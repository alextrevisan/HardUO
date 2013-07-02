    ------------------------------------
    -- Script Name: journal.lua
    -- Author: Kal In Ex
    -- Version: 1.2
    -- Client Tested with: 7.0.15.1 (Patch 95)
    -- EUO version tested with: OpenEUO 0.91.0026
    -- Shard OSI / FS: OSI
    -- Revision Date: June 25,2011
    -- Public Release: May 19, 2010
    -- Purpose: easier journal scanning
    -- Copyright: 2010,2011 Kal In Ex
    ------------------------------------
    -- http://www.easyuo.com/forum/viewtopic.php?t=43488
     
    journal = {}
     
    journal.new = function()
            local state = {}
            local mt = {__index = journal}
            setmetatable(state,mt)
            state:clear()
            return state
    end
     
    journal.get = function(state)
            state.ref,state.lines = UO.ScanJournal(state.ref)
            state.index = 0
            for i=0,state.lines-1 do
                    local text,col = UO.GetJournal(state.lines-i-1)
                    state[i+1] = "|"..tostring(col).."|"..text.."|"
            end
    end
     
    journal.next = function(state)
            if state.index == state.lines then
                    state:get()
                    if state.index == state.lines then
                            return nil
                    end
            end
            state.index = state.index + 1
            return state[state.index]
    end
     
    journal.last = function(state)
            return state[state.index]
    end
     
    journal.find = function(state,...)
            local arg = {...}
            if type(arg[1]) == "table" then
                    arg = arg[1]
            end
            while true do
                    local text = state:next()
                    if text == nil then
                            break
                    end
                    for i=1,#arg do
                            if string.find(text,tostring(arg[i]),1,true) ~= nil then
                                    return i
                            end
                    end
            end
            return nil
    end
     
    journal.wait = function(state,TimeOUT,...)
            TimeOUT = getticks() + TimeOUT
            repeat
                    local result = state:find(...)
                    if result ~= nil then
                            return result
                    end
                    wait(1)
            until getticks() >= TimeOUT
            return nil
    end
     
    journal.clear = function(state)
            state.ref = UO.ScanJournal(0)
            state.lines = 0
            state.index = 0
    end