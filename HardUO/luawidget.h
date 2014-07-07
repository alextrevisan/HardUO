#ifndef LUAWIDGET_H
#define LUAWIDGET_H

#include <QWidget>
#include <QDebug>

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"

}


class TForm: public QWidget
{
    Q_OBJECT
public:
    TForm(QWidget* parent, lua_State* L, int id)
        :QWidget(parent),mL(L),ID(id)
    {
        eventOnClose = false;
    }
    void setCaption(const QString& capt)
    {
        caption = capt;
        this->setWindowTitle(capt);
    }

    bool eventOnClose;
    QString caption;
    int ID;
protected:
    void closeEvent ( QCloseEvent * event )
    {
        //QString script = "Obj.OnClose('"+this->windowTitle()+"')";
        //luaL_dostring(mL,script.toStdString().data());
        //qDebug()<<script;
        eventOnClose = true;
    }
    lua_State* mL;
};

#endif // LUAWIDGET_H
