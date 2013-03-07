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
    completingTextEdit = new CodeArea();
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
    logText->setReadOnly(true);
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
    mStatus = 0;
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
    //UOTreeView::GetInstance().CharDir =
    //UOTreeView::GetInstance().CharStatus =
    //UOTreeView::GetInstance().CharID =
    //UOTreeView::GetInstance().CharGhost =
    UOTreeView::GetInstance().BackpackID = UOUpadeView->BackpackID();
    /// Status Bar
    mCharName = UOUpadeView->CharName().data();
    UOTreeView::GetInstance().CharName = mCharName;
    UOTreeView::GetInstance().Sex = UOUpadeView->Sex();
    //UOTreeView::GetInstance().Str = UOUpadeView->Str();
    //UOTreeView::GetInstance().Dex = UOUpadeView->Dex();
    //UOTreeView::GetInstance().Int = UOUpadeView->Int();
    UOTreeView::GetInstance().Hits = UOUpadeView->Hits();
    UOTreeView::GetInstance().MaxHits = UOUpadeView->MaxHits();
    UOTreeView::GetInstance().Stamina = UOUpadeView->Stam();
    UOTreeView::GetInstance().MaxStam = UOUpadeView->MaxStam();

    UOTreeView::GetInstance().Mana = UOUpadeView->Mana();
    UOTreeView::GetInstance().MaxMana = UOUpadeView->MaxMana();
    //UOTreeView::GetInstance().MaxSats = UOUpadeView->MaxStats();
    //UOTreeView::GetInstance().Luck = UOUpadeView->Luck();
    UOTreeView::GetInstance().Weight = UOUpadeView->Weight();
    UOTreeView::GetInstance().MaxWeight = UOUpadeView->MaxWeight();
    //UOTreeView::GetInstance().MinDmg = UOUpadeView->MinDmg();
    //UOTreeView::GetInstance().MaxDmg = UOUpadeView->MaxDmg();
    UOTreeView::GetInstance().Gold = UOUpadeView->Gold();
    //UOTreeView::GetInstance().Followers = UOUpadeView->Followers();
    //UOTreeView::GetInstance().MaxFol = UOUpadeView->MaxFol();
    UOTreeView::GetInstance().Ar = UOUpadeView->Ar();
    //UOTreeView::GetInstance().Fr = UOUpadeView->Fr();
    //UOTreeView::GetInstance().Cr = UOUpadeView->Cr();
    //UOTreeView::GetInstance().Pr = UOUpadeView->Pr();
    //UOTreeView::GetInstance().Er = UOUpadeView->Er();
    //UOTreeView::GetInstance().Tp = UOUpadeView->Tp();

    /// Client Info
    mCliNr = UOUpadeView->CliNr();
    UOTreeView::GetInstance().CliNr = mCliNr;
    UOTreeView::GetInstance().CliCnt = UOUpadeView->CliCnt();
    //UOTreeView::GetInstance().CliLang = UOUpadeView->CliLang();
    //UOTreeView::GetInstance().CliVer = UOUpadeView->CliVer();
    //UOTreeView::GetInstance().CliLogged = UOUpadeView->CliLogged();
    //UOTreeView::GetInstance().CliLeft = UOUpadeView->CliLeft();
    //UOTreeView::GetInstance().CliTop = UOUpadeView->CliTop();
    //UOTreeView::GetInstance().CliXRes = UOUpadeView->CliXRes();
    //UOTreeView::GetInstance().CliYRes = UOUpadeView->CliYRes();
    //UOTreeView::GetInstance().CliTitle = UOUpadeView->CliTitle();

    /// Last Action
    UOTreeView::GetInstance().LLiftedType = UOUpadeView->LLiftedType();



    //Miscellaneous Skills
    UOTreeView::GetInstance().Alchemy = UOUpadeView->GetSkill("Alch").real;
    UOTreeView::GetInstance().Blacksmithy = UOUpadeView->GetSkill("Blac").real;
    UOTreeView::GetInstance().Bowcraft = UOUpadeView->GetSkill("Bowc").real;
    UOTreeView::GetInstance().Bushido = UOUpadeView->GetSkill("Bush").real;
    UOTreeView::GetInstance().Carpentry = UOUpadeView->GetSkill("Carp").real;
    UOTreeView::GetInstance().Chivalry = UOUpadeView->GetSkill("Chiv").real;
    UOTreeView::GetInstance().Cooking = UOUpadeView->GetSkill("Cook").real;
    UOTreeView::GetInstance().Fishing = UOUpadeView->GetSkill("Fish").real;
    UOTreeView::GetInstance().Focus = UOUpadeView->GetSkill("Focu").real;
    UOTreeView::GetInstance().Healing = UOUpadeView->GetSkill("Heal").real;
    UOTreeView::GetInstance().Herding = UOUpadeView->GetSkill("Herd").real;
    UOTreeView::GetInstance().Lockpicking = UOUpadeView->GetSkill("Lock").real;
    UOTreeView::GetInstance().Lumberjacking = UOUpadeView->GetSkill("Lumb").real;
    UOTreeView::GetInstance().Magery = UOUpadeView->GetSkill("Mage").real;
    UOTreeView::GetInstance().Meditation = UOUpadeView->GetSkill("Medi").real;
    UOTreeView::GetInstance().Mining = UOUpadeView->GetSkill("Mini").real;
    UOTreeView::GetInstance().Musicianship = UOUpadeView->GetSkill("Musi").real;
    UOTreeView::GetInstance().Necromancy = UOUpadeView->GetSkill("Necr").real;
    UOTreeView::GetInstance().Ninjitsu = UOUpadeView->GetSkill("Ninj").real;
    UOTreeView::GetInstance().RemoveTrap = UOUpadeView->GetSkill("Remo").real;
    UOTreeView::GetInstance().ResistingSpells = UOUpadeView->GetSkill("Resi").real;
    UOTreeView::GetInstance().Snooping = UOUpadeView->GetSkill("Snoo").real;
    UOTreeView::GetInstance().Stealing = UOUpadeView->GetSkill("Stea").real;
    UOTreeView::GetInstance().Stealth = UOUpadeView->GetSkill("Stlt").real;
    UOTreeView::GetInstance().Tailoring = UOUpadeView->GetSkill("Tail").real;
    UOTreeView::GetInstance().Tinkering = UOUpadeView->GetSkill("Tink").real;
    UOTreeView::GetInstance().Veterinary = UOUpadeView->GetSkill("Vete").real;



    //Combat Skills
    UOTreeView::GetInstance().Archery = UOUpadeView->GetSkill("Arch").real;
    UOTreeView::GetInstance().Fencing = UOUpadeView->GetSkill("Fenc").real;
    UOTreeView::GetInstance().MaceFighting = UOUpadeView->GetSkill("Mace").real;
    UOTreeView::GetInstance().Parrying = UOUpadeView->GetSkill("Parr").real;
    UOTreeView::GetInstance().Swordsmanship = UOUpadeView->GetSkill("Swor").real;
    UOTreeView::GetInstance().Tactics = UOUpadeView->GetSkill("Tact").real;
    UOTreeView::GetInstance().Wrestling = UOUpadeView->GetSkill("Wres").real;

    //Actions
    UOTreeView::GetInstance().AnimalTaming = UOUpadeView->GetSkill("Anim").real;
    UOTreeView::GetInstance().Begging = UOUpadeView->GetSkill("Begg").real;
    UOTreeView::GetInstance().Camping = UOUpadeView->GetSkill("Camp").real;
    UOTreeView::GetInstance().DetectingHidden = UOUpadeView->GetSkill("Det").real;
    UOTreeView::GetInstance().Discordance = UOUpadeView->GetSkill("Disc").real;
    UOTreeView::GetInstance().Hiding = UOUpadeView->GetSkill("Hidi").real;
    UOTreeView::GetInstance().Inscription = UOUpadeView->GetSkill("Insc").real;
    UOTreeView::GetInstance().Peacemaking = UOUpadeView->GetSkill("Peac").real;
    UOTreeView::GetInstance().Poisoning = UOUpadeView->GetSkill("Pois").real;
    UOTreeView::GetInstance().Provocation = UOUpadeView->GetSkill("Prov").real;
    UOTreeView::GetInstance().SpiritSpeak = UOUpadeView->GetSkill("Spir").real;
    UOTreeView::GetInstance().Tracking = UOUpadeView->GetSkill("Trac").real;


    //Lore & Knowledge
    UOTreeView::GetInstance().Anatomy = UOUpadeView->GetSkill("Anat").real;
    UOTreeView::GetInstance().AnimalLore = UOUpadeView->GetSkill("Anil").real;
    UOTreeView::GetInstance().ArmsLore = UOUpadeView->GetSkill("Arms").real;
    UOTreeView::GetInstance().EvaluatingIntelligence = UOUpadeView->GetSkill("Eval").real;
    UOTreeView::GetInstance().ForensicEvaluation = UOUpadeView->GetSkill("Fore").real;
    UOTreeView::GetInstance().ItemIdentification = UOUpadeView->GetSkill("Item").real;
    UOTreeView::GetInstance().TasteIdentification = UOUpadeView->GetSkill("Tast").real;



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
