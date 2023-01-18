local ROOT = game.Players.LocalPlayer.Character.HumanoidRootPart
workspace.ServerStuff.changeStats:InvokeServer("changeclass", "mind")
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x + 10, ROOT.CFrame.y, ROOT.CFrame.z), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
    [3] = _G.serverKey,
    [4] = _G.playerKey

}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x, ROOT.CFrame.y, ROOT.CFrame.z + 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
     [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x - 10, ROOT.CFrame.y, ROOT.CFrame.z), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
      [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x, ROOT.CFrame.y, ROOT.CFrame.z - 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
   [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x + 10, ROOT.CFrame.y, ROOT.CFrame.z - 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
     [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x - 10, ROOT.CFrame.y, ROOT.CFrame.z + 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
      [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x + 10, ROOT.CFrame.y, ROOT.CFrame.z + 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
      [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
local args = {
    [1] = "dropmkiller",
    [2] = {
        [1] = CFrame.new(Vector3.new(ROOT.CFrame.x - 10, ROOT.CFrame.y, ROOT.CFrame.z - 10), Vector3.new(ROOT.CFrame.Position)),
        [2] = false
    },
     [3] = _G.serverKey,
    [4] = _G.playerKey
}
workspace.ServerStuff.dealDamage:FireServer(unpack(args))
