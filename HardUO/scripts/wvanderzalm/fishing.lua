if FISHINGINIT then return end 
print("Fishing.lua init")
FISHINGINIT = true  
dofile(getinstalldir().."Scripts/Kal In Ex/journal.lua")       
dofile(getinstalldir().."Scripts/Kal In Ex/FindItems.lua")
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")           
Journal={}
Journal.Script=journal:new()

function Fish(ResourceTile)
  Journal.Script:clear() 
  local t = ScanItems(true,{ID=PoleID}) 
  if #t <= 0 or PoleID == nil then                                            
    t = ScanItems(true,{ContID={UO.BackpackID,UO.CharID}, Type={3519,3520}}) 
    if #t < 1 then 
      UO.ExMsg(UO.CharID,"You have no fishing rod!")
      return false
    else
      PoleID = t[1].ID
    end
  end
  
  DClick(PoleID)
  local Timeout = getticks() + 10000   
  while Timeout > getticks() do 
    if GRIDMAPINIT then
      Display_Busy(ResourceTile.X,ResourceTile.Y,Busy_deg)
      Busy_deg=Busy_deg+5
      wait(1)
    end
    if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end 
    while Journal.Script:next() do
      if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end  
      if string.find(Journal.Script:last(),"What water do you want to fish in?") then 
        TargetG(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,3,ResourceTile.Type)
      end
      if string.find(Journal.Script:last(),"You must wait to perform another action.") then 
        DClick(PoleID)   
        Timeout = getticks() + 10000
      end  
      if string.find(Journal.Script:last(),"You pull out an item :") 
      or string.find(Journal.Script:last(),"You fish a while, but fail to catch anything.") then 
        if GRIDMAPINIT and not Fish_Dry.Checked then clrscr() end return true 
      end 
      if string.find(Journal.Script:last(),"The fish don't seem to be biting here.") then 
        if GRIDMAPINIT then clrscr() end return "depleted" 
      end
      if string.find(Journal.Script:last(),"you cannot see that location") 
      or string.find(Journal.Script:last(),"Target cannot be seen.") 
      or string.find(Journal.Script:last(),"You need to be closer to the water to fish!")
      or string.find(Journal.Script:last(),"that is too far away") then 
        if GRIDMAPINIT then clrscr() end return false 
      end
    end
  end  
  if GRIDMAPINIT and not Fish_Dry.Checked then clrscr() end return "timeout" 
end