local lootBag = 1074733081
               --gold, bolt, arrow, potion
local loot     = {3821, 7163, 3903, 3849}
local jewels   = {3864, 3857, 3859, 3878, 3855, 3861, 3862, 3856, 3877} --pe,tu,bd,fr,ba,ec,ds, fe
local food     = typeConverter("RUD_FUD_BDF_GQE_IQE_ZPE_SQD_OQE_KPE_VQE_TQE_YSD_JQE_YWI_AXI_PQD_QQD_MQE_SPE_RQE_END_RGG_AQD_FUD_ZBG_WLI_QRD_YLI_NRD_PRD_XLI_ACG_IGI_GUD_HND_QSD")
local scrools  = {8012}
Ignore = {}

local userLoot = {}

for k,v in pairs(loot) do userLoot[#userLoot+1] = v end
for k,v in pairs(jewels) do userLoot[#userLoot+1] = v end
for k,v in pairs(food) do userLoot[#userLoot+1] = v end
for k,v in pairs(scrools) do userLoot[#userLoot+1] = v end

local waitdragdrop = 500
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
        wait(50)
    end
end

function LookForCorpse()
       local corpsetypes = typeConverter("YFM_")
       local t = ScanItems(true,{Type=corpsetypes,Dist=2,Kind=1},{ID=Ignore})
       for i=1, #t do
           UO.LObjectID = t[i].ID
           IgnoreItems(t[i].ID)
           UO.NextCPosX= 656
           UO.NextCPosY= 388
           UO.Macro(17,0)
           wait(waitdragdrop+500)
           lootFrom(t[i].ID)
           local bagloot = ScanItems(true,{ContID=t[i].ID, Type={3701}},{ID=Ignore})
           for i=1, #bagloot do
               UO.LObjectID = bagloot[i].ID
               IgnoreItems(bagloot[i].ID)
               UO.NextCPosX= 656
               UO.NextCPosY= 388
               UO.Macro(17,0)
               wait(waitdragdrop+600)
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