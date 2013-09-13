--===========================================================================--
-- Macro: Bater em boneco.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Bate no boneco selecionado
--===========================================================================--

UO.SysMessage("Clique no boneco que quer bater...")
UO.TargCurs = 1
while UO.TargCurs == 1 do
    wait(10)
end
Boneco = UO.LTargetID
function EquipWeaponShield()
    weapon = FindItem({Type=Weapons, ContID=UO.CharID})
    if #weapon <= 0 then
        weapon = FindItem({Type=Weapons, ContID=UO.BackPackID})
        if #weapon > 0 then
            UO.LHandID = 0
            UO.RHandID = weapon[1].id
            EventMacro(24, 2)
        end
    end
    
    shield = FindItem({Type=Shields, ContID=UO.CharID})
    if #shield <= 0 then
        shield = FindItem({Type=Shields, ContID=UO.BackPackID})
        if #shield > 0 then
            UO.RHandID = 0
            UO.LHandID = shield[1].id
            EventMacro(24, 1)
        end
    end
end
while true do
    EquipWeaponShield()
    UO.LObjectID = Boneco
    EventMacro(17,0)
    wait(2000)
    Speak(".guards")
end
