while true do
    spawn(function()
        for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
            if anomaly.Name == "HumanoidRootPart"  then
                local h = Instance.new("Highlight") 
                h.Parent = anomaly.Parent
            end
        end
        for _,v in pairs(game.Workspace.mainGame["active_anomaly"]:GetDescendants()) do
            if v.Name == "Head" then
                v.Size = Vector3.new(4, 4, 4)
                v.Transparency = 0.6
                v.CanCollide = false
            end
        end
    end)
wait()
end
