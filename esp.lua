
local scriptver = 'v1.2.1'

if ( _G.RadarKill ) then
    _G.RadarKill()
end

--- Settings ---
local existingSettings = _G.RadarSettings or {}
local settings = {
    -- Radar settings
    RADAR_LINES = true; -- Displays distance rings
    RADAR_SCALE = 1; -- Controls how "zoomed in" the radar display is 
    RADAR_RADIUS = 125; -- The size of the radar itself
    RADAR_LINE_DISTANCE = 50; -- The distance between each line
    RADAR_ROTATION = true; -- Toggles radar rotation. Looks kinda trippy when disabled
    SMOOTH_ROT = true; -- Rotates the radar smoothly
    SMOOTH_ROT_AMNT = 20; -- Lower number is smoother, higher number is snappier 
    CARDINAL_DISPLAY = true; -- Displays each cardinal direction (NSWE) around the radar 

    -- Marker settings
    USE_QUADS = true; -- Displays radar markers as arrows instead of dots 
    OFFSCREEN_TRANSPARENCY = 0.3; -- Transparency of offscreen markers
    DISPLAY_TEAM_COLORS = true; -- Sets the radar markers' color to their player's team color
    DISPLAY_OFFSCREEN = true; -- Leaves offscreen markers visible
    DISPLAY_TEAMMATES = true; -- Shows your teammates' markers
    MARKER_SCALEMIN = 0.75; -- Minimium scale radar markers can be. Marker falloff bypasses this limit!
    MARKER_SCALEMAX = 1.75; -- Maximum scale radar markers can be. Marker falloff bypasses this limit!
    MARKER_FALLOFF = false; -- Affects the markers' scale depending on how far away the player is
    MARKER_FALLOFF_AMNT = 500; -- How close someone has to be for falloff to start affecting them 

    -- Theme
    RADAR_THEME = {
        Outline = Color3.fromRGB(35, 35, 45); -- Radar outline
        Background = Color3.fromRGB(25, 25, 35); -- Radar background
        DragHandle = Color3.fromRGB(50, 50, 255); -- Drag handle 
        
        Cardinal_Lines = Color3.fromRGB(110, 110, 120); -- Color of the horizontal and vertical lines
        Distance_Lines = Color3.fromRGB(65, 65, 75); -- Color of the distance rings
        
        Generic_Marker = Color3.fromRGB(255, 25, 115); -- Color of a player marker without a team
        Local_Marker = Color3.fromRGB(115, 25, 255); -- Color of your marker, regardless of team
    };
}

for k, v in pairs(existingSettings) do 
    if ( v ~= nil ) then
        settings[k] = v 
    end
end

-- localize each setting (settings aren't meant to be changed during runtime)
local RADAR_LINES = settings.RADAR_LINES
local RADAR_SCALE = settings.RADAR_SCALE
local RADAR_RADIUS = settings.RADAR_RADIUS
local RADAR_LINE_DISTANCE = settings.RADAR_LINE_DISTANCE
local RADAR_ROTATION = settings.RADAR_ROTATION
local SMOOTH_ROT = settings.SMOOTH_ROT
local SMOOTH_ROT_AMNT = settings.SMOOTH_ROT_AMNT
local CARDINAL_DISPLAY = settings.CARDINAL_DISPLAY

local USE_QUADS = settings.USE_QUADS
local OFFSCREEN_TRANSPARENCY = settings.OFFSCREEN_TRANSPARENCY
local DISPLAY_TEAM_COLORS = settings.DISPLAY_TEAM_COLORS 
local DISPLAY_OFFSCREEN = settings.DISPLAY_OFFSCREEN
local DISPLAY_TEAMMATES = settings.DISPLAY_TEAMMATES
local MARKER_SCALEMIN = settings.MARKER_SCALEMIN
local MARKER_SCALEMAX = settings.MARKER_SCALEMAX
local MARKER_FALLOFF = settings.MARKER_FALLOFF 
local MARKER_FALLOFF_AMNT = settings.MARKER_FALLOFF_AMNT

local RADAR_THEME = settings.RADAR_THEME 


--- Services ---
local inputService = game:GetService('UserInputService')
local runService = game:GetService('RunService')
local playerService = game:GetService('Players')

--- Localization ---
local newV2 = Vector2.new
local newV3 = Vector3.new

local mathSin = math.sin
local mathCos = math.cos
local mathExp = math.exp

--- Script connections ---
local scriptCns = {}

--- Other variables
local markerScale = math.clamp(RADAR_SCALE, MARKER_SCALEMIN, MARKER_SCALEMAX)
local scaleVec = newV2(markerScale, markerScale)

local quadPointA = newV2(0, 5)   * scaleVec
local quadPointB = newV2(4, -5)  * scaleVec
local quadPointC = newV2(0, -3)  * scaleVec
local quadPointD = newV2(-4, -5) * scaleVec

--- Drawing setup ---
local drawObjects = {}
local function newDrawObj(objectClass, objectProperties) -- this method is cringe but it's easy to work with 
    local obj = Drawing.new(objectClass)
    table.insert(drawObjects, obj)
    
    for i, v in pairs(objectProperties) do
        obj[i] = v
    end

    objectProperties = nil
    return obj
end


-- Drawing tween function 
local drawingTween do -- obj property dest time 
    local function numLerp(a, b, c) 
        return (1 - c) * a + c * b
    end
    
    local tweenTypes = {}
    tweenTypes.Vector2 = Vector2.zero.Lerp
    tweenTypes.number = numLerp
    tweenTypes.Color3 = Color3.new().Lerp
    
    
    function drawingTween(obj, property, dest, duration) 
        task.spawn(function()
            local initialVal = obj[property]
            local tweenTime = 0
            local lerpFunc = tweenTypes[typeof(dest)]
            
            while ( tweenTime < duration ) do 
                
                obj[property] = lerpFunc(initialVal, dest, 1 - math.pow(2, -10 * tweenTime / duration))
                
                local deltaTime = task.wait()
                tweenTime += deltaTime
            end

            obj[property] = dest
        end)
    end
end

--- Local object manager --- 
local clientPlayer = playerService.LocalPlayer
local clientRoot, clientHumanoid do 
    
    scriptCns.charRespawn = clientPlayer.CharacterAdded:Connect(function(newChar) 
        clientRoot = newChar:WaitForChild('HumanoidRootPart')
        clientHumanoid = newChar:WaitForChild('Humanoid')
    end)
    
    if ( clientPlayer.Character ) then 
        clientRoot = clientPlayer.Character:FindFirstChild('HumanoidRootPart')
        clientHumanoid = clientPlayer.Character:FindFirstChild('Humanoid')
    end
end

local clientCamera do 
    scriptCns.cameraUpdate = workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function() 
        clientCamera = workspace.CurrentCamera or workspace:FindFirstChildOfClass('Camera')
    end)

    clientCamera = workspace.CurrentCamera or workspace:FindFirstChildOfClass('Camera')
end

local clientTeam do 
    scriptCns.teamUpdate = clientPlayer:GetPropertyChangedSignal('Team'):Connect(function() 
        clientTeam = clientPlayer.Team
    end)

    clientTeam = clientPlayer.Team
end

--- PlaceID Check --- 
do
    local id = game.PlaceId
    if ( id == 292439477 or id == 3233893879 ) then
        local notif = Drawing.new('Text')
        notif.Center = true
        notif.Color = Color3.fromRGB(255, 255, 255)
        notif.Font = Drawing.Fonts.UI
        notif.Outline = true
        notif.Position = newV2(clientCamera.ViewportSize.X / 2, 200)
        notif.Size = 30
        notif.Text = 'Games with custom character systems\naren\'t supported. Sorry!'
        notif.Transparency = 0
        notif.Visible = true

        
        drawingTween(notif, 'Transparency', 1, 0.25)
        drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 150), 0.25)
        task.wait(5)
        
        drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 200), 0.25)
        drawingTween(notif, 'Transparency', 0, 0.25)
        task.wait(3)
        
        for _, con in pairs(scriptCns) do 
            con:Disconnect()
        end
        notif:Remove()
        return
    else
        -- might as well place control notification here 
        local notif = Drawing.new('Text')
        notif.Center = true
        notif.Color = Color3.fromRGB(255, 255, 255)
        notif.Font = Drawing.Fonts.UI
        notif.Outline = true
        notif.Position = newV2(clientCamera.ViewportSize.X / 2, 200)
        notif.Size = 22
        notif.Text = ('Loaded Drawing Radar %s\n\nControls:\n[-]: zoom out     [+]: zoom in     [End]: exit script'):format(scriptver)
        notif.Transparency = 0
        notif.Visible = true

        task.spawn(function()
            task.wait(1)
            
            drawingTween(notif, 'Transparency', 1, 0.25)
            drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 150), 0.25)
            task.wait(8)
            
            drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 200), 0.25)
            drawingTween(notif, 'Transparency', 0, 0.25)
            task.wait(1)
            
            if ( workspace.StreamingEnabled ) then
                notif.Text = 'It looks like this game uses StreamingEnabled, which may mess with the radar!\nSorry if it doesn\'t work!'
                drawingTween(notif, 'Transparency', 1, 0.25)
                drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 150), 0.25)
                task.wait(5)
                
                drawingTween(notif, 'Position', newV2(clientCamera.ViewportSize.X / 2, 200), 0.25)
                drawingTween(notif, 'Transparency', 0, 0.25)
                task.wait(1)
            end
            
            notif:Remove()
        end)
    end
end

--- Player managers --- 
local playerManagers = {}
do 
    local function removePlayer(player) 
        local thisName = player.Name
        local thisManager = playerManagers[thisName]
        local thisPlayerCns = thisManager.Cns
                
        if ( thisManager.onLeave ) then 
            thisManager.onLeave()
        end
        
        for _, con in pairs(thisPlayerCns) do
            con:Disconnect()
        end
        
        thisManager.onDeath = nil
        thisManager.onLeave = nil
        thisManager.onRemoval = nil
        thisManager.onRespawn = nil
        thisManager.onTeamChange = nil 
        
        thisManager.Player = nil
        
        playerManagers[thisName] = nil 
    end
    
    local function readyPlayer(thisPlayer) 
        local thisName = thisPlayer.Name
        local thisManager = {}
        local thisPlayerCns = {}
        
        local function deathFunc() -- Reusable on-death function - done so the same function doesnt get made 9138589135 times 
            if ( thisManager.onDeath ) then
                thisManager.onDeath()
            end
        end

        -- Setup connections
        thisPlayerCns['chr-add'] = thisPlayer.CharacterAdded:Connect(function(newChar) -- This handles when a player respawns
            -- Get some important instances 
            local RootPart = newChar:WaitForChild('HumanoidRootPart')
            local Humanoid = newChar:WaitForChild('Humanoid')
            
            -- Call onRespawn
            if ( thisManager.onRespawn ) then
                thisManager.onRespawn(newChar, RootPart, Humanoid)
            end
            -- Update manager values 
            thisManager.Character = newChar
            thisManager.RootPart = RootPart
            thisManager.Humanoid = Humanoid
            
            -- Re-connect the death connection 
            if ( thisPlayerCns['chr-die'] ) then
                thisPlayerCns['chr-die']:Disconnect()
            end
            thisPlayerCns['chr-die'] = Humanoid.Died:Connect(deathFunc)
        end)

        thisPlayerCns['chr-remove'] = thisPlayer.CharacterRemoving:Connect(function() -- This handles when a player's character gets removed 
            -- Call onRemoval
            if ( thisManager.onRemoval ) then
                thisManager.onRemoval()
            end
            
            -- Update manager values 
            thisManager.Character = nil
            thisManager.RootPart = nil
            thisManager.Humanoid = nil 
        end)
        
        thisPlayerCns['team'] = thisPlayer:GetPropertyChangedSignal('Team'):Connect(function()  -- This handles team changing, self explanatory
            thisManager.Team = thisPlayer.Team
            
            if ( thisManager.onTeamChange ) then
                thisManager.onTeamChange(thisManager.Team)
            end
        end)
        
        -- Check for an existing character
        if ( thisPlayer.Character ) then
            -- Fetch some stuff
            local Character = thisPlayer.Character
            local Humanoid = Character:FindFirstChild('Humanoid')
            local RootPart = Character:FindFirstChild('HumanoidRootPart')

            -- Set manager values 
            thisManager.Character = Character
            thisManager.RootPart = RootPart
            thisManager.Humanoid = Humanoid 

            if ( Humanoid ) then
                -- Setup death connection *only if the humanoid exists*
                -- This previously wasn't checked for which probably constantly errored, oops 🗿
                thisPlayerCns['chr-die'] = Humanoid.Died:Connect(deathFunc)
            end
        end
        
        -- Set existing values 
        thisManager.Team = thisPlayer.Team
        thisManager.Player = thisPlayer
        thisManager.Name = thisName 
        thisManager.DisplayName = thisPlayer.DisplayName  
        
        -- Finalize
        thisManager.Cns = thisPlayerCns 
        playerManagers[thisName] = thisManager
    end
    
    -- Setup managers for every existing player 
    for _, player in ipairs(playerService:GetPlayers()) do
        if ( player ~= clientPlayer ) then
            readyPlayer(player)
        end
    end

    -- Setup managers for joining players, and clean managers for leaving players
    scriptCns.pm_playerAdd = playerService.PlayerAdded:Connect(readyPlayer)
    scriptCns.pm_playerRemove = playerService.PlayerRemoving:Connect(removePlayer)
end

--- Plugin managers --- 
-- The ability to make custom plugins / add-ons for the radar 
-- (to add stuff like npc support) might be developed eventually!

--- Radar UI --- 
local radarLines = {}
local radarObjects = {}
local radarPosition = newV2(300, 250)

radarObjects.main = newDrawObj('Circle', {
    Color = RADAR_THEME.Background;
    Position = radarPosition; 
    
    Filled = true;
    Visible = true;
    
    NumSides = 40;
    Radius = RADAR_RADIUS;
    ZIndex = 300;
})

radarObjects.outline = newDrawObj('Circle', {
    Color = RADAR_THEME.Outline;
    Position = radarPosition; 
    
    Filled = false;
    Visible = true;
    
    NumSides = 40;
    Thickness = 10;
    Radius = RADAR_RADIUS;
    ZIndex = 299;
})

radarObjects.dragHandle = newDrawObj('Circle', {
    Color = RADAR_THEME.DragHandle;
    Position = radarPosition; 
    
    Filled = false;
    Visible = false;
    
    NumSides = 40;
    Radius = RADAR_RADIUS;
    Thickness = 3;
    ZIndex = 325;
})

radarObjects.zoomText = newDrawObj('Text', {
    Center = true;
    Color = Color3.fromRGB(255, 255, 255);
    Font = Drawing.Fonts.UI;
    Outline = true;
    Size = 20;
    Transparency = 0;
    Visible = true;
    ZIndex = 305;
})

radarObjects.hoverText = newDrawObj('Text', {
    Center = true;
    Color = Color3.fromRGB(255, 255, 255);
    Font = Drawing.Fonts.UI;
    Outline = true;
    Size = 16;
    Transparency = 1;
    Visible = true;
    ZIndex = 305;
})

-- center marker
if ( USE_QUADS ) then 
    radarObjects.centerMark = newDrawObj('Quad', {
        Color = RADAR_THEME.Local_Marker;
        PointA = radarPosition + quadPointA;
        PointB = radarPosition + quadPointB;
        PointC = radarPosition + quadPointC;
        PointD = radarPosition + quadPointD;
        
        Filled = true;
        Visible = true;
        
        ZIndex = 303;
        Thickness = 2;
    })
else
    radarObjects.centerMark = newDrawObj('Circle', {
        Color = RADAR_THEME.Local_Marker;
        Position = radarPosition; 
        
        Filled = true;
        Visible = true;
        
        NumSides = 20;
        Radius = 3 * markerScale;
        Thickness = 2;
        ZIndex = 303;
    })
end

-- lines
if ( RADAR_LINES ) then 
    for i = 0, RADAR_RADIUS, RADAR_SCALE * RADAR_LINE_DISTANCE do 
        local thisLine = newDrawObj('Circle', {
            Color = RADAR_THEME.Distance_Lines;
            Position = radarPosition; 
            Radius = i;
            
            Filled = false;
            Visible = true;
            
            Transparency = ((i / RADAR_LINE_DISTANCE) % 4 == 0) and 0.8 or 0.2;
            NumSides = 40;
            Thickness = 1;
            ZIndex = 300;
        })
        
        table.insert(radarLines, thisLine)
    end
    
    radarObjects.horizontalLine = newDrawObj('Line', {
        Color = RADAR_THEME.Cardinal_Lines;
        From = radarPosition - newV2(RADAR_RADIUS, 0);
        To = radarPosition + newV2(RADAR_RADIUS, 0);
                
        Visible = true; 
        
        Thickness = 1;
        Transparency = 0.2;
        ZIndex = 300;
    })
    
    radarObjects.verticalLine = newDrawObj('Line', {
        Color = RADAR_THEME.Cardinal_Lines;
        From = radarPosition - newV2(0, RADAR_RADIUS);
        To = radarPosition + newV2(0, RADAR_RADIUS);
        
        Visible = true; 
        
        Thickness = 1;
        Transparency = 0.2;
        ZIndex = 300;
    })
else
    radarLines = nil 
end

-- NSWE display 
if ( CARDINAL_DISPLAY ) then
    radarObjects.directionN = newDrawObj('Text', {
        Center = true;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Drawing.Fonts.UI;
        Outline = true;
        Size = 16;
        Text = 'N';
        Transparency = 1;
        Visible = true;
        ZIndex = 303;
    })

    radarObjects.directionS = newDrawObj('Text', {
        Center = true;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Drawing.Fonts.UI;
        Outline = true;
        Size = 16;
        Text = 'S';
        Transparency = 1;
        Visible = true;
        ZIndex = 303;
    })

    radarObjects.directionW = newDrawObj('Text', {
        Center = true;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Drawing.Fonts.UI;
        Outline = true;
        Size = 16;
        Text = 'W';
        Transparency = 1;
        Visible = true;
        ZIndex = 303;
    })

    radarObjects.directionE = newDrawObj('Text', {
        Center = true;
        Color = Color3.fromRGB(255, 255, 255);
        Font = Drawing.Fonts.UI;
        Outline = true;
        Size = 16;
        Text = 'E';
        Transparency = 1;
        Visible = true;
        ZIndex = 303;
    })
end

--- Other functions
local destroying = false 
local function killScript() 
    if ( destroying ) then
        return
    end 
    
    destroying = true
    
    for _, con in pairs(scriptCns) do 
        con:Disconnect()
    end
    
    task.wait()
    for name, manager in pairs(playerManagers) do 
        for _, con in pairs(manager.Cns) do
            con:Disconnect()
        end
        
        -- just in case 
        playerManagers.onDeath = nil 
        playerManagers.onLeave = nil 
        playerManagers.onRespawn = nil 
        playerManagers.onRemoval = nil 
        playerManagers.onTeamChange = nil 

        playerManagers[name] = nil 
    end
    
    for _, obj in ipairs(drawObjects) do 
        drawingTween(obj, 'Transparency', 0, 0.5)
    end
    
    task.wait(1)
    
    if ( not drawObjects ) then
        return
    end
    
    for _, obj in ipairs(drawObjects) do 
        obj:Remove()
        _G.RadarKill = nil 
    end
    drawObjects = nil
end

local function setRadarScale()   
    markerScale = math.clamp(RADAR_SCALE, MARKER_SCALEMIN, MARKER_SCALEMAX)
    
    if ( RADAR_LINES ) then
        -- Calculate how many radar lines can fit at this scale 
        local lineCount = math.floor(RADAR_RADIUS / (RADAR_SCALE * RADAR_LINE_DISTANCE))
        
        -- If more lines can fit than there are made, make more 
        if ( lineCount > #radarLines ) then
            for i = 1, lineCount - #radarLines do 
                
                local thisLine = newDrawObj('Circle', {
                    Color = RADAR_THEME.Distance_Lines;
                    
                    Position = radarPosition;
                    
                    Filled = false;
                    Visible = true;
                    
                    NumSides = 40;
                    Thickness = 1;
                    ZIndex = 300;
                })
                
                table.insert(radarLines, thisLine)
            end
        end
        
        -- Position every single line 
        for idx, line in ipairs(radarLines) do 
            if ( idx > lineCount ) then
                -- This line wont fit, hide it 
                line.Visible = false 
            else
                -- This line fits, set its radius and display it 
                line.Radius = idx * (RADAR_SCALE * RADAR_LINE_DISTANCE)
                line.Transparency = (idx % 4 == 0) and 0.8 or 0.2
                line.Visible = true
            end
        end
    end
    
    
    if ( USE_QUADS ) then 
        scaleVec = newV2(markerScale, markerScale)
        
        quadPointA = newV2(0, 5)   * scaleVec
        quadPointB = newV2(4, -5)  * scaleVec
        quadPointC = newV2(0, -3)  * scaleVec
        quadPointD = newV2(-4, -5) * scaleVec
    else
        radarObjects.centerMark.Radius = 3 * markerScale
    end
end

local function setRadarPosition(newPosition) 
    radarPosition = newPosition
        
    radarObjects.main.Position = newPosition
    radarObjects.outline.Position = newPosition
    
    
    if ( RADAR_LINES ) then
        for _, line in ipairs(radarLines) do 
            line.Position = newPosition
        end 
        
        radarObjects.horizontalLine.From = newPosition - newV2(RADAR_RADIUS, 0);
        radarObjects.horizontalLine.To = newPosition + newV2(RADAR_RADIUS, 0);
        
        radarObjects.verticalLine.From = newPosition - newV2(0, RADAR_RADIUS);
        radarObjects.verticalLine.To = newPosition + newV2(0, RADAR_RADIUS);
    end
end

--- Input and drag handling
do
    local radarDragging = false
    local radarHovering = false
    
    local zoomingIn = false
    local zoomingOut = false
        
    -- The keycode is only checked if its found in this dictionary,
    -- just so a giant elif chain isnt done on every keypress
    local keysToCheck = {
        End = true;
        Equals = true;
        Minus = true;
    }
    
    scriptCns.inputBegan = inputService.InputBegan:Connect(function(io) 
        local inputType = io.UserInputType.Name

        if ( inputType == 'Keyboard' ) then
            local keyCode = io.KeyCode.Name
            
            if ( not keysToCheck[keyCode] ) then
                return
            end
            
            if ( keyCode == 'End' ) then
                killScript() 
            elseif ( keyCode == 'Equals' ) then
                zoomingIn = true 
                
                local zoomText = radarObjects.zoomText
                zoomText.Position = radarPosition + newV2(0, RADAR_RADIUS + 25)
                drawingTween(zoomText, 'Transparency', 1, 0.3)
                
                local accel = 0.1
                
                scriptCns.zoomInCn = runService.Heartbeat:Connect(function(deltaTime) 
                    RADAR_SCALE = math.clamp(RADAR_SCALE + (deltaTime * accel), 0.02, 3)
                    accel += deltaTime
                    
                    zoomText.Text = ('Scale: %.2f'):format(RADAR_SCALE)
                    setRadarScale()
                end)
            elseif ( keyCode == 'Minus' ) then
                zoomingOut = true
                
                local zoomText = radarObjects.zoomText
                zoomText.Position = radarPosition + newV2(0, RADAR_RADIUS + 25)
                drawingTween(zoomText, 'Transparency', 1, 0.3)
                
                local accel = 0.1
                
                scriptCns.zoomOutCn = runService.Heartbeat:Connect(function(deltaTime) 
                    RADAR_SCALE = math.clamp(RADAR_SCALE - (deltaTime * accel), 0.02, 3)
                    accel += deltaTime
                    
                    zoomText.Text = ('Scale: %.2f'):format(RADAR_SCALE)
                    setRadarScale()
                end)    
            end
        elseif ( inputType == 'MouseButton1' ) then
            local mousePos = inputService:GetMouseLocation()
            
            if ( (mousePos - radarPosition).Magnitude < RADAR_RADIUS ) then
                radarDragging = true
                radarObjects.dragHandle.Visible = true
                
                scriptCns.dragCn = inputService.InputChanged:Connect(function(io) 
                    if ( io.UserInputType.Name == 'MouseMovement' ) then
                        local mousePos = inputService:GetMouseLocation()
                        radarObjects.dragHandle.Position = mousePos
                    end
                end)
            end
        end
    end)

    scriptCns.inputEnded = inputService.InputEnded:Connect(function(io) 
        local inputType = io.UserInputType.Name
        if ( inputType == 'Keyboard' ) then
            local keyCode = io.KeyCode.Name
            
            if ( not keysToCheck[keyCode] ) then
                return
            end
            
            if ( keyCode == 'Equals' ) then
                zoomingIn = false 
                
                drawingTween(radarObjects.zoomText, 'Transparency', 0, 0.3)
                
                local zoomCn = scriptCns.zoomInCn
                if ( zoomCn and zoomCn.Connected ) then 
                    zoomCn:Disconnect()
                end
            elseif ( keyCode == 'Minus' ) then
                zoomingOut = false
                
                drawingTween(radarObjects.zoomText, 'Transparency', 0, 0.3)
                
                local zoomCn = scriptCns.zoomOutCn
                if ( zoomCn and zoomCn.Connected ) then 
                    zoomCn:Disconnect()
                end
            end
            
        elseif ( inputType == 'MouseButton1' ) then
            if ( radarDragging ) then
                scriptCns.dragCn:Disconnect()
                radarDragging = false 
                
                setRadarPosition(radarObjects.dragHandle.Position)
                radarObjects.dragHandle.Visible = false 
            end
        end
    end)
end


--- Player marker setup
local playerMarks = {} do 
    local function initMark(thisPlayer)
        local thisName = thisPlayer.Name 
        local thisManager = playerManagers[thisName]
        
        local mark
        local text
        
        if ( USE_QUADS ) then 
            mark = Drawing.new('Quad')
            mark.Filled = true
            mark.Thickness = 2
            mark.Visible = true
            mark.ZIndex = 302
        else
            mark = Drawing.new('Circle')
            mark.Filled = true
            mark.NumSides = 20
            mark.Radius = 3 * markerScale
            mark.Thickness = 2
            mark.Visible = true
            mark.ZIndex = 302
        end
        
        text = Drawing.new('Text')
        text.Center = true
        text.Color = Color3.fromRGB(255, 255, 255)
        text.Font = Drawing.Fonts.UI
        text.Outline = true
        text.Size = 15
        text.Text = thisPlayer.DisplayName or thisName
        text.Visible = false
        text.ZIndex = 305
        
        if ( DISPLAY_TEAM_COLORS ) then
            mark.Color = thisManager.Player.TeamColor.Color
        else
            mark.Color = RADAR_THEME.Generic_Marker
        end
        
        table.insert(drawObjects, mark)
        table.insert(drawObjects, text)
        
        playerMarks[thisName] = mark
        
        thisManager.onDeath = function()
            mark.Filled = false
        end
        thisManager.onRespawn = function()
            mark.Filled = true
        end
        thisManager.onLeave = function()
            table.remove(drawObjects, table.find(drawObjects, mark))
            table.remove(drawObjects, table.find(drawObjects, text))

            task.spawn(function() 
                drawingTween(mark, 'Transparency', 0, 1)
                task.wait(1.3)
                mark:Remove()
            end)

            text:Remove()
            
            playerMarks[thisName] = nil
        end
        
        if ( DISPLAY_TEAM_COLORS ) then 
            thisManager.onTeamChange = function(team) 
                mark.Color = team.TeamColor.Color
            end
        end
    end
    
    for _, manager in pairs(playerManagers) do
        initMark(manager.Player)
    end
    
    scriptCns.addMarks = playerService.PlayerAdded:Connect(function(player) 
        task.wait(0.1) -- This will hopefully prevent loading issues
        initMark(player)
    end)
end

local hoverPlayer
-- Hover display
do 

    local lastCheckTime = 0
    
    scriptCns.inputChanged = inputService.InputChanged:Connect(function(input) 
        local nowTime = tick() -- Funky optimization 

        if ( nowTime - lastCheckTime > 0.05 and input.UserInputType.Name == 'MouseMovement' ) then
            lastCheckTime = nowTime
            local mousePos = inputService:GetMouseLocation()
            
            -- Check if the mouse is inside of the radar 
            if ( (mousePos - radarPosition).Magnitude < RADAR_RADIUS ) then
                -- Get the closest player and set the hover text to their name 

                local distanceThresh = 900 -- math.huge 🤓🤓🤓🤓🤓🤓🤓
                hoverPlayer = nil

                for thisName in pairs(playerManagers) do 
                    local thisMark = playerMarks[thisName]
                    -- safety marker check, in case the player hasnt finished loading in 
                    if ( not thisMark ) then
                        continue
                    end
                    
                    local markPos = thisMark[USE_QUADS and 'PointC' or 'Position']
                    local distance = (mousePos - markPos).Magnitude

                    if ( distance < distanceThresh ) then
                        distanceThresh = distance
                        hoverPlayer = thisName
                    end
                end
            else
                hoverPlayer = nil
                radarObjects.hoverText.Visible = false 
            end
        end
    end)
end


--- Main radar loop

-- Coordinate conversion functions
local function cartToPolar(x, y) 
    return math.sqrt(x^2 + y^2), math.atan2(y, x)
end
local function polarToCart(r, t) 
    return r * mathCos(t), r * mathSin(t)
end

do
    local finalLookVec = Vector3.zero
    
    local hOffset = newV2(RADAR_RADIUS, 0) -- Horizontal offset
    local vOffset = newV2(0, RADAR_RADIUS) -- Vertical offset
    
    local textOffset = newV2(0, 5)
    
    local rad90 = math.rad(90)
    local rad180 = math.rad(180)
    
    scriptCns.radarLoop = runService.Heartbeat:Connect(function(deltaTime) 
        -- Safety rootpart check
        if ( not clientRoot ) then 
            return 
        end

        local selfPos = clientRoot.Position
        local camAngle = 0 

        -- Camera angle
        do 
            if ( RADAR_ROTATION ) then 
                local cameraLookVec = clientCamera.CFrame.LookVector
                local fixedLookVec = newV3(cameraLookVec.X, 0, cameraLookVec.Z).Unit
                
                if ( SMOOTH_ROT ) then
                    finalLookVec = finalLookVec:Lerp(fixedLookVec, 1 - mathExp(-SMOOTH_ROT_AMNT * deltaTime))
                else
                    finalLookVec = fixedLookVec
                end
                
                camAngle = math.atan2(finalLookVec.X, finalLookVec.Z)
            end
        end
        
        -- Vertical and horizontal lines
        do 
            if ( RADAR_LINES ) then
                local top = -vOffset
                local bottom = vOffset
                local left = -hOffset
                local right = hOffset
                                
                local angleCos = mathCos(-camAngle)
                local angleSin = mathSin(-camAngle)
                
                local fixedTop    = radarPosition + newV2((top.X * angleSin)    - (top.Y * angleCos),    (top.X * angleCos)    + (top.Y * angleSin))
                local fixedBottom = radarPosition + newV2((bottom.X * angleSin) - (bottom.Y * angleCos), (bottom.X * angleCos) + (bottom.Y * angleSin))     
                local fixedLeft   = radarPosition + newV2((left.X * angleSin)   - (left.Y * angleCos),   (left.X * angleCos)   + (left.Y * angleSin))  
                local fixedRight  = radarPosition + newV2((right.X * angleSin)  - (right.Y * angleCos),  (right.X * angleCos)  + (right.Y * angleSin))  
                
                local hLine, vLine = radarObjects.horizontalLine, radarObjects.verticalLine
                
                hLine.From = fixedLeft
                hLine.To = fixedRight
                
                vLine.From = fixedTop
                vLine.To = fixedBottom

                if ( CARDINAL_DISPLAY ) then
                    radarObjects.directionN.Position = fixedRight - textOffset
                    radarObjects.directionS.Position = fixedLeft - textOffset
                    radarObjects.directionW.Position = fixedTop - textOffset
                    radarObjects.directionE.Position = fixedBottom - textOffset
                end
            end
        end
        
        -- Centermark
        do
            local centerMark = radarObjects.centerMark
            if ( USE_QUADS ) then
                -- For those of you who didn't pay attention in geometry (like me)
                -- https://danceswithcode.net/engineeringnotes/rotations_in_2d/rotations_in_2d.html
                
                -- Get player LookVector
                local playerLookVec = clientRoot.CFrame.LookVector
                -- Convert it to an "angle" using atan2 and subtract the camera "angle" 
                local angle = (math.atan2(playerLookVec.X, playerLookVec.Z) - camAngle) - rad90

                local angleCos = mathCos(angle)
                local angleSin = mathSin(angle)
                
                -- Rotate quad points by angle using the sine and cosine calculated above
                local fixedA = radarPosition + newV2((quadPointA.X * angleSin) - (quadPointA.Y * angleCos), (quadPointA.X * angleCos) + (quadPointA.Y * angleSin))
                local fixedB = radarPosition + newV2((quadPointB.X * angleSin) - (quadPointB.Y * angleCos), (quadPointB.X * angleCos) + (quadPointB.Y * angleSin))
                local fixedC = radarPosition + newV2((quadPointC.X * angleSin) - (quadPointC.Y * angleCos), (quadPointC.X * angleCos) + (quadPointC.Y * angleSin))
                local fixedD = radarPosition + newV2((quadPointD.X * angleSin) - (quadPointD.Y * angleCos), (quadPointD.X * angleCos) + (quadPointD.Y * angleSin))
                
                -- Set points
                centerMark.PointA = fixedA
                centerMark.PointB = fixedB
                centerMark.PointC = fixedC
                centerMark.PointD = fixedD
            else
                centerMark.Position = radarPosition
                centerMark.Radius = 3 * markerScale
            end
        end
        
        -- Player marks
        do
            for thisName, thisManager in pairs(playerManagers) do 
                local thisMark = playerMarks[thisName]
                -- Safety marker check, in case the player hasnt finished loading in 
                if ( not thisMark ) then
                    continue
                end
                                
                -- Team check 
                if ( DISPLAY_TEAMMATES == false and thisManager.Team == clientTeam ) then
                    thisMark.Visible = false
                    continue
                end
                
                local thisRoot = thisManager.RootPart
                -- Spawned in / alive check 
                if ( thisRoot ) then
                 -- Get this player's position relative to the localplayer position 
                    local posDelta = thisRoot.Position - selfPos
                    
                    local radius, angle = cartToPolar(posDelta.X, posDelta.Z)
                    local fixedRadius = radius * RADAR_SCALE -- This makes the current zoom affect the marker position 
                    
                    if ( fixedRadius > RADAR_RADIUS ) then
                        if ( DISPLAY_OFFSCREEN ) then 
                            thisMark.Transparency = OFFSCREEN_TRANSPARENCY
                        else
                            thisMark.Visible = false
                            continue
                        end
                    else
                        thisMark.Visible = true
                        thisMark.Transparency = 1
                    end
                    
                    radius = math.clamp(fixedRadius, 0, RADAR_RADIUS)
                    angle += (camAngle + rad180) -- 180 degrees needs to be added to align things properly (there's probably a good reason but idk why)
                    
                    local x, y = polarToCart(radius, angle)
                    local finalPos = radarPosition + newV2(x, y)
                    
                    if ( USE_QUADS ) then
                        -- Get player LookVector
                        local playerLookVec = thisRoot.CFrame.LookVector
                        -- Convert it to an angle using atan2 and subtract the camera angle
                        local angle = (math.atan2(playerLookVec.X, playerLookVec.Z)) - rad90 - camAngle
                        
                        local angleCos = mathCos(angle)
                        local angleSin = mathSin(angle)
                        
                        -- Rotate quad points by angle using the sin and cosine calculated above
                        local fixedA = newV2((quadPointA.X * angleSin) - (quadPointA.Y * angleCos), (quadPointA.X * angleCos) + (quadPointA.Y * angleSin))
                        local fixedB = newV2((quadPointB.X * angleSin) - (quadPointB.Y * angleCos), (quadPointB.X * angleCos) + (quadPointB.Y * angleSin))                
                        local fixedC = newV2((quadPointC.X * angleSin) - (quadPointC.Y * angleCos), (quadPointC.X * angleCos) + (quadPointC.Y * angleSin))  
                        local fixedD = newV2((quadPointD.X * angleSin) - (quadPointD.Y * angleCos), (quadPointD.X * angleCos) + (quadPointD.Y * angleSin))  

                        if ( MARKER_FALLOFF ) then
                            local distance = posDelta.Magnitude
                            local scaleFalloff = math.clamp(MARKER_FALLOFF_AMNT / distance, 0.5, 1)
                            fixedA *= scaleFalloff
                            fixedB *= scaleFalloff
                            fixedC *= scaleFalloff
                            fixedD *= scaleFalloff
                        end

                        fixedA += finalPos
                        fixedB += finalPos
                        fixedC += finalPos
                        fixedD += finalPos


                        -- Set points
                        thisMark.PointA = fixedA
                        thisMark.PointB = fixedB
                        thisMark.PointC = fixedC
                        thisMark.PointD = fixedD
                    else
                        thisMark.Position = finalPos
                        local dotRadius = 3 * markerScale
                        
                        if ( MARKER_FALLOFF ) then
                            local distance = posDelta.Magnitude
                            local scaleFalloff = math.clamp(MARKER_FALLOFF_AMNT / distance, 0.5, 1)
                            dotRadius *= scaleFalloff
                        end

                        thisMark.Radius = dotRadius
                    end

                    if ( hoverPlayer == thisName ) then
                        local text = radarObjects.hoverText 
                        text.Position = finalPos + textOffset
                        text.Text = string.format('%s\n(%d studs away)', thisManager.DisplayName, posDelta.Magnitude)
                        text.Size = math.clamp(16 * RADAR_SCALE, 16, 24)
                        text.Visible = true
                    end
                end
            end
        end
    end)
end


-- set _G.RadarKill, so this radar can be killed on re-execution 
_G.RadarKill = killScript
