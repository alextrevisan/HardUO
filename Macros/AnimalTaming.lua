--mensagens
mAceita = {"aceita voce como", "animal already belong"}
mProximo = {"lack the skill", "too far"}

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
function useAnimalTaming()
    harp = ScanItems(true,{Type={3762}})
    UO.LObjectID =  harp[1].ID
    EventMacro(17,0)
    wait(150)
end

function nextTarget()
    UO.Macro(26,0)
    animal = ScanItems(true,{ID={UO.LTargetID}}, {Type={401, 400, 205}})
    if #animal <= 0 or UO.LTargetID == UO.CharID or math.abs(animal[1].RelX) > 4 or math.abs(animal[1].RelY) > 4 then
        nextTarget()
    end
    wait(10)
end

function targetAnimal()
    UO.Macro(22,0)
    wait(150)
end

function releaseAll()
    UO.Msg("all release\n")
end

nextTarget()

while true do
    useAnimalTaming()
    targetAnimal()
    local waitTime = 5000
    
    journal = getMsg()
    if(findMsg(journal,mProximo)) then
        nextTarget()
        waitTime = 100
    end
    if(findMsg(journal,mAceita)) then
        releaseAll()
        nextTarget()
        waitTime = 100
    end
    wait(waitTime)
end

