if game.PlaceId == 12389327869 then
    if game:IsLoaded() then
        local plr = game.Players.LocalPlayer
        local rs =game:GetService("ReplicatedStorage")
        local cgui = workspace.merc_customisation.gui.primary
        local mo =game:GetService("ReplicatedStorage").weapon_modules
        local anomaly = game:GetService("Workspace").mainGame.active_anomaly
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
        Section:NewButton("OneShot", "You use 50 Cal. bullet.", function()
            local settings = {repeatamount = 10, exceptions = {"SayMessageRequest", "game_handler", "audio_relay", "weapon_vfx_relay", "voices_handler", "arm_handler", "player_respawn", "change_equipped", "resetter", "standing_handler", "effects_relay", "weapon_handler", "terror_handler"}}
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
        Section:NewButton("Fly Jump", "", function()
            local InfiniteJumpEnabled = true
            game:GetService("UserInputService").JumpRequest:connect(function()
                plr.Character.Humanoid.JumpPower = 20
            	if InfiniteJumpEnabled then
            		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            	end
            end)
        end)
        Section:NewButton("Anti Lag", "", function()
            rm()
            for _,lag in pairs(rs:GetDescendants()) do
                if lag:IsA("Particle Emitter") or lag:IsA("Beam") then
                    lag.Enabled = false
                end
                if lag:IsA("PointLight") then
                    lag:Destroy()
                end
                wait(.1)
            end
        end)
        Section:NewButton("Show hidden equipment slot", "", function()
            game:GetService("Workspace")["merc_customisation"].gui.equipmentip3:Destroy()
            game:GetService("Workspace")["merc_customisation"].gui.equipmentip3:Destroy()
            game:GetService("Workspace")["merc_customisation"].gui.equipment4.Visible = true 
        end)
        Section:NewButton("Increase monster's money [ NOT WORKING ]", "", function()
            for _, enemy in pairs(rs.enemy_types:GetChildren()) do
                local script = require(enemy)
                script.v1.kill_value = 500
            end
        end)
        Tab = Window:NewTab("Misc")
        local Section = Tab:NewSection("")
        Section:NewDropdown("Special Stuff [ Some option may not work ]", "", {"GT-HBR", "R.300", "M9P+", "BSD set"}, function(currentOption)
            if currentOption == "GT-HBR" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc",cgui, mo.sniperblack)
            end
            if currentOption == "R.300" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc",cgui, mo.blackgun)
            end
            if currentOption == "M9P+" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc",workspace.merc_customisation.gui.pistol, akimboblack)
            end
            if currentOption == "BSD set" then
                workspace.mainGame.remotes.change_equipped:FireServer("merc",workspace.merc_customisation.gui.pistol, akimboblack)
                workspace.mainGame.remotes.change_equipped:FireServer("merc",workspace.merc_customisation.gui.secondary, mo.blackgun)
                workspace.mainGame.remotes.change_equipped:FireServer("merc",cgui, mo.sniperblack)
            end
        end)

        Section:NewKeybind("Right Ctrl to close", "", Enum.KeyCode.RightControl, function()
        	Library:ToggleUI()
        end)
    end
else return
end
