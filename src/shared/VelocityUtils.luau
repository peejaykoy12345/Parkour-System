local Debris = game:GetService("Debris")

local Utils = {}

function Utils:AddBodyVelocity(part: BasePart, velocity: Vector3, duration: number)
    local bv = Instance.new("BodyVelocity", part)
    part.Anchored = false
    bv.MaxForce = Vector3.new(1,1,1) * math.huge
    bv.Velocity = velocity
    Debris:AddItem(bv, duration)
end

return Utils