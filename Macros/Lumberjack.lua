--'createMode = true' irá gravar as arvores que vai cortar
-- use createMode true somente na primeira vez, depois ele
-- irá so carregar o arquivo q gerou.
--'createMode = false' irá carregar arvores ja gravadas
local createMode = false
local maxTry = 5
local mTreeFile = "arvores.lua"
mPositionX = {}
mPositionY = {}
mMesssages ={"not enough","too far","Nao ha", "no ore left", "uma linha", "muito distante", "so close", 
             "can't see", "You can't" , "be seen"}

mLogTypes = {7133}


UO.SysMessage("Va ate o banco e pressione ENTER")
print("Va ate o banco e pressione ENTER")

while getkey(KEY_ENTER) ~=true do
    wait(10)
end
local mBankX = UO.CharPosX
local mBankY = UO.CharPosY

UO.Msg("bank\n")
UO.SysMessage("Clique na bag que irá guardar os Logs")
print("Clique na bag que irá guardar os Logs")

UO.TargCurs = true
while UO.TargCurs do
    wait(10)
end
mBankBag = UO.LTargetID

UO.SysMessage("De 2 cliques no machado que ira utilizar")
print("De 2 cliques no machado que ira utilizar")

while UO.TargCurs ~=true do
    wait(10)
end
local mAxe = UO.LObjectID
UO.TargCurs = false

if createMode then
    local mTargetX = {}
    local mTargetY = {}
    local mTargetZ = {}
    local mTargetTile = {}
    local index = 1
    UO.SysMessage("Se posicione proximo as arvores")
    print("Se posicione proximo as arvores")

    UO.SysMessage("Pressione ENTER para marcar a arvore ou F4 para finalizar")
    print("Pressione ENTER para marcar a arvore ou F4 para finalizar")
    while getkey(KEY_F4) ~= true do
        if getkey(KEY_ENTER) == true then
            UO.LObjectID = mAxe
            EventMacro(17,0)
            wait(100)
            while UO.TargCurs do
                wait(10)
            end
            print("adicionando arvore...")
            mTargetX[index] = UO.LTargetX
            mTargetY[index] = UO.LTargetY
            mTargetZ[index] = UO.LTargetZ
            mTargetTile[index] = UO.LTargetTile

            mPositionX[index] = UO.CharPosX
            mPositionY[index] = UO.CharPosY
            index = index + 1
            UO.SysMessage("Pressione ENTER para marcar a arvore ou F4 para finalizar")
            print("Pressione ENTER para marcar a arvore ou F4 para finalizar")
        end
        wait(1)
    end
    print("gravando arquivo...")
    print("numero de arvores: "..#mTargetX)
    file = io.open("arvores.lua", "w")
    file:write("mTargetX = {")
    for i=1,#mTargetX do
        file:write(mTargetX[i])
        if i == #mTargetX then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:write("\n")
    file:write("mTargetY = {")
    for i=1,#mTargetY do
        file:write(mTargetY[i])
        if i == #mTargetY then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:write("\n")
    file:write("mTargetZ = {")
    for i=1,#mTargetZ do
        file:write(mTargetZ[i])
        if i == #mTargetZ then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:write("\n")
    file:write("mTargetTile = {")
    for i=1,#mTargetTile do
        file:write(mTargetTile[i])
        if i == #mTargetTile then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:write("\n")
    file:write("mPositionX = {")
    for i=1,#mPositionX do
        file:write(mPositionX[i])
        if i == #mPositionX then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:write("\n")
    file:write("mPositionY = {")
    for i=1,#mPositionY do
        file:write(mPositionY[i])
        if i == #mPositionY then
            file:write("}")
        else
            file:write(",")
        end
    end
    file:close()
end

function bankLog()
   UO.Move(mBankX,mBankY,0,8000)
   UO.Msg("bank\n")
end

function depositLogs()
    UO.Move(mBankX,mBankY,0,8000)
    UO.Msg("bank\n")
    wait(500)
    logs = ScanItems(true, {Type=mLogTypes})
    for i=1, #logs do
        --UO.SysMessage("ore "..ores[i].ID.." stack "..ores[i].Stack)
        UO.Drag(logs[i].ID, logs[i].Stack)
        wait(500)
        UO.DropC(mBankBag)
        wait(500)
    end
end

dofile("arvores.lua")
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
local index = 1
local count = 0
journal = getMsg()
while true do
    UO.Move(mPositionX[index],mPositionY[index],0,6000)
    UO.LObjectID = mAxe
    UO.LTargetKind = 1
    UO.Macro(17,0)
    wait(450)
    UO.LTargetX = mTargetX[index]
    UO.LTargetY = mTargetY[index]
    UO.LTargetZ = mTargetZ[index]
    UO.LTargetTile = mTargetTile[index]
    UO.LTargetKind = 3
    wait(100)
    UO.Macro(22,0)
    wait(250)
    journal = getMsg()
    local waitvalue = 8500
    if findMsg(journal,mMesssages)==true or count > maxTry then
        index = index + 1
        if index > #mPositionX then
            index = 1
        end
        count = 0
        waitvalue = 500
    end
    count = count+1

    wait(waitvalue)
    if UO.Weight > UO.MaxWeight - 50 then
        depositLogs()
        UO.Move(mPositionX[index],mPositionY[iindex],0,12000)
    end
end
