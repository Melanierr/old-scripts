_G.teamcheck = true -- team check
local plr = game.Players.LocalPlayer
while true do
    spawn(function()
        if _G.teamcheck == true then
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= plr and v.Team ~= plr.Team then
                    v.Character.Head.Size = Vector3.new(4, 4, 4)
                    v.Character.Head.Transparency = 0.4
                    v.Character.Head.CanCollide = false
                end
            end
        end
        if _G.teamcheck == false then
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= plr then
                    v.Character.Head.Size = Vector3.new(4, 4, 4)
                    v.Character.Head.Transparency = 0.4
                    v.Character.Head.CanCollide = false
                end
            end
        end
    end)
wait()
end
local Sound = Instance.new("Sound",game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://232127604"
Sound:Play()
