/****************************************************************************
** Meta object code from reading C++ file 'SystemKeyboardReadWrite.h'
**
** Created: Tue 2. Jul 08:40:17 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../SystemKeyboardReadWrite.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'SystemKeyboardReadWrite.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_SystemKeyboardReadWrite[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      50,   25,   24,   24, 0x05,

       0        // eod
};

static const char qt_meta_stringdata_SystemKeyboardReadWrite[] = {
    "SystemKeyboardReadWrite\0\0"
    "keysDepressed,keyPressed\0"
    "keyPressed(byte*,DWORD)\0"
};

void SystemKeyboardReadWrite::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        SystemKeyboardReadWrite *_t = static_cast<SystemKeyboardReadWrite *>(_o);
        switch (_id) {
        case 0: _t->keyPressed((*reinterpret_cast< byte*(*)>(_a[1])),(*reinterpret_cast< DWORD(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData SystemKeyboardReadWrite::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject SystemKeyboardReadWrite::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_SystemKeyboardReadWrite,
      qt_meta_data_SystemKeyboardReadWrite, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &SystemKeyboardReadWrite::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *SystemKeyboardReadWrite::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *SystemKeyboardReadWrite::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_SystemKeyboardReadWrite))
        return static_cast<void*>(const_cast< SystemKeyboardReadWrite*>(this));
    return QObject::qt_metacast(_clname);
}

int SystemKeyboardReadWrite::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 1)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    }
    return _id;
}

// SIGNAL 0
void SystemKeyboardReadWrite::keyPressed(byte * _t1, DWORD _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
