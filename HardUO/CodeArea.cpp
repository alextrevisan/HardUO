#include "codearea.h"
#include "customhighlighter.h"
#include "scriptrunner.h"
#include <QPainter>
#include <QStringListModel>
#include <QScrollBar>

CodeArea::CodeArea(QWidget *parent)
    :QPlainTextEdit(parent)
    ,highlighter(this->document())
{
    QFont font;
    font.setFamily("Courier");
    font.setFixedPitch(true);
    font.setPointSize(10);
    font.insertSubstitution("	","    ");
    setFont(font);
    setWordWrapMode(QTextOption::NoWrap);

    lineNumberArea = new LineNumberArea(this);
    connect(this, SIGNAL(blockCountChanged(int)), this, SLOT(updateLineNumberAreaWidth(int)));
    connect(this, SIGNAL(updateRequest(QRect,int)), this, SLOT(updateLineNumberArea(QRect,int)));
    connect(this, SIGNAL(cursorPositionChanged()), this, SLOT(highlightCurrentLine()));

    updateLineNumberAreaWidth(0);
    highlightCurrentLine();
    mCompleter = new QCompleter(this);
    mCompleter->setModel(new QStringListModel(mWordList, mCompleter));
    mCompleter->setModelSorting(QCompleter::CaseSensitivelySortedModel);
    mCompleter->setCaseSensitivity(Qt::CaseSensitive);
    mCompleter->setWrapAround(false);

    mCompleter->setWidget(this);
    mCompleter->setCompletionMode(QCompleter::PopupCompletion);
    mCompleter->setCaseSensitivity(Qt::CaseInsensitive);
    QObject::connect(mCompleter, SIGNAL(activated(QString)),
                  this, SLOT(insertCompletion(QString)));

    connect(this,SIGNAL(textChanged()), this, SLOT(onTextChange()));
}
int CodeArea::lineNumberAreaWidth()
{
    int digits = 1;
    int max = qMax(1, blockCount());
    while (max >= 10) {
        max /= 10;
        ++digits;
    }

    int space = 3 + fontMetrics().width(QLatin1Char('9')) * digits;

    return space;
}
void CodeArea::updateLineNumberAreaWidth(int /* newBlockCount */)
{
    setViewportMargins(lineNumberAreaWidth(), 0, 0, 0);
}
void CodeArea::updateLineNumberArea(const QRect &rect, int dy)
{
    if (dy)
        lineNumberArea->scroll(0, dy);
    else
        lineNumberArea->update(0, rect.y(), lineNumberArea->width(), rect.height());

    if (rect.contains(viewport()->rect()))
        updateLineNumberAreaWidth(0);
}
void CodeArea::resizeEvent(QResizeEvent *e)
{
    QPlainTextEdit::resizeEvent(e);

    QRect cr = contentsRect();
    lineNumberArea->setGeometry(QRect(cr.left(), cr.top(), lineNumberAreaWidth(), cr.height()));
}

void CodeArea::keyPressEvent(QKeyEvent *e)
{

    if (mCompleter && mCompleter->popup()->isVisible())
    {
             // The following keys are forwarded by the completer to the widget
            switch (e->key())
            {
                case Qt::Key_Enter:
                case Qt::Key_Return:
                case Qt::Key_Escape:
                case Qt::Key_Tab:
                case Qt::Key_Backtab:
                     e->ignore();
                     return; // let the completer do default behavior
                default:
                    break;
            }
    }

    {
       switch (e->key()) {
       case Qt::Key_Tab:
       {
           QTextCursor tc = textCursor();
           if(tc.hasSelection())
           {

           }
           if(!(e->modifiers() & (Qt::ShiftModifier | Qt::ControlModifier)))
           {
               this->insertPlainText("    ");
               QTextCursor tc = textCursor();
               tc.setPosition(tc.position());
               setTextCursor(tc);
               return;
           }

       }
       case Qt::Key_Backtab:
       {
           QTextCursor tc = textCursor();

           QTextBlock tb = tc.block();
           QString str = tb.text();
           int space = 4;
           tc.movePosition(QTextCursor::StartOfLine);
           foreach(QString s, str)
           {
               if(s == " "&& space!=0)
               {
                   space--;
                   tc.movePosition(QTextCursor::Right);
                   tc.deletePreviousChar();

               }
               else
                   break;
           }
           return;
       }
       case Qt::Key_Return:
       {
           QTextCursor tc = textCursor();
           QTextBlock tb = tc.block();
           QString str = tb.text();
           int space = 0;
           foreach(QString s, str)
           {
               if(s == " ")
                   space++;
               else
                   break;
           }
           insertPlainText("\n");
           for(int x= 0; x <space;++x)
               insertPlainText(" ");
           tc.movePosition(QTextCursor::EndOfLine);
           setTextCursor(tc);
           e->accept();
           return;
       }
       default:
           break;
       }
    }

    bool isShortcut = ((e->modifiers() & Qt::ControlModifier) && e->key() == Qt::Key_Space); // CTRL+E
    if (!mCompleter || !isShortcut) // do not process the shortcut when we have a completer
        QPlainTextEdit::keyPressEvent(e);

    const bool ctrlOrShift = e->modifiers() & (Qt::ControlModifier | Qt::ShiftModifier);
    if (!mCompleter || (ctrlOrShift && e->text().isEmpty()))
        return;

    static QString eow("~!@#$%^&*_+(){}|\"<>?,:./;'[]\\-="); // end of word
    bool hasModifier = (e->modifiers() != Qt::NoModifier) && !ctrlOrShift;
    QString completionPrefix = textUnderCursor();
    /*if(completionPrefix.endsWith(")"))
    {
        completionPrefix.remove(completionPrefix.size()-1);
    }*/

    if (!isShortcut && (hasModifier || e->text().isEmpty()|| completionPrefix.length() < 3
                      || eow.contains(e->text().right(1)))) {
        mCompleter->popup()->hide();
        return;
    }

    if (completionPrefix != mCompleter->completionPrefix()) {
        mCompleter->setCompletionPrefix(completionPrefix);
        mCompleter->popup()->setCurrentIndex(mCompleter->completionModel()->index(0, 0));
    }
    QRect cr = cursorRect();
    cr.setWidth(mCompleter->popup()->sizeHintForColumn(0)
                + mCompleter->popup()->verticalScrollBar()->sizeHint().width());
    mCompleter->complete(cr); // popup it up!
}
QString CodeArea::textUnderCursor() const
{
    QTextCursor tc = textCursor();
    tc.select(QTextCursor::WordUnderCursor);

    return tc.selectedText();
}
void CodeArea::insertCompletion(const QString& completion)
{
    /*if (c->widget() != this)
        return;*/
    QTextCursor tc = textCursor();
    //int extra = completion.length() - mCompleter->completionPrefix().length();
    tc.select(QTextCursor::WordUnderCursor);
    tc.removeSelectedText();
    tc.insertText(completion);
    tc.movePosition(QTextCursor::Left);
    tc.movePosition(QTextCursor::EndOfWord);
    setTextCursor(tc);
}

void CodeArea::onTextChange()
 {
     QStringList lineList = toPlainText().split("\n");
     QString cleanData;
     foreach (QString str, lineList)
     {
         if(!str.startsWith("--"))
         {
             cleanData+=str+" ";
         }
     }
     QRegExp ex("(\\s|\\(|\\)|\\=|,|\\[|\\]|\\{|\\}|\\.|-)");
     QStringList wordList = cleanData.split(ex);
     wordList.removeAll("");
     /*foreach(QString word, wordList)
     {
         //if(word.size()>1)
            qDebug()<<word;
     }*/
     wordList.removeAll(textUnderCursor());
     wordList.append(mWordList);
     wordList.append( AutoComplete::autoCompleteList.toSet().toList());
     wordList.append( AutoComplete::autoCompleteUOList.toSet().toList());
     wordList.sort();

     if(mCompleter)
        mCompleter->setModel(new QStringListModel(wordList.toSet().toList(), mCompleter));
 }

void CodeArea::highlightCurrentLine()
{
    QList<QTextEdit::ExtraSelection> extraSelections;

    if (!isReadOnly()) {
        QTextEdit::ExtraSelection selection;

        QColor lineColor = QColor(Qt::blue).lighter(190);

        selection.format.setBackground(lineColor);
        selection.format.setProperty(QTextFormat::FullWidthSelection, true);
        selection.cursor = textCursor();
        selection.cursor.clearSelection();
        extraSelections.append(selection);
    }

    setExtraSelections(extraSelections);
}
void CodeArea::lineNumberAreaPaintEvent(QPaintEvent *event)
{
    QPainter painter(lineNumberArea);
    painter.fillRect(event->rect(), QColor(Qt::lightGray).lighter(122));

    QTextBlock block = firstVisibleBlock();
    int blockNumber = block.blockNumber();
    int top = (int) blockBoundingGeometry(block).translated(contentOffset()).top();
    int bottom = top + (int) blockBoundingRect(block).height();

    while (block.isValid() && top <= event->rect().bottom()) {
        if (block.isVisible() && bottom >= event->rect().top()) {
            QString number = QString::number(blockNumber + 1);
            painter.setPen(Qt::gray);
            painter.drawText(0, top, lineNumberArea->width(), fontMetrics().height(),
                             Qt::AlignRight, number);
        }

        block = block.next();
        top = bottom;
        bottom = top + (int) blockBoundingRect(block).height();
        ++blockNumber;
    }
}
