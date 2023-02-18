--// Setup
local repl = game:GetService("ReplicatedStorage")
local space = game:GetService("Workspace")
local light = game:GetService("Lighting")
local pgui = game:GetService("Players").LocalPlayer.PlayerGui
while true do
    spawn(function()
        local map=space.CurrentMap
    end)
    wait()
end

--// Functions

light.cc:Destroy()
light.sr:Destroy()
light.bl:Destroy()
light.Sky:Destroy()
light.FogEnd = 9e9
light.GlobalShadows=false
light.TimeOfDay=12
pgui.mainGui.blackOverlay.Visible=false
pgui.mainGui.splatterOverlay.Visible=false
pgui.mainGui.exfilOverlay.Visible=false
pgui.mainGui.death_screen.Visible=false
pgui.mainGui.boss_healthbar.bar.boss_name="Nigger Demon"
if optimize==true then
    space.ElectricalPanel:Destroy()
    space.MedicalStuff:Destroy()
    space.engineer:Destroy()
    space.Chicken:Destroy()
    space.Posters:Destroy()
    space.jfj:Destroy()
    
end
for _,l in pairs(space:GetDescendants()) do
    if l:IsA("PointLight") then
        l:Destroy()
    end
    wait(.1)
end
for _,weaponvfx in pairs(repl.weapon_effect:GetDescendants()) do
    if weaponvfx:IsA("ParticleEmitter") then
        weaponvfx.Enabled=false
    end
    if weaponvfx:IsA("Trail") then
        weaponvfx.Enabled=false
    end
end
for _,vfx in pairs(repl.misc_effects:GetDescendants()) do
    if vfx:IsA("ParticleEmitter") and vfx.Name ~='laser' and vfx.Name~='lens'then
        vfx.Enabled=false
    end
    if vfx:IsA("PointLight") and vfx.Name ~= "lightA" and vfx.Name ~="lightB" then
        vfx.Enabled=false
    end
    if vfx:IsA("MeshPart") then
        vfx.Transparency=1 
    end
end
while mapoptimize==true do
    spawn(function()
        for _,v in pairs(map:GetChildren()) do
            if v.Name =="Lights" and v:IsA("Model") then
                v:Destroy()
                wait(.1)
            end
        end
        wait()
        for _,object in pairs(map:GetDescendants()) do
            if object:IsA("PointLight") then
                object:Destroy()
                wait(.1)
            end
            if object:IsA("Part") or object:IsA("UnionOperation") then
                object.Material = "Plastic"
                object.Color = Color3.new(128, 128, 128)
                wait(.1)
            end
            if object:IsA("Texture") then
                object:Destroy()
                wait(.1)
            end
        end
    end)
wait()
end
print("Optimized")
