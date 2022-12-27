local id = "774d46f3-bbac-453d-bf6b-1abd66f154d7" -- the player key
local plr = game.Players.LocalPlayer
local chest = game:GetService("Workspace"):FindFirstChild("Chests")
local root = plr.Character.HumanoidRootPart
--local adress = game:GetService("Workspace").WinterWonderland.Map["Address Labels"]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("doodle world", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Stuff")
--// Setups
Section:NewButton("TP to XMAS Screen", "teleports you to xmas screen", function()
    root.CFrame = game:GetService("Workspace").XMasScreen.CFrame + Vector3.new(4 , 0, 4)
end)
Section:NewButton("TP chests", "teleports chests to your location", function()
    for _, tp in pairs(game.Workspace:GetDescendants()) do
        if tp.Name == "Keyhole" then
            tp.Parent:GetPivot()
            tp.Parent:PivotTo(plr.Character.Head.CFrame + Vector3.new(-4, 0, -4))
            --plr.Character.HumanoidRootPart.CFrame = tp.CFrame
            wait(0.1)
        end
    end
end)
Section:NewButton("Heal pets", "IN DEV", function()
    game:GetService("Players").LocalPlayer.Event:FireServer(id, "PlayerData", "Heal")
end)
--// note that the remote can only be used once, don't spam it or either get kicked by the AC
-- game:GetService("Players").LocalPlayer.Function:InvokeServer(id, "DeliverPresent", "C2")
--// this remote complete the task but I haven't found a way to get player's id, those remote above is also.
Section:NewSlider("WalkSpeed", "", 200, 25, function(speed) -- 500 (MaxValue) | 0 (MinValue)
    plr.Character.Humanoid.WalkSpeed = speed
end)
local Tab = Window:NewTab("TP")
local Section = Tab:NewSection("Locations for events")
Section:NewButton("TP to Santa", "IN DEV", function()
    root.CFrame = CFrame.new(196, -183, -2632)
end)
Section:NewDropdown("Area A houses", "", {"A1", "A2", "A3", 'A4', 'A5', 'A6', 'A7', 'A8'}, function(currentOption)
    if currentOption == "A1" then
        root.CFrame = CFrame.new(381, -183, -2792)
    end
    if currentOption == 'A2' then
        root.CFrame = CFrame.new(383, -183, -2899)
    end
    if currentOption == 'A3' then
        root.CFrame = CFrame.new(259, -183, -3016)
    end
    if currentOption == "A4" then
        root.CFrame = CFrame.new(212, -183, -2895)
    end
    if currentOption == 'A5' then
        root.CFrame = CFrame.new(37, -183, -3025)
    end
    if currentOption == 'A6' then
        root.CFrame = CFrame.new(13, -183, -2899)
    end
    if currentOption == "A7" then
        root.CFrame = CFrame.new(-108, -183, -2889)
    end
    if currentOption == 'A8' then
        root.CFrame = CFrame.new(-182, -183, -3026)
    end
end)
Section:NewDropdown("Area B houses", "", {"B1", "B2", "B3", 'B4', 'B5', 'B6', 'B7'}, function(currentOption)
    if currentOption == "B1" then
        root.CFrame = CFrame.new(36, -182, -2784)
    end
    if currentOption == 'B2' then
        root.CFrame = CFrame.new(-46, -182, -2781)
    end
    if currentOption == 'B3' then
        root.CFrame = CFrame.new(-118, -183, -2685)
    end
    if currentOption == 'B4' then
        root.CFrame = CFrame.new(-143, -183, -2552)
    end
    if currentOption == 'B5' then
        root.CFrame = CFrame.new(-299, -183, -2680)
    end
    if currentOption == 'B6' then
        root.CFrame = CFrame.new(-170, -183, -2750)
    end
    if currentOption == 'B7' then
        root.CFrame = CFrame.new(-314, -183, -2839)
    end
end)
Section:NewDropdown("Area C houses", "", {"C1", "C2", "C3", 'C4', 'C5', 'C6', 'C7'}, function(currentOption)
    if currentOption == "C1" then
        root.CFrame = CFrame.new(205, -183, -2518)
    end
    if currentOption == 'C2' then
        root.CFrame = CFrame.new(176, -183, -2517)
    end
    if currentOption == 'C3' then
        root.CFrame = CFrame.new(126, -183, -2517)
    end
    if currentOption == 'C4' then
        root.CFrame = CFrame.new(94, -183, -2518)
    end
    if currentOption == 'C5' then
        root.CFrame = CFrame.new(54, -183, -2517)
    end
    if currentOption == 'C6' then
        root.CFrame = CFrame.new(38, -183, -2514)
    end
    if currentOption == 'C7' then
        root.CFrame = CFrame.new(-31, -185, -2471)
    end
end)
local Tab = Window:NewTab("Misc")
local Section = Tab:NewSection("")
Section:NewButton("Battle Assist", "IN DEV", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Aidez/doodle_world/main/battle_assist'),true))()
end)
Section:NewKeybind("", "", Enum.KeyCode.RightControl, function()
	Library:ToggleUI()
end)
