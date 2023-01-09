local uis = game:GetService("UserInputService")
isenabled = false
dounce = false
local defaultAmbient = game.Lighting.OutdoorAmbient
local sound = Instance.new("Sound", game.SoundService)
local cce = Instance.new("ColorCorrectionEffect", game.Lighting)
cce.Enabled = false
cce.Brightness = .2
cce.Contrast = .2
cce.TintColor = Color3.new(0.376471, 0.772549, 0.317647)
sound.SoundId = "rbxassetid://6361023770"

uis.InputBegan:Connect(function(input, processed)
if input.KeyCode == Enum.KeyCode.C then
if dounce == false then
dounce = true
if isenabled == false then
sound:Play()
game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
cce.Enabled = true
game.Lighting.ExposureCompensation = 1.5
isenabled = true
elseif isenabled == true then
sound:Play()
game.Lighting.OutdoorAmbient = defaultAmbient
cce.Enabled = false
game.Lighting.ExposureCompensation = 0
isenabled = false

end
else
wait(1.8)
dounce = false
end
end
end)
