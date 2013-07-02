if MININGINIT then return end 
print("Mining.lua init")
MININGINIT = true  
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")
dofile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/OreTypes.lua")       
dofile(getinstalldir().."Scripts/Kal In Ex/journal.lua")       
dofile(getinstalldir().."Scripts/Kal In Ex/FindItems.lua")                
dofile(getinstalldir().."Scripts/wvanderzalm/Crafting.lua")
--Crafter=CraftingObject()
--Crafter:Using({"tinkering"})  


Journal={}
Journal.Script=journal:new()

function Mine(ResourceTile,MakeTools)  
  Journal.Script:clear() 
  local t = ScanItems(true,{ID=PickID}) 
  if MakeTools==nil then MakeTools = true  end
  local TinkersTools = 0
  if #t <= 0 or PickID == nil then                                        
    if MakeTools then
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
    end
    t = ScanItems(true,{ContID={UO.BackpackID,UO.CharID}, Type={3897,3898,3717,3718}}) 
    if #t < 1 then 
      if TinkersTools == 0 then return "notools" end
      while UO.ContSizeX ~= 530 or UO.ContSizeY ~= 437 do DClick(TinkersTools) wait(300) end
      Craft_ItemName("tinkering","shovel")
      if UO.ContSizeX == 530 or UO.ContSizeY == 437 then RClick(UO.ContPosX+50,UO.ContPosY+50) end
      return true
    else
      PickID = t[1].ID
    end
  end
  
  if IsMounted() then Dismount() end
  DClick(PickID)                    
  local Timeout = getticks() + 4000
  while Timeout > getticks() do      
    if GRIDMAPINIT then
      Display_Busy(ResourceTile.X,ResourceTile.Y,Busy_deg)
      Busy_deg=Busy_deg+5
      wait(1)
    end
    if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end 
    while Journal.Script:next() do     
      if getkey("esc") then while getkey("esc") do end if GRIDMAPINIT then clrscr() end return false end 
      if string.find(Journal.Script:last(),"Where do you wish to dig?") then 
        if ResourceTile.Terrain then TargetG(ResourceTile.X,ResourceTile.Y,ResourceTile.Z)            
        else TargetG(ResourceTile.X,ResourceTile.Y,ResourceTile.Z,3,ResourceTile.Type) end
      end
      if string.find(Journal.Script:last(),"You can't mine while riding") 
      or string.find(Journal.Script:last(),"You can't dig while riding or flying.") then
        Dismount() DClick(PickID)   
        Timeout = getticks() + 4000
      end
      if string.find(Journal.Script:last(),"You must wait to perform another action.") then 
        DClick(PickID)   
        Timeout = getticks() + 4000
      end 
      if string.find(Journal.Script:last(),"Your backpack is full, so the ore you mined is lost.") then 
        if GRIDMAPINIT then clrscr() end return "fullbackpack"
      end 
      if string.find(Journal.Script:last(),"You dig some") then     
        local X8x8 = math.floor(ResourceTile.X/8)
        local Y8x8 = math.floor(ResourceTile.Y/8)
        if not OreMap then OreMap={} end           
        if not OreMap[UO.CursKind] then OreMap[UO.CursKind]={} end 
        if not OreMap[UO.CursKind][X8x8] then OreMap[UO.CursKind][X8x8]={} end
        if not OreMap[UO.CursKind][X8x8][Y8x8] or OreMap[UO.CursKind][X8x8][Y8x8] == 1 then
          local type = string.sub(Journal.Script:last(),19,20)
          for i=1,table.getn(OreTypes) do if string.sub(OreTypes[i][2],1,2)==type then type=i break end end
          if not OreMap[UO.CursKind][X8x8][Y8x8] or (OreMap[UO.CursKind][X8x8][Y8x8]~=type and type~=1) then 
            OreMap[UO.CursKind][X8x8][Y8x8]=type
            SaveData(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/MapFiles/"..UO.Shard.."-OreMap.lua","OreMap="..TableToString(OreMap)) 
            if GRIDMAPINIT then
              UpdateMiningMatrix=true 
              update=true 
              clrscr()
            else
              setatom("MREAtom","OreMap="..TableToString(OreMap).." UpdateMiningMatrix=true update=true clrscr()")   
            end         
          end
        end
        if GRIDMAPINIT and not ( Mining_Dry.Checked or Mining_Prospect.Checked ) then clrscr() end 
        return true  
      end       
      if string.find(Journal.Script:last(),"You loosen some rocks but fail to find any useable ore.") then 
        if GRIDMAPINIT and not ( Mining_Dry.Checked or Mining_Prospect.Checked ) then clrscr() end return true
      end                   
      if string.find(Journal.Script:last(),"There is no metal here to mine.") then
        if GRIDMAPINIT then clrscr() end return "depleted"
      end      
      if string.find(Journal.Script:last(),"That is too far away.") 
      or string.find(Journal.Script:last(),"You can't mine that.")
      or string.find(Journal.Script:last(),"You can't mine there.")
      or string.find(Journal.Script:last(),"Target cannot be seen.")
      or string.find(Journal.Script:last(),"You have moved too far away to continue mining.") then  
        if GRIDMAPINIT then clrscr() end return false
      end
    end
  end 
  if GRIDMAPINIT and not ( Mining_Dry.Checked or Mining_Prospect.Checked ) then clrscr() end return "timeout" 
end
function Smelt(ForgeID,OreID)
  Journal.Script:clear() 
  DClick(OreID) 
  local Timeout = getticks() + 4000                                 
  while Timeout > getticks() do      
    if getkey("esc") then while getkey("esc") do end return false end 
    while Journal.Script:next() do 
      if string.find(Journal.Script:last(),"Select the forge on which to smelt the ore, or another pile of ore with which to combine it.") then 
        Target(ForgeID)
      end
      if string.find(Journal.Script:last(),"You have no idea how to smelt this strange ore!") then
        print("Not enough Mining skill to smelt!")
        pause()
      end
      if string.find(Journal.Script:last(),"You must wait to perform another action.") then 
        --wait(500)
        DClick(OreID)   
        local Timeout = getticks() + 4000
      end 
      if string.find(Journal.Script:last(),"You burn away the impurities but are left with less useable metal.") then 
        return true
      end                   
      if string.find(Journal.Script:last(),"You smelt the ore removing the impurities and put the metal in your backpack.") or 
         string.find(Journal.Script:last(),"You burn away the impurities but are left with no useable metal.") then
        return "depleted"
      end      
      if string.find(Journal.Script:last(),"That is too far away.") 
      or string.find(Journal.Script:last(),"You can't mine that.")
      or string.find(Journal.Script:last(),"You can't mine there.")
      or string.find(Journal.Script:last(),"Target cannot be seen.") then 
        return false
      end
    end 
  end
  return "timeout"
end