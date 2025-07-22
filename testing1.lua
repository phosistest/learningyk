-- // CONFIGURACIÓN
local refreshRate = 1 -- cada cuántos segundos actualizar
local boxColor = Color3.fromRGB(255, 0, 0) -- color de las cajas
local espEnabled = true

-- // FUNCIONES

local function createESP(player)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player:FindFirstChild("ESPBox") then
		local box = Instance.new("BoxHandleAdornment")
		box.Name = "ESPBox"
		box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
		box.Size = Vector3.new(4, 6, 2)
		box.Color3 = boxColor
		box.AlwaysOnTop = true
		box.ZIndex = 5
		box.Transparency = 0.5
		box.Parent = player.Character
	end
end

local function updateESP()
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			createESP(player)
		end
	end
end

-- // CONEXIONES

game.Players.PlayerAdded:Connect(function()
	wait(1)
	updateESP()
end)

game.Players.PlayerRemoving:Connect(function()
	wait(1)
	updateESP()
end)

-- // LOOP PRINCIPAL

while espEnabled do
	updateESP()
	wait(refreshRate)
end
