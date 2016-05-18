SetTop(hnd, 0)
PushStrVal(hnd, "Get")
PushStrVal(hnd, "CliNr")
Execute(hnd)
__CurrentCliNr__ =  GetInteger(hnd, 1)

SetTop(hnd, 0);
PushStrVal(hnd, "Get");
PushStrVal(hnd, "CliCnt");
Execute(hnd);
local CliCnt = GetInteger(hnd, 1);
	
if __CurrentCliNr__<CliCnt then
	SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, __CurrentCliNr__+1);
    Execute(hnd);
	__CurrentCliNr__ = __CurrentCliNr__ + 1
else
	SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, 1);
    Execute(hnd);
	__CurrentCliNr__ = 1
end