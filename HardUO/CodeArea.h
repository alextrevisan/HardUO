#ifndef CODEAREA_H
#define CODEAREA_H

#include <QPlainTextEdit>
#include <QCompleter>
#include "customhighlighter.h"
#include <QCompleter>

class CodeArea : public QPlainTextEdit
{
    Q_OBJECT
public:
    CodeArea(QWidget* parent);
    void lineNumberAreaPaintEvent(QPaintEvent *event);
    int lineNumberAreaWidth();
private:
    MyCustomHighlighter highlighter;
    QWidget *lineNumberArea;
    QCompleter *mCompleter;
    QStringList mWordList;
    QString textUnderCursor() const;
protected:
    void resizeEvent(QResizeEvent *event);
    void keyPressEvent(QKeyEvent *e);

private slots:
    void updateLineNumberAreaWidth(int newBlockCount);
    void highlightCurrentLine();
    void updateLineNumberArea(const QRect &, int);
    void insertCompletion(const QString &completion);
    void onTextChange();
};


class LineNumberArea : public QWidget
{
public:
    LineNumberArea (CodeArea *editor) : QWidget (editor) {
        codeEditor = editor;
    }

    QSize sizeHint () const {
        return QSize (codeEditor->lineNumberAreaWidth (), 0);
    }

protected:
    void paintEvent (QPaintEvent *event) {
        codeEditor->lineNumberAreaPaintEvent (event);
    }

private:
    CodeArea *codeEditor;
};

#endif // CODEAREA_H
