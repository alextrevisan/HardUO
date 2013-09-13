#include "gamedll.h"
#include "uo.h"
#include <string>
#include <windows.h>

int UOdllStarted = 0;

int settop(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    SetTop(hnd,value);
    return 0;
}
int pushinteger(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isstring(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    PushInteger(hnd,value);
    return 0;
}
int pushstrval(lua_State *L)
{
    int hnd = 0;
    std::string value;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isstring(L,2))
            value = lua_tostring(L,2);
        else
            return 0;
    }
    PushStrVal(hnd,(char*)value.data());
    return 0;
}
int pushboolean(lua_State *L)
{
    int hnd = 0;
    bool value = false;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isboolean(L,2))
            value = lua_toboolean(L,2);
        else
            return 0;
    }
    PushBoolean(hnd,value);
    return 0;
}

int pushdouble(lua_State *L)
{
    int hnd = 0;
    double value = false;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    PushDouble(hnd,value);
    return 0;
}

int pushnil(lua_State *L)
{
    int hnd = 0;
    int n = lua_gettop(L);
    if(n == 1)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
    }
    PushNil(hnd);
    return 0;
}

int pushstrref(lua_State *L)
{
    int hnd = 0;
    int n = lua_gettop(L);
    std::string value;
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isstring(L,1))
            value = lua_tostring(L,2);
        else
            return 0;
    }

    PushStrRef(hnd,(char*)value.data());
    return 0;
}

int pushvalue(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);

    if(n == 1)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,1))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    PushValue(hnd,value);
    return 0;
}


int execute(lua_State *L)
{
    int hnd = 0;
    int n = lua_gettop(L);
    if(n == 1)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
    }
    Execute(hnd);
    return 0;
}
int getstring(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }

    lua_pushstring(L, GetString(hnd,value));

    return 1;
}

int getinteger(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    int rvalue = GetInteger(hnd,value);
    lua_pushinteger(L, rvalue);

    return 1;
}
int getboolean(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    bool rvalue = GetBoolean(hnd,value);
    lua_pushboolean(L, rvalue);

    return 1;
}
int query(lua_State *L)
{
    int hnd = 0;
    int n = lua_gettop(L);
    if(n == 1)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
    }
    int rvalue = Query(hnd);
    lua_pushinteger(L, rvalue);

    return 1;
}
int remove(lua_State *L)
{
    int hnd = 0;
    int value = 0;
    int n = lua_gettop(L);
    if(n == 2)
    {
        if(lua_isnumber(L,1))
            hnd = lua_tonumber(L,1);
        else
            return 0;
        if(lua_isnumber(L,2))
            value = lua_tonumber(L,2);
        else
            return 0;
    }
    Remove(hnd,value);
    return 0;
}
int version(lua_State *L)
{
    int rvalue = Version();
    lua_pushinteger(L, rvalue);
    return 0;
}

int open(lua_State *L)
{
    int hnd = Open();
    lua_pushinteger(L, hnd);
    return 1;
}

int wait(lua_State* L)
{
    int value = 0;
    if(lua_isnumber(L,1))
        value = lua_tonumber(L,1);
    Sleep(value);
    return 0;
}

void ConfigureLua(lua_State* L)
{
    if(UOdllStarted == 0)
    {
        UOdllStarted = InitWrapper();
        if(!UOdllStarted)
        {
            exit(666);
        }
    }
    /* register our function */
    lua_register(L, "SetTop", settop);
    lua_register(L, "PushStrVal", pushstrval);
    lua_register(L, "PushInteger", pushinteger);
    lua_register(L, "Execute", execute);
    lua_register(L, "GetString", getstring);
    lua_register(L, "GetInteger", getinteger);
    lua_register(L, "GetBoolean", getboolean);
    lua_register(L, "Open", open);
    lua_register(L, "PushBoolean", pushboolean);
    lua_register(L, "PushDouble", pushdouble);
    lua_register(L, "PushStrRef", pushstrref);
    lua_register(L, "PushValue", pushvalue);
    lua_register(L, "Query", query);
    lua_register(L, "Remove", remove);
    lua_register(L, "Version", version);
    lua_register(L, "wait", wait);
}

