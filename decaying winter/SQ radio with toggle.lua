function radio(toogle)
local plr = game.Players.LocalPlayer.Character
local radio = game:GetService("Workspace").activeHostiles["AI_QUEEN"].Torso.radioback.musicpart
local cloneradio = radio:Clone()
cloneradio.Parent = plr.Torso
cloneradio.Transparency = 1
cloneradio.Anchored = true
cloneradio.Name = "lol"
cloneradio.steel.Looped = toogle
  
while true do
cloneradio.Position = plr.Torso.Position 
wait()
end
end
