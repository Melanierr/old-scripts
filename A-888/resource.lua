if game.PlaceId == 12389327869 then
    if game:IsLoaded() then
        local plr = game.Players.LocalPlayer
        local rs =game:GetService("ReplicatedStorage")
        local mo = game:GetService("ReplicatedStorage").weapon_modules
        local anomaly = game:GetService("Workspace").mainGame.active_anomaly
        local tk = false
        plr.PlayerGui.mainGui["death_screen"].Visible=false
        plr.PlayerGui.mainGui.splatterOverlay.Visible=false
        function hb()
            for _, ano in pairs(anomaly:GetChildren()) do
                if ano:IsA("Model") then
                    ano.Head.Size=Vector3.new(5, 5, 5)
                    ano.Head.Transparency=0.5
                end
            end
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
    local Section = Tab:NewSection(" [ THIS IS NOT THE FINAL VERSION! ] ")
        Section:NewToggle("TeamKill", "", function(state)
            if state then
                tk = true
                while tk ==true do
                    for _,plr in pairs(game:GetSerice("Workspace").mainGame.active_humans:GetChildren()) do
                        if plr.Name ~= game.Players.LocalPlayer.Character.Name then
                            plr.Parent = game:GetSerice("Workspace").mainGame.active_firing_range
                            wait(.1)
                        end
                    end
                wait()
                end
            else
                tk = false
                while tk==false do
                    for _,plr in pairs(game:GetSerice("Workspace").mainGame.active_humans:GetChildren()) do
                        if plr.Name ~= game.Players.LocalPlayer.Character.Name then
                            plr.Parent = game:GetSerice("Workspace").mainGame.active_firing_range
                            wait(.1)
                        end
                    end
                wait()
                end
            end
        end)
        Section:NewButton("Fly Jump", "", function()
            local InfiniteJumpEnabled = true
            game:GetService("UserInputService").JumpRequest:connect(function()
                plr.Character.Humanoid.JumpPower = 20
            	if InfiniteJumpEnabled then
            		plr.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            	end
            end)
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
        Section:NewButton("More Ammo", "", function()
            for _,a in pairs(rs.weapon_modules:GetChildren()) do
                if a.Name ~= "sentry" and a.Name ~='pipe' and a.Name ~= 'camera' and a.Name~='smoke' and a.Name ~= "syringe" and a.Name ~='mine' and a.Name ~= 'platepiece' and a.Name~='plate' and a.Name ~= "medic" and a.Name ~='stamshot' and a.Name ~= 'shrap' and a.Name~='ammobox' and a.Name ~= 'classic' and a.Name~='karamb' and a.Name ~= 'fists'  then
                    local b = require(a)
                    b.special_attributes = {spare_modifier=100}
                    print("blaclisted")
                    wait(.01)
                end
            end
            for _,a in pairs(rs.weapon_variants:GetChildren()) do
                if a.Name ~= "sentry" and a.Name ~='pipe' and a.Name ~= 'camera' and a.Name~='smoke' and a.Name ~= "syringe" and a.Name ~='mine' and a.Name ~= 'platepiece' and a.Name~='plate' and a.Name ~= "medic" and a.Name ~='stamshot' and a.Name ~= 'shrap' and a.Name~='ammobox' and a.Name ~= 'throwaxe'and a.Name~='karamb' and a.Name ~= 'fists' then
                    local b = require(a)
                    b.special_attributes = {spare_modifier=100}
                    print("blaclisted")
                    wait(.01)
                end
            end
        end)
        Section:NewButton("Full Auto [ NOT RECOMMENDED ]", "", function()
            for _,a in pairs(rs.weapon_modules:GetChildren()) do
                if a.Name ~= "sentry" and a.Name ~='pipe' and a.Name ~= 'camera' and a.Name~='smoke' and a.Name ~= "syringe" and a.Name ~='mine' and a.Name ~= 'platepiece' and a.Name~='plate' and a.Name ~= "medic" and a.Name ~='stamshot' and a.Name ~= 'shrap' and a.Name~='ammobox' and a.Name ~= 'throwaxe' then
                local b = require(a)
                b.semi_automatic = false
                b.special_attributes = {spare_modifier=100, rpm_increase=1, rpm_max_increase=20}
                end
            end
        end)
        Section:NewButton("Heal on Kill [ IN DEVELOPMENT ] ", "", function()
            for _,a in pairs(rs.weapon_modules:GetChildren()) do
                if a.Name ~= "sentry" and a.Name ~='pipe' and a.Name ~= 'camera' and a.Name~='smoke' and a.Name ~= "syringe" and a.Name ~='mine' and a.Name ~= 'platepiece' and a.Name~='plate' and a.Name ~= "medic" and a.Name ~='stamshot' and a.Name ~= 'shrap' and a.Name~='ammobox' and a.Name ~= 'throwaxe' then
                    local b = require(a)
                    b.special_attributes = {heal_on_kill=500}
                    print("blaclisted")
                    wait(.01)
                end
            end
            for _,a in pairs(rs.weapon_variants:GetChildren()) do
                if a.Name ~= "sentry" and a.Name ~='pipe' and a.Name ~= 'camera' and a.Name~='smoke' and a.Name ~= "syringe" and a.Name ~='mine' and a.Name ~= 'platepiece' and a.Name~='plate' and a.Name ~= "medic" and a.Name ~='stamshot' and a.Name ~= 'shrap' and a.Name~='ammobox' and a.Name ~= 'throwaxe' then
                    local b = require(a)
                    b.special_attributes = {heal_on_kill=500}
                    print("blaclisted")
                    wait(.01)
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
                local args = {
                    [1] = "merc",
                    [2] = {
                        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sniperblack,
                        ["gui"] = workspace.merc_customisation.gui.primary
                    }
                }
                
                workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
            end
            if currentOption=="R.300" then
                local args = {
                    [1] = "merc",
                    [2] = {
                        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.blackgun,
                        ["gui"] = workspace.merc_customisation.gui.primary
                    }
                }
                
                workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))            
                end
            if currentOption=="M9P" then
                local args = {
                    [1] = "merc",
                    [2] = {
                        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.akimboblack,
                        ["gui"] = workspace.merc_customisation.gui.pistol
                    }
                }
                
                workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))           
                end
            if currentOption=="M9-S" then
                local args = {
                    [1] = "merc",
                    [2] = {
                        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.suppistol,
                        ["gui"] = workspace.merc_customisation.gui.pistol
                    }
                }
                
                workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))            end
        end)
        Section:NewButton("Anti Lag", "", function()
            rm()
            game.Lighting.FogEnd=100000
            for _,lag in pairs(game:GetDescendants()) do
                if lag:IsA("Particle Emitter") then
                    lag.Enabled = false
                end
                if lag:IsA("PointLight") then
                    lag:Destroy()
                    wait(.1)
                end
                if lag:IsA("Part") or lag:IsA("MeshPart") then
                    lag.Material = "Plastic"
                    wait(.1)
                end
                if lag:IsA("Texture") then
                    lag:Destroy()
                    wait(.1)
                end
            end
        end)
        Section:NewKeybind("Right Ctrl to close", "", Enum.KeyCode.RightControl, function()
        	Library:ToggleUI()
        end)
    end
else return
end
