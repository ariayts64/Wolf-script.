-- [[ WolfGod ULTRA UI - 
repeat task.wait() until game:IsLoaded()
local Players, UIS, RunService, TeleportService, TCS = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("TeleportService"), game:GetService("TextChatService")
local LP, Cam = Players.LocalPlayer, workspace.CurrentCamera

-- GUI Setup
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui")); gui.Name = "WolfGod_ULTRA_UI"; gui.ResetOnSpawn = false
local main = Instance.new("Frame", gui); main.Size = UDim2.new(0,340,0,320); main.Position = UDim2.new(0.5,0,0.5,0); main.AnchorPoint = Vector2.new(0.5,0.5); main.BackgroundColor3 = Color3.fromRGB(12,12,12); main.BorderSizePixel = 0; main.Visible = false; main.Active = true; main.Draggable = true; Instance.new("UICorner", main)
local float = Instance.new("TextButton", gui); float.Size = UDim2.new(0,32,0,32); float.Position = UDim2.new(0,10,0.5,-16); float.Text = "WG"; float.Font = Enum.Font.GothamBold; float.TextSize = 11; float.TextColor3 = Color3.new(1,1,1); float.BackgroundColor3 = Color3.fromRGB(25,25,25); Instance.new("UICorner", float).CornerRadius = UDim.new(1,0)
float.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- Titles
local title = Instance.new("TextLabel", main); title.Size = UDim2.new(1,-20,0,28); title.Position = UDim2.new(0,10,0,6); title.Text = "WolfGod"; title.Font = Enum.Font.GothamBold; title.TextSize = 15; title.BackgroundTransparency = 1
local credit = Instance.new("TextLabel", main); credit.Size = UDim2.new(1,0,0,18); credit.Position = UDim2.new(0,0,1,-20); credit.Text = "Creator: WolfGod"; credit.Font = Enum.Font.GothamBold; credit.TextSize = 11; credit.BackgroundTransparency = 1
task.spawn(function() local h=0 while true do h=(h+1)%360; local c=Color3.fromHSV(h/360,1,1); title.TextColor3=c; credit.TextColor3=c; task.wait(0.03) end end)

-- Tab System (5 Tabs)
local pages = Instance.new("Frame", main); pages.Size = UDim2.new(1,-20,1,-100); pages.Position = UDim2.new(0,10,0,70); pages.BackgroundTransparency = 1
local p1, p2, p3, p4, p5 = Instance.new("Frame", pages), Instance.new("Frame", pages), Instance.new("Frame", pages), Instance.new("Frame", pages), Instance.new("Frame", pages)
for _, p in pairs({p1, p2, p3, p4, p5}) do p.Size = UDim2.new(1,0,1,0); p.BackgroundTransparency = 1; p.Visible = false end; p1.Visible = true
local function NewTab(name, x, target, width)
    local b = Instance.new("TextButton", main); b.Size = UDim2.new(0,width,0,26); b.Position = UDim2.new(0,x,0,38); b.Text = name; b.Font = Enum.Font.GothamBold; b.TextSize = 9; b.TextColor3 = Color3.new(1,1,1); b.BackgroundColor3 = Color3.fromRGB(20,20,20); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() p1.Visible=false; p2.Visible=false; p3.Visible=false; p4.Visible=false; p5.Visible=false; target.Visible=true end)
end
NewTab("PLAYER", 5, p1, 62); NewTab("TARGET", 72, p2, 62); NewTab("UTILITY", 139, p3, 62); NewTab("TROLL", 206, p4, 62); NewTab("LOGS", 273, p5, 62)

local function Btn(par, txt, x, y, func)
    local b = Instance.new("TextButton", par); b.Size = UDim2.new(0,145,0,28); b.Position = UDim2.new(0,x,0,y); b.Text = txt; b.Font = Enum.Font.GothamBold; b.TextSize = 11; b.TextColor3 = Color3.new(1,1,1); b.BackgroundColor3 = Color3.fromRGB(22,22,22); Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() func(b) end); return b
end

-- [[ LOGS TAB ]] --
local function CreateLogSection(parent, titleText, yPos)
    local lbl = Instance.new("TextLabel", parent); lbl.Size = UDim2.new(1,-60,0,20); lbl.Position = UDim2.new(0,0,0,yPos); lbl.Text = titleText; lbl.TextColor3 = Color3.new(0.8,0.8,0.8); lbl.BackgroundTransparency = 1; lbl.Font = Enum.Font.Gotham; lbl.TextSize = 11; lbl.TextXAlignment = "Left"
    local sc = Instance.new("ScrollingFrame", parent); sc.Size = UDim2.new(1,-60,0,85); sc.Position = UDim2.new(0,0,0,yPos+20); sc.BackgroundColor3 = Color3.fromRGB(18,18,18); sc.BorderSizePixel = 0; sc.ScrollBarThickness = 2; sc.CanvasSize = UDim2.new(0,0,0,0); sc.AutomaticCanvasSize = "Y"
    local list = Instance.new("UIListLayout", sc); list.Padding = UDim.new(0,2); Instance.new("UICorner", sc)
    local clr = Instance.new("TextButton", parent); clr.Size = UDim2.new(0,50,0,25); clr.Position = UDim2.new(1,-55,0,yPos+50); clr.Text = "Clear"; clr.BackgroundColor3 = Color3.fromRGB(30,30,30); clr.TextColor3 = Color3.new(1,1,1); clr.Font = Enum.Font.GothamBold; clr.TextSize = 11; Instance.new("UICorner", clr)
    clr.MouseButton1Click:Connect(function() for _,v in pairs(sc:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end end)
    return sc
end
local chatSc = CreateLogSection(p5, "Chat Logs", 0)
local joinSc = CreateLogSection(p5, "Join/Leave Logs", 115)
local function AddLog(sc, txt, col)
    local l = Instance.new("TextLabel", sc); l.Size = UDim2.new(1,0,0,16); l.BackgroundTransparency = 1; l.Text = " ["..os.date("%X").."] "..txt; l.TextColor3 = col or Color3.new(1,1,1); l.TextXAlignment = "Left"; l.Font = Enum.Font.SourceSans; l.TextSize = 12; l.RichText = true
end
TCS.MessageReceived:Connect(function(m) if m.TextSource then AddLog(chatSc, "<b>"..m.TextSource.Name.."</b>: "..m.Text) end end)
Players.PlayerAdded:Connect(function(p) AddLog(joinSc, p.DisplayName.." Joined!", Color3.fromRGB(0,255,0)) end)
Players.PlayerRemoving:Connect(function(p) AddLog(joinSc, p.DisplayName.." Left.", Color3.fromRGB(255,0,0)) end)

-- [[ PLAYER PAGE ]] --
Btn(p1,"Speed +",10,10,function() LP.Character.Humanoid.WalkSpeed+=5 end)
Btn(p1,"Speed -",185,10,function() LP.Character.Humanoid.WalkSpeed-=5 end)
Btn(p1,"Reset",10,46,function() LP.Character:BreakJoints() end)
Btn(p1,"Sit",185,46,function() if LP.Character then LP.Character.Humanoid.Sit = true end end)
local flying, flySpeed, flyConn = false, 50, nil
local flyBtn = Btn(p1, "Fly: OFF", 10, 82, function() end)
local speedInp = Instance.new("TextBox", p1); speedInp.Size = UDim2.new(0,145,0,28); speedInp.Position = UDim2.new(0,185,0,82); speedInp.BackgroundColor3 = Color3.fromRGB(25,25,25); speedInp.Text = "50"; speedInp.TextColor3 = Color3.new(1,1,1); speedInp.PlaceholderText = "Fly Speed..."; Instance.new("UICorner", speedInp)
speedInp.FocusLost:Connect(function() flySpeed = tonumber(speedInp.Text) or 50 end)
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying; flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    local char = LP.Character or LP.CharacterAdded:Wait()
    local hrp, hum = char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
    if flying then
        local bv, bg = Instance.new("BodyVelocity", hrp), Instance.new("BodyGyro", hrp)
        bv.Name, bg.Name, bv.MaxForce, bg.MaxTorque = "FlyVel", "FlyGyro", Vector3.new(9e9,9e9,9e9), Vector3.new(9e9,9e9,9e9)
        flyConn = RunService.RenderStepped:Connect(function()
            local dir = Vector3.new(0,0,0); local cf = Cam.CFrame
            if UIS:IsKeyDown("W") then dir += cf.LookVector end if UIS:IsKeyDown("S") then dir -= cf.LookVector end
            if UIS:IsKeyDown("A") then dir -= cf.RightVector end if UIS:IsKeyDown("D") then dir += cf.RightVector end
            if UIS:IsKeyDown("Space") then dir += Vector3.new(0,1,0) end if UIS:IsKeyDown("LeftControl") then dir -= Vector3.new(0,1,0) end
            bv.Velocity = dir * flySpeed; bg.CFrame = cf; hum.PlatformStand = true
        end)
    else
        if flyConn then flyConn:Disconnect() end hum.PlatformStand = false
        if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
    end
end)
Btn(p1, "Rejoin Server", 10, 118, function() TeleportService:Teleport(game.PlaceId, LP) end).Size = UDim2.new(0,320,0,28)

-- [[ TARGET PAGE ]] --
local Target = nil
local search = Instance.new("TextBox", p2); search.Size = UDim2.new(1,-4,0,26); search.PlaceholderText = "Search Name/Nickname..."; search.BackgroundColor3 = Color3.fromRGB(25,25,25); Instance.new("UICorner", search)
local scroll = Instance.new("ScrollingFrame", p2); scroll.Position = UDim2.new(0,0,0,30); scroll.Size = UDim2.new(1,0,1,-30); scroll.BackgroundTransparency = 1; scroll.AutomaticCanvasSize = "Y"; Instance.new("UIListLayout", scroll).Padding = UDim.new(0,4)
local function Refresh()
    for _, v in pairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, plr in pairs(Players:GetPlayers()) do if plr ~= LP then
        local b = Instance.new("TextButton", scroll); b.Size = UDim2.new(1,-6,0,26); b.Text = plr.DisplayName.." (@"..plr.Name..")"; b.Name = plr.Name; b.BackgroundColor3 = Color3.fromRGB(25,25,25); b.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() Target = plr; title.Text = "TARGET: "..plr.DisplayName end)
    end end
end
Refresh(); Players.PlayerAdded:Connect(Refresh); Players.PlayerRemoving:Connect(Refresh)
search:GetPropertyChangedSignal("Text"):Connect(function()
    local t = search.Text:lower()
    for _, v in pairs(scroll:GetChildren()) do if v:IsA("TextButton") then local p = Players:FindFirstChild(v.Name); v.Visible = p and (p.Name:lower():find(t) or p.DisplayName:lower():find(t)) end end
end)

-- [[ UTILITY PAGE ]] --
local noclip, headsit, infJump, lookAt = false, false, false, false
UIS.JumpRequest:Connect(function() if infJump and LP.Character then LP.Character.Humanoid:ChangeState("Jumping") end end)
RunService.Stepped:Connect(function()
    if not LP.Character then return end
    if noclip then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    if headsit and Target and Target.Character and Target.Character:FindFirstChild("Head") then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = Target.Character.Head.CFrame * CFrame.new(0,1.2,0); hrp.Velocity = Vector3.zero; LP.Character.Humanoid.Sit = true end
    end
    if lookAt and Target and Target.Character and Target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
        if hrp then local p = Target.Character.HumanoidRootPart.Position; hrp.CFrame = CFrame.lookAt(hrp.Position, Vector3.new(p.X, hrp.Position.Y, p.Z)) end
    end
end)
Btn(p3,"Spectate",10,10,function() if Target and Target.Character then Cam.CameraSubject=Target.Character.Humanoid end end)
Btn(p3,"UnSpectate",185,10,function() Cam.CameraSubject=LP.Character.Humanoid end)
Btn(p3,"Noclip",10,46,function() noclip = not noclip end)
Btn(p3,"Teleport",185,46,function() if Target and Target.Character then LP.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame end end)
Btn(p3,"Infinite Jump",10,82,function() infJump = not infJump end)
Btn(p3,"Head Sit",185,82,function()
    if not Target then return end headsit = not headsit; noclip = headsit
    if not headsit then local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Sit = false; task.wait(0.05); LP.Character.HumanoidRootPart.Velocity = Vector3.new(0,60,0); hum:ChangeState("Jumping") end
    end
end)

-- [[ TROLL PAGE ]] --
Btn(p4,"Fling",10,10,function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ariayts64/Wolf-script./main/fling.lua"))() end)
Btn(p4,"Look At Target",185,10,function(b) if Target then lookAt = not lookAt; b.Text = lookAt and "Look At: ON" or "Look At Target" end end)
