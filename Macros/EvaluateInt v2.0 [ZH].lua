--===========================================================================--
-- Macro: Eval Int.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 2.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Configure a quantidade de NPCs na variavel "numeroNPCs" fique 
--              perto dos NPCs e de play. Selecione os NPCs e ele vai inciar
--===========================================================================--
numeroNPCs = 3
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
        UO.SysMessage("Analisando o NPC numero "..i)
        UO.LTargetID = NPC[i]
        useEvaluatingIntelligence()
        wait(250)
        UO.Macro(22, 0)
        wait(22000)
    end
end