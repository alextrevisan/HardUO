print("ding")                                              
dofile(getinstalldir().."Scripts/wvanderzalm/Pathfind.lua")      
dofile(getinstalldir().."Scripts/wvanderzalm/Tile.lua")       
dofile(getinstalldir().."Scripts/wvanderzalm/OEUOA/GridMap/Grid Map Api.lua")  
dofile(getinstalldir().."scripts/wvanderzalm/OEUOA/GridMap/OreTypes.lua")      
dofile(getinstalldir().."Scripts/wvanderzalm/Beetle.lua")    
function CheckWeight()
  local PlayerFull=UO.Weight >= UO.MaxWeight - 4*12
  local BeetleFull=B1.Weight >= B1.MaxWeight - 12

  if PlayerFull and BeetleFull then 
    return "Bank"
  elseif PlayerFull then 
    return "Beetle"
  else 
    return "Good"
  end
end


dofile(getinstalldir().."Scripts/wvanderzalm/mining.lua") 
local hook=Gridmap_Api
local update=false
local OreTypes={6583,6584,6585,6586}
local SmeltIndex={}              
local BankIndex={} 
B1=Beetle()




  local Nodes=hook:getnodes()
  while Nodes==false do Nodes=hook:getnodes() end
  for i=1,table.getn(Nodes) do  
    if string.find(Nodes[i].Action,"Smelt") then
      table.insert(SmeltIndex,i)
    end
    if string.find(Nodes[i].Action,"Bank") then
      table.insert(BankIndex,i)
    end
  end  
  


  

while true do  
  for i=1,table.getn(Nodes) do
    while CheckWeight()=="Beetle" do --UO.Weight >= UO.MaxWeight - 4*16 then
      Dismount()
      local nCnt = UO.ScanItems(true)
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if ( nType == OreTypes[1] or nType == OreTypes[2] or nType == OreTypes[3] or nType == OreTypes[4] ) and nContID==UO.BackpackID then
          B1:Take(nID,math.floor((B1.MaxWeight-B1.Weight)/12))
          print(B1.Weight)
        end
        if CheckWeight()~="Beetle" then B1:Mount() break end
      end  
    end
    if CheckWeight()=="Bank" then
    --find closest bank
      local bi=0
      local dist=9999
      for i=1,#BankIndex do
        local ndist=math.sqrt(math.pow(UO.CharPosX-Nodes[BankIndex[i]].X,2)+math.pow(UO.CharPosY-Nodes[BankIndex[i]].Y,2))
        if dist > ndist then bi=i dist=ndist end
      end
      if bi==0 then print("No bank nodes??") pause() end      
    --find closest forge
      local si=0
      dist=9999
      for i=1,#SmeltIndex do
        local ndist=math.sqrt(math.pow(UO.CharPosX-Nodes[SmeltIndex[i]].X,2)+math.pow(UO.CharPosY-Nodes[SmeltIndex[i]].Y,2))
        if dist > ndist then si=i dist=ndist end
      end
      if si==0 then print("No forge nodes??") pause() end      
    --
      B1:Mount()
      Pathfind(Nodes[SmeltIndex[si]].X,Nodes[SmeltIndex[si]].Y,Nodes[SmeltIndex[si]].Z,-1,false)
      Dismount()
      B1:OpenPack()
      wait(250)
      local ForgeID=false
      local nCnt = UO.ScanItems(true)                                 
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if ( nType==4017 or ( nType>= 6522 and nType<=6569 ) ) and math.abs(UO.CharPosX-nX)<=2 and math.abs(UO.CharPosY-nY)<=2 then ForgeID=nID break end
      end
      if not ForgeID then print("NO FORGE FOUND") pause() end
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if ( nType == OreTypes[1] or nType == OreTypes[2] or nType == OreTypes[3] or nType == OreTypes[4]) and (nContID==UO.BackpackID or nContID==B1.BackpackID) then
          while Smelt(ForgeID,nID)~="depleted" do end wait(250)
        end
      end                 
      B1:Mount()
    
      print("BANK!")
      for OkX=-1,1 do for OkY=-1,1 do
        if IsOK(Nodes[BankIndex[bi]].X+OkX,Nodes[BankIndex[bi]].Y+OkY,true,false,Nodes[BankIndex[bi]].Z,Nodes[BankIndex[bi]].Z+16) then 
          Pathfind(Nodes[BankIndex[bi]].X+OkX,Nodes[BankIndex[bi]].Y+OkY,Nodes[BankIndex[bi]].Z,-1,true)
          break
        end
      end end
      Dismount()     
      B1:OpenPack() 
      local nCnt = UO.ScanItems(true) 
      
      
      UO.Msg("bank"..string.char(13))
      wait(250)
      if UO.ContID==B1.BackpackID then UO.Msg("bank"..string.char(13)) wait(1000) end
      local bankid=UO.ContID
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if ( nType == OreTypes[1] or nType == OreTypes[2] or nType == OreTypes[3] or nType == OreTypes[4] or nType == 7154 ) and (nContID==UO.BackpackID or nContID==B1.BackpackID) then
          --move nid
          UO.Drag(nID,nStack)    
          wait(250)
          UO.DropC(bankid)
          wait(500)
        end
      end
      B1.Weight=0                             
      B1:Mount()
      local nCnt = UO.ScanItems(true) 
      for i=1,nCnt do
        nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
        if nType == 7154 and nContID==bankid and nCol==0 then
          --move nid
          UO.Drag(nID,30)    
          wait(250)
          UO.DropC(UO.BackpackID)
          wait(500)
        end
      end
      
      
      
      
    end
   
   
   
   
   
   
   
    print(i..": "..Nodes[i].Label.."  "..Nodes[i].X.."  "..Nodes[i].Y.."  "..Nodes[i].Z.."  "..Nodes[i].Facet.."  "..Nodes[i].Action.."  "..Nodes[i].Col.."  "..Nodes[i].Scale.."  "..Nodes[i].Width)
    if Nodes[i].Action=="Pathfind" then 
      B1:Mount()
      while UO.CharPosX ~= Nodes[i].X or UO.CharPosY ~= Nodes[i].Y do Pathfind(Nodes[i].X,Nodes[i].Y,Nodes[i].Z,-1,false) end
      print("pathfind!") 
    end
    if Nodes[i].Action=="Mine" then
      Dismount()
      miningresult=true
      while miningresult do
        while CheckWeight()=="Beetle" do --UO.Weight >= UO.MaxWeight - 4*16 then
          Dismount()
          local nCnt = UO.ScanItems(true)
          for i=1,nCnt do
            nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
            if ( nType == OreTypes[1] or nType == OreTypes[2] or nType == OreTypes[3] or nType == OreTypes[4] ) and nContID==UO.BackpackID then
              B1:Take(nID,nStack)
              print(B1.Weight)
            end
            if CheckWeight()~="Beetle" then break end
          end  
        end
        if CheckWeight()=="Bank" then B1:Mount() break end
        miningresult=Mine({X=Nodes[i].X,Y=Nodes[i].Y,Z=GetLandTileZ(Nodes[i].X,Nodes[i].Y)})
        --print("mine!")
        if miningresult=="depleted" then miningresult=false end
      end
    end

  end
end