#ifndef SCOPEDLOCK_H
#define SCOPEDLOCK_H

#include <QMutex>

class ScopedLock
{
public:
    ScopedLock(QMutex* mutex);
    ~ScopedLock();
private:
    QMutex *mMutex;
};

#endif // SCOPEDLOCK_H
