local mod = {}
mod.full_acc_aimed = true
mod.rpm_increase = 0.05
mod.rpm_increase_max = 10
mod.trigger_delay = 0.2
local supp = require(game.ReplicatedStorage['weapon_modules'].suppistol)
local lmg = require(game.ReplicatedStorage['weapon_modules'].lmg_aa)
if lmg then
    lmg.special_attributes = mod
    lmg.desc = "Slay until there's none left."
end
if supp then
    supp.speical_attributes = mod
end









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
        ["item"] = game:GetService("ReplicatedStorage").weapon_variants.suppistol,
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
        ["item"] = game:GetService("ReplicatedStorage").weapon_modules.stim,
        ["gui"] = workspace.merc_customisation.gui.equipment4
    }
}

workspace.mainGame.remotes.change_equipped:FireServer(unpack(args))
