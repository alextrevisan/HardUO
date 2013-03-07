#include "SystemKeyboardReadWrite.h"
#include <QDebug>

SystemKeyboardReadWrite* SystemKeyboardReadWrite::uniqueInstance = 0;

SystemKeyboardReadWrite::SystemKeyboardReadWrite() :
    QObject()
{
    // Assign to null
    keyboardHook = NULL;
}

SystemKeyboardReadWrite::~SystemKeyboardReadWrite()
{
    delete uniqueInstance;
}

LRESULT CALLBACK SystemKeyboardReadWrite::keyboardProcedure(int nCode, WPARAM wParam, LPARAM lParam)
{
    // Check for a key down press
    if (nCode == HC_ACTION)
    {
        if (wParam == WM_KEYDOWN)
        {
            KBDLLHOOKSTRUCT *pKeyboard = (KBDLLHOOKSTRUCT*)lParam;

            byte *keysDepressed;

            keysDepressed = new byte[numberKeys];

            if(GetKeyboardState(keysDepressed))
            {
                // Broadcasts signal
                emit SystemKeyboardReadWrite::instance()->keyPressed(keysDepressed, pKeyboard->vkCode);
                //qDebug()<<pKeyboard->vkCode;
            }

        }
        else if (wParam == WM_KEYUP)
        {

        }

    }

    return false;
}

bool SystemKeyboardReadWrite::connected()
{
    return keyboardHook;
}

bool SystemKeyboardReadWrite::setConnected(bool state)
{
    if(state)
    {
        keyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, keyboardProcedure, GetModuleHandle(NULL), 0);

        return keyboardHook;
    }
    else
    {
        UnhookWindowsHookEx(keyboardHook);
        keyboardHook = NULL;

        return keyboardHook;
    }
}

SystemKeyboardReadWrite* SystemKeyboardReadWrite::instance()
{
    if(uniqueInstance == NULL)
    {
        uniqueInstance = new SystemKeyboardReadWrite();
    }
    return uniqueInstance;
}
