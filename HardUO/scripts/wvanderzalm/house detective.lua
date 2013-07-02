
  local f = openfile(getinstalldir().."scripts/wvanderzalm/MapFiles/"..UO.Shard.."-HousingCache.lua")
  if f then                                 
    f:close()                 
    dofile(getinstalldir().."scripts/wvanderzalm/MapFiles/"..UO.Shard.."-HousingCache.lua")
    print("House Cache file for \""..UO.Shard.."\" has been loaded...")
  else        
    local f = openfile(getinstalldir().."scripts/wvanderzalm/MapFiles/"..UO.Shard.."-HousingCache.lua","w+b")
    f:write("HouseItems={}")
    f:close()                                  
    dofile(getinstalldir().."scripts/wvanderzalm/MapFiles/"..UO.Shard.."-HousingCache.lua")
    print("House Cache file for \""..UO.Shard.."\" has been CREATED!")
  end








function IsInside(xc,yc,x,y,x2,y2)
  if x>x2 then local temp=x x=x2 x2=temp end
  if y>y2 then local temp=y y=y2 y2=temp end
  if xc>=x and xc<=x2 and yc>=y and yc<=y2 then return true end
  return false
end    

    
function GuessHouseArea(HouseItem)
  local Sign={}
  local ClosestSign={X=-9,Y=9,Z=0}
  HouseItem.State=false 
   
  
  for i=1,#SignItems do  
    if (SignItems[i].X-HouseItem.X>=ClosestSign.X and SignItems[i].X-HouseItem.X<6) and (SignItems[i].Y-HouseItem.Y<=ClosestSign.Y and SignItems[i].Y-HouseItem.Y>2) then
      local isset=false  
      --Sign already attached to a house?           
    --  for j=1,#HouseSignList do if HouseSignList[j].SignID==nID then isset=true end end  
      for j=1,#HouseItems do if HouseItems[j]~= HouseItem and HouseItems[j].State=="certain" and HouseItems[j].SignID==SignItems[i].ID then isset=true end end
      if not isset then
        --Is there a House Between this sign and the house object?
        for j=1,#HouseItems do if HouseItems[j].X~=HouseItem.X and HouseItems[j].Y~=HouseItem.Y and IsInside(HouseItems[j].X,HouseItems[j].Y,HouseItem.X,HouseItem.Y,SignItems[i].X,SignItems[i].Y) then isset=true end end
        --No? ok then use this sign.
        if not isset then ClosestSign=SignItems[i] end
      end
    end
  end 
  
  
  if ClosestSign.X==-9 then          
    --local nCnt = UO.ScanItems(false)
    --assume 24x24 Keep? or 18x18 plot?
    local CastleDoor1=false
    local CastleDoor2=false        
        
    CastleDoor1=DynamicItemSearchType(HouseItem.X,HouseItem.Y-11,{0x0675,0x0684})
    if not CastleDoor1 then     
      CastleDoor1=DynamicItemSearchType(HouseItem.X,HouseItem.Y+5,{0x0675,0x0684})
      if not CastleDoor1 then                                          
        CastleDoor1=DynamicItemSearchType(HouseItem.X,HouseItem.Y+11,{0x0675,0x0684})
        if not CastleDoor1 then                                               
          CastleDoor1=DynamicItemSearchType(HouseItem.X,HouseItem.Y+15,{0x0675,0x0684})
        end 
      end 
    end     
    if CastleDoor1 then
      CastleDoor2=DynamicItemSearchType(HouseItem.X-1,HouseItem.Y-11,{0x0675,0x0684})
      if not CastleDoor2 then                                     
        CastleDoor2=DynamicItemSearchType(HouseItem.X+1,HouseItem.Y+5,{0x0675,0x0684})  
        if not CastleDoor2 then                                     
          CastleDoor2=DynamicItemSearchType(HouseItem.X+1,HouseItem.Y+11,{0x0675,0x0684})   
          if not CastleDoor2 then                                     
            CastleDoor2=DynamicItemSearchType(HouseItem.X+1,HouseItem.Y+15,{0x0675,0x0684})
          end
        end
      end
    end   
    if CastleDoor1 and CastleDoor2 then   
      ClosestSign={X=HouseItem.X+5,Y=HouseItem.Y+17,Z=HouseItem.Z+16,ID=0}
      HouseItem.State="certain"
    else
      ClosestSign={X=HouseItem.X-8,Y=HouseItem.Y-8,Z=HouseItem.Z,ID=0} 
      HouseItem.State="uncertain"
    end
  end--return false end  
  
  
 -- table.insert(HouseSignList,{SignID=ClosestSign.ID})  
  local difX=HouseItem.X-(ClosestSign.X) 
  local difY=HouseItem.Y-(ClosestSign.Y-1) 
  local difZ=ClosestSign.Z-HouseItem.Z     

---------------------------------------------------------------------------
--[[ Classic House Guessing! ]]--------------------------------------------
---------------------------------------------------------------------------
  if ClosestSign.X>=HouseItem.X then    
-- MISSING STILL TODO:!:!:
---------- large patio house 135<->141
---------- large marble patio house 150
--      
    local House={Width=0,Height=0}
    if difX==0 and difY==-7 and difZ==-3 then difX,difY,House.Width,House.Height,HouseItem.State=7,7,14,14,"certain" --Large Patio House     
    elseif difX==-4 and difY==-7 and difZ==16 then difX,difY,House.Width,House.Height,HouseItem.State=7,7,14,15,"certain" --Large Brick House 
    elseif difX==-2 and difY==-7 and difZ==16 then difX,difY,House.Width,House.Height,HouseItem.State=7,7,14,15,"certain" --Two Story Wood/Stone and Plaster House       
    elseif difX==-5 and difY==-7 and difZ==16 then difX,difY,House.Width,House.Height,HouseItem.State=7,7,16,15,"certain" --Large Tower  
    elseif difX==-5 and difY==-11 and difZ==16 then difX,difY,House.Width,House.Height,HouseItem.State=11,11,24,24,"certain" --Keep
    elseif difX==-5 and difY==-16 and difZ==16 then difX,difY,House.Width,House.Height,HouseItem.State=15,15,31,32,"certain" --Castle
    elseif difX==-1 and difY==-3 and difZ==5 then difX,difY,House.Width,House.Height,HouseItem.State=3,3,8,8,"certain" --Small Tower  
    elseif difX==-5 and difY==-7 and difZ==20 then difX,difY,House.Width,House.Height,HouseItem.State=3,6,8,13,"certain" --Log Cabin
    elseif difX==-4 and difY==-5 and difZ==24 then difX,difY,House.Width,House.Height,HouseItem.State=5,4,12,9,"certain" --Sandstone Patio House              
    elseif difX==-3 and difY==-7 and difZ==24 then difX,difY,House.Width,House.Height,HouseItem.State=5,5,11,12,"certain" --Villa
    elseif difX==-3 and difY==-3 and difZ==5 then difX,difY,House.Width,House.Height,HouseItem.State=3,3,7,8,"certain" --Small Mable Workshop        
    elseif difX==-3 and difY==-3 and difZ==7 then difX,difY,House.Width,House.Height,HouseItem.State=3,3,7,8,"certain" --Small Stone Workshop 
    elseif difX==-2 and difY==-3 and difZ==5 then difX,difY,House.Width,House.Height,HouseItem.State=3,3,7,8,"certain" --Small House
    else
      print("WRONG SIGN, Next")
      ClosestSign={X=HouseItem.X-9,Y=HouseItem.Y-9,Z=HouseItem.Z,ID=0}          
      difX=HouseItem.X-(ClosestSign.X) 
      difY=HouseItem.Y-(ClosestSign.Y-1) 
      difZ=ClosestSign.Z-HouseItem.Z  
      HouseItem.State="uncertain"
      House={Width=0,Height=0}
    end
    HouseItem.Area={X=HouseItem.X-difX,Y=HouseItem.Y-difY,X2=HouseItem.X-difX+House.Width,Y2=HouseItem.Y-difY+House.Height}
    HouseItem.SignID=ClosestSign.ID
    return HouseItem.State
  else
    difX=math.abs(difX) 
    difY=math.abs(difY) 
    HouseItem.Area={X=HouseItem.X-difX,Y=HouseItem.Y-difY,X2=HouseItem.X-difX+(difX+1)*2,Y2=HouseItem.Y-difY+(difY)*2+2}
    if HouseItem.State~="certain" and HouseItem.State~="uncertain" then HouseItem.State="nexttocertain" end
    HouseItem.SignID=ClosestSign.ID
    return HouseItem.State
  end   
  if not HouseItem.State then HouseItem.State="uncertain" end  
  HouseItem.Area={X=HouseItem.X-difX,Y=HouseItem.Y-difY,X2=HouseItem.X-difX+(difX+1)*2,Y2=HouseItem.Y-difY+(difY)*2+2}                                                                  
  HouseItem.SignID=ClosestSign.ID
  return HouseItem.State
end

function MultiRefresh() 
  for i=1,#HouseItems do  
    for j=1,#HouseItems do if HouseItems[j]~=HouseItems[i] and HouseItems[j].State=="certain" and 
    HouseItems[j].SignID==HouseItems[i].SignID then 
      HouseItems[i].SignID=nil 
      HouseItems[i].State="uncertain"
      HouseItems[i].Area={X=0,Y=0,X2=0,Y2=0}
      break
    end end
    if HouseItems[i].State=="uncertain" then  
      GuessHouseArea(HouseItems[i]) 
    end
  end
  
    if #HouseItems>0 then
      for i=1,#HouseItems do        
        if HouseItems[i].State~="uncertain" and HouseItems[i].State~="certain" then 
          for J=1,#HouseItems do            
            if HouseItems[J].State~="uncertain" and HouseItems[J].State~="certain" then
              if ((HouseItems[J].Area.Y<=HouseItems[i].Area.Y2 and HouseItems[J].Area.Y>=HouseItems[i].Area.Y) or (HouseItems[J].Area.Y2>=HouseItems[i].Area.Y and HouseItems[J].Area.Y2<=HouseItems[i].Area.Y2)) and HouseItems[J].Area.X==HouseItems[i].Area.X2 then
                HouseItems[i].Area.X2=HouseItems[i].Area.X2-1
              end
              if((HouseItems[J].Area.X<=HouseItems[i].Area.X2 and HouseItems[J].Area.X>=HouseItems[i].Area.X) or (HouseItems[J].Area.X2>=HouseItems[i].Area.X and HouseItems[J].Area.X2<=HouseItems[i].Area.X2)) and HouseItems[J].Area.Y2+4==HouseItems[i].Area.Y then
                HouseItems[i].Area.Y=HouseItems[i].Area.Y+1
              end
            end
          end
          for Y=HouseItems[i].Area.Y,HouseItems[i].Area.Y2-1 do
            if FindHouseBlockingTile(HouseItems[i].Area.X2,Y) then 
             HouseItems[i].Area.X2=HouseItems[i].Area.X2-1
              if HouseItems[i].State=="uncertainX" then 
                HouseItems[i].State="certain"            
              else
                HouseItems[i].State="uncertainY"
              end
            end
          end
          for X=HouseItems[i].Area.X,HouseItems[i].Area.X2 do
            if FindHouseBlockingTile(X,HouseItems[i].Area.Y-1) then 
             HouseItems[i].Area.Y=HouseItems[i].Area.Y+1
              if HouseItems[i].State=="uncertainY" then 
                HouseItems[i].State="certain"            
              else
                HouseItems[i].State="uncertainX"
              end
            end
          end
        end
      end
    end
  SaveHouseCache()
end

function FindHouseBlockingTile(x,y)
  local list = GetTiles(x,y)
  if list == false then
    return false
  end
  for i=1,list.Cnt do
    if not isPassible(list[i].Flags) then 
      return true
    end
  end
  return false
end
function SaveHouseCache()
  local f = openfile(getinstalldir().."scripts/wvanderzalm/MapFiles/"..UO.Shard.."-HousingCache.lua","w+b")
  f:write("HouseItems="..TableToString(HouseItems))
  f:close() 
end

--[[dofile(getinstalldir().."Scripts/wvanderzalm/std.lua") 
DynamicsReset() 
MultiRefresh()  
   

local px=0
local py=0 
str=""
while true do
wait(100)
  if px~=UO.CharPosX or py~=UO.CharPosY then 
    px=UO.CharPosX
    py=UO.CharPosY   
    DynamicsRefresh()
    MultiRefresh()
    if #HouseItems>0 then
      for i=1,#HouseItems do
        if math.abs(HouseItems[i].X-UO.CharPosX)<18 and math.abs(HouseItems[i].Y-UO.CharPosY)<18 then
        --str="DrawSqrRelXYZ("..Houses[i].X..","..Houses[i].Y..","..Houses[i].Z..", 255, 1, 1)"  
        if HouseItems[i].State=="uncertain" then Colour=255
        elseif HouseItems[i].State=="nexttocertain" then Colour=255   +   Bit.Shl(255,8) 
        elseif HouseItems[i].State=="uncertainX" then Colour=0   +   Bit.Shl(255,8) +   Bit.Shl(255,16)   --We have moved X boarder
        elseif HouseItems[i].State=="uncertainY" then Colour=255   +   Bit.Shl(255,8) +   Bit.Shl(255,16) --We have moved Y boarder
        else Colour=Bit.Shl(255,8)   +   Bit.Shl(0,16) end
        str=str.."DrawAreaRelXY("..HouseItems[i].Area.X ..","..HouseItems[i].Area.Y ..","..HouseItems[i].Area.X2-1 ..","..HouseItems[i].Area.Y2-1 ..","..Colour..",1,3)"
        
        

        if getatom("MREAtom") then
        
        else 
          setatom("MREAtom",str.."setatom('MREAtom',false)")
          str=""
        end 
 end
      end
    end
  end
end     ]]             
                 