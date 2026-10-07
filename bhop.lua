--==================================================
-- KECAP H4KN - BHOP CONTROLLER
-- Roblox Studio / LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

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
local scriptClosed = false

local connections = {}

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

connections.CharacterAdded = player.CharacterAdded:Connect(setupCharacter)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "KecapH4KN_BhopHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN
--==================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(260, 225)
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
-- HEADER / DRAG AREA
--==================================================

local header = Instance.new("Frame")
header.Name = "DragHeader"
header.Size = UDim2.new(1, -45, 0, 45)
header.Position = UDim2.fromOffset(0, 0)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = main

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
-- CLOSE BUTTON
--==================================================

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.fromOffset(28, 28)
closeButton.Position = UDim2.new(1, -36, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 55, 55)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 13
closeButton.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = closeButton

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
-- KEYBIND
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
spaceButton.TextColor3 = Color3.fromRGB(120, 230, 160)
spaceButton.Font = Enum.Font.GothamMedium
spaceButton.TextSize = 12
spaceButton.Parent = main

local spaceCorner = Instance.new("UICorner")
spaceCorner.CornerRadius = UDim.new(0, 8)
spaceCorner.Parent = spaceButton

--==================================================
-- INFO
--==================================================

local hideInfo = Instance.new("TextLabel")
hideInfo.Size = UDim2.new(1, -20, 0, 18)
hideInfo.Position = UDim2.fromOffset(10, 180)
hideInfo.BackgroundTransparency = 1
hideInfo.Text = "HIDE GUI : RIGHT SHIFT"
hideInfo.TextColor3 = Color3.fromRGB(130, 135, 150)
hideInfo.Font = Enum.Font.GothamMedium
hideInfo.TextSize = 10
hideInfo.TextXAlignment = Enum.TextXAlignment.Center
hideInfo.Parent = main

--==================================================
-- CREATOR
--==================================================

local creator = Instance.new("TextLabel")
creator.Size = UDim2.new(1, -20, 0, 18)
creator.Position = UDim2.fromOffset(10, 199)
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

	if scriptClosed then
		return
	end

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

	hideInfo.Text = "HIDE GUI : RIGHT SHIFT"
end

--==================================================
-- TOGGLE BHOP
--==================================================

local function toggleBhop()

	if scriptClosed then
		return
	end

	bhopEnabled = not bhopEnabled
	updateHUD()

end

connections.ToggleButton = toggleButton.MouseButton1Click:Connect(toggleBhop)

--==================================================
-- SPACE ASSIST
--==================================================

connections.SpaceButton = spaceButton.MouseButton1Click:Connect(function()

	if scriptClosed then
		return
	end

	spaceAssistEnabled = not spaceAssistEnabled
	updateHUD()

end)

--==================================================
-- CHANGE KEYBIND
--==================================================

connections.KeyButton = keyButton.MouseButton1Click:Connect(function()

	if scriptClosed or changingKey then
		return
	end

	changingKey = true

	keyButton.Text = "PRESS A KEY..."
	keyButton.BackgroundColor3 = Color3.fromRGB(120, 95, 35)

end)

--==================================================
-- CLOSE / CLEANUP
--==================================================

local function closeScript()

	if scriptClosed then
		return
	end

	scriptClosed = true

	-- Matikan fitur
	bhopEnabled = false
	spaceAssistEnabled = false
	spaceHeld = false
	changingKey = false

	-- Disconnect semua connection
	for _, connection in pairs(connections) do
		if connection and connection.Connected then
			connection:Disconnect()
		end
	end

	table.clear(connections)

	-- Hapus GUI
	if gui then
		gui:Destroy()
		gui = nil
	end

end

connections.CloseButton = closeButton.MouseButton1Click:Connect(closeScript)

--==================================================
-- INPUT
--==================================================

connections.InputBegan = UserInputService.InputBegan:Connect(function(input, gameProcessed)

	if scriptClosed then
		return
	end

	-- Right Shift = Hide / Show
	if input.UserInputType == Enum.UserInputType.Keyboard then

		if input.KeyCode == hideGuiKey then

			guiHidden = not guiHidden
			main.Visible = not guiHidden

			return
		end

	end

	if gameProcessed then
		return
	end

	--==================================================
	-- CHANGE KEY
	--==================================================

	if changingKey then

		if input.UserInputType == Enum.UserInputType.Keyboard then

			-- ESC = batal
			if input.KeyCode == Enum.KeyCode.Escape then

				changingKey = false
				keyButton.BackgroundColor3 = Color3.fromRGB(35, 38, 47)

				updateHUD()

				return
			end

			-- Hindari Space dan Right Shift
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
	-- NORMAL INPUT
	--==================================================

	if input.UserInputType == Enum.UserInputType.Keyboard then

		-- Toggle Bhop
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

connections.InputEnded = UserInputService.InputEnded:Connect(function(input)

	if scriptClosed then
		return
	end

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

connections.DragStart = header.InputBegan:Connect(function(input)

	if scriptClosed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

	end

end)

connections.DragEnd = header.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)

connections.DragMove = UserInputService.InputChanged:Connect(function(input)

	if scriptClosed then
		return
	end

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

connections.BhopLoop = RunService.RenderStepped:Connect(function()

	if scriptClosed then
		return
	end

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
-- INITIALIZE
--==================================================

updateHUD()
