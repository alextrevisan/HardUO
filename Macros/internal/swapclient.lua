SetTop(hnd, 0)
PushStrVal(hnd, "Get")
PushStrVal(hnd, "CliNr")
Execute(hnd)
local CliNr =  GetInteger(hnd, 1)

SetTop(hnd, 0);
PushStrVal(hnd, "Get");
PushStrVal(hnd, "CliCnt");
Execute(hnd);
local CliCnt = GetInteger(hnd, 1);
	
if CliNr<CliCnt then
	SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, CliNr+1);
    Execute(hnd);
else
	SetTop(hnd, 0);
    PushStrVal(hnd, "Set");
    PushStrVal(hnd, "CliNr");
    PushInteger(hnd, 1);
    Execute(hnd);
end