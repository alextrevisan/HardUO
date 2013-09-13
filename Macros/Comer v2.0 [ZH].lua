--===========================================================================--
-- Macro: Comer.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Deixe a comida na bag, ele ira comer a cada 10 segundos 
--            se estiver com fome
--===========================================================================--
mFoodTypes = typeConverter("RUD_FUD_BDF_GQE_IQE_ZPE_SQD_OQE_KPE_VQE_TQE_YSD_JQE_YWI_AXI_PQD_QQD_MQE_SPE_RQE_END_RGG_AQD_FUD_ZBG_WLI_QRD_YLI_NRD_PRD_XLI_ACG_IGI_GUD_HND_QSD")

local nNewRef = 0
function getMsg()
    nNewRef, nCnt= UO.ScanJournal(nNewRef) 
    local sLine = UO.GetJournal(0)
    local a = {}
    while nCnt > 0 do
        a[nCnt] = UO.GetJournal(nCnt)
        nCnt = nCnt -1
    end
    return a
end
function findMsg(mstr, find)
    for i=1, #mstr do
        for n=1,#find do
            if(string.find(mstr[i],find[n])) then
                return true
            end
        end
    end
end

while true do
    UO.Msg(".hungry"..string.char(13))
    wait(1000)
    journal = getMsg()
    if(findMsg(journal,{"stuffed"})~=true) then
        print("Comendo...")
        food = ScanItems(true,{Type=mFoodTypes,ContID=UO.Backpack})
        if #food > 0 then
            UO.LObjectID = food[1].ID
            EventMacro(17,0)
        end
    end
    wait(30000)
end