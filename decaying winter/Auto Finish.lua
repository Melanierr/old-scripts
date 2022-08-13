--// Variables

--// Services
local args = {
    [1] = workspace.InteractablesNoDel.Touch,
    [2] = "touchthing",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args)) -- knife

wait(0.3)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-74, 22, 166)) -- goto bunker wait
wait(2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(400, -3, -16))
wait(1)
local args = {
    [1] = workspace.InteractablesNoDel.Keycard,
    [2] = "keycardget",
    [3] = 30515
}
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(400, -3, -16))
wait(0.3)
game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(1)
local args = {
    [1] = workspace.InteractablesNoDel.Unlock,
    [2] = "unlockthing",
    [3] = 30515
}

wait(1)

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(1)
local args = {
    [1] = workspace.InteractablesNoDel.Activate,
    [2] = "activatething",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))
wait(2)
local args = {
    [1] = workspace.InteractablesNoDel:FindFirstChild("Acquire Masks"),
    [2] = "acquirething",
    [3] = 30515
}

game:GetService("ReplicatedStorage").Interactables.interaction:FireServer(unpack(args))

wait(5)
