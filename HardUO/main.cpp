#include <QtGui/QApplication>
#include "mainwindow.h"
#include <QSplashScreen>
#include <QPixmap>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QPixmap pixmap(":/icon/icons/uo.png");
    QSplashScreen splash(pixmap);
    splash.show();

    MainWindow w;
    w.show();

    splash.finish(&w);

    return a.exec();
}
