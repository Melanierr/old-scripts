while true do
    for __,a in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalGamepasses:GetChildren()) do
        a.HasGamepass.Value = true
    end
    for _, b in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalBadges:GetChildren()) do
        b.HasBadge.Value = true
    end
    for _, c in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalReputations:GetChildren()) do
        c.HasRepuable.Value = true
    end
    
    for _, e in pairs(game.Players.LocalPlayer.ClassConfigurations.LocalAttachments:GetChildren()) do
        e.HasAttachment.Value = true
    end
    wait()
end
game:GetService("ReplicatedStorage").Miscs.Events.GetCurrentStatsEvent:InvokeServer()
game:GetService("ReplicatedStorage").Miscs.Events.GameplayUpdateEvent:FireServer()
