#include "mapwindow.h"
#include "ui_mapwindow.h"
#include <QImage>
#include <QMouseEvent>
#include <QPainter>
#include <QBrush>
#include <QDebug>
#include <QTimer>
#include <QInputDialog>

#include <windows.h>

MapWindow::MapWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MapWindow)
{
    ui->setupUi(this);
    setWindowFlags( Qt::CustomizeWindowHint );
    mFindLocation = false;
    mImageMap = new QImage("MAP0-1.png");

    QSize size = centralWidget()->size();
    int posX = 2560-size.width()/2;
    int posY = 494-size.height()/2;
    mPixMap = QPixmap::fromImage(*mImageMap).copy(posX, posY, size.width(), size.height() );
    moving = false;
    setMouseTracking(false);
    QTimer *t = new QTimer(this);
    t->setInterval(500);
    connect(t, SIGNAL(timeout()), this, SLOT(updateMap()));
    mLocX = mLocY = 0;
    t->start();
}

void MapWindow::setPosition(int x, int y)
{
    mCurrentX = x;
    mCurrentY = y;
}

void MapWindow::createLine(const QLine &line, int lineID, const QColor &color)
{
    mLines[lineID] = line;
    mLinesColor[lineID] = color;
    mLastX = -1;
}

void MapWindow::removeLine(int lineID)
{
    mLines.remove(lineID);
    mLinesColor.remove(lineID);
    mLastX = -1;
}

void MapWindow::removeAllLines()
{
    mLines.clear();
    mLinesColor.clear();
    mLastX = -1;
}


void MapWindow::mousePressEvent(QMouseEvent *event)
{
    //MainWindow::mousePressEvent(event);
    if((event->button() == Qt::LeftButton)) {
        moving = true;
        offset = event->pos();
    }
}

void MapWindow::mouseMoveEvent(QMouseEvent *event)
{
    //MainWindow::mouseMoveEvent(event);
    if(moving)
        this->move(event->globalPos() - offset);
}

void MapWindow::mouseReleaseEvent(QMouseEvent *event)
{
    //MainWindow::mouseReleaseEvent(event);
    if(event->button() == Qt::LeftButton) {
        moving = false;
    }
}

void MapWindow::paintEvent(QPaintEvent *pe)
{
    Q_UNUSED(pe)
    //pix.copy(posX, posY, size.width(), size.height() );
    //QPixmap::copy(int x, int y, int width, int height )
    QPainter pPainter(this);
    pPainter.drawPixmap(rect(),mPixMap);

}

void MapWindow::wheelEvent(QWheelEvent *event)
{
    if(event->delta()>0)
    {
        mMapSize =  mMapSize / 2;
    }
    else
    {
        mMapSize = mMapSize * 2;
    }
    mLastX = -1;
}

void MapWindow::mouseDoubleClickEvent (QMouseEvent * event)
{
    Q_UNUSED(event)
    ui->actionHide_Border->setChecked(!ui->actionHide_Border->isChecked());
    on_actionHide_Border_triggered();
}

void MapWindow::resizeEvent(QResizeEvent* event)
{
    Q_UNUSED(event);
    mMapSize = centralWidget()->size();
    mLastX = -1;
}

void MapWindow::updateMap()
{
    /*static int hnd = Open();

    SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, 1);
    Execute(hnd);

    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharPosX");
    Execute(hnd);
    mCurrentX =  GetInteger(hnd, 1);

    SetTop(hnd, 0);
    PushStrVal(hnd, "Get");
    PushStrVal(hnd, "CharPosY");
    Execute(hnd);
    mCurrentY = GetInteger(hnd, 1);*/


    int posX = mCurrentX-mMapSize.width()/2;
    int posY = mCurrentY-mMapSize.height()/2;
    bool repaintText = false;
    if(mLastX != mCurrentX || mLastY != mCurrentY)
    {
        mPixMap =  QPixmap::fromImage(*mImageMap).copy(posX, posY, mMapSize.width(), mMapSize.height() );
        mLastX = mCurrentX;
        mLastY = mCurrentY;
        repaintText = true;
    }
    static bool color = true;


    QPainter painter( &mPixMap );
    //painter.setRenderHint( QPainter::Antialiasing );
    if(repaintText)
    {
        painter.setPen( Qt::green );
        painter.drawText(0,30, QString("%1,%2").arg(mCurrentX).arg(mCurrentY));
    }

    if(color)
    {
        painter.setPen( Qt::white );
    }
    else
    {
        painter.setPen( Qt::gray );
    }
    color = !color;

    painter.drawEllipse( mMapSize.width()/2-3, mMapSize.height()/2-3, 6, 6 );
    //painter.drawEllipse( mMapSize.width()/2-1, mMapSize.height()/2-1, 2, 2 );
    painter.drawPoint(mMapSize.width()/2, mMapSize.height()/2);

    /*if(mFindLocation)
    {
        painter.setPen( Qt::yellow );
        painter.drawLine(mMapSize.width()/2, mMapSize.height()/2,mLocX-mCurrentX+mMapSize.width()/2,mLocY-mCurrentY+mMapSize.height()/2);
    }*/

    foreach(QLine line, mLines)
    {
        qDebug()<<"imprimindo linha id";
        painter.setPen( Qt::yellow );
        painter.drawLine(line.x1()-mCurrentX+mMapSize.width()/2,line.y1()-mCurrentY+mMapSize.height()/2,line.x2()-mCurrentX+mMapSize.width()/2,line.y2()-mCurrentY+mMapSize.height()/2);
    }

    repaint();
}

MapWindow::~MapWindow()
{
    delete ui;
}

void MapWindow::on_actionAlways_On_Top_triggered()
{
    if (ui->actionAlways_On_Top->isChecked())
    {
        SetWindowPos((HWND)this->winId(), HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
    }
    else
    {
        SetWindowPos((HWND)this->winId(), HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
    }
    show();
}

void MapWindow::on_actionHide_Border_triggered()
{
    if(ui->actionHide_Border->isChecked())
    {
        setWindowFlags(Qt::FramelessWindowHint);
    }
    else
    {
        setWindowFlags( Qt::CustomizeWindowHint );
    }
    if (ui->actionAlways_On_Top->isChecked())
    {
        SetWindowPos((HWND)this->winId(), HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
    }
    show();
}

void MapWindow::on_actionExit_triggered()
{
    this->close();
}

void MapWindow::on_actionFind_Location_triggered()
{
    QString text = QInputDialog::getText(this, tr("Find Location"),
                                        tr("Location - format: 0,0"), QLineEdit::Normal,
                                         QString("%1,%2").arg(mLocX).arg(mLocY), &mFindLocation);
    QStringList numbers;
    if (mFindLocation && !text.isEmpty())
    {
        numbers = text.split(",");
        if(numbers.size()==2)
        {
            mLocX = numbers.at(0).toInt();
            mLocY = numbers.at(1).toInt();
        }
        else
        {
            mFindLocation = false;
            mLastX = -1;
        }
    }
    else
    {
        mLocX = mCurrentX;
        mLocY = mCurrentY;
    }
}
