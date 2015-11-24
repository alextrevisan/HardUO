--===========================================================================--
-- Macro: Mining Minoc.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul)
-- Versao: 1.2
-- Shard: Dimension - http://www.dmsshard.com.br
-- DescriÃƒÂ§ao: Mining Minoc (Minera e guarda)
--===========================================================================--

--ConfiguraÃƒÂ§ao de peso mÃƒÂ¡ximo ate ir no banco guardar
PesoMaximo = UO.MaxWeight - 50

mMiningDirections = { {-1,-1},{0,-1},{1,-1},{-1,0},{0,0},{1,0},{-1,1},{0,1},{1,1}}

mCurrentDirections = 1

--mOreTypes = {6585,6584,6586,6583}--dwj_ewj_gwj_tvj
mOreTypes = typeConverter("DWJ_EWJ_GWJ_TVJ")
mJewelTypes={3864, 3857, 3859, 3878, 3855, 3861, 3862} --pe,tu,bd,fr,ba,ec,ds
mMesssages ={"too far","Nao ha nada", "no ore left", "uma linha", "muito distante", "Tente minerar em", "perto", "so close", 
             "can't see", "You can't" , "completa"}


function GetPicaxeFromBank()
    Speak("bank")
    wait(500)
    for i=1,5 do
    pickaxe = ScanItems(true,{Type={3717,3718}})
        if #pickaxe <=0 then
            UO.SysMessage("Sem pickaxe manolo!!")
            print("Sem pickaxe manolo!! == parando macro == linha 48 ==")
        end
        wait(250)
    end
    UO.Drag(pickaxe[1].ID)
    wait(400)
    UO.DropC(UO.BackpackID)
    wait(400)
    DepositOres()
end

function DepositOres()
  Speak("bank")
  wait(500)
  ores = ScanItems(true, {Type=mOreTypes})
  if #ores>0 then
    for i=1, #ores do
      --UO.SysMessage("ore "..ores[i].ID.." stack "..ores[i].Stack)
      UO.Drag(ores[i].ID, ores[i].Stack)
      wait(400)
      UO.DropC(mBankBag)
      wait(400)
    end
  end
  ores = ScanItems(true, {Type=mJewelTypes,ContID=UO.BackpackID})

  if #ores>0 then
    for i=1, #ores do
      UO.Drag(ores[i].ID, ores[i].Stack)
      wait(400)
      UO.DropC(mBankBag)
      wait(400)
    end
  end
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
function NewSpot()
    --[lateral da mina
    x = math.random(2568,2578)
    --[frente e fundo (nao ta muito pra frente pra evitar PK)
    y = math.random(474,485)      
    UO.Move(x,y,1,5000)
    TargetMining()         
end

function TargetMining()
  tmp = mMiningDirections[mCurrentDirections]
  mCurrentDirections = mCurrentDirections+1
  --[se ele ja procurou tudo em volta do char, manda andar
  if mCurrentDirections > 10 then
     mCurrentDirections = 1
     NewSpot()
  end     
  UO.LTargetX = tmp[1] + UO.CharPosX
  UO.LTargetY = tmp[2] + UO.CharPosY
  UO.LTargetZ = UO.CharPosZ       
  UO.LTargetKind = 3
end

function StartMining()
    while true do
        pickaxe = ScanItems(true,{Type={3717,3718}})
        if #pickaxe <= 0 then
            GetPicaxeFromBank()
        end
        if UO.Weight > PesoMaximo then
            DepositOres()
        end
        pickaxe = ScanItems(true,{Type={3717,3718}})
        UO.LObjectID =  pickaxe[1].ID
        EventMacro(17,0)
        wait(300)
        EventMacro(25, 0)
        wait(150)
        EventMacro(22,0)    
        mContinue = true
        mTime = 0
        --[enquanto o tempo for menor que 8k e nao tiver mensagem de erro da lista
        while mContinue and mTime < 8000 do
            if(UO.Hits < UO.MaxHits-21) then
                Speak("guards")
                wait(5000)
            end
            journal = getMsg()
            if(findMsg(journal,mMesssages)) then
                wait(500)
                TargetMining()
                mContinue = false
                break
            end
            mTime = mTime + 100
            wait(100)
        end
    end
end
UO.Macro(8,1)
wait(250)
UO.Macro(8,2)
wait(250)
UO.ScanJournal(1)
UO.SysMessage("Va ate a mina e aperte a tecla Enter")
while(getkey(KEY_ENTER) ~= true) do
    wait(10)
end
Speak("bank")
UO.SysMessage("Selecione a bag de minerios")
UO.TargCurs = true
while UO.TargCurs == true do
    wait(10)
end
mBankBag = UO.LTargetID

pickaxe = ScanItems(true,{Type={3717,3718}})
if #pickaxe <=0 then
    GetPicaxeFromBank()
    UO.SysMessage("Sem pickaxe manolo!!")
    print("Sem pickaxe manolo!!")
end
UO.Drag(pickaxe[1].ID)
wait(400)
UO.DropC(UO.BackpackID)
wait(400)

NewSpot()
TargetMining()
Star