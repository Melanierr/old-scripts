for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
    if anomaly.Name == "HumanoidRootPart"  then
        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")
    
        BillboardGui.Parent = anomaly.Parent
        BillboardGui.AlwaysOnTop = true
        BillboardGui.LightInfluence = 1
        BillboardGui.Size = UDim2.new(0, 30, 0, 30)
        BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
    
        TextLabel.Parent = BillboardGui
        TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Size = UDim2.new(2, 0, 2, 0)
        TextLabel.Text = "."
        TextLabel.TextColor3 = Color3.new(1, 0, 0)
        TextLabel.TextScaled = true
        wait()
    end
end
for _,v in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
    if v.Name == "Head" then
        v.Size = Vector3.new(4, 4, 4)
        v.Transparency = 0.6
        v.CanCollide = false
    end
end
