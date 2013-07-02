/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created: Tue 2. Jul 08:39:40 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../mainwindow.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainWindow[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      23,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x08,
      42,   11,   11,   11, 0x08,
      73,   11,   11,   11, 0x08,
     101,   11,   11,   11, 0x08,
     131,  127,   11,   11, 0x08,
     145,  127,   11,   11, 0x08,
     160,   11,   11,   11, 0x08,
     187,   11,   11,   11, 0x08,
     221,   11,   11,   11, 0x08,
     234,   11,   11,   11, 0x08,
     252,  250,   11,   11, 0x08,
     279,  273,   11,   11, 0x08,
     312,  273,   11,   11, 0x08,
     343,  273,   11,   11, 0x08,
     376,  273,   11,   11, 0x08,
     399,   11,   11,   11, 0x08,
     425,   11,   11,   11, 0x08,
     452,   11,   11,   11, 0x08,
     480,   11,   11,   11, 0x08,
     506,   11,   11,   11, 0x08,
     532,   11,   11,   11, 0x08,
     549,   11,   11,   11, 0x08,
     569,   11,   11,   11, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainWindow[] = {
    "MainWindow\0\0on_actionStop_F11_triggered()\0"
    "on_actionPause_F10_triggered()\0"
    "on_actionRun_F9_triggered()\0"
    "on_actionNovo_triggered()\0tab\0"
    "CloseTab(int)\0TabChange(int)\0"
    "on_actionAbrir_triggered()\0"
    "on_actionStop_All_F12_triggered()\0"
    "UpdateView()\0updateButtons()\0e\0"
    "changeEvent(QEvent*)\0event\0"
    "dragEnterEvent(QDragEnterEvent*)\0"
    "dragMoveEvent(QDragMoveEvent*)\0"
    "dragLeaveEvent(QDragLeaveEvent*)\0"
    "dropEvent(QDropEvent*)\0on_actionSwap_triggered()\0"
    "on_actionAbout_triggered()\0"
    "on_actionSkills_triggered()\0"
    "on_actionStep_triggered()\0"
    "on_actionSave_triggered()\0openRecentFile()\0"
    "openAllRecentFile()\0clearAllRecentFiles()\0"
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        MainWindow *_t = static_cast<MainWindow *>(_o);
        switch (_id) {
        case 0: _t->on_actionStop_F11_triggered(); break;
        case 1: _t->on_actionPause_F10_triggered(); break;
        case 2: _t->on_actionRun_F9_triggered(); break;
        case 3: _t->on_actionNovo_triggered(); break;
        case 4: _t->CloseTab((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->TabChange((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: _t->on_actionAbrir_triggered(); break;
        case 7: _t->on_actionStop_All_F12_triggered(); break;
        case 8: _t->UpdateView(); break;
        case 9: _t->updateButtons(); break;
        case 10: _t->changeEvent((*reinterpret_cast< QEvent*(*)>(_a[1]))); break;
        case 11: _t->dragEnterEvent((*reinterpret_cast< QDragEnterEvent*(*)>(_a[1]))); break;
        case 12: _t->dragMoveEvent((*reinterpret_cast< QDragMoveEvent*(*)>(_a[1]))); break;
        case 13: _t->dragLeaveEvent((*reinterpret_cast< QDragLeaveEvent*(*)>(_a[1]))); break;
        case 14: _t->dropEvent((*reinterpret_cast< QDropEvent*(*)>(_a[1]))); break;
        case 15: _t->on_actionSwap_triggered(); break;
        case 16: _t->on_actionAbout_triggered(); break;
        case 17: _t->on_actionSkills_triggered(); break;
        case 18: _t->on_actionStep_triggered(); break;
        case 19: _t->on_actionSave_triggered(); break;
        case 20: _t->openRecentFile(); break;
        case 21: _t->openAllRecentFile(); break;
        case 22: _t->clearAllRecentFiles(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData MainWindow::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow,
      qt_meta_data_MainWindow, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &MainWindow::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 23)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 23;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
