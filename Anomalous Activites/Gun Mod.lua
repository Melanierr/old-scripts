for _, modules in pairs(game.ReplicatedStorage['weapon_modules']:GetChildren()) do
    if modules.Name ~= "syringe" and modules.Name ~= 'stim' and modules.Name ~= 'flash' and modules.Name ~= 'stamshot' and modules.Name ~= 'mine'  and modules.Name ~= "frag" then  
        local ms = require(modules)
        local v31 = {}
        v31.full_acc_aimed = true
        v31.trigger_delay = 0
        v31.rpm_increase = 1
        v31.rpm_max_increase = 30
        ms.semi_automatic = false
        ms.special_attributes = v31
    end
end
wait(1)
for _, modules in pairs(game.ReplicatedStorage['weapon_variants']:GetChildren()) do
        local ms = require(modules)
        local v31 = {}
        v31.full_acc_aimed = true
        v31.trigger_delay = 0.1
        v31.rpm_increase = 0.1
        v31.rpm_max_increase = 10
        ms.special_attributes = v31
end
