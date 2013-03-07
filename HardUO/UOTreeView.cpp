#include "UOTreeView.h"
#include <QStandardItemModel>
UOTreeView UOTreeView::mInstance;
UOTreeView::UOTreeView()
{
    mModel = new QStandardItemModel( 5, 1 );

    /** Character Info **/
    QStandardItem *item = new QStandardItem( QString("Character Info") );
    item->setEditable(false);

        mViewMap["CharPosX"] = new QStandardItem( QString("CharPosX: %0").arg(0) );
        mViewMap["CharPosX"]->setEditable( false );
        item->appendRow( mViewMap["CharPosX"] );

        mViewMap["CharPosY"] = new QStandardItem( QString("CharPosY: %0").arg(0) );
        mViewMap["CharPosY"]->setEditable( false );
        item->appendRow( mViewMap["CharPosY"] );

        mViewMap["CharPosZ"] = new QStandardItem( QString("CharPosZ: %0").arg(0) );
        mViewMap["CharPosZ"]->setEditable( false );
        item->appendRow( mViewMap["CharPosZ"] );

        mViewMap["CharDir"] = new QStandardItem( QString("CharDir: %0").arg(0) );
        mViewMap["CharDir"]->setEditable( false );
        item->appendRow( mViewMap["CharDir"] );

        mViewMap["CharStatus"] = new QStandardItem( QString("CharStatus: %0").arg(0) );
        mViewMap["CharStatus"]->setEditable( false );
        item->appendRow( mViewMap["CharStatus"] );

        mViewMap["CharID"] = new QStandardItem( QString("CharID: %0").arg(0) );
        mViewMap["CharID"]->setEditable( false );
        item->appendRow( mViewMap["CharID"] );

        mViewMap["CharGhost"] = new QStandardItem( QString("CharGhost: %0").arg(0) );
        mViewMap["CharGhost"]->setEditable( false );
        item->appendRow( mViewMap["CharGhost"] );

        mViewMap["BackpackID"] = new QStandardItem( QString("BackpackID: %0").arg(0) );
        mViewMap["BackpackID"]->setEditable( false );
        item->appendRow( mViewMap["BackpackID"] );
    mModel->setItem(0, 0, item);
    /** Status Bar **/
    item = new QStandardItem( QString("Status Bar") );
    item->setEditable(false);

        mViewMap["CharName"] = new QStandardItem( QString("CharName: %0").arg(0) );
        mViewMap["CharName"]->setEditable( false );
        item->appendRow( mViewMap["CharName"] );

        mViewMap["Sex"] = new QStandardItem( QString("Sex: %0").arg(0) );
        mViewMap["Sex"]->setEditable( false );
        item->appendRow( mViewMap["Sex"] );

        mViewMap["Str"] = new QStandardItem( QString("Str: %0").arg(0) );
        mViewMap["Str"]->setEditable( false );
        item->appendRow( mViewMap["Str"] );

        mViewMap["Dex"] = new QStandardItem( QString("Dex: %0").arg(0) );
        mViewMap["Dex"]->setEditable( false );
        item->appendRow( mViewMap["Dex"] );

        mViewMap["Int"] = new QStandardItem( QString("Int: %0").arg(0) );
        mViewMap["Int"]->setEditable( false );
        item->appendRow( mViewMap["Int"] );

        mViewMap["Hits"] = new QStandardItem( QString("Hits: %0").arg(0) );
        mViewMap["Hits"]->setEditable( false );
        item->appendRow( mViewMap["Hits"] );

        mViewMap["MaxHits"] = new QStandardItem( QString("MaxHits: %0").arg(0) );
        mViewMap["MaxHits"]->setEditable( false );
        item->appendRow( mViewMap["MaxHits"] );

        mViewMap["Stamina"] = new QStandardItem( QString("Stamina: %0").arg(0) );
        mViewMap["Stamina"]->setEditable( false );
        item->appendRow( mViewMap["Stamina"] );

        mViewMap["MaxStam"] = new QStandardItem( QString("MaxStam: %0").arg(0) );
        mViewMap["MaxStam"]->setEditable( false );
        item->appendRow( mViewMap["MaxStam"] );

        mViewMap["Mana"] = new QStandardItem( QString("Mana: %0").arg(0) );
        mViewMap["Mana"]->setEditable( false );
        item->appendRow( mViewMap["Mana"] );

        mViewMap["MaxMana"] = new QStandardItem( QString("MaxMana: %0").arg(0) );
        mViewMap["MaxMana"]->setEditable( false );
        item->appendRow( mViewMap["MaxMana"] );

        mViewMap["MaxStats"] = new QStandardItem( QString("MaxStats: %0").arg(0) );
        mViewMap["MaxStats"]->setEditable( false );
        item->appendRow( mViewMap["MaxStats"] );

        mViewMap["Luck"] = new QStandardItem( QString("Luck: %0").arg(0) );
        mViewMap["Luck"]->setEditable( false );
        item->appendRow( mViewMap["Luck"] );

        mViewMap["Weight"] = new QStandardItem( QString("Weight: %0").arg(0) );
        mViewMap["Weight"]->setEditable( false );
        item->appendRow( mViewMap["Weight"] );

        mViewMap["MaxWeight"] = new QStandardItem( QString("MaxWeight: %0").arg(0) );
        mViewMap["MaxWeight"]->setEditable( false );
        item->appendRow( mViewMap["MaxWeight"] );

        mViewMap["MinDmg"] = new QStandardItem( QString("MinDmg: %0").arg(0) );
        mViewMap["MinDmg"]->setEditable( false );
        item->appendRow( mViewMap["MinDmg"] );

        mViewMap["MaxDmg"] = new QStandardItem( QString("MaxDmg: %0").arg(0) );
        mViewMap["MaxDmg"]->setEditable( false );
        item->appendRow( mViewMap["MaxDmg"] );

        mViewMap["Gold"] = new QStandardItem( QString("Gold: %0").arg(0) );
        mViewMap["Gold"]->setEditable( false );
        item->appendRow( mViewMap["Gold"] );

        mViewMap["Followers"] = new QStandardItem( QString("Followers: %0").arg(0) );
        mViewMap["Followers"]->setEditable( false );
        item->appendRow( mViewMap["Followers"] );

        mViewMap["MaxFol"] = new QStandardItem( QString("MaxFol: %0").arg(0) );
        mViewMap["MaxFol"]->setEditable( false );
        item->appendRow( mViewMap["MaxFol"] );

        mViewMap["Ar"] = new QStandardItem( QString("Ar: %0").arg(0) );
        mViewMap["Ar"]->setEditable( false );
        item->appendRow( mViewMap["Ar"] );

        mViewMap["Fr"] = new QStandardItem( QString("Fr: %0").arg(0) );
        mViewMap["Fr"]->setEditable( false );
        item->appendRow( mViewMap["Fr"] );

        mViewMap["Cr"] = new QStandardItem( QString("Cr: %0").arg(0) );
        mViewMap["Cr"]->setEditable( false );
        item->appendRow( mViewMap["Cr"] );

        mViewMap["Pr"] = new QStandardItem( QString("Pr: %0").arg(0) );
        mViewMap["Pr"]->setEditable( false );
        item->appendRow( mViewMap["Pr"] );

        mViewMap["Er"] = new QStandardItem( QString("Er: %0").arg(0) );
        mViewMap["Er"]->setEditable( false );
        item->appendRow( mViewMap["Er"] );

        mViewMap["Tp"] = new QStandardItem( QString("Tp: %0").arg(0) );
        mViewMap["Tp"]->setEditable( false );
        item->appendRow( mViewMap["Tp"] );
    mModel->setItem(1, 0, item);
    /** Container Info **/
    item = new QStandardItem( QString("Container Info") );
    item->setEditable(false);

        mViewMap["NextCPosX"] = new QStandardItem( QString("NextCPosX: %0").arg(0) );
        mViewMap["NextCPosX"]->setEditable( false );
        item->appendRow( mViewMap["NextCPosX"] );

        mViewMap["NextCPosY"] = new QStandardItem( QString("NextCPosY: %0").arg(0) );
        mViewMap["NextCPosY"]->setEditable( false );
        item->appendRow( mViewMap["NextCPosY"] );

        mViewMap["ContPosX"] = new QStandardItem( QString("ContPosX: %0").arg(0) );
        mViewMap["ContPosX"]->setEditable( false );
        item->appendRow( mViewMap["ContPosX"] );

        mViewMap["ContPosY"] = new QStandardItem( QString("ContPosY: %0").arg(0) );
        mViewMap["ContPosY"]->setEditable( false );
        item->appendRow( mViewMap["ContPosY"] );

        mViewMap["ContSize"] = new QStandardItem( QString("ContSize: %0").arg(0) );
        mViewMap["ContSize"]->setEditable( false );
        item->appendRow( mViewMap["ContSize"] );

        mViewMap["ContKind"] = new QStandardItem( QString("ContKind: %0").arg(0) );
        mViewMap["ContKind"]->setEditable( false );
        item->appendRow( mViewMap["ContKind"] );

        mViewMap["ContName"] = new QStandardItem( QString("ContName: %0").arg(0) );
        mViewMap["ContName"]->setEditable( false );
        item->appendRow( mViewMap["ContName"] );

        mViewMap["ContID"] = new QStandardItem( QString("ContID: %0").arg(0) );
        mViewMap["ContID"]->setEditable( false );
        item->appendRow( mViewMap["ContID"] );

        mViewMap["ContType"] = new QStandardItem( QString("ContType: %0").arg(0) );
        mViewMap["ContType"]->setEditable( false );
        item->appendRow( mViewMap["ContType"] );
    mModel->setItem(2, 0, item);
    /** Client Info **/
    item = new QStandardItem( QString("Container Info") );
    item->setEditable(false);

    mViewMap["CliNr"] = new QStandardItem( QString("CliNr: %0").arg(0) );
    mViewMap["CliNr"]->setEditable( false );
    item->appendRow( mViewMap["CliNr"] );

    mViewMap["CliCnt"] = new QStandardItem( QString("CliCnt: %0").arg(0) );
    mViewMap["CliCnt"]->setEditable( false );
    item->appendRow( mViewMap["CliCnt"] );

    mViewMap["CliLang"] = new QStandardItem( QString("CliLang: %0").arg(0) );
    mViewMap["CliLang"]->setEditable( false );
    item->appendRow( mViewMap["CliLang"] );

    mViewMap["CliVer"] = new QStandardItem( QString("CliVer: %0").arg(0) );
    mViewMap["CliVer"]->setEditable( false );
    item->appendRow( mViewMap["CliVer"] );

    mViewMap["CliLogged"] = new QStandardItem( QString("CliLogged: %0").arg(0) );
    mViewMap["CliLogged"]->setEditable( false );
    item->appendRow( mViewMap["CliLogged"] );

    mViewMap["CliLeft"] = new QStandardItem( QString("CliLeft: %0").arg(0) );
    mViewMap["CliLeft"]->setEditable( false );
    item->appendRow( mViewMap["CliLeft"] );

    mViewMap["CliTop"] = new QStandardItem( QString("CliTop: %0").arg(0) );
    mViewMap["CliTop"]->setEditable( false );
    item->appendRow( mViewMap["CliTop"] );

    mViewMap["CliXRes"] = new QStandardItem( QString("CliXRes: %0").arg(0) );
    mViewMap["CliXRes"]->setEditable( false );
    item->appendRow( mViewMap["CliXRes"] );

    mViewMap["CliYRes"] = new QStandardItem( QString("CliYRes: %0").arg(0) );
    mViewMap["CliYRes"]->setEditable( false );
    item->appendRow( mViewMap["CliYRes"] );

    mViewMap["CliTitle"] = new QStandardItem( QString("CliTitle: %0").arg(0) );
    mViewMap["CliTitle"]->setEditable( false );
    item->appendRow( mViewMap["CliTitle"] );

    mModel->setItem(3, 0, item);

    /** Last Target **/
    item = new QStandardItem( QString("Last Target") );
    item->setEditable(false);

    mViewMap["LLiftedType"] = new QStandardItem( QString("LLiftedType: %0").arg(0) );
    mViewMap["LLiftedType"]->setEditable( false );
    item->appendRow( mViewMap["LLiftedType"] );

    mModel->setItem(4, 0, item);


    /** Skills **/
    item = new QStandardItem( QString("Skills") );
    item->setEditable(false);

        mViewMap["Alchemy"] = new QStandardItem( QString("Alchemy: %0").arg(0) );
        mViewMap["Alchemy"]->setEditable( false );
        item->appendRow( mViewMap["Alchemy"] );
        mViewMap["Blacksmithy"] = new QStandardItem( QString("Blacksmithy: %0").arg(0) );
        mViewMap["Blacksmithy"]->setEditable( false );
        item->appendRow( mViewMap["Blacksmithy"] );
        mViewMap["Bowcraft"] = new QStandardItem( QString("Bowcraft: %0").arg(0) );
        mViewMap["Bowcraft"]->setEditable( false );
        item->appendRow( mViewMap["Bowcraft"] );
        mViewMap["Bushido"] = new QStandardItem( QString("Bushido: %0").arg(0) );
        mViewMap["Bushido"]->setEditable( false );
        item->appendRow( mViewMap["Bushido"] );
        mViewMap["Carpentry"] = new QStandardItem( QString("Carpentry: %0").arg(0) );
        mViewMap["Carpentry"]->setEditable( false );
        item->appendRow( mViewMap["Carpentry"] );
        mViewMap["Chivalry"] = new QStandardItem( QString("Chivalry: %0").arg(0) );
        mViewMap["Chivalry"]->setEditable( false );
        item->appendRow( mViewMap["Chivalry"] );
        mViewMap["Cooking"] = new QStandardItem( QString("Cooking: %0").arg(0) );
        mViewMap["Cooking"]->setEditable( false );
        item->appendRow( mViewMap["Cooking"] );
        mViewMap["Fishing"] = new QStandardItem( QString("Fishing: %0").arg(0) );
        mViewMap["Fishing"]->setEditable( false );
        item->appendRow( mViewMap["Fishing"] );
        mViewMap["Focus"] = new QStandardItem( QString("Focus: %0").arg(0) );
        mViewMap["Focus"]->setEditable( false );
        item->appendRow( mViewMap["Focus"] );
        mViewMap["Healing"] = new QStandardItem( QString("Healing: %0").arg(0) );
        mViewMap["Healing"]->setEditable( false );
        item->appendRow( mViewMap["Healing"] );
        mViewMap["Herding"] = new QStandardItem( QString("Herding: %0").arg(0) );
        mViewMap["Herding"]->setEditable( false );
        item->appendRow( mViewMap["Herding"] );
        mViewMap["Lockpicking"] = new QStandardItem( QString("Lockpicking: %0").arg(0) );
        mViewMap["Lockpicking"]->setEditable( false );
        item->appendRow( mViewMap["Lockpicking"] );
        mViewMap["Lumberjacking"] = new QStandardItem( QString("Lumberjacking: %0").arg(0) );
        mViewMap["Lumberjacking"]->setEditable( false );
        item->appendRow( mViewMap["Lumberjacking"] );
        mViewMap["Magery"] = new QStandardItem( QString("Magery: %0").arg(0) );
        mViewMap["Magery"]->setEditable( false );
        item->appendRow( mViewMap["Magery"] );
        mViewMap["Meditation"] = new QStandardItem( QString("Meditation: %0").arg(0) );
        mViewMap["Meditation"]->setEditable( false );
        item->appendRow( mViewMap["Meditation"] );
        mViewMap["Mining"] = new QStandardItem( QString("Mining: %0").arg(0) );
        mViewMap["Mining"]->setEditable( false );
        item->appendRow( mViewMap["Mining"] );
        mViewMap["Musicianship"] = new QStandardItem( QString("Musicianship: %0").arg(0) );
        mViewMap["Musicianship"]->setEditable( false );
        item->appendRow( mViewMap["Musicianship"] );
        mViewMap["Necromancy"] = new QStandardItem( QString("Necromancy: %0").arg(0) );
        mViewMap["Necromancy"]->setEditable( false );
        item->appendRow( mViewMap["Necromancy"] );
        mViewMap["Ninjitsu"] = new QStandardItem( QString("Ninjitsu: %0").arg(0) );
        mViewMap["Ninjitsu"]->setEditable( false );
        item->appendRow( mViewMap["Ninjitsu"] );
        mViewMap["RemoveTrap"] = new QStandardItem( QString("RemoveTrap: %0").arg(0) );
        mViewMap["RemoveTrap"]->setEditable( false );
        item->appendRow( mViewMap["RemoveTrap"] );
        mViewMap["ResistingSpells"] = new QStandardItem( QString("ResistingSpells: %0").arg(0) );
        mViewMap["ResistingSpells"]->setEditable( false );
        item->appendRow( mViewMap["ResistingSpells"] );
        mViewMap["Snooping"] = new QStandardItem( QString("Snooping: %0").arg(0) );
        mViewMap["Snooping"]->setEditable( false );
        item->appendRow( mViewMap["Snooping"] );
        mViewMap["Stealing"] = new QStandardItem( QString("Stealing: %0").arg(0) );
        mViewMap["Stealing"]->setEditable( false );
        item->appendRow( mViewMap["Stealing"] );
        mViewMap["Stealth"] = new QStandardItem( QString("Stealth: %0").arg(0) );
        mViewMap["Stealth"]->setEditable( false );
        item->appendRow( mViewMap["Stealth"] );
        mViewMap["Tailoring"] = new QStandardItem( QString("Tailoring: %0").arg(0) );
        mViewMap["Tailoring"]->setEditable( false );
        item->appendRow( mViewMap["Tailoring"] );
        mViewMap["Tinkering"] = new QStandardItem( QString("Tinkering: %0").arg(0) );
        mViewMap["Tinkering"]->setEditable( false );
        item->appendRow( mViewMap["Tinkering"] );
        mViewMap["Veterinary"] = new QStandardItem( QString("Veterinary: %0").arg(0) );
        mViewMap["Veterinary"]->setEditable( false );
        item->appendRow( mViewMap["Veterinary"] );
        mViewMap["Archery"] = new QStandardItem( QString("Archery: %0").arg(0) );
        mViewMap["Archery"]->setEditable( false );
        item->appendRow( mViewMap["Archery"] );
        mViewMap["Fencing"] = new QStandardItem( QString("Fencing: %0").arg(0) );
        mViewMap["Fencing"]->setEditable( false );
        item->appendRow( mViewMap["Fencing"] );
        mViewMap["MaceFighting"] = new QStandardItem( QString("MaceFighting: %0").arg(0) );
        mViewMap["MaceFighting"]->setEditable( false );
        item->appendRow( mViewMap["MaceFighting"] );
        mViewMap["Parrying"] = new QStandardItem( QString("Parrying: %0").arg(0) );
        mViewMap["Parrying"]->setEditable( false );
        item->appendRow( mViewMap["Parrying"] );
        mViewMap["Swordsmanship"] = new QStandardItem( QString("Swordsmanship: %0").arg(0) );
        mViewMap["Swordsmanship"]->setEditable( false );
        item->appendRow( mViewMap["Swordsmanship"] );
        mViewMap["Tactics"] = new QStandardItem( QString("Tactics: %0").arg(0) );
        mViewMap["Tactics"]->setEditable( false );
        item->appendRow( mViewMap["Tactics"] );
        mViewMap["Wrestling"] = new QStandardItem( QString("Wrestling: %0").arg(0) );
        mViewMap["Wrestling"]->setEditable( false );
        item->appendRow( mViewMap["Wrestling"] );
        mViewMap["AnimalTaming"] = new QStandardItem( QString("AnimalTaming: %0").arg(0) );
        mViewMap["AnimalTaming"]->setEditable( false );
        item->appendRow( mViewMap["AnimalTaming"] );
        mViewMap["Begging"] = new QStandardItem( QString("Begging: %0").arg(0) );
        mViewMap["Begging"]->setEditable( false );
        item->appendRow( mViewMap["Begging"] );
        mViewMap["Camping"] = new QStandardItem( QString("Camping: %0").arg(0) );
        mViewMap["Camping"]->setEditable( false );
        item->appendRow( mViewMap["Camping"] );
        mViewMap["DetectingHidden"] = new QStandardItem( QString("DetectingHidden: %0").arg(0) );
        mViewMap["DetectingHidden"]->setEditable( false );
        item->appendRow( mViewMap["DetectingHidden"] );
        mViewMap["Discordance"] = new QStandardItem( QString("Discordance: %0").arg(0) );
        mViewMap["Discordance"]->setEditable( false );
        item->appendRow( mViewMap["Discordance"] );
        mViewMap["Hiding"] = new QStandardItem( QString("Hiding: %0").arg(0) );
        mViewMap["Hiding"]->setEditable( false );
        item->appendRow( mViewMap["Hiding"] );
        mViewMap["Inscription"] = new QStandardItem( QString("Inscription: %0").arg(0) );
        mViewMap["Inscription"]->setEditable( false );
        item->appendRow( mViewMap["Inscription"] );
        mViewMap["Peacemaking"] = new QStandardItem( QString("Peacemaking: %0").arg(0) );
        mViewMap["Peacemaking"]->setEditable( false );
        item->appendRow( mViewMap["Peacemaking"] );
        mViewMap["Poisoning"] = new QStandardItem( QString("Poisoning: %0").arg(0) );
        mViewMap["Poisoning"]->setEditable( false );
        item->appendRow( mViewMap["Poisoning"] );
        mViewMap["Provocation"] = new QStandardItem( QString("Provocation: %0").arg(0) );
        mViewMap["Provocation"]->setEditable( false );
        item->appendRow( mViewMap["Provocation"] );
        mViewMap["SpiritSpeak"] = new QStandardItem( QString("SpiritSpeak: %0").arg(0) );
        mViewMap["SpiritSpeak"]->setEditable( false );
        item->appendRow( mViewMap["SpiritSpeak"] );
        mViewMap["Tracking"] = new QStandardItem( QString("Tracking: %0").arg(0) );
        mViewMap["Tracking"]->setEditable( false );
        item->appendRow( mViewMap["Tracking"] );
        mViewMap["Anatomy"] = new QStandardItem( QString("Anatomy: %0").arg(0) );
        mViewMap["Anatomy"]->setEditable( false );
        item->appendRow( mViewMap["Anatomy"] );
        mViewMap["AnimalLore"] = new QStandardItem( QString("AnimalLore: %0").arg(0) );
        mViewMap["AnimalLore"]->setEditable( false );
        item->appendRow( mViewMap["AnimalLore"] );
        mViewMap["ArmsLore"] = new QStandardItem( QString("ArmsLore: %0").arg(0) );
        mViewMap["ArmsLore"]->setEditable( false );
        item->appendRow( mViewMap["ArmsLore"] );
        mViewMap["EvaluatingIntelligence"] = new QStandardItem( QString("EvaluatingIntelligence: %0").arg(0) );
        mViewMap["EvaluatingIntelligence"]->setEditable( false );
        item->appendRow( mViewMap["EvaluatingIntelligence"] );
        mViewMap["ForensicEvaluation"] = new QStandardItem( QString("ForensicEvaluation: %0").arg(0) );
        mViewMap["ForensicEvaluation"]->setEditable( false );
        item->appendRow( mViewMap["ForensicEvaluation"] );
        mViewMap["ItemIdentification"] = new QStandardItem( QString("ItemIdentification: %0").arg(0) );
        mViewMap["ItemIdentification"]->setEditable( false );
        item->appendRow( mViewMap["ItemIdentification"] );
        mViewMap["TasteIdentification"] = new QStandardItem( QString("TasteIdentification: %0").arg(0) );
        mViewMap["TasteIdentification"]->setEditable( false );
        item->appendRow( mViewMap["TasteIdentification"] );


    mModel->setItem(5, 0, item);

    //mModel->setItem(1, 0, item);
}
void UOTreeView::UpdateView()
{
    mViewMap["CharPosX"]->setText(QString("CharPosX: %0").arg(CharPosX));
    mViewMap["CharPosY"]->setText(QString("CharPosY: %0").arg(CharPosY));
    mViewMap["CharPosZ"]->setText(QString("CharPosZ: %0").arg(CharPosZ));
    mViewMap["CharDir"]->setText(QString("CharDir: %0").arg(CharDir));
    mViewMap["CharStatus"]->setText(QString("CharStatus: %0").arg(CharStatus));
    mViewMap["CharGhost"]->setText(QString("CharGhost: %0").arg(CharGhost));
    mViewMap["BackpackID"]->setText(QString("BackpackID: %0").arg(BackpackID));

    mViewMap["CharName"]->setText(QString("CharName: %0").arg(CharName));
    mViewMap["Sex"]->setText(QString("Sex: %0").arg(Sex?"Mulher":"Isso que é Macho!"));
    mViewMap["Str"]->setText(QString("Str: %0").arg(Str));
    mViewMap["Dex"]->setText(QString("Dex: %0").arg(Dex));
    mViewMap["Int"]->setText(QString("Int: %0").arg(Int));
    mViewMap["Hits"]->setText(QString("Hits: %0").arg(Hits));
    mViewMap["MaxHits"]->setText(QString("MaxHits: %0").arg(MaxHits));
    mViewMap["Stamina"]->setText(QString("Stamina: %0").arg(Stamina));
    mViewMap["MaxStam"]->setText(QString("MaxStam: %0").arg(MaxStam));
    mViewMap["Mana"]->setText(QString("Mana: %0").arg(Mana));
    mViewMap["MaxMana"]->setText(QString("MaxMana: %0").arg(MaxMana));
    mViewMap["MaxStats"]->setText(QString("MaxStats: %0").arg(MaxStats));
    mViewMap["Luck"]->setText(QString("Luck: %0").arg(Luck));
    mViewMap["Weight"]->setText(QString("Weight: %0").arg(Weight));
    mViewMap["MaxWeight"]->setText(QString("MaxWeight: %0").arg(MaxWeight));
    mViewMap["MinDmg"]->setText(QString("MinDmg: %0").arg(MinDmg));
    mViewMap["MaxDmg"]->setText(QString("MaxDmg: %0").arg(MaxDmg));
    mViewMap["Gold"]->setText(QString("Gold: %0").arg(Gold));
    mViewMap["Followers"]->setText(QString("Followers: %0").arg(Followers));
    mViewMap["MaxFol"]->setText(QString("MaxFol: %0").arg(MaxFol));
    mViewMap["Ar"]->setText(QString("Ar: %0").arg(Ar));
    mViewMap["Fr"]->setText(QString("Fr: %0").arg(Fr));
    mViewMap["Cr"]->setText(QString("Cr: %0").arg(Cr));
    mViewMap["Pr"]->setText(QString("Pr: %0").arg(Pr));
    mViewMap["Er"]->setText(QString("Er: %0").arg(Er));
    mViewMap["Tp"]->setText(QString("Tp: %0").arg(Tp));

    mViewMap["CliNr"]->setText(QString("CliNr: %0").arg(CliNr));
    mViewMap["CliCnt"]->setText(QString("CliCnt: %0").arg(CliCnt));
    mViewMap["CliLang"]->setText(QString("CliLang: %0").arg(CliLang));
    mViewMap["CliVer"]->setText(QString("CliVer: %0").arg(CliVer));
    mViewMap["CliLogged"]->setText(QString("CliLogged: %0").arg(CliLogged));
    mViewMap["CliLeft"]->setText(QString("CliLeft: %0").arg(CliLeft));
    mViewMap["CliTop"]->setText(QString("CliTop: %0").arg(CliTop));
    mViewMap["CliXRes"]->setText(QString("CliXRes: %0").arg(CliXRes));
    mViewMap["CliYRes"]->setText(QString("CliYRes: %0").arg(CliYRes));
    mViewMap["CliTitle"]->setText(QString("CliTitle: %0").arg(CliTitle));

    mViewMap["LLiftedType"]->setText(QString("LLiftedType: %0").arg(LLiftedType));


    mViewMap["Alchemy"]->setText(QString("Alchemy: %0").arg(Alchemy/10));
    mViewMap["Blacksmithy"]->setText(QString("Blacksmithy: %0").arg(Blacksmithy/10));
    mViewMap["Bowcraft"]->setText(QString("Bowcraft:%0").arg(Bowcraft/10));
    mViewMap["Bushido"]->setText(QString("Bushido:%0").arg(Bushido/10));
    mViewMap["Carpentry"]->setText(QString("Carpentry:%0").arg(Carpentry/10));
    mViewMap["Chivalry"]->setText(QString("Chivalry:%0").arg(Chivalry/10));
    mViewMap["Cooking"]->setText(QString("Cooking:%0").arg(Cooking/10));
    mViewMap["Fishing"]->setText(QString("Fishing:%0").arg(Fishing/10));
    mViewMap["Focus"]->setText(QString("Focus:%0").arg(Focus/10));
    mViewMap["Healing"]->setText(QString("Healing:%0").arg(Healing/10));
    mViewMap["Herding"]->setText(QString("Herding:%0").arg(Herding/10));
    mViewMap["Lockpicking"]->setText(QString("Lockpicking:%0").arg(Lockpicking/10));
    mViewMap["Lumberjacking"]->setText(QString("Lumberjacking:%0").arg(Lumberjacking/10));
    mViewMap["Magery"]->setText(QString("Magery:%0").arg(Magery/10));
    mViewMap["Meditation"]->setText(QString("Meditation:%0").arg(Meditation/10));
    mViewMap["Mining"]->setText(QString("Mining:%0").arg(Mining/10));
    mViewMap["Musicianship"]->setText(QString("Musicianship:%0").arg(Musicianship/10));
    mViewMap["Necromancy"]->setText(QString("Necromancy:%0").arg(Necromancy/10));
    mViewMap["Ninjitsu"]->setText(QString("Ninjitsu:%0").arg(Ninjitsu/10));
    mViewMap["RemoveTrap"]->setText(QString("RemoveTrap:%0").arg(RemoveTrap/10));
    mViewMap["ResistingSpells"]->setText(QString("ResistingSpells:%0").arg(ResistingSpells/10));
    mViewMap["Snooping"]->setText(QString("Snooping:%0").arg(Snooping/10));
    mViewMap["Stealing"]->setText(QString("Stealing:%0").arg(Stealing/10));
    mViewMap["Stealth"]->setText(QString("Stealth:%0").arg(Stealth/10));
    mViewMap["Tailoring"]->setText(QString("Tailoring:%0").arg(Tailoring/10));
    mViewMap["Tinkering"]->setText(QString("Tinkering:%0").arg(Tinkering/10));
    mViewMap["Veterinary"]->setText(QString("Veterinary:%0").arg(Veterinary/10));
    mViewMap["Archery"]->setText(QString("Archery:%0").arg(Archery/10));
    mViewMap["Fencing"]->setText(QString("Fencing:%0").arg(Fencing/10));
    mViewMap["MaceFighting"]->setText(QString("MaceFighting:%0").arg(MaceFighting/10));
    mViewMap["Parrying"]->setText(QString("Parrying:%0").arg(Parrying/10));
    mViewMap["Swordsmanship"]->setText(QString("Swordsmanship:%0").arg(Swordsmanship/10));
    mViewMap["Tactics"]->setText(QString("Tactics:%0").arg(Tactics/10));
    mViewMap["Wrestling"]->setText(QString("Wrestling:%0").arg(Wrestling/10));
    mViewMap["AnimalTaming"]->setText(QString("AnimalTaming:%0").arg(AnimalTaming/10));
    mViewMap["Begging"]->setText(QString("Begging:%0").arg(Begging/10));
    mViewMap["Camping"]->setText(QString("Camping:%0").arg(Camping/10));
    mViewMap["DetectingHidden"]->setText(QString("DetectingHidden:%0").arg(DetectingHidden/10));
    mViewMap["Discordance"]->setText(QString("Discordance:%0").arg(Discordance/10));
    mViewMap["Hiding"]->setText(QString("Hiding:%0").arg(Hiding/10));
    mViewMap["Inscription"]->setText(QString("Inscription:%0").arg(Inscription/10));
    mViewMap["Peacemaking"]->setText(QString("Peacemaking:%0").arg(Peacemaking/10));
    mViewMap["Poisoning"]->setText(QString("Poisoning:%0").arg(Poisoning/10));
    mViewMap["Provocation"]->setText(QString("Provocation:%0").arg(Provocation/10));
    mViewMap["SpiritSpeak"]->setText(QString("SpiritSpeak:%0").arg(SpiritSpeak/10));
    mViewMap["Tracking"]->setText(QString("Tracking:%0").arg(Tracking/10));
    mViewMap["Anatomy"]->setText(QString("Anatomy:%0").arg(Anatomy/10));
    mViewMap["AnimalLore"]->setText(QString("AnimalLore:%0").arg(AnimalLore/10));
    mViewMap["ArmsLore"]->setText(QString("ArmsLore:%0").arg(ArmsLore/10));
    mViewMap["EvaluatingIntelligence"]->setText(QString("EvaluatingIntelligence:%0").arg(EvaluatingIntelligence/10));
    mViewMap["ForensicEvaluation"]->setText(QString("ForensicEvaluation:%0").arg(ForensicEvaluation/10));
    mViewMap["ItemIdentification"]->setText(QString("ItemIdentification:%0").arg(ItemIdentification/10));
    mViewMap["TasteIdentification"]->setText(QString("TasteIdentification:%0").arg(TasteIdentification/10));


}

void UOTreeView::SetView(QTreeView* view)
{
    if(view==NULL)return;
    mTreeView = view;
    mTreeView->setModel(mModel);
    mTreeView->expandAll();
}

