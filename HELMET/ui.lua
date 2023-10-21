local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HELMET", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("More will be added!")

Section:NewButton("Hostile ESP", "", function()
    function check()
        for _, a in pairs(workspace:GetChildren()) do
            if a.Name == "Hostile" and a.Name ~= "Civilian" then
                local b = Instance.new("Highlight", a)
            end
        end
    end

    game.Workspace.ChildAdded:Connect(function()
        wait(2)
        check()
    end)

    check()
end)

Section:NewButton("Skip Keycard Door", "", function()
    local objectives = game:GetService("Workspace").Map.Objectives
    local keycardDoor = objectives:FindFirstChild("KeycardDoor")
    if keycardDoor then
        keycardDoor:Destroy()
    end
end)

Section:NewButton("Check for Keycard", "", function()
    local keycard = game:GetService("Workspace").Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild("Keycard")
    if keycard then
        local highlight = Instance.new("Highlight", keycard)
    end
end)

Section:NewButton("Objective ESP", "", function()
    local objectives = game:GetService("Workspace").Map.Objectives

    for _, o in pairs(objectives:GetChildren()) do
        local highlight = Instance.new("Highlight", o)
    end

    objectives.ChildAdded:Connect(function(ob)
        local highlight = Instance.new("Highlight", ob)
    end)
end)
