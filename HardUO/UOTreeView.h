#ifndef UOTREEVIEW_H
#define UOTREEVIEW_H

#include <QTreeView>
#include <QStandardItemModel>

class UOTreeView
{
public:
    static UOTreeView& GetInstance(){return mInstance;}
    void SetView(QTreeView* view);
    void UpdateView();
    /// Character Info
    int CharPosX;
    int CharPosY;
    int CharPosZ;
    int CharDir;
    std::string CharStatus;
    int CharID;
    int CharType;
    int CharGhost;
    int BackpackID;
    /// Status Bar
    QString CharName;
    int Sex;
    int Str;
    int Dex;
    int Int;
    int Hits;
    int MaxHits;
    int Stamina;
    int MaxStam;
    int Mana;
    int MaxMana;
    int MaxStats;
    int Luck;
    int Weight;
    int MaxWeight;
    int MinDmg;
    int MaxDmg;
    int Gold;
    int Followers;
    int MaxFol;
    int Ar;
    int Fr;
    int Cr;
    int Pr;
    int Er;
    int Tp;

    /// Container Info
    int NextCPosX;
    int NextCPosY;
    int ContPosX;
    int ContPosY;
    int ContSizeX;
    int ContSizeY;
    int ContKind;
    QString ContName;
    int ContID;
    int ContType;

    /// Client Info
    int CliNr;
    int CliCnt;
    QString CliLang;
    QString CliVer;
    bool CliLogged;
    int CliLeft;
    int CliTop;
    int CliXRes;
    int CliYRes;
    QString CliTitle;

    /// Last Action
    int LObjectID;
    int LObjectType;
    int LTargetID;
    int LTargetKind;
    int LTargetTile;
    int LTargetX;
    int LTargetY;
    int LTargetZ;
    int LLiftedID;
    int LLiftedKind;
    int LLiftedType;
    int LSkill;
    int LSpell;

    /// Skills
    float Alchemy;
    float Blacksmithy;
    float Bowcraft;
    float Bushido;
    float Carpentry;
    float Chivalry;
    float Cooking;
    float Fishing;
    float Focus;
    float Healing;
    float Herding;
    float Lockpicking;
    float Lumberjacking;
    float Magery;
    float Meditation;
    float Mining;
    float Musicianship;
    float Necromancy;
    float Ninjitsu;
    float RemoveTrap;
    float ResistingSpells;
    float Snooping;
    float Stealing;
    float Stealth;
    float Tailoring;
    float Tinkering;
    float Veterinary;

        //Combat Skills
    float Archery;
    float Fencing;
    float MaceFighting;
    float Parrying;
    float Swordsmanship;
    float Tactics;
    float Wrestling;

        //Actions
    float AnimalTaming;
    float Begging;
    float Camping;
    float DetectingHidden;
    float Discordance;
    float Hiding;
    float Inscription;
    float Peacemaking;
    float Poisoning;
    float Provocation;
    float SpiritSpeak;
    float Tracking;


        //Lore & Knowledge
    float Anatomy;
    float AnimalLore;
    float ArmsLore;
    float EvaluatingIntelligence;
    float ForensicEvaluation;
    float ItemIdentification;
    float TasteIdentification;


private:
    UOTreeView();
    QTreeView* mTreeView;
    static UOTreeView mInstance;
    QStandardItemModel* mModel;
    QMap<QString, QStandardItem*> mViewMap;
};

#endif // UOTREEVIEW_H
