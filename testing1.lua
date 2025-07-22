-- // CONFIGURACIÓN INICIAL
local boxColor = Color3.fromRGB(0, 255, 0)
local refreshRate = 1 -- segundos
local espEnabled = false

-- // GUI CREACIÓN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESP_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 150, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextScaled = true
ToggleButton.Text = "ESP: OFF"
ToggleButton.Parent = ScreenGui

-- // FUNCIONES DE ESP

local function createESP(player)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not player.Character:FindFirstChild("ESPBox") then
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

local function removeESP(player)
	if player.Character and player.Character:FindFirstChild("ESPBox") then
		player.Character:FindFirstChild("ESPBox"):Destroy()
	end
end

local function updateESP()
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			if espEnabled then
				createESP(player)
			else
				removeESP(player)
			end
		end
	end
end

-- // BOTÓN PARA ACTIVAR/DESACTIVAR

ToggleButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	ToggleButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
	updateESP()
end)

-- // ACTUALIZACIÓN AUTOMÁTICA

while true do
	updateESP()
	wait(refreshRate)
end
