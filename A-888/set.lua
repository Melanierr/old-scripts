local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sniperblack,
        ["gui"] = workspace.merc_customisation.gui.primary
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.blackgun,
        ["gui"] = workspace.merc_customisation.gui.secondary
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.akimboblack,
        ["gui"] = workspace.merc_customisation.gui.pistol
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.syringe,
        ["gui"] = workspace.merc_customisation.gui.equipment1
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))

local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.platepiece,
        ["gui"] = workspace.merc_customisation.gui.equipment2
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.shrap,
        ["gui"] = workspace.merc_customisation.gui.equipment3
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.smoke,
        ["gui"] = workspace.merc_customisation.gui.equipment4
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_auxes.stim,
        ["gui"] = workspace.merc_customisation.gui.aux
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))

for _,gun in pairs(game.ReplicatedStorage.weapon_modules:GetChildren()) do
    if gun:IsA("Module Script")then
        local v5 = {spare_moidfiers=100}
        local script = require(gun)
        script.special_attributes = v5
    end
end
