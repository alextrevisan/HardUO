#include "scriptrunner.h"
#include <QMutex>
#include <windows.h>

Log* Log::mInstance = new Log();
Map Map::mInstance;
QMutex mMutex;
int getkey(lua_State* L)
{
    if(lua_isnumber(L,1))
    {
        int value = lua_tonumber(L,1);
        lua_pushboolean(L, GetAsyncKeyState(value));
        return 1;
    }
    return 0;
}

int showMap(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1))
    {
        value = lua_tonumber(L,1);
        Map::getInstance().show(value);
    }
    return 0;
}
int hideMap(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1))
    {
        value = lua_tonumber(L,1);
        Map::getInstance().hide(value);
    }
    return 0;
}

int setPositionMap(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1)&&lua_isnumber(L,2)&&lua_isnumber(L,3))
    {
        value = lua_tonumber(L,1);
        int x = lua_tonumber(L,2);
        int y = lua_tonumber(L,3);
        Map::getInstance().setPosition(value,x,y);
    }
    return 0;
}
int createLine(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1)&&lua_isnumber(L,2)&&lua_isnumber(L,3)
            &&lua_isnumber(L,4)&&lua_isnumber(L,5)&&lua_isnumber(L,6))
    {
        value = lua_tonumber(L,1);
        int x1 = lua_tonumber(L,2);
        int y1 = lua_tonumber(L,3);
        int x2 = lua_tonumber(L,4);
        int y2 = lua_tonumber(L,5);
        int id = lua_tonumber(L,6);
        Map::getInstance().createLine(value,QLine(x1,y1,x2,y2),id);
    }
    return 0;
}
int removeLine(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1)&&lua_isnumber(L,2))
    {
        value = lua_tonumber(L,1);
        int id = lua_tonumber(L,2);
        Map::getInstance().removeLine(value,id);
    }
    return 0;
}

int removeAllLines(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1))
    {
        value = lua_tonumber(L,1);
        Map::getInstance().removeAllLines(value);
    }
    return 0;
}

int printFromLua(lua_State* L)
{
    int value = 0;
    std::string text;
    if(lua_isnumber(L,1))
        value = lua_tonumber(L,1);

    if(lua_isnoneornil(L,2))
        text = "nil";
    else
        text = lua_tostring(L,2);
    Log::getInstance()->append(value, text.data());
    Sleep(1);
    return 0;
}


ScriptRunner::ScriptRunner(int cliNr, int tabIndex, const QString& script)
    :mCliNr(cliNr)
    ,mTabIndex(tabIndex)
    ,mScript(script)
{

}

void ScriptRunner::configure()
{
    Log::getInstance()->isPaused[mTabIndex] = false;
    /* initialize Lua */
    L = luaL_newstate();
    /* load Lua base libraries */
    luaL_openlibs(L);


    ConfigureLua(L);
    lua_register(L, "__getkey__", getkey);
    lua_register(L, "__printn__", printFromLua);
    lua_register(L, "__showMap__", showMap);
    lua_register(L, "__hideMap__", hideMap);
    lua_register(L, "__setPosition__", setPositionMap);
    lua_register(L, "__createLine__", createLine);
    lua_register(L, "__removeLine__", removeLine);
    lua_register(L, "__removeAllLines__", removeAllLines);

    QString script = QString("function getkey(key) return __getkey__(key) end");
    luaL_dostring(L,script.toStdString().data());

    script = QString("function showMap() __showMap__(%1) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    script = QString("function hideMap() __hideMap__(%1) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    script = QString("function setPosition(x, y) __setPosition__(%1,x,y) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    script = QString("function createLine(x1,y1,x2,y2,id) __createLine__(%1,x1,y1,x2,y2,id) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    script = QString("function removeLine(id) __removeLine__(%1,id) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    script = QString("function removeAllLines() __removeAllLines__(%1) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    //lua_register(L, "pause", pause);

    script = QString("function print(text) __printn__(%1,text) end").arg(mTabIndex);
    luaL_dostring(L,script.toStdString().data());

    //printScript = QString("function stop() pause(%1) end").arg(mTabIndex);
    //luaL_dostring(L,printScript.toStdString().data());

    luaL_dostring(L, "debug.sethook(stop,\"Sln\")");

    //int s = luaL_dostring(L, "debug.sethook(PauseHook,\"Sln\")");

    int error = luaL_dofile(L, "macros/internal/loader.lua");

    if ( error!=0 )
    {
        emit print(mTabIndex,lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
        stop();
        emit finished();
        emit updateButtonsFinished(mTabIndex);
        return;
    }
    QString configure("hnd = Open() SetCliNr(1)");
    error = luaL_dostring(L, configure.toStdString().data());
    if ( error!=0 )
    {
        emit print(mTabIndex,lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
        stop();
        emit finished();
        emit updateButtonsFinished(mTabIndex);
        return;
    }
}
void ScriptRunner::setScript(const QString &script)
{
    mScript = script;
}

void ScriptRunner::stop()
{
    lua_close(L);
    configure();
}

void ScriptRunner::swapClient()
{
    int error = luaL_dofile(L, "macros/internal/swapclient.lua");

    if ( error!=0 )
    {
        emit print(mTabIndex,lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
        stop();
        emit finished();
        emit updateButtonsFinished(mTabIndex);
        return;
    }
}

void ScriptRunner::run()
{
    Log::getInstance()->isPaused[mTabIndex] = false;
    int s = luaL_dostring(L, mScript.toStdString().data());
    if ( s!=0 )
    {
        emit print(mTabIndex,lua_tostring(L, -1));
        lua_pop(L, 1);
        lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
        stop();
        emit finished();
        emit updateButtonsFinished(mTabIndex);
        return;
    }
    lua_gc(L, LUA_GCCOLLECT, 0); // chama o garbage collector
    stop();
    emit finished();
    emit updateButtonsFinished(mTabIndex);
}
