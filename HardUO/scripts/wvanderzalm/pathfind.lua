------------------------------------
-- Script Name: Pathfind.lua
-- Author: Wesley Vanderzalm
-- Version: 1.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestServer
-- Revision Date: 
-- Public Release: March 28 2011
-- Purpose: Find a way from A -> B
------------------------------------
dofile(getinstalldir().."scripts/wvanderzalm/pathfind/pathfinder.lua")            
   
function Pathfind(x,y,z,t,PathGravity)   
  --if UO.CharPosX==x and UO.CharPosY==y and UO.CharPosZ==z then return true end
  local totaltime=0
  local P=PathFinder()
  local timer = getticks()                   
  --path = P:FindPath({1365,1752,10}, {x,y,z},t,PathGravity)
  path = P:FindPath({UO.CharPosX,UO.CharPosY,UO.CharPosZ}, {x,y,z},UO.CharDir,t,PathGravity)
  print("Pathfound in: "..((getticks()-timer)/1000).." Seconds")
  if path == nil then return false end
  if path == "Error : Ending is not passable!" then print("Error : Ending is not passable!") return false end
  if path == "Error : Start is not passable!" then print("Error : Start is not passable!") return false end
  if path==true then return true end
  print("Time Spent inside PositionIsFree(): "..(totaltime/1000).." Seconds")
--               

--[[--
  local Radar={}
  for i=0,999 do local sName,nX,nY = UO.GetCont(i)
    if sName == "radar gump" then Radar={X=nX,Y=nY} break end
    if sName==nil then break end
  end 
  local str=""
  for i=1,#path do
    local rx=path[i].X-UO.CharPosX
    local ry=path[i].Y-UO.CharPosY
    str=str.."Canvas.SetPixel(Window.X-UO.CliLeft+140+"..rx-ry+Radar.X..", Window.Y-UO.CliTop+140+"..rx+ry+Radar.Y..", "..(0   +   Bit.Shl(255,8)     +   Bit.Shl(255,16))..")" 
    
    str=str.."DrawSqrRelXYZ4("..path[i].X..","..path[i].Y..","..path[i].Z..","..path[i].Z..","..path[i].Z..","..path[i].Z..",255,1,1) "    
    if path[i].Height~=0 then
      local top=path[i].Z
      str=str.."DrawSqrRelXYZ4("..path[i].X..","..path[i].Y..","..top..","..top..","..top..","..top..",255000,1,1) "
    end
    if path[i].Ceil~=2147483647 then
      local top=path[i].Z
      str=str.."DrawSqrRelXYZ4("..path[i].X..","..path[i].Y..","..top..","..top..","..top..","..top..","..(0   +   Bit.Shl(0,8)     +   Bit.Shl(255,16))..",1,1) "
    end
    
  end
  setatom("MREAtom",str.."setatom('MREAtom',false)")
  while getatom("MREAtom") do end    
--stop()
  pause() 
----   ]]

  while P:Next() do end      
end 

   --Pathfind(1815,2822,0,0,true)--inside trinsic bank  
   --Pathfind(656,819,0,0,true)--
  -- Pathfind(1826,2780,0,0,true)--outside trinsic gate(west)
  --Pathfind(1169,2220,1,0)--maze
  --Pathfind(1477,1612,20,0)
  --Pathfind(UO.LTargetX,UO.LTargetY,UO.LTargetZ,0)
--Call DynamicsReset() to clear the list of dynamic objects
--This is not really nesseary, unless the code is used for extended periods of time.
--DynamicsReset() 