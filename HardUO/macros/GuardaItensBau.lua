--===========================================================================--
-- Macro: Guarda itens.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul - DMS)
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Guarda qualquer item selecionado da bag em um baú
--===========================================================================--

UO:SystemMessage("Mova o tipo do item que deseja guardar e pressione ENTER")

WaitKey(13)

mItemType = UO:LLiftedType()

UO:SystemMessage("Clique no baú ou bag que deseja colocar os itens")
setTargCurs(true)
while TargCurs()==true do
    wait(10)
end

mBag = getLTargetID()

items = FindItem({Type={mItemType},ContID=BackpackID()})

if #items>0 then
    for i=1, #items do
        Drag(items[i].id, items[i].stack)
        wait(400)
        DropC(mBag)
        wait(400)
    end
end

UO:SystemMessage("Finalizado!")