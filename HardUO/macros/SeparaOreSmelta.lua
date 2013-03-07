--===========================================================================--
-- Macro: Separador e Smeltador de Ores.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Separa ore e/ou smelta
--===========================================================================--

dofile("macros/type_converter.lua")
-- Numero de ORES pra separar pra smeltar
SysMessage("Iniciando macro Separa/Smelta", 100)

stackSize = 5
smelt = 1
type = typeConverter("DWJ")
Xf = 633
Yf = 343
EventMacro(9, 7)
wait(400)
EventMacro(8, 7)
wait(400)
setContPos(450, 300)

continue = true

while continue do
    ores = FindItem({Type=type,ContID=BackpackID()})
    if #ores>0 then
        if ores[i].stack >= ores then
            CliDrag(ores[i].id, stackSize)
            wait(200)
            Click(Yf, Yf)
            wait(200)
            if smelt == 1 then
                setLObjectID(ores[i].id)
                EventMacro(17,0)
                wait(200)
            end
        else
            continue = false
        end
    else
        continue = false
    end
end
SysMessage("Finalizado", 100)

