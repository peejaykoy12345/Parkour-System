local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)
local VelocityUtils = require(ReplicatedStorage.Shared.VelocityUtils)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local vaultAvailable = true

RunService.Heartbeat:Connect(function()
    local result = ParkourUtils:CanVault(char)
    if not result or not vaultAvailable then return end
    
    local part = result.Instance
    if part.Name ~= "Vault" or hum.FloorMaterial == Enum.Material.Air then return end

    vaultAvailable = false
    VelocityUtils:AddBodyVelocity(hrp, hrp.CFrame.LookVector * 20 + Vector3.new(0, 30, 0), 0.15)

    task.wait(0.75)
    vaultAvailable = true
end)