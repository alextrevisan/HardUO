if ORETYPESINIT then return true end
ORETYPESINIT = true  

  local f = openfile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/MapFiles/"..UO.Shard.."-OreMap.lua")
  if f then                                 
    f:close()                 
    dofile("MapFiles/"..UO.Shard.."-OreMap.lua")
    print("Ore Map file for \""..UO.Shard.."\" has been loaded...")
  else        
    local f = openfile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/MapFiles/"..UO.Shard.."-OreMap.lua","w+b")
    f:write("OreMap={}")
    f:close()                                  
    dofile("MapFiles/"..UO.Shard.."-OreMap.lua")
    print("Ore Map file for \""..UO.Shard.."\" has been CREATED!")
  end



OreTypes={
{14474460,"iron","I"}, 
{7900310,"dull copper","D"},
{39423,"copper","C"},
{16739940,"shadow","S"}, 
{3100783,"bronze","B"}, 
{55295,"golden","G"}, 
{12695295,"agapite","A"},  
{3329434,"verite","Vr"},   
{12562319,"valorite","Va"}, 

}