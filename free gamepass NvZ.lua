for __,v in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalGamepasses:GetChildren()) do
        v.HasGamepass.Value = true
end
for _, a in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalBadges:GetChildren()) do
    a.HasBadge.Value = true
end
game:GetService("ReplicatedStorage").Miscs.Events.GetCurrentStatsEvent:InvokeServer()
game:GetService("ReplicatedStorage").Miscs.Events.GameplayUpdateEvent:FireServer()
