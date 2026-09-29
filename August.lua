-- Script ใส่ไว้ใน ServerScriptService

-- 1. ระบบขโมยไข่และวาร์ปกลับฐาน
local eggPart = workspace:WaitForChild("EggPart") -- กำหนด Part ไข่
local baseSpawn = workspace:WaitForChild("BaseSpawnPoint") -- กำหนดจุดวาร์ปฐาน
local prompt = eggPart:WaitForChild("ProximityPrompt")

prompt.Triggered:Connect(function(player)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		
		-- เพิ่มจำนวนไข่ใน leaderstats
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local eggStat = leaderstats:FindFirstChild("Eggs")
			if eggStat then
				eggStat.Value = eggStat.Value + 1
			end
		end
		
		-- วาร์ปผู้เล่นกลับไปจุดตั้งต้น/ฐานทันที
		character.HumanoidRootPart.CFrame = baseSpawn.CFrame + Vector3.new(0, 3, 0)
		
		-- รีเซ็ตการเกิดของไข่
		eggPart.Transparency = 1
		eggPart.CanCollide = false
		prompt.Enabled = false
		
		task.wait(5) -- รอ 5 วินาทีก่อนไข่เกิดใหม่
		
		eggPart.Transparency = 0
		eggPart.CanCollide = true
		prompt.Enabled = true
	end
end)

-- 2. ระบบลู่วิ่งเพิ่มค่าความเร็ว (Treadmill)
local treadmillPart = workspace:WaitForChild("TreadmillPart")

treadmillPart.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		local humanoid = hit.Parent:FindFirstChild("Humanoid")
		-- เพิ่มค่าความเร็วเฉพาะตอนที่ผู้เล่นกำลังเดินอยู่บนลู่วิ่ง
		if humanoid and humanoid.MoveDirection.Magnitude > 0 then
			local leaderstats = player:FindFirstChild("leaderstats")
			if leaderstats then
				local speedStat = leaderstats:FindFirstChild("Speed")
				if speedStat then
					speedStat.Value = speedStat.Value + 1
				end
			end
		end
	end
end)
