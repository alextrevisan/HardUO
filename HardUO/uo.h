#ifndef UO_H_
#define UO_H_

extern "C"
{
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}

#include <luabind/luabind.hpp>

#include <iostream>
#include <deque>
#include <vector>
#include <string>
#include <QList>
#include <QString>

class JournalRef
{
public:
    JournalRef():
        ref(0),
        count(0)
    {}
    int ref;
    int count;
};

class Journal
{
public:
    Journal():
        line(""),
        color(0)
    {}
    std::string line;
    int color;
};

struct ItemProperty
{
public:
    ItemProperty()
    {
        itemname.reserve(128);
        iteminfo.reserve(128);
    }
    std::string itemname;
    std::string iteminfo;
};

class UO
{
    int hnd;
public:
    UO();
    void SetLuaState(lua_State *L);

    void SetCliNr(int cliNr);
    int GetCliNr(){ return mCliNr;}

    /// Dados do personagem

    int BackpackID();
    std::string CharName();
    int Hits();
    int MaxHits();
    int Mana();
    int MaxMana();
    int Stamina();
    int MaxStam();
    int Sex();
    int CharPosX();
    int CharPosY();
    int CharPosZ();
    int CharDir();
    std::string CharStatus();
    int CharID();
    int CharType();
    int Str();
    int Dex();
    int Int();
    int Weight();
    int MaxWeight();
    int MaxStats();
    int Luck();
    int MinDmg();
    int MaxDmg();
    int Gold();
    int Followers();
    int MaxFol();
    int Ar();
    int Fr();
    int Cr();
    int Pr();
    int Er();
    int Tp();

    /// Container
    void NextCPosX(int x);
    int NextCPosX();
    void NextCPosY(int y);
    int NextCPosY();
    int ContSizeX();
    int ContSizeY();
    int ContPosX();
    void ContPosX(int x);
    int ContPosY();
    void ContPosY(int y);
    int ContKind();
    int ContID();
    int ContType();
    std::string ContName();

    /// Client Info
    int CliNr();
    int CliCnt();
    std::string CliLang();
    std::string CliVer();
    bool CliLogged();
    int CliLeft();
    int CliTop();
    int CliXRes();
    int CliYRes();
    std::string CliTitle();

    /// Last Action
    void LObjectID(int id);
    int LObjectID();
    void LObjectType(int type);
    int LObjectType();
    int getLastTargetID();
    void setLastTargetID(int ID);
    int LTargetX();
    int LTargetY();
    int LTargetZ();
    void setLTargetX(int x);
    void setLTargetY(int y);
    void setLTargetZ(int z);
    int LTargetKind();
    int LTargetTile();
    void setLTargetKind(int kind);
    int LLiftedID();
    int LLiftedType();
    int LLiftedKind();
    int LSkill();
    void LSkill(int skill);
    int LSpell();
    void LSpell(int spell);


    /// Skills
    luabind::object GetSkill(luabind::object skill);
    int GetSkill(std::string skill);
    void useLastSkill();
    void useAnatomy();
    void useAnimalLore();
    void useItemIdentification();
    void useArmsLore();
    void useBegging();
    void usePeacemaking();
    void useCartography();
    void useDetectingHidden();
    void useDiscordance();
    void useEvaluatingIntelligence();
    void useForensicEvaluation();
    void useHidding();
    void useProvocation();
    void useInscription();
    void usePoisoning();
    void useSpiritSpeak();
    void useStealing();
    void useTasteIdentification();
    void useTracking();
    void useMeditation();
    void useStealth();
    void useRemoveTrap();

    /// Magics
    void castMagery(int ID);

    /// Ações
    void Speak(std::string Text);
    void Emote(std::string Text);
    void SystemMessage(std::string Text, int color);
    void WarPeace();
    void Paste(); //Cola o texto que estiver no clipboard
    void OpenDoor();
    void EventMacro(int x, int y);
    void WaitTarget();
    void LastTarget();
    void TargetSelf();
    bool Move(int x, int y, int tileError, int timeOut);

    void ClearJournal();

    int LastJournalIndex(luabind::object obj);

    void setContPos(int x, int y);



    int TargCurs();
    void setTargCurs(int tc);

    int CursKind();

    void CliDrag(int id);
    void Drag(int id, int amount);
    void Drag(int id);
    void DropC(int contID, int x, int y);
    void DropC(int contID);
    void DropG(int x, int y, int z);
    void DropG(int x, int y);
    void DropPD();

    void Click(int x, int y, bool left, bool down, bool up, bool mc);

    void ScanJournal();
    JournalRef ScanJournal(int oldRef);
    Journal GetJournal(int index);
    bool FindJournal(luabind::object obj);
    void SetJournalIndex(int index, const std::string& value);

    int ScanItems(bool visibleOnly);
    luabind::object GetItem(int index);
    luabind::object GetProperty(int id);
    luabind::object FindItem(luabind::object const& table);

private:
    int mCliNr;
    int mItemCount;
    int mCntJournal;
    int mNewRefJournal;
    QList<QString> mJournalList;
    lua_State *mLuaState;

};
#endif // UO_H
