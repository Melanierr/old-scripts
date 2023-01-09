for _, modules in pairs(game.ReplicatedStorage['weapon_modules']:GetChildren()) do
    if modules.Name ~= "syringe" and modules.Name ~= 'stim' and modules.Name ~= 'flash' and modules.Name ~= 'stamshot' and modules.Name ~= 'mine'  and modules.Name ~= "frag" then  
        local ms = require(modules)
        local v31 = {}
        v31.full_acc_aimed = true
        v31.trigger_delay = 0.1
        v31.rpm_increase = 0.1
        v31.rpm_max_increase = 20
        v31.not_shown = false
        v31.disallowed = false
        ms.semi_automatic = false
        ms.single_load = false
        ms.special_attributes = v31
    end
end
