--// BHOP CONTROLLER
--// LocalScript
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local bhopEnabled = false
local spaceAssistEnabled = true

local toggleKey = Enum.KeyCode.L
local hideGuiKey = Enum.KeyCode.RightShift

local changingKey = false
local spaceHeld = false
local guiHidden = false

--==================================================
-- CHARACTER
--==================================================

local character
local humanoid

local function setupCharacter(char)
	character = char
	humanoid = char:WaitForChild("Humanoid")
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "BhopHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN FRAME
--==================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(260, 220)
main.Position = UDim2.new(0, 30, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(70, 75, 90)
stroke.Thickness = 1
stroke.Parent = main

--==================================================
-- DRAG HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "DragHeader"
header.Size = UDim2.new(1, 0, 0, 45)
header.Position = UDim2.fromOffset(0, 0)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 25)
title.Position = UDim2.fromOffset(10, 6)
title.BackgroundTransparency = 1
title.Text = "BHOP CONTROLLER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local dragInfo = Instance.new("TextLabel")
dragInfo.Size = UDim2.new(1, -20, 0, 15)
dragInfo.Position = UDim2.fromOffset(10, 29)
dragInfo.BackgroundTransparency = 1
dragInfo.Text = "DRAG HERE TO MOVE"
dragInfo.TextColor3 = Color3.fromRGB(120, 125, 140)
dragInfo.Font = Enum.Font.Gotham
dragInfo.TextSize = 9
dragInfo.TextXAlignment = Enum.TextXAlignment.Left
dragInfo.Parent = header

--==================================================
-- STATUS
--==================================================

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 25)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "●  BHOP : OFF"
status.TextColor3 = Color3.fromRGB(255, 90, 90)
status.Font = Enum.Font.GothamSemibold
status.TextSize = 14
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

--==================================================
-- BHOP BUTTON
--==================================================

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(1, -20, 0, 32)
toggleButton.Position = UDim2.fromOffset(10, 76)
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
toggleButton.Text = "BHOP  [ OFF ]"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 13
toggleButton.Parent = main

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

--==================================================
-- KEYBIND BUTTON
--==================================================

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(1, -20, 0, 30)
keyButton.Position = UDim2.fromOffset(10, 113)
keyButton.BackgroundColor3 = Color3.fromRGB(35, 38, 47)
keyButton.Text = "TOGGLE KEY : L"
keyButton.TextColor3 = Color3.fromRGB(210, 215, 225)
keyButton.Font = Enum.Font.GothamMedium
keyButton.TextSize = 12
keyButton.Parent = main

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyButton

--==================================================
-- SPACE ASSIST
--==================================================

local spaceButton = Instance.new("TextButton")
spaceButton.Size = UDim2.new(1, -20, 0, 30)
spaceButton.Position = UDim2.fromOffset(10, 148)
spaceButton.BackgroundColor3 = Color3.fromRGB(35, 38, 47)
spaceButton.Text = "SPACE ASSIST : ON"
spaceButton.TextColor3 = Color3.fromRGB(210, 215, 225)
spaceButton.Font = Enum.Font.GothamMedium
spaceButton.TextSize = 12
spaceButton.Parent = main

local spaceCorner = Instance.new("UICorner")
spaceCorner.CornerRadius = UDim.new(0, 8)
spaceCorner.Parent = spaceButton

--==================================================
-- HIDE GUI INFO
--==================================================

local hideInfo = Instance.new("TextLabel")
hideInfo.Size = UDim2.new(1, -20, 0, 25)
hideInfo.Position = UDim2.fromOffset(10, 184)
hideInfo.BackgroundTransparency = 1
hideInfo.Text = "HIDE GUI  :  RIGHT SHIFT"
hideInfo.TextColor3 = Color3.fromRGB(130, 135, 150)
hideInfo.Font = Enum.Font.GothamMedium
hideInfo.TextSize = 10
hideInfo.TextXAlignment = Enum.TextXAlignment.Center
hideInfo.Parent = main

--==================================================
-- CREATOR / BRANDING
--==================================================

local creator = Instance.new("TextLabel")
creator.Size = UDim2.new(1, -20, 0, 18)
creator.Position = UDim2.fromOffset(10, 198)
creator.BackgroundTransparency = 1
creator.Text = "MADE BY KECAP H4KN"
creator.TextColor3 = Color3.fromRGB(90, 95, 110)
creator.Font = Enum.Font.GothamBold
creator.TextSize = 9
creator.TextXAlignment = Enum.TextXAlignment.Center
creator.Parent = main

--==================================================
-- HUD UPDATE
--==================================================

local function updateHUD()

	if bhopEnabled then
		status.Text = "●  BHOP : ON"
		status.TextColor3 = Color3.fromRGB(70, 230, 130)

		toggleButton.Text = "BHOP  [ ON ]"
		toggleButton.BackgroundColor3 = Color3.fromRGB(40, 120, 75)
	else
		status.Text = "●  BHOP : OFF"
		status.TextColor3 = Color3.fromRGB(255, 90, 90)

		toggleButton.Text = "BHOP  [ OFF ]"
		toggleButton.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	end

	keyButton.Text = "TOGGLE KEY : " .. toggleKey.Name

	if spaceAssistEnabled then
		spaceButton.Text = "SPACE ASSIST : ON"
		spaceButton.TextColor3 = Color3.fromRGB(120, 230, 160)
	else
		spaceButton.Text = "SPACE ASSIST : OFF"
		spaceButton.TextColor3 = Color3.fromRGB(210, 215, 225)
	end

	hideInfo.Text = "HIDE GUI  :  RIGHT SHIFT"
end

--==================================================
-- TOGGLE BHOP
--==================================================

local function toggleBhop()
	bhopEnabled = not bhopEnabled
	updateHUD()
end

toggleButton.MouseButton1Click:Connect(toggleBhop)

--==================================================
-- SPACE ASSIST TOGGLE
--==================================================

spaceButton.MouseButton1Click:Connect(function()
	spaceAssistEnabled = not spaceAssistEnabled
	updateHUD()
end)

--==================================================
-- CHANGE KEYBIND
--==================================================

keyButton.MouseButton1Click:Connect(function()

	if changingKey then
		return
	end

	changingKey = true

	keyButton.Text = "PRESS A KEY..."
	keyButton.BackgroundColor3 = Color3.fromRGB(120, 95, 35)
end)

--==================================================
-- HIDE / SHOW GUI
--==================================================

local function toggleGUI()

	guiHidden = not guiHidden

	if guiHidden then
		main.Visible = false
	else
		main.Visible = true
	end

end

--==================================================
-- INPUT
--==================================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)

	-- Right Shift selalu bisa membuka/menutup HUD
	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == hideGuiKey then
			toggleGUI()
			return
		end

	end

	if gameProcessed then
		return
	end

	--==================================================
	-- CHANGE KEYBIND
	--==================================================

	if changingKey then

		if input.UserInputType == Enum.UserInputType.Keyboard then

			if input.KeyCode == Enum.KeyCode.Escape then

				changingKey = false
				keyButton.BackgroundColor3 = Color3.fromRGB(35, 38, 47)

				updateHUD()

				return
			end

			-- Space tidak digunakan sebagai toggle key
			if input.KeyCode ~= Enum.KeyCode.Space
				and input.KeyCode ~= hideGuiKey then

				toggleKey = input.KeyCode

				changingKey = false

				keyButton.BackgroundColor3 = Color3.fromRGB(35, 38, 47)

				updateHUD()
			end

		end

		return
	end

	--==================================================
	-- BHOP KEY
	--==================================================

	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == toggleKey then
			toggleBhop()
			return
		end

		-- Space
		if input.KeyCode == Enum.KeyCode.Space then
			spaceHeld = true
		end

	end

end)

--==================================================
-- INPUT ENDED
--==================================================

UserInputService.InputEnded:Connect(function(input)

	if input.KeyCode == Enum.KeyCode.Space then
		spaceHeld = false
	end

end)

--==================================================
-- DRAG SYSTEM
--==================================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

	end

end)

header.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement then
		return
	end

	local delta = input.Position - dragStart

	main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)

end)

--==================================================
-- BHOP LOOP
--==================================================

RunService.RenderStepped:Connect(function()

	if not bhopEnabled then
		return
	end

	if not spaceAssistEnabled then
		return
	end

	if not spaceHeld then
		return
	end

	if not humanoid then
		return
	end

	if humanoid.Health <= 0 then
		return
	end

	-- Hanya jump ketika menyentuh tanah
	if humanoid.FloorMaterial ~= Enum.Material.Air then

		local state = humanoid:GetState()

		if state ~= Enum.HumanoidStateType.Jumping
			and state ~= Enum.HumanoidStateType.Freefall then

			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

		end

	end

end)

--==================================================
-- START
--==================================================

updateHUD()
