-- WolfGod ULTRA UI +
-- Creator: WolfGod

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "WolfGod_ULTRA_UI"
gui.ResetOnSpawn = false
gui.Parent = LP:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,340,0,320)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- Floating Button
local float = Instance.new("TextButton", gui)
float.Size = UDim2.new(0,32,0,32)
float.Position = UDim2.new(0,10,0.5,-16)
float.Text = "WG"
float.Font = Enum.Font.GothamBold
float.TextSize = 11
float.TextColor3 = Color3.new(1,1,1)
float.BackgroundColor3 = Color3.fromRGB(25,25,25)
float.BorderSizePixel = 0
Instance.new("UICorner", float).CornerRadius = UDim.new(1,0)

float.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,-20,0,28)
title.Position = UDim2.new(0,10,0,6)
title.Text = "WolfGod"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.BackgroundTransparency = 1

-- Footer (Credit RGB)
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1,0,0,18)
credit.Position = UDim2.new(0,0,1,-20)
credit.Text = "Creator: WolfGod"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 11
credit.BackgroundTransparency = 1

-- RGB Effect for Title and Credit
task.spawn(function()
	local h=0
	while true do
		h=(h+1)%360
		local c=Color3.fromHSV(h/360,1,1)
		title.TextColor3=c
		credit.TextColor3=c
		task.wait(0.03)
	end
end)

-- Pages Container
local pages = Instance.new("Frame", main)
pages.Size = UDim2.new(1,-20,1,-100)
pages.Position = UDim2.new(0,10,0,70)
pages.BackgroundTransparency = 1

local p1 = Instance.new("Frame", pages); p1.Size = UDim2.new(1,0,1,0); p1.BackgroundTransparency = 1; p1.Visible = true
local p2 = Instance.new("Frame", pages); p2.Size = UDim2.new(1,0,1,0); p2.BackgroundTransparency = 1; p2.Visible = false
local p3 = Instance.new("Frame", pages); p3.Size = UDim2.new(1,0,1,0); p3.BackgroundTransparency = 1; p3.Visible = false

local function Switch(page)
    p1.Visible = false; p2.Visible = false; p3.Visible = false; page.Visible = true
end

local function NewTab(name, x, targetPage)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0,100,0,26); b.Position = UDim2.new(0,x,0,38); b.Text = name
	b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(20,20,20); b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
    b.MouseButton1Click:Connect(function() Switch(targetPage) end)
end

NewTab("PLAYER", 10, p1)
NewTab("TARGET", 120, p2)
NewTab("UTILITY", 230, p3)

local function Btn(par, txt, x, y, func)
	local b = Instance.new("TextButton", par)
	b.Size = UDim2.new(0,145,0,28); b.Position = UDim2.new(0,x,0,y); b.Text = txt
	b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(22,22,22); b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	b.MouseButton1Click:Connect(func)
	return b
end

-- === PLAYER PAGE ===
Btn(p1,"Speed +",10,10,function() LP.Character.Humanoid.WalkSpeed+=5 end)
Btn(p1,"Speed -",185,10,function() LP.Character.Humanoid.WalkSpeed-=5 end)
Btn(p1,"Jump +",10,46,function() LP.Character.Humanoid.JumpPower+=10 end)
Btn(p1,"Jump -",185,46,function() LP.Character.Humanoid.JumpPower-=10 end)
Btn(p1,"Reset",10,82,function() LP.Character:BreakJoints() end)

local flying = false
local flySpeed = 50
local flyConn

local flyBtn = Btn(p1, "Fly: OFF", 185, 82, function() end)
local speedInput = Instance.new("TextBox", p1)
speedInput.Size = UDim2.new(0, 145, 0, 28); speedInput.Position = UDim2.new(0, 185, 0, 118)
speedInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25); speedInput.Text = "50"
speedInput.TextColor3 = Color3.new(1, 1, 1); speedInput.Font = Enum.Font.Gotham; speedInput.TextSize = 11
speedInput.PlaceholderText = "Fly Speed..."
Instance.new("UICorner", speedInput).CornerRadius = UDim.new(0, 6)
speedInput.FocusLost:Connect(function() flySpeed = tonumber(speedInput.Text) or 50 end)

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local char = LP.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if flying then
        flyBtn.Text = "Fly: ON"
        local bv = Instance.new("BodyVelocity", hrp); bv.Name = "FlyVel"; bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        local bg = Instance.new("BodyGyro", hrp); bg.Name = "FlyGyro"; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9); bg.P = 9e4
        flyConn = RunService.RenderStepped:Connect(function()
            local dir = Vector3.zero; local camCF = Cam.CFrame
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir += camCF.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= camCF.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= camCF.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir += camCF.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0, 1, 0) end
            bv.Velocity = dir * flySpeed; bg.CFrame = camCF; hum.PlatformStand = true
        end)
    else
        flyBtn.Text = "Fly: OFF"
        if flyConn then flyConn:Disconnect() end
        if hrp and hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end
        if hrp and hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        if hum then hum.PlatformStand = false end
    end
end)

-- === TARGET PAGE ===
local search = Instance.new("TextBox", p2)
search.Size = UDim2.new(1, -4, 0, 26); search.Position = UDim2.new(0, 2, 0, 0)
search.PlaceholderText = "Search Player..."; search.TextColor3 = Color3.new(1, 1, 1)
search.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", search).CornerRadius = UDim.new(0, 6)

local scroll = Instance.new("ScrollingFrame", p2)
scroll.Position = UDim2.new(0, 0, 0, 30); scroll.Size = UDim2.new(1, 0, 1, -30)
scroll.BackgroundTransparency = 1; scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 4)

local Target = nil
local function RefreshList()
    for _, v in ipairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local b = Instance.new("TextButton", scroll)
            b.Size = UDim2.new(1, -6, 0, 26); b.Text = plr.Name; b.TextColor3 = Color3.new(1, 1, 1)
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            b.MouseButton1Click:Connect(function() Target = plr; title.Text = "TARGET: " .. plr.Name end)
        end
    end
end
RefreshList()
Players.PlayerAdded:Connect(RefreshList); Players.PlayerRemoving:Connect(RefreshList)
search:GetPropertyChangedSignal("Text"):Connect(function()
    local t = search.Text:lower()
    for _,v in ipairs(scroll:GetChildren()) do if v:IsA("TextButton") then v.Visible = v.Text:lower():find(t) and true or false end end
end)

-- === UTILITY PAGE ===
local noclip = false; local headsit = false; local infJump = false
UIS.JumpRequest:Connect(function() if infJump and LP.Character then LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
RunService.Stepped:Connect(function()
    if LP.Character then
        if noclip then for _,v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
        if headsit and Target and Target.Character and Target.Character:FindFirstChild("Head") then
            local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then 
                hrp.CFrame = Target.Character.Head.CFrame * CFrame.new(0, 1.2, 0)
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
                LP.Character.Humanoid.Sit = true 
            end
        end
    end
end)

Btn(p3,"Spectate",10,10,function() if Target and Target.Character then Cam.CameraSubject=Target.Character.Humanoid end end)
Btn(p3,"UnSpectate",185,10,function() Cam.CameraSubject=LP.Character.Humanoid end)
Btn(p3,"Noclip",10,46,function() noclip = not noclip end)
Btn(p3,"Teleport",185,46,function() if Target and Target.Character then LP.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame end end)
Btn(p3,"Infinite Jump",10,82,function() infJump = not infJump end)
Btn(p3,"Fling",185,82,function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ariayts64/Wolf-script./main/fling.lua"))() end) 
Btn(p3,"Sit",10,118,function() LP.Character.Humanoid.Sit = true end)
Btn(p3,"Head Sit",185,118,function() if Target then headsit = not headsit; noclip = headsit end end)
Btn(p3,"Rejoin",95,154,function() TeleportService:Teleport(game.PlaceId, LP) end)

