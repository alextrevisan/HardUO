--Configurations
local __lag_offset__ = 0 --used for slow connections on functions (WaitTarget, ...)
function setLagOffset(value) __lag_offset__ = value end

-- OpenEUO compatibility variables
UO = {}
local ReadOpenEUOtoHardUO={}
local WriteOpenEUOtoHardUO={}
local IgnoredFunctions = {}

--Character Variables
--The character category of system variables contains information specific to the character in the current instance of Ultima Online that EasyUO is attached to. 
UO.CharPosX = 0
local function CharPosX() return UOInstance:CharPosX() end
ReadOpenEUOtoHardUO["CharPosX"] = CharPosX

UO.CharPosY = 0
local function CharPosY() return UOInstance:CharPosY() end
ReadOpenEUOtoHardUO["CharPosY"] = CharPosY

UO.CharPosZ = 0
local function CharPosZ() return UOInstance:CharPosZ() end
ReadOpenEUOtoHardUO["CharPosZ"] = CharPosZ

UO.CharDir = 0
local function CharDir() return UOInstance:CharDir() end
ReadOpenEUOtoHardUO["CharDir"] = CharDir

UO.CharStatus = 0
local function CharStatus() return UOInstance:CharStatus() end
ReadOpenEUOtoHardUO["CharStatus"] = CharStatus

UO.CharID = 0
local function CharID() return UOInstance:CharID() end
ReadOpenEUOtoHardUO["CharID"] = CharID

UO.CharType = 0
local function CharType() return UOInstance:CharType() end
ReadOpenEUOtoHardUO["CharType"] = CharType

UO.BackpackID = 0
local function BackpackID() return UOInstance:BackpackID() end
ReadOpenEUOtoHardUO["BackpackID"] = BackpackID

--Status Variables
--Status variables come from the UO Status Bar in game. They provide information about the current character.
UO.CharName = 0
local function CharName() return UOInstance:CharName() end
ReadOpenEUOtoHardUO["CharName"] = CharName

UO.Sex = 0
local function Sex() return UOInstance:Sex() end
ReadOpenEUOtoHardUO["Sex"] = Sex

UO.Str = 0
local function Str() return UOInstance:Str() end
ReadOpenEUOtoHardUO["Str"] = Str

UO.Hits = 0
local function Hits() return UOInstance:Hits() end
ReadOpenEUOtoHardUO["Hits"] = Hits

UO.MaxHits = 0
local function MaxHits() return UOInstance:MaxHits() end
ReadOpenEUOtoHardUO["MaxHits"] = MaxHits

UO.Dex = 0
local function Dex() return UOInstance:Dex() end
ReadOpenEUOtoHardUO["Dex"] = Dex

UO.Stamina = 0
local function Stamina() return UOInstance:Stamina() end
ReadOpenEUOtoHardUO["Stamina"] = Stamina

UO.MaxStam = 0
local function MaxStam() return UOInstance:MaxStam() end
ReadOpenEUOtoHardUO["MaxStam"] = MaxStam

UO.Int = 0
local function Int() return UOInstance:Int() end
ReadOpenEUOtoHardUO["Int"] = Int

UO.Mana = 0
local function Mana() return UOInstance:Mana() end
ReadOpenEUOtoHardUO["Mana"] = Mana

UO.MaxMana = 0
local function MaxMana() return UOInstance:MaxMana() end
ReadOpenEUOtoHardUO["MaxMana"] = MaxMana

UO.MaxStats = 0
local function MaxStats() return UOInstance:MaxStats() end
ReadOpenEUOtoHardUO["MaxStats"] = MaxStats

UO.Luck = 0
local function Luck() return UOInstance:Luck() end
ReadOpenEUOtoHardUO["Luck"] = Luck

UO.Weight = 0
local function Weight() return UOInstance:Weight() end
ReadOpenEUOtoHardUO["Weight"] = Weight

UO.MaxWeight = 0
local function MaxWeight() return UOInstance:MaxWeight() end
ReadOpenEUOtoHardUO["MaxWeight"] = MaxWeight

UO.MinDmg = 0
local function MinDmg() return UOInstance:MinDmg() end
ReadOpenEUOtoHardUO["MinDmg"] = MinDmg

UO.MaxDmg = 0
local function MaxDmg() return UOInstance:MaxDmg() end
ReadOpenEUOtoHardUO["MaxDmg"] = MaxDmg

UO.Gold = 0
local function Gold() return UOInstance:Gold() end
ReadOpenEUOtoHardUO["Gold"] = Gold

UO.Followers = 0
local function Followers() return UOInstance:Followers() end
ReadOpenEUOtoHardUO["Followers"] = Followers

UO.MaxFol = 0
local function MaxFol() return UOInstance:MaxFol() end
ReadOpenEUOtoHardUO["MaxFol"] = MaxFol

UO.AR = 0
local function Ar() return UOInstance:Ar() end
ReadOpenEUOtoHardUO["AR"] = Ar

UO.FR = 0
local function FR() return UOInstance:Fr() end
ReadOpenEUOtoHardUO["FR"] = FR

UO.CR = 0
local function CR() return UOInstance:Cr() end
ReadOpenEUOtoHardUO["CR"] = CR

UO.PR = 0
local function PR() return UOInstance:Pr() end
ReadOpenEUOtoHardUO["PR"] = PR

UO.ER = 0
local function ER() return UOInstance:Er() end
ReadOpenEUOtoHardUO["ER"] = ER

UO.TP = 0
local function TP() return UOInstance:Tp() end
ReadOpenEUOtoHardUO["TP"] = TP
--Container 
--Container system variables represent information available about the top most (or most reacent) gump that was opened, moved, or clicked in the Ultima Online Client. 

UO.NextCPosX = 0
local function getNextCPosX() return UOInstance:NextCPosX() end
local function setNextCPosX(x) return UOInstance:NextCPosX(x) end
ReadOpenEUOtoHardUO["NextCPosX"] = getNextCPosX
WriteOpenEUOtoHardUO["NextCPosX"] = setNextCPosX

UO.NextCPosY = 0
local function getNextCPosY() return UOInstance:NextCPosY() end
local function setNextCPosY(x) return UOInstance:NextCPosY(x) end
ReadOpenEUOtoHardUO["NextCPosY"] = getNextCPosY
WriteOpenEUOtoHardUO["NextCPosY"] = setNextCPosY

UO.ContSizeX = 0
local function ContSizeX() return UOInstance:ContSizeX() end
ReadOpenEUOtoHardUO["ContSizeX"] = ContSizeX

UO.ContSizeY = 0
local function ContSizeY() return UOInstance:ContSizeY() end
ReadOpenEUOtoHardUO["ContSizeY"] = ContSizeY

UO.ContPosX = 0
local function ContPosX() return UOInstance:ContPosX() end
ReadOpenEUOtoHardUO["ContPosX"] = ContPosX

UO.ContPosY = 0
local function ContPosY() return UOInstance:ContPosY() end
ReadOpenEUOtoHardUO["ContPosY"] = ContPosY

UO.ContKind = 0
local function ContKind() return UOInstance:ContKind() end
ReadOpenEUOtoHardUO["ContKind"] = ContKind

UO.ContID = 0
local function ContID() return UOInstance:ContID() end
ReadOpenEUOtoHardUO["ContID"] = ContID

UO.ContType = 0
local function ContType() return UOInstance:ContType() end
ReadOpenEUOtoHardUO["ContType"] = ContType

UO.ContName = 0
local function ContName() return UOInstance:ContName() end
ReadOpenEUOtoHardUO["ContName"] = ContName

UO.LObjectID = 0
local function setLObjectID(id) UOInstance:LObjectID(id) end
local function getLObjectID() return UOInstance:LObjectID() end
ReadOpenEUOtoHardUO["LObjectID"] = getLObjectID
WriteOpenEUOtoHardUO["LObjectID"] = setLObjectID

UO.LObjectType = 0
local function setLObjectType(id) UOInstance:LObjectType(id) end
local function getLObjectType() return UOInstance:LObjectType() end
ReadOpenEUOtoHardUO["LObjectType"] = getLObjectType
WriteOpenEUOtoHardUO["LObjectType"] = setLObjectType

UO.LTargetID = 0
local function getLTargetID() return UOInstance:getLastTargetID() end
local function setLTargetID(id) UOInstance:setLastTargetID(id) end
ReadOpenEUOtoHardUO["LTargetID"] = getLTargetID
WriteOpenEUOtoHardUO["LTargetID"] = setLTargetID

UO.LTargetX = 0
local function getLTargetX() return UOInstance:LTargetX() end
local function setLTargetX(target) UOInstance:setLTargetX(target) end
ReadOpenEUOtoHardUO["LTargetX"] = getLTargetX
WriteOpenEUOtoHardUO["LTargetX"] = setLTargetX


UO.LTargetY = 0
local function getLTargetY() return UOInstance:LTargetY() end
local function setLTargetY(target) UOInstance:setLTargetY(target) end
ReadOpenEUOtoHardUO["LTargetY"] = getLTargetY
WriteOpenEUOtoHardUO["LTargetY"] = setLTargetY

UO.LTargetZ = 0
local function getLTargetZ() return UOInstance:LTargetZ() end
local function setLTargetZ(target) UOInstance:setLTargetZ(target) end
ReadOpenEUOtoHardUO["LTargetZ"] = getLTargetZ
WriteOpenEUOtoHardUO["LTargetZ"] = setLTargetZ

UO.LTargetKind = 0
local function getLTargetKind() return UOInstance:LTargetKind() end
local function setLTargetKind(kind) UOInstance:setLTargetKind(kind) end
ReadOpenEUOtoHardUO["LTargetKind"] = getLTargetKind
WriteOpenEUOtoHardUO["LTargetKind"] = setLTargetKind

UO.LTargetTile = 0
local function LTargetTile() return UOInstance:LTargetTile() end
ReadOpenEUOtoHardUO["LTargetTile"] = LTargetTile

UO.LLiftedID = 0
local function LLiftedID() return UOInstance:LLiftedID() end
ReadOpenEUOtoHardUO["LLiftedID"] = LLiftedID

UO.LLiftedKind = 0
local function LLiftedKind() return UOInstance:LLiftedKind() end
ReadOpenEUOtoHardUO["LLiftedKind"] = LLiftedKind

UO.LLiftedType = 0
local function LLiftedType() return UOInstance:LLiftedType() end
ReadOpenEUOtoHardUO["LLiftedType"] = LLiftedType

UO.LSkill = 0
local function setLSkill(skill)  UOInstance:LSkill(skill) end
local function getLSkill() return UOInstance:LSkill() end
ReadOpenEUOtoHardUO["LSkill"] = getLSkill
WriteOpenEUOtoHardUO["LSkill"] = setLSkill

UO.LSpell = 0
local function setLSpell(spell) return UOInstance:LSpell(spell) end
local function getLSpell() return UOInstance:LSpell() end
ReadOpenEUOtoHardUO["LSpell"] = getLSpell
WriteOpenEUOtoHardUO["LSpell"] = setLSpell

--FindItem 
--The euox system variables are set when the FindItem command is used, however in oeuo the command UO.GetItem populates most of these fields. 

local function ScanItems(a) return UOInstance:ScanItems(a) end
UO.ScanItems = ScanItems
IgnoredFunctions["ScanItems"] = ScanItems


local function GetItem(a)
	local i = UOInstance:GetItem(a)
	return i.id, i.type, i.kind, i.contId, i.x, i.y, i.z, i.stack, i.rep, i.color
end
UO.GetItem = GetItem
IgnoredFunctions["GetItem"] = GetItem

--Extended 
--Extended system variables show information about various systems in the Ultima Online client that can be gained by using certain commands. 
local function SysMessage(s, col) UOInstance:SystemMessage(s,col or 0) end
UO.SysMessage = SysMessage
IgnoredFunctions["SysMessage"] = SysMessage

UO.TargCurs = 0
local function TargCurs() return UOInstance:TargCurs() end
local function setTargCurs(a) UOInstance:setTargCurs(a) end
ReadOpenEUOtoHardUO["TargCurs"] = TargCurs
WriteOpenEUOtoHardUO["TargCurs"] = setTargCurs

UO.CursKind = 0
local function CursKind() return UOInstance:CursKind() end
ReadOpenEUOtoHardUO["CursKind"] = CursKind

UO.GetSkill = 0
local function GetSkill(a)
	s = UOInstance:GetSkill(a)
	return s.norm, s.real, s.cap, s.lock
end
IgnoredFunctions["GetSkill"] = GetSkill

UO.GetJournal = 0
local function GetJournal(index)
	j = UOInstance:GetJournal(index)
	return j.line, j.color
end
IgnoredFunctions["GetJournal"] = GetJournal

UO.ScanJournal = 0
local function ScanJournal(index)
	j = UOInstance:ScanJournal(index)
	return j.ref, j.count
end
IgnoredFunctions["ScanJournal"] = ScanJournal

UO.Drag = 0
local function Drag(a,b) if b~=nil then UOInstance:Drag(a,b) else UOInstance:Drag(a) end end
IgnoredFunctions["Drag"] = Drag

UO.DropC = 0
local function DropC(a,b,c) if b~=nil and c~=nil then UOInstance:DropC(a,b,c) else UOInstance:DropC(a) end end
IgnoredFunctions["DropC"] = DropC

UO.Property = 0
local function Property(id)
	local p = UOInstance:Property(id)
	return p.name, p.info
end
IgnoredFunctions["Property"] = Property


--Status
function Speak(a) UOInstance:Speak(a) end
UO.Msg = Speak
function Move(a,b,c,d) UOInstance:Move(a,b,c,d) end
UO.Move = Move
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

function LastTarget() UOInstance:LastTarget() end
function LLiftedType() return UOInstance:LLiftedType() end
function setContPos(x, y) UOInstance:setContPos(x,y) end
function TargetSelf() UOInstance:TargetSelf() end

function TargetOn(targetid) setLTargetID(targetid) LastTarget() end

-- Skills

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
function FindItem(a) return UOInstance:FindItem(a) end

--Mouse
function CliDrag(a) UOInstance:CliDrag(a) end
function DropOnContainer(a,b,c) if b~=nil and c~=nil then UOInstance:DropC(a,b,c) else UOInstance:DropC(a) end end
function DropG(a,b) UOInstance:DropG(a,b) end
function DropOnGround(x,y) UOInstance:DropG(x,y) end
function DropOnGround(x,y,z) UOInstance:DropG(x,y,z) end
function DropG(a,b,c) if c~=nil then UOInstance:DropG(a,b,c) else UOInstance:DropG(a,b) end end
function DropPD() UOInstance:DropG() end
function DropOnPaperDoll() UOInstance:DropG() end
function Click(x, y, left, down, up, mc) UOInstance:Click(x, y, left, down, up, mc) end

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

----------------------------------------
--update variables(OpenEUO compatibility)
----------------------------------------
-- keep a private access to original table
local _t = UO
-- create proxy
UO = {}
-- create metatable
local __mt__ = {
	__index = function (t,k)
		if ReadOpenEUOtoHardUO[k] ~= nil then--print("*access to element " .. tostring(k))
			return ReadOpenEUOtoHardUO[k]()--_t[k]   -- access the original table
		else
			if IgnoredFunctions[k] ~=nil then
				return IgnoredFunctions[k]
			end
		end
	end,
	__newindex = function (t,k,v)
		--print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		if WriteOpenEUOtoHardUO[k] ~= nil then
			WriteOpenEUOtoHardUO[k](v)--_t[k] = v   -- update original table
		else
			error(k ..' is a read only variable', 2)
		end
	end
}
setmetatable(UO, __mt__)