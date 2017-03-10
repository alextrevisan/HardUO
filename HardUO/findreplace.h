#ifndef FINDREPLACE_H
#define FINDREPLACE_H

#include <QWidget>

namespace Ui {
class FindReplace;
}

class FindReplace : public QWidget
{
    Q_OBJECT

public:
    explicit FindReplace(QWidget *parent = 0);
    ~FindReplace();

private slots:
    void on_FindButton_clicked();

    void on_ReplaceButton_clicked();

private:
    Ui::FindReplace *ui;
signals:
    void Find(const QString& findText);
    void ReplaceFind(const QString& findText, const QString& replaceText);
};

#endif // FINDREPLACE_H
