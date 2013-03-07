#include "skillslist.h"
#include "ui_skillslist.h"

SkillsList::SkillsList(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::SkillsList)
{
    ui->setupUi(this);
    uo = new UO();

    QTimer* timer = new QTimer(this);
    timer->setInterval(1000);
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start();
}

SkillsList::~SkillsList()
{
    delete ui;
}

void SkillsList::update()
{
    ui->SkillsTable->clearContents();
    ui->SkillsTable->setRowCount(0);

    //Miscellaneous Skills
    insertItem("Alchemy","Alch");
    insertItem("Blacksmithy","Blac");
    insertItem("Bowcraft","Bowc");
    insertItem("Bushido","Bush");
    insertItem("Carpentry","Carp");
    insertItem("Chivalry","Chiv");
    insertItem("Cooking","Cook");
    insertItem("Fishing","Fish");
    insertItem("Focus","Focu");
    insertItem("Healing","Heal");
    insertItem("Herding","Herd");
    insertItem("Lockpicking","Lock");
    insertItem("Lumberjacking","Lumb");
    insertItem("Magery","Mage");
    insertItem("Meditation","Medi");
    insertItem("Mining","Mini");
    insertItem("Musicianship","Musi");
    insertItem("Necromancy","Necr");
    insertItem("Ninjitsu","Ninj");
    insertItem("RemoveTrap","Remo");
    insertItem("ResistingSpells","Resi");
    insertItem("Snooping","Snoo");
    insertItem("Stealing","Stea");
    insertItem("Stealth","Stlt");
    insertItem("Tailoring","Tail");
    insertItem("Tinkering","Tink");
    insertItem("Veterinary","Vete");

    //Combat Skills
    insertItem("Archery","Arch");
    insertItem("Fencing","Fenc");
    insertItem("MaceFighting","Mace");
    insertItem("Parrying","Parr");
    insertItem("Swordsmanship","Swor");
    insertItem("Tactics","Tact");
    insertItem("Wrestling","Wres");

    //Actions
    insertItem("AnimalTaming","Anim");
    insertItem("Begging","Begg");
    insertItem("Camping","Camp");
    insertItem("DetectingHidden","Dete");
    insertItem("Discordance","Disc");
    insertItem("Hiding","Hidi");
    insertItem("Inscription","Insc");
    insertItem("Peacemaking","Peac");
    insertItem("Poisoning","Pois");
    insertItem("Provocation","Prov");
    insertItem("SpiritSpeak","Spir");
    insertItem("Tracking","Trac");

    //Lore & Knowledge
    insertItem("Anatomy","Anat");
    insertItem("AnimalLore","Anil");
    insertItem("ArmsLore","Arms");
    insertItem("EvaluatingIntelligence","Eval");
    insertItem("ForensicEvaluation","Fore");
    insertItem("ItemIdentification","Item");
    insertItem("TasteIdentification","Tast");
}

void SkillsList::insertItem(const QString &_skill, const QString &_value)
{
    int row = ui->SkillsTable->rowCount();
    ui->SkillsTable->insertRow(row);
    ui->SkillsTable->setItem(row, 0,new QTableWidgetItem(_skill));
    ui->SkillsTable->setItem(row, 1,new QTableWidgetItem(QString::number((float)uo->GetSkill(_value.toStdString()).real/10)));
}
