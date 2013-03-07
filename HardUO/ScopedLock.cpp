#include "ScopedLock.h"

ScopedLock::ScopedLock(QMutex* mutex)
    :mMutex(mutex)
{
    mMutex->lock();
}
ScopedLock::~ScopedLock()
{
    mMutex->unlock();
}
