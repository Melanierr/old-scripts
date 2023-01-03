function ESP()
    spawn(function()
        while true do
            spawn(function()
                for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetChildren()) do
                    if anomaly:IsA("Model")  then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = anomaly.Head
                    else
                        warn("Not a player or a minion")
                    end
                end
            end)
        wait()
        end
    end)
end
local lobby = game:GetService("Workspace").lobby
local InfiniteJumpEnabled = true
local plr = game.Players.LocalPlayer.Character
local cf = Vector3.new(1, 1, 1)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Anomalous Activities", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("")
    Section:NewButton("No Fog", "Removes fog.", function()
        while true do 
            game.Lighting.FogEnd = 1000000
            game.Lighting.GlobalShadows = false
            wait()
        end
    end)
    Section:NewButton("Always Day", "Brightness.", function()
        while true do
            game.Lighting.Brightness = 3
            game.Lighting.ClockTime = 12
            
            wait()
        end
    end)
    Section:NewButton("ESP", "Scary monster.", function()
        ESP()
        print("executed")
    end)
    Section:NewButton("Hitbox Extender", "Big head", function()
        while true do
            for _, box in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Part") and box.Name == "Head" then
                    box.Size =  Vector3.new(5, 5, 5)
                    box.Transparency = 0.6
                    box.CanCollide = false
                end
            end
        wait()
        end
    end)
    Section:NewButton("Instant Anchor ( F key )", "", function()
        game:GetService("UserInputService").InputBegan:Connect(function(Key)
            if Key.KeyCode == Enum.KeyCode.F then -- put your custom key here
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]= workspace.CurrentMap.Interactables.A })
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]= workspace.CurrentMap.Interactables.B })
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]= workspace.CurrentMap.Interactables.C })
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]= workspace.CurrentMap.Interactables.D })
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]= workspace.CurrentMap.Interactables.E })
            end
        end)
    end)
    Section:NewButton("Lag fix", "removes unnecesscary objects", function()
        for _, object in pairs(lobby:GetChildren()) do
            if object.Name == "lights" or object.Name == "corrodedbit" then
                object:destroy()
            end
        end
        for _, material in pairs(lobby:GetChildren()) do
            if material.Name == "Block" then
                material.Material = "Plastic"
                material.Color = Color3.new(163, 162, 165)
            end
        end
    end)
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
alert:Play()
