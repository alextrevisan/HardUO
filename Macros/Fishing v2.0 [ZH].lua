--===========================================================================--
-- Macro: Fishin Minoc.
-- Programa de Script: HardUO - http://www.hogpog.com.br/harduo
-- Escrito por Alex (Blue)
-- Versao: 1.0
-- Shard: Zulu Hotel - http://www.zuluhotel.com.br
-- Descriçao: Pesca e guarda no banco
--===========================================================================--
mFishinDirections = { {-2,-2},{-2,-1},{2,0},{-2,1},{-2,2},
                      {-1,-2},{-1,-1},{-1,0},{-1,1},{-1,2},
                      {0,-2},{0,-1},{0,0},{0,1},{0,2},
                      {1,-2},{1,-1},{1,0},{1,1},{1,2},
                      {2,-2},{2,-1},{2,0},{2,1},{2,2} }
mCurrentDirections = 1
mFishTypes = {2508, 2509, 2510, 2511}

Speak("bank")
UO.SysMessage("Selecione a bag de peixes")
UO.TargCurs = true
while UO.TargCurs == true do
    wait(10)
end
mBankBag = UO.LTargetID
UO.SysMessage("Ande para onde quer pescar, pressione ENTER quando chegar",65)
mX = {}
mY = {}
mFishingLocX = 0
mFishingLocY = 0
mFishingLocZ = 0
mX[1] = UO.CharPosX
mY[1] = UO.CharPosY
record = true
while record do
    if mX[#mX] ~= UO.CharPosX and mY[#mY] ~= UO.CharPosY then
        mX[#mX+1] = UO.CharPosX
        mY[#mY+1] = UO.CharPosY
    end
    wait(100)
    if getkey(KEY_ENTER) then
        record = false
        mX[#mX+1] = UO.CharPosX
        mY[#mY+1] = UO.CharPosY
    end
end

UO.SysMessage("Clique onde quer pescar",65)
fishinPole = ScanItems(true,{Type={3519}})
UO.LObjectID =  fishinPole[1].ID
EventMacro(17,0)
wait(350)
while UO.TargCurs == true do
    wait(10)
end
mFishingLocX = UO.LTargetX
mFishingLocY = UO.LTargetY
mFishingLocZ = UO.LTargetZ

function GoToBank()
    for i=#mX, 1, -1 do
        UO.Move(mX[i],mY[i],0,1000)
    end
end
function GoToFish()
    for i=1, #mX do
        UO.Move(mX[i],mY[i],0,1000)
    end
end

function TargetFishing()
  tmp = mFishinDirections[mCurrentDirections]
  mCurrentDirections = mCurrentDirections+1
  --[se ele ja procurou tudo em volta do char, manda andar
  if mCurrentDirections > 25 then
     mCurrentDirections = 1
  end     
  UO.LTargetX = tmp[1] + mFishingLocX
  UO.LTargetY = tmp[2] + mFishingLocY
  UO.LTargetZ = mFishingLocZ       
  UO.LTargetKind = 3
end
function DepositFish()
    GoToBank()
    Speak("bank")
    fish = FindItem({Type=mFishTypes,ContID=UO.BackpackID})
    if #fish>0 then
        for i=1, #fish do
          UO.Drag(fish[i].id, fish[i].stack)
          wait(400)
          UO.DropC(mBankBag)
          wait(400)
        end
    end
    GoToFish()
end
UO.Msg(".autoloop 1"..string.char(13))
--GoToFish()
while true do
    TargetFishing()
    fishinPole = ScanItems(true,{Type={3519}})
    UO.LObjectID =  fishinPole[1].ID
    EventMacro(17,0)
    EventMacro(25, 0)
    wait(150)
    EventMacro(22,0)
    wait(3000)
    UO.Msg(".guards\n")
    wait(3000)
    UO.Msg(".guards\n")
    if UO.Weight > 40 then
        DepositFish()
    end
end