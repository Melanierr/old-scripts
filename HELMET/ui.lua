local plr = game.Players.LocalPlayer
local backpack = plr.Backpack
local char = plr.Character
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HELMET", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("More will be added!")
Section:NewButton("Inf Ammo", "", function()
    local tool = char:FindFirstChildWhichIsA("Tool")
    tool:SetAttribute("Ammo", math.huge)
    tool:SetAttribute("ClipSize", math.huge)
    for i,v in pairs(backpack:GetChildren()) do
        v:SetAttribute("Ammo", math.huge)
        v:SetAttribute("ClipSize", math.huge)
    end
end)
Section:NewButton("Fast Firerate", "", function()
    local tool = char:FindFirstChildWhichIsA("Tool")
    tool:SetAttribute("Firerate", tool:GetAttribute("Firerate") + 100)
    tool:SetAttribute("DamageDecreaseAdd", 0)
    for i,v in pairs(backpack:GetChildren()) do
        v:SetAttribute("Firerate", v:GetAttribute("Firerate") + 100)
        v:SetAttribute("DamageDecreaseAdd", 0)
    end
end)

local Tab = Window:NewTab("Visual")
local Section0 = Tab:NewSection("")
Section0:NewButton("Enemy ESP", "", function()
    local function putOnESP(object)
        if tostring(object.Name) == "Hostile" or tostring(object.Name) == "TaskForce" then
            local highlight = Instance.new("Highlight", object)
            highlight.FillColor = Color3.fromRGB(255, 255, 255) -- white
            highlight.FillTransparency = 0.6
            highlight.OutlineColor = Color3.fromRGB(255,0,0) -- black
            highlight.OutlineTransparency = 0
	elseif tostring(object.Name) == "Civilian" then
	    	local highlights = Instance.new("Highlight", object)
            highlights.FillColor = Color3.fromRGB(255, 255, 255) -- white
            highlights.FillTransparency = 0.6
            highlights.OutlineColor = Color3.fromRGB(0, 0, 0)-- red
            highlights.OutlineTransparency = 0
        end
    end
    for _,scan in pairs(game.Workspace:GetChildren()) do
        putOnESP(scan)
    end
    game.Workspace.ChildAdded:Connect(function(humanoid)
        putOnESP(humanoid)
    end)
end)

Section0:NewButton("Objective ESP", "", function()
    local objectives = game:GetService("Workspace").Map.Objectives
    for _, o in pairs(objectives:GetChildren()) do
        local h1 = Instance.new("Highlight", o)
    end
    objectives.ChildAdded:Connect(function(ob)
        local h2 = Instance.new("Highlight", ob)
    end)
end)
Section0:NewButton("Check for Keycard", "", function()
    local keycard = game:GetService("Workspace").Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild("Keycard")
    if keycard then
        local h3 = Instance.new("Highlight", keycard)
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
Section1:NewButton("Remove screen effects", "", function()
	game.Players.LocalPlayer.PlayerGui.Effects.Enabled = false
end)
Section1:NewButton("Fullbright", "", function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 0
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)
Section1:NewButton("Optimize lighting", "", function()
    local Terrain = workspace:FindFirstChildOfClass('Terrain')
    local Lighting = game.Lighting
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
    for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
end)
