#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QList>
#include <QVBoxLayout>
#include <QTextEdit>
#include <QThread>
#include "scriptrunner.h"
#include "codearea.h"

#define MAX_RECENT_FILES 5

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    void ChangeStatus(int tabIndex, int status);
    
private slots:
    void on_actionNew_triggered();
    void CloseTab(int index);
    void playMacro();
    void MacroFinished(int tabIndex);
    void printFromScript(int tabIndex,const QString& text);
    void updateButtons(int tabIndex);
    /** map **/
    void showMap(int tabIndex);
    void hideMap(int tabIndex);
    void setPositionMap(int tabIndex, int x, int y);
    void createLineMap(int tabIndex, const QLine& line, int lineID, const QColor& color);
    void removeLineMap(int tabIndex, int lineID);
    void removeAllLinesMap(int tabIndex);
    /** **/

    void on_actionPlay_triggered();

    void on_actionStop_triggered();

    void on_actionSwap_triggered();

    void on_actionOpen_triggered();

    void on_actionSave_triggered();

    void openRecentFile();

    void on_actionStopAll_triggered();

private:
    void CreateTab(const QString& text = "", const QString &name = "");
    void UpdateRecentFileActions();
    void SetCurrentFile(const QString &fileName);
    QAction* recentFileActs[MAX_RECENT_FILES];
    Ui::MainWindow *ui;
    QList<CodeArea*> mCodeAreas;
    QList<QVBoxLayout*> mVBoxLayouts;
    QList<QTextEdit*> mLogTexts;
    //QList<QThread*> mThreads;
    QList<ScriptRunner*> mScripts;
    QMap<int, MapWindow*> mMapList;
    QMap<int, QString> mFileList;

};
class Block: public QWidget
{
    Q_OBJECT
public:
    Block(QWidget* parent):QWidget(parent){}
    int codeID;
};
#endif // MAINWINDOW_H

