--===========================================================================--
-- Macro: Poison.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Casta Poison no personagem selecionado
--===========================================================================--
UO.SysMessage("Clique no char que quer castar InNox...")
UO.TargCurs = 1
while UO.TargCurs == 1 do
    wait(10)
end
Boneco = UO.LTargetID
while true do
    if UO.Hits > UO.MaxHits - 10 then
        castPoison()
        wait(2000)
        UO.LTargetID = Boneco
        EventMacro(22,0)
        wait(5000)
    end
    while UO.Mana < 10 do
        useMeditation()
        wait(3000)
    end
end