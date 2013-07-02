
--dofile(getinstalldir().."Scripts/wvanderzalm/std.lua")    
--dofile(getinstalldir().."scripts/wvanderzalm/MulHandles.lua") 
dofile(getinstalldir().."scripts/wvanderzalm/tile.lua")

 DynamicsRefresh()   
    
Layers={    
[0]='_______',
[1]='LeftHand',
[2]='RightHand',
[3]='Shoes',
[4]='Pants',
[5]='Shirt',
[6]='Hat',
[7]='Gloves',
[8]='Ring',
[9]='_Nil_',
[10]='Neck',
[11]='Hair',
[12]='Waist',
[13]='Torso',
[14]='Bracelet',
[15]='MonGen',
[16]='Beard',
[17]='Sash',
[18]='Ears',
[19]='Arms',
[20]='Back',
[21]='Backpack',
[22]='Robe',
[23]='Skirt',
[24]='Leggings',
[25]='Mount',
[26]='Vendor_Buy',
[27]='Vendor_Restock',
[28]='Vendor_Sell',
[29]='Bank',
}
Layer25={
	--[]=??? --Didnt register
	[16]=276,--11669 --"Chimera"/Raptalon Ethereal/NonEthy
	[17]=277,--11670 --CuShindhe Ethereal/NonEthy
	[18]=793,--11676 --"Charge of the fallen" Ethereal/NonEthy
	[19]="?19", --Didnt register
	[20]=243,--10090 --Hiryu
	[21]="?21", --Didnt register (But i look like im riding)
	[22]="?22", --Didnt register
	[23]=195,--9743 --Giant Beetle Ethereal
	[24]=194,--9753 --Swamp Dragon Ethereal
	[25]="?25", --Didnt register
	[26]=193,--9749 --Ridge Back Ethereal
	[27]=192,--9678 --Unicorn Ethereal
	[28]=191,--9632 --Kirin Ethereal
	[29]="?29", --??Ethereal Horse??
	[30]=190, --Fire Steed
	[31]=200, --Horse Dappled Brown
	[32]=226, --Horse Dappled Grey
	[33]=228, --Horse Tan
	[34]=204, --Horse Dark Brown
	[35]=210, --Desert Ostard
	[36]=219, --Frenzied Ostard
	[37]=218, -- Forest Ostard 
	[38]=220, --Ridable Llama
	[39]="?39", --[177 or 178 or 114 or 116??] --(NonPure Mare)
	[40]=117, --Silver Steed
	[41]=178, --Nightmare3 (used "get body")
	[42]=226,--8413 --Horse Ethereal
	[43]=170,--8438 --Llama Ethereal
	[44]=171,--8501 --Ostard Ethereal
	[45]=191,--Kirin 
	[46]="?46", --Didnt register
	[47]=120, --minax
	[48]=121, --Shadow Lords
	[49]=119, --COM
	[50]=118, --TB
	[51]=144, --Seahorse
	[52]=122, --Unicorn
	[53]=177, --NM of Dappled brown
	[54]=178, --NM of Tan
	[55]=179, --Nightmare4 (Pure Mare)
	[56]=188, --Savage Ridgeback
	[57]="?47", --Didnt register
	[58]=187, --Ridgeback
	[59]=319,--9751 --"hell Steed"/"Skeletal Mount"
	[60]=791, --Giant Beetle
	[61]=794, --Swamp Dragon
	[62]=799, --Scaled Swamp Dragon
	[69]=213,--8417 --Polar Bear Ethereal/NonEthy
	[70]="?70"--18168,18169 Boura Ethereal/NonEthy
}
Layer25_hue={
[0]="NoColor",
[16385]="Ethy",
[1161]="Fire",
}




function GetEquiped(id)
  local ID=id or UO.CharID    
  local Equipment={}   
  for i=1,#DynamicItemsFull do
    local P=DynamicItemsFull[i]
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol=P[1],P[2],P[3],P[4],P[5],P[6],P[7],P[8],P[9],P[10]
    if nContID==ID then 
      local Name, Flags, Height, Weight, Layer--=GetStaticTileData(nType)
      

---------------------------------------------------------------------------
--[[ Layer 25! "Mount" ]]--------------------------------------------------
---------------------------------------------------------------------------
      if ( nType>=16000)then --Mount?
        Layer=25
        local Body=Layer25[nType-16000]   
        if type(Body)=="number" then
          Name="Mount" 
          Flags=0 
          Height=0 
          Weight=0   
          nType=Body
          if Layer25_hue[nCol] then 
            nCol=Layer25_hue[nCol]
          end      
        end     
---------------------------------------------------------------------------
--[[ Layer 29! "Bank" ]]---------------------------------------------------
---------------------------------------------------------------------------
      elseif nType==3708 then --Its inside YOU, Not your backpack
        Layer=29  
        Name="Bank" 
        Flags=0 
        Height=0 
        Weight=0   
        nType=3708
        nCol=0                                                       
--------------------------------------------------------------------------- 
      else
        Name, Flags, Height, Weight, Layer=GetStaticTileData(nType)
      end 
      Equipment[Layer]={Name=Name,ID=nID,Type=nType,Weight=Weight,Color=nCol}
    end    
  end 
  Equipment[0]=getticks() --Last updated?
  return Equipment
end
    
--[[function Unequip(n) 
  if not m_Layers[n] then return true end  
  if m_objdelay < getticks() then
    MoveToCont(m_Layers[n].ID,1,m_Layers[21].ID)
    m_Layers[n]=nil
    m_objdelay=getticks()+600   
    return true
  else
    return false
  end  
  return true
end   

list=GetEquiped(UO.CharID)
verbose=false

if verbose then
print( "---------------------------------------------------------------------------","--[ [ Your Paperdoll] ]-----------------------------------------------------","---------------------------------------------------------------------------")
print("[Layer #/Name]\t[    ID    ]\t[Type]\t[Wght]\t[Color]\t[Name] ")
for i=1,29 do
if list[i] then
  print("["..i.." : "..Layers[i].."]\t["..list[i].ID.."]\t["..list[i].Type.."]\t["..list[i].Weight.."]\t["..list[i].Color.."]\t["..list[i].Name.."] ")
end
end


if list[21] then
print( "---------------------------------------------------------------------------","--[ [ Your Backpack ] ]------------------------------------------------------","---------------------------------------------------------------------------")
  local nCnt = UO.ScanItems(false)
  for i=0,nCnt-1 do
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol= UO.GetItem(i)
    if nContID==list[21].ID then
      local Name, Flags, Height, Weight, Quality=GetStaticTileData(nType)     
      if Quality>29 then Quality=0 end
      print("["..Quality.." : "..Layers[Quality].."]\t["..nID.."]\t["..nType.."]\t["..Weight.."]\t["..nCol.."]\t["..Name.."] ")
    end
  end 
end

if list[29] then
print( "---------------------------------------------------------------------------","--[ [ Your Bank Account ] ]--------------------------------------------------","---------------------------------------------------------------------------")
  local nCnt = UO.ScanItems(false)
  for i=0,nCnt-1 do
    local nID,nType,nKind, nContID, nX, nY, nZ, nStack, nRep, nCol= UO.GetItem(i)
    if nContID==list[29].ID then
      local Name, Flags, Height, Weight, Quality=GetStaticTileData(nType) 
      if Quality>29 then Quality=0 end
      print("["..Quality.." : "..Layers[Quality].."]\t["..nID.."]\t["..nType.."]\t["..Weight.."]\t["..nCol.."]\t["..Name.."] ")
    end
  end 
end

end      ]]--