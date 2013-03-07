-- Bitwise XOR - thanks to Reuben Thomas and BitUtils http://lua-users.org/wiki/BitUtils
function bxor(a,b)
        local floor = math.floor
        local r = 0
       
        for i = 0, 31 do
                local x = a / 2 + b / 2
                if x ~= floor (x) then
                        r = r + 2^i
                end
                a = floor (a / 2)
                b = floor (b / 2)
        end
        return r
end

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
-- From EUO to DEC
function euo2dec(euoid)
        euoid = string.upper(euoid)
        local i, j, decid = 1, 0, 0
        for j = 1, #euoid do
                local char = euoid:sub(j,j)
                decid = decid + ( string.byte(char) - string.byte('A') ) * i
                --print(decid)
                i = i * 26
        end
        decid = bxor((decid - 7), 69)
        return decid
end
-- From DEC to EUO
function dec2euo (decid)
        local euoid = ""
        local i = (bxor(decid, 69) + 7)
        local j = 0
       
        while (i > 0) do
                euoid = euoid .. string.char((i % 26) + string.byte('A'))
                i = math.floor(i / 26)
        end
        return euoid
end
function typeConverter(string)
    local stringTable = split(string, "_")
    local itemTable = {}
    for i=1, #stringTable do
        local itemid = euo2dec(stringTable[i])
        itemTable[i] = itemid
    end
    return itemTable
end






