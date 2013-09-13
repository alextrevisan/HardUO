cast = true
medit = false
while true do
    if cast == true  then
        castArchProtection()
        wait(500)
    end
    if cast ~= true then
        useMeditation()
        wait(5000)
    end
    if UO.Mana < 10 then
        cast = false
    end
    if UO.Mana == UO.MaxMana then
        cast = true
    end
end
    
