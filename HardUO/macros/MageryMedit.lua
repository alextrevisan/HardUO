while 1 do
    while Mana()<MaxMana() do
        useMeditation()
        wait(4000)
    end
    castHeal()
    WaitTarget()
    wait(200)
    TargetSelf()
    wait(2000)
    castHeal()
    WaitTarget()
    wait(200)
    TargetSelf()
    wait(2000)
end