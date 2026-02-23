local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationPlayer = {}

local PRODUCTION = false

local cachedAnimations = {}

local function getAnimator(character: Model)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("No humanoid found")
        return nil
    end

    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end

    return animator
end

function AnimationPlayer:Play(character: Model, animationId: string)
    local animator = getAnimator(character)
    if not animator then return nil end

    if not cachedAnimations[animationId] then
        local animation = ReplicatedStorage.Animations:FindFirstChild(tostring(animationId))
        if animation then
            cachedAnimations[animationId] = animation
        else
            animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://" .. animationId
            animation.Name = animationId
            animation.Parent = ReplicatedStorage.Animations
            cachedAnimations[animationId] = animation
        end
    end

    local track = animator:LoadAnimation(cachedAnimations[animationId])
    track:Play()

    return track
end

return AnimationPlayer