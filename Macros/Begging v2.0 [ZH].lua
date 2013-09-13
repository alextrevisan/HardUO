--===========================================================================--
-- Macro: Begging.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.1
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descrição: Configure a quantidade de NPCs na variavel "numeroNPCs" fique 
--              perto dos NPCs e de play. Selecione os NPCs e ele vai inciiar
--===========================================================================--
numeroNPCs = 3
QuantidadeDeGold = 100
NPC = {}
mBankBag = 0

function GuardaGold()
    UO.Move(2531,551,0,15000)
    UO.Move(2531,558,0,15000)
    porta = ScanItems(true,{ID=1083084473})
    if porta[1].Type == 1701 then
        UO.LObjectID = porta[1].ID
        EventMacro(17, 0)
    end
    UO.Move(2531,560,0,15000)
    UO.Move(2511,560,0,15000)
    Speak("bank")
    wait(500)
    golds = ScanItems(true,{Type=3821})
    UO.Drag(golds[1].ID,golds[1].Stack)
    wait(250)
    UO.DropC(mBankBag)
    wait(250)
    UO.Move(2531,560,0,15000)
    porta = ScanItems(true,{ID=1083084473})
    if porta[1].Type == 1701 then
        UO.LObjectID = porta[1].ID
        EventMacro(17, 0)
    end
    UO.Move(2531,558,0,15000)
    UO.Move(2531,551,0,15000)
end
Speak("bank")
UO.SysMessage("Selecione a bag de gold")
UO.TargCurs = true
while UO.TargCurs == true do
    wait(10)
end
mBankBag = UO.LTargetID
UO.SysMessage("Ande ate o local e pressione ENTER")
while getkey(KEY_ENTER) ~=true do wait(10) end
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
        UO.SysMessage("Pedindo para o NPC numero "..i)
        useBegging()
        wait(450)
        UO.LTargetID = NPC[i]
        EventMacro(22, 0)
        wait(22000)
        if UO.Gold > QuantidadeDeGold then
            GuardaGold()
        end
    end
end