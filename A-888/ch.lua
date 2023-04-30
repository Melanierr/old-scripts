local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "";
        Text = "Crosshair script could not be loaded because your executor is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Typing = false

local ViewportSize_ = Camera.ViewportSize / 2
local Axis_X, Axis_Y = ViewportSize_.X, ViewportSize_.Y

local HorizontalLine = Drawing.new("Line")
local VerticalLine = Drawing.new("Line")

_G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
_G.DefaultSettings = false   -- If set to true then the script would create a crosshair with the default settings regardless of any changes.
_G.ToMouse = true   -- If set to true then the crosshair will be positioned to your mouse cursor's position. If set to false it will be positioned to the center of your screen.

_G.CrosshairVisible = true   -- If set to true then the crosshair would be visible and vice versa.
_G.CrosshairSize = 24   -- The size of the crosshair.
_G.CrosshairThickness = 1.1   -- The thickness of the crosshair.
_G.CrosshairColor = Color3.fromRGB(0, 255, 0)   -- The color of the crosshair
_G.CrosshairTransparency = 1   -- The transparency of the crosshair.

_G.DisableKey = Enum.KeyCode.U   -- The key that enables / disables the crosshair.

RunService.RenderStepped:Connect(function()
    local Real_Size = _G.CrosshairSize / 2

    HorizontalLine.Color = _G.CrosshairColor
    HorizontalLine.Thickness = _G.CrosshairThickness
    HorizontalLine.Visible = _G.CrosshairVisible
    HorizontalLine.Transparency = _G.CrosshairTransparency
    
    VerticalLine.Color = _G.CrosshairColor
    VerticalLine.Thickness = _G.CrosshairThickness
    VerticalLine.Visible = _G.CrosshairVisible
    VerticalLine.Transparency = _G.CrosshairTransparency
    
    if _G.ToMouse == true then
        HorizontalLine.From = Vector2.new(UserInputService:GetMouseLocation().X - Real_Size, UserInputService:GetMouseLocation().Y)
        HorizontalLine.To = Vector2.new(UserInputService:GetMouseLocation().X + Real_Size, UserInputService:GetMouseLocation().Y)
        
        VerticalLine.From = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y - Real_Size)
        VerticalLine.To = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y + Real_Size)
    elseif _G.ToMouse == false then
        HorizontalLine.From = Vector2.new(Axis_X - Real_Size, Axis_Y)
        HorizontalLine.To = Vector2.new(Axis_X + Real_Size, Axis_Y)
    
        VerticalLine.From = Vector2.new(Axis_X, Axis_Y - Real_Size)
        VerticalLine.To = Vector2.new(Axis_X, Axis_Y + Real_Size)
    end
end)

if _G.DefaultSettings == true then
    _G.CrosshairVisible = true
    _G.CrosshairSize = 25
    _G.CrosshairThickness = 1
    _G.CrosshairColor = Color3.fromRGB(40, 90, 255)
    _G.CrosshairTransparency = 0.15
    _G.DisableKey = Enum.KeyCode.P
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == _G.DisableKey and Typing == false then
        _G.CrosshairVisible = not _G.CrosshairVisible
        
        if _G.SendNotifications == true then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "Exunys Developer";
                Text = "The crosshair's visibility is now set to "..tostring(_G.CrosshairVisible)..".";
                Duration = 5;
            })
        end
    end
end)
