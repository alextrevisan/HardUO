local name = UO.CharName
local initial = name[1]
removeAllLines()
function split(pString, pPattern)
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end
socket = require('socket') -- sempre o require
local client = socket.connect('lotz.no-ip.org',7121)
if client then
    print('Conectado')
    showMap()
else
    print('offline')
    return
end
time = 0
lines = {}
repeat
    if os.time() - time > 0.250 then
        local m = name..":"..UO.CharPosX..":"..UO.CharPosY
        if m ~= '' then
            client:send(m..'\n')
        end
        time = os.time()
        setPosition(UO.CharPosX,UO.CharPosY)
        removeAllLines()
        for id,line in pairs(lines) do
            createLine(UO.CharPosX,UO.CharPosY,line.x,line.y,id)
			print(id)
        end
    end
    client:settimeout(0.1)
    local msg,stat = client:receive()
    if msg then
        splited = split(msg,":")
        if #splited == 4 then
                local x = tonumber(splited[2])
                local y = tonumber(splited[3])
                local id = tonumber(splited[4])
                lines[id] = {}
                lines[id].x = x
                lines[id].y = y
        end
        if #splited == 2 then
                local id = tonumber(splited[2])
                lines[id] = nil
        end
    end
wait(20)
until not client