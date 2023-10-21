local v0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))();
local v1 = v0.CreateLib("HELMET", "Synapse");
local v2 = v1:NewTab("Main");
local v3 = v2:NewSection("More will be added!");
v3:NewButton("Gun Mod", "", function()
	local v7 = 0;
	local v8;
	while true do
		if (v7 == (1385 - (1103 + 282))) then
			v8 = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool");
			for v46, v47 in pairs(v8:GetAttributes()) do
				local v48 = 0;
				while true do
					if (1 == v48) then
						v8:SetAttribute("ClipSize", math.huge);
						v8:SetAttribute("Firerate", 2000);
						break;
					end
					if (v48 == (0 + 0)) then
						print(v46, v47);
						v8:SetAttribute("Ammo", math.huge);
						v48 = 351 - (87 + 263);
					end
				end
			end
			break;
		end
	end
end);
local v2 = v1:NewTab("Visual");
local v4 = v2:NewSection("");
v4:NewButton("Enemy ESP", "", function()
	local function v9(v30)
		if ((tostring(v30.Name) == "Hostile") or (tostring(v30.Name) == "TaskForce")) then
			local v42 = 180 - (67 + 113);
			local v43;
			while true do
				if (v42 == 0) then
					v43 = Instance.new("Highlight", v30);
					v43.FillColor = Color3.fromRGB(187 + 68, 626 - 371, 188 + 67);
					v42 = 3 - 2;
				end
				if (v42 == (953 - (802 + 150))) then
					v43.FillTransparency = 0.7;
					v43.OutlineColor = Color3.fromRGB(686 - 431, 100, 0 - 0);
					v42 = 2;
				end
				if (v42 == 2) then
					v43.OutlineTransparency = 0.5 + 0;
					break;
				end
			end
		end
	end
	for v31, v32 in pairs(game.Workspace:GetChildren()) do
		v9(v32);
	end
	game.Workspace.ChildAdded:Connect(function(v33)
		v9(v33);
	end);
end);
v4:NewButton("Objective ESP", "", function()
	local v10 = 997 - (915 + 82);
	local v11;
	while true do
		if (v10 == (2 - 1)) then
			v11.ChildAdded:Connect(function(v49)
				local v50 = Instance.new("Highlight", v49);
			end);
			break;
		end
		if (v10 == 0) then
			v11 = game:GetService("Workspace").Map.Objectives;
			for v51, v52 in pairs(v11:GetChildren()) do
				local v53 = Instance.new("Highlight", v52);
			end
			v10 = 1 + 0;
		end
	end
end);
v4:NewButton("Skip Keycard Door", "", function()
	local v12 = game:GetService("Workspace").Map.Objectives;
	local v13 = v12:FindFirstChild("KeycardDoor");
	if v13 then
		v13:Destroy();
	end
end);
v4:NewButton("Check for Keycard", "", function()
	local v14 = game:GetService("Workspace").Map.Geometry.CameraRoom.KeycardSpawns:FindFirstChild("Keycard");
	if v14 then
		local v38 = Instance.new("Highlight", v14);
	end
end);
local v5 = v1:NewTab("Performance");
local v6 = v5:NewSection("Optimize da game");
v6:NewButton("Remove shell casing", "", function()
	for v34, v35 in pairs(game:GetService("ReplicatedStorage").Modules.Client.BulletShells:GetChildren()) do
		for v39, v40 in pairs(v35:GetChildren()) do
			v40.Transparency = 1 - 0;
		end
	end
end);
v6:NewButton("Remove screen effects", "", function()
	game.Players.LocalPlayer.PlayerGui.Effects.Enabled = false;
end);
v6:NewButton("Fullbright", "", function()
	local v16 = game:GetService("Lighting");
	v16.Brightness = 1189 - (1069 + 118);
	v16.ClockTime = 14;
	v16.FogEnd = 226871 - 126871;
	v16.GlobalShadows = false;
	v16.OutdoorAmbient = Color3.fromRGB(128, 279 - 151, 128);
end);
v6:NewButton("Optimize lighting", "", function()
	local v22 = workspace:FindFirstChildOfClass("Terrain");
	local v23 = game.Lighting;
	v22.WaterWaveSize = 0;
	v22.WaterWaveSpeed = 0;
	v22.WaterReflectance = 0 + 0;
	v22.WaterTransparency = 0 - 0;
	v23.GlobalShadows = false;
	v23.FogEnd = 8999999488;
	for v36, v37 in pairs(v23:GetDescendants()) do
		if (v37:IsA("BlurEffect") or v37:IsA("SunRaysEffect") or v37:IsA("BloomEffect") or v37:IsA("DepthOfFieldEffect")) then
			v37.Enabled = false;
		end
	end
end);
