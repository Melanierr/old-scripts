if game.PlaceId == 12389327869 then
    if game:IsLoaded() then
        local plr = game.Players.LocalPlayer
        local rs =game:GetService("ReplicatedStorage")
        local mo = game:GetService("ReplicatedStorage").weapon_modules
        local anomaly = game:GetService("Workspace").mainGame.active_anomaly
       plr.PlayerGui.mainGui["death_screen"].Visible=false
        plr.PlayerGui.mainGui.splatterOverlay.Visible=false
        function hb()
        end
        function rm()
            game:GetService("Workspace").engineer:Destroy()
            game:GetService("Workspace").MedicalStuff:Destroy()
            game:GetService("Workspace").ElectricalPanel:Destroy()
            game:GetService("Workspace").LobbySpawns:Destroy()
            game:GetService("Workspace").jfj:Destroy()
            game:GetService("Workspace").Posters:Destroy()
        end
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("KFC Hub", "Synapse")
    Tab = Window:NewTab("Main")
    local Section = Tab:NewSection("")
        Section:NewButton("Fly Jump", "", function()
            local InfiniteJumpEnabled = true
            game:GetService("UserInputService").JumpRequest:connect(function()
                plr.Character.Humanoid.JumpPower = 20
            	if InfiniteJumpEnabled then
            		plr.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            	end
            end)
        end)
        Section:NewButton("Anti Lag", "", function()
            rm()
            game.Lighting.FogEnd=100000
            for _,lag in pairs(game:GetDescendants()) do
                if lag:IsA("Particle Emitter") or lag:IsA("Beam") then
                    lag.Enabled = false
                end
                if lag:IsA("PointLight") then
                    lag:Destroy()
                    wait(.1)
                end
                if lag:IsA("Part") then
                    lag.Material = "Plastic"
                    lag.Color=Color3.new(112, 113, 121)
                    wait(.1)
                end
                if lag:IsA("Texture") then
                    lag:Destroy()
                    wait(.1)
                end
            end
        end)
    Tab = Window:NewTab("Weapon")
    local Section = Tab:NewSection("")
        Section:NewButton("Show hidden slot & guns", "", function()
            game:GetService("Workspace")["merc_customisation"].gui.equipmentip3:Destroy()
            game:GetService("Workspace")["merc_customisation"].gui.equipmentip3:Destroy()
            game:GetService("Workspace")["merc_customisation"].gui.equipment4.Visible = true
            for _,a in pairs(game.ReplicatedStorage.weapon_modules:GetChildren()) do
                local b = require(a)
                b.special_attributes = {not_shown = false,disallowed = false}
            end
        end)
        Section:NewButton("Inf Mags", "", function()
            for _,a in pairs(rs.weapon_modules:GetChildren()) do
                if a.Name ~= "sentry" or a.Name ~='pipe' or a.Name ~= 'camera' or a.Name~='smoke' or a.Name ~= "syringe" or a.Name ~='mine' or a.Name ~= 'platepiece' or a.Name~='plate' or a.Name ~= "medic" or a.Name ~='stamshot' or a.Name ~= 'shrap' or a.Name~='ammobox' or a.Name ~= 'throwaxe' then
                    local b = require(a)
                    b.special_attributes = {spare_modifier=100}
                    print("blaclisted")
                    wait(.01)
                end
            end
        end)
        Section:NewButton("Full Auto", "", function()
            for _,a in pairs(rs.weapon_modules:GetChildren()) do
                if a.Name ~= "sentry" or a.Name ~='pipe' or a.Name ~= 'camera' or a.Name~='smoke' or a.Name ~= "syringe" or a.Name ~='mine' or a.Name ~= 'platepiece' or a.Name~='plate' or a.Name ~= "medic" or a.Name ~='stamshot' or a.Name ~= 'shrap' or a.Name~='ammobox' or a.Name ~= 'throwaxe' then
                local b = require(a)
                b.semi_automatic = false
                end
            end
        end)
        Section:NewButton("OneShot", "", function()
            local settings = {repeatamount = 15, exceptions = {"SayMessageRequest", "game_handler", "audio_relay", "weapon_vfx_relay", "voices_handler", "arm_handler", "player_respawn", "change_equipped", "resetter", "standing_handler", "effects_relay", "weapon_handler", "terror_handler", "equipment_handler", 'aux_handler', 'skill_handler'}}
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
    
            mt.__namecall = function(uh, ...)
            local args = {...}
            local method = getnamecallmethod()
            for i,o in next, settings.exceptions do
                if uh.Name == o then
                    return old(uh, ...)
                end
            end
            if method == "FireServer" or method == "InvokeServer" then
                for i = 1,settings.repeatamount do
                    old(uh, ...)
                end
            end
            return old(uh, ...)
            end
            setreadonly(mt, true)
        end)
    Tab = Window:NewTab("Misc")
    local Section = Tab:NewSection("")
        Section:NewDropdown("Equip item", "", {"GT-HBR", "R.300", "M9P", "M9-S", "", ""}, function(currentOption)
            if currentOption=="GT-HBR" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.sniperblack,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.primary})
            end
            if currentOption=="R.300" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.blackgun,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.primary})
            end
            if currentOption=="M9P" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.akimboblack,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.pistol})
            end
            if currentOption=="M9-S" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.suppistol,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.pistol})
            end
            if currentOption=="M9P" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.akimboblack,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.pistol})
            end
            if currentOption=="M9P" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc", {["item"] = rs.weapon_modules.akimboblack,  ["gui"] = game:GetService("Workspace").merc_customisation.gui.pistol})
            end
        end)
        Section:NewKeybind("Right Ctrl to close", "", Enum.KeyCode.RightControl, function()
        	Library:ToggleUI()
        end)
    end
else return
end
