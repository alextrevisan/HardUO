dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")    
Beetle=class()
function Beetle:__init()
  self.Weight=0                
  self.MaxWeight=1600      
  self.Items=0                
  self.MaxItems=125
  mounted=IsMounted()
  if mounted and mounted.Type==791 then           
    --Mounted ID is BackPackID-1???  This is true on RUNUO servers
    self.MountedID=mounted.ID 
    Dismount()
    nCnt = UO.ScanItems(false)
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i) 
      if nX==UO.CharPosX and nY==UO.CharPosY and nType==791 then
        self.ID=nID
        break
      end
    end
    while UO.ContName~="normal gump" do UO.Popup(self.ID) end             
    self.Bonded=((UO.ContSizeY-24)/18)==11
    while (UO.ContSizeX~=230 and UO.ContSizeY~=204) or UO.ContID==UO.BackpackID do
      if self.Bonded then
        Popup(self.ID,11)
      else                                                          
        Popup(self.ID,10)                                               
      end
    end    
    self.BackpackID=UO.ContID
    self.Weight,self.Items=self:GetWeight()   
    self:Mount()     
    --wait(100)              
    if UO.ContName=="normal gump" then RClick(UO.ContPosX+5,UO.ContPosY+45) end
  else
    print("Not mounted... cant find beetle")
    pause()
  end
  self:FindInfo()
end
function Beetle:GetWeight()
  self:OpenPack()
  wait(500)
  local tempweight,tempstack=0,0
  nCnt = UO.ScanItems(false)
  for i=0,nCnt-1 do
    nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
    if nContID==self.BackpackID then  
      local Name, Flags, Height, Weight=GetStaticTileData(nType) 
      tempweight=tempweight+nStack*Weight
      tempstack=tempstack+1
    end
  end
  return tempweight, tempstack
end

  function Beetle:FindInfo()  
    nCnt = UO.ScanItems(false)
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nID == self.ID then
        self.Type,self.Kind,self.ContID = nType,nKind, nContID
        self.X,self.Y,self.Z = nX, nY, nZ
        if math.abs(self.X-UO.CharPosX) > math.abs(self.Y-UO.CharPosY) then
          self.Dist=math.abs(self.X-UO.CharPosX)
        else
          self.Dist=math.abs(self.Y-UO.CharPosY)
        end
        self.Stack,self.Rep,self.Col = nStack, nRep, nCol 
        return true
      end
    end 
    self.Dist=0
  end                                                        
  function Beetle:OpenPack()   
    local Timeout = getticks() + 3000
    self:FindInfo() 
    if self.Mounted then Dismount() end
    while UO.ContID ~= self.BackpackID and Timeout > getticks() do
      if self.Bonded then
        Popup(self.ID,11)
      else                                                          
        Popup(self.ID,10)                                               
      end
    end 
  end       
  
  function Beetle:Take(ID, Stack)
    local Stack = Stack or 60000
    local Found=false
    local Type,tStack,ContID=0,0,0
    self:FindInfo() 
    if IsMounted() then Dismount() end    
    
    local nCnt = UO.ScanItems(true)
    for i=1,nCnt do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nID == ID then
        Type=nType
        tStack=nStack
        ContID=nContID
        Found=true
        break
      end
    end
    if not Found then return false end   
    local Name, Flags, Height, Weight=GetStaticTileData(Type) 
                                                            
    if Stack > tStack then Stack = tStack end
    if self.Weight+Stack*Weight > self.MaxWeight then Stack = math.floor((self.MaxWeight - self.Weight)/Weight) end   
    
    UO.Drag(ID,Stack)
    wait(250) 
    if UO.ContID == self.BackpackID then 
      UO.DropC(self.BackpackID)
      wait(500) 
    else 
      UO.DropC(self.ID)
      wait(500) 
    end 
    local nCnt = UO.ScanItems(true)
    for i=1,nCnt do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nID == ID then
        if ContID==nContID then 
          return false
        end
        break
      end
    end
    self.Weight=self.Weight+Weight*Stack    
    self.Items=self.Items+1
    if self.Weight > self.MaxWeight then print("Warning: Beetle Weight exceeded maximum!") end     
    if self.Items > self.MaxItems then print("Warning: Beetle Item Count exceeded maximum!") end
    return true
  end

--[[     Give()
         Returns False   If Item remains in original container
         Returns True    It Item ends up in container other then original
]]--     Lowers Beetle.Weight automatically
  function Beetle:Give(ID, Stack, ContID)   
    local Found=false
    local Type,tStack,ContID=0,0,0
    local ContID=ContID or UO.BackpackID
    
    self:OpenPack()
    
    local nCnt = UO.ScanItems(true)
    for i=1,nCnt do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nID == ID then
        Type=nType
        tStack=nStack
        ContID=nContID
        Found=true
        break
      end
    end
    if not Found then return false end   
    local Name, Flags, Height, Weight=GetStaticTileData(Type) 
                                                            
    if Stack > tStack then Stack = tStack end
    if ContID == UO.BackpackID and UO.Weight+Stack*Weight > UO.MaxWeight then Stack = math.floor((UO.MaxWeight - UO.Weight)/Weight) end   
    
    UO.Drag(ID,Stack) 
    wait(250)
    UO.DropC(ContID)
    wait(500)
     
    local nCnt = UO.ScanItems(true)
    for i=1,nCnt do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nID == ID then
        if ContID==nContID then 
          return false
        end
        break
      end
    end
    self.Weight=self.Weight-Weight*Stack   
    self.Items=self.Items-1
    if self.Weight < 0 then print("Warning: Beetle Weight is bellow Zero!") end   
    if self.Items < 0 then print("Warning: Beetle Item Count is bellow Zero!") end
    return true
  end
  function Beetle:Mount()
    self:FindInfo() 
    if self.Dist<16 and self.Dist>1 then
      while self.Dist>1 do
        while not UO.TargCurs do Popup(self.ID,2) end
        Target(UO.CharID)
        Move(self.X,self.Y,100) 
        self:FindInfo() 
      end
    end
    local mounted=IsMounted()
    if mounted then
      if mounted.ID==MountedID then return true 
      else while IsMounted() do Dismount() end
      end
    end
    while not IsMounted() do DClick(self.ID) end
    return true
  end
--B1=Beetle()
--print("ID="..B1.ID,"MountedID="..B1.MountedID,"BackpackID="..B1.BackpackID,"Weight="..B1.Weight,"Items="..B1.Items)