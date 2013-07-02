dofile(getinstalldir().."Scripts/wvanderzalm/Tile.lua")

function IsOK(X,Y,ignoredoors,ignorespellfields,ourz,ourtop)  
  local XCheck,YCheck=X,Y
  local TileCnt=TileCnt(XCheck,YCheck,UO.CursKind)
  for i=2,TileCnt do
    local CalcTop=0
    local StaticTile={
    ID=WorldTiles[XCheck][YCheck][i][1],
    Flags=WorldTiles[XCheck][YCheck][i][4],
    Z=WorldTiles[XCheck][YCheck][i][2],
    Height=WorldTiles[XCheck][YCheck][i][5]}
    if Bit.And(StaticTile.Flags,Flags.Bridge)~=0 then
      CalcTop=StaticTile.Z+math.floor(StaticTile.Height/2)
    else
      CalcTop=StaticTile.Z+StaticTile.Height
    end
    if Bit.And(StaticTile.Flags,Flags.Impassable)~=0 or Bit.And(StaticTile.Flags,Flags.Surface)~=0 then
      if CalcTop>ourz and ourtop>StaticTile.Z then return false end
    end
  end
  if DynamicItems[XCheck] and DynamicItems[XCheck][YCheck] then
    for i=1,#DynamicItems[XCheck][YCheck] do   
      local CalcTop=0
      local DynamicTile={
      ID=DynamicItems[XCheck][YCheck][i][1],
      Flags=DynamicItems[XCheck][YCheck][i][4],
      Z=DynamicItems[XCheck][YCheck][i][2],
      Height=DynamicItems[XCheck][YCheck][i][5]}     
      if Bit.And(DynamicTile.Flags,Flags.Bridge)~=0 then
        CalcTop=DynamicTile.Z+math.floor(DynamicTile.Height/2)
      else
        CalcTop=DynamicTile.Z+DynamicTile.Height
      end  
      if Bit.And(DynamicTile.Flags,Flags.Impassable)~=0 or Bit.And(DynamicTile.Flags,Flags.Surface)~=0 then 
        if ignoredoors and ( Bit.And(DynamicTile.Flags,Flags.Door)~=0 or DynamicTile.ID==0x692 or DynamicTile.ID==0x846 or DynamicTile.ID==0x873 or (DynamicTile.ID>=0x6f5 and DynamicTile.ID<=0x6f6) ) then
        else--continue
          if ignorespellfields and ( DynamicTile.ID==0x82 or DynamicTile.ID==3946 or DynamicTile.ID==0x3956) then
          else--continue       
            if Bit.And(DynamicTile.Flags,Flags.Bridge)~=0 then calcheight=DynamicTile.Height/2 else calcheight=DynamicTile.Height end
            if CalcTop>ourz and ourtop>DynamicTile.Z then return false end 
          end--continue
        end--continue
      end
    end
  end
  return true
end
function GetStartZ(X,Y,Z)
  local XCheck,YCheck=X,Y
  local TileCnt=TileCnt(XCheck,YCheck,UO.CursKind)
  local ZCenter,ZLow,ZTop=0,0,0
  local isSet=false  
--LandTiles-----------------------------------------------  
  local LandTile={
  ID=WorldTiles[XCheck][YCheck][1][1],
  Flags=WorldTiles[XCheck][YCheck][1][4]}
  LandTile.Center,LandTile.Z,LandTile.Top=GetAverageZ(XCheck,YCheck) 
  LandTile.Ignore=IgnoreLand[LandTile.ID]~=nil
  LandTile.Blocks=Bit.And(LandTile.Flags,Flags.Impassable)~=0
  if not LandTile.Ignore and not LandTile.Blocks and Z>=LandTile.Center then
    ZLow=LandTile.Z
    ZCenter=LandTile.Center
    if not isSet or LandTile.Top>ZTop then
      ZTop=LandTile.Top
    end
    isSet=true
  end
--StaticTiles-----------------------------------------------  
  for i=2,TileCnt do
    local CalcTop=0
    local StaticTile={
    ID=WorldTiles[XCheck][YCheck][i][1],
    Flags=WorldTiles[XCheck][YCheck][i][4],
    Z=WorldTiles[XCheck][YCheck][i][2],
    Height=WorldTiles[XCheck][YCheck][i][5]}
    if Bit.And(StaticTile.Flags,Flags.Bridge)~=0 then
      CalcTop=StaticTile.Z+math.floor(StaticTile.Height/2) 
    else
      CalcTop=StaticTile.Z+StaticTile.Height
    end
    if (not isSet or CalcTop>=ZCenter) and Bit.And(StaticTile.Flags,Flags.Surface)~=0 and Z>=CalcTop then
      ZLow=StaticTile.Z
      ZCenter=CalcTop
      local top=StaticTile.Z+StaticTile.Height
      if not isSet or top>ZTop then
        ZTop=top
      end
      isSet=true
    end         
  end
--DynamicTiles-----------------------------------------------  
  if DynamicItems[XCheck] and DynamicItems[XCheck][YCheck] then
    for i=1,#DynamicItems[XCheck][YCheck] do
      local CalcTop=0
      local DynamicTile={
      ID=DynamicItems[XCheck][YCheck][i][1],
      Flags=DynamicItems[XCheck][YCheck][i][4],
      Z=DynamicItems[XCheck][YCheck][i][2],
      Height=DynamicItems[XCheck][YCheck][i][5]}  
      --  table.insert(DynamicItems[x][y],{nType,z,Name,Flags,Height})
      if Bit.And(DynamicTile.Flags,Flags.Bridge)~=0 then
        CalcTop=DynamicTile.Z+math.floor(DynamicTile.Height/2)
      else
        CalcTop=DynamicTile.Z+DynamicTile.Height
      end
      if (not isSet or CalcTop>=ZCenter) and Bit.And(DynamicTile.Flags,Flags.Surface)~=0 and Z>=CalcTop then
        ZLow=DynamicTile.Z
        ZCenter=CalcTop
        local top=DynamicTile.Z+DynamicTile.Height
        if not isSet or top>ZTop then
          ZTop=top
        end
        isSet=true
      end 
    end
  end
  if not isSet then
    ZLow=Z
    ZTop=Z
  elseif Z>ZTop then
    ZTop=Z
  end
  return ZLow, ZTop
end
function Check(Start,X,Y,IgnoreDoors,IgnoreSpellFeilds)
  local NewZ,NewType=0,0
  local TileCnt=TileCnt(X,Y,UO.CursKind)
--LandTiles-----------------------------------------------  
  local LandTile={
  ID=WorldTiles[X][Y][1][1],
  Flags=WorldTiles[X][Y][1][4]}
  LandTile.Center,LandTile.Z,LandTile.Top=GetAverageZ(X,Y) 
  LandTile.Ignore=IgnoreLand[LandTile.ID]~=nil
  LandTile.Blocks=Bit.And(LandTile.Flags,Flags.Impassable)~=0

  local MoveIsOk=false
  local StepTop=Start.Top+StepHeight
  local CheckTop=Start.Z+PersonHeight
  
 -- local IgnoreDoors=true
 -- local IgnoreSpellFeilds=false
  
--StaticTiles-----------------------------------------------  
  for i=2,TileCnt do
    local CalcTop=0
    local StaticTile={
    ID=WorldTiles[X][Y][i][1],
    Flags=WorldTiles[X][Y][i][4],
    Z=WorldTiles[X][Y][i][2],
    Height=WorldTiles[X][Y][i][5]}
    if Bit.And(StaticTile.Flags,Flags.Bridge)~=0 then
      CalcTop=StaticTile.Z+math.floor(StaticTile.Height/2) ---------------Round?
    else
      CalcTop=StaticTile.Z+StaticTile.Height
    end
    if Bit.And(StaticTile.Flags,Flags.Surface)~=0 and Bit.And(StaticTile.Flags,Flags.Impassable)==0 then
      local TestTop=CheckTop
      local ItemTop=StaticTile.Z 
      local cmp=math.abs(CalcTop-Start.Z) - math.abs(NewZ-Start.Z)
      if MoveIsOk and (cmp > 0 or (cmp==0 and CalcTop>NewZ)) then
        --continue    **************-*-**-*-*-*-*-*-*-**-*-*-*-
      else 
        if CalcTop + PersonHeight > TestTop then
          TestTop=CalcTop + PersonHeight
        end
        if Bit.And(StaticTile.Flags,Flags.Bridge)==0 then
          ItemTop=ItemTop+StaticTile.Height
        end
        if StepTop>=ItemTop then
          local LandCheck=StaticTile.Z
          if StaticTile.Height>=StepHeight then
            LandCheck=LandCheck+StepHeight
          else
            LandCheck=LandCheck+StaticTile.Height
          end
          if not LandTile.Ignore and LandCheck < LandTile.Center and LandTile.Center > CalcTop and TestTop>LandTile.Z then
            --Continue---- -*-*-*--**-*-*-*-*-*-*-*-*-*--**-
          else
            if IsOK(X,Y,IgnoreDoors, IgnoreSpellFields,CalcTop,TestTop) then
              NewZ=CalcTop
              NewType=0x4000+StaticTile.ID
              MoveIsOk=true
            end
          end
        end
      end
    end   
  end
--DynamicTiles-----------------------------------------------  
  if DynamicItems[X] and DynamicItems[X][Y] then
    for i=2,#DynamicItems[X][Y] do
      local CalcTop=0
      local DynamicTile={
      ID=DynamicItems[X][Y][i][1],
      Flags=DynamicItems[X][Y][i][4],
      Z=DynamicItems[X][Y][i][2],
      Height=DynamicItems[X][Y][i][5]}
      if Bit.And(DynamicTile.Flags,Flags.Bridge)~=0 then
        CalcTop=DynamicTile.Z+math.floor(DynamicTile.Height/2)
      else
        CalcTop=DynamicTile.Z+DynamicTile.Height
      end
      if Bit.And(DynamicTile.Flags,Flags.Surface)~=0 and Bit.And(DynamicTile.Flags,Flags.Impassable)==0 then
        local TestTop=CheckTop
        local ItemTop=DynamicTile.Z 
        local cmp=math.abs(CalcTop-Start.Z) - math.abs(NewZ-Start.Z)
        if MoveIsOk and (cmp > 0 or (cmp==0 and CalcTop>NewZ)) then
          --continue    **************-*-**-*-*-*-*-*-*-**-*-*-*-
        else 
          if CalcTop + PersonHeight > TestTop then
            TestTop=CalcTop + PersonHeight
          end
          if Bit.And(DynamicTile.Flags,Flags.Bridge)==0 then
            ItemTop=ItemTop+DynamicTile.Height
          end
          if StepTop>=ItemTop then
            local LandCheck=DynamicTile.Z
            if DynamicTile.Height>=StepHeight then
              LandCheck=LandCheck+StepHeight
            else
              LandCheck=LandCheck+DynamicTile.Height
            end
            if not LandTile.Ignore and LandCheck < LandTile.Center and LandTile.Center > CalcTop and TestTop>LandTile.Z then
              --Continue---- -*-*-*--**-*-*-*-*-*-*-*-*-*--**-
            else
              if IsOK(X,Y,IgnoreDoors, IgnoreSpellFields,CalcTop,TestTop) then
                NewZ=CalcTop             
                NewType=0x4000+DynamicTile.ID
                MoveIsOk=true
              end
            end
          end
        end
      end   
    end
  end
  if not LandTile.Ignore and not LandTile.Blocks and StepTop>=LandTile.Z then
    local TestTop=CheckTop
    if LandTile.Center + PersonHeight > TestTop then
      TestTop=LandTile.Center + PersonHeight 
    end
    local ShouldCheck=true
    if MoveIsOk then 
      local cmp=math.abs(LandTile.Center-Start.Z) - math.abs(NewZ-Start.Z)
      if cmp > 0 or (cmp==0 and LandTile.Center>NewZ) then
        ShouldCheck=false
      end
    end
    if ShouldCheck and IsOK(X,Y,IgnoreDoors,IgnoreSpellFields,LandTile.Center,TestTop) then
      NewZ=LandTile.Center
      NewType=LandTile.ID
      MoveIsOk=true
    end   
  end
  return MoveIsOk, NewZ, NewType
end

function Offset(Direction, x, y )
  if Direction==0 then return x  , y-1 end
  if Direction==4 then return x  , y+1 end  
  if Direction==6 then return x-1, y   end
  if Direction==2 then return x+1, y   end
  if Direction==1 then return x+1, y-1 end
  if Direction==5 then return x-1, y+1 end
  if Direction==3 then return x+1, y+1 end
  if Direction==7 then return x-1, y-1 end
  return x, y
end

function CheckMovement(X,Y,Z,Direction,IgnoreDoors,IgnoreSpellFeilds)
  local CheckDiagonals = Bit.And(Direction,0x1)==0x1
  local XStart=X
  local YStart=Y
  local XForward,YForward = Offset(Direction,XStart,YStart)  
  local XRight,YRight = Offset(Bit.And(Direction+1,0x7),XStart,YStart)   
  local XLeft,YLeft = Offset(Bit.And(Direction-1,0x7),XStart,YStart)
  local StartZ,StartTop=GetStartZ(XStart,YStart,Z) 
  local MoveIsOk, NewZ, NewType=Check({X=XStart,Y=YStart,Z=StartZ,Top=StartTop},XForward,YForward,IgnoreDoors,IgnoreSpellFeilds)
  if MoveIsOk and CheckDiagonals then
    if not Check({X=XStart,Y=YStart,Z=StartZ,Top=StartTop},XLeft,YLeft,IgnoreDoors,IgnoreSpellFeilds) or not Check({X=XStart,Y=YStart,Z=StartZ,Top=StartTop},XRight,YRight,IgnoreDoors,IgnoreSpellFeilds) then
      MoveIsOk=false
    end
  end             
  if not MoveIsOk then
    NewZ=StartZ
  end
  return MoveIsOk, NewZ, NewType
end