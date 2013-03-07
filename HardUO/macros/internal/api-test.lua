print("testing SysMessage")
SysMessage("testing SysMessage")

if Ar() <= 0 then
    print("warning: zero value - Ar()")
end
if Hits() <= 0 then
    print("warning: zero value - Hits()")
end
if MaxHits() <= 0 then
    print("warning: zero value - MaxHits()")
end
if Mana() <= 0 then
    print("warning: zero value - Mana()")
end
if BackpackID() <= 0 then
    print("warning: zero value - BackpackID()")
end
if CharPosX() <= 0 then
    print("warning: zero value - CharPosX()")
end
if CharPosY() <= 0 then
    print("warning: zero value - CharPosY()")
end
if CharPosZ() <= 0 then
    print("warning: zero value - CharPosZ()")
end
if #CharName() <= 0 then
    print("warning: zero value - CharName()")
end
if Weight() <= 0 then
    print("warning: zero value - Weight()")
end
if MaxWeight() <= 0 then
    print("warning: zero value - MaxWeight()")
end
--if WarPeace() <= 0 then
--    print("warning: zero value - WarPeace()")
--end

print("your char should changing to War/Peace in..")
SysMessage("your char should changing to War/Peace in..")
print("3")
SysMessage("3")
wait(1000)
print("2")
SysMessage("2")
wait(1000)
print("1")
SysMessage("1")
wait(1000)
WarPeace()

print("your char should returning to War/Peace in..")
SysMessage("your char should returning to War/Peace in..")
print("3")
SysMessage("3")
wait(1000)
print("2")
SysMessage("2")
wait(1000)
print("1")
SysMessage("1")
wait(1000)
WarPeace()

print("your char should speak 'Hello' in..")
SysMessage("your char should speak 'Hello' in..")
print("3")
SysMessage("3")
wait(1000)
print("2")
SysMessage("2")
wait(1000)
print("1")
SysMessage("1")
wait(1000)
Speak("Hello")

print("your char should move 1 tile in..")
SysMessage("your char should move 1 tile in..")
print("3")
SysMessage("3")
wait(1000)
print("2")
SysMessage("2")
wait(1000)
print("1")
SysMessage("1")
wait(1000)
Move(CharPosX()+1,CharPosY(), CharPosZ(), 5000)
