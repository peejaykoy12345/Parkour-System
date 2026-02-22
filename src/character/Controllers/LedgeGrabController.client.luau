local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild('Humanoid')
local hrp = char:WaitForChild("HumanoidRootPart")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)
local VelocityUtils = require(ReplicatedStorage.Shared.VelocityUtils)

local holding = false
local ledgeAvailable = true

local function climb()
    hrp.Anchored = false
    local velocity = hrp.CFrame.LookVector * 10 + Vector3.new(0,30,0)
    VelocityUtils:AddBodyVelocity(hrp, velocity, 0.15)
    holding = false
    task.wait(0.75)
    ledgeAvailable = true
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space and holding then
        climb()
    end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    -- print(`{ledgeAvailable} and not {holding} and {ParkourUtils:CanPlayerClimbLedge(char)}`)
    if ledgeAvailable and not holding and ParkourUtils:CanPlayerClimbLedge(char) then
        ledgeAvailable = false
        holding = true
        char.HumanoidRootPart.Anchored = true
    end
end)