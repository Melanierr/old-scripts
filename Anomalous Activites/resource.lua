repeat wait() until game:IsLoaded()
if game:IsLoaded() and game.PlaceId == 8770868695 then
local lobby = game:GetService("Workspace").lobby
local tk = false
local noclip = false
local plr = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.PlayerGui.mainGui.blackOverlay.Visible = false
local alert = Instance.new("Sound",game:GetService("SoundService"))
alert.SoundId = "rbxassetid://232127604"
local ab = require(game:GetService("ReplicatedStorage")["weapon_modules"].akimboblack)
local dp = require(game:GetService("ReplicatedStorage")["weapon_modules"].dualpistol)
local sb = require(game:GetService("ReplicatedStorage")["weapon_modules"].sniperblack)
local bg = require(game:GetService("ReplicatedStorage")["weapon_modules"].blackgun)
local sp = require(game:GetService("ReplicatedStorage")["weapon_modules"].suppistol)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Anomalous Activities", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("")
    Section:NewButton("NVG ( C key )", "execute once", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anomalous%20Activites/NVG.lua"))()
    end)
    Section:NewButton("Hitbox Extender", "Big head", function()
        while true do
            for _, box in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
                if box:IsA("Part") and box.Name == "Head" then
                    box.Size =  Vector3.new(6, 6, 6)
                    box.Transparency = 0.6
                    box.CanCollide = false
                else 
                end
            end
        wait()
        end
    end)
    Section:NewToggle("TeamKill", " S U S ", function(state)
        if state then
            tk = true
            while tk == true do 
                for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer and player.Parent == game.Workspace.mainGame["active_humans"] then
				player.Parent = game.Workspace.mainGame["active_firing_range"]
			end
		end
            wait()
            end
        else
            tk = false
            while tk == false do
                for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer and player.Parent == game.Workspace.mainGame["active_firing_range"] then
				player.Parent = game.Workspace.mainGame["active_humans"]
			end
		end
            wait()
            end
        end
    end)
    Section:NewButton("Instant interaction ( F key )", "", function()
        game:GetService("UserInputService").InputBegan:Connect(function(Key)
            if Key.KeyCode == Enum.KeyCode.F then -- put your custom key here
		workspace.mainGame.remotes.game_handler:FireServer("interaction", {['with']= workspace.CurrentMap.Interactables.Ammo})
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {['with']= workspace.CurrentMap.Interactables.Reinforcements})
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
                        wait(1)
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
        Section:NewButton("Lag fix", "removes unnecesscary objects", function()
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
            game.Workspace.MedicalStuff:destroy()
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
        end)
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("")
    Section:NewButton("Hunter Kit", "", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anomalous%20Activites/BETA.lua"))()
    end)
    Section:NewButton("Equip Spare Magazine in-case", "ButtonInfo", function()
    	workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags, ["gui"] = workspace.merc_customisation.gui.secondary })
    end)
    Section:NewButton("Mod guns (CURRENTLY BBROKEN)", "", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anomalous%20Activites/Gun%20Mod.lua"))()
    end)
local Section = Tab:NewSection("")
   --[[ Section:NewButton("Show hidden guns", "", function()
        for _, cyka in pairs(game.ReplicatedStorage['weapon_modules']:GetChildren()) do
		local cs = require(cyka)
		local v31 = {}
			v31.not_shown = false
			v31.disallowed = false
		cs.special_attributes = v31
	end
    end)]]
    Section:NewButton("Potato Graphic", "For Potato PC/Laptop", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/Anti%20Lag.lua"))()
    end)
    Section:NewButton("SUPER POTATO GRAPHIC", "I'm just kidding", function()
        for i,v in next, workspace:GetDescendants() do
            if v:IsA("MeshPart") or v:IsA("UnionOperation") then
                sethiddenproperty(v, "RenderFidelity", "Automatic")
            end
        end
    end)
    Section:NewKeybind("Right Ctrl to close GUI", "", Enum.KeyCode.RightControl, function()
	    Library:ToggleUI()
    end)
    alert:Play()
else
	return
end
