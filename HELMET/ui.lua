function check()
	for _,a in pairs (workspace:GetChildren()) do
		if a.Name =="Hostile" then
			local b =Instance.new("Highlight", a)
		end
	end
end
game.Workspace.ChildAdded:Connect(function()
	check()
end)	
check()
