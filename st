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