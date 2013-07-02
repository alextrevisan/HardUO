#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "ui_skillslist.h"
#include <QProcess>
#include <QVBoxLayout>
#include <QTextEdit>
#include <QCompleter>
#include <QFile>
#include <QMessageBox>
#include <QFileDialog>
#include <QStandardItemModel>
#include <QTimer>
#include <QStringListModel>
#include <QUrl>
#include <QSettings>
#include <QMimeData>

#include <windows.h>
#include "CodeArea.h"
#include "ScriptRunner.h"
#include "UOTreeView.h"
#include "about.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
  ,mTabNum(1)
{
    ui->setupUi(this);

    wordList << "print()"
             << "UO:BackpackID()"
             << "UO:Mana()"
             << "UO:MaxMana()"
             << "wait "

             << "Speak "
             << "true "

             << "while ";


    //completingTextEdit = new CodeArea();

    completer = new QCompleter(this);
    completer->setModel(new QStringListModel(wordList, completer));
    completer->setModelSorting(QCompleter::CaseSensitivelySortedModel);
    completer->setCaseSensitivity(Qt::CaseSensitive);
    completer->setWrapAround(false);
    //completer->
   // completingTextEdit->setCompleter(completer);

    mTabWidget = new QTabWidget();
    setCentralWidget(mTabWidget);
    mTabWidget->setTabsClosable(true);
    mTabWidget->setMovable(true);

    TabWindow* tmp = new TabWindow(this);

    mTabWidget->addTab(tmp,"new "+QString::number(mTabNum++));
    mTabWindows.append(tmp);
    tmp->SetCompleter(completer);

    connect(mTabWidget, SIGNAL(tabCloseRequested(int)),this,SLOT(CloseTab(int)));
    connect(mTabWidget, SIGNAL(currentChanged(int)),this,SLOT(TabChange(int)));


    setWindowTitle(tr("HardUO"));

    mStatusText = new QLabel();
    ui->statusBar->addWidget(mStatusText);

    UOTreeView::GetInstance().SetView(ui->treeView);
    SetButtonStatus(0);


    QTimer* timer = new QTimer(this);
    timer->setInterval(500);
    connect(timer, SIGNAL(timeout()), this, SLOT(UpdateView()));
    connect(timer, SIGNAL(timeout()), this, SLOT(updateButtons()));
    timer->start();

    SL = new SkillsList();
    setAcceptDrops(true);
    ui->menuArquivo->addSeparator();
    for (int i = 0; i < MAX_RECENT_FILES; ++i)
    {
        recentFileActs[i] = new QAction(this);
        recentFileActs[i]->setVisible(false);
        connect(recentFileActs[i], SIGNAL(triggered()),
             this, SLOT(openRecentFile()));
        ui->menuArquivo->addAction(recentFileActs[i]);
    }


    openAll = new QAction(this);
    openAll->setText("Open all recent files");
    connect(openAll, SIGNAL(triggered()),
         this, SLOT(openAllRecentFile()));

    clearAll = new QAction(this);
    clearAll->setText("Clear all recent files");
    connect(clearAll, SIGNAL(triggered()),
         this, SLOT(clearAllRecentFiles()));
    ui->menuArquivo->addSeparator();
    ui->menuArquivo->addAction(openAll);
    ui->menuArquivo->addAction(clearAll);
    //ui->menuRecentes->addAction()

    UpdateRecentFileActions();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_actionRun_F9_triggered()
{
    if(mTabWidget->currentIndex()>=0)
    {
        mTabWindows[mTabWidget->currentIndex()]->Step(false);
        mTabWindows[mTabWidget->currentIndex()]->Start();
        SetButtonStatus(mTabWindows[mTabWidget->currentIndex()]->Status());
    }
}
void MainWindow::on_actionPause_F10_triggered()
{
    if(mTabWidget->currentIndex()>=0)
    {
        TabWindow* tab = mTabWindows[mTabWidget->currentIndex()];
        tab->Step(false);
        tab->Pause();
        SetButtonStatus(tab->Status());
    }
}

void MainWindow::on_actionStop_F11_triggered()
{
    if(mTabWidget->currentIndex()>=0)
    {
        mTabWindows[mTabWidget->currentIndex()]->Stop();
        SetButtonStatus(mTabWindows[mTabWidget->currentIndex()]->Status());
    }
}

void MainWindow::LoadFile(const QString &filename)
{
    QFile file(filename);
    if (!file.open(QFile::ReadOnly | QFile::Text)) {
        QMessageBox::warning(this, tr("Recent Files"),
                             tr("Cannot read file %1:\n%2.")
                             .arg(filename)
                             .arg(file.errorString()));
        return;
    }

    QTextStream in(&file);
    QApplication::setOverrideCursor(Qt::WaitCursor);


    //textEdit->setPlainText(in.readAll());
    if(mTabWindows.size()>0 && mTabWindows[0]->TextEdit()->document()->toPlainText().size() == 0)
    {
        mTabWidget->removeTab(0);
        delete mTabWindows[0];
        mTabWindows.removeAt(0);
    }
    QString script = in.readAll();
    TabWindow* tmp = new TabWindow(script);
    tmp->SetFileName(filename);
    QFileInfo f(file);

    mTabWidget->addTab(tmp,f.fileName());
    mTabWindows.append(tmp);

    tmp->SetCompleter(completer);
    tmp->TextEdit()->document()->setModified(false);
    SetCurrentFile(filename);
    QApplication::restoreOverrideCursor();

}

void MainWindow::on_actionNovo_triggered()
{
    TabWindow* tmp = new TabWindow(this);

    mTabWidget->addTab(tmp,"new "+QString::number(mTabNum++));
    mTabWindows.append(tmp);
    tmp->SetCompleter(completer);
}

void MainWindow::CloseTab(int tab)
{
    mTabWidget->removeTab(tab);
    delete mTabWindows[tab];
    mTabWindows.removeAt(tab);
}
void MainWindow::TabChange(int tab)
{
    if(tab>0)
    {
        UpdateView();
        SetButtonStatus(mTabWindows[tab]->Status());
    }
}

void MainWindow::on_actionAbrir_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this);
    if (!fileName.isEmpty())
        LoadFile(fileName);
}

void MainWindow::on_actionStop_All_F12_triggered()
{
    foreach(TabWindow* t, mTabWindows)
    {
        t->Stop();
    }
    SetButtonStatus(0);
}

void MainWindow::UpdateView()
{
    if(mTabWidget->currentIndex()>=0)
    {
        mTabWindows[mTabWidget->currentIndex()]->UpdateView();
        setWindowTitle(QString("HardUO - %0 - CliNr: %1")
                       .arg(mTabWindows[mTabWidget->currentIndex()]->CharName())
                       .arg(mTabWindows[mTabWidget->currentIndex()]->CliNr()));
    }

}

void MainWindow::updateButtons()
{
    if(mTabWidget->currentIndex()>=0)
    {
        ui->actionSave->setEnabled(mTabWindows[mTabWidget->currentIndex()]->TextEdit()->document()->isModified());
        SetButtonStatus(mTabWindows[mTabWidget->currentIndex()]->Status());
    }
}

void MainWindow::changeEvent(QEvent *e)
{
    QMainWindow::changeEvent(e);
    switch (e->type()) {
    case QEvent::LanguageChange:
        ui->retranslateUi(this);
        break;
    default:
        break;
    }
}

void MainWindow::dragEnterEvent(QDragEnterEvent *event)
{
    event->acceptProposedAction();
    //emit changed(event->mimeData());
}

void MainWindow::dragMoveEvent(QDragMoveEvent *event)
{
    event->acceptProposedAction();
}

void MainWindow::dragLeaveEvent(QDragLeaveEvent *event)
{
}

void MainWindow::dropEvent(QDropEvent *event)
{
    const QMimeData* mimeData = event->mimeData();
    // check for our needed mime type, here a file or a list of files
    if (mimeData->hasUrls())
    {
        QList<QUrl> urlList = mimeData->urls();
        // extract the local paths of the files
        for (int i = 0; i < urlList.size() && i < 32; ++i)
        {
            LoadFile(urlList.at(i).toLocalFile());
        }
    }
}

void MainWindow::SetButtonStatus(int status)
{
    if(status==0)
    {
        ui->actionRun_F9->setEnabled(true);
        ui->actionPause_F10->setEnabled(false);
        ui->actionStop_F11->setEnabled(false);
        mStatusText->setText("Stopped!");
    }
    else if(status==1)
    {
        ui->actionRun_F9->setEnabled(false);
        ui->actionPause_F10->setEnabled(true);
        ui->actionStop_F11->setEnabled(true);
        mStatusText->setText("Running...");
    }
    else if(status==2)
    {
        ui->actionRun_F9->setEnabled(true);
        ui->actionPause_F10->setEnabled(true);
        ui->actionStop_F11->setEnabled(true);
        mStatusText->setText("Paused...");
    }

    bool stopall = false;
    foreach(TabWindow* tab, mTabWindows)
    {
        if(tab->Status()>0)
        {
            stopall = true;
            break;
        }
    }
    ui->actionStop_All_F12->setEnabled(stopall);
}

void MainWindow::UpdateRecentFileActions()
{

    QSettings settings("HogPog","HardUO");
    QStringList files = settings.value("recentFileList").toStringList();

    int numRecentFiles = qMin(files.size(), (int)MAX_RECENT_FILES);
    for (int i = 0; i < numRecentFiles; ++i)
    {
        QString text = tr("&%1 %2").arg(i + 1).arg(QFileInfo(files[i]).fileName());
        recentFileActs[i]->setText(text);
        recentFileActs[i]->setData(files[i]);
        recentFileActs[i]->setVisible(true);
    }
    if(numRecentFiles>0)
    {
        clearAll->setEnabled(true);
        openAll->setEnabled(true);
    }
    else
    {
        clearAll->setEnabled(false);
        openAll->setEnabled(false);
    }
    for (int j = numRecentFiles; j < MAX_RECENT_FILES; ++j)
        recentFileActs[j]->setVisible(false);
}

void MainWindow::SetCurrentFile(const QString &fileName)
{
    QSettings settings("HogPog","HardUO");
    QStringList files = settings.value("recentFileList").toStringList();
    files.removeAll(fileName);
    files.prepend(fileName);
    while (files.size() > MAX_RECENT_FILES)
        files.removeLast();

    settings.setValue("recentFileList", files);

    UpdateRecentFileActions();
}

void MainWindow::clearAllRecentFiles()
{
    QSettings settings("HogPog","HardUO");
    QStringList files;
    files.clear();
    settings.setValue("recentFileList", files);
    UpdateRecentFileActions();
}

void MainWindow::on_actionSwap_triggered()
{
    mTabWindows[mTabWidget->currentIndex()]->SwapClient();
    UpdateView();
}

void MainWindow::on_actionAbout_triggered()
{
    about *a = new about();
    a->setAttribute(Qt::WA_DeleteOnClose);
    a->show();
}

void MainWindow::on_actionSkills_triggered()
{
    SL->show();
}

void MainWindow::on_actionStep_triggered()
{
    if(mTabWindows[mTabWidget->currentIndex()]->InStep())
    {
        mTabWindows[mTabWidget->currentIndex()]->Pause();
    }
    else
    {
        mTabWindows[mTabWidget->currentIndex()]->Step();
    }
}

void MainWindow::on_actionSave_triggered()
{
    mTabWindows[mTabWidget->currentIndex()]->Save();
    QFileInfo f(mTabWindows[mTabWidget->currentIndex()]->GetFileName());
    SetCurrentFile(mTabWindows[mTabWidget->currentIndex()]->GetFileName());
    if(!f.exists())
        return;
    mTabWidget->setTabText(mTabWidget->currentIndex(),f.fileName());
}

void MainWindow::openRecentFile()
{
    QAction *action = qobject_cast<QAction *>(sender());
         if (action)
             LoadFile(action->data().toString());
}

void MainWindow::openAllRecentFile()
{
    QSettings settings("HogPog","HardUO");
    QStringList files = settings.value("recentFileList").toStringList();

    int numRecentFiles = qMin(files.size(), (int)MAX_RECENT_FILES);
    for (int i = 0; i < numRecentFiles; ++i)
    {
        LoadFile(recentFileActs[i]->data().toString());
    }
}

void MainWindow::closeEvent(QCloseEvent *event)
{
    foreach(TabWindow* tab, mTabWindows)
    {
        if(tab->TextEdit()->document()->isModified())
        {
            QMessageBox::StandardButton ret;
            ret = QMessageBox::warning(this, tr("HardUO"),
                      tr("Tem certeza que deseja sair?\n"
                         "Todos os documentos não salvos serão perdidos."),
                      QMessageBox::Ok | QMessageBox::Cancel);
            if (ret == QMessageBox::Ok)
                event->accept();
            else
                event->ignore();
            break;
        }

    }

}
