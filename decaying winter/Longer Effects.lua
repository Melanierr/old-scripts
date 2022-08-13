local eff = require(game:GetService("Workspace").ServerStuff.Statistics["S_STATISTICS"])
if eff then
    eff.RespA.dur = 120
    eff.BuffC.dur = 120
    eff.Exha.dur = 0
    eff.Crp.dur = 0
    eff.Bld.dur = 0
    eff.HeavBld.dur = 0
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
    eff.Rgn.dur = 360
    eff.Bnd.dur = 0
    end
wait(5)

game.StarterGui:SetCore("SendNotification", {
    Text = "Buffs are longer now.",
    Icon = "rbxassetid://2541869220",
    Duration = 4
})
