#include "uo.h"
#include "UOdll.h"
#include <QDebug>

UO::UO()
{
    mNewRefJournal = 0;
    if(!InitWrapper())
    {
        exit(666);
    }

    hnd = Open();
    SetCliNr(1);

}
void UO::SetLuaState(lua_State *L)
{
   mLuaState = L;
}

void UO::SetCliNr(int cliNr)
{
    mCliNr = cliNr;
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, cliNr);
    Execute(hnd);
}

/// Dados do personagem
int UO::BackpackID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "BackpackID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
std::string UO::CharName()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharName");
    Execute(hnd);
    return GetString(hnd, 1);
}
int UO::Hits()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Hits");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::MaxHits()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxHits");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::Mana()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Mana");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::MaxMana()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxMana");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::Stamina()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Stamina");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::MaxStam()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxStam");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Sex()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Sex");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CharPosX()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharPosX");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CharPosY()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharPosY");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CharPosZ()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharPosZ");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CharDir()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharDir");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

std::string UO::CharStatus()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharStatus");
    Execute(hnd);
    return GetString(hnd, 1);
}

int UO::CharID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CharType()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharType");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Str()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Str");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Dex()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Dex");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Int()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Int");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Weight()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Weight");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::MaxWeight()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxWeight");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::MaxStats()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxStats");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Luck()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Luck");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::MinDmg()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MinDmg");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::MaxDmg()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxDmg");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::Gold()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Gold");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Followers()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "Followers");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::MaxFol()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "MaxFol");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::Ar()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "AR");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Fr()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "FR");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Cr()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CR");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Pr()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "PR");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Er()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ER");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::Tp()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "TP");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::NextCPosX(int x)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "NextCPosX");
    PushInteger(hnd, x);
    Execute(hnd);
}

int UO::NextCPosX()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "NextCPosX");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::NextCPosY(int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "NextCPosY");
    PushInteger(hnd, y);
    Execute(hnd);
}

int UO::NextCPosY()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "NextCPosY");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::ContSizeX()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContSizeX");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::ContSizeY()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContSizeY");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::ContPosX()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContPosX");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::ContPosX(int x)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "ContPosX");
    PushInteger(hnd, x);
    Execute(hnd);
}

int UO::ContPosY()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContPosY");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::ContPosY(int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "ContPosY");
    PushInteger(hnd, y);
    Execute(hnd);
}

int UO::ContKind()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContKind");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::ContID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::ContType()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContType");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

std::string UO::ContName()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "ContName");
    Execute(hnd);
    return GetString(hnd, 1);
}

int UO::CliNr()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliNr");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CliCnt()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliCnt");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

std::string UO::CliLang()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliLang");
    Execute(hnd);
    return GetString(hnd, 1);
}

std::string UO::CliVer()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliVer");
    Execute(hnd);
    return GetString(hnd, 1);
}

bool UO::CliLogged()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliLogged");
    Execute(hnd);
    return GetBoolean(hnd, 1);
}

int UO::CliLeft()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliLeft");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CliTop()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliTop");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CliXRes()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliXRes");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::CliYRes()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliYRes");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

std::string UO::CliTitle()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CliTitle");
    Execute(hnd);
    return GetString(hnd, 1);
}

/// Last Action
void UO::LObjectID(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LObjectID");
    PushInteger(hnd, id);
    Execute(hnd);
}
int UO::LObjectID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LObjectID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
/// Last WeaponID
void UO::LHandID(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LHandID");
    PushInteger(hnd, id);
    Execute(hnd);
}
/// Last WeaponID
int UO::LHandID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LHandID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
/// Last WeaponID
void UO::RHandID(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "RHandID");
    PushInteger(hnd, id);
    Execute(hnd);
}
/// Last WeaponID
int UO::RHandID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "RHandID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::LObjectType(int type)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LObjectType");
    PushInteger(hnd, type);
    Execute(hnd);
}

int UO::LObjectType()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LObjectType");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LTargetX()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetX");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LTargetY()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetY");
    Execute(hnd);
    return GetInteger(hnd, 1);
}
int UO::LTargetZ()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetZ");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::setLTargetX(int x)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LTargetX");
    PushInteger(hnd, x);
    Execute(hnd);
}

void UO::setLTargetY(int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LTargetY");
    PushInteger(hnd, y);
    Execute(hnd);
}

void UO::setLTargetZ(int z)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LTargetZ");
    PushInteger(hnd, z);
    Execute(hnd);
}

int UO::LLiftedID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LLiftedID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LLiftedType()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LLiftedType");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LLiftedKind()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LLiftedKind");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LSkill()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LSkill");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::LSkill(int skill)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LSkill");
    PushInteger(hnd, skill);
    Execute(hnd);
}

int UO::LSpell()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LSpell");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::LSpell(int spell)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LSpell");
    PushInteger(hnd, spell);
    Execute(hnd);
}

/// Skills
luabind::object UO::GetSkill(luabind::object skill)
{
    luabind::object returnTable = luabind::newtable( mLuaState );
    returnTable["norm"] = 0;
    returnTable["real"] = 0;
    returnTable["cap"] = 0;
    returnTable["lock"] = 0;
    if(luabind::type(skill)==LUA_TSTRING)
    {
        SetTop(hnd, 0);
        PushStrVal(hnd, "Call");
        PushStrVal(hnd, "GetSkill");
        PushStrVal(hnd, (char*)luabind::object_cast<std::string>(skill).data());
        Execute(hnd);

        returnTable["norm"] = GetInteger(hnd, 1);
        returnTable["real"] = GetInteger(hnd, 2);
        returnTable["cap"] = GetInteger(hnd, 3);
        returnTable["lock"] = GetInteger(hnd, 4);
    }
    return returnTable;
}

int UO::GetSkill(std::string skill)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "GetSkill");
    PushStrVal(hnd, (char*)skill.data());
    Execute(hnd);
    return GetInteger(hnd, 2); //real
}
void UO::useLastSkill()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::useAnatomy()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 1);
    Execute(hnd);
}
void UO::useAnimalLore()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 2);
    Execute(hnd);
}
void UO::useItemIdentification()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 3);
    Execute(hnd);
}
void UO::useArmsLore()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 4);
    Execute(hnd);
}
void UO::useBegging()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 6);
    Execute(hnd);
}
void UO::usePeacemaking()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 9);
    Execute(hnd);
}
void UO::useCartography()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 12);
    Execute(hnd);
}
void UO::useDetectingHidden()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 14);
    Execute(hnd);
}
void UO::useDiscordance()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 15);
    Execute(hnd);
}
void UO::useEvaluatingIntelligence()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 16);
    Execute(hnd);
}
void UO::useForensicEvaluation()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 19);
    Execute(hnd);
}
void UO::useHidding()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 21);
    Execute(hnd);
}
void UO::useProvocation()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 22);
    Execute(hnd);
}
void UO::useInscription()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 23);
    Execute(hnd);
}
void UO::usePoisoning()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 30);
    Execute(hnd);
}
void UO::useSpiritSpeak()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 32);
    Execute(hnd);
}
void UO::useStealing()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 33);
    Execute(hnd);
}
void UO::useTasteIdentification()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 36);
    Execute(hnd);
}
void UO::useTracking()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 38);
    Execute(hnd);
}
void UO::useMeditation()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 46);
    Execute(hnd);
}
void UO::useStealth()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 47);
    Execute(hnd);
}
void UO::useRemoveTrap()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 13);
    PushInteger(hnd, 48);
    Execute(hnd);
}

///Magics
void UO::castMagery(int ID)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 15);
    PushInteger(hnd,ID);
    Execute(hnd);
}

///Ações
void UO::Speak(std::string Text)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 1);
    PushInteger(hnd, 0);
    PushStrVal(hnd, (char*)Text.data());
    Execute(hnd);
}
void UO::Emote(std::string Text)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 2);
    PushInteger(hnd, 0);
    PushStrVal(hnd, (char*)Text.data());
    Execute(hnd);
}
void UO::SystemMessage(std::string Text, int color)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "SysMessage");
    PushStrVal(hnd, (char*)Text.data());
    PushInteger(hnd, color);
    Execute(hnd);
}
int UO::Msg(const std::string& msg)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Msg");
    PushStrVal(hnd,(char*)msg.data());
    Execute(hnd);
}
void UO::WarPeace()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 6);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::Paste() //Cola o texto que estiver no clipboard
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 7);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::OpenDoor()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 12);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::EventMacro(int x, int y, std::string z)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    PushStrVal(hnd, (char*)z.data());
    Execute(hnd);
}
void UO::EventMacro(int x, int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    Execute(hnd);
}
void UO::WaitTarget()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 25);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::LastTarget()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 22);
    PushInteger(hnd, 0);
    Execute(hnd);
}
void UO::TargetSelf()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Macro");
    PushInteger(hnd, 23);
    PushInteger(hnd, 0);
    Execute(hnd);
}
bool UO::Move(int x, int y, int tileError, int timeOut)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Move");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    PushInteger(hnd, tileError);
    if(timeOut>0)
        PushInteger(hnd, timeOut);
    Execute(hnd);
}

///Sistema
int UO::getLastTargetID()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetID");
    Execute(hnd);
    return GetInteger(hnd, 1);
}


void UO::setContPos(int x, int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "ContPosX");
    PushInteger(hnd, x);
    Execute(hnd);
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "ContPosY");
    PushInteger(hnd, y);
    Execute(hnd);
}

void UO::setLTargetKind(int kind)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LTargetKind");
    PushInteger(hnd, kind);
    Execute(hnd);
}

int UO::TargCurs()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "TargCurs");
    Execute(hnd);
    return GetBoolean(hnd, 1)==false?0:1;
}

void UO::setTargCurs(int tc)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "TargCurs");
    PushBoolean(hnd, tc==0?false:true);
    Execute(hnd);
}

int UO::CursKind()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CursKind");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LTargetKind()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetKind");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

int UO::LTargetTile()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "LTargetTile");
    Execute(hnd);
    return GetInteger(hnd, 1);
}

void UO::setLastTargetID(int ID)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "LTargetID");
    PushInteger(hnd, ID);
    Execute(hnd);
}

void UO::CliDrag(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "CliDrag");
    PushInteger(hnd, id);
    Execute(hnd);
}

void UO::Drag(int id, int amount)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Drag");
    PushInteger(hnd, id);
    PushInteger(hnd, amount);
    Execute(hnd);
}
void UO::Drag(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Drag");
    PushInteger(hnd, id);
    Execute(hnd);
}

void UO::DropC(int contID, int x, int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "DropC");
    PushInteger(hnd, contID);
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    Execute(hnd);
}

void UO::DropC(int contID)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "DropC");
    PushInteger(hnd, contID);
    Execute(hnd);
}

void UO::DropG(int x, int y, int z)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "DropG");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    PushInteger(hnd, z);
    Execute(hnd);
}

void UO::DropG(int x, int y)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "DropG");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    Execute(hnd);
}

void UO::DropPD()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "DropPD");
    Execute(hnd);
}

void UO::Click(int x, int y, bool left, bool down, bool up, bool mc)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Click");
    PushInteger(hnd, x);
    PushInteger(hnd, y);
    PushBoolean(hnd, left);
    PushBoolean(hnd, down);
    PushBoolean(hnd, up);
    PushBoolean(hnd, mc);
    Execute(hnd);
}

void UO::ClearJournal()
{
    mJournalList.clear();
}

int UO::LastJournalIndex(luabind::object obj)
{
    QList<QString> sortedJournal = mJournalList;
    std::reverse(sortedJournal.begin(), sortedJournal.end());
    QList<QString> searchList;
    if(luabind::type(obj)==LUA_TTABLE)
    {
        for ( luabind::iterator i( obj ), end; i != end; ++i )
        {
            luabind::object val = *i;
            if ( luabind::type( val ) == LUA_TSTRING )
            {
                searchList.append(luabind::object_cast<std::string>(val).data());
            }
        }
    }
    else if(luabind::type(obj)==LUA_TSTRING)
    {
        searchList.append(luabind::object_cast<std::string>(obj).data());
    }
    else
    {
        return 0;
    }
    int journalIndex = 0;
    foreach(QString value, sortedJournal)
    {
        ++journalIndex;
        foreach(QString search, searchList)
        {
            int j = 0;
            if(value.contains(search))
            {
                return journalIndex;
            }
        }
    }
    return 0;
}

void UO::ScanJournal()
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "ScanJournal");
    PushInteger(hnd, mNewRefJournal);
    Execute(hnd);
    mNewRefJournal = GetInteger(hnd, 1);
    mCntJournal = GetInteger(hnd, 2);

    for(int i = 0; i < mCntJournal; ++i)
    {
        SetTop(hnd, 0);
        PushStrRef(hnd, "Call");
        PushStrVal(hnd, "GetJournal");
        PushInteger(hnd, i);
        Execute(hnd);
        mJournalList.append(GetString(hnd, 1));
    }
}

JournalRef UO::ScanJournal(int oldRef)
{
    JournalRef ref;
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "ScanJournal");
    PushInteger(hnd, oldRef);
    Execute(hnd);
    ref.ref = GetInteger(hnd, 1);
    ref.count = GetInteger(hnd, 2);
    return ref;
}

Journal UO::GetJournal(int index)
{
    Journal j;
    SetTop(hnd, 0);
    PushStrRef(hnd, "Call");
    PushStrVal(hnd, "GetJournal");
    PushInteger(hnd, index);
    Execute(hnd);
    j.line = GetString(hnd, 1);
    j.color = GetInteger(hnd, 2);
    return j;
}
bool UO::FindJournal(luabind::object obj)
{
    QList<QString> searchList;
    if(luabind::type(obj)==LUA_TTABLE)
    {
        for ( luabind::iterator i( obj ), end; i != end; ++i )
        {
            luabind::object val = *i;
            if ( luabind::type( val ) == LUA_TSTRING )
            {
                searchList.append(luabind::object_cast<std::string>(val).data());
            }
        }
    }
    else if(luabind::type(obj)==LUA_TSTRING)
    {
        searchList.append(luabind::object_cast<std::string>(obj).data());
    }
    else
    {
        return false;
    }

    foreach(QString value, mJournalList)
    {
        foreach(QString search, searchList)
        {
            int j = 0;
            while ((j = value.indexOf(search, j)) != -1)
            {
                ++j;
                return true;
            }
        }
    }
    return false;
}

void UO::SetJournalIndex(int index, const std::string& value)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "SetIndexValue");
    PushInteger(hnd, index);
    PushStrVal(hnd,  (char*)value.data());
}

int UO::ScanItems(bool visibleOnly)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "ScanItems");
    PushBoolean(hnd, visibleOnly);
    Execute(hnd);
    mItemCount = GetInteger(hnd, 1);
    return mItemCount;
}
luabind::object UO::GetItem(int index)
{
    luabind::object returnTable = luabind::newtable( mLuaState );
    if(index>mItemCount || index < 0)
    {
        return returnTable;
    }
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "GetItem");
    PushInteger(hnd, index);
    Execute(hnd);

    returnTable["id"] = GetInteger(hnd, 1);
    returnTable["type"] = GetInteger(hnd, 2);
    returnTable["kind"] = GetInteger(hnd, 3);
    returnTable["contId"] = GetInteger(hnd, 4);
    returnTable["x"] = GetInteger(hnd, 5);
    returnTable["y"] = GetInteger(hnd, 6);
    returnTable["z"] = GetInteger(hnd, 7);
    returnTable["stack"] = GetInteger(hnd, 8);
    returnTable["rep"] = GetInteger(hnd, 9);
    returnTable["color"] = GetInteger(hnd,10);
    return returnTable;
}

luabind::object UO::GetProperty(int id)
{
    SetTop(hnd, 0);
    PushStrVal(hnd, "Call");
    PushStrVal(hnd, "Property");
    PushInteger(hnd, id);
    Execute(hnd);

    luabind::object returnTable = luabind::newtable( mLuaState );
    std::string name = GetString(hnd,1);
    std::string info = GetString(hnd,2);
    returnTable["name"] = name;
    returnTable["info"] = info;
    return returnTable;
}
luabind::object UO::FindItem(luabind::object const& table)
{
    QList<luabind::object> removeList;
    QList<int> typeFilter;
    QList<int> idFilter;
    QList<int> contIDFilter;

    /** Primeiro passo -  verificar quais filtros foram passados no parametro **/
    //verifica se o tipo do objeto passado eh uma tabela
    if(luabind::type(table)==LUA_TTABLE)
    {
        /** ID **/
        //verifica se o filtro ID é um numero ou lista de numeros dos tipos
        //se for numero adiciona na lista de filtros
        if(luabind::type(table["ID"])==LUA_TNUMBER)
        {
            idFilter.append(luabind::object_cast<int>(table["ID"]));
        }
        //se for uma lista de id percorre cada item e adiciona na lista de filtros
        else if (luabind::type(table["ID"])==LUA_TTABLE)
        {
            for ( luabind::iterator i( table["ID"] ), end; i != end; ++i )
            {
                luabind::object val = *i;
                if ( luabind::type( val ) == LUA_TNUMBER )
                {
                    idFilter.append(luabind::object_cast<int>(val));
                }
            }
        }
        /** Type **/
        //verifica se o filtro type é um numero ou lista de numeros dos tipos
        //se for numero adiciona na lista de filtros
        if(luabind::type(table["Type"])==LUA_TNUMBER)
        {
            typeFilter.append(luabind::object_cast<int>(table["Type"]));
        }
        //se for uma lista de tipos percorre cada item e adiciona na lista de filtros
        else if (luabind::type(table["Type"])==LUA_TTABLE)
        {
            for ( luabind::iterator i( table["Type"] ), end; i != end; ++i )
            {
                luabind::object val = *i;
                if ( luabind::type( val ) == LUA_TNUMBER )
                {
                    typeFilter.append(luabind::object_cast<int>(val));
                }
            }
        }
        /** ContID **/
        //verifica se o filtro type é um numero ou lista de numeros dos tipos
        //se for numero adiciona na lista de filtros
        if(luabind::type(table["ContID"])==LUA_TNUMBER)
        {
            contIDFilter.append(luabind::object_cast<int>(table["ContID"]));
        }
        //se for uma lista de tipos percorre cada item e adiciona na lista de filtros
        else if (luabind::type(table["ContID"])==LUA_TTABLE)
        {
            for ( luabind::iterator i( table["ContID"] ), end; i != end; ++i )
            {
                luabind::object val = *i;
                if ( luabind::type( val ) == LUA_TNUMBER )
                {
                    contIDFilter.append(luabind::object_cast<int>(val));
                }
            }
        }
        /** outros **/
    }
    /** Segundo passo - Coletar os itens **/
    QList<luabind::object> itemList;
    ScanItems(true);

    for(int x = 0; x<mItemCount;++x)
    {
        //Item *item = new Item;
        luabind::object item = GetItem(x);
        itemList.append(item);
    }

    /** Terceiro passo - Verificar quais itens serao removidos da lista de itens coletados **/
    foreach(luabind::object i, itemList)
    {
        /** remove os itens que nao estao na lista de ID **/
        bool sameID = false;
        foreach(int id, idFilter)
        {
            if(luabind::object_cast<int>(i["id"])==id)
            {
                sameID = true;
                break;
            }
        }
        if(!sameID&&!idFilter.empty())
        {
            removeList.append(i);
        }
        /** remove os itens que nao estao na lista de Type **/
        bool sameType = false;
        foreach(int type, typeFilter)
        {
            if(luabind::object_cast<int>(i["type"])==type)
            {
                sameType = true;
                break;
            }
        }
        if(!sameType&&!typeFilter.empty())
        {
            removeList.append(i);
        }
        /** remove os itens que nao estao nos contID passados **/
        bool sameContID = false;
        foreach(int contID, contIDFilter)
        {
            if(luabind::object_cast<int>(i["contId"])==contID)
            {
                sameContID = true;
                break;
            }
        }
        if(!sameContID&&!contIDFilter.empty())
        {
            removeList.append(i);
        }
    }

    /** Quarto passo - Remover os itens que nao passaram do filtro **/
    foreach(luabind::object i, removeList)
    {
        itemList.removeOne(i);
    }
    /** Quinto passo -  cria a table da lua pra retornar os itens **/
    luabind::object returnTable = luabind::newtable( mLuaState );
    for(int x = 1; x<= itemList.size();++x)
    {
        returnTable[x] = itemList.at(x-1);
    }
    return returnTable;
}



