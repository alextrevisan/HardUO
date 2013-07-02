/****************************************************************************
** Meta object code from reading C++ file 'ScriptRunner.h'
**
** Created: Tue 2. Jul 08:39:54 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../ScriptRunner.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ScriptRunner.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ScriptRunner[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: signature, parameters, type, tag, flags
      18,   14,   13,   13, 0x05,
      36,   31,   13,   13, 0x05,
      47,   13,   13,   13, 0x05,
      57,   13,   13,   13, 0x05,
      66,   13,   13,   13, 0x05,

 // slots: signature, parameters, type, tag, flags
     101,   76,   13,   13, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_ScriptRunner[] = {
    "ScriptRunner\0\0log\0Log(QString)\0line\0"
    "Pause(int)\0Started()\0Paused()\0Stopped()\0"
    "keysDepressed,keyPressed\0"
    "KeyPressed(byte*,DWORD)\0"
};

void ScriptRunner::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ScriptRunner *_t = static_cast<ScriptRunner *>(_o);
        switch (_id) {
        case 0: _t->Log((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->Pause((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->Started(); break;
        case 3: _t->Paused(); break;
        case 4: _t->Stopped(); break;
        case 5: _t->KeyPressed((*reinterpret_cast< byte*(*)>(_a[1])),(*reinterpret_cast< DWORD(*)>(_a[2]))); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ScriptRunner::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ScriptRunner::staticMetaObject = {
    { &QThread::staticMetaObject, qt_meta_stringdata_ScriptRunner,
      qt_meta_data_ScriptRunner, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ScriptRunner::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ScriptRunner::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ScriptRunner::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ScriptRunner))
        return static_cast<void*>(const_cast< ScriptRunner*>(this));
    return QThread::qt_metacast(_clname);
}

int ScriptRunner::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QThread::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void ScriptRunner::Log(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ScriptRunner::Pause(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void ScriptRunner::Started()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void ScriptRunner::Paused()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void ScriptRunner::Stopped()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
