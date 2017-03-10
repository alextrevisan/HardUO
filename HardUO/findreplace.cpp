#include "findreplace.h"
#include "ui_findreplace.h"

FindReplace::FindReplace(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::FindReplace)
{
    ui->setupUi(this);
    setWindowFlags(Qt::Tool);
    //setWindowFlags( (windowFlags() | Qt::CustomizeWindowHint) & ~Qt::WindowMaximizeButtonHint & ~Qt::WindowMinimizeButtonHint);
    //setFocus();
}

FindReplace::~FindReplace()
{
    delete ui;
}

void FindReplace::on_FindButton_clicked()
{
    emit Find(ui->FindEdit->text());
}

void FindReplace::on_ReplaceButton_clicked()
{
     emit ReplaceFind(ui->FindEdit->text(),ui->ReplaceEdit->text());
}
