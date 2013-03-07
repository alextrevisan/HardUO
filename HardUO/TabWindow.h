#ifndef TABWINDOW_H
#define TABWINDOW_H

#include <QWidget>
#include <QCompleter>
#include <QVBoxLayout>
#include "CodeArea.h"
#include "ScriptRunner.h"
#include <QObject>
#include "ScopedLock.h"

class TabWindow: public QWidget
{
    Q_OBJECT

public:
    explicit TabWindow(QWidget *parent = 0);
    ~TabWindow();
    TabWindow(QString & script);
    void SetCompleter(QCompleter *completer);
    QPlainTextEdit* TextEdit(){return completingTextEdit;}
    void SetFileName(const QString& name);
    QString GetFileName();
    void Start();
    void Pause();
    void Stop();
    void Save();
    bool InStep(){if(mRunner)return mRunner->InStep();else return false;}
    void Step(bool step = true){if(mRunner)mRunner->Step(step);}
    void UpdateView();
    int Status();
    void SwapClient();
    int CliNr();
    QString CharName();
private:
    QVBoxLayout *mLayout;
    CodeArea* completingTextEdit;
    QTextEdit* logText;
    ScriptRunner *mRunner;
    QString lastString;
    UO* mUO;
    static UO* UOUpadeView;
    int mStatus;
    QString mCharName;
    int mCliNr;
    QMutex mMutex;
    QString mFileName;

private slots:
    void OnLog(const QString& log);
    void OnPause(int line);
    void OnStart();
    void OnStop();

};

#endif // TABWINDOW_H
