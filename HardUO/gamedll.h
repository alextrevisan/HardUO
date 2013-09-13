#ifndef _UODLL_H
#define _UODLL_H

#include <stdio.h>
#include <windows.h>

extern "C" {

    typedef int uo_int32;
    typedef double uo_float64;

    void (__stdcall *Clean)(uo_int32 hnd) = 0;
    void (__stdcall *Close)(uo_int32 hnd) = 0;
    uo_int32 (__stdcall *Execute)(uo_int32 hnd) = 0;
    uo_int32 (__stdcall *GetBoolean)(uo_int32 hnd, uo_int32 index) = 0;
    uo_float64 (__stdcall *GetDouble)(uo_int32 hnd, uo_int32 index) = 0;
    uo_int32 (__stdcall *GetInteger)(uo_int32 hnd, uo_int32 index) = 0;
    void* (__stdcall *GetPointer)(uo_int32 hnd, uo_int32 index) = 0;
    char* (__stdcall *GetString)(uo_int32 hnd, uo_int32 index) = 0;
    uo_int32 (__stdcall *GetTop)(uo_int32 hnd) = 0;
    uo_int32 (__stdcall *GetType)(uo_int32 hnd, uo_int32 index) = 0;
    void (__stdcall *Insert)(uo_int32 hnd, uo_int32 index) = 0;
    void (__stdcall *Mark)(uo_int32 hnd) = 0;
    uo_int32 (__stdcall *Open)() = 0;
    void (__stdcall *PushBoolean)(uo_int32 hnd, uo_int32 value) = 0;
    void (__stdcall *PushDouble)(uo_int32 hnd, uo_float64 value) = 0;
    void (__stdcall *PushInteger)(uo_int32 hnd, uo_int32 value) = 0;
    void (__stdcall *PushNil)(uo_int32 hnd) = 0;
    void (__stdcall *PushPointer)(uo_int32 hnd, void* value) = 0;
    void (__stdcall *PushPtrOrNil)(uo_int32 hnd, void* value) = 0;
    void (__stdcall *PushStrRef)(uo_int32 hnd, char* value) = 0;
    void (__stdcall *PushStrVal)(uo_int32 hnd, char* value) = 0;
    void (__stdcall *PushValue)(uo_int32 hnd, uo_int32 index) = 0;
    uo_int32 (__stdcall *Query)(uo_int32 hnd) = 0;
    void (__stdcall *Remove)(uo_int32 hnd, uo_int32 index) = 0;
    void (__stdcall *SetTop)(uo_int32 hnd, uo_int32 index) = 0;
    uo_int32 (__stdcall *Version)() = 0;

    HMODULE uoDllHandle = 0;


    int initUoDll(char *dllName)
    {
        if(dllName == 0)
            uoDllHandle = LoadLibrary(L"uo.dll");
        else
            uoDllHandle = LoadLibrary((WCHAR*)dllName);
        if(uoDllHandle == 0)
            return 0;

        Clean = (void (__stdcall*)(uo_int32 hnd))GetProcAddress(uoDllHandle, "Clean");
        if(Clean == 0)
            return 0;

        Close = (void (__stdcall*)(uo_int32 hnd))GetProcAddress(uoDllHandle, "Close");
        if(Close == 0)
            return 0;

        Execute = (uo_int32 (__stdcall *)(uo_int32 hnd))GetProcAddress(uoDllHandle, "Execute");
        if(Execute == 0)
            return 0;

        GetBoolean = (uo_int32 (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetBoolean");
        if(GetBoolean == 0)
            return 0;

        GetDouble = (uo_float64 (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetDouble");
        if(GetDouble == 0)
            return 0;

        GetInteger = (uo_int32 (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetInteger");
        if(GetInteger == 0)
            return 0;

        GetPointer = (void* (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetPointer");
        if(GetPointer == 0)
            return 0;

        GetString = (char* (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetString");
        if(GetString == 0)
            return 0;

        GetTop = (uo_int32 (__stdcall *)(uo_int32 hnd))GetProcAddress(uoDllHandle, "GetTop");
        if(GetTop == 0)
            return 0;

        GetType = (uo_int32 (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "GetType");
        if(GetType == 0)
            return 0;

        Insert = (void (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "Insert");
        if(Insert == 0)
            return 0;

        Mark = (void (__stdcall *)(uo_int32 hnd))GetProcAddress(uoDllHandle, "Mark");
        if(Mark == 0)
            return 0;

        Open = (uo_int32 (__stdcall *)())GetProcAddress(uoDllHandle, "Open");
        if(Open == 0)
            return 0;

        PushBoolean = (void (__stdcall *)(uo_int32 hnd, uo_int32 value))GetProcAddress(uoDllHandle, "PushBoolean");
        if(PushBoolean == 0)
            return 0;

        PushDouble = (void (__stdcall *)(uo_int32 hnd, uo_float64 value))GetProcAddress(uoDllHandle, "PushDouble");
        if(PushDouble == 0)
            return 0;

        PushInteger = (void (__stdcall *)(uo_int32 hnd, uo_int32 value))GetProcAddress(uoDllHandle, "PushInteger");
        if(PushInteger == 0)
            return 0;

        PushNil = (void (__stdcall *)(uo_int32 hnd))GetProcAddress(uoDllHandle, "PushNil");
        if(PushNil == 0)
            return 0;

        PushPointer = (void (__stdcall *)(uo_int32 hnd, void* value))GetProcAddress(uoDllHandle, "PushPointer");
        if(PushPointer == 0)
            return 0;

        PushPtrOrNil = (void (__stdcall *)(uo_int32 hnd, void* value))GetProcAddress(uoDllHandle, "PushPtrOrNil");
        if(PushPtrOrNil == 0)
            return 0;

        PushStrRef = (void (__stdcall *)(uo_int32 hnd, char* value))GetProcAddress(uoDllHandle, "PushStrRef");
        if(PushStrRef == 0)
            return 0;

        PushStrVal = (void (__stdcall *)(uo_int32 hnd, char* value))GetProcAddress(uoDllHandle, "PushStrVal");
        if(PushStrVal == 0)
            return 0;

        PushValue = (void (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "PushValue");
        if(PushValue == 0)
            return 0;

        Query = (uo_int32 (__stdcall *)(uo_int32 hnd))GetProcAddress(uoDllHandle, "Query");
        if(Query == 0)
            return 0;

        Remove = (void (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "Remove");
        if(Remove == 0)
            return 0;

        SetTop = (void (__stdcall *)(uo_int32 hnd, uo_int32 index))GetProcAddress(uoDllHandle, "SetTop");
        if(SetTop == 0)
            return 0;

        Version = (uo_int32 (__stdcall *)())GetProcAddress(uoDllHandle, "Version");
        if(Version == 0)
            return 0;

        return 1;
    }

    int DeinitWrapper()
    {
        if(uoDllHandle != 0)
            FreeLibrary(uoDllHandle);
        return 1;
    }

    int InitWrapper()
    {
        int ret = initUoDll(0);
        if( ret == 0)
            printf("Erro ao inicializar a DLL (nao encontrada)\n");
        return ret;
    }

}
#endif // _UODLL_H
