--Macro de Smeltar 1 por 1 fora de casa por Skywalker
--Servidor: TFG

--Set #SysMsgCol 1965
UO.SysMessage("#####################")
UO.SysMessage("# Macro de smeltar 1 por 1 iniciado #")
UO.SysMessage("#####################")

UO.NextCPosX = 321
UO.NextCPosY = 0
UO.Macro(9,7)
wait(150)
UO.Macro(8, 7)
wait(150)

local haveOre = true

function smelt()
    iron = ScanItems(true,{ContID={UO.BackpackID},Type={6585, 6584, 6586}})
    if #iron > 0 then
        UO.Drag(iron[1].ID, 1)
        wait(150)
        UO.DropC(UO.BackpackID,1, 1)
        wait(150)
    end

    iron = ScanItems(true,{ContID={UO.BackpackID},Type={6583}})
    if #iron > 0 then
        UO.LObjectID = iron[1].ID
        UO.Macro(17,0)
        wait(2000)
    else
        haveOre = false
    end
end

while haveOre do
    smelt()
    wait(100)
end