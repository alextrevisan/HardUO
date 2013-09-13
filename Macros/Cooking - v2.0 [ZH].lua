while true do
    mFishTypes = {2426}
    fish = ScanItems(true,{Type=mFishTypes,ContID=UO.BackpackID})
    if #fish>0 then
        UO.LObjectID = fish[1].id
        EventMacro(17,0)
        wait(350)
        Click(70, 60, true, true, true, false)
        Click(70, 60, true, true, true, false)
        wait(4000)
    else
        UO.SysMessage("Acabaram os peixes.",65)
        print("Acabaram os peixes.")
        stop()
    end
end
