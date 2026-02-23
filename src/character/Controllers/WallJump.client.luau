local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)
local VelocityUtils = require(ReplicatedStorage.Shared.VelocityUtils)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local SPEED = 25
local DURATION = 0.2

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space then
        if not ParkourUtils:CanWallJump(char) then return end
        VelocityUtils:AddBodyVelocity(hrp, (hrp.CFrame.LookVector + Vector3.new(0, 1, 0)) * SPEED, DURATION)
    end
end)