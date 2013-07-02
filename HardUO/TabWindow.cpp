#include "TabWindow.h"
#include <QDebug>
#include "UOTreeView.h"
#include <QFileDialog>

UO* TabWindow::UOUpadeView = new UO();

TabWindow::TabWindow(QWidget *parent)
    :QWidget(parent)
    ,mStatus(0)
    ,mFileName("NONE")
{
    mUO = new UO();
    mRunner = NULL;
    mLayout = new QVBoxLayout();
    setLayout(mLayout);
    completingTextEdit = new CodeArea(this);
    mLayout->addWidget(completingTextEdit);

    logText = new QTextEdit();
    mLayout->addWidget(logText);
    logText->setMaximumSize(16777215,150);
    logText->setReadOnly(true);
}
TabWindow::~TabWindow()
{
    if(mRunner)
        mRunner->terminate();
    delete mRunner;
    delete logText;
    delete completingTextEdit;
    delete mLayout;
}

TabWindow::TabWindow(QString &script)
    :QWidget(NULL)
    ,mStatus(0)
{
    mUO = new UO();
    mRunner = NULL;
    mLayout = new QVBoxLayout();
    setLayout(mLayout);
    completingTextEdit = new CodeArea();
    mLayout->addWidget(completingTextEdit);

    logText = new QTextEdit();
    mLayout->addWidget(logText);
    logText->setMaximumSize(16777215,150);
    logText->setReadOnly(false);
    script.replace("\t","    ");
    completingTextEdit->document()->setPlainText(script);
}
void TabWindow::SetCompleter(QCompleter *completer)
{
    if(completingTextEdit)
        completingTextEdit->setCompleter(completer);
}

void TabWindow::SetFileName(const QString &name)
{
    mFileName = name;
}

QString TabWindow::GetFileName()
{
    return mFileName;
}

void TabWindow::Save()
{
    if(mFileName == "NONE")
    {
        mFileName = QFileDialog::getSaveFileName(this,"Save file","","*.lua");
        if(mFileName.isEmpty())
            return;
    }
    QFile f( mFileName );
    f.open( QIODevice::WriteOnly );
    f.write(completingTextEdit->document()->toPlainText().toStdString().data(),completingTextEdit->document()->toPlainText().size());
    completingTextEdit->document()->setModified(false);
    f.close();
}

void TabWindow::Start()
{
    if(!mRunner)
    {
        mRunner =  new ScriptRunner(completingTextEdit->document());

        mRunner->SetUO(mUO);
        connect(mRunner,SIGNAL(Log(QString)),this,SLOT(OnLog(QString)));
        connect(mRunner,SIGNAL(Pause(int)),this,SLOT(OnPause(int)));
        connect(mRunner, SIGNAL(Started()),this,SLOT(OnStart()));
        connect(mRunner, SIGNAL(Stopped()),this,SLOT(OnStop()));
    }
    if(!mRunner->isRunning())
    {
        mRunner->start();
        mStatus = 1; //Start
    }
    else
    {
        if(mRunner->IsPaused())
        {

            mRunner->Pause(false);
            mStatus = 1; //Start
        }
    }
}
void TabWindow::Stop()
{
    if(mRunner)
        if(mRunner->isRunning())
        {
            mRunner->terminate();
            delete mRunner;
            mRunner = NULL;
            OnPause(0);
            mStatus = 0; //Stop
        }
    mStatus = 0;
}

void TabWindow::Pause()
{
    //qDebug()<<"status=="<<mStatus;
    if(mRunner)
    {
        //qDebug()<<"mrunner e status==2";
        mRunner->Pause(!mRunner->IsPaused());
        mStatus = (mStatus == 1 || mRunner->InStep())?2:1; //Pause:Start
    }
}
void TabWindow::OnLog(const QString& log)
{
    logText->append(log);
    QTextCursor c = logText->textCursor();
    c.movePosition(QTextCursor::End);
    logText->setTextCursor(c);
}
void TabWindow::OnPause(int line)
{
    completingTextEdit->SetPause(line);
}

void TabWindow::OnStart()
{
    mStatus = 1;
}

void TabWindow::OnStop()
{
    Stop();
}

void TabWindow::UpdateView()
{
    ScopedLock mutex(&mMutex);
    UOUpadeView->SetCliNr(mUO->GetCliNr());
    /// Alguns dados n tem ainda

    /// Character Info
    UOTreeView::GetInstance().CharPosX = UOUpadeView->CharPosX();
    UOTreeView::GetInstance().CharPosY = UOUpadeView->CharPosY();
    UOTreeView::GetInstance().CharPosZ = UOUpadeView->CharPosZ();
    UOTreeView::GetInstance().CharDir = UOUpadeView->CharDir();
    UOTreeView::GetInstance().CharStatus = UOUpadeView->CharStatus();
    UOTreeView::GetInstance().CharID = UOUpadeView->CharID();
    UOTreeView::GetInstance().CharType = UOUpadeView->CharType();
    //UOTreeView::GetInstance().CharGhost =
    UOTreeView::GetInstance().BackpackID = UOUpadeView->BackpackID();
    /// Status Bar
    mCharName = UOUpadeView->CharName().data();
    UOTreeView::GetInstance().CharName = mCharName;
    UOTreeView::GetInstance().Sex = UOUpadeView->Sex();
    UOTreeView::GetInstance().Str = UOUpadeView->Str();
    UOTreeView::GetInstance().Dex = UOUpadeView->Dex();
    UOTreeView::GetInstance().Int = UOUpadeView->Int();
    UOTreeView::GetInstance().Hits = UOUpadeView->Hits();
    UOTreeView::GetInstance().MaxHits = UOUpadeView->MaxHits();
    UOTreeView::GetInstance().Stamina = UOUpadeView->Stamina();
    UOTreeView::GetInstance().MaxStam = UOUpadeView->MaxStam();

    UOTreeView::GetInstance().Mana = UOUpadeView->Mana();
    UOTreeView::GetInstance().MaxMana = UOUpadeView->MaxMana();
    UOTreeView::GetInstance().MaxStats = UOUpadeView->MaxStats();
    UOTreeView::GetInstance().Luck = UOUpadeView->Luck();
    UOTreeView::GetInstance().Weight = UOUpadeView->Weight();
    UOTreeView::GetInstance().MaxWeight = UOUpadeView->MaxWeight();
    UOTreeView::GetInstance().MinDmg = UOUpadeView->MinDmg();
    UOTreeView::GetInstance().MaxDmg = UOUpadeView->MaxDmg();
    UOTreeView::GetInstance().Gold = UOUpadeView->Gold();
    UOTreeView::GetInstance().Followers = UOUpadeView->Followers();
    UOTreeView::GetInstance().MaxFol = UOUpadeView->MaxFol();
    UOTreeView::GetInstance().Ar = UOUpadeView->Ar();
    UOTreeView::GetInstance().Fr = UOUpadeView->Fr();
    UOTreeView::GetInstance().Cr = UOUpadeView->Cr();
    UOTreeView::GetInstance().Pr = UOUpadeView->Pr();
    UOTreeView::GetInstance().Er = UOUpadeView->Er();
    UOTreeView::GetInstance().Tp = UOUpadeView->Tp();

    /// Container Info
    UOTreeView::GetInstance().NextCPosX = UOUpadeView->NextCPosX();
    UOTreeView::GetInstance().NextCPosY = UOUpadeView->NextCPosY();
    UOTreeView::GetInstance().ContPosX = UOUpadeView->ContPosX();
    UOTreeView::GetInstance().ContPosY = UOUpadeView->ContPosY();
    UOTreeView::GetInstance().ContSizeX = UOUpadeView->ContSizeX();
    UOTreeView::GetInstance().ContSizeY = UOUpadeView->ContSizeY();
    UOTreeView::GetInstance().ContKind = UOUpadeView->ContKind();
    UOTreeView::GetInstance().ContName = UOUpadeView->ContName().data();
    UOTreeView::GetInstance().ContID = UOUpadeView->ContID();
    UOTreeView::GetInstance().ContType = UOUpadeView->ContType();

    /// Client Info
    mCliNr = UOUpadeView->CliNr();
    UOTreeView::GetInstance().CliNr = mCliNr;
    UOTreeView::GetInstance().CliCnt = UOUpadeView->CliCnt();
    UOTreeView::GetInstance().CliLang = UOUpadeView->CliLang().data();
    UOTreeView::GetInstance().CliVer = UOUpadeView->CliVer().data();
    UOTreeView::GetInstance().CliLogged = UOUpadeView->CliLogged();
    UOTreeView::GetInstance().CliLeft = UOUpadeView->CliLeft();
    UOTreeView::GetInstance().CliTop = UOUpadeView->CliTop();
    UOTreeView::GetInstance().CliXRes = UOUpadeView->CliXRes();
    UOTreeView::GetInstance().CliYRes = UOUpadeView->CliYRes();
    UOTreeView::GetInstance().CliTitle = UOUpadeView->CliTitle().data();

    /// Last Action
    UOTreeView::GetInstance().LObjectID = UOUpadeView->LObjectID();
    UOTreeView::GetInstance().LObjectType = UOUpadeView->LObjectType();
    UOTreeView::GetInstance().LTargetID = UOUpadeView->getLastTargetID();
    UOTreeView::GetInstance().LTargetKind = UOUpadeView->LTargetKind();
    UOTreeView::GetInstance().LTargetTile = UOUpadeView->LTargetTile();
    UOTreeView::GetInstance().LTargetX = UOUpadeView->LTargetX();
    UOTreeView::GetInstance().LTargetY = UOUpadeView->LTargetY();
    UOTreeView::GetInstance().LTargetZ = UOUpadeView->LTargetZ();
    UOTreeView::GetInstance().LLiftedID = UOUpadeView->LLiftedID();
    UOTreeView::GetInstance().LLiftedKind = UOUpadeView->LLiftedKind();
    UOTreeView::GetInstance().LLiftedType = UOUpadeView->LLiftedType();
    UOTreeView::GetInstance().LSkill = UOUpadeView->LSkill();
    UOTreeView::GetInstance().LSpell = UOUpadeView->LSpell();



    //Miscellaneous Skills
    UOTreeView::GetInstance().Alchemy = UOUpadeView->GetSkill("Alch");
    UOTreeView::GetInstance().Blacksmithy = UOUpadeView->GetSkill("Blac");
    UOTreeView::GetInstance().Bowcraft = UOUpadeView->GetSkill("Bowc");
    UOTreeView::GetInstance().Bushido = UOUpadeView->GetSkill("Bush");
    UOTreeView::GetInstance().Carpentry = UOUpadeView->GetSkill("Carp");
    UOTreeView::GetInstance().Chivalry = UOUpadeView->GetSkill("Chiv");
    UOTreeView::GetInstance().Cooking = UOUpadeView->GetSkill("Cook");
    UOTreeView::GetInstance().Fishing = UOUpadeView->GetSkill("Fish");
    UOTreeView::GetInstance().Focus = UOUpadeView->GetSkill("Focu");
    UOTreeView::GetInstance().Healing = UOUpadeView->GetSkill("Heal");
    UOTreeView::GetInstance().Herding = UOUpadeView->GetSkill("Herd");
    UOTreeView::GetInstance().Lockpicking = UOUpadeView->GetSkill("Lock");
    UOTreeView::GetInstance().Lumberjacking = UOUpadeView->GetSkill("Lumb");
    UOTreeView::GetInstance().Magery = UOUpadeView->GetSkill("Mage");
    UOTreeView::GetInstance().Meditation = UOUpadeView->GetSkill("Medi");
    UOTreeView::GetInstance().Mining = UOUpadeView->GetSkill("Mini");
    UOTreeView::GetInstance().Musicianship = UOUpadeView->GetSkill("Musi");
    UOTreeView::GetInstance().Necromancy = UOUpadeView->GetSkill("Necr");
    UOTreeView::GetInstance().Ninjitsu = UOUpadeView->GetSkill("Ninj");
    UOTreeView::GetInstance().RemoveTrap = UOUpadeView->GetSkill("Remo");
    UOTreeView::GetInstance().ResistingSpells = UOUpadeView->GetSkill("Resi");
    UOTreeView::GetInstance().Snooping = UOUpadeView->GetSkill("Snoo");
    UOTreeView::GetInstance().Stealing = UOUpadeView->GetSkill("Stea");
    UOTreeView::GetInstance().Stealth = UOUpadeView->GetSkill("Stlt");
    UOTreeView::GetInstance().Tailoring = UOUpadeView->GetSkill("Tail");
    UOTreeView::GetInstance().Tinkering = UOUpadeView->GetSkill("Tink");
    UOTreeView::GetInstance().Veterinary = UOUpadeView->GetSkill("Vete");



    //Combat Skills
    UOTreeView::GetInstance().Archery = UOUpadeView->GetSkill("Arch");
    UOTreeView::GetInstance().Fencing = UOUpadeView->GetSkill("Fenc");
    UOTreeView::GetInstance().MaceFighting = UOUpadeView->GetSkill("Mace");
    UOTreeView::GetInstance().Parrying = UOUpadeView->GetSkill("Parr");
    UOTreeView::GetInstance().Swordsmanship = UOUpadeView->GetSkill("Swor");
    UOTreeView::GetInstance().Tactics = UOUpadeView->GetSkill("Tact");
    UOTreeView::GetInstance().Wrestling = UOUpadeView->GetSkill("Wres");

    //Actions
    UOTreeView::GetInstance().AnimalTaming = UOUpadeView->GetSkill("Anim");
    UOTreeView::GetInstance().Begging = UOUpadeView->GetSkill("Begg");
    UOTreeView::GetInstance().Camping = UOUpadeView->GetSkill("Camp");
    UOTreeView::GetInstance().DetectingHidden = UOUpadeView->GetSkill("Det");
    UOTreeView::GetInstance().Discordance = UOUpadeView->GetSkill("Disc");
    UOTreeView::GetInstance().Hiding = UOUpadeView->GetSkill("Hidi");
    UOTreeView::GetInstance().Inscription = UOUpadeView->GetSkill("Insc");
    UOTreeView::GetInstance().Peacemaking = UOUpadeView->GetSkill("Peac");
    UOTreeView::GetInstance().Poisoning = UOUpadeView->GetSkill("Pois");
    UOTreeView::GetInstance().Provocation = UOUpadeView->GetSkill("Prov");
    UOTreeView::GetInstance().SpiritSpeak = UOUpadeView->GetSkill("Spir");
    UOTreeView::GetInstance().Tracking = UOUpadeView->GetSkill("Trac");


    //Lore & Knowledge
    UOTreeView::GetInstance().Anatomy = UOUpadeView->GetSkill("Anat");
    UOTreeView::GetInstance().AnimalLore = UOUpadeView->GetSkill("Anil");
    UOTreeView::GetInstance().ArmsLore = UOUpadeView->GetSkill("Arms");
    UOTreeView::GetInstance().EvaluatingIntelligence = UOUpadeView->GetSkill("Eval");
    UOTreeView::GetInstance().ForensicEvaluation = UOUpadeView->GetSkill("Fore");
    UOTreeView::GetInstance().ItemIdentification = UOUpadeView->GetSkill("Item");
    UOTreeView::GetInstance().TasteIdentification = UOUpadeView->GetSkill("Tast");



    UOTreeView::GetInstance().UpdateView();

}
int TabWindow::Status()
{
    return mStatus;
}

void TabWindow::SwapClient()
{
    ScopedLock mutex(&mMutex);
    int CliNr = mUO->CliNr();
    if(CliNr<mUO->CliCnt())
    {
        mUO->SetCliNr(CliNr+1);
    }
    else
    {
        mUO->SetCliNr(1);
    }
}
int TabWindow::CliNr()
{
    return mCliNr;
}

QString TabWindow::CharName()
{
    return mCharName;
}
