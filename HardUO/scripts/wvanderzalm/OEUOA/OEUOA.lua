         
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")
------------------------------------
-- Script Name: 
-- Author: Wesley Vanderzalm
-- Version: 1.0.0
-- Client Tested with: 7.0.10.3 
-- EUO version tested with: OpenEUO
-- Shard OSI / FS: TestShard
-- Revision Date: 
-- Public Release: TBA
-- Purpose: 
-- Copyleft: 2011 Wesley Vanderzalm
------------------------------------
ConfirmDialog = Obj.Create("TMessageBox")
ConfirmDialog.Title = "Confirm"
ConfirmDialog.Button = 4
ConfirmDialog.Icon = 2
ConfirmDialog.Default = 1


dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/OEUOA Menu.lua") 
dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid Map Editor.lua")      
                                                     
TestTabCont.OnChange=function()
  if TestTabCont.TabIndex==0 then
    Panel_Common.Show() Panel_GridMap.Hide() Panel_Mining.Hide() Panel_HotKeys.Hide()
  elseif TestTabCont.TabIndex==1 then           
    Panel_Common.Hide() Panel_GridMap.Show() Panel_Mining.Hide() Panel_HotKeys.Hide()
  elseif TestTabCont.TabIndex==2 then           
    Panel_Common.Hide() Panel_GridMap.Hide() Panel_Mining.Show() Panel_HotKeys.Hide()
  elseif TestTabCont.TabIndex==3 then           
    Panel_Common.Hide() Panel_GridMap.Hide() Panel_Mining.Hide() Panel_HotKeys.Show()
  end
end
---------------------------------------------------------------------------
--[[ Tool Tips! ]]---------------------------------------------------------
---------------------------------------------------------------------------
      --GridMap Tips
        GridMap_View._={ShowHint=true, Hint="Shows the grid map in all its glory!"} 
        GridMap_ResourceHighlight._={ShowHint=true, Hint="Shows the resource area you are standing in"} 
        GridMap_ResourceSize._={ShowHint=true, Hint="Changes the resource area size"}   
        GridMap_ViewRGrid._={ShowHint=true, Hint="Shows all resource grid boarders"}     
        GridMap_ViewMarkers._={ShowHint=true, Hint="Shows nodes that are in the rail editor"}   
        GridMap_ViewMarkersZ._={ShowHint=true, Hint="Shows height of nodes"}     
        GridMap_MarkersNumb._={ShowHint=true, Hint="Shows nodes index number instead of first initial of action"}  
        GridMap_ViewCursor._={ShowHint=true, Hint="Shows the square selection under your cursor"} 
        GridMap_ViewCursorLOS._={ShowHint=true, Hint="Adds colour shifting to your cursor. ORANGE if targeted TERRAIN is not in line of sight, else GREEN"}   
        GridMap_HoldStill._={ShowHint=true, Hint="Time in milliseconds you have to stand still inorder for the Mining ore map to be drawn.(0 no delay)"} 
      --Mining tips                                                                          
        Mining_View._={ShowHint=true, Hint="Displays ore veins on the ground and radar."} 
        Mining_Once._={ShowHint=true, Hint="Trys to mine only once. Holding down the hotkey will repeatedly mine."} 
        Mining_Prospect._={ShowHint=true, Hint="Stops mining when coloured ore is found."}              
        Mining_Dry._={ShowHint=true, Hint="Stops mining when no more ore is found, or the location can't be targeted."} 
        Radar_View._={ShowHint=true, Hint="Displays ore veins on the radar."}           
        Editor_View._={ShowHint=true, Hint="Displays rail editor form."}     
        Reagents_Highlight._={ShowHint=true, Hint="Highlights reagents on the ground."}
        Lumberjack_View._={ShowHint=true, Hint="Highlights Trees on the grid."}
        Lumberjack_Dry._={ShowHint=true, Hint="Chop trees until \"There's not enough wood here to harvest.\""}
        Fish_Dry._={ShowHint=true, Hint="Fish in a location until no more are caught."}
---------------------------------------------------------------------------
--[[ Splash! ]]------------------------------------------------------------
---------------------------------------------------------------------------
Splash=function(n)
  local f = openfile(getinstalldir().."Scripts/wvanderzalm/OEUOA/Splash.bmp","rb")      
  if f then                                    
    BitMap_Splash = Obj.Create("TBitmap")  
    BitMap_Splash._={Data = f:read("*a"),Transparent = true, TransparentColor = White }      
    f:close()
    local top=ClientYRes-BitMap_Splash.Height/2   
    local bot=BitMap_Splash.Height+top
    local left=ClientXRes-BitMap_Splash.Width/2
    local right=BitMap_Splash.Width+left 
    print("333"..BitMap_Splash.Height..","..BitMap_Splash.Width)
    Canvas.Draw(left,top,0,BitMap_Splash)        
    Canvas.Draw(left,top,0,BitMap_Splash)   
    Obj.Free(BitMap_Splash)                  
    Canvas.Font.Color = 0xffffff
    Canvas.Text(left,bot+10,"Loading")
    local timeout=getticks()+n
    local dotnudge=left+60
    while timeout>getticks() do  
      --Canvas.Text(dotnudge,bot+10,".")
      Canvas.Pen.Color=0xffffff
      Canvas.Brush.Color=0xffffff
      local dotright=left+(right-left)*(1-(timeout-getticks())/n)
      Canvas.Rectangle(left,bot+40,dotright,bot+42)
      dotnudge=dotnudge+5
     -- wait(100)
    end   
  else        
    print("No Splash image found")                   
  end  
  return 
end
---------------------------------------------------------------------------
--[[ Setup ]]--------------------------------------------------------------
---------------------------------------------------------------------------
Beetle=false
local Mount=IsMounted(ID)
if Mount and Mount.Type==791 then --{Name=Name,ID=nID,Type=nType,Weight=Weight,Color=nCol}                           
  dofile(getinstalldir().."Scripts/wvanderzalm/Beetle.lua")    
  Beetle=Beetle()
end
---------------------------------------------------------------------------
--[[ Opening ]]------------------------------------------------------------
---------------------------------------------------------------------------
Panel_Common.Show() Panel_GridMap.Hide() Panel_Mining.Hide() Panel_HotKeys.Hide()
dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid map.lua")      
Splash(0)  --This is my Splash screen, Ill use this to promote myself and this script! :)
Counter_form.Show()
dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/config.cfg")
MainMenu.SetHints(false)
Obj.Loop() 

---------------------------------------------------------------------------
--[[ Closing ]]------------------------------------------------------------
--------------------------------------------------------------------------- 
clrscr()                      
Editor_form.Hide()
Counter_form.Hide()   
MainForm.Hide() 

Obj.Free(MainForm)
Obj.Free(LoadMenu)
Obj.Free(SaveMenu)
Obj.Free(ConfirmDialog)  
Obj.Free(Timer)
---------------------------------------------------------------------------
--[[ Counter_form ]]-------------------------------------------------------
---------------------------------------------------------------------------
MainMenu.Free()
---------------------------------------------------------------------------
--[[ Editor_form ]]--------------------------------------------------------
---------------------------------------------------------------------------
EditorMenu.Free()

for i = 1,table.getn(BitMap_RadarIcons.Guilds) do Obj.Free(BitMap_RadarIcons.Guilds[i]) end  
for i = 1,table.getn(BitMap_RadarIcons.Shops) do Obj.Free(BitMap_RadarIcons.Shops[i]) end
for i = 1,table.getn(BitMap_RadarIcons.Topographic) do Obj.Free(BitMap_RadarIcons.Topographic[i]) end