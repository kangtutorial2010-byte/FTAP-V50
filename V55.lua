-- FTAP V54 RAYFIELD ANTI 404 - FINAL
repeat task.wait() until game:IsLoaded()

local Rayfield
local urls = {
    "https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua",
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source",
    "https://sirius.menu/rayfield"
}

for _,url in ipairs(urls) do
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res and #res > 1000 then
        local ok2, lib = pcall(function() return loadstring(res)() end)
        if ok2 and lib then Rayfield = lib break end
    end
end

if not Rayfield then
    warn("Rayfield 404 semua, cek koneksi/Http di Delta lu aktif gak")
    return
end

local Window = Rayfield:CreateWindow({
   Name = "FTAP V54 Rayfield FIX",
   LoadingTitle = "Loaded",
   ConfigurationSaving = { Enabled = false }
})

local T1 = Window:CreateTab("Ngumpet Tanah", 4483362458)
local T2 = Window:CreateTab("Curang", 6031091002)

local plr = game.Players.LocalPlayer
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local oldPos, noclip, antifling, fly, bv, bg, con = nil, false, false, false, nil, nil, nil

T1:CreateButton({Name="MASUK TANAH", Callback=function()
    local hrp = plr.Character.HumanoidRootPart
    oldPos = hrp.CFrame
    plr.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    for _,v in pairs(plr.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.Transparency=1 end end
    plr.Character.Humanoid.HipHeight=-12
    if con then con:Disconnect() end
    con=Run.Heartbeat:Connect(function() if hrp and oldPos then hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Position.Y-11, hrp.Position.Z) hrp.Velocity=Vector3.new(0,0,0) end end)
end})

T1:CreateButton({Name="KELUAR TANAH", Callback=function()
    if con then con:Disconnect() con=nil end
    for _,v in pairs(plr.Character:GetDescendants()) do if v:IsA("BasePart") then v.Transparency=0 end end
    plr.Character.Humanoid.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Viewer
    plr.Character.Humanoid.HipHeight=0
    if oldPos then plr.Character.HumanoidRootPart.CFrame=oldPos+Vector3.new(0,5,0) end
end})

T1:CreateSlider({Name="Kedalaman 5-20", Range={5,20}, Increment=1, CurrentValue=11, Callback=function(V)
    local hrp=plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp and oldPos then hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Position.Y-V, hrp.Position.Z) end
end})

T2:CreateSlider({Name="Hitbox 3-20", Range={3,20}, Increment=1, CurrentValue=3, Callback=function(S)
    for _,p in pairs(game.Players:GetPlayers()) do if p~=plr and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Size=Vector3.new(S,S,S) p.Character.HumanoidRootPart.Transparency=0.6 end end
end})

T2:CreateButton({Name="RESET HITBOX", Callback=function()
    for _,p in pairs(game.Players:GetPlayers()) do if p~=plr and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Size=Vector3.new(2,2,1) p.Character.HumanoidRootPart.Transparency=1 end end
    Rayfield:Notify({Title="Hitbox", Content="Reset Normal", Duration=2})
end})

T2:CreateToggle({Name="Anti Fling V2", CurrentValue=false, Flag="AF", Callback=function(V) antifling=V end})
T2:CreateToggle({Name="Noclip", CurrentValue=false, Flag="NC", Callback=function(V) noclip=V end})
T2:CreateToggle({Name="Fly", CurrentValue=false, Flag="Fly", Callback=function(V)
    fly=V local hrp=plr.Character.HumanoidRootPart
    if V then bg=Instance.new("BodyGyro",hrp) bg.P=90000 bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bv=Instance.new("BodyVelocity",hrp) bv.MaxForce=Vector3.new(9e9,9e9,9e9) bv.Velocity=Vector3.new(0,0,0)
    else if bg then bg:Destroy() bg=nil end if bv then bv:Destroy() bv=nil end end
end})
T2:CreateSlider({Name="Speed 100-150", Range={100,150}, Increment=5, CurrentValue=100, Callback=function(S) plr.Character.Humanoid.WalkSpeed=S end})
T2:CreateButton({Name="Reset Speed 16", Callback=function() plr.Character.Humanoid.WalkSpeed=16 end})

Run.Stepped:Connect(function() if noclip or antifling then for _,v in pairs(plr.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false v.Velocity=Vector3.new(0,0,0) end end end end)
Run.Heartbeat:Connect(function() if fly and bv and bg then local cam=workspace.CurrentCamera.CFrame bg.CFrame=cam local m=Vector3.new(0,0,0) if UIS:IsKeyDown(Enum.KeyCode.W) then m=m+cam.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S) then m=m-cam.LookVector end bv.Velocity=m*60 end end)

Rayfield:Notify({Title="V54 Rayfield", Content="Loaded Anti 404", Duration=3})
