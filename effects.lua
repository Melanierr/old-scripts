local eff = require(game:GetService("Workspace").ServerStuff.Statistics["S_STATISTICS"])
if eff then
    eff.RespA.dur = 120
    eff.BuffC.dur = 120
    eff.Exha.dur = 0
    eff.Crp.dur = 0
    eff.Bld.dur = 0
    eff.HeavBld.intensity = 9999
    eff.Stealth.dur = 400
    eff.Vcd.dur = 0
    eff.Brz.dur = 240
    eff.Arm.dur = 1000
    eff.ArtiB.dur = 60
    eff.AlkyA.dur = 120
    eff["3-(cbSTM)"].dur = 360
    eff["I4S-DS"].dur = 360
    eff["BL1 (Neloprephine)"].dur = 360
    eff["S44-UL1"].dur = 360
    eff.Pnk.dur = 360
    eff.Laz.dur = 360
    eff.Snr.dur = 0
    eff.Tnt.dur = 0
    eff.Slc.dur = 20

end

local aux2 = require(game:GetService("Workspace").ServerStuff.Statistics["AUX_STATISTICS"])
if aux2 then
    aux2.v2.use_per_night = math.huge
end
