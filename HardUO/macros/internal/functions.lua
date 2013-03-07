--Configurations
local __lag_offset__ = 0 --used for slow connections on functions (WaitTarget, ...)
UO = {}
function setLagOffset(value) __lag_offset__ = value end
--Status
function Ar() return UOInstance:Ar() end
UO.Ar = Ar
function Hits() return UOInstance:Hits() end
UO.Hits = Hits
function MaxHits() return UOInstance:MaxHits() end
UO.MaxHits = MaxHits
function Mana() return UOInstance:Mana() end
UO.Mana = Mana
function MaxMana() return UOInstance:MaxMana() end
UO.MaxMana = MaxMana
function BackpackID() return UOInstance:BackpackID() end
UO.BackpackID = BackpackID
function Speak(a) UOInstance:Speak(a) end
function Move(a,b,c,d) UOInstance:Move(a,b,c,d) end
function CharPosX() return UOInstance:CharPosX() end
function CharPosY() return UOInstance:CharPosY() end
function CharPosZ() return UOInstance:CharPosZ() end
function CharName() return UOInstance:CharName() end
function Weight() return UOInstance:Weight() end
function MaxWeight() return UOInstance:MaxWeight() end
function WarPeace() UOInstance:WarPeace() end

--Spells
function castClumsy () UOInstance:castMagery( 0 ) end
function castCreateFood () UOInstance:castMagery( 1 ) end
function castFeeblemind () UOInstance:castMagery( 2 ) end
function castHeal () UOInstance:castMagery( 3 ) end
function castMagicArrow () UOInstance:castMagery( 4 ) end
function castNightSight () UOInstance:castMagery( 5 ) end
function castReactiveArmor () UOInstance:castMagery( 6 ) end
function castWeaken () UOInstance:castMagery( 7 ) end
function castAgility () UOInstance:castMagery( 8 ) end
function castCunning () UOInstance:castMagery( 9 ) end
function castCure () UOInstance:castMagery( 10 ) end
function castHarm () UOInstance:castMagery( 11 ) end
function castMagicTrap () UOInstance:castMagery( 12 ) end
function castMagicUntrap () UOInstance:castMagery( 13 ) end
function castProtection() UOInstance:castMagery( 14 ) end
function castStrength () UOInstance:castMagery( 15 ) end
function castBless () UOInstance:castMagery( 16 ) end
function castFireball () UOInstance:castMagery( 17 ) end
function castMagicLock () UOInstance:castMagery( 18 ) end
function castPoison () UOInstance:castMagery( 19 ) end
function castTelekinesis () UOInstance:castMagery( 20 ) end
function castTeleport () UOInstance:castMagery( 21 ) end
function castUnlock () UOInstance:castMagery( 22 ) end
function castWallOfStone () UOInstance:castMagery( 23 ) end
function castArchCure () UOInstance:castMagery( 24 ) end
function castArchProtection () UOInstance:castMagery( 25 ) end
function castCurse () UOInstance:castMagery( 26 ) end
function castFireField () UOInstance:castMagery( 27 ) end
function castGreaterHeal () UOInstance:castMagery( 28 ) end
function castLightning () UOInstance:castMagery( 29 ) end
function castManaDrain () UOInstance:castMagery( 30 ) end
function castRecall () UOInstance:castMagery( 31 ) end
function castBladeSpirits () UOInstance:castMagery( 32 ) end
function castDispelField () UOInstance:castMagery( 33 ) end
function castIncognito () UOInstance:castMagery( 34 ) end
function castMagicReflection () UOInstance:castMagery( 35 ) end
function castMindBlast () UOInstance:castMagery( 36 ) end
function castParalyze () UOInstance:castMagery( 37 ) end
function castPoisonField () UOInstance:castMagery( 38 ) end
function castSummonCreature () UOInstance:castMagery( 39 ) end
function castDispel () UOInstance:castMagery( 40 ) end
function castEnergyBolt () UOInstance:castMagery( 41 ) end
function castExplosion () UOInstance:castMagery( 42 ) end
function castInvisibility () UOInstance:castMagery( 43 ) end
function castMark () UOInstance:castMagery( 44 ) end
function castMassCurse () UOInstance:castMagery( 45 ) end
function castParalyzeField () UOInstance:castMagery( 46 ) end
function castReveal () UOInstance:castMagery( 47 ) end
function castChainLightning () UOInstance:castMagery( 48 ) end
function castEnergyField () UOInstance:castMagery( 49 ) end
function castFlameStrike () UOInstance:castMagery( 50 ) end
function castGateTravel () UOInstance:castMagery( 51 ) end
function castManaVampire () UOInstance:castMagery( 52 ) end
function castMassDispel () UOInstance:castMagery( 53 ) end
function castMeteorSwarm () UOInstance:castMagery( 54 ) end
function castPolymorph () UOInstance:castMagery( 55 ) end
function castEarthquake () UOInstance:castMagery( 56 ) end
function castEnergyVortex () UOInstance:castMagery( 57 ) end
function castResurrection () UOInstance:castMagery( 58 ) end
function castAirElemental () UOInstance:castMagery( 59 ) end
function castSummonDaemon () UOInstance:castMagery( 60 ) end
function castEarthElemental () UOInstance:castMagery( 61 ) end
function castFireElemental () UOInstance:castMagery( 62 ) end
function castWaterElemental () UOInstance:castMagery( 63 ) end
-- Target

function WaitTarget() UOInstance:WaitTarget() wait(__lag_offset__) end
function TargCurs() return UOInstance:TargCurs() end
function setTargCurs(a) UOInstance:setTargCurs(a) end
function LastTarget() UOInstance:LastTarget() end
function LLiftedType() return UOInstance:LLiftedType() end
function setContPos(x, y) UOInstance:setContPos(x,y) end
function TargetSelf() UOInstance:TargetSelf() end
function getLTargetID() return UOInstance:getLastTargetID() end
function setLTargetID() UOInstance:setLastTargetID(a) end
function LTargetX() return UOInstance:LTargetX() end
function LTargetY() return UOInstance:LTargetY() end
function LTargetZ() return UOInstance:LTargetZ() end
function setLTargetX(a) UOInstance:setLTargetX(a) end
function setLTargetY(a) UOInstance:setLTargetY(a) end
function setLTargetZ(a) UOInstance:setLTargetZ(a) end
function LTargetKind() return UOInstance:LTargetKind() end
function setLTargetKind(a) UOInstance:setLTargetKind(a) end
function TargetOn(targetid) setLTargetID(targetid) LastTarget() end

-- Skills
function getSkill(a) return UOInstance:GetSkill(a) end
function useLastSkill() UOInstance:useLastSkill() end
function useAnatomy() UOInstance:useAnatomy() end
function useAnimalLore() UOInstance:useAnimalLore() end
function useItemIdentification() UOInstance:useItemIdentification() end
function useArmsLore() UOInstance:useArmsLore() end
function useBegging() UOInstance:useBegging() end
function usePeacemaking() UOInstance:usePeacemaking() end
function useCartography() UOInstance:useCartography() end
function useDetectingHidden() UOInstance:useDetectingHidden() end
function useDiscordance() UOInstance:useDiscordance() end
function useEvaluatingIntelligence() UOInstance:useEvaluatingIntelligence() end
function useForensicEvaluation() UOInstance:useForensicEvaluation() end
function useHidding() UOInstance:useHidding() end
function usePoisoning() UOInstance:usePoisoning() end
function useSpiritSpeak() UOInstance:useSpiritSpeak() end
function useStealing() UOInstance:useStealing() end
function useTasteIdentification() UOInstance:useTasteIdentification() end
function useTracking() UOInstance:useTracking() end
function useMeditation() UOInstance:useMeditation() end
function useStealth() UOInstance:useStealth() end
function useRemoveTrap() UOInstance:useRemoveTrap() end
function EventMacro(a, b) UOInstance:EventMacro(a, b) end

-- Journal
function ScanJournal() UOInstance:ScanJournal() end
function FindJournal(a) return UOInstance:FindJournal(a) end
function ClearJournal() return UOInstance:ClearJournal() end
function LastJournalIndex(a) return UOInstance:LastJournalIndex(a) end
function SetJournalIndex(a,b) return UOInstance:SetJournalIndex(a,b) end

--Items
function ScanItems(a) return UOInstance:ScanItems(a) end
UO.ScanItems = ScanItems
function GetItem(a)
	local i = UOInstance:GetItem(a)
	return i.id, i.type, i.kind, i.contId, i.x, i.y, i.stacl, i.rep, i.col
end
UO.GetItem = GetItem
function Property(id)
	local p = UOInstance:Property(id)
	return p.name, p.info
end
UO.Property = Property
function FindItem(a) return UOInstance:FindItem(a) end
function setLObjectID(a) UOInstance:setLObjectID(a) end

--Mouse
function CliDrag(a) UOInstance:CliDrag(a) end
function Drag(a,b) if b~=nil then UOInstance:Drag(a,b) else UOInstance:Drag(a) end end
function DropC(a,b,c) if b~=nil and c~=nil then UOInstance:DropC(a,b,c) else UOInstance:DropC(a) end end
function DropOnContainer(a,b,c) if b~=nil and c~=nil then UOInstance:DropC(a,b,c) else UOInstance:DropC(a) end end
function DropG(a,b) UOInstance:DropG(a,b) end
function DropOnGround(x,y) UOInstance:DropG(x,y) end
function DropOnGround(x,y,z) UOInstance:DropG(x,y,z) end
function DropG(a,b,c) if c~=nil then UOInstance:DropG(a,b,c) else UOInstance:DropG(a,b) end end
function DropPD() UOInstance:DropG() end
function DropOnPaperDoll() UOInstance:DropG() end
function Click(x, y, left, down, up, mc) UOInstance:Click(x, y, left, down, up, mc) end
function SysMessage(s, col) UOInstance:SystemMessage(s,col or 0) end

--File
function openfile(file, mode)
	return io.open(file, mode)
end

--Lua
function dostring(s)
	return loadstring(s)()
end
----------------------------------------
-- Cheffe's Table Converter Functions --
----------------------------------------
 
local function ToStr(value,func,spc)
  local t = type(value)                 --get type of value
  if t=="string" then
	return '"' .. value .. '"'          --not 100% clean, binary characters should be escaped!
  end
  if t=="table" then
	if func then
	  return func(value,spc.."  ")
	else
	  error("Tables not allowed as keys!",2)
	end
  end
  if t=="number" or t=="boolean" or t=="nil" then
	return tostring(value)
  end
  error("Cannot convert unknown type to string!",2)
end
 
----------------------------------------
 
local function TblToStr(t,spc)
  local s = "{\r\n"
  for k,v in pairs(t) do
	s = s..spc.."  ["..ToStr(k).."] = "..ToStr(v,TblToStr,spc)..",\r\n"
  end
  return s..spc.."}"
end
 
----------------------------------------
 
function TableToString(table)
  return TblToStr(table,"")
end
 
----------------------------------------
----------------------------------------
----------------------------------------