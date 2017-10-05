
function Relogin(password)
        if UO.ContName == "waiting gump" or UO.ContName == "MainMenu gump" then
            UO.Click(398, 329, true, true, true, false)
            wait(200)
            if UO.ContName == "MainMenu gump" then
                UO.Click(374, 400, true, true, true, false)
                UO.Msg(password)
                wait(200)
                UO.Click(614, 448, true, true, true, false)
                wait(1000)
                while UO.ContName == "waiting gump" do
                    UO.Click(314, 354, true, true, true, false)
                    wait(200)
                    UO.Click(614, 448, true, true, true, false)
                    wait(1000)
                end
                UO.Click(614, 448, true, true, true, false)
                wait(1000)
                UO.Click(614, 448, true, true, true, false)
            end
        end
        wait(1000)
end