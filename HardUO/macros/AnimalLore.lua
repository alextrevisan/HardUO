--===========================================================================--
-- Macro: Animal Lore.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul - DMS)
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Animal Lore
--===========================================================================--

SysMessage("Clique no animal que deseja examinar",55)
setTargCurs(true)
while TargCurs()==true do
    wait(10)
end
mTarget = getLTargetID()
while true do
    useAnimalLore()
    WaitTarget()
    setLTargetID(mTarget)
    LastTarget()
    wait(3000)
end