loadstring(game:HttpGet(('https://raw.githubusercontent.com/Aidez/decaying_winter/main/GOODWILL_COMMAND_SCRIPT'),true))()
wait(5)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/IrishBaker/script/main/effects.lua'),true))()
local a = game:GetService("Lighting")
local b = game:GetService("Lighting").Sky
b:destroy()
while true do
        game.Lighting.FogEnd = 10000
        game.Lighting.TimeOfDay = 10
        wait()
end
local bruh = (game:GetService("Workspace").Snow)
bruh:destroy()
