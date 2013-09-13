#ifndef MAPWINDOW_H
#define MAPWINDOW_H

#include <QMainWindow>
#include <QMap>
#include <QLine>
#include <QColor>

namespace Ui {
class MapWindow;
}

class MapWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MapWindow(QWidget *parent = 0);
    void setPosition(int x, int y);
    void createLine(const QLine& line, int lineID, const QColor& color);
    void removeLine(int lineID);
    void removeAllLines();

    ~MapWindow();

private:
    Ui::MapWindow *ui;
    QPoint offset;
    bool moving;
    QImage* mImageMap;
    QPainter* mPainter;
    QPixmap mPixMap;
    QSize mMapSize;
    //bool mShowCircle;
    int mLocX,mLocY;
    int mCurrentX, mCurrentY;
    int mLastX,mLastY;
    bool mFindLocation;
    QMap<int, QLine> mLines;
    QMap<int, QColor> mLinesColor;

protected:
    void paintEvent(QPaintEvent *pe);
    void resizeEvent(QResizeEvent* event);
    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void wheelEvent(QWheelEvent* event);
    void mouseDoubleClickEvent (QMouseEvent * event);

private slots:
    void on_actionAlways_On_Top_triggered();
    void on_actionExit_triggered();
    void on_actionHide_Border_triggered();
    void updateMap();
    void on_actionFind_Location_triggered();
};

#endif // MAPWINDOW_H
