--===========================================================================--
-- Macro: Anatomy.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 2.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Usa skill de anatomy em NPCs ou players
--===========================================================================--
numeroNPCs = 1
NPC = {}
for i=1,numeroNPCs do
    UO.SysMessage("Selecione o NPC numero "..i)
    UO.TargCurs = true
    while UO.TargCurs == true do
        wait(10)
    end
    NPC[i] = UO.LTargetID
end

while true do
    for i=1,numeroNPCs do
        UO.SysMessage("Anatomy no NPC numero "..i)
        useAnatomy()
        wait(250)
        UO.LTargetID = NPC[i]
        EventMacro(22, 0)
        wait(10000)
    end
end