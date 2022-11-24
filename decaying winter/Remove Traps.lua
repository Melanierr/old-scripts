for _, trap in pairs(game.Workspace.Interactables.ScavTraps:GetDescendants()) do
  if trap:IsA("Part") or trap:IsA("Mesh") then
    trap.CanCollide = false
  end
end
