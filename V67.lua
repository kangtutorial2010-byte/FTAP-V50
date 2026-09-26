
-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local HitboxBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame UI Utama
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Active = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Judul
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "  Hitbox Hub (TUBA)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Fitur Draggable (Dapat Digeser)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.OffsetFitur **Hitbox Expander** sangat populer dan efektif untuk game-game bertema pertempuran atau bos di Roblox. Script ini bekerja dengan cara memperbesar ukuran fisik bagian tubuh musuh (*seperti Head atau HumanoidRootPart*) secara *Client-Side*. 

Efeknya, area tebasan atau tembakanmu menjadi jauh lebih luas, sehingga kamu bisa menyerang dan mengenai bos/musuh dengan sangat mudah meskipun seranganmu terbilang meleset dari karakter aslinya.

Berikut adalah Script GUI Draggable dengan fitur **Hitbox Expander**:

```lua
-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local HitboxBtn = Instance.new("TextButton")
local ResetBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame UI Utama
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
MainFrame.Size = UDim2.new(0, 230, 0, 160)
MainFrame.Active = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Judul
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "  Hitbox Hub (TUBA)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Fitur Draggable (Dapat Digeser)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Tombol 1: Aktifkan Hitbox Besar
HitboxBtn.Parent = MainFrame
HitboxBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
HitboxBtn.Position = UDim2.new(0.08, 0, 0.3, 0)
HitboxBtn.Size = UDim2.new(0.84, 0, 0.28, 0)
HitboxBtn.Font = Enum.Font.SourceSansBold
HitboxBtn.Text = "Hitbox Expander: OFF"
HitboxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxBtn.TextSize = 15.000

local C1 = Instance.new("UICorner")
C1.CornerRadius = UDim.new(0, 6)
C1.Parent = HitboxBtn

-- Tombol 2: Reset Hitbox
ResetBtn.Parent = MainFrame
ResetBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ResetBtn.Position =
