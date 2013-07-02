dofile(getinstalldir().."Scripts/wvanderzalm/Waypoints/Pathfinder.lua")                                                               
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")  




Waypoint=class()
function Waypoint:__init() 
  self.type=1
  self.links={}
  self.position={}
end       
function Waypoint:Addlink(Link)
  for i=1,#self.links do
    if self.links[i]:Getparent()==Link then return true end
  end                      
  local NewPos=Link:Getposition()
  table.insert(self.links,WPLink())
  self.links[#self.links]:Setparent(Link)                       
  self.links[#self.links]:Setdistance(GetDistanceSquared(self.position.X,self.position.Y,NewPos.X,NewPos.Y)) 
  if self.type~=3 and Link.type~=3 then Link:Addlink(self) end
end    
function Waypoint:Getposition() return self.position end
function Waypoint:Getlinks()  
  if self.type==1 then
    return self.links 
  elseif self.type==2 then
    local linklist={}
    for i=1,#MoongateList do
      if self~=MoongateList[i] then
        table.insert(linklist,WPLink())
        linklist[#linklist]:Setparent(MoongateList[i])                       
        linklist[#linklist]:Setdistance(1)
      end
    end
    for i=1,#self.links do                    
      table.insert(linklist,self.links[i]) 
    end
    return linklist
  elseif self.type==3 then
    local linklist=self.links 
    for i=1,#linklist do                    
      linklist[i]:Setdistance(1)
    end
    return linklist
  end  
end

WPLink=class()
function WPLink:init()
  self.parent=0
  self.distance=0
end
function WPLink:Getparent() return self.parent end  
function WPLink:Setparent(Link) self.parent=Link end  
function WPLink:Getdistance() return self.distance end 
function WPLink:Setdistance(Dist) self.distance=Dist end

function FindclosestWaypoint(X,Y,Z,f)
  local facet=f or UO.CursKind
  local org=Point3D(X,Y,Z)
  local Closest={index=0,Distance=9000}   
  for i=1,#WPList do      
    if WPList[i].position.f~=facet then
    else
      local Current=Point3D(WPList[i].position.X,WPList[i].position.Y,WPList[i].position.Z)
      local Dist=Current:GetDistanceSquared(org) 
      if Dist < Closest.Distance then
        Closest={index=i,Distance=Dist}
      end
    end
  end
  return Closest
end 
function GetDistanceSquared(x,y,x2,y2) dx = x-x2 dy = y-y2 return math.sqrt((dx * dx) + (dy * dy)) end   
BreadLoaf=class()
function BreadLoaf:__init(position) 
  self.f_score = 2147483647 --Int32.MaxValue
  self.g_score = 2147483647
  self.h_score = 2147483647
end
BreadLoaf.__eq = function(op1,op2) return op1.position==op2.position end
function BreadLoaf:CompareTo(other) if (self.f_score>other.f_score) then return 1 elseif (self.f_score<other.f_score) then return -1 else return 0 end end
function WaitForCont(x,y,t)
  Timeout = getticks() + t                                              
  while Timeout > getticks() and UO.ContSizeX ~= x and UO.ContSizeY ~= y do wait(50) end
  if UO.ContSizeX ~= x and UO.ContSizeY ~= y then return false end 
  return true
end
function NotWaitForCont(x,y,t)
  Timeout = getticks() + t                                              
  while Timeout > getticks() and UO.ContSizeX == x and UO.ContSizeY == y do wait(50) end
  if UO.ContSizeX == x and UO.ContSizeY == y then return false end 
  return true
end
MoongateMenu={}
MoongateMenu.Facet=function(n) if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(100) LClick(UO.ContPosX+17,UO.ContPosY+40+25*n) if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(50) return true end
MoongateMenu.Location=function(n) if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(100) LClick(UO.ContPosX+210,UO.ContPosY+45+25*n) if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(50) return true end
MoongateMenu.Okay=function() if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(100) LClick(UO.ContPosX+25,UO.ContPosY+Moongate.Height-60) if not NotWaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(50) return true end
MoongateMenu.Cancel=function() if not WaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(100) LClick(UO.ContPosX+25,UO.ContPosY+Moongate.Height-35) if not NotWaitForCont(Moongate.Width,Moongate.Height,4000) then return false end wait(50) return true end

function Astart(WP1,WP2)
  local ignoremoongates=false 
  local ignoreteleports=false
  local ClosedList={}
  local OpenList=MinHeap()
  local Path={}
  local Current=BreadLoaf()
  Current.Next=WP1
  Current.h_score=GetDistanceSquared(Current.Next.position.X,Current.Next.position.Y,WP2.position.X,WP2.position.Y)
  Current.g_score=0
  Current.f_score=Current.h_score+Current.g_score
  OpenList:Add(Current)

  while OpenList.count>0 do
    local Pointer
    local Current=OpenList:ExtractFirst() 
    if Current.Next==WP2 then print("Waypoint 2 found!") 
      local path,temppath={},{}
      repeat 
        table.insert(temppath,Current.Next)
        Current=Current.Last
      until Current==nil
      for i=0,#temppath-1 do table.insert(path,temppath[#temppath-i]) end
      return path 
    end
    if (ignoremoongates and Current.Next.type==2) or (ignoreteleports and Current.Next.type==3) then
      Pointer={}
    else
      Pointer=Current.Next:Getlinks()
    end
    for i=1,#Pointer do
      local Parent=Pointer[i]:Getparent()  
      OnClosedList=false
      for j=1,#ClosedList do
        if Parent==ClosedList[j] then
          OnClosedList=true
        end
      end
      if not OnClosedList then
        local Next=BreadLoaf()
        Next.h_score=GetDistanceSquared(Current.Next.position.X,Current.Next.position.Y,Parent.position.X,Parent.position.Y)
        Next.g_score=Current.g_score+Pointer[i]:Getdistance()
        Next.f_score=Next.h_score+Next.g_score
        Next.Next=Parent
        Next.Last=Current
        OpenList:Add(Next)
      end
    end
    table.insert(ClosedList,Current.Next)
  end
end

function Pathfind(x,y,z)   
--Path=Astart(A,D) 
  local begin={X=UO.CharPosX,Y=UO.CharPosY,Z=UO.CharPosZ}
  local finish={X=x,Y=y,Z=z}             
  if begin.X==finish.X and begin.Y==finish.Y and begin.Z==finish.Z then return true end
  local startcord=FindclosestWaypoint(begin.X,begin.Y,begin.Z)
  local endcord=FindclosestWaypoint(finish.X,finish.Y,finish.Z)
  local start=WPList[startcord.index]
  local enddd=WPList[endcord.index]
  local P1=PathFinder()
  local P2=PathFinder()  
  
  Path=Astart(start,enddd)
  table.insert(Path,1,{position=begin,type=1})
  table.insert(Path,#Path+1,{position=finish,type=1})  
  table.insert(Path,#Path+1,{position=finish,type=1})
  for i=1,#Path do print(Path[i].position.X..","..Path[i].position.Y..","..Path[i].position.Z) end
  DynamicsRefresh()
  pointer1=P1
  pointer2=P2 
  --pointer1:FindPath({pos.X,pos.Y,pos.Z}, {pos2.X,pos2.Y,pos2.Z},UO.CharDir,t,false)
  for i=1,#Path-1 do  --Minus one cuz we dont pathfind FROM the last spot
  
    local temp=pointer2
    pointer2=pointer1
    pointer1=temp
    pos=Path[i].position
    pos2=Path[i+1].position
    pointer1:FindPath({pos.X,pos.Y,pos.Z}, {pos2.X,pos2.Y,pos2.Z},UO.CharDir,t,false)
    while pointer2:Next() do if pointer1.path==nil then pointer1:callback()pointer1:callback() end end  
    if Path[i].type==2 and Path[i+1].type==2 then   
      while pointer2:Next() do end  
      Moongate.ID=0
      if not WaitForCont(Moongate.Width,Moongate.Height,1000) then 
        DynamicsRefresh()
        print(#DynamicItems[Path[i].position.X][Path[i].position.Y] ) 
        for j=1,#DynamicItems[Path[i].position.X][Path[i].position.Y] do
          print(DynamicItems[Path[i].position.X][Path[i].position.Y][j][1])
          local type=DynamicItems[Path[i].position.X][Path[i].position.Y][j][1]
          if type>=0x0F6C and type<=0x0F70 then
            Moongate.ID=DynamicItems[Path[i].position.X][Path[i].position.Y][j][6]
          end
        end                                                               
        if Moongate.ID==0 then print("Error no moongate found...") pause() end
      end
      local MenuIndex={}
      for j=1,#MoongateLocations do
        if MoongateLocations[j][2][1]==Path[i+1].position.X and
        MoongateLocations[j][2][2]==Path[i+1].position.Y and
        MoongateLocations[j][2][3]==Path[i+1].position.Z and
        MoongateLocations[j][2][4]==Path[i+1].position.f then
          MenuIndex=MoongateLocations[j][1]
          break
        end
      end   
      local OX,OY=UO.CharPosX, UO.CharPosY 
      while OX==UO.CharPosX and OY==UO.CharPosY do
        while OX==UO.CharPosX and OY==UO.CharPosY and not WaitForCont(Moongate.Width,Moongate.Height,1000) do DClick(Moongate.ID) print("ding2222")  end
        if #MenuIndex==0 then print("Moongate menu error!") pause() end
        if not MoongateMenu.Facet(MenuIndex[1]) then print("Moongate menu returns false!") pause() end
        if not MoongateMenu.Location(MenuIndex[2]) then print("Moongate menu returns false!") pause() end    
        if not MoongateMenu.Okay() then print("Moongate menu returns false!") pause() end      
        local Timeout = getticks() + 2000                                              
        while Timeout > getticks() and OX==UO.CharPosX and OY==UO.CharPosY do wait(50) end
      end            
    elseif Path[i].type==3 then   
      while pointer2:Next() do end   
      while OX==Path[i].position.X and OY==Path[i].position.Y do wait(10) end
    else    
      while pointer1.path==nil do pointer1:callback()pointer1:callback()end  
    end               
    pointer2.path=nil 
  end
  return true
end

--------------------------------
--dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid Map Api.lua")  
--local hook=Gridmap_Api
--local Nodes=hook:getnodes()
--while Nodes==false do Nodes=hook:getnodes() end    
Moongate={ID=0,Width=380,Height=295}
dofile(getinstalldir().."Scripts/wvanderzalm/waypointssave.txt")

WPList={}
MoongateList={}
local TempLinkHolder={}
for i=1,#Nodes do      
  local cmd=string.sub(Nodes[i].Action,1,string.find(Nodes[i].Action,":")-1)
  if cmd == "Link" then
    WPList[i]=Waypoint()
    WPList[i].position={X=Nodes[i].X,Y=Nodes[i].Y,Z=Nodes[i].Z,f=Nodes[i].Facet} 
    WPList[i].type=1 --Standard node
    local Links={}
    table.insert(TempLinkHolder,{})
    TempLinkHolder[#TempLinkHolder][0]=i
    for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end    
  end
  if cmd == "Moongate" then
    WPList[i]=Waypoint()
    WPList[i].position={X=Nodes[i].X,Y=Nodes[i].Y,Z=Nodes[i].Z,f=Nodes[i].Facet}
    WPList[i].type=2 --moongate
    table.insert(MoongateList,WPList[i])
    local Links={}
    table.insert(TempLinkHolder,{})
    TempLinkHolder[#TempLinkHolder][0]=i
    for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end    
  end
  if cmd == "Teleport" then
    WPList[i]=Waypoint()
    WPList[i].position={X=Nodes[i].X,Y=Nodes[i].Y,Z=Nodes[i].Z,f=Nodes[i].Facet}
    WPList[i].type=3 --teleport
    table.insert(TempLinkHolder,{})
    TempLinkHolder[#TempLinkHolder][0]=i
    for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(TempLinkHolder[#TempLinkHolder],tonumber(w)) end        print(#TempLinkHolder[#TempLinkHolder])
  end
end  
for i=1,#TempLinkHolder do
  local WPindex=TempLinkHolder[i][0]
  for j=1,#TempLinkHolder[i] do  
    local WPlink=TempLinkHolder[i][j] 
    WPList[WPindex]:Addlink(WPList[WPlink])
  end
end 




--Pathfind(1479,1616,20)  
--Pathfind(4467,1273,0)   
Pathfind(4449,1115,5)
--Pathfind(566,990,0) 