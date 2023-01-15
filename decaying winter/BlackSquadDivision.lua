--// Security Key
function key()
    spawn(function()
        while true do
            for _, instance in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
                    repeat
                        mainHandler = getsenv(instance)
                        game:GetService("RunService").Heartbeat:Wait()
                    until mainHandler.afflictstatus ~= nil
            
                    local upvalue = getupvalues(mainHandler.afflictstatus)
                    _G.serverKey = upvalue[16]
                    _G.playerKey = upvalue[17]
                end
            end
        wait()
        end
    end)
end
key()
--// Spawn sound
--// Setup
local uis = game:GetService("UserInputService")
isenabled = false
dounce = false
local defaultAmbient = game.Lighting.OutdoorAmbient
local sound = Instance.new("Sound", game.SoundService)
local cce = Instance.new("ColorCorrectionEffect", game.Lighting)
local plr=game.Players.LocalPlayer
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
local vectors = {"rightVector", "lookVector"}
local scalars = {-5, 5}
--[[game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.J then
        local perk = game.Players.LocalPlayer.Character.current_perk.Value
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", "lazarus")
        local args = {
            [1] = "lazarus_device",
            [2] = plr.Character.HumanoidRootPart.CFrame,
            [3] = _G.serverKey,
            [4] = _G.playerKey
        }
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        workspace.ServerStuff.playAudio:FireServer({ [1] = "ai"}, "healfx", game.Workspace)
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", perk)
    end
end)]]
game:GetService("UserInputService").InputBegan:Connect(function(input, Typing)
    if Typing then
        return
    end
    if input.KeyCode == Enum.KeyCode.V then
        local perk = game.Players.LocalPlayer.Character.current_perk.Value
	    workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "taunt_5", game.Workspace)
        workspace.ServerStuff.handlePerkVisibility:FireServer("aegisprotect")
        workspace.ServerStuff.handlePerkVisibility:FireServer("enable_aegis_shield")
        for flame=1, 3 do
            workspace.ServerStuff.changeStats:InvokeServer("changeclass", "shotgun")
        local args = {
            [1] = "shotshell",
            [2] = {
                [1] = game.Workspace.Camera.CFrame,
                [2] = game.Workspace.Camera.CFrame + Vector3.new(0.5, -1, 0.5)
            },
            [3] = _G.serverKey,
            [4] = _G.playerKey
        }
        
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        local args = {
            [1] = "immolate_ability",
            [2] = game:GetService("Players").LocalPlayer.Character,
            [3] = game:GetService("Players").LocalPlayer,
            [4] = {
                [1] = game.workspace.Camera.CFrame + Vector3.new(0.5, -1, 0.5)
            }
        }
        
        workspace.ServerStuff.applyGore:FireServer(unpack(args))
        wait(0.1)
        end
            workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "sickler", game.Workspace)
            workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "sickler", game.Workspace)
            workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "sickler", game.Workspace)
            workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "enough", game.Workspace)
        for spawn=1, 5 do
        game.Workspace.ServerStuff.changeStats:InvokeServer("changeclass", "shield")
            wait(.1)
            plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0, 4.5)
            local args = {
                [1] = "placeaegisturret",
                [3] = _G.serverKey,
                [4] = _G.playerKey
            }
            
            workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        end
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", perk)
    end
end)
cce.Enabled = false
cce.Brightness = .2
cce.Contrast = .2
cce.TintColor = Color3.new(0.376471, 0.772549, 0.317647)
sound.SoundId = "rbxassetid://6361023770"

uis.InputBegan:Connect(function(input, processed)
if input.KeyCode == Enum.KeyCode.N then
if dounce == false then
dounce = true
if isenabled == false then
sound:Play()
game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
cce.Enabled = true
game.Lighting.ExposureCompensation = 1.5
isenabled = true
elseif isenabled == true then
sound:Play()
game.Lighting.OutdoorAmbient = defaultAmbient
cce.Enabled = false
game.Lighting.ExposureCompensation = 0
isenabled = false

end
else
wait(1.8)
dounce = false
end
end
end)
warn("!")
spawn(function()
    game.Workspace["activePlayers"].ChildAdded:Connect(function(w)
        if w.Name == plr.Name then
            workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "rhyer", game.Workspace)
            workspace.ServerStuff.playAudio:FireServer({ [1] = "voices", [2] = "ilija", [3] = "arrive" }, "arrive2", game.Workspace)
        end
    end)
    plr.Character:WaitForChild("Humanoid").Died:Connect(function()
        workspace.ServerStuff.playAudio:FireServer({ [1] = "general"}, "pan", game.Workspace)
    end)
end)
