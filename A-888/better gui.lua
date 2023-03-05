getgenv().SecureMode = true
setclipboard("https://discord.gg/jaqmAv54xT")
local wp = game:GetService("Workspace")
local res = game:GetService("ReplicatedStorage")
local plr = game:GetService("Players")
local remote = wp.mainGame.remotes
local chars = plr.LocalPlayer.Character
local mui = plr.LocalPlayer.PlayerGui.mainGui
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "A-888 by Musc & Viscome",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil, -- Create a custom folder for your hub/game
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "jaqmAv54xT", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
        Title = "A-888",
        Subtitle = "Key System",
        Note = "Join our discord!",
        FileName = "Lmao",
        SaveKey = true,
        GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = "therewasnokey"
    }
})
local Tab = Window:CreateTab("Utilities", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Guns")
local Button = Tab:CreateButton({
    Name = "Funny Pistol",
    Callback = function()
        local a = require(game:GetService("ReplicatedStorage")["weapon_modules"].threepistol)
        if a then
            a.name= "V.S.M 9"
            a.desc= "Was developed by the Americans military after WWII."
            a.magazine=18*1000
            a.fire_rate=0.01
            a.base_recoil=8*0
            a.spread=2
            a.special_attributes={burst_count=3*10, full_acc_aimed=true, spare_modifier=300}
            
        end
        local args = {
            [1] = "merc",
            [2] = {
                ["item"] = game:GetService("ReplicatedStorage").weapon_modules.threepistol,
                ["gui"] = workspace.merc_customisation.gui.pistol
            }
        }
        
        workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
   end,
})
local Button = Tab:CreateButton({
    Name = "Infinite Ammo",
    Callback = function()
        for _,g in pairs(res.weapon_modules:GetChildren()) do
            if g:IsA("ModuleScript") then
                s=require(g)
                s.magazine=10*120
            end
        end
    end,
})
local Button = Tab:CreateButton({
    Name = "One Shot",
    Callback = function()
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
    end,
})
local Section = Tab:CreateSection("Game")
local Button = Tab:CreateButton({
    Name = "Instant Anchor",
    Callback = function()
        game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
            if IsTyping then return end
            if Input.KeyCode == Enum.KeyCode.G then -- put your custom key here
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]=workspace.CurrentMap.Interactables.A})
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]=workspace.CurrentMap.Interactables.B})
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]=workspace.CurrentMap.Interactables.C})
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]=workspace.CurrentMap.Interactables.D})
                workspace.mainGame.remotes.game_handler:FireServer("interaction", {["with"]=workspace.CurrentMap.Interactables.E})
            end
        end)
   end,
})
local Section = Tab:CreateSection("Player")
local Button = Tab:CreateButton({
    Name = "Walkspeed",
    Callback = function()
        chars.Humanoid.Walkspeed=28
        task.wait()
   end,
})
local Tab = Window:CreateTab("Visual", 4483362458) -- Title, Image
local Section = Tab:CreateSection("Effects")
local Button = Tab:CreateButton({
   Name = "Disable VFX",
   Callback = function()
        for _,a in pairs(game:GetService("ReplicatedStorage").shared_modules.weaponVisuals.casing:GetChildren()) do
            if a:IsA("ParticleEmitter") then
                a.Enabled=false
            end
        end
   end,
})
local Button = Tab:CreateButton({
    Name = "Removes Objects",
    Callback = function()
        wp.ElectricalPanel:destroy()
        wp.MedicalStuff:destroy()
        wp.clothes:destroy()
        wp.ArmouryStuff:destroy()
        wp.lightscreens:destroy()
        wp.engineer:destroy()
        wp.Posters:destroy()
        wp.hiddenroom:destroy()
        wp.Quartermasterstuff:destroy()
   end,
})
local Button = Tab:CreateButton({
    Name = "Simplify Objects",
    Callback = function()
        for _,o in pairs(wp:GetDescendants()) do
            if o:IsA("Part") or o:IsA("UnionOperation") then
                task.wait(.1)
                o.Material="Plastic"
                o.Color=Color3.new(112, 113, 121)
            end
            if o:IsA("PointLight") then
                task.wait(.1)
                o:destroy()
            end
        end
   end,
})
local Button = Tab:CreateButton({
   Name = "Disable GUI",
   Callback = function()
        mui.death_screen.flash.Visible=false
        mui.death_screen.deadtext.Text="NIGGA HOW??!?!!?!"
        mui.death_screen.respawn.Text="RETURNING TO OHIO"
        mui.blackOverlay.Visible=false
        mui.splatterOverlay.Visible=false
   end,
})

















Rayfield:Notify({
    Title = "Discord",
    Content = "Copied Invite Link.",
    Duration = 5,
    Image = 4483362458,
    Actions = { -- Notification Buttons
        Ignore = {
        Name = "Ok",
        Callback = function()
        return
    end
    },
},
})
