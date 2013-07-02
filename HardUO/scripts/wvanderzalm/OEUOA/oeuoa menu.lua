MainMenuBackgoundColour=(51   +   Bit.Shl(153,8)   +   Bit.Shl(100,16))
LeftBackgroundColour=(51   +   Bit.Shl(153,8)   +   Bit.Shl(0,16))    
RightBackgroundColour=(128   +   Bit.Shl(153,8)   +   Bit.Shl(0,16))

MainMenu={}
MainMenu.Objects={}
MainMenu.CreateObj=function(name,str,args) dostring(name..'=Obj.Create("'..str..'") table.insert(MainMenu.Objects,{Pointer='..name..',Name="'..name..'",Type="'..str..'"})') if args then dostring(name.."._="..args) end end
MainMenu.SetHints=function(bool) for i=1,#MainMenu.Objects do MainMenu.Objects[i].Pointer.ShowHint=bool end end
MainMenu.Free=function() for i=#MainMenu.Objects,1,-1 do if MainMenu.Objects[i].Pointer then Obj.Free(MainMenu.Objects[i].Pointer) end end end

MainMenu.CreateObj("Counter_form",           "TForm",          '{Color=MainMenuBackgoundColour, Caption = "OEUO Augment 0.0",Left=0,Top=0, Width=465, Height=275, OnClose = function() if ConfirmDialog.Show("Exit OEUOA?")==6 then Obj.Exit() end end, FormStyle = 3 }')
MainMenu.CreateObj("TestTabCont",            "TTabControl",    "{Align=5,Parent=Counter_form }")
  TestTabCont.Tabs.Add("Common")
  TestTabCont.Tabs.Add("Grid Map")
  TestTabCont.Tabs.Add("Mining")
  TestTabCont.Tabs.Add("HotKeys")
--MainMenu.CreateObj("Splash",                 "TPanel",         "{Align=5,BevelOuter=0,Parent=TestTabCont}")
--Common
MainMenu.CreateObj("Panel_Common",           "TPanel",         "{Color=(0   +   Bit.Shl(255,8)   +   Bit.Shl(255,16)),Align=5,BevelOuter=0,Parent=TestTabCont}")
MainMenu.CreateObj("GridMap_O",     "TLabel",         "{Caption='˜—˜—˜—˜—˜—˜—˜—|–™–™–™–™–™–™–™',Align=1,Parent=Counter_form}")
GridMap_O.Font._={Name="Wingdings", Size=12}
  
MainMenu.CreateObj("GridMap_O3",     "TLabel",         "{Caption='—˜—˜—˜—˜—˜—˜—˜|™–™–™–™–™–™–™–',Align=2,Parent=Counter_form}")
GridMap_O3.Font._={Name="Wingdings", Size=12}

MainMenu.CreateObj("Panel_Common_Left",      "TPanel",         "{Color=LeftBackgroundColour,Align=3,Width=220,Parent=Panel_Common}")
MainMenu.CreateObj("Panel_Common_Right",     "TPanel",         "{Color=RightBackgroundColour,Align=3,Width=221,Parent=Panel_Common}")
MainMenu.CreateObj("GridMap_Opacity_label",     "TLabel",         "{Caption='Opacity of the Grid : Solid',Align=1,Parent=Panel_Common_Left}")
MainMenu.CreateObj("GridMap_Opacity",     "TScrollBar",         "{Align=1, Min=1, Max=255, Position=1, Parent = Panel_Common_Left, OnChange=function() if GridMap_Opacity.Position ~= 255 then MainForm.AlphaBlend=true MainForm.AlphaBlendValue=GridMap_Opacity.Position GridMap_Opacity_label.Caption='Opacity of the Grid :'..GridMap_Opacity.Position else MainForm.AlphaBlend=false GridMap_Opacity_label.Caption='Opacity of the Grid : Solid' end end}")
MainMenu.CreateObj("Counter_form_Opacity_label",     "TLabel",         "{Caption='Opacity of this menu : Solid',Align=1,Parent=Panel_Common_Left}")
MainMenu.CreateObj("Counter_form_Opacity",     "TScrollBar",         "{Align=1, Min=20, Max=255, Position=20, Parent = Panel_Common_Left, OnChange=function() if Counter_form_Opacity.Position ~= 255 then Counter_form.AlphaBlend=true Counter_form.AlphaBlendValue=Counter_form_Opacity.Position Counter_form_Opacity_label.Caption='Opacity of this menu :'..Counter_form_Opacity.Position else Counter_form.AlphaBlend=false Counter_form_Opacity_label.Caption='Opacity of this menu : Solid' end end}")
MainMenu.CreateObj("Save_Settings",                 "TButton",         "{Align=1,Parent = Panel_Common_Right, Caption='Save All Settings'}")
Save_Settings.OnClick=function()
  local str=""
  str=str..'HotKey_Mine='..TableToString(HotKey_Mine)..string.char(0xd)..string.char(0xa)
  str=str..'HotKey_Lumberjack='..TableToString(HotKey_Lumberjack)..string.char(0xd)..string.char(0xa)
  str=str..'HotKey_Pathfind='..TableToString(HotKey_Pathfind)..string.char(0xd)..string.char(0xa)
  str=str..'HotKey_Fish='..TableToString(HotKey_Fish)..string.char(0xd)..string.char(0xa)
  str=str..string.char(0xd)..string.char(0xa)
  str=str.."Color_Resourcegrid = "..(0   +   Bit.Shl(255,8)   +   Bit.Shl(255,16))..string.char(0xd)..string.char(0xa)
  str=str.."Color_Char = "..(0   +   Bit.Shl(0,8)     +   Bit.Shl(255,16))..string.char(0xd)..string.char(0xa)
  str=str.."Color_Cursor = "..(255   +   Bit.Shl(127,8)   +   Bit.Shl(0,16))..string.char(0xd)..string.char(0xa)
  str=str.."Color_Resource = "..(255   +   Bit.Shl(0,8)   +   Bit.Shl(0,16))..string.char(0xd)..string.char(0xa)
  str=str.."TransparentColorValue = "..0 ..string.char(0xd)..string.char(0xa) --0xffffff
  str=str.."White = "..0xffffff ..string.char(0xd)..string.char(0xa)
  str=str..string.char(0xd)..string.char(0xa)
  for i=#MainMenu.Objects,1,-1 do
    if MainMenu.Objects[i].Type=="TCheckBox" then
      str=str..MainMenu.Objects[i].Name..'.Checked='..tostring(MainMenu.Objects[i].Pointer.Checked)..string.char(0xd)..string.char(0xa)
    elseif MainMenu.Objects[i].Type=="TEdit" then
      str=str..MainMenu.Objects[i].Name..'.Text="'..MainMenu.Objects[i].Pointer.Text..'"'..string.char(0xd)..string.char(0xa)
    elseif MainMenu.Objects[i].Type=="TRadioButton" then
      str=str..MainMenu.Objects[i].Name..'.Checked='..tostring(MainMenu.Objects[i].Pointer.Checked)..string.char(0xd)..string.char(0xa)
    end
  end
  SaveData(getinstalldir().."Scripts/wvanderzalm/OEUOA/config.cfg",str)
end

--Common End
--GridMap
MainMenu.CreateObj("Panel_GridMap",                 "TPanel",         "{Color=255,Align=5,BevelOuter=0,Parent=TestTabCont}")
MainMenu.CreateObj("Panel_GridMap_Left",      "TPanel",         "{Color=LeftBackgroundColour,Align=3,Width=220,Parent=Panel_GridMap}")
MainMenu.CreateObj("Panel_GridMap_Right",     "TPanel",         "{Color=RightBackgroundColour,Align=3,Width=221,Parent=Panel_GridMap}")
MainMenu.CreateObj("GridMap_View",     "TCheckBox",         "{Caption='Enable Grid Map', Align=1, Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ResourceHighlight",     "TCheckBox",         "{Caption='Highlight Your Current Resource Grid', Align=1,Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ResourceSize",     "TEdit",         "{Align=1, Parent = Panel_GridMap_Left, Text='8'}")
MainMenu.CreateObj("GridMap_ViewRGrid",     "TCheckBox",         "{Caption='Display Resource Grid',Align=1,Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ViewMarkers",     "TCheckBox",         "{Caption='Draw Markers',Align=1,Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ViewMarkersZ",     "TCheckBox",         "{Caption='Draw Markers With Height',Align=1,Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_MarkersNumb",     "TCheckBox",         "{Caption='Draw Marker\\'s Index',Align=1,Parent = Panel_GridMap_Left, OnClick=function()update=true clrscr() end}")
--right
MainMenu.CreateObj("GridMap_ViewCursor",     "TCheckBox",         "{Caption='Draw Cursor',Align=1,Parent = Panel_GridMap_Right, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ViewCursorLOS",     "TCheckBox",         "{Caption='Highlight Cursor if in LOS',Align=1,Parent = Panel_GridMap_Right}")
MainMenu.CreateObj("GridMap_MatrixHighlight",     "TCheckBox",         "{Caption='HighLight Terrain Matrix',Align=1, Parent = Panel_GridMap_Right, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_ViewCharPos",     "TCheckBox",         "{Caption='Draw Player Marker',Align=1,Parent = Panel_GridMap_Right, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("GridMap_HoldStill_label",     "TLabel",         "{Caption='HoldStill Time (\\'0\\' for none)',Align=1,Parent=Panel_GridMap_Right}")
MainMenu.CreateObj("GridMap_HoldStill",     "TEdit",         "{Align=1,Parent = Panel_GridMap_Right, Text='300'}")
--GridMap end
--Mining
MainMenu.CreateObj("Panel_Mining",                 "TPanel",         "{Color=255000,Align=5,BevelOuter=0,Parent=TestTabCont}")
MainMenu.CreateObj("Panel_Mining_Left",                 "TPanel",         "{Color=LeftBackgroundColour,Align=3,Width=220,Parent=Panel_Mining}")
MainMenu.CreateObj("Panel_Mining_Right",                 "TPanel",         "{Color=RightBackgroundColour,Align=3,Width=221,Parent=Panel_Mining}")
MainMenu.CreateObj("Mining_View",                 "TCheckBox",         "{Caption='Enable Mining Matrix', Align=1, Parent = Panel_Mining_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("Mining_Once",                 "TRadioButton",         "{Caption='Mine Once Only', Align=1, Parent = Panel_Mining_Left} ")
MainMenu.CreateObj("Mining_Dry",                 "TRadioButton",         "{Caption='Mine Target Dry', Align=1, Parent = Panel_Mining_Left}")
MainMenu.CreateObj("Mining_Prospect",                 "TRadioButton",         "{Caption='Mine Prospectively', Align=1, Parent = Panel_Mining_Left}")
MainMenu.CreateObj("Mining_MakeTools",                 "TCheckBox",         "{Caption='Make tools when required', Align=1, Parent = Panel_Mining_Left, OnClick=function() if not Crafter then Crafter=CraftingObject() end Crafter:Using({'tinkering'})  end}")
MainMenu.CreateObj("Resource_View_Height",                 "TCheckBox",         "{Caption='Set Resource Icon \"Height\"', Align=1, Parent = Panel_Mining_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("Radar_View",                 "TCheckBox",         "{Caption='Enable Radar', Align=1, Parent = Panel_Mining_Left, OnClick=function()update=true clrscr() end}")
MainMenu.CreateObj("Editor_View",                 "TCheckBox",         "{Caption='Enable Editor', Align=1, Parent = Panel_Mining_Left, OnClick=function()if Editor_View.Checked then Editor_form.Show() else Editor_form.Hide() end end}")
MainMenu.CreateObj("Reagents_Highlight",                 "TCheckBox",         "{Caption='Highlight reagents', Align=1, Parent = Panel_Mining_Left}")
MainMenu.CreateObj("Lumberjack_View",                 "TCheckBox",         "{Caption='Enable Lumberjack Matrix', Align=1, Parent = Panel_Mining_Right} ")
MainMenu.CreateObj("Lumberjack_Dry",                 "TCheckBox",         "{Caption='Chop Target Dry', Align=1, Parent = Panel_Mining_Right} ")
MainMenu.CreateObj("Fish_Dry",                 "TCheckBox",         "{Caption='Fish Target Dry', Align=1, Parent = Panel_Mining_Right} ")
--mining end
--hotkeys
MainMenu.CreateObj("Panel_HotKeys",                 "TPanel",         "{Color=0,Align=5,BevelOuter=0,Parent=TestTabCont}")
MainMenu.CreateObj("Panel_HotKeys_Left",                 "TPanel",         "{Color=LeftBackgroundColour,Align=3,Width=220,Parent=Panel_HotKeys}")
MainMenu.CreateObj("Panel_HotKeys_Right",                 "TPanel",         "{Color=RightBackgroundColour,Align=3,Width=221,Parent=Panel_HotKeys}")
MainMenu.CreateObj("HotKey_Edit_Mining_label",                 "TLabel",         "{Caption='HotKey to attempt mining(Key,Ctrl,Alt,Shift)',Align=1,Parent=Panel_HotKeys_Left}")
MainMenu.CreateObj("HotKey_Edit_Mining",                 "TButton",         "{Align=1,Parent = Panel_HotKeys_Left, Caption='F2,false,false,false'}")
        HotKey_Edit_Mining.OnClick=function()
          HotKey_Edit_Mining.Caption="Hit Key Now!"
          local key,ctrl,alt,shift=GetValidKeys()
          while not key do key,ctrl,alt,shift=GetValidKeys() end
          HotKey_Edit_Mining.Caption=tostring(key)..","..tostring(ctrl)..","..tostring(alt)..","..tostring(shift)
          HotKey_Mine={key,ctrl,alt,shift}
          while getkey(key) do end
        end
MainMenu.CreateObj("HotKey_Edit_Lumberjack_label",                 "TLabel",         "{Caption='HotKey to attempt lumberjacking(Key,Ctrl,Alt,Shift)',Align=1,Parent=Panel_HotKeys_Left}")
MainMenu.CreateObj("HotKey_Edit_Lumberjack",                 "TButton",         "{Align=1,Parent = Panel_HotKeys_Left, Caption='F3,false,false,false'}")
        HotKey_Edit_Lumberjack.OnClick=function()
          HotKey_Edit_Lumberjack.Caption="Hit Key Now!"
          local key,ctrl,alt,shift=GetValidKeys()
          while not key do key,ctrl,alt,shift=GetValidKeys() end
          HotKey_Edit_Lumberjack.Caption=tostring(key)..","..tostring(ctrl)..","..tostring(alt)..","..tostring(shift)
          HotKey_Lumberjack={key,ctrl,alt,shift}
          while getkey(key) do end
        end
MainMenu.CreateObj("HotKey_Edit_Pathfind_label",                 "TLabel",         "{Caption='HotKey to attempt pathfinding(Key,Ctrl,Alt,Shift)',Align=1,Parent=Panel_HotKeys_Left}")
MainMenu.CreateObj("HotKey_Edit_Pathfind",                 "TButton",         "{Align=1,Parent = Panel_HotKeys_Left, Caption='F6,false,false,false'}")
        HotKey_Edit_Pathfind.OnClick=function()
          HotKey_Edit_Pathfind.Caption="Hit Key Now!"
          local key,ctrl,alt,shift=GetValidKeys()
          while not key do key,ctrl,alt,shift=GetValidKeys() end
          HotKey_Edit_Pathfind.Caption=tostring(key)..","..tostring(ctrl)..","..tostring(alt)..","..tostring(shift)
          HotKey_Pathfind={key,ctrl,alt,shift}
          while getkey(key) do end
        end