#ifndef SCRIPTRUNNER_H
#define SCRIPTRUNNER_H

#include <QThread>
#include <QMap>
#include <QLine>
#include "uo.h"
#include "mapwindow.h"

class ScriptRunner : public QThread
{
    Q_OBJECT
public:
    ScriptRunner(int cliNr, int tabIndex, const QString &script);
    void configure();
    void setScript(const QString& script);
    void stop();
    void swapClient();
signals:
    void finished();
    void updateButtonsFinished(int tabIndex);
    void print(int tabIndex,const QString& value);
protected:
    void run();
private:
    int mCliNr;
    int mTabIndex;
    QString mScript;
    lua_State *L;
};
class Log : public QObject
{
    Q_OBJECT
public:
    static Log* getInstance()
    {
        return mInstance;
    }

    void append(int tabIndex, const QString& string)
    {
        emit textChanged(tabIndex,string);
    }

    QMap<int,bool> isPaused;
signals:
    void textChanged(int tabIndex, const QString& text);
private:
    static Log* mInstance;

};

class Map:  public QObject
{
    Q_OBJECT
public:
    static Map& getInstance()
    {
        return mInstance;
    }

    void show(int tabIndex)
    {
        emit showMap(tabIndex);
    }
    void hide(int tabIndex)
    {
        emit hideMap(tabIndex);
    }
    void setPosition(int tabIndex, int x, int y)
    {
        emit setPositionMap(tabIndex, x, y);
    }
    void createLine(int tabIndex, const QLine& line, int lineID, const QColor& color = Qt::yellow)
    {
        emit createLineMap(tabIndex, line, lineID, color);
    }
    void removeLine(int tabIndex, int lineID)
    {
        emit removeLineMap(tabIndex,lineID);
    }
    void removeAllLines(int tabIndex)
    {
        emit removeAllLinesMap(tabIndex);
    }
signals:
    void showMap(int tabIndex);
    void hideMap(int tabIndex);
    void setPositionMap(int tabIndex, int x, int y);
    void createLineMap(int tabIndex, const QLine& line, int lineID, const QColor& color);
    void removeLineMap(int tabIndex, int lineID);
    void removeAllLinesMap(int tabIndex);
private:
    static Map mInstance;

};

class AutoComplete
{
public:
    static QStringList autoCompleteList;
};

#endif // SCRIPTRUNNER_H

