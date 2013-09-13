local Bandage = typeConverter("ZLF")
while true do
if UO.Hits < 80 then
    --WaitKey(113)
    bandage = ScanItems(true,{Type=Bandage,ContID=UO.BackpackID})
    if #bandage > 0 then
        UO.LObjectID = bandage[1].ID
        EventMacro(17,0)
        wait(250)
        UO.SysMessage("Aplicando Bandages!",65)
        EventMacro(23,0)
    end
    wait(2000)
end
wait(1000)
end