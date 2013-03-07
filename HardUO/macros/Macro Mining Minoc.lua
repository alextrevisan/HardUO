--===========================================================================--
-- Macro: Mining Minoc.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Axul - DMS)
-- Versao: 1.0
-- Shard: DMS
-- Descriçao: Mining Minoc (chama guards, guarda ores e da mass dispel com vortex)
--===========================================================================--

mMiningDirections = {{-2,-2},{-2,-1},{-2,0},{-2,1},{-2,2} , {-1,-2},{-1,-1},{-1,0},{-1,1},{-1,2} , {0,-2},{0,-1},{0,0},{0,1},{0,2} , {1,-2},{1,-1},{1,0},{1,1},{1,2} , {2,-2},{2,-1},{2,0},{2,1},{2,2}}
mCurrentDirections = 1

--mOreTypes = {6585,6584,6586,6583}--dwj_ewj_gwj_tvj
mOreTypes = typeConverter("DWJ_EWJ_GWJ_TVJ")
mJewelTypes={3864, 3857, 3859, 3878, 3855, 3861, 3862} --pe,tu,bd,fr,ba,ec,ds
mMesssages ={"too far","Nao ha nada", "uma linha", "muito distante", "Tente minerar em", "perto", "so close", 
             "can't see", "You can't" , "completa"}

mMaxWeigth = MaxWeight()

ScanJournal()
SysMessage("va ate a mina e aperte a tecla Enter")
WaitKey(KEY_ENTER)
Speak("bank")
SysMessage("Selecione a bag de minerios")
setTargCurs(true)
while TargCurs()==true do
    wait(10)
end
mBankBag = getLTargetID()

--[ funçao q guarda ores no banco
function DepositOres()
  Speak("Bank")
  ores = FindItem({Type=mOreTypes,ContID=BackpackID()})
  --UO.SysMessage(#ores)
  if #ores>0 then
    for i=1, #ores do
      --UO.SysMessage("ore "..ores[i].ID.." stack "..ores[i].Stack)
      Drag(ores[i].id, ores[i].stack)
      wait(400)
      DropC(mBankBag)
      wait(400)
    end
  end
  ores = FindItem({Type=mJewelTypes,ContID=BackpackID()})
  --UO.SysMessage(#ores)
  if #ores>0 then
    for i=1, #ores do
      --UO.SysMessage("ore "..ores[i].ID.." stack "..ores[i].Stack)
      Drag(ores[i].id, ores[i].stack)
      wait(400)
      DropC(mBankBag)
      wait(400)
    end
  end
end


--[ faz o char andar
function NewSpot()
    --[lateral da mina
    x = math.random(2568,2578)
    --[frente e fundo (nao ta muito pra frente pra evitar PK)
    y = math.random(474,485)      
    Move(x,y,1,5000)
    TargetMining()         
end


--[ Pega o target em volta do char
function TargetMining()
  tmp = mMiningDirections[mCurrentDirections]
  mCurrentDirections = mCurrentDirections+1
  --[se ele ja procurou tudo em volta do char, manda andar
  if mCurrentDirections > #mMiningDirections then
     mCurrentDirections = 1
     NewSpot()
  end     
  setLTargetX(tmp[1] + CharPosX())
  setLTargetY(tmp[2] + CharPosY())
  setLTargetZ(CharPosZ())        
  setLTargetKind(3)
end


--[ Funcao principal da mineraÃ§Ã£o
function StartMining()
  --[ Pra sempre faÃ§a
  while true do
    --[procura a pickaxe e usa
    if Weight() > mMaxWeigth then
      DepositOres()
    end
    
    pickaxe = FindItem({Type={3717,3718}})
    if #pickaxe <= 0 then
        print("Sem pickaxe! o0")
        return
    end
    setLObjectID(pickaxe[1].id)
    EventMacro(17,0)
    EventMacro(25, 0)
    wait(150)
    EventMacro(22,0)
    
    mContinue = true
    mTime = 0
    --[enquanto o tempo for menor que 8k e nao tiver mensagem de erro da lista
    while mContinue and mTime < 8000 do
      ScanJournal()
      if(FindJournal({"vortex","Vortex", "atacando"})) then
          Speak("Guards!")
          castMassDispel()
          wait(10000)
      end
      if(FindJournal(mMesssages)) then
          TargetMining()
          mContinue = false
          break
      end
      if Mana()<MaxMana() then
          useMeditation()
          wait(1000)
      end
      mTime = mTime + 100
      wait(100)
    end
  end
end


NewSpot()
TargetMining()
StartMining()