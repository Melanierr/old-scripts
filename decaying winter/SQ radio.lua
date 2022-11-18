local plr = game.Players.LocalPlayer.Character
local radio = game:GetService("Workspace").activeHostiles["AI_QUEEN"].Torso.radioback.musicpart
local cloneradio = radio:Clone()
cloneradio.Parent = plr.Torso -- you know this
cloneradio.Transparency = 1
cloneradio.Anchored = true -- prevent the part from falling through the map
cloneradio.Name = "lol" -- changes name to avoid removal
cloneradio.steel.Looped = true -- ur choice
while true do
cloneradio.Position = plr.Torso.Position 
wait()
end
