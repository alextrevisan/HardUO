#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QCompleter>
#include "CodeArea.h"
#include <QDebug>
#include "ScriptRunner.h"
#include <QTabWidget>
#include <QLabel>
#include "TabWindow.h"
#include "skillslist.h"

#define MAX_RECENT_FILES 10


extern "C"
{
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
}


namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
private slots:
    void on_actionStop_F11_triggered();
    void on_actionPause_F10_triggered();
    void on_actionRun_F9_triggered();
    void on_actionNovo_triggered();
    void CloseTab(int tab);
    void TabChange(int tab);
    void on_actionAbrir_triggered();
    void on_actionStop_All_F12_triggered();
    void UpdateView();
    void updateButtons();

    void changeEvent(QEvent *e);
    void dragEnterEvent(QDragEnterEvent *event);
    void dragMoveEvent(QDragMoveEvent *event);
    void dragLeaveEvent(QDragLeaveEvent *event);
    void dropEvent(QDropEvent *event);

    void on_actionSwap_triggered();

    void on_actionAbout_triggered();

    void on_actionSkills_triggered();

    void on_actionStep_triggered();

    void on_actionSave_triggered();

    void openRecentFile();
    void openAllRecentFile();
    void clearAllRecentFiles();
protected:
    void closeEvent(QCloseEvent *event);
private:
    void LoadFile(const QString& filename);
    void SetButtonStatus(int status);
    void UpdateRecentFileActions();
    void SetCurrentFile(const QString &fileName);

    Ui::MainWindow *ui;
    QCompleter *c;
    QCompleter* completer;
    QTabWidget* mTabWidget;
    QList<TabWindow*> mTabWindows;
    QLabel* mStatusText;
    int mTabNum;
    QStringList wordList;
    SkillsList *SL;
    QAction* recentFileActs[MAX_RECENT_FILES];
    QAction *openAll;
    QAction *clearAll;

};

#endif // MAINWINDOW_H
