local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HELMET", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("More will be added!")
Section:NewButton("Hostile ESP", "", function()
    -- Function to check for hostile objects and add highlights
    local function check()
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
    
    -- Initial check
    check()
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
Section:NewButton("Skip Keycard Door", "", function()
    -- Get the objectives from the workspace
    local objectives = game:GetService("Workspace").Map.Objectives
    local keycardDoor = objectives:FindFirstChild("KeycardDoor")
    if keycardDoor then
        keycardDoor:Destroy()
    end
end)
Section:NewButton("Check for Keycard", "", function()
    -- Get the Keycard object from the workspace
    local keycard = game:GetService("Workspace").Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild("Keycard")
    if keycard then
        local highlight = Instance.new("Highlight", keycard)
    end
end)
Section:NewButton("Fullbright", "", function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
