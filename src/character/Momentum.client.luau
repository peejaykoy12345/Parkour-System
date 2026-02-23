local Players = game:GetService("Players")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

while true do task.wait()
      if hum.MoveDirection == Vector3.new (0, 0, 0) then
       hum.WalkSpeed = 12
   else
       hum.WalkSpeed = hum.WalkSpeed + 1.25
		if hum.WalkSpeed >= 29 then
			hum.WalkSpeed = 28		
          end
     end
end