while true do
    spawn(function()
        for _, anomaly in pairs(game.Workspace.mainGame["active_anomaly"]:GetChildren()) do
            if anomaly:IsA("Model")  then
                local highlight = Instance.new("Highlight")
                highlight.Parent = anomaly
            else
                warn("Not a player or a minion")
            end
        end
    end)
wait()
end
