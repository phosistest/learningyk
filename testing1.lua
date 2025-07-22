-- // CONFIGURACIÓN INICIAL
local refreshRate = 1 -- segundos
local espEnabled = false

-- // COLORES POR EQUIPO
local teamColors = {
	["Guards"] = Color3.fromRGB(0, 150, 255),     -- azul
	["Inmates"] = Color3.fromRGB(255, 110, 0),    -- naranja
	["Neutral"] = Color3.fromRGB(130, 130, 130),  -- gris
	["Criminals"] = Color3.fromRGB(255, 0, 0)     -- rojo
}

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
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if not character:FindFirstChild("ESPBox") then
		local box = Instance.new("BoxHandleAdornment")
		box.Name = "ESPBox"
		box.Adornee = hrp
		box.Size = Vector3.new(4, 6, 2)
		box.AlwaysOnTop = true
		box.ZIndex = 5
		box.Transparency = 0.5

		-- Asignar color por team
		local teamName = player.Team and player.Team.Name or "Neutral"
		box.Color3 = teamColors[teamName] or Color3.fromRGB(255, 255, 255)

		box.Parent = character
	end
end

local function removeESP(player)
	local character = player.Character
	if character and character:FindFirstChild("ESPBox") then
		character:FindFirstChild("ESPBox"):Destroy()
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

-- // BOTÓN DE ACTIVACIÓN

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
