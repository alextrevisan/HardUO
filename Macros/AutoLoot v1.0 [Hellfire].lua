local lootBag = {1074171062}
local gold = 3821
local bolt = 7163
local arrow = 3903
local potion = 3849
local userLoot = {gold, bolt, arrow, potion, 6884, 8031,4030}
local waitdragdrop = 300
Ignore = {}
local function IgnoreItems(itemid)
    Ignore[#Ignore+1] = itemid
end
function lootFrom(bagid)
--Loot userLoot
    local loot = ScanItems(true,{ContID=bagid, Type=userLoot,Kind=0})
    for i=1, #loot do
        UO.Drag(loot[i].ID, loot[i].Stack)
        wait(waitdragdrop)
        UO.DropC(lootBag)
        wait(waitdragdrop)
    end
end
function LookForCorpse()
       local corpsetypes = typeConverter("YFM_")
       local t = ScanItems(true,{Type=corpsetypes,Dist=3,Kind=1},{ID=Ignore})
       UO.SysMessage("Encontrado "..#t.." corpos")
       for i=1, #t do
           UO.LObjectID = t[i].ID
           IgnoreItems(t[i].ID)
           UO.NextCPosX= 656
           UO.NextCPosY= 388
           UO.Macro(17,0)
           wait(waitdragdrop+500)
           lootFrom(t[i].ID)
           local bagloot = ScanItems(true,{ContID=t[i].ID, Type={3701}},{ID=Ignore})
           UO.SysMessage("Encontrado "..#bagloot.." bags")
           for i=1, #bagloot do
               UO.SysMessage("Abrindo bag de loot")
               UO.LObjectID = bagloot[i].ID
               IgnoreItems(bagloot[i].ID)
               UO.NextCPosX= 656
               UO.NextCPosY= 388
               UO.Macro(17,0)
               wait(waitdragdrop+500)
               lootFrom(bagloot[i].ID)
               UO.Click(730, 440 ,false,true,true,false)
           end
           UO.Click(730, 440 ,false,true,true,false)
       end
end

while true do
    LookForCorpse()
    wait(2500)
end