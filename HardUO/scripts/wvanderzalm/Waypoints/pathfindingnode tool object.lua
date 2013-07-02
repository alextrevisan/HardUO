function SaveData(fn,s)
  local f,e = openfile(fn,"w+b")        --w+ means overwrite
  if f then
    f:write(s)
    f:close()
  else
    error(e,2)
  end
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

                                                              
dofile(getinstalldir().."scripts/wvanderzalm/std.lua")

ControlUnit=class()
function ControlUnit:__init() 
  self.Controls={}
  self.Count=0
  


end                  
function ControlUnit:Add(X,Y,Z,f) 
  table.insert(self.Controls,{Links={},position={X=X,Y=Y,Z=Z},facet=f,NodeIndex=0,Action="Link",Extra="Made in Control Unit"})
end
function ControlUnit:Remove(Ctrl) 
  local index=0
  for i=1,#self.Controls do
    if self.Controls[i]==Ctrl then
      index=i
      break
    end
  end
  if index==0 then print("This control doesn't exist") return false end
  for i=1,#Ctrl.Links do
    local Link=Ctrl.Links[i]
    self:RemoveLink(Link,Ctrl) 
  end
  table.remove(self.Controls,index)
end
function ControlUnit:Link(C1,C2)
  if C1==C2 then return false end 
  if not C1 or not C2 then return false end
 --[[ if C1.Action~="Teleport" and C2.Action=="Teleport" then
    self:OneWayLink(C1,C2)  
    return true
  end 
  if C1.Action=="Teleport" and C2.Action~="Teleport" then
    self:OneWayLink(C1,C2)
    return true
  end ]]
  for i=1,#C1.Links do
    if C1.Links[i]==C2 then return true end
  end
  table.insert(C1.Links,C2)
  if C1.Action~="Teleport" and C2.Action~="Teleport" then self:Link(C2,C1) end
end 
--[[function ControlUnit:OneWayLink(C1,C2)
  if C1==C2 then return false end  
  if not C1 or not C2 then return false end
  for i=1,#C1.Links do
    if C1.Links[i]==C2 then return true end
  end
  table.insert(C1.Links,C2)
end ]]
function ControlUnit:RemoveLink(Ctrl,Link)
  if C1==Link then return false end
  if not Ctrl then return false end  
  for i=1,#Ctrl.Links do  
    if Ctrl.Links[i]==Link then  
      table.remove(Ctrl.Links,i)
      --self:RemoveLink(Link,Ctrl) 
      return true 
    end
  end   
  return true           
end 
function ControlUnit:RemoveAllLinks(Ctrl)
  if not Ctrl then return false end  
  for i=#Ctrl.Links,1,-1 do  
    table.remove(Ctrl.Links,i) 
  end   
  return true           
end 
function ControlUnit:BuildNodesList()
  local List={}
  for i=1,#self.Controls do
    self.Controls[i].NodeIndex=i
  end
  for i=1,#self.Controls do
    local Node={}
    Node.Label=self.Controls[i].Extra
    Node.X=self.Controls[i].position.X
    Node.Y=self.Controls[i].position.Y
    Node.Z=self.Controls[i].position.Z
    Node.Facet=self.Controls[i].facet
    Node.Action=self.Controls[i].Action..":"--"Link:"
    for j=1,#self.Controls[i].Links do
      Node.Action=Node.Action..self.Controls[i].Links[j].NodeIndex..":"
    end
    if self.Controls[i].Action=="Link" then Node.Col=255 
    elseif self.Controls[i].Action=="Moongate" then Node.Col=(0   +   Bit.Shl(0,8)     +   Bit.Shl(255,16))    
    elseif self.Controls[i].Action=="Teleport" then Node.Col=(255   +   Bit.Shl(255,8)     +   Bit.Shl(0,16))
    end
    Node.Scale=1
    Node.Width=1
    table.insert(List,Node)
  end
  return List
end      
function ControlUnit:BuildControlsList() 
  self.Controls={}              
  local TempLinkHolder={}
  for i=1,#Nodes do
    local Control={}
    Control.NodeIndex=i
    Control.position={}
    Control.position.X=Nodes[i].X
    Control.position.Y=Nodes[i].Y
    Control.position.Z=Nodes[i].Z 
    Control.facet=Nodes[i].Facet     
    Control.Extra=Nodes[i].Label
    Control.Links={}      
    if string.sub(Nodes[i].Action,1,4) == "Link" then
      Control.Action="Link"      
      table.insert(TempLinkHolder,{})
      TempLinkHolder[#TempLinkHolder][0]=i
      for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end     
    elseif string.sub(Nodes[i].Action,1,8) == "Moongate" then
      Control.Action="Moongate"    
      table.insert(TempLinkHolder,{})
      TempLinkHolder[#TempLinkHolder][0]=i
      for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end     
    elseif string.sub(Nodes[i].Action,1,8) == "Teleport" then
      Control.Action="Teleport"
      table.insert(TempLinkHolder,{})
      TempLinkHolder[#TempLinkHolder][0]=i
      for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end     
    end
    table.insert(self.Controls,Control)     
    TempLinkHolder[#TempLinkHolder][0]=self.Controls[#self.Controls]
  end
  for i=1,#TempLinkHolder do
    for m=1,#TempLinkHolder[i] do
      local Link=0
      for j=1,#self.Controls do
        if self.Controls[j].NodeIndex==TempLinkHolder[i][m] then
          Link=self.Controls[j]
          break
        end
      end
      if Link==0 then print("Cant link to this, doesn't exist") pause() 
      else
        self:Link(TempLinkHolder[i][0],Link)
      end
    end  
  end
  return 
end
function ControlUnit:Findclosest(X,Y,Z,f)
  local Closest={index=0,Distance=9000}
  for i=1,#self.Controls do
    local Ptr=self.Controls[i]
    if Ptr.facet==f then
      local Dist=math.sqrt(((Ptr.position.X-X) * (Ptr.position.X-X)) + ((Ptr.position.Y-Y) * (Ptr.position.Y-Y)))
      print(Dist)
      if Dist < Closest.Distance then
        Closest={index=i,Distance=Dist}
      end
    end
  end
  if Closest.index==0 then return false end
  return self.Controls[Closest.index], Closest.Distance
end 
function getmousecords() 
  local P={X=math.floor((UO.CursorX-UO.CliLeft+UO.CursorY-UO.CliTop-UO.CliYRes/2-UO.CliXRes/2+22)/44),Y=math.floor((UO.CursorY-UO.CliTop-(UO.CursorX-UO.CliLeft)-UO.CliYRes/2+UO.CliXRes/2+22)/44)} 
  return P
end

test=ControlUnit()
function Rebuild()
  local list=test:BuildNodesList()
  setatom("MREAtom","Nodes="..TableToString(list).." NodeListUpdate() clrscr() update=true setatom('MREAtom',false)")
  while getatom("MREAtom") do end
  Selected={}  
end


dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid Map Api.lua")  
   

local Hotkey_Add="a"
local Hotkey_Select="s"
local Hotkey_Link="l"
local Hotkey_Rebuild="r"
local Hotkey_Undo="z"
local Hotkey_BreakLink="b"
local Hotkey_Delete="d" --plus alt
local Hotkey_Move="x"
Selected={}
--local History={}


while true do
  if getkey("ctrl") then       
    local temp=getmousecords()
    local X=UO.CharPosX+temp.X
    local Y=UO.CharPosY+temp.Y 
    local Z=GetLandTileZ(X,Y)
    local f=UO.CursKind
---------------------------------------------------------------------------
--[[ Refresh GridMap! ]]------------------------------------------------------
---------------------------------------------------------------------------
    if getkey(Hotkey_Rebuild) then                 
      while getkey(Hotkey_Rebuild) do end 
      Rebuild()
    end
---------------------------------------------------------------------------
--[[ Save! ]]--------------------------------------------------------------
---------------------------------------------------------------------------
  --  if getkey("alt") then
    while getkey("alt") do
      if getkey("p") then 
        while getkey("p") do end      
        print("Saving...")           
        local list=test:BuildNodesList()
        SaveData(getinstalldir().."Scripts/wvanderzalm/waypointssave.txt","Nodes="..TableToString(list))
      end
---------------------------------------------------------------------------
--[[ Load! ]]--------------------------------------------------------------
--------------------------------------------------------------------------- 
      if getkey("o") then
        while getkey("o") do end  
        print("Opening...")
        dofile(getinstalldir().."Scripts/wvanderzalm/waypointssave.txt")
        test:BuildControlsList()                                        
        Rebuild()
      end
      if getkey("i") then
        while getkey("i") do end  
        print("Opening...")
        local hook=Gridmap_Api
        Nodes=hook:getnodes()
        while Nodes==false do Nodes=hook:getnodes() end 
        test:BuildControlsList()                                        
        Rebuild()
      end
    end
---------------------------------------------------------------------------
--[[ Add Control! ]]-------------------------------------------------------
--------------------------------------------------------------------------- 
    if getkey(Hotkey_Add) then
      while getkey(Hotkey_Add) do end 
      test:Add(X,Y,Z,f)
      Rebuild()
    end  
---------------------------------------------------------------------------
--[[ Delete Selected! ]]---------------------------------------------------
---------------------------------------------------------------------------
    if getkey(Hotkey_Delete) and getkey("alt") then
      while getkey(Hotkey_Delete) do end 
      if #Selected > 0 then
        for i=1,#Selected do
          test:Remove(Selected[i])
          --table.insert(History,{cmd="remove",index="0"})
        end
        Rebuild()
      else
        print("Not enought controls selected")
      end
    end 
---------------------------------------------------------------------------
--[[ Selecto Control! ]]---------------------------------------------------
---------------------------------------------------------------------------
    if getkey(Hotkey_Select) then                 
      while getkey(Hotkey_Select) do end
      local index=test:Findclosest(X,Y,Z,f)  
      local isset=0
      if index~= false then
        for i=1,#Selected do  
          if Selected[i]==index then isset=i end
        end
        if isset~=0 then
          table.remove(Selected,isset)
          setatom("MREAtom","Nodes["..index.NodeIndex.."].Col=255 NodeListUpdate() clrscr() update=true setatom('MREAtom',false)")
          while getatom("MREAtom") do end 
        else
          table.insert(Selected,index)
          setatom("MREAtom","Nodes["..index.NodeIndex.."].Col=25500 NodeListUpdate() clrscr() update=true setatom('MREAtom',false)")
          while getatom("MREAtom") do end  
        end
      end
    end            
---------------------------------------------------------------------------
--[[ Link Selected! ]]------------------------------------------------------
---------------------------------------------------------------------------               
    if getkey(Hotkey_Link) then                 
      while getkey(Hotkey_Link) do end 
      if Selected[1].Action=="Teleport" and Selected[2].Action~="Teleport" then  
        test:RemoveLink(Selected[2],Selected[1]) 
        test:RemoveAllLinks(Selected[1]) 
        test:Link(Selected[1],Selected[2])
        print("Linked Teleporter in a One-Way link!"..#Selected[2].Links)
        Rebuild()
      elseif Selected[1].Action~="Teleport" and Selected[2].Action=="Teleport" then  
        test:Link(Selected[1],Selected[2])
        print("Linked Teleporter in a One-Way link!")
        Rebuild()
      elseif #Selected > 1 then 
        for i=1,#Selected do
          for j=1,#Selected do test:Link(Selected[i],Selected[j]) end
        end 
        Rebuild()
      else
        print("Not enought controls selected")
      end
    end
---------------------------------------------------------------------------
--[[ Break Links of Selected! ]]-------------------------------------------
---------------------------------------------------------------------------
    if getkey(Hotkey_BreakLink) then                 
      while getkey(Hotkey_BreakLink) do end 
      if #Selected > 1 then 
        for i=1,#Selected do
          for j=1,#Selected do 
            test:RemoveLink(Selected[i],Selected[j]) 
            test:RemoveLink(Selected[j],Selected[i])
          end
        end 
        Rebuild()
      else
        print("Not enought controls selected")
      end
    end
---------------------------------------------------------------------------
--[[ Change Selected to MOONGATE! ]]---------------------------------------
---------------------------------------------------------------------------
    if getkey("m") then                 
      while getkey("m") do end 
      if #Selected==1 then 
        Selected[1].Action="Moongate"
        Rebuild()
      else
        print("Not enought controls selected")
      end
    end
---------------------------------------------------------------------------
--[[ Change Selected to TELEPORT! ]]---------------------------------------
---------------------------------------------------------------------------
    if getkey("n") then                 
      while getkey("n") do end 
      if #Selected==1 then 
        Selected[1].Action="Teleport"
        Rebuild()
      else
        print("Not enought controls selected")
      end
    end
---------------------------------------------------------------------------
--[[ Move Nearest! ]]------------------------------------------------------
---------------------------------------------------------------------------
    if getkey(Hotkey_Move) then   
      local Mouse=getmousecords()    
      local Closest=test:Findclosest(UO.CharPosX+Mouse.X,UO.CharPosY+Mouse.Y,GetLandTileZ(UO.CharPosX+Mouse.X,UO.CharPosY+Mouse.Y),f)
      if Closest.index~=false then           
        local oldX=UO.CharPosX+Mouse.X 
        local oldY=UO.CharPosY+Mouse.Y  
        local oldZ=GetLandTileZ(oldX,oldY)   
        while getkey(Hotkey_Move) do   
          Mouse=getmousecords() 
          local index=Closest.NodeIndex        
          local X= UO.CharPosX+Mouse.X                            
          local Y= UO.CharPosY+Mouse.Y 
          local Z=GetLandTileZ(X,Y)   
          setatom("MREAtom","DrawThread("..Closest.position.X..","..Closest.position.Y..","..Closest.position.Z..", "..oldX..", "..oldY..", "..oldZ..", 0, 1, 1) DrawThread("..Closest.position.X..","..Closest.position.Y..","..Closest.position.Z..", "..X..", "..Y..", "..Z..", 255000, 1, 1) setatom('MREAtom',false)")
          while getatom("MREAtom") do end  
          oldX=X
          oldY=Y
          oldZ=Z
        end
        local Mouse=getmousecords() 
        Closest.position={X=UO.CharPosX+Mouse.X,Y=UO.CharPosY+Mouse.Y,Z=GetLandTileZ(UO.CharPosX+Mouse.X,UO.CharPosY+Mouse.Y),f=f}
        Rebuild() 
      end
    end
---------------------------------------------------------------------------
--[[ Null! ]]------------------------------------------------------
---------------------------------------------------------------------------
  end
end