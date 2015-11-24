/****************************************************************************
** Meta object code from reading C++ file 'UOTreeView.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../HardUO/UOTreeView.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'UOTreeView.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_UOTreeView_t {
    QByteArrayData data[7];
    char stringdata0[73];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UOTreeView_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UOTreeView_t qt_meta_stringdata_UOTreeView = {
    {
QT_MOC_LITERAL(0, 0, 10), // "UOTreeView"
QT_MOC_LITERAL(1, 11, 10), // "UpdateView"
QT_MOC_LITERAL(2, 22, 0), // ""
QT_MOC_LITERAL(3, 23, 19), // "onCustomContextMenu"
QT_MOC_LITERAL(4, 43, 5), // "point"
QT_MOC_LITERAL(5, 49, 11), // "onCopyIndex"
QT_MOC_LITERAL(6, 61, 11) // "onCopyValue"

    },
    "UOTreeView\0UpdateView\0\0onCustomContextMenu\0"
    "point\0onCopyIndex\0onCopyValue"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UOTreeView[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   34,    2, 0x0a /* Public */,
       3,    1,   35,    2, 0x09 /* Protected */,
       5,    0,   38,    2, 0x09 /* Protected */,
       6,    0,   39,    2, 0x09 /* Protected */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QPoint,    4,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void UOTreeView::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        UOTreeView *_t = static_cast<UOTreeView *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->UpdateView(); break;
        case 1: _t->onCustomContextMenu((*reinterpret_cast< const QPoint(*)>(_a[1]))); break;
        case 2: _t->onCopyIndex(); break;
        case 3: _t->onCopyValue(); break;
        default: ;
        }
    }
}

const QMetaObject UOTreeView::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_UOTreeView.data,
      qt_meta_data_UOTreeView,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *UOTreeView::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UOTreeView::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_UOTreeView.stringdata0))
        return static_cast<void*>(const_cast< UOTreeView*>(this));
    return QObject::qt_metacast(_clname);
}

int UOTreeView::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
