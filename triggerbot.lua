local HoldClick = true
local Hotkey = 't' -- Leave blank for always on
local HotkeyToggle = true 

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Toggle = (Hotkey ~= '')
local CurrentlyPressed = false

local function startFiring()
    if HoldClick then
        if not CurrentlyPressed then
            CurrentlyPressed = true
            mouse1press()
        end
    else
        mouse1click()
    end
end


local function stopFiring()
    if HoldClick and CurrentlyPressed then
        CurrentlyPressed = false
        mouse1release()
    end
end


local function isShootableTarget(target)
    if target and target.Parent then
        local humanoid = target.Parent:FindFirstChild('Humanoid')
        if humanoid then
 
            return true
        end
        

        if target:IsA('BasePart') then
            return true
        end
    end
    return false
end


Mouse.KeyDown:Connect(function(key)
    if HotkeyToggle and key:lower() == Hotkey:lower() then
        Toggle = not Toggle
    elseif not HotkeyToggle and key:lower() == Hotkey:lower() then
        Toggle = true
    end
end)


Mouse.KeyUp:Connect(function(key)
    if HotkeyToggle == false and key:lower() == Hotkey:lower() then
        Toggle = false
    end
end)

RunService.RenderStepped:Connect(function()
    if Toggle then
        local target = Mouse.Target
        if isShootableTarget(target) then
            startFiring() 
        else
            stopFiring()  
        end
    else
        stopFiring()
    end
end)
