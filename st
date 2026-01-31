local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")


local Config = {
    Enabled = true,
    Mode = "hold", 
    Keybind = Enum.KeyCode.E,

    StartDelay = 0.01,
    EndDelay = 0.02,

    Prediction = 0.12,
}

Config.StartDelay = math.clamp(Config.StartDelay, 0.01, 1)
Config.EndDelay   = math.clamp(Config.EndDelay, Config.StartDelay, 2)


local isToggled = false
local nextShotTime = 0
local mouseHeld = false


local function mouseDown(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, false)
end

local function mouseUp(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, false)
end

local function getMousePosition()
    local pos = UserInputService:GetMouseLocation()
    return pos.X, pos.Y
end

local function isUsingKnife()
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then return false end

    local blacklist = {
        "we all end up fucked guys fuck 3rd person games pain in the ass lol"
    }

    return table.find(blacklist, tool.Name:lower()) ~= nil
end

local function isValidCharacterPart(part)
    if not part then return false end

    local character = part:FindFirstAncestorOfClass("Model")
    if not character then return false end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end

    if Players:GetPlayerFromCharacter(character) == LocalPlayer then
        return false
    end

    return true
end


local function getPredictedPosition(part)
    return part.Position + (part.Velocity * Config.Prediction)
end


local function TriggerAction()
    local char = LocalPlayer.Character
    if not char then return false end

    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or isUsingKnife() then
        return false
    end

    local mouse = LocalPlayer:GetMouse()
    local targetPart = mouse.Target
    if not isValidCharacterPart(targetPart) then
        return false
    end

    local predictedPos = getPredictedPosition(targetPart)
    local _, onScreen = Camera:WorldToViewportPoint(predictedPos)
    if not onScreen then
        return false
    end

    local currentTime = os.clock()
    if currentTime < nextShotTime then
        return true 
    end

    local x, y = getMousePosition()

    if not mouseHeld then
        mouseDown(x, y)
        mouseHeld = true
    end

    local delay = math.random() * (Config.EndDelay - Config.StartDelay) + Config.StartDelay
    nextShotTime = currentTime + delay

    return true
end


UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if Config.Mode == "toggle" and input.KeyCode == Config.Keybind then
        isToggled = not isToggled
    end
end)


RunService.RenderStepped:Connect(function()
    if not Config.Enabled then return end

    if Config.Mode == "hold" then
        isToggled = UserInputService:IsKeyDown(Config.Keybind)
    end

    local validTarget = false

    if isToggled then
        validTarget = TriggerAction()
    end

    
    if mouseHeld and (not isToggled or not validTarget) then
        local x, y = getMousePosition()
        mouseUp(x, y)
        mouseHeld = false
    end
end)

getgenv().Settings = {
    Jumpbot = {
        Enabled = true;
        TeamCheck = true;
        Delay = 0; -- milliseconds
    };

    WallCheck = {
        Enabled = true;
    };

    FOV = {
        Enabled = false;

        Radius = 35;
        MinimumRadius = 35; -- prevents instability
        Padding = 53;       -- forgiveness for small FOVs
    };

    Notifications = {
        Enabled = false;
    };
}

-- SERVICES
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local StatesToIgnore = {
    Enum.HumanoidStateType.Dead,
    Enum.HumanoidStateType.Freefall,
    Enum.HumanoidStateType.Jumping
}

local ClosestPlayer
local RightClickHeld = false -- Track right-click state

-- WALL CHECK
local function HasLineOfSight(TargetPart)
    if not Settings.WallCheck.Enabled then
        return true
    end

    local Origin = Camera.CFrame.Position
    local Direction = TargetPart.Position - Origin

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Blacklist
    Params.FilterDescendantsInstances = {
        LocalPlayer.Character,
        TargetPart.Parent
    }
    Params.IgnoreWater = true

    return workspace:Raycast(Origin, Direction, Params) == nil
end

-- FOV CHECK (STABLE)
local function IsInFOV(ScreenPos)
    if not Settings.FOV.Enabled then
        return true
    end

    local Mouse = UserInputService:GetMouseLocation()
    local Radius = math.max(Settings.FOV.Radius, Settings.FOV.MinimumRadius)

    return (Vector2.new(ScreenPos.X, ScreenPos.Y) - Mouse).Magnitude
        <= (Radius + Settings.FOV.Padding)
end

-- CLOSEST VISIBLE BODY PART
local function GetClosestVisiblePart(Character)
    local ClosestPart
    local ClosestDistance = math.huge
    local Mouse = UserInputService:GetMouseLocation()

    for _, Part in ipairs(Character:GetChildren()) do
        if not Part:IsA("BasePart") then continue end
        if Part.Transparency >= 0.5 then continue end
        if not HasLineOfSight(Part) then continue end

        local ScreenPos, OnScreen = Camera:WorldToScreenPoint(Part.Position)
        if not OnScreen then continue end

        local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Mouse).Magnitude
        if Distance < ClosestDistance then
            ClosestDistance = Distance
            ClosestPart = Part
        end
    end

    return ClosestPart
end

-- JUMP LOGIC
local function Jump(HumanoidRootPart)
    if not Settings.Jumpbot.Enabled then return end
    if RightClickHeld then return end -- Don't jump while right-clicking

    local TargetPlayer = Players:GetPlayerFromCharacter(HumanoidRootPart.Parent)
    if not TargetPlayer then return end

    if Settings.Jumpbot.TeamCheck then
        if TargetPlayer.Team == LocalPlayer.Team then return end
        if Teams[tostring(TargetPlayer.Team)]
            and Teams[tostring(TargetPlayer.Team)].AutoAssignable then
            return
        end
    end

    if TargetPlayer ~= ClosestPlayer then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end

    local TargetPart = GetClosestVisiblePart(HumanoidRootPart.Parent)
    if not TargetPart then return end

    local ScreenPos, OnScreen = Camera:WorldToScreenPoint(TargetPart.Position)
    if not OnScreen then return end
    if not IsInFOV(ScreenPos) then return end

    if Settings.Jumpbot.Delay > 0 then
        task.wait(Settings.Jumpbot.Delay / 1000)
    end

    local Humanoid = LocalPlayer.Character.Humanoid
    if Humanoid.Health > 0
        and not table.find(StatesToIgnore, Humanoid:GetState()) then

        keypress(0x20)
        task.wait(0.5)
        keyrelease(0x20)
    end
end

-- CLOSEST PLAYER TO CURSOR
local function GetClosestPlayer()
    local Result
    local ClosestDistance = math.huge
    local Mouse = UserInputService:GetMouseLocation()

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player == LocalPlayer then continue end
        local Character = Player.Character
        local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
        if not HRP then continue end

        local Pos, OnScreen = Camera:WorldToViewportPoint(HRP.Position)
        if not OnScreen then continue end

        local Distance = (Mouse - Vector2.new(Pos.X, Pos.Y)).Magnitude
        if Distance < ClosestDistance then
            ClosestDistance = Distance
            Result = Player
        end
    end

    return Result
end

-- CHARACTER MONITOR
local function JumpFunc(Character)
    local HRP = Character:WaitForChild("HumanoidRootPart")
    local Bool = Instance.new("BoolValue")

    Bool.Changed:Connect(function(v)
        if v then
            Jump(HRP)
        end
    end)

    RunService.RenderStepped:Connect(function()
        Bool.Value = HRP.Velocity.Y > 10
    end)
end

-- PLAYER CONNECTIONS
for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        Player.CharacterAdded:Connect(JumpFunc)
        if Player.Character then
            JumpFunc(Player.Character)
        end
    end
end

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(JumpFunc)
end)

-- UPDATE LOOP
RunService.Heartbeat:Connect(function()
    ClosestPlayer = GetClosestPlayer()
end)

-- RIGHT CLICK DETECTION
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        RightClickHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(Input, GameProcessed)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        RightClickHeld = false
    end
end)

-- INSERT = TOGGLE JUMPBOT
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end

    if Input.KeyCode == Enum.KeyCode.Insert then
        Settings.Jumpbot.Enabled = not Settings.Jumpbot.Enabled
    end
end)

-- HOME = TOGGLE TEAM CHECK
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end

    if Input.KeyCode == Enum.KeyCode.Home then
        Settings.Jumpbot.TeamCheck = not Settings.Jumpbot.TeamCheck
    end
end)