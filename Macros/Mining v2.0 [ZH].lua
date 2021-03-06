--===========================================================================--
-- Macro: Mining Minoc.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Masmorra)
-- Versao: 1.3
-- Descricao: Mining Minoc (Minera, vai ao banco, guarda e volta pra mina)
--===========================================================================--
dofile("Macros/Relogin 1.0 [TFG].lua")
-- Defina sua senha para relogin
mSenha = "sua_senha_aqui"
--Configur de peso maximo ate ir no banco guardar
PesoMaximo = 50
--Config da bag do banco, se for 0, inicia do banco
mBankBag = 0--1074888939
--Config de tempo de espera
TempoEsperaComMinerio = 8000

mMiningDirections = { {-1,-1},{0,-1},{1,-1},{-1,0},{0,0},{1,0},{-1,1},{0,1},{1,1} }
mCurrentDirections = 1

--mOreTypes = {6585,6584,6586,6583}--dwj_ewj_gwj_tvj
mOreTypes = typeConverter("DWJ_EWJ_GWJ_TVJ")
mJewelTypes={3864, 3857, 3859, 3878, 3855, 3861, 3862} --pe,tu,bd,fr,ba,ec,ds
mMesssages ={"line of sight","too far","Nao ha nada","nothing here", "elsewhere", "no ore left", "uma linha", "muito distante", "Tente minerar em", "perto", "so close", 
             "can't see", "You can't" , "completa"}
             
function GoToBank()
    UO.Move(2558,494,0,15000)
    UO.Move(2558,501,0,15000)
    UO.Move(2540,502,0,15000)
    UO.Move(2526,502,0,15000)
    UO.Move(2526,513,0,15000)
    UO.Move(2510,513,0,15000)
    UO.Move(2509,542,0,15000)
end

function GoToMine()
    UO.Move(2509,542,0,15000)
    UO.Move(2510,513,0,15000)
    UO.Move(2526,513,0,15000)
    UO.Move(2526,502,0,15000)
    UO.Move(2540,502,0,15000)
    UO.Move(2558,501,0,15000)
    UO.Move(2558,494,0,15000)
    UO.Move(2571,430,0,15000)
end

function GetPicaxeFromBank()
    GoToBank()
    Speak("banker bank")
    wait(500)
    for i=1,5 do
    pickaxe = ScanItems(true,{Type={3717,3718}})
        if #pickaxe <=0 then
            UO.SysMessage("Sem pickaxe manolo!!")
            print("Sem pickaxe manolo!!")
        end
        wait(250)
    end
    UO.Drag(pickaxe[1].ID)
    wait(400)
    UO.DropC(UO.BackpackID)
    wait(400)
    DepositOres()
    GoToMine()
end

function DepositOres()
  Speak("banker bank")
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
    x = math.random(2571,2598)
    --[frente e fundo (nao ta muito pra frente pra evitar PK)
    y = math.random(430,442)      
    UO.Move(x,y,2,8000)
    TargetMining()         
end

function TargetMining(changeDirection)
  
  local tmp = mMiningDirections[mCurrentDirections]
  if changeDirection then
      mCurrentDirections = mCurrentDirections+1
  end
  --[se ele ja procurou tudo em volta do char, manda andar
  if mCurrentDirections > 9 then
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
        Relogin(mSenha);
        pickaxe = ScanItems(true,{Type={3717,3718}})
        if #pickaxe <= 0 then
            GetPicaxeFromBank()
        end
        if UO.Weight > PesoMaximo then
            GoToBank()
            DepositOres()
            GoToMine()
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
        TargetMining(false)
        --[enquanto o tempo for menor que 8k e nao tiver mensagem de erro da lista
        while mTime < TempoEsperaComMinerio do
            journal = getMsg()
            if(findMsg(journal,mMesssages)) then
                TargetMining(true)
                --mContinue = false
                mTime = TempoEsperaComMinerio
                --break
            end
            mTime = mTime + 100
            wait(100)
        end
    end
end

if mBankBag == 0 then
UO.ScanJournal(1)
UO.SysMessage("Va ate o banco e aperte a tecla Enter")
while(getkey("ENTER") ~= true) do
    wait(10)
end
Speak("banker bank")
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
DepositOres()
GoToMine()
end
NewSpot()
TargetMining()
StartMining()
