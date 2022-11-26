--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
--// Variables
local stuff = game.Workspace.InteractablesNoDel
local gui = game.Players.LocalPlayer.PlayerGui.controlsGui
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
--// Virus blocking
for index, status in pairs(getupvalue(mainHandler.afflictstatus, 1)) do
    if string.match(index, "Virus") ~= nil then
        status.effects.currentduration = math.huge
    end
end
end)
end


--// parry
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.R then
	        for i=1, 10 do
            workspace.ServerStuff.initiateblock:FireServer(_G.serverKey, true)
	        end
	end
end)


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
	        wait(0.1)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.L then
	    for i=1, 10 do
            workspace.ServerStuff.dropAmmo:FireServer("rations", "MRE")
            workspace.ServerStuff.dropAmmo:FireServer("rations", "Bottle")
            wait()
        end
    end
end)
UserInputService.InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
	if input.KeyCode == Enum.KeyCode.R then
	    for i=1, 10 do
            workspace.ServerStuff.initiateblock:FireServer(_G.serverKey, true)
	    end
	end
end)
wait(3)


--// controlsGui
gui.Enabled = false
loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Announce.lua"))()
while true do
    getkey()
    wait(1)
end
while true do
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localplayer then 
            player.Character.Parent = game.Workspace
        end
    wait()
    end
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Longer%20Effects.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Remove%20UI.lua"))()
function Callback(answer)
    if answer == "Yes" then
        workspace.ServerStuff.playAudio:FireServer({ [1] = "songs", [2] = "holdout_bosses"}, "sledge", game.Workspace)
    elseif answer == "No" then
        print("Player rejected.")
    end
end
local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = Callback
game.StarterGui:SetCore("SendNotification", {
    Title = "Music";
    Text = {"Want some SQ music?                  ( holdout )"};
    Duration = "20";
    Button1 = "Yes";
    Button2 = "No";
    Icon = "rbxassetid://2541869220";
    Callback = Bindable
})
wait(5)
function Callback(answer)
    if answer == "Yes" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/IrishBaker/scripts/main/decaying%20winter/Auto%20Finish.lua"))()
    elseif answer == "No" then
        print("Player rejected.")
    end
end
local Bindable = Instance.new("BindableFunction")
Bindable.OnInvoke = Callback
game.StarterGui:SetCore("SendNotification", {
    Title = "Auto True Ending?";
    Text = "";
    Duration = "20";
    Button1 = "Yes";
    Button2 = "No";
    Icon = "rbxassetid://11151804229";
    Callback = Bindable
})
