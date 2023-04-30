local settings = {repeatamount = 6, exceptions = {"SayMessageRequest", "game_handler", "audio_relay", "weapon_vfx_relay", "voices_handler", "arm_handler", "player_respawn", "change_equipped", "resetter", "standing_handler", "effects_relay", "weapon_handler", "terror_handler", "equipment_handler", 'aux_handler', 'skill_handler'}}
            local mt = getrawmetatable(game)
            local old = mt.__namecall
            setreadonly(mt, false)
    
            mt.__namecall = function(uh, ...)
            local args = {...}
            local method = getnamecallmethod()
            for i,o in next, settings.exceptions do
                if uh.Name == o then
                    return old(uh, ...)
                end
            end
            if method == "FireServer" or method == "InvokeServer" then
                for i = 1,settings.repeatamount do
                    old(uh, ...)
                end
            end
            return old(uh, ...)
            end
            setreadonly(mt, true)
