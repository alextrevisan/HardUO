--===========================================================================--
-- Macro: Combats.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 2.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Bate, corre quando estiver com vida baixa, heala com bandagens e volta
--===========================================================================--
--Configure como Player = 1 ou Player = 2 
-- player 1 anda pro SUL
-- player 2 anda pra NORTE
Player = 1
FugirComVida = 5 --Quantidade de vida pra fugir
IniciarHeal = 25  --Quantidade de vida pra começar a se curar
BaterComVida = 60 --Quantidade de vida pra ele voltar a bater
EquiparArma = true --true ele equipa armas, false não equipa
EquiparEscudo = true --true ele equipa escudos, false não equipa

local posx = UO.CharPosX
local posy = UO.CharPosY
local Water = 60696--typeConverter("VEE")
local Bandage = 3617
local BandageSuja = 3616

local Weapons = {5114,5126,3921,3913,5091,5110}
local Shields = {7026,7027,7028}

--=====================--
--========Inicio=======--
--=====================--

function EquipWeaponShield()
    weapon = ScanItems(true,{Type=Weapons, ContID=UO.CharID})
    if #weapon <= 0 then
        weapon = ScanItems(true,{Type=Weapons, ContID=UO.BackPackID})
        if #weapon > 0 and EquiparArma then
            UO.LHandID = 0
            UO.RHandID = weapon[1].ID
            UO.Macro(24, 2)
        end
    end
    
    shield = ScanItems(true,{Type=Shields, ContID=UO.CharID})
    if #shield <= 0 then
        shield = ScanItems(true,{Type=Shields, ContID=UO.BackPackID})
        if #shield > 0 and EquiparEscudo then
            UO.RHandID = 0
            UO.LHandID = shield[1].ID
            UO.Macro(24, 1)
        end
    end
end

function Escape()
    local playerPos = {2,-2}
    UO.Move(posx,posy+playerPos[Player],0,5000)
end
function BandageClean()
    bandageSuja = ScanItems(true,{Type=BandageSuja,ContID=UO.BackpackID})
    if #bandageSuja <=0 then
        return
    end
    UO.LObjectID = bandageSuja[1].ID
    water = ScanItems(true,Water)
    if #water <= 0 then
        return
    end
    UO.Macro(17,0)
    wait(100)
    UO.LObjectID = water[1].ID
    UO.Macro(22,0)
end
function BandageSelf()
    bandage = ScanItems(true,{Type=Bandage,ContID=UO.BackpackID})
    if #bandage <=0 then
        return
    end
    UO.LObjectID = bandage[1].ID
    UO.Macro(17,0)
    wait(250)
    UO.SysMessage("Aplicando Bandages!",65)
    UO.Macro(23,0)
end
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
function Comer()
    journal = getMsg()
    if findMsg(journal,mMesssages) then

    end
end
UO.SysMessage("Clique em seu oponente")
UO.TargCurs = true
while UO.TargCurs == true do
    wait(10)
end
Spar = UO.LTargetID
while true do
    for i=1,5 do
        EquipWeaponShield()
        UO.LTargetID = Spar;
        UO.Macro(27,0)
        if UO.Hits <= FugirComVida then
            Escape()
        end
        if UO.Hits <= IniciarHeal then
            BandageSelf()
        end
        if UO.Hits >= BaterComVida then
            UO.Move(posx,posy,0,5000)
        end
        wait(1000)
    end
end