local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_variants.lmg_aa,
        ["gui"] = workspace.merc_customisation.gui.primary
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags,
        ["gui"] = workspace.merc_customisation.gui.secondary
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.pistol_diab,
        ["gui"] = workspace.merc_customisation.gui.pistol
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))

local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags,
        ["gui"] = workspace.merc_customisation.gui.equipment1
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags,
        ["gui"] = workspace.merc_customisation.gui.equipment2
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))

local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags,
        ["gui"] = workspace.merc_customisation.gui.equipment3
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))

local args = {
    [1] = "merc",
    [2] = {
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags,
        ["gui"] = workspace.merc_customisation.gui.equipment4
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
