local LP = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

_G.AutoCollect = false
_G.AutoKickBlock = false
_G.AutoSafeZone = false
_G.GodMode = false
_G.UIHidden = false
_G.SafeZonePos = nil
_G.IsMovingManual = false

local radius = 1000
local collectSpeed = 0.15
local kickSpeed = 0.1

-- Fungsi stop gerak
local function StopMove()
	if LP.Character and LP.Character:FindFirstChild("Humanoid") then
	LP.Character.Humanoid:MoveTo(LP.Character.HumanoidRootPart.Position)
	LP.Character.Humanoid.WalkSpeed = 16 -- reset speed
	end
end

-- Deteksi gerak manual
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or 
	   input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
	_G.IsMovingManual = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or 
	   input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D then
	_G.IsMovingManual = false
	end
end)

-- Remotes
pcall(function()
	rev_B_Collect = ReplicatedStorage:WaitForChild("Shared", 5):WaitForChild("Packages", 5):WaitForChild("Network", 5):WaitForChild("rev_B_Collect", 5)
	rev_KickEvent = ReplicatedStorage:WaitForChild("Shared", 5):WaitForChild("Packages", 5):WaitForChild("Network", 5):WaitForChild("rev_KickEvent", 5)
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "JeraHubUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = gethui and gethui() or game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 240)
frame.Position = UDim2.new(0, 15, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
frame.BorderColor3 = Color3.fromRGB(23, 23, 23)
frame.BorderSizePixel = 1
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -35, 0, 28)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "script by Jera hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 25, 0, 25)
hideBtn.Position = UDim2.new(1, -30, 0, 6)
hideBtn.Text = "-"
hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 18
hideBtn.Parent = frame
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 4)

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 0, 200)
contentFrame.Position = UDim2.new(0, 10, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = frame

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 5)
uiList.Parent = contentFrame

local function createBtn(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = contentFrame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
	return btn
end

local toggleBtn = createBtn("Auto Collect 1-30: OFF")
toggleBtn.MouseButton1Click:Connect(function()
	_G.AutoCollect = not _G.AutoCollect
	toggleBtn.Text = "Auto Collect 1-30: " .. (_G.AutoCollect and "ON" or "OFF")
	toggleBtn.BackgroundColor3 = _G.AutoCollect and Color3.fromRGB(0, 170, 85) or Color3.fromRGB(60, 60, 60)
end)

local kickBtn = createBtn("Auto Tendang Block: OFF")
kickBtn.MouseButton1Click:Connect(function()
	_G.AutoKickBlock = not _G.AutoKickBlock
	kickBtn.Text = "Auto Tendang Block: " .. (_G.AutoKickBlock and "ON" or "OFF")
	kickBtn.BackgroundColor3 = _G.AutoKickBlock and Color3.fromRGB(0, 170, 85) or Color3.fromRGB(60, 60, 60)
end)

local setSafeBtn = createBtn("Set Safe Zone")
setSafeBtn.MouseButton1Click:Connect(function()
	local char = LP.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
	_G.SafeZonePos = char.HumanoidRootPart.Position
		setSafeBtn.Text = "Safe Zone Set ✓"
		task.wait(1)
		setSafeBtn.Text = "Set Safe Zone"
	end
end)

local safeBtn = createBtn("Auto Jalan ke Safe Zone: OFF")
safeBtn.MouseButton1Click:Connect(function()
	_G.AutoSafeZone = not _G.AutoSafeZone
	safeBtn.Text = "Auto Jalan ke Safe Zone: " .. (_G.AutoSafeZone and "ON" or "OFF")
	safeBtn.BackgroundColor3 = _G.AutoSafeZone and Color3.fromRGB(0, 170, 85) or Color3.fromRGB(60, 60, 60)
	
	if not _G.AutoSafeZone then
	StopMove() -- STOP GERAK PAS DIMATIIN
	end
end)

local godBtn = createBtn("God Mode Anti Mati: OFF")
godBtn.MouseBu
