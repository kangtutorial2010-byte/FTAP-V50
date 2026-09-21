-- V53 NGUMPET TANAH + HILANGIN NAMA
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name="Horomori V53 TANAH", LoadingTitle="Ngumpet Tanah", ConfigurationSaving={Enabled=false}})
local TanahTab = Window:CreateTab("Ngumpet Tanah", 4483362458)

local oldPos=nil
local oldHip=0
local con=nil

TanahTab:CreateButton({Name="MASUK KE DALAM TANAH", Callback=function()
    local plr=game.Players.LocalPlayer
    local char=plr.Character
    local hrp=char and char:FindFirstChild("HumanoidRootPart")
    local hum=char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    oldPos=hrp.CFrame
    oldHip=hum.HipHeight
    
    -- 1. HILANGIN NAMA DI ATAS KEPALA
    hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
    hum.HealthDisplayType=Enum.HumanoidHealthDisplayType.AlwaysOff
    hum.NameDisplayDistance=0
    -- Hapus Billboard nama
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BillboardGui") or v.Name=="HumanoidRootPart" and v:FindFirstChild("NameTag") then
            v.Enabled=false
        end
        if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then
            v.Transparency=1
        end
        if v:IsA("Decal") then v.Transparency=1 end
    end
    if char.Head:FindFirstChild("face") then char.Head:FindFirstChild("face").Transparency=1 end
    
    -- 2. MASUK TANAH
    hum.HipHeight=-12
    hrp.CFrame=hrp.CFrame * CFrame.new(0,-10,0)
    -- Biar gak jatuh terus
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
    if char.Head:FindFirstChild("face") then char.Head:FindFirstChild("face").Transparency=0 end
    if hrp and oldPos then hrp.CFrame=oldPos + Vector3.new(0,5,0) end
    Rayfield:Notify({Title="Keluar", Content="Balik normal lagi", Duration=2})
end})

TanahTab:CreateSlider({Name="Kedalaman Tanah", Range={5,20}, Increment=1, CurrentValue=11, Callback=function(V)
    local hrp=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp and oldPos then
        hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Y - V, hrp.Position.Z)
    end
end})

TanahTab:CreateLabel("Work 100% di FTAP - Orang lain gak liat nama lu karena lu di bawah tanah")
