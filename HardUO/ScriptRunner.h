#ifndef SCRIPTRUNNER_H
#define SCRIPTRUNNER_H
#include <QThread>
#include <QTextEdit>
#include <string>
#include "uo.h"
#include "SystemKeyboardReadWrite.h"
#include <QMutex>

extern "C"
{
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

#include <luabind/luabind.hpp>

class ScriptRunner : public QThread
{
    Q_OBJECT
public:
    ScriptRunner(const QString& script, QTextEdit* log);
    ScriptRunner(QTextDocument* doc);
    ScriptRunner();
    ~ScriptRunner();
    void Pause(bool pause = true);
    void Step(bool step = true);
    bool IsPaused(){return isPaused;}
    bool InStep(){return inStep;}

    void setGlobal(std::string const& name, std::string const& value)
    {
        mGlobalVar[name] = value;
    }
    std::string getGlobal(std::string const& name)
    {
        return mGlobalVar[name];
    }
    void SetUO(UO* uo);
    void ReadLuaVariables();
    std::string getinstalldir();
protected:
     void run();
     void stop();
     //int pause();
private:
     int mLine;
     QTextDocument* mDoc;
     QString mScript;
     QTextEdit* mLog;
     void Print(const std::string& print);
     void Wait(int ms);
     void OnPause(int line);
     void PauseHook();
     bool isPaused;
     bool inStep;
     UO* mUO;
     void WaitKey(unsigned long keyCode);
     DWORD mKeyPressed;
     QMutex mMutexKey;
     lua_State *L;
     static QMap<std::string,std::string> mGlobalVar;

signals:
     void Log(const QString& log);
     void Pause(int line);
     void Started();
     void Paused();
     void Stopped();
private slots:
     void KeyPressed(byte *keysDepressed, DWORD keyPressed);
};

#endif // SCRIPTRUNNER_H
