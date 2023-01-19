local sm = require(game:GetService("ReplicatedStorage")["weapon_variants"]["dmr_fd"])
local dp = require(game:GetService("ReplicatedStorage")["weapon_modules"]["suppistol"])
local shre = require(game:GetService("ReplicatedStorage")["weapon_variants"]["lmg_aa"])
local v31 = {}
    v31.full_acc_aimed = true
    v31.trigger_delay = 0.05
    v31.rpm_increase = 1
    v31.rpm_max_increase = 3
local v32 = {}
    v32.full_acc_aimed = true
if sm then
    sm.semi_automatic = false
    sm.special = "suppresed"
    sm.firing_sound = "sniperblack"
    sm.special_attributes = v32
end
if shre then
    shre.special_attributes = v31
    shre.firing_sound = "akimboblack"
end
if dp then
  dp.special_attributes= v31
  dp.semi_automatic= false
  dp.firing_sound = "blackgun"
end
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_variants.lmg_aa, ["gui"] = workspace.merc_customisation.gui.primary})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_variants.dmr_shell, ["gui"] = workspace.merc_customisation.gui.secondary})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_modules.suppistol, ["gui"] = workspace.merc_customisation.gui.pistol})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_modules.sparemags, ["gui"] = workspace.merc_customisation.gui.equipment1})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_modules.syringe, ["gui"] = workspace.merc_customisation.gui.equipment2})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_modules.platepiece, ["gui"] = workspace.merc_customisation.gui.equipment3})
workspace.mainGame.remotes.change_equipped:FireServer("merc",{["item"] = game:GetService("ReplicatedStorage").weapon_modules.stim, ["gui"] = workspace.merc_customisation.gui.equipment4})
warn("!")
