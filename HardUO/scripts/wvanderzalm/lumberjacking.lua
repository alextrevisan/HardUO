if LUMBERJACKINIT then return end 
print("Lumberjacking.lua init")
LUMBERJACKINIT = true  
dofile(getinstalldir().."Scripts/Kal In Ex/journal.lua")       
dofile(getinstalldir().."Scripts/Kal In Ex/FindItems.lua")
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")                   
dofile(getinstalldir().."Scripts/wvanderzalm/Crafting.lua") 
--Crafter=CraftingObject()
--Crafter:Using({"tinkering"})  

Journal={}
Journal.Script=journal:new()

function Chop(ResourceTile)
  Journal.Script:clear() 
  local t = ScanItems(true,{ID=AxeID}) 
  local TinkersTools = 0
  if #t <= 0 or AxeID == nil then                                        
    t = ScanItems(true,{ContID={UO.BackpackID,UO.CharID}, Type={7864,7865}})
    if #t > 0 then TinkersTools = t[1].ID else
      UO.ExMsg(UO.CharID,"You need tinkers tools!")
      return false 
    end 
    if #t < 2 then
      while UO.ContSizeX ~= 530 or UO.ContSizeY ~= 437 do DClick(TinkersTools) wait(300) end
      Craft_ItemName("tinkering","tinker's tools") 
      if UO.ContSizeX == 530 or UO.ContSizeY == 437 then RClick(UO.ContPosX+50,UO.ContPosY+50) end
      return true
    end    
    t = ScanItems(true,{ContID={UO.BackpackID,UO.CharID}, Type={3907}}) 
    if #t < 1 then 
      while UO.ContSizeX ~= 530 or UO.ContSizeY ~= 437 do DClick(TinkersTools) wait(300) end
      Craft_ItemName("tinkering","hatchet")
      if UO.ContSizeX == 530 or UO.ContSizeY == 437 then RClick(UO.ContPosX+50,UO.ContPosY+50) end
      return true
    else
      AxeID = t[1].ID
    end
  end
  
  DClick(AxeID)
  local Timeout = getticks() + 6000
  while Timeout > getticks() do   
    if GRIDMAPINIT then
      Display_Busy(ResourceTile.X,ResourceTile.Y,Busy_deg)
      Busy_deg=Busy_deg+5
      wait(1)
    end 
    if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end 
    while Journal.Script:next() do     
      if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end 
      if string.find(Journal.Script:last(),"What do you want to use this item on?") then 
        TargetG(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,3,ResourceTile.Type)
      end
      if string.find(Journal.Script:last(),"The axe must be equipped for any serious wood chopping.") then
        Equip(AxeID)DClick(AxeID)   
        Timeout = getticks() + 6000
      end 
      if string.find(Journal.Script:last(),"You must wait to perform another action.") then 
        DClick(AxeID)   
        Timeout = getticks() + 6000
      end  
      if string.find(Journal.Script:last(),"You put some logs into your backpack.") 
      or string.find(Journal.Script:last(),"You hack at the tree for a while, but fail to produce any useable wood.") then 
        if GRIDMAPINIT and not Lumberjack_Dry.Checked then clrscr() end return true 
      end 
      if string.find(Journal.Script:last(),"There's not enough wood here to harvest.") then 
        if GRIDMAPINIT then clrscr() end return "depleted" 
      end
      if string.find(Journal.Script:last(),"You can't use an axe on that.") 
      or string.find(Journal.Script:last(),"You cannot see that location") 
      or string.find(Journal.Script:last(),"Target cannot be seen") 
      or string.find(Journal.Script:last(),"You have moved too far away")
      or string.find(Journal.Script:last(),"That is too far away") then 
        if GRIDMAPINIT then clrscr() end return false 
      end
    end
  end  
  if GRIDMAPINIT and not Lumberjack_Dry.Checked then clrscr() end return "timeout" 
end