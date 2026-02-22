local ReplicatedStorage = game:GetService("ReplicatedStorage")

local raycast_helper = require(ReplicatedStorage.Packages["raycast-helper"])

local Utils = {}

function Utils:CanPlayerClimbLedge(char: Model) : boolean
	local hrp: BasePart = char.HumanoidRootPart
    local head: BasePart = char.Head

    local result = raycast_helper.raycast({
        origin = head.Position,
        direction = head.CFrame.LookVector * 6,

        rayParams = raycast_helper.params({
            filter_type = Enum.RaycastFilterType.Exclude,
            instance = {char},
        })
    })

	if not result then return false end
	
	local part: BasePart = result.Instance
	
	if part.Size.Y >= 7 then
		if head.Position.Y >= (part.Position.Y + (part.Size.Y / 2)) - 1 and head.Position.Y <= part.Position.Y + (part.Size.Y / 2) and  hrp.Velocity.Y <= 0 then
            return true
        end
	end

    return false
end

local function RaycastToADirection(char: Model, hrp: BasePart, direction: Vector3, direction_multiplier: number?)
    local result = raycast_helper.raycast({
        origin = hrp.Position,
        direction = direction * (direction_multiplier or 3),
        rayParams = raycast_helper.params({
            filterType = Enum.RaycastFilterType.Exclude,
            instances = {char},
        })
    })

    return result
end

local MINIMUM_HEIGHT_TO_WALL_RUN = 12

function Utils:IsOnGround(char: Model) : boolean
    local result = RaycastToADirection(char, char.HumanoidRootPart, Vector3.new(0, -1, 0), MINIMUM_HEIGHT_TO_WALL_RUN)
    local isOnGround = result ~= nil
	return isOnGround
end

function Utils:CanWallRun(char: Model): (RaycastResult?, string?)
    local hrp = char.HumanoidRootPart

    if self:IsOnGround(char) then return end

    local rayL = RaycastToADirection(char, hrp, -hrp.CFrame.RightVector)
    local rayR = RaycastToADirection(char, hrp, hrp.CFrame.RightVector)

    local result = rayL or rayR

    local direction: string
    if rayL then
        direction = "Left"
    elseif rayR then
        direction = "Right"
    end

    -- print(result, " | ", direction)

    return result, direction
end

function Utils:CanVault(char: Model): RaycastResult?
    local hrp = char.HumanoidRootPart
    return RaycastToADirection(char, hrp, hrp.CFrame.LookVector * 7 + hrp.CFrame.UpVector * -5, 1)
end

return Utils