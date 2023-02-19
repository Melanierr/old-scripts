task.wait()--// Ingame
local repl = game:GetService("ReplicatedStorage")
local space = game:GetService("Workspace")
local light = game:GetService("Lighting")
local pgui = game:GetService("Players").LocalPlayer.PlayerGui
--//
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
while true do
    spawn(function()
        for _,v in pairs(space.CurrentMap:GetChildren()) do
            if v.Name =="Lights" and v:IsA("Model") then
                v:Destroy()
                task.wait(.1)
            end
        end
        wait()
        for _,object in pairs(space.CurrentMap:GetDescendants()) do
            if object:IsA("PointLight") then
                object:Destroy()
               task.wait(.1)
            end
            if object:IsA("Part") then
                object.Material = "Plastic"
                object.Color = Color3.new(128, 128, 128)
                task.wait()
            end
            if object:IsA("UnionOperation") then
                object.Material = "Plastic"
                object.Color = Color3.new(128, 128, 128)
                task.wait(.1)
            end
            if object:IsA("Texture") then
                object:Destroy()
                task.wait(.1)
            end
        end
    end)
task.wait()
end
game.StarterGui:SetCore("SendNotification", {
    Title = 'Thank you for your patience.';
    Text = "Vfx disabled, map will be optimized.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
