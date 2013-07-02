------------------------------------
-- Script Name: Grid Map.lua
-- Author: Wesley Vanderzalm
-- Version: 2.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestShard
-- Revision Date: 
-- Public Release: TBA
-- Purpose: Grid Map
-- Copyright: 2011 Wesley Vanderzalm
------------------------------------
--######################
--####  Expansions  ####
--######################
if UO.CharPosX == 0 then print("Ultima Online Is Not Running!!") stop() end
print("Grid Map.lua init")
GRIDMAPINIT = true                                            
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")
dofile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/Grid Map Cmd.lua")  
dofile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/OreTypes.lua") 
dofile(getinstalldir().."scripts/wvanderzalm/Mining.lua")              
dofile(getinstalldir().."scripts/wvanderzalm/Fishing.lua")          
dofile(getinstalldir().."scripts/wvanderzalm/Lumberjacking.lua") 
dofile(getinstalldir().."scripts/wvanderzalm/Pathfind.lua")     
---------------------------------------------------------------------------
--[[ Declarations! ]]------------------------------------------------------
---------------------------------------------------------------------------
  HotKey_Mine={"F2",false,false,false} 
  HotKey_Smelt={"F5",false,false,false}                                  
  HotKey_Lumberjack={"F3",false,false,false}
  HotKey_Pathfind={"F6",false,false,false} 
  HotKey_Fish={"F4",false,false,false}
---------------------------------------------------------------------------
--[[ Declarations! ]]------------------------------------------------------
---------------------------------------------------------------------------
  Color_Resourcegrid = (0   +   Bit.Shl(255,8)   +   Bit.Shl(255,16))
  Color_Char =    (0   +   Bit.Shl(0,8)     +   Bit.Shl(255,16))
  Color_Cursor =  (255   +   Bit.Shl(255,8)   +   Bit.Shl(0,16))  
  Color_Resource= (255   +   Bit.Shl(0,8)   +   Bit.Shl(0,16))
  TransparentColorValue=0 --0xffffff
  White = 0xffffff
---------------------------------------------------------------------------
--[[ Declarations! ]]------------------------------------------------------
---------------------------------------------------------------------------
  local Version="1.0.0"   
  setatom("MREAtom",false)
  local SavedLocation=getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/RailData.txt"
  local SaveFileName="untitled" 
  local VarName = {"Label","X","Y","Z","Facet","Action","Col","Scale","Width"}
  local NodeIndex=900              
  local NodeListIndexOld=-1 
  local NodePropIndexOld=-1
  local ScreenResX=1680
  local ScreenResY=1050
  
  local MainFormClicked={Time=0,X=0,Y=0}
  ClientXRes = UO.CliXRes/2
  ClientYRes = UO.CliYRes/2  
  Nodes={}    
  Drawn={} --Holds Array of Drawn tiles on the matrix plane, Used to half the ammount of lines drawn    
  update=true
  if true then
    local a,b=getmouse()
    Window={X=a-UO.CursorX+UO.CliLeft ,Y=b-UO.CursorY+UO.CliTop}   
  end  
  local cursor_Timeout=0
  local OldPos={X=UO.CharPosX,Y=UO.CharPosY,CX=UO.CursorX,CY=UO.CursorY}
  local MousePos={X=0,Y=0}
  Radar={X=0,Y=0}
  local HeldStill=getticks()
  local UpdateMiningMatrix=true
  local UnderGround=false   
  
  path=nil 
  P=PathFinder() 
  for i=0,999 do local sName,nX,nY = UO.GetCont(i)
    if sName == "radar gump" then Radar={X=nX,Y=nY} break end
    if sName==nil then break end
  end 
  miningresult=false 
  miningloc={} 
  local OldPix={}     
  radardrawn={} 
  Hover=false  
  Busy_deg=0  
  

----------------------------------------------------------------------------------------------------------------------------------------
--[[ GUI ]]-----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------

  MainForm = Obj.Create("TForm")
  MainForm._ = {
	BorderStyle = 0,
	WindowState = 2,
	Color = TransparentColorValue,
        AlphaBlend=false,      --add option to adjust this..?
     --AlphaBlendValue=90,
	TransparentColor = true,
	TransparentColorValue = TransparentColorValue,
	OnClose = function() Obj.Exit() end,
  }
  MainForm.FormStyle = 3
  MainForm.Visible = true 
  --MainForm.Enabled = false
  MainForm.OnClick = function()
  local a,b=getmouse()
  MainFormClicked={Time=getticks(),X=a,Y=b}
  UO.Click(UO.CursorX,UO.CursorY,true,true,true,false)
  end
  Canvas	= MainForm.Canvas  
  Canvas.Font.Name =  "Arial" 
  Canvas.Font.Size =  12  
  Pen	= Canvas.Pen

--print("load editor")       
--dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid Map Editor.lua")
--dofile(getinstalldir().."Scripts/const.lua")

  local filter  = "Text Files (*.txt)|*.txt|Lua Files (*.lua)|*.lua|All Files (*.*)|*.*"

  LoadMenu = Obj.Create("TOpenDialog")
  LoadMenu.DefaultExt = "txt"
  LoadMenu.Filter = filter
  LoadMenu.InitialDir = getinstalldir().."scripts\\wvanderzalm\\OEUOA\\Rails"
  LoadMenu.Options = 0x200-- C.ofFileMustExist

  SaveMenu = Obj.Create("TSaveDialog")
  SaveMenu.DefaultExt = "txt"
  SaveMenu.Filter = filter
  SaveMenu.InitialDir = getinstalldir().."scripts\\wvanderzalm\\OEUOA\\Rails"
  SaveMenu.Options = 0x102-- C.ofPathMustExist+C.ofOverwritePrompt
	

  function Nodes_Save()   if #Nodes>0 then if SaveFileName~="untitled" then SaveData(SaveFileName,"Nodes="..TableToString(Nodes)) else Nodes_SaveAs() end end end
  function Nodes_SaveAs() if SaveMenu.Execute() then SaveFileName=SaveMenu.FileName SaveData(SaveMenu.FileName,"Nodes="..TableToString(Nodes)) end end
  function Nodes_Load()   if LoadMenu.Execute() then SaveFileName=LoadMenu.FileName dostring(LoadData(LoadMenu.FileName)) NodeListUpdate() clrscr() update=true end end
  function NodeListUpdate() NodeList.Clear() for i=1,#Nodes do NodeList.Items.Add(i.." : "..Nodes[i].Action) end NodePropList.Clear() end
  function NodePropEditUpdate()
    NodePropEdit.Clear()
    if NodePropList.ItemIndex ~= -1 then
      NodePropEdit.Text=tostring(Nodes[NodeList.ItemIndex+1][VarName[NodePropList.ItemIndex+1]])         
      NodePropListIndexOld=NodePropList.ItemIndex  
      NodePropEdit.SetFocus()
      NodePropEdit.SelectAll()
    end
  end
  function NodePropListUpdate()
    NodePropList.Clear()
    if NodeList.ItemIndex~= -1 then
      for i=1,#VarName do if Nodes[NodeList.ItemIndex+1] and Nodes[NodeList.ItemIndex+1][VarName[i]] then NodePropList.Items.Add(VarName[i] .. " : " .. Nodes[NodeList.ItemIndex+1][VarName[i]]) end end                          
      NodeListIndexOld=NodeList.ItemIndex                        
      NodePropListIndexOld=-1
    end
  end 
  function gethotkey(var) 
    if type(var)~="table" or #var < 4 or #var > 4 then return false end
    if not getkey(var[1]) then return false end
    if getkey("CTRL")~=var[2] then return false end
    if getkey("ALT")~=var[3] then return false end
    if getkey("SHIFT")~=var[4] then return false end
    return true
  end 


local RadarIcons={
Guilds={"Archers' Guild","Armaments Guild","Armourers' Guild","Assassins' Guild","Bardic Guild","Barters' Guild","Cavalry Guild","Cooks' Guild","Fighters' Guild","Fishermens' Guild",
"Healers' Guild","Illusionist Guild","Mages' Guild","Merchants' Guild","Miners' Guild","Provisioner Guild","Rogues' Guild","Sailors' Guild","Shipwrights' Guild","Sorcerer's Guild",
"Thieves' Guild","Tinkers' Guild","Traders' Guild","Warriors' Guild","Weapons Guild"},
Shops={"Armourer","Baker","Bank","Barber Shop","Bard","Beekeeper","Blacksmith","Bowyer","Brass Sign","Butcher","Carpenter","Customs","Fletcher","Healer","Inn","Jeweler","Library",
"Mage","Painter","Provisioner","Reagent Shop","Shipwright","Stable","Tailor","Tanner","Tavern","Theatre","Tinker"},
Topographic={"Body of Water","Bridge","City","Docks","Dungeon","Exit","Gate","Gem","Graveyard","Interest","Island","Landmark","Moongate","Point","Ruins","Scenic","Ship bata","Shrine",
"Stairs","Teleport","Terrain","Treasure","UOAM_Large","UOAM_Medium","UOAM_Small"},
}
BitMap_RadarIcons={
Guilds={},
Shops={},
Topographic={},
}
for i = 1,table.getn(RadarIcons.Guilds) do
  BitMap_RadarIcons.Guilds[i] = Obj.Create("TBitmap")  
  BitMap_RadarIcons.Guilds[i]._={Data = LoadData(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/MapIcons/"..RadarIcons.Guilds[i]..".bmp"),Transparent = true, TransparentColor = White }
end
for i = 1,table.getn(RadarIcons.Shops) do
  BitMap_RadarIcons.Shops[i] = Obj.Create("TBitmap")  
  BitMap_RadarIcons.Shops[i]._={Data = LoadData(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/MapIcons/"..RadarIcons.Shops[i]..".bmp"),Transparent = true, TransparentColor = White }
end
for i = 1,table.getn(RadarIcons.Topographic) do
  BitMap_RadarIcons.Topographic[i] = Obj.Create("TBitmap")  
  BitMap_RadarIcons.Topographic[i]._={Data = LoadData(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/MapIcons/"..RadarIcons.Topographic[i]..".bmp"),Transparent = true, TransparentColor = White }
end

function clrscr()
  --UpdateMiningMatrix=true
  UpdateMiningMatrix=false
  Pen.Color = TransparentColorValue
  Canvas.Brush.Color=TransparentColorValue
  Canvas.Rectangle(0,0,ScreenResX,ScreenResY)
  Drawn = {} 
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
--[[ MainLoop Ahead! ]]----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
Timer = Obj.Create("TTimer")
Timer.Interval = 1
Timer.Enabled = true
Timer.OnTimer = function() 
  if getkey("enter") then
    if GridMap_ResourceSize.Focused then update=true clrscr() end
  end            
  if Editor_View.Checked then  
    if NodeList.ItemIndex ~= -1 and NodeList.ItemIndex ~= NodeListIndexOld then NodePropListUpdate() end 
    if NodePropList.ItemIndex ~= -1 and NodePropList.ItemIndex ~= NodePropListIndexOld then NodePropEditUpdate() end 
    if getkey("enter") then 
      if NodePropEdit.Focused then Button_Apply.Click() end      
    end
  end  
  MainLoop()
  local str=getatom("MREAtom")
  if str then    
    print(str)
    atomtimeout=getticks()
    dostring(str)
    setatom("MREAtom",false)
  end
end

function MainLoop() 
  local CX=UO.CharPosX
  local CY=UO.CharPosY 
  local CZ=UO.CharPosZ  

--###################################################################################
--## Mining related subjects                                                       ##
--###################################################################################                                                
  local WeightStatus=CheckWeight()  
  local AutoMoveToBeetle={6583,6584,6585,6586,  --OreTypes
                          7154, --ingots
                          7133  --Logs
                          }


  if Mining_View.Checked then       
    if gethotkey(HotKey_Mine) or ( miningresult and ( Mining_Dry.Checked or Mining_Prospect.Checked ) ) then --or miningresult then  
      --print("Targeting Ground: "..UO.LTargetX..", "..UO.LTargetY..", "..UO.LTargetZ)                                          
      if gethotkey(HotKey_Mine) then miningresult=true 
        miningloc=FindResourceTile(CX+MousePos.X,CY+MousePos.Y,"ore")
        while miningloc do
          local CharPos=GetPoint(Point3D(CX,CY,CZ),"mobile")
          local TargPos={}
          if miningloc.Terrain then   
            TargPos=GetPoint(Point3D(miningloc.X,miningloc.Y,0),"Land")
          else                 
            TargPos=GetPoint(Point3D(miningloc.X,miningloc.Y,miningloc.Z),"Point3D")
          end
          
          if LineOfSight( CharPos,TargPos ) then break end
          if miningloc.Next.Next then miningloc=miningloc.Next else miningloc=false break end
        end     
      end--{X=CX+MousePos.X,Y=CY+MousePos.Y,Z=GetLandTileZ(CX+MousePos.X,CY+MousePos.Y)} end
      if miningloc==false then miningresult=false end 
      if Mining_Prospect.Checked and miningresult then      
        local X8x8 = math.floor(miningloc.X/8)
        local Y8x8 = math.floor(miningloc.Y/8)
        if ( OreMap[UO.CursKind] and OreMap[UO.CursKind][X8x8] and OreMap[UO.CursKind][X8x8][Y8x8] and OreMap[UO.CursKind][X8x8][Y8x8] > 1 ) then miningresult=false end
      end
      if miningresult=="depleted" then 
        if Beetle and Mining_Dry.Checked then Beetle:Mount() end 
        miningresult=false 
      end
      if miningresult=="timeout" then if Mining_Dry.Checked then miningresult=true else miningresult=false end end 
      if miningresult=="notools" then miningresult=false end
      if miningresult then miningresult=Mine(miningloc,Mining_MakeTools.Checked) end
    end 
  end 
  --###################################################################################
  --## Smelting related subjects                                                     ##
  --###################################################################################
  if gethotkey(HotKey_Smelt) then
    local ForgeID=false
    local nCnt = UO.ScanItems(true)                                 
    for i=1,nCnt do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if ( nType==4017 or ( nType>= 6522 and nType<=6569 ) ) and math.abs(UO.CharPosX-nX)<=2 and math.abs(UO.CharPosY-nY)<=2 then ForgeID=nID break end
    end
    if ForgeID then  
      if Beetle then Dismount() Beetle:OpenPack() end
      wait(250)        
      nCnt = UO.ScanItems(true)  
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if ( nType == AutoMoveToBeetle[1] or nType == AutoMoveToBeetle[2] or nType == AutoMoveToBeetle[3] or nType == AutoMoveToBeetle[4]) and (nContID==UO.BackpackID or ( Beetle and nContID==Beetle.BackpackID ) ) then
          while Smelt(ForgeID,nID)~="depleted" do end wait(250)
        end
      end                 
      if Beetle then Beetle:Mount() end
    else
      UO.ExMsg(UO.CharID,3,0x21,"no forge") 
    end
  end
  
  if WeightStatus~="Good" then
    if WeightStatus=="Beetle" then
      while not IsContOpen(UO.BackpackID) do OpenBackpack() end 
      local MoveList={}  
       
      nCnt = UO.ScanItems(false)
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        for j=1,#AutoMoveToBeetle do
          if nContID==UO.BackpackID and nType==AutoMoveToBeetle[j] and not (nType==7154 and nCol==0 ) then
            table.insert(MoveList,nID)
          end
        end
      end  
      Dismount()
      for i=1,#MoveList do
        Beetle:Take(MoveList[i])
        if CheckWeight()=="Bank" then break end
      end
      Beetle:Mount()
    end                                                       
  end
--###################################################################################
--## Lumberjacking related subjects                                                ##
--###################################################################################
  if Lumberjack_View.Checked then
    if gethotkey(HotKey_Lumberjack) or ( lumberjackresult and Lumberjack_Dry.Checked ) then --or miningresult then  
      --print("Targeting Tree: "..UO.LTargetX..", "..UO.LTargetY..", "..UO.LTargetZ)                                          
      if gethotkey(HotKey_Lumberjack) then lumberjackresult=true lumberjackloc=FindResourceTile(CX+MousePos.X,CY+MousePos.Y,"wood") end
      if lumberjackloc==false then lumberjackresult=false end
      if lumberjackresult=="depleted" then lumberjackresult=false end
      if lumberjackresult=="timeout" then if Lumberjack_Dry.Checked then lumberjackresult=true else lumberjackresult=false end end
      if lumberjackresult then lumberjackresult=Chop(lumberjackloc) end
    end 
  end  
--###################################################################################
--## Fishing related subjects                                                      ##
--###################################################################################
  if true then --Lumberjack_View.Checked then
    if gethotkey(HotKey_Fish) or ( fishingresult and Fish_Dry.Checked ) then --or miningresult then  
      --print("Targeting Tree: "..UO.LTargetX..", "..UO.LTargetY..", "..UO.LTargetZ)                                          
      if gethotkey(HotKey_Fish) then fishingresult=true fishingloc=FindResourceTile(CX+MousePos.X,CY+MousePos.Y,"fish") end
      if fishingloc==false then fishingresult=false end
      if fishingresult=="depleted" then fishingresult=false end
      if fishingresult=="timeout" then if Fish_Dry.Checked then fishingresult=true else fishingresult=false end end
      if fishingresult then fishingresult=Fish(fishingloc) end
    end 
  end  
--###################################################################################
--## Editor related subjects                                                       ##
--###################################################################################
  if Editor_View.Checked then
    if table.getn(Nodes) > 0 and getkey("ctrl") then
      local cnt = table.getn(Nodes)
      local cnt2 = 0
      if cnt > 9 then cnt2 = 9 else cnt2=cnt end
      for i=1,cnt do
        if getkey(i) then
          while getkey(i) do end
          table.insert(Nodes,table.getn(Nodes)+1,{Label=Nodes[i].Label,X=CX+MousePos.X,Y=CY+MousePos.Y,Z=GetLandTileZ(CX+MousePos.X,CY+MousePos.Y),Facet=Nodes[i].Facet,Action=Nodes[i].Action,Col=Nodes[i].Col, Scale=Nodes[i].Scale,Width=Nodes[i].Width}) 
          local Index=NodeList.ItemIndex  
          local Index2 = NodePropList.ItemIndex
          NodeListUpdate()                   
          NodeList.ItemIndex=Index +1  
          NodePropListUpdate()   
          NodePropList.ItemIndex=Index2 
          update=true   
        end
      end
    end
  end
  

  if GridMap_View.Checked then
  --###################################################################################
  --## Here we check to see if the Window,GameWindow, or Mouse has moved             ## 
  --## There are 3x checks becouse there is a phenomenon where the numbers change,   ##  
  --## But I never move the window                                                   ##
  --###################################################################################
    local Mouse={}
    Mouse.X,Mouse.Y=getmouse()
    while Mouse.X==nil or Mouse.Y==nil do Mouse.X,Mouse.Y=getmouse() end
    local tempWinX= Mouse.X-UO.CursorX+UO.CliLeft --UO.CliXRes
    local tempWinY= Mouse.Y-UO.CursorY+UO.CliTop  --UO.CliYRes
    if tempWinX~=Window.X or tempWinY~=Window.Y then
      Mouse.X,Mouse.Y=getmouse()
      while Mouse.X==nil or Mouse.Y==nil do Mouse.X,Mouse.Y=getmouse() end
      local tempWinX= Mouse.X-UO.CursorX+UO.CliLeft
      local tempWinY= Mouse.Y-UO.CursorY+UO.CliTop  
      if tempWinX~=Window.X or tempWinY~=Window.Y then
        Mouse.X,Mouse.Y=getmouse()
        while Mouse.X==nil or Mouse.Y==nil do Mouse.X,Mouse.Y=getmouse() end
        local tempWinX= Mouse.X-UO.CursorX+UO.CliLeft 
        local tempWinY= Mouse.Y-UO.CursorY+UO.CliTop  
        if tempWinX~=Window.X or tempWinY~=Window.Y then    
          Window.X = tempWinX 
          Window.Y = tempWinY
          clrscr() 
          update=true
        end
      end
    end
    --if globaltimer then print(getticks()-globaltimer) end
    --globaltimer=getticks()
    if gethotkey(HotKey_Pathfind) then    
      if table.getn(OldPix) > 1 then 
        for i=2,table.getn(OldPix) do Canvas.SetPixel(OldPix[i].X,OldPix[i].Y,OldPix[i].Col) end
        OldPix={{Col=0,X=0,Y=0}}
      end
      local Col=UO.GetPix(Mouse.X,Mouse.Y)
      if Col==TransparentColorValue then Col=1 end
      table.insert(OldPix,{Col=Canvas.GetPixel(Mouse.X,Mouse.Y),X=Mouse.X,Y=Mouse.Y}) 
      Canvas.SetPixel(Mouse.X,Mouse.Y,Col)
      
      if MainFormClicked.Time+100>getticks() and MainFormClicked.X==Mouse.X and MainFormClicked.Y==Mouse.Y then
        path = P:FindPath({CX,CY,UO.CharPosZ}, {CX+MousePos.X,CY+MousePos.Y,GetLandTileZ(CX+MousePos.X,CY+MousePos.Y)})
        if path == nil then return false 
        elseif path == "Error : Ending is not passable!" then print("Error : Ending is not passable!") path = nil  
        elseif path == "Error : Start is not passable!" then print("Error : Start is not passable!") path = nil end 
        UO.ExMsg(UO.CharID,tostring(Col))
        MainFormClicked.Time=0    
      end
    end   
      
    if path ~= nil then P:Next(200) end   

    if Reagents_Highlight.Checked then
      nCnt = UO.ScanItems(false)
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if nType>=3960 and nType<=3985 and nContID==0 then
          DrawSqrRelXYZ4(nX,nY,nZ,nZ,nZ,nZ,255,1,3)
        end
      end
    end






    

  --###################################################################################
  --## If the Mouse has moved...                                                     ##  
  --###################################################################################  
    if OldPos.CX~=UO.CursorX or OldPos.CY~=UO.CursorY then 
      --This Replaces an old pixel color on the canvas (We delete pixels under the cursor so as to not interfear with the User interface in ultima.)
      if table.getn(OldPix) > 1 then for i=2,table.getn(OldPix) do Canvas.SetPixel(OldPix[i].X,OldPix[i].Y,OldPix[i].Col) end OldPix={{Col=0,X=0,Y=0}} end
      
      if GridMap_ViewCursor.Checked then
        DrawSqrRelXY(CX+MousePos.X, CY+MousePos.Y, TransparentColorValue, -4)   
        if GridMap_MatrixHighlight.Checked then    
          DrawCursor(CX+MousePos.X, CY+MousePos.Y,GetLandMatrixZ(CX+MousePos.X, CY+MousePos.Y), TransparentColorValue, -4, 1)
        end
        local Color=Color_Cursor
        if GridMap_ViewCursorLOS.Checked then     
          local CharPos=GetPoint(Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ),"mobile")
          local TargPos=GetPoint(Point3D(CX+MousePos.X, CY+MousePos.Y,0),"Land")
          if LineOfSight( CharPos,TargPos ) then Color=Bit.Shl(255,8) end
        end
        
        MousePos=GetCursorGameXY()                                                                                                               
        if GridMap_MatrixHighlight.Checked and not UnderGround then 
          local zes=GetLandMatrixZ(CX+MousePos.X, CY+MousePos.Y)
          if not( zes[1]==zes[2] and zes[2]==zes[3] and zes[3]==zes[4] and zes[4]==UO.CharPosZ ) then
            DrawCursor(CX+MousePos.X, CY+MousePos.Y,GetLandMatrixZ(CX+MousePos.X, CY+MousePos.Y), Color, -4, 1) 
          end
        end
        DrawSqrRelXY(CX+MousePos.X, CY+MousePos.Y, Color, -4)              
      end
      
      --This adds the Color under our cursor to memory, and then deletes the pixel to maintain Ultima's focus, as stated above.
      table.insert(OldPix,{Col=Canvas.GetPixel(Mouse.X,Mouse.Y),X=Mouse.X,Y=Mouse.Y})           
      Canvas.SetPixel(Mouse.X,Mouse.Y,TransparentColorValue)
      OldPos.CX=UO.CursorX
      OldPos.CY=UO.CursorY
    
      --if there are any icons on the Radar AND the cursor is over the Radar
      if table.getn(radardrawn) > 0 and UO.CursorX>Radar.X and UO.CursorX<Radar.X+280 and UO.CursorY>Radar.Y and UO.CursorY<Radar.Y+280 then        
        Canvas.Font.Color = White       
        Canvas.Font.Size = 8
        local LocalHover=false
        for i=1, table.getn(radardrawn) do
          if radardrawn[i].X <= Mouse.X and radardrawn[i].Y <= Mouse.Y and radardrawn[i].X + radardrawn[i].Width >= Mouse.X and radardrawn[i].Y + radardrawn[i].Height >= Mouse.Y then
            Canvas.Text(radardrawn[i].X-30,radardrawn[i].Y-12,radardrawn[i].Label) 
            LocalHover=true
            Hover = true
            if getticks() < MainFormClicked.Time + 100 and MainFormClicked.X >= radardrawn[i].X and MainFormClicked.X <= radardrawn[i].X +radardrawn[i].Width and MainFormClicked.Y >= radardrawn[i].Y and MainFormClicked.Y <=radardrawn[i].Y+radardrawn[i].Height then
              --Radar Icon has been Clicked
            end
          end
        end
        if Hover==true and LocalHover==false then                 
          Pen.Color = TransparentColorValue
          Canvas.Brush.Color=TransparentColorValue
          Canvas.Rectangle(Radar.X,Radar.Y,Radar.X+280,Radar.Y+280)
          update=true
          Hover=false
        end
      end
    end
    
    
    --###################################################################################
    --##                                                                               ##
    --###################################################################################
    if UpdateMiningMatrix==false and ( tonumber(GridMap_HoldStill.Text) == 0 or ( tonumber(GridMap_HoldStill.Text) > 0 and HeldStill+GridMap_HoldStill.Text < getticks() ) ) then 
      UpdateMiningMatrix=true
      update=true 
    end
    if OldPos.X~=CX or OldPos.Y~=CY then update=true end  
    
    if update then                       
      if OldPos.X~=CX or OldPos.Y~=CY then 
        HeldStill=getticks() 
        OldPix={{Col=0,X=0,Y=0}}  --Pixels that are stored-then deleted- to allow click through    
        if GetLandTileZ(UO.CharPosX,UO.CharPosY) > UO.CharPosZ +15 then
          UnderGround=true           
        else                 
          UnderGround=false        
        end
        clrscr() 
      end
      OldPos={X=CX,Y=CY}
      if GridMap_ViewRGrid.Checked then DrawResourceGrid(tonumber(GridMap_ResourceSize.Text),Color_Resourcegrid,1) end  
      if GridMap_ResourceHighlight.Checked then DrawResource(CX,CY,tonumber(GridMap_ResourceSize.Text),Color_Resourcegrid,0,3) end -- Draw8x8RelXY(UO.CharPosX,UO.CharPosY,255,-2) end
      if GridMap_ViewCharPos.Checked then DrawSqrRelXY(CX, CY, Color_Char) end   
      --if CheckBox_MarkersView.Checked then
--###################################################################################
--##                  Lumberjack Resource Highlighter                              ##
--###################################################################################
      if Lumberjack_View.Checked then
        for xi=-14,14 do
          Drawn[xi]={}
          for yi=-14,14 do
            local ResourceTile = FindResourceTile(UO.CharPosX+xi,UO.CharPosY+yi,'wood')
            if ResourceTile ~= false then
              if xi>=-2 and xi<=2 and yi>=-2 and yi<=2 then
                local CharPos=GetPoint(Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ),"mobile")
                local TargPos=GetPoint(Point3D(UO.CharPosX+xi,UO.CharPosY+yi,0),"Land")
                if LineOfSight( CharPos,TargPos ) then
                  DrawCursor(ResourceTile.X,ResourceTile.Y,GetLandMatrixZ(ResourceTile.X,ResourceTile.Y),255000, 1,6) 
                end
              end 
              Drawn[xi][yi]=true
              DrawSqrRelXYZ4(ResourceTile.X,ResourceTile.Y,GetLandMatrixZ(ResourceTile.X,ResourceTile.Y),255, 1) 
              DrawStringRelXYZ(ResourceTile.X,ResourceTile.Y,GetLandTileZ(ResourceTile.X,ResourceTile.Y)+15,"®",255,12)
            end 
          end                
        end
      end
        
        
      if Mining_View.Checked then
--###################################################################################
--##                  Mining Grid Terrain "Matrix"                                 ##
--###################################################################################
        if UpdateMiningMatrix then
          for xi=-14,14 do
            Drawn[xi]={}
            for yi=-14,14 do
              local ResourceTile = FindResourceTile(UO.CharPosX+xi,UO.CharPosY+yi,'ore')     
              if ResourceTile ~= false then  
                while UnderGround and ResourceTile.Terrain and ResourceTile.Next~=nil do
                  ResourceTile=ResourceTile.Next
                end
                if ResourceTile.Next==nil then ResourceTile=false end
              end
              if ResourceTile ~= false and ResourceTile.Next~=nil then
                if xi>=-2 and xi<=2 and yi>=-2 and yi<=2 then
                  local CharPos=GetPoint(Point3D(UO.CharPosX,UO.CharPosY,UO.CharPosZ),"mobile")
                  local TargPos=CharPos
                  if ResourceTile.Terrain then
                    TargPos=GetPoint(Point3D(UO.CharPosX+xi,UO.CharPosY+yi,0),"Land")
                  else 
                    TargPos=GetPoint(Point3D(UO.CharPosX+xi,UO.CharPosY+yi,0),ResourceTile.Type)
                  end
                  if LineOfSight( CharPos,TargPos ) then
                    if not UnderGround then
                      DrawCursor(ResourceTile.X,ResourceTile.Y,GetLandMatrixZ(ResourceTile.X,ResourceTile.Y),255000, 1,6)      
                    else                                                                                                   
                      DrawSqrRelXYZ(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,255000, 1,3)                
                    end   
                  end
                end 
                Drawn[xi][yi]=true
                local X8x8=math.floor(ResourceTile.X/8)
                local Y8x8=math.floor(ResourceTile.Y/8)  
                if not UnderGround then ResourceTile.Z=GetLandTileZ(ResourceTile.X,ResourceTile.Y) end
                local Out={String="Err",Col=255}
                if Resource_View_Height.Checked then
                  Out.String=ResourceTile.Z    
                  if OreMap and OreMap[UO.CursKind] and OreMap[UO.CursKind][X8x8] and OreMap[UO.CursKind][X8x8][Y8x8] then
                    Out.Col=OreTypes[OreMap[UO.CursKind][X8x8][Y8x8]][1]
                  else
                    Out.Col=255
                  end
                elseif OreMap and OreMap[UO.CursKind] and OreMap[UO.CursKind][X8x8] and OreMap[UO.CursKind][X8x8][Y8x8] then
                  Out.String=OreTypes[OreMap[UO.CursKind][X8x8][Y8x8]][3]
                  Out.Col=OreTypes[OreMap[UO.CursKind][X8x8][Y8x8]][1]
                else
                  Out.String="?"
                  Out.Col=255
                end
                if not UnderGround then               
                  DrawSqrRelXYZ4(ResourceTile.X,ResourceTile.Y,GetLandMatrixZ(ResourceTile.X,ResourceTile.Y),Out.Col, 1)
                else                                                                                                   
                  DrawSqrRelXYZ(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,Out.Col, 1)                
                end   
                DrawStringRelXYZ(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,Out.String,Out.Col,12)
              end 
            end                
          end
        end
--###################################################################################
--##                  Grid Terrain Editor "Matrix"                                 ##
--###################################################################################
      --  if UpdateMiningMatrix then
      if not PatchTable then PatchTable={} end
          for xi=-14,14 do
            Drawn[xi]={}
            for yi=-14,14 do
              if PatchTable[UO.CharPosX+xi] and PatchTable[UO.CharPosX+xi][UO.CharPosY+yi] and PatchTable[UO.CharPosX+xi][UO.CharPosY+yi][2] then
                Drawn[xi][yi]=true
                  local temp=GetLandMatrixZ(UO.CharPosX+xi,UO.CharPosY+yi)
                  local Z1,Z2,Z3,Z4=temp[1],temp[2],temp[3],temp[4]
                  Z1=PatchTable[UO.CharPosX+xi][UO.CharPosY+yi][2] 
                  if PatchTable[UO.CharPosX+xi] and PatchTable[UO.CharPosX+xi][UO.CharPosY+yi+1] and PatchTable[UO.CharPosX+xi][UO.CharPosY+yi+1][2] then
                    Z4=PatchTable[UO.CharPosX+xi][UO.CharPosY+yi+1][2] end
                  if PatchTable[UO.CharPosX+xi+1] and PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi+1] and PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi+1][2] then
                    Z3=PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi+1][2] end
                  if PatchTable[UO.CharPosX+xi+1] and PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi] and PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi][2] then
                    Z2=PatchTable[UO.CharPosX+xi+1][UO.CharPosY+yi][2] end
                  DrawSqrRelXYZ4(UO.CharPosX+xi,UO.CharPosY+yi,Z1,Z2,Z3,Z4,255, 1) 
              end 
            end                
          end
      --  end
--###################################################################################
--##            Radar Overlay (Mining Overlay)                                     ##
--################################################################################### 
        if Radar_View.Checked then 
          for i=0,999 do local sName,nX,nY = UO.GetCont(i)
            if sName == "radar gump" then Radar={X=nX,Y=nY} break end
            if sName==nil then break end
          end 
          local x=math.floor(CX/8)*8 
          local y=math.floor(CY/8)*8 
          local rx=x-CX
          local ry=y-CY   
          Canvas.Font.Size = 8  
          Pen.Width=1
          for xi=-8,8 do 
            for yi=-8,8 do                                  
              local X8x8=math.floor(x/8)+xi
              local Y8x8=math.floor(y/8)+yi  
              local rx=X8x8*8-CX
              local ry=Y8x8*8-CY 
              if OreMap and OreMap[UO.CursKind] and OreMap[UO.CursKind][X8x8] and OreMap[UO.CursKind][X8x8][Y8x8] 
              and OreMap[UO.CursKind][X8x8][Y8x8] > 0 then
                Canvas.Font.Color = OreTypes[OreMap[UO.CursKind][X8x8][Y8x8]][1] 
                Pen.Color = Canvas.Font.Color  
                Canvas.Text(Window.X-UO.CliLeft+Radar.X+140+rx-ry-3,Window.Y-UO.CliTop+Radar.Y+140+rx+ry+1,tostring(OreTypes[OreMap[UO.CursKind][X8x8][Y8x8]][3]))  
                DrawRadar8x8(xi,yi)
                   -- else       
                   --   Canvas.Font.Color = 255
                   --   Canvas.Text(Window.X-UO.CliLeft+Radar.X+140+rx-ry-4,Window.Y-UO.CliTop+Radar.Y+140+rx+ry,"?") 
              end        
            end 
          end
          Pen.Color = Color_Resourcegrid
          Pen.Width=1
          DrawRadar8x8(0,0)
        end
      end
--(><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><)
--(><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><)
--(><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><) For Loop (><)
      if table.getn(Nodes) > 0 then
        if Radar_View.Checked then radardrawn={} end 
        for i=1,table.getn(Nodes) do 
          local rx=Nodes[i].X-CX
          local ry=Nodes[i].Y-CY
          if Nodes[i].Facet==UO.CursKind and math.abs(rx)<70 and math.abs(ry)<70
          or string.sub(Nodes[i].Action,1,8) == "Teleport" then --remove?
            local DrawBase=true
            if string.sub(Nodes[i].Action,1,4) == "Area" then
              local Links={}
              for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(Links,tonumber(w)) end
              for iLink=1,table.getn(Links) do
                if not Nodes[Links[iLink]] then --Nodes[i].Action = "Null"
                else 
                  local X2= Nodes[Links[iLink]].X                             
                  local Y2= Nodes[Links[iLink]].Y 
                  DrawAreaRelXY(Nodes[i].X, Nodes[i].Y,X2,Y2,Nodes[i].Col,Nodes[i].Scale,Nodes[i].Width)    
                end 
              end
              DrawBase=true
            end                    
            if string.sub(Nodes[i].Action,1,5) == "Arrow" then
              local Link = tonumber(string.sub(Nodes[i].Action,7))
              if not Nodes[Link] then Nodes[i].Action = "Null"
              else 
                local X2= Nodes[Link].X                             
                local Y2= Nodes[Link].Y 
                DrawArrowRelXY(Nodes[i].X, Nodes[i].Y,Nodes[i].Z,X2,Y2,Nodes[i].Col,Nodes[i].Scale,Nodes[i].Width)   
              end 
              DrawBase=false
            end
            if string.sub(Nodes[i].Action,1,4) == "Link" then
              local Links={}
              for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(Links,tonumber(w)) end
              for iLink=1,table.getn(Links) do
                if not Nodes[Links[iLink]] then --Nodes[i].Action = "Null"
                else 
                  local X2= Nodes[Links[iLink]].X                             
                  local Y2= Nodes[Links[iLink]].Y                            
                  local Z2= Nodes[Links[iLink]].Z 
                  DrawThread(Nodes[i].X,Nodes[i].Y,Nodes[i].Z, X2,Y2,Z2,Nodes[i].Col,Nodes[i].Scale,Nodes[i].Width)   
                end 
              end
              DrawBase=true
            end
            if string.sub(Nodes[i].Action,1,8) == "Teleport" then
              local Links={}
              for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(Links,tonumber(w)) end
              for iLink=1,table.getn(Links) do
                if not Nodes[Links[iLink]] then --Nodes[i].Action = "Null"
                else 
                  local X2= Nodes[Links[iLink]].X                             
                  local Y2= Nodes[Links[iLink]].Y                            
                  local Z2= Nodes[Links[iLink]].Z 
                  DrawArrowRelXY(X2,Y2,Z2,X2+1,Y2+1,Nodes[i].Col,-50,4)  
                end 
              end
              DrawBase=true
            end
            if GridMap_ViewMarkersZ.Checked and DrawBase then
              DrawSqrRelXYZ(Nodes[i].X, Nodes[i].Y, Nodes[i].Z, Nodes[i].Col, Nodes[i].Scale or -2, Nodes[i].Width)
              if GridMap_MarkersNumb.Checked then DrawStringRelXYZ(Nodes[i].X, Nodes[i].Y, Nodes[i].Z,i,Nodes[i].Col,12) end
            elseif DrawBase then
              DrawSqrRelXY(Nodes[i].X, Nodes[i].Y, Nodes[i].Col, Nodes[i].Scale or -2, Nodes[i].Width)
              if GridMap_MarkersNumb.Checked then DrawStringRelXY(Nodes[i].X, Nodes[i].Y,i,Nodes[i].Col,12) end
            end
--###################################################################################
--##            Radar Overlay (UOAM Expansion)                                     ##
--###################################################################################
            if Radar_View.Checked then
              if string.sub(Nodes[i].Action,1,3) == "Map" then
                local Category = string.match(Nodes[i].Action,"([%w%s]+):",5) or "" --tonumber(string.sub(Nodes[i].Action,10))
                local CategoryIndex = tonumber(string.match(Nodes[i].Action,"([%w%s]+)",6+string.len(Category))) or 1
                local Label = string.match(Nodes[i].Action,"([%w%s]+)",7+string.len(Category)+string.len(CategoryIndex)) or ""
                local len = string.len(Label)*15/88
                DrawSqrRelXY(Nodes[i].X, Nodes[i].Y,Nodes[i].Col,Nodes[i].Scale,Nodes[i].Width)  
                DrawStringRelXYZ(Nodes[i].X-len, Nodes[i].Y+len,Nodes[i].Z+20,Label,Nodes[i].Col,24) 
                local x=Window.X-UO.CliLeft+Radar.X+140+rx-ry
                local y=Window.Y-UO.CliTop+Radar.Y+140+rx+ry
                if Category == "Guilds" or Category == "Shops" or Category == "Topographic" then
                  local Width=BitMap_RadarIcons[Category][CategoryIndex].Width
                  local Height=BitMap_RadarIcons[Category][CategoryIndex].Height
                  x=x-(Width/2)
                  y=y-(Height/2)
                  local result, result2=true, true
                  result,result2 = pcall(Canvas.Draw,x,y,0,BitMap_RadarIcons[Category][CategoryIndex])
                  if result == false then print("Error: Canvas.Draw() ["..Category.."]["..CategoryIndex..","..RadarIcons[Category][CategoryIndex].."].. Code:"..result2)end                                     
                  table.insert(radardrawn,{X=x,Y=y,Width=Width,Height=Height,Label=Label,NodeIndex=i})
                else  
                  Canvas.SetPixel(Window.X-UO.CliLeft+Radar.X+140+rx-ry, Window.Y-UO.CliTop+Radar.Y+140+rx+ry, Nodes[i].Col) 
                end              
              elseif string.sub(Nodes[i].Action,1,4) == "Link" then
                local Links={}
                for w in string.gmatch(Nodes[i].Action,":(%d+)") do table.insert(Links,tonumber(w)) end
                for iLink=1,table.getn(Links) do
                  if not Nodes[Links[iLink]] then --Nodes[i].Action = "Null"
                  else 
                    local rx2=Nodes[Links[iLink]].X-CX
                    local ry2=Nodes[Links[iLink]].Y-CY
                    Pen.Color=Nodes[i].Col
                    Pen.Width = 1  
                    Canvas.Line(Window.X-UO.CliLeft+Radar.X+140+rx-ry, 
                      Window.Y-UO.CliTop+Radar.Y+140+rx+ry,
                      Window.X-UO.CliLeft+Radar.X+140+rx2-ry2, 
                      Window.Y-UO.CliTop+Radar.Y+140+rx2+ry2) 
                  end
                end
              else    
                Canvas.SetPixel(Window.X-UO.CliLeft+Radar.X+140+rx-ry, Window.Y-UO.CliTop+Radar.Y+140+rx+ry, Nodes[i].Col)
              end
            end
--###################################################################################
          end   
        end
      end           
      update = false
    end
  end
end     
------------------------------------------------------------------------------ End Of Main Loop ---------------------------------------------------------
MainForm.Show()
MainForm.SetFocus()     