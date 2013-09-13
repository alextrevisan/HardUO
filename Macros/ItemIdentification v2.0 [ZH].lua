--===========================================================================--
-- Macro: Item ID.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: usa Item ID em itens na bag e equipados. Dê play e seja feliz
--===========================================================================--
while true do
    items = ScanItems(true,{ContID={UO.BackpackID,UO.CharID}})
    for i=1,#items do
        useItemIdentification()
        wait(250)
        UO.LTargetID = items[i].ID
        EventMacro(22, 0)
        wait(10000)
    end
end