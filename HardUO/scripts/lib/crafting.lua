if CRAFTINIT then return true end
CRAFTINIT = true  
dofile(getinstalldir().."Scripts/Kal In Ex/FindItems.lua") 
dofile(getinstalldir().."Scripts/Kal In Ex/KALOCR.lua") 
dofile(getinstalldir().."Scripts/Kal In Ex/journal.lua")      
dofile(getinstalldir().."Scripts/wvanderzalm/std.lua") 

---------------------------------------------------------------------------
--[[ Load Crafting Files ]]------------------------------------------------
---------------------------------------------------------------------------
if UO.Shard=="" then print("No Shard Selected! Shutting down!") stop() end

local f = openfile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua")
if f then                                 
  f:close()                 
  dofile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua")
  print("CraftInfo file for \""..UO.Shard.."\" has been loaded...")
else        
  local f = openfile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua","w+b")
  f:write("craftinfo={}")
  f:close()                                  
  dofile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua")
  print("CraftInfo file for \""..UO.Shard.."\" has been CREATED!")
end


CraftingObject=class()

function CraftingObject:Using(using)
  local Menu
  for i=1,table.getn(using) do               
    if not craftinfo[using[i]] then
      print("---------------------ALERT---------------------")
      print("No \""..using[i].."\" Information, Build now?")
      print("Open crafting menu THEN hit PLAY in OEUO, leave script alone till done") 
      print("This works best if the menu is placed over a Solid non-white surface")
      pause()
      Menu=self:BuildTrade()
      local a,b=string.find(Menu.title," MENU")
      local CraftingSkill=string.lower(string.sub(Menu.title,1,a-1)  )
      craftinfo[CraftingSkill]=Menu   
      local f = openfile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua","w+b")
      f:write( "craftinfo="..TableToString(craftinfo))
      f:close()                  
      dofile(getinstalldir().."Scripts/wvanderzalm/"..UO.Shard.."-CraftInfo.lua")                              
    end
  end
end 
function CraftingObject:__init()
  self.tooltypes ={}
  self.materialtypes ={}
  self.Journal=journal:new()
  
--Menu functions  
  self.Menu={    
  GetSuccess=function()          return KAL.ReadText(UO.ContPosX+170, UO.ContPosY+295,"IN",16777215,"text",350,"   ") end,  
  GetCategory=function(n)        return KAL.ReadText(UO.ContPosX+50, UO.ContPosY+63+n*20,"IN",16777215,"text",150,"   ") end,
  GetSelection=function(n)       return KAL.ReadText(UO.ContPosX+255, UO.ContPosY+63+n*20,"IN",16777215,"text",250,"   ") end,
  GetNextPage=function()         if KAL.ReadText(UO.ContPosX+405,UO.ContPosY+263,"IN",16777215,"text",62,"   ") == "NEXT PAGE" then return true end return false end,
  GetPrevPage=function()         if KAL.ReadText(UO.ContPosX+255,UO.ContPosY+263,"IN",16777215,"text",63,"   ") == "PREV PAGE" then return true end return false end,
  
  GetMaterial=function()         return KAL.ReadText(UO.ContPosX+50,UO.ContPosY+365,"IN",16777215,"text",120,"   ") end,   
  GetMaterialScales=function()   return KAL.ReadText(UO.ContPosX+50,UO.ContPosY+385,"IN",16777215,"text",120,"   ") end,
  GetUseMaterialColor=function() return KAL.ReadText(UO.ContPosX+255, UO.ContPosY+63+200,"IN",16777215,"text",250,"   ") end, 
  GetMarkItem=function()         return KAL.ReadText(UO.ContPosX+305,UO.ContPosY+365,"IN",16777215,"text",120,"   ") end,  
--Details page
  GetSkillToMake=function(n)     return KAL.ReadText(UO.ContPosX+170,UO.ContPosY+132+n*20,"IN",16777215,"text",350,"   "),tonumber(KAL.ReadText(UO.ContPosX+431,UO.ContPosY+133+n*20,"IN",16250871,"NUMBER",350,"   ")) end,
  GetMaterialToMake=function(n)  return KAL.ReadText(UO.ContPosX+170,UO.ContPosY+219+n*20,"IN",16777215,"text",350,"   "),tonumber(KAL.ReadText(UO.ContPosX+431,UO.ContPosY+220+n*20,"IN",16250871,"NUMBER",350,"   ")) end,
  GetOther=function(n)           return KAL.ReadText(UO.ContPosX+170, UO.ContPosY+302+n*20,"IN",16777215,"text",350,"   ") end, 
--Title of trade menu
  GetMenuTitle=function()   
    local MenuStart,MenuTextSize=0,34    
    for X=280,299 do 
      local temp= KAL.ReadText(UO.ContPosX+X,UO.ContPosY+12,"IN",16777215,"text",MenuTextSize-2,"   ")  
      if temp=="MENU" then  
        MenuStart=X
        break
      end
    end
    if MenuStart==280 then MenuStart=281 end
    local Diff=(MenuStart+MenuTextSize)-UO.ContSizeX/2
    if MenuStart==0 then
      print("Error, Unable to find menu Title")
      return false
    else  
      return KAL.ReadText(UO.ContPosX+UO.ContSizeX/2-Diff,UO.ContPosY+12,"IN",16777215,"text",270,"   ")  
    end
  end, 
  GetGumpInfo=function()
    for i=0,999 do
      local Name,X,Y,SX,SY=UO.GetCont(i)
      if X==nil then return false end
      if SX==530 and SY==437 then      
        return "main"      
      elseif SX==530 and SY==417 then
        return "details"
      end
    end
  end,
  BringToFront=function()
    for i=0,999 do
      local Name,X,Y,SX,SY=UO.GetCont(i)
      if X==nil then return false end
      if (SX==530 and SY==437) or (SX==530 and SY==417) then
        UO.ContTop(i)
        return true
      end
    end
  end,
          
--Functions to Click/Use the menu
  Smelt=function()
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+25,UO.ContPosY+355) if not NotWaitForCont(530,437,4000) then return false end wait(50) return true end,
  Repair=function()
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+285,UO.ContPosY+355) if not NotWaitForCont(530,437,4000) then return false end wait(50) return true end,
  Enhance=function()
    print("Note: Need help with this command, I dont play post-aos")
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+285,UO.ContPosY+395) if not NotWaitForCont(530,437,4000) then return false end wait(50) return true end,
  Last=function()      
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+285,UO.ContPosY+415) if not WaitForCont(530,437,4000) then return false end wait(50) return true end,
  Category=function(n) 
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+25,UO.ContPosY+70+20*n) if not WaitForCont(530,437,4000) then return false end wait(50) return true end,
  Material=function() 
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+25,UO.ContPosY+375) if not WaitForCont(530,437,4000) then return false end wait(50) return true end,
  NextPage=function()  
    if not self.Menu.GetNextPage() then return false end 
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+385,UO.ContPosY+270) if not WaitForCont(530,437,4000) then return false end wait(100) return true end,
  PrevPage=function()                      
    if not self.Menu.GetPrevPage() then return false end        
    if not WaitForCont(530,437,4000) then return false end LClick(UO.ContPosX+235,UO.ContPosY+270) if not WaitForCont(530,437,4000) then return false end wait(100) return true end,
  Selection=function(n)   
    if UO.ContSizeX==530 and UO.ContSizeY==417 then self.Menu.Back() end       
    if not WaitForCont(530,437,4000) then return false end 
    for i=1,n/10 do self.Menu.NextPage() end 
    LClick(UO.ContPosX+235,UO.ContPosY+70+20*math.mod(n,10))
    if not NotWaitForCont(530,437,4000) then return false end    
    wait(50) return true end,
  Details=function(n)   
    if UO.ContSizeX==530 and UO.ContSizeY==417 then self.Menu.Back() end 
    if not WaitForCont(530,437,4000) then return false end 
    for i=1,n/10 do self.Menu.NextPage() end 
    LClick(UO.ContPosX+495,UO.ContPosY+70+20*math.mod(n,10)) 
    if not WaitForCont(530,417,4000) then return false end wait(50) return true end,
  Back=function() 
    if UO.ContSizeX==530 and UO.ContSizeY==437 then return true end 
    if not WaitForCont(530,417,4000) then return false end LClick(UO.ContPosX+30,UO.ContPosY+400) if not WaitForCont(530,437,4000) then return false end wait(50) return true end,
  MakeNow=function()                    
    if not WaitForCont(530,417,4000) then return false end LClick(UO.ContPosX+285,UO.ContPosY+400) if not NotWaitForCont(530,417,4000) then return false end return true end,   
--advanced  
  SetMaterial=function(arg)
    if UO.ContSizeX==530 and UO.ContSizeY==417 then self.Menu.Back() end 
    if not WaitForCont(530,437,4000) then return false end 
    local OldRes=self.Menu.GetMaterial()
    OldRes=OldRes:sub(1,OldRes:find(" ")-1) 
    if type(arg)=="number" then  
      if not self.Menu.Material() then return false end        
      local NewRes=self.Menu.GetSelection(arg)
      if NewRes=="" then return false end
      NewRes=NewRes:sub(1,NewRes:find(" ")-1) 
      if OldRes:lower()==NewRes:lower() then return true end
      if not self.Menu.Selection(arg) then return false end 
      if not WaitForCont(530,437,4000) then return false end 
      wait(100)   
      OldRes=self.Menu.GetMaterial()           
      if OldRes:sub(1,OldRes:find(" ")-1)==NewRes then return true end
      return false     
    elseif type(arg)=="string" then
      arg=arg.." "
      local str=arg:sub(1,arg:find(" ")-1)
      if str==OldRes:lower() then return true end
      if not self.Menu.Material() then return false end 
      for i=0,999 do      
        local NewRes=self.Menu.GetSelection(i)   
        if NewRes=="" then return false end  
        NewRes=NewRes:sub(1,NewRes:find(" ")-1)
        if str:lower()==NewRes:lower() then
          if not self.Menu.Selection(i) then return false end 
          if not WaitForCont(530,437,4000) then return false end 
          wait(100)
          OldRes=self.Menu.GetMaterial()   
          if str==OldRes:sub(1,OldRes:find(" ")-1) then return true end
          return false
        end   
      end 
    end
  end,
  Resmelt=function(ID) 
   -- if self.BulkOrder.Items[0].Amount>=self.BulkOrder.AmountToMake then return false end
    self.Menu.Smelt()
    if not WaitForTarg(4000) then return false end       
    if UO.TargCurs then Target(ID) else return false end
    --wait(50)     
    return true   
  end,
  } 
---------------------------------------------------------------------------
--[[ Bulk Order Deeds! ]]--------------------------------------------------
---------------------------------------------------------------------------
  self.BulkOrder={
  Exit=function() 
    if not WaitForCont(self.BulkOrder.Width,self.BulkOrder.Height,4000) then return false end LClick(self.BulkOrder.Left+145,self.BulkOrder.Top+self.BulkOrder.Height-50) if not NotWaitForCont(self.BulkOrder.Width,self.BulkOrder.Height,4000) then return false end wait(50) return true end,
  GetAmountFinished=function(n) 
    return tonumber(KAL.ReadText(self.BulkOrder.Left+276, self.BulkOrder.Top+97+n*24,"IN",16250871,"number",50,"   ")) end, 
  GetItemRequested=function(n) 
    return KAL.ReadText(self.BulkOrder.Left+75,self.BulkOrder.Top+96+n*24,"IN",16777215,"text",120,"   ") end,   
  GetAmountToMake=function() 
    return tonumber(KAL.ReadText(self.BulkOrder.Left+276, self.BulkOrder.Top+49,"IN",16250871,"number",50,"   ")) end, 
  GetRequirements=function(n) 
    return KAL.ReadText(self.BulkOrder.Left+75,self.BulkOrder.Top+96+(self.BulkOrder.ItemCnt+n+1)*24,"IN",16777215,"text",300,"   ") end,   
  GetItemCount=function() 
    self.BulkOrder.ItemCnt=(self.BulkOrder.Height-(251))/24 return self.BulkOrder.ItemCnt end,
  GetGumpInfo=function()
    for i=0,999 do
      local Name,X,Y,SX,SY=UO.GetCont(i)
      if X==nil then return false end
      if SX==self.BulkOrder.Width and Name=="generic gump" then
        self.BulkOrder.Height=SY
        self.BulkOrder.Left=X
        self.BulkOrder.Top=Y
        return true
      end
    end
  end,
  Set=function(ID)   
    local invalid_selection="[\`\~\!\?\@\#\$\%\^\&\*\(\)\-\_\+\=\{\}\<\>\:\;\|\\\/]"
    self.BulkOrder.ID=ID  
    self.BulkOrder.Width=510  
    self.BulkOrder.Exceptional=false
    self.BulkOrder.Material="iron" 
    self.BulkOrder.ItemCnt=0
    self.BulkOrder.Items={} 
    self.BulkOrder.AmountToMake=0
    while not self.BulkOrder.GetGumpInfo() do DClick(ID) wait(100) end        
    self.BulkOrder.GetItemCount()
    for i=0,99 do   
      local Requ=self.BulkOrder.GetRequirements(i)
      print(Requ)
      if Requ=="" then break end
      if Requ=="All items must be exceptional." then self.BulkOrder.Exceptional=true end
      if Requ:sub(1,28)=="All items must be made with " then self.BulkOrder.Material=Requ:sub(29,Requ:find("ingots")-2) end  
    end
    for i=0,self.BulkOrder.ItemCnt do
      self.BulkOrder.Items[i]={Name=self.BulkOrder.GetItemRequested(i),Amount=self.BulkOrder.GetAmountFinished(i)}
      --while string.find(self.BulkOrder.Items[i].Name,invalid_selection) do self.BulkOrder.Items[i].Name=self.BulkOrder.GetItemRequested(i) end
    end
    self.BulkOrder.AmountToMake=self.BulkOrder.GetAmountToMake()
  end,
  Combine=function(ID) 
   -- if self.BulkOrder.Items[0].Amount>=self.BulkOrder.AmountToMake then return false end
    if not WaitForCont(self.BulkOrder.Width,self.BulkOrder.Height,4000) then return false end  
    self.BulkOrder.Items[0].Amount=self.BulkOrder.GetAmountFinished(0)
    if UO.TargCurs then Target(ID) wait(50) else
      LClick(self.BulkOrder.Top+145,self.BulkOrder.Top+self.BulkOrder.Height-70) 
      if not WaitForTarg(4000) then return false end       
      if UO.TargCurs then Target(ID) else return false end  
    end                                            
    if not WaitForCont(self.BulkOrder.Width,self.BulkOrder.Height,4000) then return false end   
    if not WaitForFunction(self.BulkOrder.GetAmountFinished,self.BulkOrder.Items[0].Amount+1,4000,0) then return false end  
    self.BulkOrder.Items[0].Amount=self.BulkOrder.GetAmountFinished(0)
    --wait(50)     
    return true   
  end,
  BringToFront=function()
    for i=0,999 do
      local Name,X,Y,SX,SY=UO.GetCont(i)
      if X==nil then return false end
      if SX==self.BulkOrder.Width and SY==self.BulkOrder.Height then
        UO.ContTop(i)
        return true
      end
    end
  end,
  
  
  }
---------------------------------------------------------------------------
--[[ Bulk Order Books! ]]--------------------------------------------------
---------------------------------------------------------------------------
  self.BulkOrderBook={}

  
  self.Make=function(str)
  end
  
  
end
function ResolveNames(comp,str)  
--local str="Bread loa%ves/f%"
local Root,Plural,Singular,Suffix="","","",""
local a,b=str:find("%%.+%%")--"[\%_]")
if a then 
  Plural=str:sub(a+1,b-1) 
  Root=str:sub(1,a-1)  
  Suffix=str:sub(b+1,str:len())
  a,b=Plural:find("/")
  if a then 
    Singular=Plural:sub(a+1,Plural:len())
    Plural=Plural:sub(1,a-1)
  end
else
  Root=str
end
--print("Singular :  "..Root..Singular..Suffix)
--print("Plural   :  "..Root..Plural..Suffix)
if comp==Root..Singular..Suffix 
or comp==Root..Plural..Suffix 
or comp==Root..Suffix then return true end
return false
end

function CompNameToStaticName(str,str2)
array1={}
array2={}
for W in str:gmatch("%s*(%w+)%s*")  do
  table.insert(array1,W)
end
for W in str2:gmatch("%s*([%w%p]+)%s*")  do
  table.insert(array2,W)
end    
if #array1~=#array2 then return false end
for i=1,#array1 do
  if not ResolveNames(array1[i],array2[i]) then return false end
end
return true
end

GetTypeFromName =function(str)
print(str)
  local Types={}
  for i=0,16382 do
    local name=GetStaticTileData(i)
    if name:sub(1,1)==str:sub(1,1) then
      if CompNameToStaticName(str,name) then table.insert(Types,i) end
    end
  end
  return Types
end

function WaitForTarg(t,arg)
  Timeout = getticks() + t  
  if arg==false then                                            
    while Timeout > getticks() and UO.TargCurs do wait(50) end
    if UO.TargCurs then return false end
  else                                                             
    while Timeout > getticks() and not UO.TargCurs do wait(50) end
    if not UO.TargCurs then return false end
  end 
  return true
end  
function WaitForCont(x,y,t)
  Timeout = getticks() + t                                              
  while Timeout > getticks() and UO.ContSizeX ~= x and UO.ContSizeY ~= y do wait(50) end
  if UO.ContSizeX ~= x and UO.ContSizeY ~= y then return false end 
  return true
end
function WaitForFunction(func,Wanting,t,arg)
    local Timeout = getticks() + t                    ----****************************************************************************************************************
    while Timeout > getticks() and Wanting~=func(arg) do wait(50) end
    if func(arg)~=Wanting then return false end
    return true
end
function NotWaitForCont(x,y,t)
  Timeout = getticks() + t                                              
  while Timeout > getticks() and UO.ContSizeX == x and UO.ContSizeY == y do wait(50) end
  if UO.ContSizeX == x and UO.ContSizeY == y then return false end 
  return true
end
function GetTypeFromID(ID)
  nCnt = UO.ScanItems(false) for i=0,nCnt-1 do nID,nType= UO.GetItem(i) if nID == ID then return nType end end return false end
  
function CraftingObject:BuildTrade()
  local invalid_selection="[\`\~\!\?\@\#\$\%\^\&\*\(\)\-\_\+\=\{\}\<\>\:\;\|\\\/]"
  local Current={}
  local UnknownIndex={}
  Current.size=0  
  Current.title=self.Menu.GetMenuTitle()
  if Current.title=="" then return false end
  Current.categories={}
  Current.index={}
  for Cat=1,10 do --------------------------------------------------------------------<<--<<--<-<--Change to 0->10 to include "LAST TEN"
    local temp=self.Menu.GetCategory(Cat) 
    if temp ~= "" then  
      Current.size=Current.size+1
      Current.categories[Cat]={}
      Current.categories[Cat].name=temp  
      Current.categories[Cat].selections={} 
      Current.categories[Cat].size=0
      self.Menu.Category(Cat)  
      Timeout = getticks() + 4000
      while Timeout > getticks() and ( UO.ContSizeX ~= 530 or UO.ContSizeY ~= 437) do wait (50) end 
      wait(100)
      local page=0
      repeat
        local Rep=false
        for i=0,9 do 
          if page > 0 then
            for a=1,math.floor(page/10) do
              self.Menu.NextPage()                   
              if not WaitForCont(530,437,4000) then print("Dong") end  
              wait(50)
            end
          end
          wait(100)
          local temp=self.Menu.GetSelection(i) 
          if (temp:len()<3 or temp:find(invalid_selection))and not temp==" uu^/6 uuuu uuu6uuw Ju" then
            while (temp:len()<3 or temp:find(invalid_selection))and not temp==" uu^/6 uuuu uuu6uuw Ju" do 
              temp=self.Menu.GetSelection(i)
            end
          end         
          if temp==" uu^/6 uuuu uuu6uuw Ju" then
            Current.categories[Cat].size=Current.categories[Cat].size+1
            Current.categories[Cat].selections[i+page]={}
            Current.categories[Cat].selections[i+page].name="You haven't made anything yet."    
          elseif temp~="" then     
            Current.categories[Cat].size=Current.categories[Cat].size+1
            Current.categories[Cat].selections[i+page]={}
            Current.categories[Cat].selections[i+page].name=temp
            local Types=GetTypeFromName(temp)
            if #Types>0 then
              Current.categories[Cat].selections[i+page].types=Types
            else
              Current.categories[Cat].selections[i+page].types={}
              table.insert(UnknownIndex,{Cat,i+page})
            end
            Current.categories[Cat].selections[i+page].skills={}
            Current.categories[Cat].selections[i+page].materials={} 
            Current.categories[Cat].selections[i+page].retainsmaker=false
            Current.categories[Cat].selections[i+page].retainscolor=false 
            Current.index[temp]={Cat,i+page}             
            self.Menu.Details(i) 
            for a=0,10 do
              local tempSkill,cnt=self.Menu.GetSkillToMake(a)
              if tempSkill=="" then break end
              table.insert(Current.categories[Cat].selections[i+page].skills,{name=tempSkill,amount=cnt})
            end
            for a=0,10 do
              local tempMaterial,cnt=self.Menu.GetMaterialToMake(a)
              if tempMaterial=="" then break end
              table.insert(Current.categories[Cat].selections[i+page].materials,{name=tempMaterial,amount=cnt})
            end     
            for a=0,10 do
              local tempOther=self.Menu.GetOther(a)
              if tempOther=="" then break 
              elseif tempOther=="This item may hold its maker's mark" then
                Current.categories[Cat].selections[i+page].retainsmaker=true
              elseif tempOther=="* The item retains the color of this material" then
                Current.categories[Cat].selections[i+page].retainscolor=true  
              end
            end
            self.Menu.Back()
          else
            break
          end
        end
        if self.Menu.GetNextPage() then  
          page=page+10
          Rep=true
        end
      until not Rep
    end
  end 
  if #UnknownIndex > 0 then
    --print(  "Excuse me, I was unable to kind any Types for the following...    ("..#UnknownIndex.." total)")
    --for i=1,#UnknownIndex do
    --  print("'"..Current.categories[UnknownIndex[i][1]].selections[UnknownIndex[i][2]].name.."'")
    --  print("Would you be so kind as to point them out? or type them in?...    ("..i.."/"..#UnknownIndex..")")
    --  while true do
    --    UO.TargCurs=true
    --    local tempLtargID=UO.LTargetID
    --    while UO.TargCurs do wait(50) end
    --    if tempLtargID==UO.LTargetID then 
    --      print("We will leave this as '{}' for now...")
    --      break
    --    else 
    --      local type=GetTypeFromID(UO.LTargetID)
    --      table.insert(Current.categories[UnknownIndex[i][1]].selections[UnknownIndex[i][2]].types,type)
    --      print(type.." added")   
    --         
    --    end
    --  end
    --end
  end  
  --self.Menu.Close()
  return Current  
end
function Craft_ItemName(craft,str)
  local index=craftinfo[craft].index[str]
  local Types=craftinfo[craft].categories[index[1]].selections[index[2]].types  
  local total,total2,Timeout=0,0,0
  local Exceptional=false
  local PackList={}
  local nCnt = UO.ScanItems(false)  
  if Types=={} then
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nContID==UO.BackpackID then table.insert(PackList,{nID,nStack}) end
    end   
  else
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nContID==UO.BackpackID then 
        for i=1,#Types do if Types[i]==nType then table.insert(PackList,{nID,nStack}) break end end
      end
    end   
  end 
  
  Crafter.Journal:clear()
  Crafter.Menu.Category(craftinfo[craft].index[str][1])
  Crafter.Menu.Selection(craftinfo[craft].index[str][2])       
  if not WaitForCont(530,437,4000) then 
    while Crafter.Journal:next() do   
      print("success="..Crafter.Journal:last())
      if string.find(Crafter.Journal:last(),"You have worn out your tool!") then
      ------------------
      end      
      if string.find(Crafter.Journal:last(),"You create an exceptional quality item and affix your maker's mark.") 
      or string.find(Crafter.Journal:last(),"You create an exceptional quality item.") then   
        Exceptional=true
        break                       
      elseif string.find(Crafter.Journal:last(),"You failed to create the item, and some of your materials are lost.")   
      or string.find(Crafter.Journal:last(),"You don't have the required skills to attempt this item.")   
      or string.find(Crafter.Journal:last(),"You do not have sufficient metal to make that.")   
      or string.find(Crafter.Journal:last(),"You do not have enough dragon scales to make that.") then  
        return false  
      end
    end
    print("Menu not pop up, Journal skan for broken tool") 
  else
    wait(100)
    local Success=Crafter.Menu.GetSuccess()
    print("success="..Success)
    if Success=="" then
    -----------------------------
    elseif Success=="You create an exceptional quality item and affix your"-- maker's mark." 
    or Success=="You create an exceptional quality item." then
      Exceptional=true    
    elseif Success=="You failed to create the item, and some of your materials are lost." 
    or Success=="You don't have the required skills to attempt this item." 
    or Success=="You do not have sufficient metal to make that." 
    or Success=="You do not have enough dragon scales to make that." then
      return false
    end
  end
  local Cnt=#PackList
  local NewList={}
  local nCnt = UO.ScanItems(false)  
  if Types=={} then
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nContID==UO.BackpackID then table.insert(NewList,{nID,nStack}) end
    end   
  else
    for i=0,nCnt-1 do
      nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
      if nContID==UO.BackpackID then 
        for i=1,#Types do if Types[i]==nType then table.insert(NewList,{nID,nStack}) break end end
      end
    end   
  end 
  for x=1,#NewList do
    toggle=false
    for y=1,#PackList do
      if NewList[x][1]==PackList[y][1] and NewList[x][2]==PackList[y][2] then toggle=true break end
    end
    if toggle==false then print(NewList[x][1]) return NewList[x][1], Exceptional end
  end
end

--UO.CliNr=2
-----------------------------------------Script start----------------------------------------------------------------------------------------------
--[[Crafter=CraftingObject()          
Crafter:Using({"blacksmithing"})         
Crafter.BulkOrder.Set(1097583365)

print(Crafter.BulkOrder.Items[0].Name)
local TradeMenu=Crafter.Menu.GetGumpInfo()
if not TradeMenu then
  nCnt = UO.ScanItems(false)
  for i=0,nCnt-1 do
    nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol = UO.GetItem(i)
    if nContID==UO.BackpackID and nType==5091 then
      DClick(nID)
      if not WaitForCont(530,437,4000) then DClick(nID) end
      break
    end
  end
elseif TradeMenu=="details" then
  Crafter.Menu.Back()
end   

while Crafter.BulkOrder.Items[0].Amount < Crafter.BulkOrder.AmountToMake do
  Crafter.Menu.BringToFront()                                             
  if not WaitForCont(530,437,4000) then print("shit") end
  NewID, Exceptional=Craft_ItemName("blacksmithing",Crafter.BulkOrder.Items[0].name)
  if not WaitForCont(530,437,4000) then print("shit") end

  if Crafter.BulkOrder.Exceptional and not Exceptional then
    Crafter.Menu.BringToFront()
    Crafter.Menu.Resmelt(NewID)
  else
    Crafter.BulkOrder.BringToFront()
    Crafter.BulkOrder.Combine(NewID)
  end

end         ]]