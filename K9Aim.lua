 --========================================================
-- NEXUS AIM ASSIST + ESP (Mobile Optimized + Toggle Button)
-- Roblox Studio / ton propre jeu
-- LocalScript > StarterPlayer > StarterPlayerScripts
--========================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================
-- CONFIGURATION
--========================================================
local Config = {
	AimAssist = false,
	FOV = 180,
	AimSpeed = 25,
	AimPart = "Head",
	ESP = false,
	NameESP = false,
	ESPDistance = 500
}

--========================================================
-- TEAM CHECK
--========================================================
local function IsEnemy(player)
	if player == LocalPlayer then
		return false
	end
	if LocalPlayer.Team ~= nil 
		and player.Team ~= nil 
		and LocalPlayer.Team == player.Team then
		return false
	end
	return true
end

--========================================================
-- GUI
--========================================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "NexusUI"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

--========================================================
-- TOGGLE MENU BUTTON (برای باز و بسته کردن منو در موبایل)
--========================================================
local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Size = UDim2.fromOffset(45, 45)
ToggleMenuBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleMenuBtn.Text = "☰"
ToggleMenuBtn.TextSize = 22
ToggleMenuBtn.Font = Enum.Font.GothamBold
ToggleMenuBtn.TextColor3 = Color3.fromRGB(245, 230, 255)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(19, 13, 28)
ToggleMenuBtn.AutoButtonColor = false
ToggleMenuBtn.Parent = Gui
Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(145, 60, 235)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleMenuBtn

--========================================================
-- MAIN (سایز کوچک‌تر برای موبایل)
--========================================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(300, 380)
Main.Position = UDim2.new(0.5, -150, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(10, 7, 16)
Main.BorderSizePixel = 0
Main.Visible = true
Main.Parent = Gui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(145, 60, 235)
Stroke.Thickness = 1.5
Stroke.Parent = Main

-- دکمه باز و بسته کردن منو
ToggleMenuBtn.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--========================================================
-- HEADER
--========================================================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(19, 13, 28)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(15, 8)
Title.Size = UDim2.new(1, -90, 0, 22)
Title.Text = "AIMBOT🎯"
Title.TextColor3 = Color3.fromRGB(245, 230, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.fromOffset(16, 30)
Subtitle.Size = UDim2.new(1, -90, 0, 15)
Subtitle.Text = "MOBILE SYSTEM"
Subtitle.TextColor3 = Color3.fromRGB(155, 80, 230)
Subtitle.TextSize = 8
Subtitle.Font = Enum.Font.GothamBold
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

--========================================================
-- SETTINGS BUTTON
--========================================================
local SettingsButton = Instance.new("TextButton")
SettingsButton.Name = "Settings"
SettingsButton.Size = UDim2.fromOffset(30, 30)
SettingsButton.Position = UDim2.new(1, -75, 0, 12)
SettingsButton.Text = "⚙"
SettingsButton.TextSize = 16
SettingsButton.Font = Enum.Font.GothamBold
SettingsButton.TextColor3 = Color3.fromRGB(220, 190, 255)
SettingsButton.BackgroundColor3 = Color3.fromRGB(31, 21, 42)
SettingsButton.AutoButtonColor = false
SettingsButton.Parent = Header
Instance.new("UICorner", SettingsButton).CornerRadius = UDim.new(1, 0)

--========================================================
-- CLOSE
--========================================================
local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.fromOffset(30, 30)
Close.Position = UDim2.new(1, -38, 0, 12)
Close.Text = "×"
Close.TextSize = 18
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.fromRGB(220, 190, 255)
Close.BackgroundColor3 = Color3.fromRGB(31, 21, 42)
Close.AutoButtonColor = false
Close.Parent = Header
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

--========================================================
-- TABS
--========================================================
local Tabs = Instance.new("Frame")
Tabs.Position = UDim2.fromOffset(12, 65)
Tabs.Size = UDim2.new(1, -24, 0, 35)
Tabs.BackgroundColor3 = Color3.fromRGB(18, 12, 26)
Tabs.BorderSizePixel = 0
Tabs.Parent = Main
Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0, 9)

local AimTab = Instance.new("TextButton")
AimTab.Size = UDim2.new(0.5, -2, 1, 0)
AimTab.BackgroundColor3 = Color3.fromRGB(105, 40, 185)
AimTab.Text = "AIM"
AimTab.TextColor3 = Color3.new(1, 1, 1)
AimTab.TextSize = 10
AimTab.Font = Enum.Font.GothamBold
AimTab.AutoButtonColor = false
AimTab.Parent = Tabs
Instance.new("UICorner", AimTab).CornerRadius = UDim.new(0, 8)

local ESPTab = Instance.new("TextButton")
ESPTab.Size = UDim2.new(0.5, -2, 1, 0)
ESPTab.Position = UDim2.new(0.5, 2, 0, 0)
ESPTab.BackgroundColor3 = Color3.fromRGB(27, 18, 36)
ESPTab.Text = "ESP"
ESPTab.TextColor3 = Color3.fromRGB(190, 165, 210)
ESPTab.TextSize = 10
ESPTab.Font = Enum.Font.GothamBold
ESPTab.AutoButtonColor = false
ESPTab.Parent = Tabs
Instance.new("UICorner", ESPTab).CornerRadius = UDim.new(0, 8)

--========================================================
-- PAGES
--========================================================
local AimPage = Instance.new("Frame")
AimPage.Position = UDim2.fromOffset(12, 110)
AimPage.Size = UDim2.new(1, -24, 1, -120)
AimPage.BackgroundTransparency = 1
AimPage.Parent = Main

local ESPPage = Instance.new("Frame")
ESPPage.Position = UDim2.fromOffset(12, 110)
ESPPage.Size = UDim2.new(1, -24, 1, -120)
ESPPage.BackgroundTransparency = 1
ESPPage.Visible = false
ESPPage.Parent = Main

local SettingsPage = Instance.new("Frame")
SettingsPage.Position = UDim2.fromOffset(12, 110)
SettingsPage.Size = UDim2.new(1, -24, 1, -120)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.Parent = Main

--========================================================
-- BUTTON FUNCTION
--========================================================
local function Button(parent, text, y)
	local button = Instance.new("TextButton")
	button.Position = UDim2.fromOffset(0, y)
	button.Size = UDim2.new(1, 0, 0, 36)
	button.BackgroundColor3 = Color3.fromRGB(27, 19, 37)
	button.Text = text
	button.TextColor3 = Color3.fromRGB(210, 180, 245)
	button.TextSize = 10
	button.Font = Enum.Font.GothamBold
	button.AutoButtonColor = false
	button.Parent = parent
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 9)
	return button
end

local function ToggleText(button, title, value)
	button.Text = title .. " " .. (value and "ON" or "OFF")
	if value then
		button.BackgroundColor3 = Color3.fromRGB(105, 40, 185)
		button.TextColor3 = Color3.new(1, 1, 1)
	else
		button.BackgroundColor3 = Color3.fromRGB(27, 19, 37)
		button.TextColor3 = Color3.fromRGB(210, 180, 245)
	end
end

--========================================================
-- TAB SWITCH
--========================================================
local function ShowPage(page)
	AimPage.Visible = false
	ESPPage.Visible = false
	SettingsPage.Visible = false
	page.Visible = true
end

AimTab.MouseButton1Click:Connect(function()
	ShowPage(AimPage)
	AimTab.BackgroundColor3 = Color3.fromRGB(105, 40, 185)
	ESPTab.BackgroundColor3 = Color3.fromRGB(27, 18, 36)
end)

ESPTab.MouseButton1Click:Connect(function()
	ShowPage(ESPPage)
	AimTab.BackgroundColor3 = Color3.fromRGB(27, 18, 36)
	ESPTab.BackgroundColor3 = Color3.fromRGB(105, 40, 185)
end)

SettingsButton.MouseButton1Click:Connect(function()
	ShowPage(SettingsPage)
	AimTab.BackgroundColor3 = Color3.fromRGB(27, 18, 36)
	ESPTab.BackgroundColor3 = Color3.fromRGB(27, 18, 36)
end)

--========================================================
-- AIM ASSIST
--========================================================
local AimButton = Button(AimPage, "AIM ASSIST", 5)
ToggleText(AimButton, "AIM ASSIST", Config.AimAssist)
AimButton.MouseButton1Click:Connect(function()
	Config.AimAssist = not Config.AimAssist
	ToggleText(AimButton, "AIM ASSIST", Config.AimAssist)
end)

--========================================================
-- SLIDER
--========================================================
local function Slider(parent, title, y, minValue, maxValue, value, callback)
	local label = Instance.new("TextLabel")
	label.Position = UDim2.fromOffset(0, y)
	label.Size = UDim2.new(1, 0, 0, 18)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(225, 215, 235)
	label.TextSize = 10
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent

	local bar = Instance.new("Frame")
	bar.Position = UDim2.fromOffset(0, y + 22)
	bar.Size = UDim2.new(1, 0, 0, 6)
	bar.BackgroundColor3 = Color3.fromRGB(32, 23, 42)
	bar.BorderSizePixel = 0
	bar.Parent = parent
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale(0, 1)
	fill.BackgroundColor3 = Color3.fromRGB(145, 55, 235)
	fill.BorderSizePixel = 0
	fill.Parent = bar
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(12, 12)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.BackgroundColor3 = Color3.fromRGB(235, 210, 255)
	knob.BorderSizePixel = 0
	knob.Parent = bar
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local dragging = false
	local function SetValue(v)
		v = math.clamp(v, minValue, maxValue)
		local percent = (v - minValue) / (maxValue - minValue)
		fill.Size = UDim2.new(percent, 0, 1, 0)
		knob.Position = UDim2.new(percent, 0, 0.5, 0)
		label.Text = title .. " " .. math.floor(v)
		callback(v)
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			local percent = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
			SetValue(minValue + (maxValue - minValue) * percent)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local percent = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
		SetValue(minValue + (maxValue - minValue) * percent)
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	SetValue(value)
end

--========================================================
-- FOV & SPEED SLIDERS
--========================================================
Slider(AimPage, "FOV", 50, 30, 600, Config.FOV, function(v)
	Config.FOV = v
end)

Slider(AimPage, "AIM SPEED", 105, 1, 100, Config.AimSpeed, function(v)
	Config.AimSpeed = v
end)

--========================================================
-- AIM PART
--========================================================
local PartButton = Button(AimPage, "HEAD", 160)
local Parts = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"}
local PartIndex = 1
PartButton.MouseButton1Click:Connect(function()
	PartIndex += 1
	if PartIndex > #Parts then PartIndex = 1 end
	Config.AimPart = Parts[PartIndex]
	PartButton.Text = string.upper(Config.AimPart)
end)

--========================================================
-- FOV CIRCLE
--========================================================
local FOVCircle = Instance.new("Frame")
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.ZIndex = 10
FOVCircle.Parent = Gui
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)
local FOVStroke = Instance.new("UIStroke")
FOVStroke.Color = Color3.fromRGB(180, 65, 255)
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

--========================================================
-- AIM TARGET
--========================================================
local function GetAimPart(character)
	if not character then return nil end
	return character:FindFirstChild(Config.AimPart) or character:FindFirstChild("HumanoidRootPart")
end

local function FindTarget()
	local Camera = workspace.CurrentCamera
	if not Camera then return nil end
	local mouse = UserInputService:GetMouseLocation()
	local closest = nil
	local closestDistance = Config.FOV
	for _, player in ipairs(Players:GetPlayers()) do
		if IsEnemy(player) then
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local part = GetAimPart(character)
			if humanoid and humanoid.Health > 0 and part then
				local screen, visible = Camera:WorldToViewportPoint(part.Position)
				if visible and screen.Z > 0 then
					local distance = (Vector2.new(screen.X, screen.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
					if distance < closestDistance then
						closestDistance = distance
						closest = part
					end
				end
			end
		end
	end
	return closest
end

local CurrentTarget = nil

--========================================================
-- AIM LOOP
--========================================================
RunService.RenderStepped:Connect(function(dt)
	local Camera = workspace.CurrentCamera
	if not Camera then return end
	local mouse = UserInputService:GetMouseLocation()
	
	FOVCircle.Position = UDim2.fromOffset(mouse.X, mouse.Y)
	FOVCircle.Size = UDim2.fromOffset(Config.FOV * 2, Config.FOV * 2)
	FOVCircle.Visible = Config.AimAssist

	if not Config.AimAssist then
		CurrentTarget = nil
		return
	end

	if not CurrentTarget or not CurrentTarget.Parent then
		CurrentTarget = FindTarget()
	end

	if not CurrentTarget then return end

	local character = CurrentTarget.Parent
	local player = Players:GetPlayerFromCharacter(character)
	if not player or not IsEnemy(player) then
		CurrentTarget = nil
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		CurrentTarget = nil
		return
	end

	local screen, visible = Camera:WorldToViewportPoint(CurrentTarget.Position)
	if not visible then
		CurrentTarget = nil
		return
	end

	local distance = (Vector2.new(screen.X, screen.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
	if distance > Config.FOV then
		CurrentTarget = FindTarget()
		return
	end

	local desired = CFrame.lookAt(Camera.CFrame.Position, CurrentTarget.Position)
	local alpha = 1 - math.exp(-Config.AimSpeed * dt)
	Camera.CFrame = Camera.CFrame:Lerp(desired, alpha)
end)

--========================================================
-- ESP
--========================================================
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "NexusESP"
ESPFolder.Parent = workspace
local ESPObjects = {}

local function RemoveESP(player)
	local data = ESPObjects[player]
	if not data then return end
	if data.Highlight then data.Highlight:Destroy() end
	if data.NameTag then data.NameTag:Destroy() end
	ESPObjects[player] = nil
end

local function CreateESP(player)
	if player == LocalPlayer then return end
	if not Config.ESP and not Config.NameESP then
		RemoveESP(player)
		return
	end
	if not IsEnemy(player) then
		RemoveESP(player)
		return
	end

	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local head = character:FindFirstChild("Head")
	if not humanoid or not head then return end
	if humanoid.Health <= 0 then
		RemoveESP(player)
		return
	end

	RemoveESP(player)
	local data = {Character = character}

	if Config.ESP then
		local highlight = Instance.new("Highlight")
		highlight.Name = "PlayerESP"
		highlight.Adornee = character
		highlight.FillColor = Color3.fromRGB(255, 40, 55)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.65
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = ESPFolder
		data.Highlight = highlight
	end

	if Config.NameESP then
		local tag = Instance.new("BillboardGui")
		tag.Name = "NameESP"
		tag.Adornee = head
		tag.Size = UDim2.fromOffset(220, 40)
		tag.StudsOffset = Vector3.new(0, 3, 0)
		tag.AlwaysOnTop = true
		tag.MaxDistance = Config.ESPDistance
		tag.Parent = ESPFolder

		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Size = UDim2.fromScale(1, 1)
		label.Text = player.DisplayName
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		label.TextStrokeTransparency = 0
		label.TextSize = 12
		label.Font = Enum.Font.GothamBold
		label.Parent = tag
		data.NameTag = tag
	end

	ESPObjects[player] = data
end

local function UpdateESP()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if Config.ESP or Config.NameESP then
				local character = player.Character
				local data = ESPObjects[player]
				if not data or data.Character ~= character then
					CreateESP(player)
				end
			else
				RemoveESP(player)
			end
		end
	end
end

local ESPTimer = 0
RunService.Heartbeat:Connect(function(dt)
	ESPTimer += dt
	if ESPTimer < 0.1 then return end
	ESPTimer = 0
	UpdateESP()
end)

--========================================================
-- ESP BUTTONS
--========================================================
local ESPButton = Button(ESPPage, "ESP", 5)
local NameButton = Button(ESPPage, "NAME ESP", 50)

ToggleText(ESPButton, "ESP", Config.ESP)
ToggleText(NameButton, "NAME ESP", Config.NameESP)

ESPButton.MouseButton1Click:Connect(function()
	Config.ESP = not Config.ESP
	ToggleText(ESPButton, "ESP", Config.ESP)
	UpdateESP()
end)

NameButton.MouseButton1Click:Connect(function`
	Config.NameESP = not Config.NameESP
	ToggleText(NameButton, "NAME ESP", Config.NameESP)
	UpdateESP()
end)
