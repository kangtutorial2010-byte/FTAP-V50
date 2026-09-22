-- V53 FINAL GABUNG + HITBOX RESET
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name="Horomori V53 FINAL", LoadingTitle="Ngumpet Tanah + Curang", ConfigurationSaving={Enabled=false}})
local TanahTab = Window:CreateTab("Ngumpet Tanah", 4483362458)
local CurangTab = Window:CreateTab("Curang Tambahan", 6031091002)

local oldPos=nil
local oldHip=0
local con=nil

-- ===== NGUMPET TANAH =====
TanahTab:CreateButton({Name="MASUK KE DALAM TANAH", Callback=function()
    local plr=game.Players.LocalPlayer
    local char=plr.Character
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    oldPos=hrp.CFrame
    oldHip=hum.HipHeight
    hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType=Enum.HumanoidHealthDisplayType.AlwaysOff
    hum.NameDisplayDistance=0
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BillboardGui") then v.Enabled=false end
        if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.Transparency=1 end
        if v:IsA("Decal") then v.Transparency=1 end
    end
    if char.Head:FindFirstChild("face") then char.Head.face.Transparency=1 end
    hum.HipHeight=-12
    hrp.CFrame=hrp.CFrame * CFrame.new(0,-10,0)
    if con then con:Disconnect() end
    con=game:GetService("RunService").Heartbeat:Connect(function()
        if char and hrp then
            hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Y - 11, hrp.Position.Z)
            hrp.Velocity=Vector3.new(0,0,0)
        end
    end)
    Rayfield:Notify({Title="Ngumpet", Content="Udah di dalam tanah + Nama hilang", Duration=3})
end})

TanahTab:CreateButton({Name="KELUAR DARI TANAH", Callback=function()
    local char=game.Players.LocalPlayer.Character
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChild("Humanoid")
    if not char then return end
    if con then con:Disconnect() con=nil end
    if hum then
        hum.HipHeight=oldHip or 0
        hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Viewer
        hum.HealthDisplayType=Enum.HumanoidHealthDisplayType.DisplayWhenDamaged
        hum.NameDisplayDistance=100
    end
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.Transparency=0 end
        if v:IsA("Decal") then v.Transparency=0 end
        if v:IsA("BillboardGui") then v.Enabled=true end
    end
    if char.Head:FindFirstChild("face") then char.Head.face.Transparency=0 end
    if hrp and oldPos then hrp.CFrame=oldPos + Vector3.new(0,5,0) end
end})

TanahTab:CreateSlider({Name="Kedalaman Tanah", Range={5,20}, Increment=1, CurrentValue=11, Callback=function(V)
    local hrp=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and oldPos then hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Y - V, hrp.Position.Z) end
end})

-- ===== CURANG TAMBAHAN =====
CurangTab:CreateSlider({Name="Hitbox 3-20", Range={3,20}, Increment=1, CurrentValue=3, Callback=function(Size)
    for _,plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            hrp.Size = Vector3.new(Size, Size, Size)
            hrp.Transparency = 0.7
            hrp.CanCollide = false
        end
    end
end})

CurangTab:CreateButton({Name="RESET HITBOX NORMAL", Callback=function()
    for _,plr in pairs(game.Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            hrp.Size = Vector3.new(2,2,1)
            hrp.Transparency = 1
        end
    end
    Rayfield:Notify({Title="Hitbox", Content="Balik ke 2x2x1 normal", Duration=2})
end})

local antiFling = false
CurangTab:CreateToggle({Name="Anti Fling V2", CurrentValue=false, Flag="AntiFling", Callback=function(Value)
    antiFling = Value
end})
game:GetService("RunService").Heartbeat:Connect(function()
    if antiFling then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _,v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Velocity = Vector3.new(0,0,0)
                    v.RotVelocity = Vector3.new(0,0,0)
                end
            end
        end
    end
end)

local noclip = false
CurangTab:CreateToggle({Name="Noclip", CurrentValue=false, Flag="Noclip", Callback=function(Value) noclip=Value end})
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        local char = game.Players.LocalPlayer.Character
        if char then for _,v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
    end
end)

local flying = false
CurangTab:CreateToggle({Name="Fly [WASD+Space]", CurrentValue=false, Flag="Fly", Callback=function(Value)
    flying = Value
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if Value then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name="FlyForce" bv.Velocity=Vector3.new(0,0,0) bv.MaxForce=Vector3.new(9e9,9e9,9e9)
        game:GetService("RunService").Heartbeat:Connect(function()
            if flying and bv.Parent then
                local cam=workspace.CurrentCamera.CFrame
                local move=Vector3.new(0,0,0)
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then move=move+cam.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then move=move-cam.LookVector end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then move=move+Vector3.new(0,1,0) end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then move=move-Vector3.new(0,1,0) end
                bv.Velocity=move*50
            end
        end)
    else
        if hrp:FindFirstChild("FlyForce") then hrp:FindFirstChild("FlyForce"):Destroy() end
    end
end})

CurangTab:CreateSlider({Name="Speed 100-150", Range={100,150}, Increment=5, CurrentValue=100, Callback=function(S)
    local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed=S end
end})

CurangTab:CreateButton({Name="Reset Speed 16", Callback=function()
    local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed=16 end
end})
