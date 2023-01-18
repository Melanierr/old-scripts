--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

--// Variables
local vectors = {"rightVector", "lookVector"}
local scalars = {-5, 5}
local plr = Players.LocalPlayer
local hrp = plr.Character:WaitForChild("HumanoidRootPart")
plr.PlayerGui.controlsGui.Enabled=false
plr.PlayerGui.topbarkek.Enabled=false
local mainHandler = { instance = nil, senv = nil }
local namecall = nil
local toggle = {
    using = false,
    blocking = { false, 0, 0 },
    dashing = { false },
    healing = { false },
    grappling = { false }
}

local activeStat = {
    def = { func = nil, upvalue = 0 },
    mvt = { func = nil, upvalue = 0 },
}
--// Functions
function spawnItem(itemName, slot)
    local inventory = getupvalue(mainHandler.senv.start_dual_wield, 3)
    local function spawn(use)
        if inventory[slot][1] ~= itemName then
            if workspace.InteractablesNoDel:FindFirstChild("Personal Workbench") ~= nil then
                repeat
                    ReplicatedStorage.Interactables.interaction:FireServer(workspace.InteractablesNoDel["Personal Workbench"], "buybaseupgrade", _G.serverKey)
                    RunService.Heartbeat:Wait()
                until workspace.InteractablesNoDel:FindFirstChild("Workbench") ~= nil
            end

            local workbench = workspace.InteractablesNoDel:FindFirstChild("Workbench") or workspace.Interactables:FindFirstChild("Workbench")
            if workbench:FindFirstChild("stats") == nil then
                return
            end

            ReplicatedStorage.Interactables.interaction:FireServer(workbench, "workbenchblueprint" .. itemName, _G.playerKey)
            repeat RunService.Heartbeat:Wait() until workbench.stats.blueprint.Value == itemName

            ReplicatedStorage.Interactables.interaction:FireServer(workbench, "workbench", _G.playerKey)

            local self = nil
            self = workspace.WeaponDrops.ChildAdded:Connect(function(item)
                if item.Name == itemName and (item:GetPivot().Position - workbench:GetPivot().Position).Magnitude <= 20 then
                    if inventory[slot][1] ~= "Fist" then
                        inventory[slot] = {"Fist", false, nil}
                    end

                    local lastPosition = plr.Character:GetPivot()
                    repeat
                        plr.Character:PivotTo(item:GetPivot() + Vector3.new(0, 5, 0))
                        workspace.ServerStuff.claimItem:InvokeServer(item)

                        RunService.Heartbeat:Wait()
                    until plr.Character.valids:FindFirstChild(itemName) ~= nil

                    local animSet = nil
                    for _, v in pairs(ReplicatedStorage.animationSets.TPanimSets:GetChildren()) do
                        if v.Name == require(workspace.ServerStuff.Statistics.W_STATISTICS)[itemName].animset then
                            animSet = v
                        end
                    end

                    repeat
                        if use == nil then
                            workspace.ServerStuff.getTPWeapon:FireServer(itemName, animSet, "Fist", item, true)
                        else
                            workspace.ServerStuff.getTPWeapon:FireServer(itemName, animSet, "Fist", item, false)
                        end

                        RunService.Heartbeat:Wait()
                    until workspace.WeaponDrops:FindFirstChild(item) == nil

                    plr.Character:PivotTo(lastPosition)
                    inventory[slot] = {itemName, false, nil}

                    self:Disconnect(); self = nil
                end
            end)
        end
    end

    for index, value in pairs(require(workspace.ServerStuff.Statistics.W_STATISTICS)) do
        if string.match(string.lower(index), string.lower(itemName)) ~= nil then
            itemName = index

            local use = nil
            if value.weapontype == "Item" or value.weapontype == "Bow" or value.weapontype == "Gun" then
                if ReplicatedStorage.Weapons:FindFirstChild(index) then
                   use = ReplicatedStorage.Weapons[index].ammo.Value
                end

                if slot == nil then
                    for inventorySlot, content in pairs(inventory) do
                        if inventorySlot ~= 1 and content[1] == "Fist" then
                            slot = inventorySlot
                            break
                        end
                    end
                end
            end

            if plr.Character.valids:FindFirstChild(itemName) ~= nil then
                inventory[slot] = {itemName, false, use}
            else
                spawn(use)
            end

            repeat RunService.Heartbeat:Wait() until inventory[slot][1] == itemName and plr.PlayerGui.mainHUD:FindFirstChild("InventoryFrame") ~= nil
            mainHandler.senv.invmanage("updatehud")

            break
        end
    end
end

function getActiveStat()
    if mainHandler.senv.maingui:FindFirstChild("devbox") == nil then
        local devbox = Instance.new("Frame")
        devbox.Size = UDim2.new(0, 0)
        devbox.BackgroundTransparency = 0
        devbox.BorderSizePixel = 0
        devbox.Parent = mainHandler.senv.maingui
        devbox.Name = "devbox"

        local devlabel1 = Instance.new("TextLabel")
        devlabel1.Size = UDim2.new(0, 0)
        devlabel1.BackgroundTransparency = 0
        devlabel1.BorderSizePixel = 0
        devlabel1.TextSize = 0
        devlabel1.Parent = devbox
        devlabel1.Name = "devlabel1"

        local devlabel2 = Instance.new("TextLabel")
        devlabel2.Size = UDim2.new(0, 0)
        devlabel2.BackgroundTransparency = 0
        devlabel2.BorderSizePixel = 0
        devlabel2.TextSize = 0
        devlabel2.Parent = devbox
        devlabel2.Name = "devlabel2"

        local devlabel3 = Instance.new("TextLabel")
        devlabel3.Size = UDim2.new(0, 0)
        devlabel3.BackgroundTransparency = 0
        devlabel3.BorderSizePixel = 0
        devlabel3.TextSize = 0
        devlabel3.Parent = devbox
        devlabel3.Name = "devlabel3"

        while devlabel1.Text == "" or devlabel2.Text == "" or devlabel3.Text == "" do
            RunService.Heartbeat:Wait()
        end
    end

    local found = false
    while found == false do
        for _, functions in pairs(getreg()) do
            if type(functions) == "function" and getfenv(functions).script and getfenv(functions).script == mainHandler.instance then
                local upvalues = getupvalues(functions)

                for i, v in pairs(upvalues) do
                    if type(v) == "number" then
                        if tostring(v) == string.sub(mainHandler.senv.maingui.devbox.devlabel1.Text, 7, -1) or tostring(v) == string.sub(mainHandler.senv.maingui.devbox.devlabel2.Text, 7, -1) or tostring(v) == string.sub(mainHandler.senv.maingui.devbox.devlabel3.Text, 14, -1) then
                            local random = math.random(-20, -10)
                            local old = v

                            setupvalue(functions, i, random)
                            RunService.Heartbeat:Wait()

                            if string.sub(mainHandler.senv.maingui.devbox.devlabel2.Text, 7, -1) == tostring(random) then
                                activeStat.def = {
                                    func = functions,
                                    upvalue = i,
                                }

                                found = true
                            end

                            if string.sub(mainHandler.senv.maingui.devbox.devlabel3.Text, 14, -1) == tostring(random) then
                                activeStat.mvt = {
                                    func = functions,
                                    upvalue = i,
                                }

                                found = true
                            end

                            setupvalue(functions, i, old)
                        end
                    end
                end
            end
        end

        RunService.Heartbeat:Wait()
    end
end

local function start()
    for _, instance in ipairs(plr.Backpack:GetChildren()) do
        if instance:IsA("LocalScript") and instance.Name ~= "ClickDetectorScript" then
            repeat
                mainHandler.instance = instance
                mainHandler.senv = getsenv(mainHandler.instance)
                RunService.Heartbeat:Wait()
            until mainHandler.senv.afflictstatus ~= nil and mainHandler.senv.unloadgun ~= nil and mainHandler.senv.ration_system_handler ~= nil

            for index, upvalue in ipairs(getupvalues(mainHandler.senv.afflictstatus)) do
                if typeof(upvalue) == "number" then
                    for _, key in pairs(getrenv()._G) do
                        if upvalue == key then
                            _G.serverKey = upvalue
                        end
                    end
                end

                if upvalue == _G.serverKey then
                    _G.playerKey = getupvalue(mainHandler.senv.afflictstatus, index + 1)
                    break
                end
            end
        end
    end

    spawnItem("FAxe", 2)
    getActiveStat()
    wait(2)
    --spawnItem("SUPAK", 2)
    --getActiveStat()
    workspace.ServerStuff.changeStats:InvokeServer("changeclass", "shield")
    mainHandler.senv.teamfolder = nil
    setupvalue(activeStat.mvt.func, activeStat.mvt.upvalue, 14)

    local ration = mainHandler.senv.ration_system_handler
    ration.Soda = 25
    ration.Bottle = 25
    ration.Beans = 50
    ration.MRE = 50

end

--// Set up
if _G.connection ~= nil then
    for _, connection in ipairs(_G.connection) do
        connection:Disconnect()
    end
end
_G.connection = {}

start()
--// ?
spawn(function()
    while true do
    	if plr.Character.Humanoid.Health <= 200 then
            warn("LOW HEALTH")
            repeat workspace.ServerStuff.dealDamage:FireServer("lazarusheal", 1, _G.serverKey, _G.playerKey) wait(.1)
            until plr.Character.Humanoid.Health >= 500
        end
    wait()
    end
    game.Workspace["activePlayers"].ChildAdded:Connect(function(w)
        if w.Name == plr.Name then
            key()
            print("got it")
            workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "rhyer", game.Workspace)
            workspace.ServerStuff.playAudio:FireServer({ [1] = "voices", [2] = "ilija", [3] = "arrive" }, "arrive2", game.Workspace)
        end
    end)
    plr.Character:WaitForChild("Humanoid").Died:Connect(function()
        workspace.ServerStuff.playAudio:FireServer({ [1] = "general"}, "pan", game.Workspace)
    end)
end)






--// MAIN
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.V then
        local perk = game.Players.LocalPlayer.Character.current_perk.Value
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", "shield")
	    workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "taunt_5", game.Workspace)
        workspace.ServerStuff.handlePerkVisibility:FireServer("aegisprotect")
        workspace.ServerStuff.handlePerkVisibility:FireServer("enable_aegis_shield")
        workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "sickler", game.Workspace)
        workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "enough", game.Workspace)
        local a = Instance.new("Part")
        a.Material = "Neon"
        a.Parent = game.workspace
        a.CFrame = hrp.CFrame + Vector3.new(18, 0, 0)
        a.Size = Vector3.new(10, 0.1, 10)
        a.Transparency = 1
        a.CanCollide = false
        a.Anchored=true
        wait(0.5)
        a.CanCollide = true
        for place=1, 10 do
        a.Transparency = a.Transparency + -1
        hrp.CFrame = a.CFrame * CFrame.Angles(0, math.rad(math.random(0, 360)), 0) + hrp.CFrame[vectors[math.random(#vectors)]] * scalars[math.random(#scalars)]
        local args = {
            [1] = "placeaegisturret",
            [3] = _G.serverKey,
            [4] = _G.playerKey
        }
        
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        wait(.2)
        end
        wait(0.5)
        for blast=1, 20 do
        local args = {
                    [1] = "immolate_ability",
                    [2] = game:GetService("Players").LocalPlayer.Character,
                    [3] = game:GetService("Players").LocalPlayer,
                    [4] = {
                        [1] = a.CFrame * CFrame.Angles(0, math.rad(math.random(0, 360)), 0) + hrp.CFrame[vectors[math.random(#vectors)]] * scalars[math.random(#scalars)] + Vector3.new(0, -1, 0)
                    }
                }
                
        workspace.ServerStuff.applyGore:FireServer(unpack(args))
        task.wait(.1)
        end
        a:Destroy()
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", perk)
    end
end)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.B then
        local perk = game.Players.LocalPlayer.Character.current_perk.Value
        local plr =game.Players.LocalPlayer
        local hrp =plr.Character.HumanoidRootPart
        local playerAnimation = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.animationSets.TPanimSets["2SKIN"].skinner_break)
        playerAnimation.Priority = Enum.AnimationPriority.Action
        playerAnimation:AdjustSpeed(.75)
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", "dagger")
        workspace.ServerStuff.retrieveStats:InvokeServer()
        workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "enough", game.Workspace)
        workspace.ServerStuff.playAudio:FireServer({ [1] = "ai", [2] = "boss" }, "enough", game.Workspace)
        playerAnimation:Play()
        workspace.ServerStuff.playAudio:FireServer({ [1] = "gamemode"}, "shadowspawn", game.Workspace)
        workspace.ServerStuff.playAudio:FireServer({ [1] = "perks"}, "sov_hex", game.Workspace)
        workspace.ServerStuff.playAudio:FireServer({ [1] = "perks", [2] = "two"}, "summon_tagged", game.Workspace)
        --// Alert
        wait(1)
        for alert=1, 3 do
        workspace.ServerStuff.playAudio:FireServer({ [1] = "holdout", [2] = "boss_sounds" }, "sickler", game.Workspace)
        end
        --// Cursing
        for _,npc in pairs(game.Workspace.activeHostiles:GetChildren()) do
        local args = {
            [1] = "sov_dagger",
            [2] = {
                [1] = npc:FindFirstChild("Torso"),
                [2] = Vector3.new(136.77305603027344, -2.4050912857055664, -1.0685887336730957)
            },
            [3] = _G.serverKey,
            [4] = _G.playerKey
        }
        
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        wait(0.1)
        local args = {
            [1] = {
                [1] = "meleedamage",
                [2] = npc,
                [3] = "shove",
                [4] = false,
                [5] = "Fist",
                [6] = false,
                [7] = false,
                [8] = {
                    ["leg"] = true,
                    ["tough"] = true,
                    ["thick"] = true
                },
                [10] = {
                    ["speedrating"] = 2,
                    ["blacklisted"] = true,
                    ["animset"] = "Fists",
                    ["desc"] = "Trusty ol' painless. Great for when you're in a pickle or feel like getting up close and personal.",
                    ["chargerating"] = 2,
                    ["weapontype"] = "Fists",
                    ["name"] = "Fists",
                    ["damagerating"] = {
                        [1] = 6,
                        [2] = 20
                    },
                    ["ability"] = "Better than nothing.",
                    ["icon"] = "2195005475",
                    ["sizerating"] = 1
                }
            },
            [3] = _G.serverKey,
            [4] = _G.playerKey
        }
        
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        workspace.ServerStuff.dealDamage:FireServer(unpack(args))
        wait(.1)
        end
        workspace.ServerStuff.changeStats:InvokeServer("changeclass", perk)
    end
end)
































