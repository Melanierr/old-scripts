local plr = game.Players.LocalPlayer
while true do
    spawn(function()
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= plr and v.Team ~= plr.Team then
                    v.Character.Head.Size = Vector3.new(4, 4, 4)
                    v.Character.Head.Transparency = 0.2
                    v.Character.Head.CanCollide = false
                end
            end
    wait()
    end)
wait()
end
