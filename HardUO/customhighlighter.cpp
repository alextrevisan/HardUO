#include "customhighlighter.h"

MyCustomHighlighter::MyCustomHighlighter(QTextDocument *parent) :
    QSyntaxHighlighter(parent)
{
    HighlightingRule rule;

    keywordFormat.setForeground(Qt::darkBlue);
    keywordFormat.setFontWeight(QFont::Bold);
    QStringList keywordPatterns;
    keywordPatterns << "\\bfor\\b"<<"\\bthen\\b"<<"\\bif\\b"<<"\\belse\\b"<<"\\bend\\b"<<"\\bdo\\b"
                    <<"\\bwhile\\b"<<"\\btrue\\b"<<"\\bfalse\\b"<<"\\bfunction\\b"<<"\\blocal\\b"<<"\\band\\b";
    foreach (const QString &pattern, keywordPatterns)
    {
        rule.pattern = QRegExp(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }

    classFormat.setFontWeight(QFont::Bold);
    classFormat.setForeground(Qt::darkMagenta);
    rule.pattern = QRegExp("\\bKEY_[A-Za-z0-9]+\\b");
    rule.format = classFormat;
    highlightingRules.append(rule);



    multiLineCommentFormat.setForeground(Qt::gray);

    quotationFormat.setForeground(Qt::darkGreen);
    rule.pattern = QRegExp("\".*\"");
    rule.format = quotationFormat;
    highlightingRules.append(rule);

    functionFormat.setFontItalic(true);
    functionFormat.setForeground(Qt::blue);
    rule.pattern = QRegExp("\\b[A-Za-z0-9_]+(?=\\()");
    rule.format = functionFormat;
    highlightingRules.append(rule);

    commentStartExpression = QRegExp("--\\[\\[");
    commentEndExpression = QRegExp("\\]{2}");

    singleLineCommentFormat.setForeground(Qt::gray);
    rule.pattern = QRegExp("(-{2})+.*");
    rule.format = singleLineCommentFormat;
    highlightingRules.append(rule);
}
void MyCustomHighlighter::highlightBlock(const QString &text)
 {
     foreach (const HighlightingRule &rule, highlightingRules) {
         QRegExp expression(rule.pattern);
         int index = expression.indexIn(text);
         while (index >= 0) {
             int length = expression.matchedLength();
             setFormat(index, length, rule.format);
             index = expression.indexIn(text, index + length);
         }
     }
     setCurrentBlockState(0);

     int startIndex = 0;
     if (previousBlockState() != 1)
         startIndex = commentStartExpression.indexIn(text);

     while (startIndex >= 0) {
         int endIndex = commentEndExpression.indexIn(text, startIndex);
         int commentLength;
         if (endIndex == -1) {
             setCurrentBlockState(1);
             commentLength = text.length() - startIndex;
         } else {
             commentLength = endIndex - startIndex
                             + commentEndExpression.matchedLength();
         }
         setFormat(startIndex, commentLength, multiLineCommentFormat);
         startIndex = commentStartExpression.indexIn(text, startIndex + commentLength);
     }
 }
