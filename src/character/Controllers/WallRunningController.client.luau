local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local holdingKey = false

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space then
        holdingKey = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space then
        holdingKey = false
    end
end)

RunService.Heartbeat:Connect(function()
    local result, direction = ParkourUtils:CanWallRun(char)
    if result and holdingKey then
        local part = result.Instance

        local weld = hrp:FindFirstChild("WallrunWeld") or Instance.new("WeldConstraint")
        weld.Name = "WallrunWeld"

        weld.Part0 = hrp
        weld.Part1 = part

        local bp = hrp:FindFirstChild("WallrunBodyPosition") or Instance.new("BodyPosition", hrp)
        bp.Name = "WallrunBodyPosition"
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bp.Position = hrp.Position + hrp.CFrame.LookVector * 10 - Vector3.new(0, 3, 0)
    else
        for _, child in pairs(hrp:GetChildren()) do
            if child.Name == "WallrunWeld" or child.Name == "WallrunBodyPosition" then
                child:Destroy()
            end
        end
    end
end)