game.StarterGui:SetCore("SendNotification", {
    Text = "Traps are removed",
    Icon = "rbxassetid://9327507252",
    Duration = 4
})

while true do
local traps = game:GetService("Workspace").Interactables.ScavTraps
traps:destroy()
wait(10)
  end

