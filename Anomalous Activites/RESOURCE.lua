function ESP()
    spawn(function()
        while true do
            spawn(function()
                for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetChildren()) do
                    if anomaly:IsA("Model") and not anomaly.Name == "demon" and not anomaly.Name == "hellwalker" then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = anomaly
                    else
                        return;
                    end
                end
            end)
        wait()
        end
    end)
end
game:GetService("Players").LocalPlayer.PlayerGui.mainGui.blackOverlay:destroy()
game:GetService("Players").LocalPlayer.PlayerGui.mainGui["death_screen"]:destroy()
local lobby = game:GetService("Workspace").lobby
local InfiniteJumpEnabled = true
local plr = game.Players.LocalPlayer.Character
local cf = Vector3.new(1, 1, 1)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Anomalous Activities", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("")
    Section:NewButton("ESP", "Scary monster.", function()
        ESP()
        print("executed")
    end)
    Section:NewButton("Hitbox Extender", "Big head", function()
        while true do
            for _, box in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Model") then
                    box.Head.Size =  Vector3.new(5, 5, 5)
                    box.Head.Transparency = 0.6
                    box.Head.CanCollide = false
                else 
                    return;
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
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("")
    Section:NewButton("Fly Jump", "Geppo BLOX FRUITS?? REAL", function()
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
            game.Lighting.ClockTime = 12
	    game.Lighting.Ambient = Color3.fromRGB(255,255,255)
	    game.Lighting.Brightness = 2
	    game.Lighting.FogColor = Color3.fromRGB(255,255,255)
            wait()
        end
    end)
    Section:NewButton("Lag fix", "removes unnecesscary objects", function()
	game:GetService("Players").LocalPlayer.PlayerGui.mainGui.blackOverlay:destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.mainGui["death_screen"]:destroy()
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
wait(1)
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
alert:Play()
