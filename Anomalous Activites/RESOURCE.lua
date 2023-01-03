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
local mgame = game.Workspace.mainGame
local InfiniteJumpEnabled = true
local plr = game.Players.LocalPlayer
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
            for _, box in pairs(mgame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Part") and box.Name == "Head" then
                    box.Size =  Vector3.new(5, 5, 5)
                    box.Transparency = 0.6
                    box.CanCollide = false
                end
            end
        wait()
        end
    end)
    Section:NewButton("TeamKill", "IN DEV", function() 
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= plr.Character and player.Character.Parent == mgame["active_humans"] then
                player.Parent = mgame["active_anomaly"]
            end
        end
    end)
    Section:NewButton("Infinite Jump", "Scary monster.", function()
        game:GetService("UserInputService").JumpRequest:connect(function()
	        if InfiniteJumpEnabled then
		        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	        end
        end)
    end)
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("Some features may make your game looks shitty")
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
        game.Workspace.MedicalStuff:destroy()
        game.Workspace.Posters:destroy()
    end)
    Section:NewKeybind("Right Ctrl", "nigger", Enum.KeyCode.RightControl, function()
	    Library:ToggleUI()
    end)
