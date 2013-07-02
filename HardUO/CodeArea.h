#ifndef CODEAREA_H
#define CODEAREA_H

#include <QPlainTextEdit>
#include <QCompleter>
#include "customhighlighter.h"

class CodeArea : public QPlainTextEdit
{
    Q_OBJECT
public:
    CodeArea(QWidget *parent = 0);
    void setCompleter(QCompleter *mCompleter);
    QCompleter *completer() const;
    void lineNumberAreaPaintEvent (QPaintEvent *event);
    int lineNumberAreaWidth();
    void SetPause(int line);
protected:
    void keyPressEvent(QKeyEvent *e);
    void focusInEvent(QFocusEvent *e);
    void resizeEvent(QResizeEvent *event);

private slots:
    void insertCompletion(const QString &completion);

    void updateLineNumberAreaWidth ( int newBlockCount);
    void highlightCurrentLine ();
    void updateLineNumberArea(const QRect &, int);
    void onTextChange();

private:
    QString textUnderCursor() const;
    QCompleter *mCompleter;
    QWidget *lineNumberArea;
    int mPauseLine;
    static QStringList mWordList;
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
