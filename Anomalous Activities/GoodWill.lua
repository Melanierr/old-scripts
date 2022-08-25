if game.PlaceId ~= 8770868695 then
    return
end
game.StarterGui:SetCore("SendNotification", {
    Title = "Loading...",
    Text = "Enter a round to fully load.",
    Icon = "rbxassetid://2541869220",
    Duration = 4
})

repeat
    wait()
until game.Players.LocalPlayer ~= nil

function hb()
    for i, v in pairs(game.Workspace.mainGame.active_anomaly:GetChildren()) do
        v.Torso.Transparency = 0
        v.Head.Transparency = 0
        v.LeftLeg.Transparency = 0
        v.RightLeg.Transparency = 0
    end
end
local Plr = game.Players.LocalPlayer
local sword = game.ReplicatedStorage.weapon_modules.sword
local gui = workspace.merc_customisation.gui.tactical
local shotgun = game.ReplicatedStorage.weapon_modules.dbgun
local gui1 = workspace.merc_customisation.gui.secondary
local r = game.Players.LocalPlayer.PlayerGui.mainGui
local library =
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("GoodWill", 5013109572)
local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(2, 1, 2),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),
    TextColor = Color3.fromRGB(255, 255, 255)
}
local page = venyx:addPage("Main", 5012544693)
local section1 = page:addSection("MERCs")
local section2 = page:addSection("Subject, WIP")
section1:addButton("Fast Anchor  ( V )", function()
    Plr:GetMouse().KeyDown:Connect(function(K)
        if K == "v" then
            workspace.mainGame.remotes.game_handler:FireServer("interaction", {
                ["with"] = workspace.CurrentMap.Interactables.A
            })
            workspace.mainGame.remotes.game_handler:FireServer("interaction", {
                ["with"] = workspace.CurrentMap.Interactables.B
            })
            workspace.mainGame.remotes.game_handler:FireServer("interaction", {
                ["with"] = workspace.CurrentMap.Interactables.C
            })
            workspace.mainGame.remotes.game_handler:FireServer("interaction", {
                ["with"] = workspace.CurrentMap.Interactables.D
            })
            workspace.mainGame.remotes.game_handler:FireServer("interaction", {
                ["with"] = workspace.CurrentMap.Interactables.E
            })
        end
    end)
    game.StarterGui:SetCore("SendNotification", {
        Text = "Press V to finish anchor, requires to stand near an anchor.",
        Icon = "rbxassetid://2541869220", -- image
        Duration = 2
    })
    print("clicked")
end)
local page1 = venyx:addPage("ESP", 5012544693)
local section1 = page1:addSection("Main")
section1:addButton("Chams", function()
    local function added(child)
        if child.Name == "active_anomaly" then
            task.wait()
            for _, n in pairs(child:GetChildren()) do
                task.spawn(function()
                    task.wait(.5)
                    local p = n:FindFirstChild("Head")
                    if p then
                        local e = Instance.new("Highlight")
                        e.Adornee = n
                        e.Enabled = true
                        e.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        e.Parent = n
                    end
                end)
            end
            child.ChildAdded:Connect(function(n)
                task.wait(.5)
                local p = n:FindFirstChild("Head")
                if p then
                    local e = Instance.new("Highlight")
                    e.Adornee = n
                    e.Enabled = true
                    e.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    e.Parent = n
                end
            end)
        end
    end

    workspace.DescendantAdded:Connect(added)

    for _, n in pairs(workspace:GetDescendants()) do
        added(n)
    end
    print("clicked")
end)
section1:addButton("Visible Subject", function()
    hb()
    print("clicked")
end)
local page2 = venyx:addPage("Misc", 5012544693)
local section1 = page2:addSection("imagine exploiting :OO!!")
section1:addButton("Get VT7 sword ( murasama )", function()
    workspace.mainGame.remotes.change_equipped:FireServer("merc", {
        ["item"] = sword,
        ["gui"] = gui
    })
    print("clicked")
end)
section1:addButton("Get Double Barrel shotgun ( Caldwell 980 ) ", function()
    workspace.mainGame.remotes.change_equipped:FireServer("merc", {
        ["item"] = shotgun,
        ["gui"] = gui1
    })
    print("clicked")
end)
section1:addButton("Remove annoying overlay", function()
    r.death_screen.Visible = false
    r.blackOverlay.Visible = false
end)
local section2 = page2:addSection("Credit to Windreve for the chams.")
