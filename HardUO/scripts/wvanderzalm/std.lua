------------------------------------
-- Script Name: Standard Library 
-- Author: Wesley Vanderzalm
-- Version: 1.0.0 --Unchanged
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestShard
-- Revision Date: 
-- Public Release: TBA --if ever, this is file is very organic
-- Purpose:  
-- Copyright: 2011 Wesley Vanderzalm
------------------------------------
if STDINIT then return true end
print("std.lua init")
STDINIT = true   
                                                
dofile(getinstalldir().."scripts/wvanderzalm/MulHandles.lua")
dofile(getinstalldir().."Scripts/wvanderzalm/Tile.lua") 
dofile(getinstalldir().."Scripts/wvanderzalm/LineOfSight.lua")  
dofile(getinstalldir().."Scripts/wvanderzalm/Class.lua")  
                         
DynamicsRefresh()   
Layers={    
[0]='_______',
[1]='LeftHand',
[2]='RightHand',
[3]='Shoes',
[4]='Pants',
[5]='Shirt',
[6]='Hat',
[7]='Gloves',
[8]='Ring',
[9]='_Nil_',
[10]='Neck',
[11]='Hair',
[12]='Waist',
[13]='Torso',
[14]='Bracelet',
[15]='MonGen',
[16]='Beard',
[17]='Sash',
[18]='Ears',
[19]='Arms',
[20]='Back',
[21]='Backpack',
[22]='Robe',
[23]='Skirt',
[24]='Leggings',
[25]='Mount',
[26]='Vendor_Buy',
[27]='Vendor_Restock',
[28]='Vendor_Sell',
[29]='Bank',
}

Layer25={   
  --[]=??? --Didnt register
  [16016]=276,--11669 --"Chimera"/Raptalon Ethereal/NonEthy
  [16017]=277,--11670 --CuShindhe Ethereal/NonEthy
  [16018]=793,--11676 --"Charge of the fallen" Ethereal/NonEthy
  [16019]="?19", --Didnt register
  [16020]=243,--10090 --Hiryu
  [16021]="?21", --Didnt register (But i look like im riding)   
  [16022]="?22", --Didnt register
  [16023]=195,--9743 --Giant Beetle Ethereal
  [16024]=194,--9753 --Swamp Dragon Ethereal
  [16025]="?25", --Didnt register
  [16026]=193,--9749 --Ridge Back Ethereal
  [16027]=192,--9678 --Unicorn Ethereal
  [16028]=191,--9632 --Kirin Ethereal
  [16029]="?29", --??Ethereal Horse??
  [16030]=190, --Fire Steed
  [16031]=200, --Horse Dappled Brown
  [16032]=226, --Horse Dappled Grey
  [16033]=228, --Horse Tan
  [16034]=204, --Horse Dark Brown
  [16035]=210, --Desert Ostard
  [16036]=219, --Frenzied Ostard
  [16037]=218, -- Forest Ostard
  [16038]=220, --Ridable Llama
  [16039]="?39", --[177 or 178 or 114 or 116??] --(NonPure Mare)   
  [16040]=117, --Silver Steed
  [16041]=178, --Nightmare3 (used "get body")   
  [16042]=226,--8413 --Horse Ethereal
  [16043]=170,--8438 --Llama Ethereal
  [16044]=171,--8501 --Ostard Ethereal
  [16045]=191,--Kirin
  [16046]="?46", --Didnt register
  [16047]=120, --minax
  [16048]=121, --Shadow Lords
  [16049]=119, --COM
  [16050]=118, --TB
  [16051]=144, --Seahorse
  [16052]=122, --Unicorn
  [16053]=177, --NM of Dappled brown
  [16054]=178, --NM of Tan
  [16055]=179, --Nightmare4 (Pure Mare)   
  [16056]=188, --Savage Ridgeback
  [16057]="?47", --Didnt register
  [16058]=187, --Ridgeback
  [16059]=319,--9751 --"hell Steed"/"Skeletal Mount"   
  [16060]=791, --Giant Beetle
  [16061]=794, --Swamp Dragon
  [16062]=799, --Scaled Swamp Dragon
  [16069]=213,--8417 --Polar Bear Ethereal/NonEthy
  [16070]="?70"--18168,18169 Boura Ethereal/NonEthy
} 

Layer25_hue={
[0]="NoColor",
[16385]="Ethy",
[1161]="Fire",
}

Timers={}
Timers.ItemDelay=getticks()

function OpenBackpack() UO.Macro(8,7) end
function IsContOpen(ID) for i=0,999 do local sName,nX,nY,nSX,nSY,nKind,nID,nType,nHP = UO.GetCont(i) if sName==nil then return false end if nID == ID then return i end end end
function Attack(ID) UO.LTargetKind = 1 UO.LTargetID = ID UO.Macro(27,0) end
function Equip(ID) 
  while Timers.ItemDelay+600 > getticks() do end
  while not IsContOpen(UO.CharID) do 
    UO.Macro(8,1) wait(700) 
  end 
  UO.Drag(ID) UO.DropPD() 
  Timers.ItemDelay=getticks()
  return true
end
function RClick(x,y) UO.Click(x,y,false,true,true,false) end 
function LClick(x,y) UO.Click(x,y,true,true,true,false) end

--###################################################
--##                     Targets                   ##
--###################################################
function Target(ID) UO.LTargetKind = 1 UO.LTargetID = ID UO.Macro(22,0) end 
function TargetG(X,Y,Z,K,Type) UO.LTargetTile = Type or 0 UO.LTargetKind = K or 2 UO.LTargetX = X UO.LTargetY = Y UO.LTargetZ = Z UO.Macro(22,0) end
function TargetSelf() UO.Macro(23,0) end

function MoveToGround(ID,Stack,X,Y) 
X=X or UO.CharPosX
Y=Y or UO.CharPosY 
UO.Drag(ID,Stack)
UO.DropG(X,Y)
end
function MoveToCont(ID,Stack,ContID)
UO.Drag(ID,Stack)
UO.DropC(ContID)
end







function DClick(ID) while Timers.ItemDelay+600 > getticks() do end UO.LObjectID = ID UO.Macro(17,0) Timers.ItemDelay=getticks() end
function Dismount() while IsMounted() do DClick(UO.CharID) end end
function Cast(SpellID) UO.Macro(15,SpellID) end
function IsMounted(ID) if ID==nil then ID=UO.CharID end DynamicsRefresh() local list=GetEquiped(ID) if list[25] then return list[25] end return false end
function IsBankOpen() DynamicsRefresh() local list=GetEquiped(UO.CharID) if list[29] then return true end return false end


--###################################################
--##                  Communication                ##
--###################################################
function Say(String) UO.Macro(1,0,String) end
function Emote(String) UO.Macro(2,0,String) end
function Whisper(String) UO.Macro(3,0,String) end
function Yell(String) UO.Macro(4,4,String) end
function Paste() UO.Macro(7,0) end



function CheckWeight()
  local PlayerFull=UO.Weight >= UO.MaxWeight - 4*12   
  local BeetleFull=0
  if Beetle then
    BeetleFull=Beetle.Weight >= Beetle.MaxWeight - 12       
    if PlayerFull and BeetleFull then 
      return "Bank"
    elseif PlayerFull then 
      return "Beetle"
    else 
      return "Good"
    end
  else
    if PlayerFull then 
      return "Bank"
    else 
      return "Good"
    end
  end
end

function Popup(ID,n)
  while UO.ContPosX ~= 0 do UO.Popup(ID) end 
  while UO.ContPosX == 0 do LClick(UO.ContPosX+45,UO.ContPosY+19*n) end--LClick(UO.ContPosX+45,UO.ContPosY+19*n) end
end

function GetValidKeys()
  local list={'ESC', 'BACK', 'TAB', 'ENTER', 'PAUSE', 'CAPSLOCK', 'SPACE', 'PGDN', 'PGUP', 'END', 'HOME', 'LEFT', 'RIGHT', 'UP', 'DOWN', 'PRNSCR', 'INSERT', 'DELETE', 'NUMLOCK', 'SCROLLLOCK', 'CTRL', 'ALT', 'SHIFT'} 
  local Depressed={}
  local ctrl,alt,shift,key=false,false,false,false
  for i=48,57 do
    if getkey(string.char(i)) then table.insert(Depressed,string.char(i)) end
  end
  for i=97,122 do   
    if getkey(string.char(i)) then table.insert(Depressed,string.char(i)) end
  end
  for i=1,12 do   
    if getkey("F"..i) then table.insert(Depressed,"F"..i) end
  end
  for i=1,#list do 
    if getkey(list[i]) then table.insert(Depressed,list[i]) end  
  end
  for i=1,#Depressed do 
    if Depressed[i]=="CTRL" then ctrl=true 
    elseif Depressed[i]=="ALT" then alt=true 
    elseif Depressed[i]=="SHIFT" then shift=true 
    else key=Depressed[i] end
  end
  return key,ctrl,alt,shift
end
function GetEquiped(id)
  local ID=id or UO.CharID    
  local Equipment={}   
  for i=1,#DynamicItemsFull do
    local P=DynamicItemsFull[i]
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol=P[1],P[2],P[3],P[4],P[5],P[6],P[7],P[8],P[9],P[10]
    if nContID==ID then 
      local Name, Flags, Height, Weight, Layer--=GetStaticTileData(nType)
---------------------------------------------------------------------------
--[[ Layer 25! "Mount" ]]--------------------------------------------------
---------------------------------------------------------------------------
      if Layer25[nType] then --Mount?
        Layer=25
        nType=Layer25[nType]   
        if Layer25_hue[nCol] then 
          nCol=Layer25_hue[nCol]
        end           
---------------------------------------------------------------------------
--[[ Layer 29! "Bank" ]]---------------------------------------------------
---------------------------------------------------------------------------
      elseif nType==3708 then --Its inside YOU, Not your backpack
        Layer=29  
        Name="Bank" 
        Flags=0 
        Height=0 
        Weight=0   
        nType=3708
        nCol=0                                                       
--------------------------------------------------------------------------- 
      else
        Name, Flags, Height, Weight, Layer=GetStaticTileData(nType)
      end 
      Equipment[Layer]={Name=Name,ID=nID,Type=nType,Weight=Weight,Color=nCol}
    end    
  end 
  Equipment[0]=getticks() --Last updated?
  return Equipment
end

function GetSpellIcon(Spelln)
  local LocOnPage=Spelln % 8
  local Page=math.floor(Spelln / 8 )
  local x,y

  UO.Macro(8,5)
  while UO.ContName ~= "spellbook gump" do
  end
--Move to correct Page
  if Page ~= 0 and Page ~= 1 then
    x=UO.ContPosX + 65 + 35 * Page
    if Page > 3 then
      x=x+30
    end
    y=UO.ContPosY + 185
    UO.Click(x,y,true,true,true,true)
  end
----------------------
  wait(1000)
--Single Click Spell
  if Page % 2 == 0 then x=UO.ContPosX + 60 else x=UO.ContPosX + 235 end
  y=UO.ContPosY + 60 + 15 * LocOnPage
  UO.Click(x,y,true,true,true,true)
----------------------
  wait(1000)
--Drag Out Icon
  if Spelln % 2 == 0 then x=UO.ContPosX + 80 else x=UO.ContPosX + 250 end
  y=UO.ContPosY + 60
  UO.Click(x,y,true,true,false,true)      
  wait(100)
  UO.Click(25,23,true,false,false,true)
  wait(100)
  UO.Click(25,23,true,false,true,true)
end

----------------------------------------
-- Cheffe's Table Converter Functions --
----------------------------------------

local function ToStr(value,func,spc)
  local t = type(value)                 --get type of value
  if t=="string" then
    return string.format("%q",value):gsub("\\\n","\\n"):gsub("\r","\\r")
  end
  if t=="table" then
    if func then
      return func(value,spc.."  ")
    else
      error("Tables not allowed as keys!",2)
    end
  end
  if t=="number" or t=="boolean" or t=="nil" then
    return tostring(value)
  end
  error("Cannot convert unknown type to string!",2)
end

----------------------------------------
local function TblToStr(t,spc)
  local s = "{\r\n"
  for k,v in pairs(t) do
    s = s..spc.."  ["..ToStr(k).."] = "..ToStr(v,TblToStr,spc)..",\r\n"
  end
  return s..spc.."}"
end
----------------------------------------
function TableToString(table)
  return TblToStr(table,"")
end
----------------------------------------
function LoadData(fn)
  local f,e = openfile(fn,"rb")         --r means read-only (default)
  if f then                             --anything other than nil/false evaluates to true
    local s = f:read("*a")              --*a means read all
    f:close()
    return s
  else                                  --if openfile fails it returns nil plus an error message
    error(e,2)                          --stack level 2, error should be reported
  end                                   --from where LoadData() was called!
end
---------------------------------------
function SaveData(fn,s)
  local f,e = openfile(fn,"w+b")        --w+ means overwrite
  if f then
    f:write(s)
    f:close()
  else
    error(e,2)
  end
end
-------------------------------------------
--DirToPoint && move, Thanks to kal in ex
-------------------------------------------
DirToPoint = function(...) 
  local varg = {...} 
  local x1,y1,x2,y2
  if #varg == 2 then
    x1 = UO.CharPosX
    y1 = UO.CharPosY
    x2 = varg[1] 
    y2 = varg[2] 
  else 
    x1 = varg[1] 
    y1 = varg[2] 
    x2 = varg[3] 
    y2 = varg[4] 
  end
  local d = -1 
  if x2 < x1 and y2 < y1 then d = 0 end
  if x2 == x1 and y2 < y1 then d = 1 end
  if x2 > x1 and y2 < y1 then d = 2 end
  if x2 > x1 and y2 == y1 then d = 3 end
  if x2 > x1 and y2 > y1 then d = 4 end
  if x2 == x1 and y2 > y1 then d = 5 end
  if x2 < x1 and y2 > y1 then d = 6 end
  if x2 < x1 and y2 == y1 then d = 7 end
  return d
end
 
Move = function(DestX,DestY,Timeout) 
  --while true do
    local CharX = UO.CharPosX
    local CharY = UO.CharPosY
    local MoveDir = DirToPoint(DestX, DestY) 
    if MoveDir == -1 then
    --   break  
      return false
    end
    local CharDir = UO.CharDir
    local TimeOUT = getticks() + Timeout 
    UO.Macro(5,MoveDir) 
    while UO.CharPosX == CharX and UO.CharPosY == CharY and UO.CharDir == CharDir do
      if getticks() >= TimeOUT then
        return false
      end
      wait(1) 
    end
  --end
  if UO.CharPosX == DestX and UO.CharPosY == DestY then
    return true
  else
    return false
  end
end