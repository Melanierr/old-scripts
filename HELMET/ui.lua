local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HELMET", "Synapse")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("More will be added!")
Section:NewButton("Hostile ESP", "", function()
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
end)
