#include "ScriptRunner.h"
#include <QDebug>
#include <windows.h>
#include <QTextBlock>

QMap<std::string,std::string> ScriptRunner::mGlobalVar;

ScriptRunner::ScriptRunner(const QString& script, QTextEdit* log)
    :mScript(script)
    ,mLog(log)
    ,inStep(false)
{
    connect(SystemKeyboardReadWrite::instance(),SIGNAL(keyPressed(byte*,DWORD)),this,SLOT(KeyPressed(byte*,DWORD)));
    SystemKeyboardReadWrite::instance()->setConnected(true);
}
ScriptRunner::ScriptRunner(QTextDocument *doc)
    :mDoc(doc)
    ,mScript(doc->toPlainText())
    ,isPaused(false)
{
    connect(SystemKeyboardReadWrite::instance(),SIGNAL(keyPressed(byte*,DWORD)),this,SLOT(KeyPressed(byte*,DWORD)));
    SystemKeyboardReadWrite::instance()->setConnected(true);

}

ScriptRunner::ScriptRunner()
{
    connect(SystemKeyboardReadWrite::instance(),SIGNAL(keyPressed(byte*,DWORD)),this,SLOT(KeyPressed(byte*,DWORD)));
    SystemKeyboardReadWrite::instance()->setConnected(true);
}

ScriptRunner::~ScriptRunner()
{
    disconnect(SystemKeyboardReadWrite::instance(),SIGNAL(keyPressed(byte*,DWORD)),this,SLOT(KeyPressed(byte*,DWORD)));
    SystemKeyboardReadWrite::instance()->setConnected(false);
}
void ScriptRunner::Pause(bool pause)
{
    isPaused = pause;
    if(!isPaused)
        emit Pause(0);
}

void ScriptRunner::Step(bool step)
{
    inStep = step;
}
void ScriptRunner::Print(const std::string &print)
{
    emit Log(QString(print.data()));

}
void ScriptRunner::Wait(int ms)
{
    Sleep(ms);
}

void ScriptRunner::PauseHook()
{
    if(isPaused)
    {
        lua_Debug ar;
        lua_getstack(L, 2, &ar);
        if(lua_getinfo(L, "nSl", &ar)>0)
        {
            emit Pause(ar.currentline -1);
            while(isPaused)
            {
                Wait(10);
            }
        }
    }
    if(inStep)
    {
        isPaused=true;
    }
}

void ScriptRunner::KeyPressed(byte *keysDepressed, DWORD keyPressed)
{
    mMutexKey.lock();
    mKeyPressed = keyPressed;
    mMutexKey.unlock();
}

void ScriptRunner::WaitKey(unsigned long keyCode)
{
    mMutexKey.lock();
    while(mKeyPressed!=keyCode)
    {
        mMutexKey.unlock();
        Wait(1);
        mMutexKey.lock();
    }
    mMutexKey.unlock();
    mKeyPressed = 0;
}



void ScriptRunner::run()
{
    try
    {
        emit Started();
        L = luaL_newstate();
        mUO->SetLuaState(L);
        luaL_openlibs(L);
        using namespace luabind;

        open(L);


        module(L)
        [
            class_<ScriptRunner>("ScriptRunner")
                .def(constructor<const QString& , QTextEdit* >())
                .def("Print", &ScriptRunner::Print)
                .def("Wait", &ScriptRunner::Wait)
                .def("WaitKey", &ScriptRunner::WaitKey)
                .def("PauseHook", &ScriptRunner::PauseHook)
                .def("setGlobal", &ScriptRunner::setGlobal)
                .def("getGlobal", &ScriptRunner::getGlobal)
        ];

        luabind::globals(L)["ScriptRunner"] = this;

        ///fake dos metodos
        luaL_dostring(L, "function print(a) ScriptRunner:Print(a) end");
        luaL_dostring(L, "function wait(a) ScriptRunner:Wait(a) end");
        luaL_dostring(L, "function WaitKey(a) ScriptRunner:WaitKey(a) end");
        luaL_dostring(L, "function PauseHook() ScriptRunner:PauseHook() end");
        luaL_dostring(L, "function setGlobal(a,b) ScriptRunner:setGlobal(a,b) end");
        luaL_dostring(L, "function getGlobal(a) return ScriptRunner:getGlobal(a) end");

        module(L)
        [
            class_<Item>("Item")
                .def(constructor<>())
                .def_readonly("id", &Item::id)
                .def_readonly("type", &Item::type)
                .def_readonly("kind", &Item::kind)
                .def_readonly("contId", &Item::contId)
                .def_readonly("x", &Item::x)
                .def_readonly("y", &Item::y)
                .def_readonly("z", &Item::z)
                .def_readonly("stack", &Item::stack)
                .def_readonly("rep", &Item::rep)
                .def_readonly("color", &Item::color)
        ];

        module(L)
        [
            class_<Property>("Property")
                .def(constructor<>())
                .def_readonly("name", &Property::name)
                .def_readonly("info", &Property::info)
        ];

        module(L)
        [
            class_<Skill>("Skill")
                .def(constructor<>())
                .def_readonly("norm", &Skill::norm)
                .def_readonly("real", &Skill::real)
                .def_readonly("cap", &Skill::cap)
                .def_readonly("lock", &Skill::lock)
        ];

        module(L)
        [
            class_<UO>("UO")
                .def(constructor<>())
                .def("Ar", &UO::Ar)
                .def("BackpackID", &UO::BackpackID)
                .def("CharName", &UO::CharName)
                .def("Hits", &UO::Hits)
                .def("MaxHits", &UO::MaxHits)
                .def("Mana", &UO::Mana)
                .def("MaxMana", &UO::MaxMana)
                .def("Stam", &UO::Stam)
                .def("MaxStam", &UO::MaxStam)
                .def("Gold", &UO::Gold)
                .def("Sex", &UO::Sex)
                .def("CharPosX", &UO::CharPosX)
                .def("CharPosY", &UO::CharPosY)
                .def("CharPosZ", &UO::CharPosZ)
                .def("MaxWeight", &UO::MaxWeight)
                .def("Weight", &UO::Weight)
                .def("EventMacro", &UO::EventMacro)
                .def("GetSkill", &UO::GetSkill)
                .def("useLastSkill", &UO::useLastSkill)
                .def("useAnatomy", &UO::useAnatomy)
                .def("useAnimalLore", &UO::useAnimalLore)
                .def("useItemIdentification", &UO::useItemIdentification)
                .def("useArmsLore", &UO::useArmsLore)
                .def("useBegging", &UO::useBegging)
                .def("usePeacemaking", &UO::usePeacemaking)
                .def("useCartography", &UO::useCartography)
                .def("useDetectingHidden", &UO::useDetectingHidden)
                .def("useDiscordance", &UO::useDiscordance)
                .def("useEvaluatingIntelligence", &UO::useEvaluatingIntelligence)
                .def("useForensicEvaluation", &UO::useForensicEvaluation)
                .def("useHidding", &UO::useHidding)
                .def("usePoisoning", &UO::usePoisoning)
                .def("useSpiritSpeak", &UO::useSpiritSpeak)
                .def("useStealing", &UO::useStealing)
                .def("useTasteIdentification", &UO::useTasteIdentification)
                .def("useTracking", &UO::useTracking)
                .def("useMeditation", &UO::useMeditation)
                .def("useStealth", &UO::useStealth)
                .def("useRemoveTrap", &UO::useRemoveTrap)
                .def("castMagery", &UO::castMagery)
                .def("Speak", &UO::Speak)
                .def("Move", &UO::Move)
                .def("Emote", &UO::Emote)
                .def("SystemMessage", &UO::SystemMessage)
                .def("WarPeace", &UO::WarPeace)
                .def("Paste", &UO::Paste)
                .def("OpenDoor", &UO::OpenDoor)
                .def("WaitTarget", &UO::WaitTarget)
                .def("LastTarget", &UO::LastTarget)
                .def("TargCurs", &UO::TargCurs)
                .def("setTargCurs", &UO::setTargCurs)
                .def("TargetSelf", &UO::TargetSelf)
                .def("getLastTargetID", &UO::getLastTargetID)
                .def("setLastTargetID", &UO::setLastTargetID)                
                .def("ClearJournal", &UO::ClearJournal)
                .def("ScanJournal", &UO::ScanJournal)
                .def("FindJournal", &UO::FindJournal)
                .def("LastJournalIndex", &UO::LastJournalIndex)
                .def("SetJournalIndex", &UO::SetJournalIndex)
                .def("ScanItems", &UO::ScanItems)
                .def("GetItem", &UO::GetItem)
                .def("FindItem", &UO::FindItem)
                .def("Property", &UO::GetProperty)
                .def("setLObjectID", &UO::setLObjectID)
                .def("LTargetX", &UO::LTargetX)
                .def("LTargetY", &UO::LTargetY)
                .def("LTargetZ", &UO::LTargetZ)
                .def("setLTargetX", &UO::setLTargetX)
                .def("setLTargetY", &UO::setLTargetY)
                .def("setLTargetZ", &UO::setLTargetZ)
                .def("LTargetKind", &UO::LTargetKind)
                .def("LLiftedType", &UO::LLiftedType)
                .def("setContPos", &UO::setContPos)
                .def("setLTargetKind", &UO::setLTargetKind)
                .def("CliDrag", &UO::CliDrag)
                .def("Drag", (void(UO::*)(int,int)) &UO::Drag)
                .def("Drag", (void(UO::*)(int)) &UO::Drag)
                .def("DropC", (void(UO::*)(int,int,int)) &UO::DropC)
                .def("DropC", (void(UO::*)(int)) &UO::DropC)
                .def("DropG", (void(UO::*)(int,int,int))&UO::DropG)
                .def("DropG", (void(UO::*)(int,int))&UO::DropG)
                .def("DropPD", &UO::DropPD)
                .def("Click", &UO::Click)
        ];

        luabind::globals(L)["UOInstance"] = mUO;
        luaL_dofile(L, "macros/internal/loader.lua");

        //int s = luaL_dostring(L, lines.toStdString().data());


        //lua_sethook(L, &PauseHook), LUA_MASKLINE, 0);
        int s = luaL_dostring(L, "debug.sethook(PauseHook,\"Sln\")");
        s = luaL_dostring(L, mDoc->toPlainText().toStdString().data());

        if ( s!=0 )
        {
            Print(lua_tostring(L, -1));
            lua_pop(L, 1); // remove error message
        }
        lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
        lua_close(L);
        emit Stopped();
    }
    catch(const std::exception &TheError)
    {
        qDebug()<<QString(TheError.what());
    }
    catch(...)
    {
        qDebug()<<QString("erroooss o0");
    }
}
void ScriptRunner::SetUO(UO *uo)
{
    mUO = uo;
}
