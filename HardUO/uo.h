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

class Item
{
public:
    Item()
        :id(0)
        ,type(0)
        ,kind(0)
        ,contId(0)
        ,x(0)
        ,y(0)
        ,z(0)
        ,stack(0)
        ,rep(0)
        ,color(0)
    {}
    int id;
    int type;
    int kind;
    int contId;
    int x;
    int y;
    int z;
    int stack;
    int rep;
    int color;
};
class Skill
{
public:
    Skill(){}
    int norm;
    int real;
    int cap;
    int lock;
};

class Property
{
public:
    Property()
    {}
    std::string name;
    std::string info;
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
    int Ar();
    int BackpackID();
    std::string CharName();
    int Hits();
    int MaxHits();
    int Mana();
    int MaxMana();
    int Stam();
    int MaxStam();
    int Gold();
    int Sex();
    int CharPosX();
    int CharPosY();
    int CharPosZ();
    int Weight();
    int MaxWeight();

    /// Skills
    Skill GetSkill(std::string skill);
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


    /// Client Info
    int CliCnt();
    int CliNr();
    void ClearJournal();

    int LastJournalIndex(luabind::object obj);
    /// Sistema
    int getLastTargetID();
    void setLastTargetID(int ID);


    int LLiftedType();
    int LTargetX();
    int LTargetY();
    int LTargetZ();

    void setLTargetX(int x);
    void setLTargetY(int y);
    void setLTargetZ(int z);

    void setContPos(int x, int y);

    int LTargetKind();
    void setLTargetKind(int kind);

    bool TargCurs();
    void setTargCurs(bool tc);

    void setLObjectID(int ID);

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
    bool FindJournal(luabind::object obj);
    void SetJournalIndex(int index, const std::string& value);

    int ScanItems(bool visibleOnly);
    Item GetItem(int index);
    Property GetProperty(int id);
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
