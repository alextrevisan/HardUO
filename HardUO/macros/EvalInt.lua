--===========================================================================--
-- Macro: Evalluate Inteligence.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul - DMS)
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Macroa a skill Evalluate Inteligence
--===========================================================================--

mFoodTypes = typeConverter("RUD_FUD_BDF_GQE_IQE_ZPE_SQD_OQE_KPE_VQE_TQE_YSD_JQE_YWI_AXI_PQD_QQD_MQE_SPE_RQE_END_RGG_AQD_FUD_ZBG_WLI_QRD_YLI_NRD_PRD_XLI_ACG_IGI_GUD_HND_QSD")

while true do
    useEvaluatingIntelligence()
    WaitTarget()
    TargetSelf()
    wait(3000)
    food = FindItem({Type=mFoodTypes,ContID=BackpackID()})
    if #food > 0 then
        setLObjectID(food[1].id)
        EventMacro(17, 0)
    end
end