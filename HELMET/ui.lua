local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HELMET", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("More will be added!")
Section:NewButton("Gun Mod", "", function()
    local tool = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
	for i,v in pairs(tool:GetAttributes()) do
    		print(i,v)
    		tool:SetAttribute("Ammo", math.huge)
    		tool:SetAttribute("ClipSize", math.huge)
    		tool:SetAttribute("Firerate", 2000)
	end
end)





local Tab = Window:NewTab("Visual")
local Section0 = Tab:NewSection("!")
Section0:NewButton("Hostile ESP", "", function()
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

Section0:NewButton("Objective ESP", "", function()
    local objectives = game:GetService("Workspace").Map.Objectives
    for _, o in pairs(objectives:GetChildren()) do
        local highlight = Instance.new("Highlight", o)
    end
    objectives.ChildAdded:Connect(function(ob)
        local highlight = Instance.new("Highlight", ob)
    end)
end)
Section0:NewButton("Skip Keycard Door", "", function()
    -- Get the objectives from the workspace
    local objectives = game:GetService("Workspace").Map.Objectives
    local keycardDoor = objectives:FindFirstChild("KeycardDoor")
    if keycardDoor then
        keycardDoor:Destroy()
    end
end)
Section0:NewButton("Check for Keycard", "", function()
    -- Get the Keycard object from the workspace
    local keycard = game:GetService("Workspace").Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild("Keycard")
    if keycard then
        local highlight = Instance.new("Highlight", keycard)
    end
end)


local Tabo = Window:NewTab("Performance")
local Section1 = Tabo:NewSection("Optimize da game")
Section1:NewButton("Remove shell casing", "", function()
	for _, model in pairs(game:GetService("ReplicatedStorage").Modules.Client.BulletShells:GetChildren()) do
		for _,shell in pairs(model:GetChildren()) do
			shell.Transparency = 1
		end
	end
end)
Section1:NewButton("Turn off Screen Effects", "", function()
	game.Players.LocalPlayer.PlayerGui.Effects.Enabled = false
end)
Section1:NewButton("Fullbright", "", function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
