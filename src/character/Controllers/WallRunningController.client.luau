local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ParkourUtils = require(ReplicatedStorage.Shared.ParkourUtils)

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local holdingKey = false
local holdingA = false
local holdingD = false

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space then
        holdingKey = true
    end

    if input.KeyCode == Enum.KeyCode.A then
        holdingA = true
    elseif input.KeyCode == Enum.KeyCode.D then
        holdingD = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.Space then
        holdingKey = false
    end

    if input.KeyCode == Enum.KeyCode.A then
        holdingA = false
    end

    if input.KeyCode == Enum.KeyCode.D then
        holdingD = false
    end
end)

local MINIMUM_HEIGHT_TO_START_WALL_RUN = 9

-- Track whether a wall run has started or not
local hasStarted = false

RunService.Heartbeat:Connect(function()
    -- We only check if it's on ground if it started and if we're already wall running then we don't
    if not hasStarted then
        if ParkourUtils:IsOnGround(char, MINIMUM_HEIGHT_TO_START_WALL_RUN) then return end

        hasStarted = true   
    end

    local result, direction = ParkourUtils:CanWallRun(char)

    local correctDirection: boolean = false

    if direction == "Left" and holdingA then
        correctDirection = true
    elseif direction == "Right" and holdingD then
        correctDirection = true
    end

    if result and correctDirection and holdingKey then
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

        hasStarted = false
    end
end)