function key()
    spawn(function()
        while true do
            for _, instance in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
                    repeat
                        mainHandler = getsenv(instance)
                        game:GetService("RunService").Heartbeat:Wait()
                    until mainHandler.afflictstatus ~= nil
            
                    local upvalue = getupvalues(mainHandler.afflictstatus)
                    _G.serverKey = upvalue[16]
                    _G.playerKey = upvalue[17]
                end
            end
        wait(1)
        end
    end)
end
key()
