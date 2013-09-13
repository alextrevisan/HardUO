--===========================================================================--
-- Macro: Guards.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 2.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Chama guards pra matar o javeiro que ta enchendo o saco
--===========================================================================--
while true do
    if UO.Hits < UO.MaxHits then
        Speak(".guards")
        wait(3000)
    end
    wait(100)
end