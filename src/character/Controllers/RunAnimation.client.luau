local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)
local AnimationPlayer = require(ReplicatedStorage.Shared.AnimationPlayer)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()

local anim: Animation?
local holdingW = false

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.W then
        holdingW = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.W then
        holdingW = false
    end
end)

RunService.Heartbeat:Connect(function()
    local IsOnGround = ParkourUtils:IsOnGround(char, 3.5)
    if holdingW and not anim and IsOnGround then
        anim = AnimationPlayer:Play(char, 82471611362840)
    elseif not holdingW or not IsOnGround then
        if not anim then return end

        anim:Stop()
        anim = nil
    end
end)