local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local AnimationsFolder = ReplicatedStorage.Animations

local animations = {}

for _, animation in pairs(AnimationsFolder:GetChildren()) do
    table.insert(animations, animation)
end

ContentProvider:PreloadAsync(animations)

print("FINISHED PRELOADING ANIMATIONS")