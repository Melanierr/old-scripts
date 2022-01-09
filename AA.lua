-- if game.PlaceId = 7884566060 then ..don't add this until the end..
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Donut Hub", "Sentinel")
local Tab = Window:NewTab("Player")
local Section = Tab:NewSection("Character")
Section:NewLabel("Credit : Irish#8707 and Applebox#0001")
Section:NewKeybind("Press RightCtrl", "open/close GUI", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)
Section:NewButton("Inf Jump", "For Anomaly only", function()
    local InfiniteJumpEnabled = true
    game:GetService("UserInputService").JumpRequest:connect(function()
        if InfiniteJumpEnabled then
            game:GetService "Players".LocalPlayer.Character:FindFirstChildOfClass 'Humanoid':ChangeState("Jumping")
        end
    end)
end)
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Modify")
Section:NewButton("ESP", "You have heat vision xD", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/frfeerrg/turbo-couscous/main/ESP'))()
end)
Section:NewButton("Damage Multiply", "Double your damage on all weapons", function()
    local settings = {
        repeatamount = 1.5,
        exceptions = {"SayMessageRequest"}
    }

    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = function(uh, ...)
        local args = {...}
        local method = getnamecallmethod()
        for i, o in next, settings.exceptions do
            if uh.Name == o then
                return old(uh, ...)
            end
        end
        if method == "FireServer" or method == "InvokeServer" then
            for i = 1, settings.repeatamount do
                old(uh, ...)
            end
        end
        return old(uh, ...)
    end

    setreadonly(mt, true)
    print("work")
end)
Section:NewButton("Full bright", "Achieve the power of light, credit to Applebox", function()
    local function brightFunc() ---loop  Fulbright
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
    brightFunc()
    game:GetService("RunService").RenderStepped:connect(function()
        brightFunc()
    end)
    local Section = Tab:NewSection("ONE SHOT")
    Section:NewButton("SWAG_MODE", "BECOMES OP/BANNABLE", function()
        local settings = {
            repeatamount = 10,
            exceptions = {"SayMessageRequest"}
        }

        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)

        mt.__namecall = function(uh, ...)
            local args = {...}
            local method = getnamecallmethod()
            for i, o in next, settings.exceptions do
                if uh.Name == o then
                    return old(uh, ...)
                end
            end
            if method == "FireServer" or method == "InvokeServer" then
                for i = 1, settings.repeatamount do
                    old(uh, ...)
                end
            end
            return old(uh, ...)
        end

        setreadonly(mt, true)
        print("work")
    end)
end)
