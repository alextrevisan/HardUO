--Configurations
local __lag_offset__ = 0 --used for slow connections on functions (WaitTarget, ...)
function setLagOffset(value) __lag_offset__ = value end

-- OpenEUO compatibility variables
UO = {}
local OpenEUOReadVariables={}
local OpenEUOWriteVariables={}
local OpenEUOFunctions = {}

function SetCliNr(cliNr)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "CliNr")
    PushInteger(hnd, cliNr)
    Execute(hnd)
end
local function BackpackID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "BackpackID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CharName()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharName")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function Hits()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Hits")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function MaxHits()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxHits")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Mana()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Mana")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function MaxMana()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxMana")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Stamina()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Stamina")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function MaxStam()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxStam")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Sex()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Sex")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharPosX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharPosX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharPosY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharPosY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharPosZ()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharPosZ")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharDir()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharDir")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharStatus()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharStatus")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function CharType()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CharType")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Str()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Str")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Dex()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Dex")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Int()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Int")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Weight()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Weight")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function MaxWeight()

    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxWeight")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function MaxStats()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxStats")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Luck()

    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Luck")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function MinDmg()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MinDmg")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function MaxDmg()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxDmg")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Gold()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Gold")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function Followers()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "Followers")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function MaxFol()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "MaxFol")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Ar()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "AR")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Fr()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "FR")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Cr()

    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CR")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Pr()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "PR")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Er()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ER")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function Tp()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "TP")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getCursorX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CursorX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getCursorY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CursorY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function NextCPosX(x)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "NextCPosX")
    PushInteger(hnd, x)
    Execute(hnd)
end
local function NextCPosX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "NextCPosX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function NextCPosY(y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "NextCPosY")
    PushInteger(hnd, y)
    Execute(hnd)
end
local function NextCPosY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "NextCPosY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContSizeX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContSizeX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContSizeY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContSizeY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContPosX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContPosX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContPosX(x)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "ContPosX")
    PushInteger(hnd, x)
    Execute(hnd)
end
local function ContPosY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContPosY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContPosY(y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "ContPosY")
    PushInteger(hnd, y)
    Execute(hnd)
end
local function ContKind()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContKind")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContType()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContType")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function ContName()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "ContName")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function getNextCPosX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "NextCPosX")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function setNextCPosX(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "NextCPosX")
	PushInteger(hnd,id)
    Execute(hnd)
end
local function getNextCPosY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "NextCPosY")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function setNextCPosY(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "NextCPosY")
	PushInteger(hnd,id)
    Execute(hnd)
end
local function CliNr()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliNr")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliCnt()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliCnt")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliLang()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliLang")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function CliVer()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliVer")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function CliLogged()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliLogged")
    Execute(hnd)
    return GetBoolean(hnd, 1)
end
local function CliLeft()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliLeft")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliTop()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliTop")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliXRes()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliXRes")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliYRes()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliYRes")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function CliTitle()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CliTitle")
    Execute(hnd)
    return GetString(hnd, 1)
end
local function setLObjectID(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LObjectID")
    PushInteger(hnd, id)
    Execute(hnd)
end
local function getLObjectID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LObjectID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setLHandID(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LHandID")
    PushInteger(hnd, id)
    Execute(hnd)
end
local function getLHandID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LHandID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setRHandID(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "RHandID")
    PushInteger(hnd, id)
    Execute(hnd)
end
local function getRHandID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "RHandID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setLObjectType(type)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LObjectType")
    PushInteger(hnd, type)
    Execute(hnd)
end
local function getLObjectType()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LObjectType")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLTargetX()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetX")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLTargetY()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetY")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLTargetZ()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetZ")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setLTargetX(x)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetX")
    PushInteger(hnd, x)
    Execute(hnd)
end
local function setLTargetY(y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetY")
    PushInteger(hnd, y)
    Execute(hnd)
end
local function setLTargetZ(z)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetZ")
    PushInteger(hnd, z)
    Execute(hnd)
end
local function LLiftedID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LLiftedID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function LLiftedType()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LLiftedType")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function LLiftedKind()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LLiftedKind")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLSkill()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LSkill")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setLSkill(skill)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LSkill")
    PushInteger(hnd, skill)
    Execute(hnd)
end
local function getLSpell()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LSpell")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setLSpell(spell)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LSpell")
    PushInteger(hnd, spell)
    Execute(hnd)
end
local function GetSkill(skill)
    returnTable = {}
    returnTable["norm"] = 0
    returnTable["real"] = 0
    returnTable["cap"] = 0
    returnTable["lock"] = 0
	SetTop(hnd, 0)
	PushStrVal(hnd, "Call")
	PushStrVal(hnd, "GetSkill")
	PushStrVal(hnd, skill)
	Execute(hnd)

	returnTable["norm"] = GetInteger(hnd, 1)
	returnTable["real"] = GetInteger(hnd, 2)
	returnTable["cap"] = GetInteger(hnd, 3)
	returnTable["lock"] = GetInteger(hnd, 4)
	
    return returnTable.norm, returnTable.real, returnTable.cap, returnTable.lock
end
local function GetSkill(skill)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "GetSkill")
    PushStrVal(hnd, skill)
    Execute(hnd)
    return GetInteger(hnd, 2)
end
local function useLastSkill()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 13)
    PushInteger(hnd, 0)
    Execute(hnd)
end
function Speak(text)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 1)
    PushInteger(hnd, 0)
    PushStrVal(hnd, text)
    Execute(hnd)
end
local function Emote(text)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 2)
    PushInteger(hnd, 0)
    PushStrVal(hnd, text)
    Execute(hnd)
end
local function SysMessage(text, color)

    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "SysMessage")
    PushStrVal(hnd, text)
    PushInteger(hnd, color)
    Execute(hnd)
end
local function Msg(msg)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Msg")
    PushStrVal(hnd,msg)
    Execute(hnd)
end
local function WarPeace()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 6)
    PushInteger(hnd, 0)
    Execute(hnd)
end
local function Paste()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 7)
    PushInteger(hnd, 0)
    Execute(hnd)
end
local function OpenDoor()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 12)
    PushInteger(hnd, 0)
    Execute(hnd)
end
function EventMacro(x, y, z)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
    PushStrVal(hnd, z)
    Execute(hnd)
end
function EventMacro(x, y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
    Execute(hnd)
end
local function WaitTarget()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 25)
    PushInteger(hnd, 0)
    Execute(hnd)
end
local function LastTarget()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 22)
    PushInteger(hnd, 0)
    Execute(hnd)
end
local function TargetSelf()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Macro")
    PushInteger(hnd, 23)
    PushInteger(hnd, 0)
    Execute(hnd)
end
local function Move(x, y, tileError, timeOut)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Move")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
	if tileError~=nil then
		PushInteger(hnd, tileError)
	end
    if timeOut>0 then
        PushInteger(hnd, timeOut)
    end
    Execute(hnd)
end
local function getLTargetID()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetID")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function setContPos(x, y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "ContPosX")
    PushInteger(hnd, x)
    Execute(hnd)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "ContPosY")
    PushInteger(hnd, y)
    Execute(hnd)
end
local function setLTargetKind(kind)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetKind")
    PushInteger(hnd, kind)
    Execute(hnd)
end
local function getTargCurs()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "TargCurs")
    Execute(hnd)
    return  GetBoolean(hnd, 1)
end
local function setTargCurs(tc)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "TargCurs")
    PushBoolean(hnd, tc)
    Execute(hnd)
end
local function CursKind()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "CursKind")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLTargetKind()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetKind")
    Execute(hnd)
    return GetInteger(hnd, 1)
end
local function getLTargetTile()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Get")
    PushStrVal(hnd, "LTargetTile")
    Execute(hnd)
    return GetInteger(hnd, 1)
end

local function setLTargetTile(tile)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetTile")
	PushInteger(hnd, tile)
    Execute(hnd)
end

local function setLTargetID(ID)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Set")
    PushStrVal(hnd, "LTargetID")
    PushInteger(hnd, ID)
    Execute(hnd)
end
local function CliDrag(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "CliDrag")
    PushInteger(hnd, id)
    Execute(hnd)
end
local function Drag(id, amount)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Drag")
    PushInteger(hnd, id)
	if amount~=nil then
		PushInteger(hnd, amount)
	end
    Execute(hnd)
end

local function DropC(contID, x, y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "DropC")
    PushInteger(hnd, contID)
	if b~=nil and c~=nil then 
		PushInteger(hnd, x)
		PushInteger(hnd, y)
	end
    Execute(hnd)
end
local function DropG(x, y, z)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "DropG")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
    PushInteger(hnd, z)
    Execute(hnd)
end
local function DropG(x, y)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "DropG")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
    Execute(hnd)
end
local function DropPD()
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "DropPD")
    Execute(hnd)
end
local function Click(x, y, left, down, up, mc)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Click")
    PushInteger(hnd, x)
    PushInteger(hnd, y)
    PushBoolean(hnd, left)
    PushBoolean(hnd, down)
    PushBoolean(hnd, up)
    PushBoolean(hnd, mc)
    Execute(hnd)
end
local function ScanItems(visibleOnly)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "ScanItems")
    PushBoolean(hnd, visibleOnly)
    Execute(hnd)
    local mItemCount = GetInteger(hnd, 1)
    return mItemCount
end
local function GetItem(index)
    returnTable = {}

    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "GetItem")
    PushInteger(hnd, index)
    Execute(hnd)

    returnTable["id"] = GetInteger(hnd, 1)
    returnTable["type"] = GetInteger(hnd, 2)
    returnTable["kind"] = GetInteger(hnd, 3)
    returnTable["contId"] = GetInteger(hnd, 4)
    returnTable["x"] = GetInteger(hnd, 5)
    returnTable["y"] = GetInteger(hnd, 6)
    returnTable["z"] = GetInteger(hnd, 7)
    returnTable["stack"] = GetInteger(hnd, 8)
    returnTable["rep"] = GetInteger(hnd, 9)
    returnTable["color"] = GetInteger(hnd,10)
    return returnTable.id, returnTable.type, returnTable.kind, returnTable.contId, returnTable.x, returnTable.y, returnTable.z, returnTable.stack, returnTable.rep, returnTable.color
end
local function Property(id)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "Property")
    PushInteger(hnd, id)
    Execute(hnd)

    local returnTable = {}
    local name = GetString(hnd,1)
    local info = GetString(hnd,2)
    return name, info
end

local function GetJournal(index)
    SetTop(hnd, 0)
    PushStrRef(hnd, "Call")
    PushStrVal(hnd, "GetJournal")
    PushInteger(hnd, index)
    Execute(hnd)
    local line = GetString(hnd, 1)
    local color = GetInteger(hnd, 2)
    return line, color
end
local function ScanJournal(oldRef)
    SetTop(hnd, 0)
    PushStrVal(hnd, "Call")
    PushStrVal(hnd, "ScanJournal")
    PushInteger(hnd, oldRef)
    Execute(hnd)
    local ref = GetInteger(hnd, 1)
    local count = GetInteger(hnd, 2)
    return ref, count
end

--Character Variables
--The character category of system variables contains information specific to the character in the current instance of Ultima Online that EasyUO is attached to. 
UO.CharPosX = 0
OpenEUOReadVariables["CharPosX"] = CharPosX
UO.CharPosY = 0
OpenEUOReadVariables["CharPosY"] = CharPosY
UO.CharPosZ = 0
OpenEUOReadVariables["CharPosZ"] = CharPosZ
UO.CharDir = 0
OpenEUOReadVariables["CharDir"] = CharDir
UO.CharStatus = 0
OpenEUOReadVariables["CharStatus"] = CharStatus
UO.CharID = 0
OpenEUOReadVariables["CharID"] = CharID
UO.CharType = 0
OpenEUOReadVariables["CharType"] = CharType
UO.BackpackID = 0
OpenEUOReadVariables["BackpackID"] = BackpackID

--Status Variables
--Status variables come from the UO Status Bar in game. They provide information about the current character.
UO.CharName = 0
OpenEUOReadVariables["CharName"] = CharName
UO.Sex = 0
OpenEUOReadVariables["Sex"] = Sex
UO.Str = 0
OpenEUOReadVariables["Str"] = Str
UO.Hits = 0
OpenEUOReadVariables["Hits"] = Hits
UO.MaxHits = 0
OpenEUOReadVariables["MaxHits"] = MaxHits
UO.MaxWeight = 0
OpenEUOReadVariables["MaxWeight"] = MaxWeight
UO.Dex = 0
OpenEUOReadVariables["Dex"] = Dex
UO.Stamina = 0
OpenEUOReadVariables["Stamina"] = Stamina
UO.MaxStam = 0
OpenEUOReadVariables["MaxStam"] = MaxStam
UO.Int = 0
OpenEUOReadVariables["Int"] = Int
UO.Mana = 0
OpenEUOReadVariables["Mana"] = Mana
UO.MaxMana = 0
OpenEUOReadVariables["MaxMana"] = MaxMana
UO.MaxStats = 0
OpenEUOReadVariables["MaxStats"] = MaxStats
UO.Luck = 0
OpenEUOReadVariables["Luck"] = Luck
UO.Weight = 0
OpenEUOReadVariables["Weight"] = Weight
UO.MaxWeight = 0
OpenEUOReadVariables["MaxWeight"] = MaxWeight
UO.MinDmg = 0
OpenEUOReadVariables["MinDmg"] = MinDmg
UO.MaxDmg = 0
OpenEUOReadVariables["MaxDmg"] = MaxDmg
UO.Gold = 0
OpenEUOReadVariables["Gold"] = Gold
UO.Followers = 0
OpenEUOReadVariables["Followers"] = Followers
UO.MaxFol = 0
OpenEUOReadVariables["MaxFol"] = MaxFol
UO.AR = 0
OpenEUOReadVariables["AR"] = Ar
UO.FR = 0
OpenEUOReadVariables["FR"] = Fr
UO.CR = 0
OpenEUOReadVariables["CR"] = Cr
UO.PR = 0
OpenEUOReadVariables["PR"] = Pr
UO.ER = 0
OpenEUOReadVariables["ER"] = Er
UO.TP = 0
OpenEUOReadVariables["TP"] = Tp
--Mouse
UO.CursorX = 0
OpenEUOReadVariables["CursorX"] = getCursorX

UO.CursorY = 0
OpenEUOReadVariables["CursorY"] = getCursorY

--Container 
--Container system variables represent information available about the top most (or most reacent) gump that was opened, moved, or clicked in the Ultima Online Client. 

UO.NextCPosX = 0
OpenEUOReadVariables["NextCPosX"] = getNextCPosX
OpenEUOWriteVariables["NextCPosX"] = setNextCPosX

UO.NextCPosY = 0
OpenEUOReadVariables["NextCPosY"] = getNextCPosY
OpenEUOWriteVariables["NextCPosY"] = setNextCPosY

UO.ContSizeX = 0
OpenEUOReadVariables["ContSizeX"] = ContSizeX

UO.ContSizeY = 0
OpenEUOReadVariables["ContSizeY"] = ContSizeY

UO.ContPosX = 0
OpenEUOReadVariables["ContPosX"] = ContPosX

UO.ContPosY = 0
OpenEUOReadVariables["ContPosY"] = ContPosY

UO.ContKind = 0
OpenEUOReadVariables["ContKind"] = ContKind

UO.ContID = 0
OpenEUOReadVariables["ContID"] = ContID

UO.ContType = 0
OpenEUOReadVariables["ContType"] = ContType

UO.ContName = 0
OpenEUOReadVariables["ContName"] = ContName

UO.NextCPosX = 0
OpenEUOReadVariables["NextCPosX"] = getNextCPosX
OpenEUOWriteVariables["NextCPosX"] = setNextCPosX

UO.NextCPosY = 0
OpenEUOReadVariables["NextCPosY"] = getNextCPosY
OpenEUOWriteVariables["NextCPosY"] = setNextCPosY

UO.CliCnt = 0
OpenEUOReadVariables["CliCnt"] = CliCnt

UO.CliLang = 0
OpenEUOReadVariables["CliLang"] = CliLang

UO.CliVer = 0
OpenEUOReadVariables["CliVer"] = CliVer

UO.CliLogged = 0
OpenEUOReadVariables["CliLogged"] = CliLogged

UO.CliLeft = 0
OpenEUOReadVariables["CliLeft"] = CliLeft

UO.CliTop = 0
OpenEUOReadVariables["CliTop"] = CliTop

UO.CliXRes = 0
OpenEUOReadVariables["CliXRes"] = CliXRes

UO.CliYRes = 0
OpenEUOReadVariables["CliYRes"] = CliYRes

UO.CliTitle = 0
OpenEUOReadVariables["CliTitle"] = CliTitle

UO.LObjectID = 0
OpenEUOReadVariables["LObjectID"] = getLObjectID
OpenEUOWriteVariables["LObjectID"] = setLObjectID

UO.LHandID = 0
OpenEUOReadVariables["LHandID"] = getLHandID
OpenEUOWriteVariables["LHandID"] = setLHandID

UO.RHandID = 0
OpenEUOReadVariables["RHandID"] = getRHandID
OpenEUOWriteVariables["RHandID"] = setRHandID

UO.LObjectType = 0
OpenEUOReadVariables["LObjectType"] = getLObjectType
OpenEUOWriteVariables["LObjectType"] = setLObjectType

UO.LTargetID = 0
OpenEUOReadVariables["LTargetID"] = getLTargetID
OpenEUOWriteVariables["LTargetID"] = setLTargetID

UO.LTargetX = 0
OpenEUOReadVariables["LTargetX"] = getLTargetX
OpenEUOWriteVariables["LTargetX"] = setLTargetX

UO.LTargetY = 0
OpenEUOReadVariables["LTargetY"] = getLTargetY
OpenEUOWriteVariables["LTargetY"] = setLTargetY

UO.LTargetZ = 0
OpenEUOReadVariables["LTargetZ"] = getLTargetZ
OpenEUOWriteVariables["LTargetZ"] = setLTargetZ

UO.LTargetKind = 0
OpenEUOReadVariables["LTargetKind"] = getLTargetKind
OpenEUOWriteVariables["LTargetKind"] = setLTargetKind

UO.LTargetTile = 0
OpenEUOReadVariables["LTargetTile"] = getLTargetTile
OpenEUOWriteVariables["LTargetTile"] = setLTargetTile

UO.TargCurs = 0
OpenEUOReadVariables["TargCurs"] = getTargCurs
OpenEUOWriteVariables["TargCurs"] = setTargCurs

UO.LLiftedID = 0
OpenEUOReadVariables["LLiftedID"] = LLiftedID

UO.LLiftedKind = 0
OpenEUOReadVariables["LLiftedKind"] = LLiftedKind

UO.LLiftedType = 0
OpenEUOReadVariables["LLiftedType"] = LLiftedType

UO.LSkill = 0
OpenEUOReadVariables["LSkill"] = getLSkill
OpenEUOWriteVariables["LSkill"] = setLSkill

UO.LSpell = 0
OpenEUOReadVariables["LSpell"] = getLSpell
OpenEUOWriteVariables["LSpell"] = setLSpell

--FindItem 
--The euox system variables are set when the FindItem command is used, however in oeuo the command UO.GetItem populates most of these fields. 
UO.ScanItems = ScanItems
OpenEUOFunctions["ScanItems"] = ScanItems

UO.GetItem = GetItem
OpenEUOFunctions["GetItem"] = GetItem

UO.Move = Move
OpenEUOFunctions["Move"] = Move

--Extended 
--Extended system variables show information about various systems in the Ultima Online client that can be gained by using certain commands. 
UO.SysMessage = SysMessage
OpenEUOFunctions["SysMessage"] = SysMessage

UO.Msg = Msg
OpenEUOFunctions["Msg"] = Msg

UO.CursKind = 0
OpenEUOReadVariables["CursKind"] = CursKind

UO.GetSkill = 0
OpenEUOFunctions["GetSkill"] = GetSkill

UO.GetJournal = 0
OpenEUOFunctions["GetJournal"] = GetJournal

UO.ScanJournal = 0
OpenEUOFunctions["ScanJournal"] = ScanJournal

UO.Drag = 0
OpenEUOFunctions["Drag"] = Drag

UO.DropC = 0
OpenEUOFunctions["DropC"] = DropC

UO.Property = 0
OpenEUOFunctions["Property"] = Property

UO.Macro = 0
OpenEUOFunctions["Macro"] = EventMacro

UO.Click = 0
OpenEUOFunctions["Click"] = Click

--Spells
local function castMagery(magery)
	EventMacro(15,magery)
end
function castClumsy () castMagery( 0 ) end
function castCreateFood () castMagery( 1 ) end
function castFeeblemind () castMagery( 2 ) end
function castHeal () castMagery( 3 ) end
function castMagicArrow () castMagery( 4 ) end
function castNightSight () castMagery( 5 ) end
function castReactiveArmor () castMagery( 6 ) end
function castWeaken () castMagery( 7 ) end
function castAgility () castMagery( 8 ) end
function castCunning () castMagery( 9 ) end
function castCure () castMagery( 10 ) end
function castHarm () castMagery( 11 ) end
function castMagicTrap () castMagery( 12 ) end
function castMagicUntrap () castMagery( 13 ) end
function castProtection() castMagery( 14 ) end
function castStrength () castMagery( 15 ) end
function castBless () castMagery( 16 ) end
function castFireball () castMagery( 17 ) end
function castMagicLock () castMagery( 18 ) end
function castPoison () castMagery( 19 ) end
function castTelekinesis () castMagery( 20 ) end
function castTeleport () castMagery( 21 ) end
function castUnlock () castMagery( 22 ) end
function castWallOfStone () castMagery( 23 ) end
function castArchCure () castMagery( 24 ) end
function castArchProtection () castMagery( 25 ) end
function castCurse () castMagery( 26 ) end
function castFireField () castMagery( 27 ) end
function castGreaterHeal () castMagery( 28 ) end
function castLightning () castMagery( 29 ) end
function castManaDrain () castMagery( 30 ) end
function castRecall () castMagery( 31 ) end
function castBladeSpirits () castMagery( 32 ) end
function castDispelField () castMagery( 33 ) end
function castIncognito () castMagery( 34 ) end
function castMagicReflection () castMagery( 35 ) end
function castMindBlast () castMagery( 36 ) end
function castParalyze () castMagery( 37 ) end
function castPoisonField () castMagery( 38 ) end
function castSummonCreature () castMagery( 39 ) end
function castDispel () castMagery( 40 ) end
function castEnergyBolt () castMagery( 41 ) end
function castExplosion () castMagery( 42 ) end
function castInvisibility () castMagery( 43 ) end
function castMark () castMagery( 44 ) end
function castMassCurse () castMagery( 45 ) end
function castParalyzeField () castMagery( 46 ) end
function castReveal () castMagery( 47 ) end
function castChainLightning () castMagery( 48 ) end
function castEnergyField () castMagery( 49 ) end
function castFlameStrike () castMagery( 50 ) end
function castGateTravel () castMagery( 51 ) end
function castManaVampire () castMagery( 52 ) end
function castMassDispel () castMagery( 53 ) end
function castMeteorSwarm () castMagery( 54 ) end
function castPolymorph () castMagery( 55 ) end
function castEarthquake () castMagery( 56 ) end
function castEnergyVortex () castMagery( 57 ) end
function castResurrection () castMagery( 58 ) end
function castAirElemental () castMagery( 59 ) end
function castSummonDaemon () castMagery( 60 ) end
function castEarthElemental () castMagery( 61 ) end
function castFireElemental () castMagery( 62 ) end
function castWaterElemental () castMagery( 63 ) end

-- Skills
function useLastSkill() EventMacro(14,0) end
function useAnatomy() EventMacro(13,1)  end
function useAnimalLore() EventMacro(13,2)  end
function useItemIdentification() EventMacro(13,3)  end
function useArmsLore() EventMacro(13,3)  end
function useBegging() EventMacro(13,6)  end
function usePeacemaking() EventMacro(13,9)  end
function useCartography() EventMacro(13,12)  end
function useDetectingHidden() EventMacro(13,14)  end
function useDiscordance() EventMacro(13,15) end
function useEvaluatingIntelligence() EventMacro(13,16) end
function useForensicEvaluation() EventMacro(13,19) end
function useHidding() EventMacro(13,21) end
function usePoisoning() EventMacro(13,30) end
function useSpiritSpeak() EventMacro(13,32) end
function useStealing() EventMacro(33) end
function useTasteIdentification() EventMacro(13,36) end
function useTracking() EventMacro(13,38) end
function useMeditation() EventMacro(13,46) end
function useStealth() EventMacro(13,47) end
function useRemoveTrap() EventMacro(13,48) end

-- Target

-- Journal

--Items

--Mouse

--File
function openfile(file, mode)
	return io.open(file, mode)
end

--Standard Functions
function dostring(s)
	return loadstring(s)()
end
function stop()
    error("Macro stopped.",666)
end
function getticks()
    return os.clock()*1000
end
function gettime()
    time =  os.date("*t")
	return time.hour, time.min, time.sec
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
		if OpenEUOReadVariables[k] ~= nil then--print("*access to element " .. tostring(k))
		    --print("warning: UO.".. k .. " is nil...")
			return OpenEUOReadVariables[k]()--_t[k]   -- access the original table
		else
			if OpenEUOFunctions[k] ~=nil then
				return OpenEUOFunctions[k]
			end
		end
	end,
	__newindex = function (t,k,v)
		--print("*update of element " .. tostring(k) .. " to " .. tostring(v))
		if OpenEUOWriteVariables[k] ~= nil then
			OpenEUOWriteVariables[k](v)--_t[k] = v   -- update original table
		else
			error(k ..' is a read only variable', 2)
		end
	end
}
setmetatable(UO, __mt__)