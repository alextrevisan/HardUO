debug_str="" 
 setatom("MREAtom",nil)
   Radar={}
  for i=0,999 do local sName,nX,nY = UO.GetCont(i)
    if sName == "radar gump" then Radar={X=nX,Y=nY} break end
    if sName==nil then break end
  end  
 
  local ScreenResX=1680
  local ScreenResY=1050 
PathType={}
for i=0x71,0x78 do PathType[i]=true end
for i=0xe8,0xeb do PathType[i]=true end
for i=0x27e,0x281 do PathType[i]=true end
for i=0x296,0x2bb do PathType[i]=true end
for i=0x355,0x358 do PathType[i]=true end 
for i=0x377,0x37a do PathType[i]=true end
for i=0x3a5,0x3a8 do PathType[i]=true end
for i=0x3e9,0x405 do PathType[i]=true end --cobble stone
for i=0x406,0x51c do PathType[i]=true end --flooring ?keep?
for i=0x529,0x52c do PathType[i]=true end    
for i=0x553,0x556 do PathType[i]=true end
for i=0x637,0x63a do PathType[i]=true end
for i=0x69d,0x6a0 do PathType[i]=true end
for i=0x79a,0x7b1 do PathType[i]=true end
--skipped over some,.. not sure what they are
for i=0x3ff8,0x3ffb do PathType[i]=true end
--for i=0x71,0x78 do PathType[i]=true end
--
--Statics now
--                     
for i=0x4495,0x453a do PathType[i]=true end  
for i=0x4554,0x4585 do PathType[i]=true end
for i=0x462b,0x4632 do PathType[i]=true end
for i=0x4637,0x463e do PathType[i]=true end
for i=0x4709,0x47d0 do PathType[i]=true end--stairs
for i=0x487a,0x487d do PathType[i]=true end--ramps
for i=0x6722,0x6751 do PathType[i]=true end--jap flooring
for i=0x686e,0x6885 do PathType[i]=true end--more jap flooring
for i=0x6960,0x698f do PathType[i]=true end--more jap flooring
for i=0x71f4,0x71fb do PathType[i]=true end  --DIRT!!--
--for i=0x71,0x78 do PathType[i]=true end


------------------------------------
-- Script Name: Pathfinder.lua
-- Author: Wesley Vanderzalm
-- Version: 1.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestServer
-- Revision Date: 
-- Public Release: March 28 2011
-- Purpose: Find a way from A -> B
------------------------------------
dofile(getinstalldir().."scripts/wvanderzalm/class.lua")  
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")         
dofile("Point3d.lua") 
dofile("breadcrumb.lua") 
dofile("MinHeap.lua")      
dofile("Check.lua")   
dofile(getinstalldir().."scripts/wvanderzalm/MulHandles.lua")
WorldTilesReset()  
DynamicsReset()   
            
PathFinder=class()
function PathFinder:__init() 
  self.path=nil 
  --self.DynamicCnt=100
  self.PathGravity=false
  self.HeuristicWeight=1
  self.Destination={}
  self.timeout=0
end 
function PathFinder:Skip()   
    table.remove(self.path,1)    
    self.DynamicCnt=self.DynamicCnt+1
end

function PathFinder:Next(PathGravity)
  if self.path == nil then
    return false, "empty"
  end               
  if self.path[1] == nil then
    return false, "finished"
  end
 -- if self.DynamicCnt > 8 then   
    DynamicsRefresh()
  --  self.DynamicCnt=0
  --end
  local x,y,z = self.path[1].X, self.path[1].Y, self.path[1].Z  

  local nCeiling=2147483647   
  local bTerrain=false                                               
  local bBridge=false
  local nHeight=0 
  local nZ=UO.CharPosZ
  
  if UO.CharPosX ~=x or UO.CharPosY~=y then 
    Move(x,y,500)
    print(x.."  "..y.."  "..z)
    if DynamicItems[x] and DynamicItems[x][y] then
      local IgnoreDoors=UO.CharType==402
      local IgnoreSpellFeilds=false
      
      if not IsOK(x,y,IgnoreDoors,IgnoreSpellFeilds,z,z+PersonHeight) then 
        if not IsOK(x,y,true,IgnoreSpellFeilds,z,z+PersonHeight) then--return "Error : Movement is not passable!"    
          local oldpath = self.path
          if not self:FindPath({UO.CharPosX,UO.CharPosY,UO.CharPosZ}, {self.Destination[1],self.Destination[2],self.Destination[3]},PathGravity) then
            self.path = oldpath
            return true, "Dynamic In the way"
            --wait(500) 
          end
        else
          local DoorID=0
          for i=1,#DynamicItems[x][y] do
            if DynamicItems[x][y][i][2]+DynamicItems[x][y][i][5] > UO.CharPosZ and UO.CharPosZ+PersonHeight>DynamicItems[x][y][i][2] and Bit.And(DynamicItems[x][y][i][4],Flags.Door)~=0 then
              DoorID=DynamicItems[x][y][i][6]
              break
            end
          end
          if DoorID ~= 0 then
            print("Opening Door...   "..DoorID)
            DClick(DoorID)
            wait(500)
            return true
          end
        end 
      end  
    end
  else   
    table.remove(self.path,1)       
  end       
  --self.DynamicCnt=self.DynamicCnt+1
  return true
end  
function PathFinder:FindPath(start, finished, dir, hWeight, PathGravity)  
  if start[1]==finished[1] and start[2]==finished[2] and start[3]==finished[3] then return true end
  dir=dir or UO.CharDir
  self.HeuristicWeight=hWeight or -1 
  self.PathGravity=PathGravity or false
  self.Destination=finished
--  self.path=PathFinder:FindPathReversed(start,finished,PathGravity) return self.path
--end    
--function PathFinder:FindPath(start,finished,PathGravity)
  DynamicsRefresh()  --<-- Should be first time used 
  local IgnoreDoors=true  
  local IgnoreSpellFeilds=false
  local OpenList=MinHeap()
  local brWorld={}       
  local tmp=Point3D
  local diff=0    
  local current = BreadCrumb(start) 
  local low  
  low,start[3]=GetStartZ(start[1],start[2],start[3])  
 -- low,finished[3]=GetStartZ(finished[1],finished[2],finished[3]) 
  
  current.position=Point3D(start[1],start[2],start[3])  
  current.dir=dir
  _,current.type=Check({X=start[1],Y=start[2],Z=start[3],Top=start[3]+PersonHeight},start[1],start[2],true,true)
  current.next=BreadCrumb(start)                           
  current.next.position=Point3D(start[1],start[2],start[3])  
                
  current.g_score=0
  local distance=current.position:GetDistanceSquared(Point3D(finished[1],finished[2],finished[3])) 
  if self.HeuristicWeight==-1 then self.HeuristicWeight=math.ceil(distance/50) end
  --if self.HeuristicWeight > 10 then self.HeuristicWeight=10 end
  current.h_score=distance*self.HeuristicWeight
  current.f_score=current.g_score+current.h_score 

  
  local finish = BreadCrumb(finished)          
  finish.position=Point3D(finished[1],finished[2],finished[3])  
      
  if brWorld[current.position.X] == nil then brWorld[current.position.X]={} end  
  if brWorld[current.position.X][current.position.Y] == nil then brWorld[current.position.X][current.position.Y]={} end
  brWorld[current.position.X][current.position.Y][current.position.Z]= current
  OpenList:Add(current)

  --Mainly for debugging purposes, These can be removed eventually   
  print("Heuristic Weight :"..self.HeuristicWeight)                               
  print("########START########","Start : X "..start[1].."  Y "..start[2].."  Z "..current.position.Z) 
  print("#########END########","End : X "..finished[1].."  Y "..finished[2].."  Z "..finished[3])

  local onethirddist=math.floor(distance/6)
  while OpenList.count > 0 do  
   -- if self.timeout and self.timeout < getticks() then return "timeout" end
    local g_score=er0r
    local h_score=er0r
    local f_score=er0r
    local current = OpenList:ExtractFirst()
    current.onClosedList=true
    brWorld[current.position.X][current.position.Y][current.position.Z]=current
    --For Each Neighbour                  
    for i=0,7 do    
      local diff = 0 --penalties
      local tmp ={}
      tmp.X,tmp.Y= Offset(i,current.position.X,current.position.Y)  
      local apple = getticks()
      local Passable, NewZ, NewType= CheckMovement(current.position.X,current.position.Y,current.position.Z,i,IgnoreDoors,IgnoreSpellFeilds)--tmp,current.ceiling,current.terrain,current.bridge)
      if Passable and PathGravity and PathType[current.type] and current.position:GetDistanceSquared(finish.position) > onethirddist and not PathType[NewType] then Passable=false end
      if totaltime then totaltime=totaltime+(getticks()-apple) end
      if Passable then
        --For Each Tile that can be stood upon
        local node={}   
        tmp.Z = NewZ 
        if brWorld[tmp.X]==nil or brWorld[tmp.X][tmp.Y]==nil or brWorld[tmp.X][tmp.Y][tmp.Z] == nil then
          node = BreadCrumb(tmp.position)
          node.position=Point3D(tmp.X,tmp.Y,tmp.Z)
          node.dir=i
          node.type=NewType   --**
          --Create the empty placeholder in brWorld, for this node.
          if brWorld[tmp.X] == nil then brWorld[tmp.X]={} end if brWorld[tmp.X][tmp.Y] == nil then brWorld[tmp.X][tmp.Y]={}end 
          brWorld[tmp.X][tmp.Y][tmp.Z]=node
        else
          node = brWorld[tmp.X][tmp.Y][tmp.Z]
        end
        if not node.onClosedList then 
          local ndistance=node.position:GetDistanceSquared(finish.position)
          --Penalty for moveing
          if current.position.X ~= node.position.X then diff=1 end--diff+1 end  
          if current.position.Y ~= node.position.Y then if diff ~= 0 then diff=1.4142135623731 else diff=1 end end
          --if current.position.Z ~= node.position.Z then diff=diff+0.5 end--diff+1 end 
          if current.dir ~= node.dir then diff=diff + 0.4 end -- Penalty for turning 
          h_score=ndistance*self.HeuristicWeight
          --These scores are used to determin the path of least cost... Adding conditions that change these scores will alter how the path is draw.
          g_score=current.g_score + diff
          --h_score=(math.abs(current.position.X-finish.position.X)+math.abs(current.position.Y-finish.position.Y))
         -- h_score=distance*self.HeuristicWeight
          f_score=g_score+h_score
--[[local rx=tmp.X-(5328)
local ry=tmp.Y-(3672)
debug_str=debug_str.."Canvas.SetPixel("..ScreenResX/2-17+rx..", "..ScreenResY/2+5+ry..", "..math.abs(math.mod(math.floor(ndistance/distance*0xff)   +   Bit.Shl(0xff-math.floor(ndistance/distance*0xff),8)     +   Bit.Shl(math.mod(g_score,0xff),16),0xffffff))..")" 
if not getatom("MREAtom") then setatom("MREAtom",debug_str.."setatom('MREAtom',false)") debug_str="" end
--while getatom("MREAtom") do end ]]   
          --If the cost to move to this tile is less then all checked prior, Set this node as the next in line.
          if f_score < node.f_score then node.g_score=g_score node.h_score=h_score node.f_score=f_score node.next=current end
          if not node.onOpenList then
            if node.position==finish.position then 
              node.next=current 
              local path,temp={},{}
              while node do  
                table.insert(path,node.position)  
                node = node.next
              end
              for i=#path,1,-1 do table.insert(temp,path[i]) end
              self.path=temp
              return temp        
            end
            node.onOpenList = true
            OpenList:Add(node) 
          end 
        end  
      end
    end
  end
    print("return nil")
    return nil --no path found
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