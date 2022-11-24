--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
--// Variables
local gui = game.Players.LocalPlayer.PlayerGui.controlsGui
local hs = game.workspace.activeHostiles
local localplayer = game.Players.LocalPlayer
local mainHandler = { instance = nil, senv = nil }
local namecall = nil
local waitTable = {}
local tgas = {
        ["throwrating"] = 1,
        ["ability"] = "Can obscure vision.",
        ["blacklisted"] = true,
        ["animset"] = "THRW",
        ["desc"] = "Used by riot police! Yes, we still have those! We have many hired and stationed on site at all time " ..
            "and borrowed some of these!",
        ["weapontype"] = "Item",
        ["name"] = "Riot Grenade",
        ["damagerating"] = {
            [1] = 0,
            [2] = 0
        },
        ["sizerating"] = 4,
        ["icon"] = "2520535457",
        ["woundrating"] = 2
}

--// Functions

game.StarterGui:SetCore("SendNotification", {
    Title = 'LOADING';
    Duration = 3;
})
wait(2)
function getkey()
    spawn(function()
for _, instance in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
        repeat
            mainHandler = getsenv(instance)
            RunService.Heartbeat:Wait()
        until mainHandler.afflictstatus ~= nil

        local upvalue = getupvalues(mainHandler.afflictstatus)
        _G.serverKey = upvalue[16]
        _G.playerKey = upvalue[17]
    end
end

for index, status in pairs(getupvalue(mainHandler.afflictstatus, 1)) do
    if string.match(index, "Virus") ~= nil then
        status.effects.currentduration = math.huge
    end
end
end)
end
--// stun
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.Y then
            local args = {
                [1] = "TGas",
                [2] = 20,
                [3] = game.Workspace.CurrentCamera.CFrame,
                [4] = 1,
                [5] = tgas,
                [6] = 1,
                [8] = _G.serverKey,
                [10] = _G.playerKey
            }

            workspace.ServerStuff.throwWeapon:FireServer(unpack(args))
            wait(1)
    end
end)
-- // scan
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.B then
        		workspace.ServerStuff.applyGore:FireServer("scanarea", localplayer.Character, localplayer, {[1] = game.Workspace.CurrentCamera.CFrame})
    	end
end)
--// smoke
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.U then
	    workspace.ServerStuff.dealDamage:FireServer("fireSmoke", workspace.CurrentCamera.CFrame, _G.serverKey, _G.playerKey)
    end
end)
--// heal
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.K then
	    for o=1, 10 do
	    game.Workspace.ServerStuff.dealDamage:FireServer("Regeneration", nil, _G.serverKey, _G.playerKey)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.L then
	   for i=1, 5 do
        workspace.ServerStuff.dropAmmo:FireServer("rations", "MRE")
        workspace.ServerStuff.dropAmmo:FireServer("rations", "Bottle")
        workspace.ServerStuff.dropAmmo:FireServer("rations", "MRE")
        workspace.ServerStuff.dropAmmo:FireServer("rations", "Bottle")
        wait()
    end
end
end)
wait(3)

--// controlsGui
gui.Enabled = false
game.StarterGui:SetCore("SendNotification", {
    Title = 'Tear Gas';
    Text = "Y to deploy tear gas.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
wait(3)
game.StarterGui:SetCore("SendNotification", {
    Title = 'Scan';
    Text = "B to scan in an area.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
wait(3)
game.StarterGui:SetCore("SendNotification", {
    Title = 'Smoke';
    Text = "U to deploy smoke.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
wait(3)
game.StarterGui:SetCore("SendNotification", {
    Title = 'Heal';
    Text = "K to heal yourself.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
-- workspace.ServerStuff.playAudio:FireServer({ [1] = "songs", [2] = "holdout_bosses"}, "sledge", game.Workspace)
while true do
    getkey()
    wait(1)
end
