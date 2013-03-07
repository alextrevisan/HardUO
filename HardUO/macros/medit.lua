while true do
        while Mana()<MaxMana() do
          useMeditation()
          wait(1000)
        end
    wait(3500)
    castCreateFood()
    WaitTarget()
    TargetSelf()
end