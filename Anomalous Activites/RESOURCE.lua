repeat 
    wait() 
until game:IsLoaded()
wait(1)
local lobby = game:GetService("Workspace").lobby
local tk = false
local InfiniteJumpEnabled = true
local plr = game.Players.LocalPlayer.Character
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Anomalous Activities", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("")
    Section:NewButton("ESP", "Scary monster.", function()
        while true do
            spawn(function()
                for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetChildren()) do
                    if anomaly:IsA("Model") then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = anomaly
                        wait(2)
                        highlight:destroy()
                    else
                    end
                end
            end)
        wait()
        end
    end)
    Section:NewButton("Hitbox Extender", "Big head", function()
        while true do
            for _, box in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Part") and box.Name == "Head" then
                    box.Size =  Vector3.new(5, 5, 5)
                    box.Transparency = 0.6
                    box.CanCollide = false
                else 
                    
                end
            end
        wait()
        end
    end)
    Section:NewButton("TeamKill", "OMG IMPOSTOR !!!", function()
        while true do 
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character.Parent == game.Workspace.mainGame["active_humans"] and player ~= game.Players.LocalPlayer then
                    player.Character.Parent = game.Workspace.mainGame["active_firing_range"]
                end
            end
        wait()
        end
    end)
    Section:NewToggle("TeamKill", "", function(state)
        if state then
            tk = true
            while tk == true do 
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character.Parent == game.Workspace.mainGame["active_humans"] and player ~= game.Players.LocalPlayer then
                        player.Character.Parent = game.Workspace.mainGame["active_firing_range"]
                    end
                end
            wait()
            end
        else
	    tk = false
            while tk == false do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player.Character.Parent == game.Workspace.mainGame["active_firing_range"] and player ~= game.Players.LocalPlayer then
                        player.Character.Parent = game.Workspace.mainGame["active_humans"]
                    end
                end
            wait()
            end
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
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("")
    Section:NewButton("Fly Jump", "   T   ", function()
        while true do
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 20
            wait()
        end
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
	        if InfiniteJumpEnabled then
		        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	        end
        end)
    end)
    Section:NewButton("No Fog", "Removes fog.", function()
        while true do 
            game.Lighting.FogEnd = 1000000
            game.Lighting.GlobalShadows = false
            wait()
        end
    end)
    Section:NewButton("Always Day", "Brightness.", function()
        while true do
	    game.Lighting.Ambient = Color3.fromRGB(255,255,255)
	    game.Lighting.FogColor = Color3.fromRGB(255,255,255)
            wait()
        end
    end)
    Section:NewButton("Lag fix", "removes unnecesscary objects", function()
        game.Workspace.MedicalStuff:destroy()
        for _, effects in pairs(game:GetService("ReplicatedStorage")["misc_effects"]:GetChildren()) do
            if effects:IsA("ParticleEmitter") or effects:IsA("Part") or effects:IsA("Part") then
                effects:destroy()
            end
        end
        for _,effect in pairs(game.ReplicatedStorage["weapon_effect"]:GetChildren()) do
            effect:Destroy()
        end
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
    Section:NewKeybind("Right Ctrl to close GUI", "", Enum.KeyCode.RightControl, function()
	    Library:ToggleUI()
    end)
    alert:Play()
