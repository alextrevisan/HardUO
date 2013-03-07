#ifndef SKILLSLIST_H
#define SKILLSLIST_H

#include <QWidget>
#include <QTimer>
#include "uo.h"

namespace Ui {
    class SkillsList;
}

class SkillsList : public QWidget
{
    Q_OBJECT

public:
    explicit SkillsList(QWidget *parent = 0);
    ~SkillsList();

private slots:
    void update();

private:
    Ui::SkillsList *ui;
    UO* uo;
    void insertItem(const QString &_skill, const QString &_value);
};

#endif // SKILLSLIST_H
