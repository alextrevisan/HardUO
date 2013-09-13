#ifndef UO_H
#define UO_H

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"

}

void ConfigureLua(lua_State* L);

#endif // UO_H
