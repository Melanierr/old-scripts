local a = Vector3.new(0, 0, 0)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruit", "Synapse")
local Tab = Window:NewTab("?")
--[[local Section = Tab:NewSection("Fighting Style")
    Section:NewButton("nigger leg", "", function()
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
    end)
    Section:NewButton("electro", "", function()
        
    end)
    Section:NewButton("kung fu", "", function()
        
    end)
    Section:NewButton("dragon breathing", "", function()
        
    end)
    Section:NewButton("super human", "", function()
        
    end)
]]
local Section = Tab:NewSection("?")
    Section:NewButton("Chest ESP", "Gives you the vision to see chest", function()
        for _,chest in pairs(game.Workspace:GetChildren()) do
            if chest.Name == "Chest1" or chest.Name == "Chest2" or chest.Name == 'Chest3' and chest:IsA("Part") then
                local h = Instance.new("Highlight")
                h.Parent = chest
        
            end
        end
    end)
    Section:NewButton("TP NPCs", "Only NPCs in your area", function()
        for _, npc in pairs(game.Workspace.NPCs:GetChildren()) do
            a = a+ Vector3.new(-10, 0, -10)
            npc:GetPivot()
            npc:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + a)
        end 
    end)
