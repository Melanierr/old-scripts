-- // Lobby
local repl = game:GetService("ReplicatedStorage")
local space = game:GetService("Workspace")
local light = game:GetService("Lighting")
local pgui = game:GetService("Players").LocalPlayer.PlayerGui
--//
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

    space.ElectricalPanel:Destroy()
    space.MedicalStuff:Destroy()
    space.engineer:Destroy()
    space.Chicken:Destroy()
    space.Posters:Destroy()
    space.jfj:Destroy()
for _,l in pairs(space:GetDescendants()) do
    if l:IsA("PointLight") then
        l:Destroy()
    end
    wait(.1)
end
game.StarterGui:SetCore("SendNotification", {
    Title = 'The lobby has been optimized';
    Text = "Thank you for your patience.";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
})
