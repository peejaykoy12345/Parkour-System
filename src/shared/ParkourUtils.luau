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

return Utils