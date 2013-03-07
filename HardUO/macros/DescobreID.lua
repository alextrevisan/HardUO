--===========================================================================--
-- Macro: ItemID.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul - DMS)
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Descobre o ID do item pra ser usado no HardUO
--===========================================================================--

SysMessage("Mova o tipo do item que deseja descobrir o tipo e pressione ENTER")
print("Mova o tipo do item que deseja descobrir o tipo e pressione ENTER")

WaitKey(KEY_ENTER)

mItemType = UO:LLiftedType()
mItem = FindItem({Type=mItemType,ContID=BackpackID()})
if #mItem > 0 then
    print("ID: "..mItem[1].id)
    print("Type: "..mItem[1].type)
    print("Kind: "..mItem[1].kind)
    print("ContID: "..mItem[1].contId)
    print("X: "..mItem[1].x)
    print("Y: "..mItem[1].y)
    print("Z: "..mItem[1].z)
    print("Stack: "..mItem[1].stack)
    print("Rep: "..mItem[1].rep)
    print("Color: "..mItem[1].color)
end