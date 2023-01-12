repeat wait() until game:IsLoaded()
if game:IsLoaded() and game.PlaceId == 8770868695 then
local lobby = game:GetService("Workspace").lobby
local anti = false
local tk = false
local newtk = false
local cam = false
local noclip = false
local squad = game:GetService("ReplicatedStorage")["sound_library"].music.squad
local announce = game:GetService("ReplicatedStorage")["sound_library"].music.black
local squadscreen= game:GetService("ReplicatedStorage")["misc_effects"]["squad_screen"]
local plr = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.PlayerGui.mainGui.blackOverlay.Visible = false
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Anomalous Activities [MERCs only]", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("")
    Section:NewButton("NVG ( C key )", "execute once", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anomalous%20Activites/NVG.lua"))()
    end)
    Section:NewButton("Hitbox Extender", "Big head", function()
        while true do
            spawn(function()
            for _, box in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Part") and box.Name == "Head" then
                    box.Size =  Vector3.new(5, 5, 5)
                    box.Transparency = 0.6
                    box.CanCollide = false
                else 
                end
            end
            end)
        wait()
        end
    end)
    Section:NewToggle("TeamKill", " S U S ", function(state)
        if state then
            tk = true
            while tk == true do
                for _, player in pairs(game.Players:GetPlayers()) do
			        if player ~= game.Players.LocalPlayer and player.Character.Parent ~= game.Workspace.mainGame["active_anomaly"] then
				        player.Character.Parent = game.Workspace.mainGame["active_anomaly"]
			        end
		        end
            wait()
            end
        else
            tk = false
            while tk == false do
                for _, player in pairs(game.Players:GetPlayers()) do
			        if player ~= game.Players.LocalPlayer and player.Character.Parent == game.Workspace.mainGame["active_anomaly"]then
				        player.Character.Parent = game.Workspace.mainGame["active_humans"]
			        end
		        end
            wait()
            end
        end
    end)
    Section:NewToggle("New TK ( test )", " S U S ", function(state)
        if state then
            newtk = true
            while newtk == true do
				plr.Parent = game.Workspace.mainGame["active_anomaly"]
            wait()
            end
        else
            newtk = false
            while newtk == false do
                plr.Parent = game.Workspace.mainGame["active_humans"]
            wait()
            end
        end
    end)
    Section:NewButton("Instant Anchor", "", function()
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
local Tab = Window:NewTab("Player")
local Section = Tab:NewSection("")
    Section:NewButton("ESP", "Scary monster.", function()
        while true do
            spawn(function()
                for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetChildren()) do
                    if anomaly:IsA("Model") then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = anomaly
                        wait()
                        highlight:destroy()
                    else
                    end
                end
            end)
        wait()
        end
    end)
    Section:NewButton("Fly Jump", "   T   ", function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
	        if InfiniteJumpEnabled then
		        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        	end
        end)
    end)
    Section:NewToggle("3rd Person", " S U S ", function(state)
        if state then
            cam = true
            while cam == true do 
                game.Workspace.Camera.CameraType = "Follow"
                game:GetService('Players').LocalPlayer.CameraMode = 'Classic'
                game.Players.LocalPlayer.DevEnableMouseLock = true
            wait()
            end
        else
            cam = false
            while cam == false do
                game.Workspace.Camera.CameraType = "Custom"
                game:GetService('Players').LocalPlayer.CameraMode = 'LockFirstPerson'
                game.Players.LocalPlayer.DevEnableMouseLock = false
            wait()
            end
        end
    end)
    Section:NewButton("? [only use ingame or start match]", "OMG BSD!!!", function()
        local clonescreen = squadscreen:Clone()
        clonescreen.Parent = game.Players.LocalPlayer.PlayerGui
        clonescreen.mainframe.flash.Visible = false
        announce:Play()
        wait(0.2)
        squad:Play()
        for _,v in pairs(game.Players:GetPlayers()) do
            if v ~= plr then
                v.Character.Parent = game.Workspace.mainGame['active_firing_range']
            end
        end
        wait(1)
        for _,gui in pairs(clonescreen.mainframe:GetChildren()) do
            if gui:IsA("TextLabel") then
                gui.Visible = false  
            end
        end
        game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
            squad.Playing = false
        end)
    end)
local Tab = Window:NewTab("World")
local Section = Tab:NewSection("")
    Section:NewButton("TP to lobby", "Useful for trolling", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9, -16, 11)
    end)
    Section:NewButton("No Fog", "Removes fog.", function()
            while true do 
                game.Lighting.FogEnd = 1000000
                game.Lighting.GlobalShadows = false
                wait()
            end
        end)
    Section:NewButton("Always Day", "Brightness.", function()
       	game.Lighting.Ambient = Color3.fromRGB(255,255,255)
       	game.Lighting.FogColor = Color3.fromRGB(255,255,255)
        end)
        Section:NewButton("Remove stuff", "", function()
            for _,particle in pairs(game:GetDescendants()) do
                if particle:IsA("ParticleEmitter") then
                    particle.Enabled = false
                end
            end
            for _, eff in pairs(game:GetService("ReplicatedStorage")["misc_effects"]:GetDescendants()) do
                if eff.Name ~= "laser" and eff.Name ~= "ping" and eff.Name ~= "scope_part" and eff:IsA("Part") or eff:IsA("MeshPart") then
                    eff.Transparency = 1 
                end
            end
            for _,v in pairs(workspace:GetDescendants()) do
                if v.ClassName == "Part" or v.ClassName == "WedgePart" then
                    v.Material = "SmoothPlastic"
                end
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
            game.Workspace.MedicalStuff:destroy()
        end)
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("")
    --[[Section:NewButton("Hunter Kit", "", function()
        local lmg = require(game:GetService("ReplicatedStorage")["weapon_modules"].lmg)
        local v1 = {}
        v1.full_acc_aimed = true
        v1.rpm_increase = 0.1
        v1.rpm_increase_max = 20
        v1.trigger_delay = 0.01
        if lmg then
        lmg["special_attributes"] = v1
        end
        print("!")
    end)]]
    
    Section:NewButton("Mod guns (will broken if use item!)", "", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anomalous%20Activites/Gun%20Mod.lua"))()
    end)
local Section = Tab:NewSection("")
    Section:NewButton("Potato Graphic", "For Potato PC/Laptop", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anti%20Lag.lua"))()
    end)
    Section:NewToggle("??", " ", function(state)
        anti = true
        if state then
            while anti == true do
                spawn(function()
                    for _, lag in pairs(game.Workspace.CurrentMap:GetDescendants()) do
                        if lag:IsA("Part")then
                            lag.Material = "Plastic"
                        end
                        if lag:IsA("MeshPart") then
                            lag.MeshId = "0"
                        end
                        if lag:IsA("Texture") then
                            lag.Texture = "0"
                        end
                        if lag:IsA("SurfaceAppearance") then
                            lag:destroy()
                        end
                    wait()
                    end
                end)
            wait()
            end
        else
            anti = false
        end
    end)
    Section:NewKeybind("Right Ctrl to close GUI", "", Enum.KeyCode.RightControl, function()
	    Library:ToggleUI()
    end)
    alert:Play()
local Tab = Window:NewTab("?")
local Section = Tab:NewSection("Credits")
	Section:NewLabel("Made by : Musc#8707")
	Section:NewLabel("Modding guns taken from Fumoslayer#3006")
	Section:NewLabel("Discord")
	Section:NewLabel("discord.gg/e6Adw82CJU")
else
	return
end
