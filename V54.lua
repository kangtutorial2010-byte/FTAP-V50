-- V53 FIXED NO ERROR LINE 77
repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name="Horomori V53 FIXED", LoadingTitle="Fix Line 77", ConfigurationSaving={Enabled=false}})
local TanahTab = Window:CreateTab("Ngumpet Tanah", 4483362458)
local CurangTab = Window:CreateTab("Curang Tambahan", 6031091002)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local plr = Players.LocalPlayer

local oldPos = nil
local oldHip = 0
local tanahCon = nil
local noclipOn = false
local antiFlingOn = false
local flyOn = false
local flyBV = nil
local flyBG = nil

-- NGUMPET TANAH
TanahTab:CreateButton({Name="MASUK KE DALAM TANAH", Callback=function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    oldPos = hrp.CFrame
    oldHip = hum.HipHeight
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BillboardGui") then v.Enabled = false end
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 1 end
        if v:IsA("Decal") then v.Transparency = 1 end
    end
    if char.Head:FindFirstChild("face") then char.Head.face.Transparency = 1 end
    hum.HipHeight = -12
    if tanahCon then tanahCon:Disconnect() end
    tanahCon = RunService.Heartbeat:Connect(function()
        if char and hrp and oldPos then
            hrp.CFrame = CFrame.new(hrp.Position.X, oldPos.Y - 11, hrp.Position.Z)
            hrp.Velocity = Vector3.new(0,0,0)
        end
    end)
end})

TanahTab:CreateButton({Name="KELUAR DARI TANAH", Callback=function()
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if tanahCon then tanahCon:Disconnect() tanahCon=nil end
    if hum then
        hum.HipHeight = oldHip
        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
    end
    if char then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 0 end
            if v:IsA("Decal") then v.Transparency = 0 end
            if v:IsA("BillboardGui") then v.Enabled = true end
        end
        if char.Head:FindFirstChild("face") then char.Head.face.Transparency = 0 end
    end
    if hrp and oldPos then hrp.CFrame = oldPos + Vector3.new(0,5,0) end
end})

TanahTab:CreateSlider({Name="Kedalaman Tanah", Range={5,20}, Increment=1, CurrentValue=11, Callback=function(V)
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp and oldPos then
        hrp.CFrame = CFrame.new(hrp.Position.X, oldPos.Y - V, hrp.Position.Z)
    end
end})

-- CURANG TAMBAHAN
CurangTab:CreateSlider({Name="Hitbox 3-20", Range={3,20}, Increment=1, CurrentValue=5, Callback=function(Size)
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            hrp.Size = Vector3.new(Size, Size, Size)
            hrp.Transparency = 0.6
            hrp.CanCollide = false
        end
    end
end})

CurangTab:CreateButton({Name="RESET HITBOX NORMAL", Callback=function()
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            hrp.Size = Vector3.new(2,2,1)
            hrp.Transparency = 1
        end
    end
end})

CurangTab:CreateToggle({Name="Anti Fling V2", CurrentValue=false, Flag="AntiFling", Callback=function(V) antiFlingOn=V end})
CurangTab:CreateToggle({Name="Noclip", CurrentValue=false, Flag="Noclip", Callback=function(V) noclipOn=V end})

CurangTab:CreateToggle({Name="Fly WASD+Space", CurrentValue=false, Flag="Fly", Callback=function(V)
    flyOn = V
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if V then
        flyBG = Instance.new("BodyGyro")
        flyBG.Parent = hrp
        flyBG.P = 90000
        flyBG.MaxTorque = Vector3.new(9e9,9e9,9e9)
        flyBG.CFrame = hrp.CFrame
        flyBV = Instance.new("BodyVelocity")
        flyBV.Parent = hrp
        flyBV.Velocity = Vector3.new(0,0,0)
        flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
    else
        if flyBG then flyBG:Destroy() flyBG=nil end
        if flyBV then flyBV:Destroy() flyBV=nil end
    end
end})

CurangTab:CreateSlider({Name="Speed 100-150", Range={100,150}, Increment=5, CurrentValue=100, Callback=function(S)
    local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = S end
end})

CurangTab:CreateButton({Name="Reset Speed 16", Callback=function()
    local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end})

RunService.Stepped:Connect(function()
    local char = plr.Character
    if not char then return end
    if noclipOn then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
    if antiFlingOn then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Velocity = Vector3.new(0,0,0)
                v.RotVelocity = Vector3.new(0,0,0)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if flyOn and flyBV and flyBG then
        local cam = workspace.CurrentCamera.CFrame
        flyBG.CFrame = cam
        local move = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
        flyBV.Velocity = move * 60
    end
end)
