--TODO:
-- Add "see through" terrain
--
dofile(getinstalldir().."Scripts/wvanderzalm/Class.lua") 
dofile(getinstalldir().."Scripts/wvanderzalm/Tile.lua")  

Point3D=class()

function Point3D:__init(X,Y,Z)
  if type(X)=="table" then
    self.X=X.X
    self.Y=X.Y
    self.Z=X.Z
  else
    self.X=X
    self.Y=Y
    self.Z=Z
  end
end                                                                               
Point3D.__eq = function(op1,op2) return op1.X==op2.X and op1.Y==op2.Y and op1.Z==op2.Z end
Point3D.__add = function(op1,op2) return Point3D(op1.X+op2.X,op1.Y+op2.Y,op1.Z+op2.Z) end
Point3D.__sub = function(op1,op2) return Point3D(op1.X-op2.X,op1.Y-op2.Y,op1.Z-op2.Z) end

function NumberBetween(n,bound1,bound2,allowance)
  if bound1>bound2 then 
    local swap=bound1
    bound1=bound2
    bound2=swap
  end
  return (n<bound2+allowance and n>bound1-allowance)
end

function InRange(p1,p2,range)
  return ( p1.X >= (p2.X - range) )and( p1.X <= (p2.X + range) )and( p1.Y >= (p2.Y - range) )and( p1.Y <= (p2.Y + range) )
end

function Round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function GetPoint(o,qtype)
  local p=Point3D(o.X,o.Y,o.Z) 
  if qtype=="mobile" then
    p.Z=p.Z+14--eye? 15 : 10-- what? runuo dev speak!/?
  elseif type(qtype)=="number" then
    local name,flags,height=GetStaticTileData(qtype)
    p.Z=p.Z+height/2+1
  elseif qtype=="Land" then
    local avg,low,top=GetAverageZ(o.X,o.Y) 
    p.Z=top+1
  elseif qtype=="Point3D" then
    --return unchanged
  else
    print("Waring: invalid object in line of sight") 
    p=Point3D(0,0,0)
  end
  return p
end


MaxLOSDistance=25 --?

function LineOfSight(org,dest)
  if org == dest then return true end
  if not InRange(org,dest,MaxLOSDistance) then
    return false
  end
  
  local start=Point3D(org)
  local finish=Point3D(dest)
  
  if ( org.X > dest.X or (org.X==dest.X and org.Y>dest.Y) or (org.X == dest.X and org.Y==dest.Y and org.Z > dest.Z) ) then
    local swap = Point3D(org)
    org=Point3D(dest)
    dest=Point3D(swap)
  end
  
  local rise,run,zslp
  local sq3d
  local x,y,z
  local xd,yd,zd
  local ix,iy,iz
  local height
  local found
  local p=Point3D(0,0,0)
  local path={}
  local flags
    
  if #path > 0 then path={} end
  
  xd=dest.X-org.X
  yd=dest.Y-org.Y
  zd=dest.Z-org.Z
  zslp=math.sqrt(xd*xd+yd*yd)
  if zd~=0 then
    sq3d=math.sqrt(zslp*zslp+zd*zd)
  else
    sq3d=zslp
  end
  
  rise=yd/sq3d
  run=xd/sq3d
  zslp=zd/sq3d
  
  y=org.Y
  x=org.X
  z=org.Z
  while NumberBetween(x,dest.X,org.X,0.5) and NumberBetween(y,dest.Y,org.Y,0.5) and NumberBetween(z,dest.Z,org.Z,0.5) do
    ix=Round(x)
    iy=Round(y)
    iz=Round(z)
    if #path > 0 then
      p=Point3D(path[#path])
      if p.X~=ix or p.Y ~=iy or p.Z ~= iz then
        table.insert(path,{X=ix,Y=iy,Z=iz})
      end
    else
      table.insert(path,{X=ix,Y=iy,Z=iz})
    end
    x= x+run
    y= y+rise
    z= z+zslp
  end  

  
  if table.getn(path) == 0 then
    return true end --should never happen, but to be safe.
  
  p=Point3D(path[#path])
  
  if p~=dest then
    table.insert(path,dest)
  end
  
  local pTop=Point3D(org)
  local pBottom=Point3D(dest)
  if pBottom.X < pTop.X then local swap=pTop.X pTop.X=pBottom.X pBottom.X=swap end 
  if pBottom.Y < pTop.Y then local swap=pTop.Y pTop.Y=pBottom.Y pBottom.Y=swap end
  if pBottom.Z < pTop.Z then local swap=pTop.Z pTop.Z=pBottom.Z pBottom.Z=swap end
  
  local pathCount=#path
  
  for i=1,pathCount do
    local point=Point3D(path[i])
    
    local landtile=GetLandTileID(point.X,point.Y) 
    local landAvg,landZ,landTop=GetAverageZ(point.X,point.Y) 
    local landflag=WorldTiles[point.X][point.Y][1][4]
--landTile.Ignored read along this line... need this for both this script AND pathfinding... Must include all land tiles that you can walk
--through,... cave enterances and such.
    if landZ <= point.Z and landTop >= point.Z and (point.X~=finish.X or point.Y~=finish.Y or landZ>finish.Z or landTop < finish.Z) then --and not landTile.Ignored 
      return false
    end
    
    --/* --Do land tiles need to be checked?  There is never land between two people, always statics.--
    --if ( landZ-1>=point.Z and landZ+1 <= point.Z and Bit.And(landflag,math.pow(2,6))~=0 ) then
    --  return false
    --end
    local statics = TileCnt(point.X,point.Y)
    if statics>1 then
      for j=2,statics do
        local id=WorldTiles[point.X][point.Y][j][1] --id,z,Name,Flags,Height  
        local z=WorldTiles[point.X][point.Y][j][2]
        local flags=WorldTiles[point.X][point.Y][j][4]
        local height=0
        if Bit.And(flags,math.pow(2,10)) ~= 0 then  --CalcHeight()
          height=WorldTiles[point.X][point.Y][j][5]/2
        else                                   
          height=WorldTiles[point.X][point.Y][j][5]      
        end
        if z<=point.Z and z+height>=point.Z and Bit.And(flags,Bit.Or(math.pow(2,12),math.pow(2,13)))~=0 then --(flags & (TileFlag.Window | TileFlag.NoShoot))
          if not(point.X==finish.X and point.Y==finish.Y and z<=finish.Z and z+height>=finish.Z) then
            return false
          end
        --Walls roofs and surfaces at anyother z??? \/  \/  \/
        --[[if z<=point.Z and z+height>=point.Z and Bit.And(flags,math.pow(2,12))==0 and Bit.And(flags,math.pow(2,13))~=0
          and ( Bit.And(flags,math.pow(2,4))~=0 or Bit.And(flags,math.pow(2,28))~=0 or (Bit.And(flags,math.pow(2,9))~=0 and zd~=0) ) then
          if not(point.X==finish.X and point.Y==finish.Y and z<=finish.Z and z+height>=finish.Z) then
            return false
          end
          end ]]
        end
      end
    end
  end 

---------------------------------------------------------------------------
--[[ Dynamic Objects! ]]---------------------------------------------------
---------------------------------------------------------------------------   
  local area={}
  local nCnt = UO.ScanItems(false)
  if nCnt > 0 then
    for i=0,nCnt-1 do 
      local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      --Not in container, in the area, and an item, stack==0
      if nContID==0 and nStack~=0 and nX>=pTop.X and nX<=pBottom.X and nY>=pTop.Y and nY<=pBottom.Y then
        table.insert(area,{Type=nType,X=nX,Y=nY,Z=nZ})
      end
    end
    if #area > 0 then
      for i=1,#area do
        local id=area[i].Type
        local name,flags,height=GetStaticTileData(id)--Name, Flags, Height, Weight, Quality
        if Bit.And(flags,Bit.Or(math.pow(2,12),math.pow(2,13)))~=0 then
          if Bit.And(flags,math.pow(2,10)) ~= 0 then  --CalcHeight()
            height=height/2     
          end
          local count=#path 
          local loc=Point3D(area[i].X,area[i].Y,area[i].Z)
          for j=1,count do 
            local point=Point3D(path[j])
            if loc.X==point.X and loc.Y==point.Y and loc.Z<=point.Z and loc.Z+height>=point.Z then
              if not (loc.X==finish.X and loc.Y==finish.Y and loc.Z<=finish.Z and loc.Z+height>=finish.Z) then  
                return false
              end 
            end
          end
        end  
      end
    end
  end
  return true
end






--[[while true do

local charpos=Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ)
local targpos=Point3D(UO.LTargetX,UO.LTargetY,UO.LTargetZ)

local str=""
for x=-4,4 do for y=-4,4 do
targpos=Point3D(UO.CharPosX+x,UO.CharPosY+y,GetAverageZ(UO.CharPosX+x,UO.CharPosY+y))--GetAverageZ(UO.CharPosX+x,UO.CharPosX+y))
if LineOfSight(  GetPoint(charpos,"mobile"),GetPoint(targpos,"Land")  ) then
  local zs=GetLandMatrixZ(targpos.X,targpos.Y)
  str=str.."DrawSqrRelXYZ4("..targpos.X..","..targpos.Y..","..zs[1]..","..zs[2]..","..zs[3]..","..zs[4]..",255000,1,3)"
end

end end

setatom("MREAtom",str.."setatom('MREAtom',false)")
while getatom("MREAtom") do end  

while charpos==Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ) do
end

end

stop()
local oldx=UO.LTargetX
local oldY=UO.LTargetY
local oldID=UO.LTargetID

while true do
local LTargetType
if UO.LTargetKind==3 then  
  LTargetType=UO.LTargetTile 
elseif UO.LTargetKind==2 then
  LTargetType="Land" 
elseif UO.LTargetKind==1 then
  local nCnt = UO.ScanItems(false)
  for i=0,nCnt-1 do
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
    if nID==UO.LTargetID then
      if nStack==0 then
        LTargetType="mobile"  
        UO.LTargetX=nX
        UO.LTargetY=nY
        UO.LTargetZ=nZ
      else
        LTargetType=nType
      end
      break
    end
  end
else
  LTargetType=UO.LTargetTile
end
local charpos=Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ)
local targpos=Point3D(UO.LTargetX,UO.LTargetY,UO.LTargetZ)
if math.abs(charpos.X-targpos.X)<=9 and math.abs(charpos.Y-targpos.Y)<=9 then
if LineOfSight(  GetPoint(charpos,"mobile"),GetPoint(targpos,LTargetType)  ) then
  UO.ExMsg(UO.CharID,"T")  
else                                                   
  UO.ExMsg(UO.CharID,"F")
end
end
   while oldx==UO.LTargetX and oldY==UO.LTargetY and oldID==UO.LTargetID do
   end 
  oldx=UO.LTargetX
  oldY=UO.LTargetY
  oldID=UO.LTargetID
  
setatom("MREAtom","clrscr()".."setatom('MREAtom',false)")
while getatom("MREAtom") do end  
  
end   
]]--