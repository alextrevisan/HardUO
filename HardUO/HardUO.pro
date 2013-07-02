#-------------------------------------------------
#
# Project created by QtCreator 2011-06-27T13:30:01
#
#-------------------------------------------------

QT       += core gui

TARGET = HardUO
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    CodeArea.cpp \
    customhighlighter.cpp \
    ScriptRunner.cpp \
    TabWindow.cpp \
    UOTreeView.cpp \
    UO.cpp \
    ScopedLock.cpp \
    SystemKeyboardReadWrite.cpp \
    skillslist.cpp \
    about.cpp

HEADERS  += mainwindow.h \
    CodeArea.h \
    customhighlighter.h \
    ScriptRunner.h \
    TabWindow.h \
    UOdll.h \
    uo.h \
    UOTreeView.h \
    ScopedLock.h \
    SystemKeyboardReadWrite.h \
    skillslist.h \
    about.h

FORMS    += mainwindow.ui \
    skillslist.ui \
    about.ui

RESOURCES += \
    resource.qrc

INCLUDEPATH += ../Dependencies/Lua_5_2/include \
               ../Dependencies/luabind/include \
               ../Dependencies/boost_1_53_0

LIBS += ../Dependencies/luabind/libluabind.a \
        ../Dependencies/Lua_5_2/lib/liblua52.a

OTHER_FILES += \
    icone.rc

RC_FILE = icone.rc

#QMAKE_CXXFLAGS += -std=c++11
