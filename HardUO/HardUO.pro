#-------------------------------------------------
#
# Project created by QtCreator 2013-07-08T19:47:05
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = HardUO
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    codearea.cpp \
    customhighlighter.cpp \
    uo.cpp \
    scriptrunner.cpp \
    UOTreeView.cpp \
    mapwindow.cpp \
    about.cpp \
    luawidget.cpp \
    findreplace.cpp

HEADERS  += mainwindow.h \
    codearea.h \
    customhighlighter.h \
    uo.h \
    gamedll.h \
    scriptrunner.h \
    UOTreeView.h \
    mapwindow.h \
    about.h \
    luawidget.h \
    findreplace.h

FORMS    += mainwindow.ui \
    mapwindow.ui \
    about.ui \
    findreplace.ui


RESOURCES += \
    icons.qrc \
    resource.qrc

INCLUDEPATH += ../Dependencies/Lua_5_2/include

LIBS += -L$$PWD/../Dependencies/Lua_5_2/lib/ -llua

OTHER_FILES += \
    icone.rc

RC_FILE = icone.rc

CONFIG+=c++11


