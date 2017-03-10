#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "UOTreeView.h"
#include <QPlainTextEdit>
#include <QMessageBox>
#include <QFileDialog>
#include <QTextStream>
#include <QTimer>
#include <QSettings>
#include <QTextDocumentWriter>
#include "about.h"
#include "findreplace.h"

#define MAX_RECENT_FILES 5

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"

}

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    UOTreeView::GetInstance().SetView(ui->treeView);
    CreateTab();
    connect(ui->tabMacros,SIGNAL(tabCloseRequested(int)),this, SLOT(CloseTab(int)));
    connect(ui->tabMacros,SIGNAL(currentChanged(int)),this, SLOT(updateButtons(int)));
    connect(ui->tabMacros,SIGNAL(currentChanged(int)),this, SLOT(updateFindWidget(int)));
    connect(Log::getInstance(),SIGNAL(textChanged(int,QString)),this,SLOT(printFromScript(int,QString)));
    QTimer* treeViewTimer = new QTimer(this);
    treeViewTimer->setInterval(500);
    UOTreeView* treeView = &UOTreeView::GetInstance();
    connect(treeViewTimer,SIGNAL(timeout()),treeView,SLOT(UpdateView()));
    treeViewTimer->start();

    connect(&Map::getInstance(),SIGNAL(showMap(int)),this, SLOT(showMap(int)));
    connect(&Map::getInstance(),SIGNAL(hideMap(int)),this, SLOT(hideMap(int)));
    connect(&Map::getInstance(),SIGNAL(setPositionMap(int,int,int)),this, SLOT(setPositionMap(int,int,int)));
    connect(&Map::getInstance(),SIGNAL(createLineMap(int,QLine,int,QColor)),this, SLOT(createLineMap(int,QLine,int,QColor)));
    connect(&Map::getInstance(),SIGNAL(removeLineMap(int,int)),this, SLOT(removeLineMap(int,int)));
    connect(&Map::getInstance(),SIGNAL(removeAllLinesMap(int)),this, SLOT(removeAllLinesMap(int)));

    ui->menuFile->addSeparator();
    for (int i = 0; i < MAX_RECENT_FILES; ++i)
    {
        recentFileActs[i] = new QAction(this);
        recentFileActs[i]->setVisible(false);
        connect(recentFileActs[i], SIGNAL(triggered()),
             this, SLOT(openRecentFile()));
        ui->menuFile->addAction(recentFileActs[i]);
    }
    ChangeStatus(0,2);
    UpdateRecentFileActions();
    mFindReplaceWindow = new FindReplace(this);
    connect(mFindReplaceWindow, &FindReplace::Find,mCodeAreas.at(0), &CodeArea::Find);
    connect(mFindReplaceWindow, &FindReplace::ReplaceFind,mCodeAreas.at(0), &CodeArea::ReplaceFind);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::CreateTab(const QString &text,const QString &name)
{
    static int codeID = 0;
    mCurrentTabID = 0;
    /** CODE AREA **/
    CodeArea* newCodeArea = new CodeArea(this);
    mCodeAreas.push_back(newCodeArea);
    if(!text.isEmpty())
    {
        newCodeArea->document()->setPlainText(text);
    }

    /** LOG **/
    QTextEdit* newLogText = new QTextEdit(this);
    newLogText->setMaximumSize(16777215,150);
    mLogTexts.push_back(newLogText);

    /** LAYOUT **/
    Block* newWidget = new Block(this);
    newWidget->codeID = codeID;
    QVBoxLayout* newLayout = new QVBoxLayout(newWidget);

    mVBoxLayouts.push_back(newLayout);
    newLayout->addWidget(newCodeArea);
    newLayout->addWidget(newLogText);

    /** SCRIPT **/
    //mThreads.push_back(new QThread());
    mScripts.push_back(new ScriptRunner(1,codeID,newCodeArea->document()->toPlainText(), this));
    //QThread* thread = mThreads.at(codeID);
    ScriptRunner* script = mScripts.at(codeID);
    //connect(thread, &QThread::started, script, &ScriptRunner::run);
    //connect(script, &ScriptRunner::finished, thread, &QThread::quit);
    connect(script, SIGNAL(updateButtonsFinished(int)), this, SLOT(MacroFinished(int)));
    connect(script, SIGNAL(print(int,QString)), this, SLOT(printFromScript(int,QString)));
    script->configure();
    /** TAB **/
    QString tabName = QString("tab %1").arg(codeID);
    if(!name.isEmpty())
        tabName = name;
    ui->tabMacros->addTab(newWidget, tabName);
    ui->tabMacros->setCurrentIndex(ui->tabMacros->count()-1);
    int cliNr = mScripts.at(codeID)->getCliNr();
    UOTreeView::GetInstance().SetCliNr(cliNr);
    codeID++;

}

void MainWindow::CloseTab(int index)
{
    const int codeID = ((Block*)ui->tabMacros->widget(index))->codeID;
    ChangeStatus(codeID,2);
    mScripts.at(codeID)->terminate();
    mScripts.at(codeID)->stop();

    if(ui->tabMacros->count()<=1)
    {
        CreateTab();
    }
    ui->tabMacros->removeTab(index);

}

void MainWindow::on_actionNew_triggered()
{
    CreateTab();
}
void MainWindow::playMacro()
{
}
void MainWindow::ChangeStatus(int tabIndex, int status)
{
    if(tabIndex==((Block*)ui->tabMacros->currentWidget())->codeID)
    {
        if(status==1)
        {
            ui->actionPlay->setEnabled(false);
            ui->actionStop->setEnabled(true);
            //ui->actionPause->setEnabled(true);
        }
        if(status == 2)
        {
            ui->actionPlay->setEnabled(true);
            ui->actionStop->setEnabled(false);
            //ui->actionPause->setEnabled(false);
        }
    }
}
void MainWindow::MacroFinished(int tabIndex)
{
    ChangeStatus(tabIndex,2);
}

void MainWindow::printFromScript(int tabIndex,const QString &text)
{
    mLogTexts.at(tabIndex)->append(text);
}

void MainWindow::updateButtons(int tabIndex)
{
    Q_UNUSED(tabIndex);
    const int codeID = ((Block*)ui->tabMacros->currentWidget())->codeID;
    ChangeStatus(codeID,mScripts.at(codeID)->isRunning()?1:2);
    int cliNr = mScripts.at(codeID)->getCliNr();
    UOTreeView::GetInstance().SetCliNr(cliNr);
}

void MainWindow::updateFindWidget(int tabIndex)
{
    Q_UNUSED(tabIndex);
    const int codeID = ((Block*)ui->tabMacros->currentWidget())->codeID;
    disconnect(mFindReplaceWindow, &FindReplace::Find,mCodeAreas.at(mCurrentTabID), &CodeArea::Find);
    disconnect(mFindReplaceWindow, &FindReplace::ReplaceFind,mCodeAreas.at(mCurrentTabID), &CodeArea::ReplaceFind);

    connect(mFindReplaceWindow, &FindReplace::Find,mCodeAreas.at(codeID), &CodeArea::Find);
    connect(mFindReplaceWindow, &FindReplace::ReplaceFind,mCodeAreas.at(codeID), &CodeArea::ReplaceFind);
}

void MainWindow::showMap(int tabIndex)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->show();
}

void MainWindow::hideMap(int tabIndex)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->hide();
}

void MainWindow::setPositionMap(int tabIndex, int x, int y)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->setPosition(x,y);
}

void MainWindow::createLineMap(int tabIndex, const QLine &line, int lineID, const QColor &color)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->createLine(line,lineID,color);
}

void MainWindow::removeLineMap(int tabIndex, int lineID)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->removeLine(lineID);
}

void MainWindow::removeAllLinesMap(int tabIndex)
{
    if(mMapList[tabIndex]==NULL)
    {
        mMapList[tabIndex] = new MapWindow();
    }
    mMapList[tabIndex]->removeAllLines();
}

void MainWindow::on_actionPlay_triggered()
{
    const int index = ((Block*)ui->tabMacros->currentWidget())->codeID;
    ChangeStatus(index,1);
    //QThread* thread = mThreads.at(index);
    ScriptRunner* script = mScripts.at(index);
    script->setScript(mCodeAreas.at(index)->document()->toPlainText());
    script->start();
}

void MainWindow::on_actionStop_triggered()
{
    const int codeID = ((Block*)ui->tabMacros->currentWidget())->codeID;
    ChangeStatus(codeID,2);
    mScripts.at(codeID)->terminate();
    mScripts.at(codeID)->stop();
    //mThreads.at(codeID)->terminate();
}

void MainWindow::on_actionSwap_triggered()
{
    const int codeID = ((Block*)ui->tabMacros->currentWidget())->codeID;
    int cliNr = mScripts.at(codeID)->swapClient();
    UOTreeView::GetInstance().SetCliNr(cliNr);
    UOTreeView::GetInstance().UpdateView();
}

void MainWindow::on_actionOpen_triggered()
{
    QString fileName = QFileDialog::getOpenFileName(this);
    if (fileName.isEmpty())
        return;
    QFile file(fileName);
    if (!file.open(QFile::ReadOnly)) {
        QMessageBox::warning(this, tr("Recent Files"),
                             tr("Cannot read file %1:\n%2.")
                             .arg(fileName)
                             .arg(file.errorString()));
        return;
    }

    QTextStream in(&file);
    QApplication::setOverrideCursor(Qt::WaitCursor);
    QFileInfo fileInfo(file);
    CreateTab(in.readAll(),fileInfo.fileName());
    mFileList[((Block*)ui->tabMacros->currentWidget())->codeID] = file.fileName();
    QApplication::restoreOverrideCursor();
    SetCurrentFile(fileName);
}

void MainWindow::on_actionSave_triggered()
{
    const int codeID = ((Block*)ui->tabMacros->currentWidget())->codeID;
    QString file = mFileList[codeID];
    if(file.isEmpty())
    {
        file = QFileDialog::getSaveFileName(this,"Save file","","*.lua");
        if(file.isEmpty())
            return;
    }

    QTextDocumentWriter writer;
    //writer.setDevice();
    writer.setFileName(file);
    writer.setFormat("plaintext");
    writer.write(mCodeAreas.at(codeID)->document());

    mCodeAreas.at(codeID)->document()->setModified(false);
    mFileList[codeID] = file;
    SetCurrentFile(file);
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

void MainWindow::openRecentFile()
{
    QAction *action = qobject_cast<QAction *>(sender());
    if (action)
    {
        QString fileName = action->data().toString();
        if (fileName.isEmpty())
            return;
        QFile file(fileName);
        if (!file.open(QFile::ReadOnly | QFile::Text)) {
            QMessageBox::warning(this, tr("Recent Files"),
                      tr("Cannot read file %1:\n%2.")
                      .arg(fileName)
                      .arg(file.errorString()));
            return;
        }

        QTextStream in(&file);
        QApplication::setOverrideCursor(Qt::WaitCursor);
        QFileInfo fileInfo(file);
        CreateTab(in.readAll(),fileInfo.fileName());
        QApplication::restoreOverrideCursor();
        mFileList[((Block*)ui->tabMacros->currentWidget())->codeID] = file.fileName();
        //CreateTab(action->data().toString(),action->data().toString());
    }
}

void MainWindow::on_actionStopAll_triggered()
{
    foreach (ScriptRunner* script, mScripts)
    {
        script->terminate();
        script->stop();
    }
    ChangeStatus(((Block*)ui->tabMacros->currentWidget())->codeID,2);
}

void MainWindow::on_actionAbout_triggered()
{
    about *a = new about(this);
    a->setAttribute(Qt::WA_DeleteOnClose);
    a->show();
}

void MainWindow::closeEvent (QCloseEvent *event)
{
    QMessageBox::StandardButton resBtn = QMessageBox::question( this, "HardUO",
                                                                tr("Are you sure?\n"),
                                                                QMessageBox::Cancel | QMessageBox::No | QMessageBox::Yes,
                                                                QMessageBox::Yes);
    if (resBtn != QMessageBox::Yes)
    {
        event->ignore();
    }
    else
    {
        event->accept();
        for(int i = ui->tabMacros->count()-1; i >= 0;--i)
        {
            const int codeID = ((Block*)ui->tabMacros->widget(i))->codeID;
            ChangeStatus(codeID,2);
            mScripts.at(codeID)->terminate();
            mScripts.at(codeID)->stop();
            //ui->tabMacros->removeTab(i);
            ScriptRunner *r = mScripts.at(codeID);
            delete r;
        }

        QApplication::quit();
    }
}

void MainWindow::on_actionFind_Replace_triggered()
{
    mFindReplaceWindow->show();
    mFindReplaceWindow->activateWindow();
}
