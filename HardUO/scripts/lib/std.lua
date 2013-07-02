print("std.lua init")
STDINIT = true   



function Attack(ID) UO.LTargetKind = 1 UO.LTargetID = ID UO.Macro(27,0) end
function Equip(ID) while UO.ContID ~= UO.CharID do UO.Macro(8,1) wait(700) end UO.Drag(ID) UO.DropPD() end
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



function DClick(ID) UO.LObjectID = ID UO.Macro(17,0) end
function Dismount() DClick(UO.CharID) end
function Cast(SpellID) UO.Macro(15,SpellID) end


--###################################################
--##                  Communication                ##
--###################################################
function Say(String) UO.Macro(1,0,String) end
function Emote(String) UO.Macro(2,0,String) end
function Whisper(String) UO.Macro(3,0,String) end
function Yell(String) UO.Macro(4,4,String) end
function Paste() UO.Macro(7,0) end







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