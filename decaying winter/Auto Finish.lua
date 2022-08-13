local args = {
    [1] = workspace.InteractablesNoDel.Touch,
    [2] = "touchthing",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args)) -- knife

wait(0.3)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-74, 22, 166)) -- goto cultist small bunker wait
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(400, -3, -16)) -- go back to spawn
wait(2)
local args = {
    [1] = workspace.InteractablesNoDel.Keycard, -- get keycard
    [2] = "keycardget",
    [3] = 30515
}
game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(400, -3, -16)) -- go back to spawn
wait(4)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(72, -3, -198)) -- go to the basement door
local args = {
    [1] = workspace.InteractablesNoDel.Unlock, -- unloock the basement door
    [2] = "unlockthing",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(3)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-14, -64, -250)) -- go to the small door
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-165, -77, -210)) -- go to the laptop room
wait(0.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(72, -3, -198)) -- go to the basement door
wait(1)
local args = {
    [1] = workspace.InteractablesNoDel.Activate, -- activate laptop
    [2] = "activatething",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(1)
local args = {
    [1] = workspace.InteractablesNoDel:FindFirstChild("Acquire Masks"), -- get mask
    [2] = "acquirething",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(400, -3, -16)) -- go back to base
wait(1)
print("True ending is ready")
