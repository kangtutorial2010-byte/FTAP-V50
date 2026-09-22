repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local Window = Rayfield:CreateWindow({
   Name = "FTAP V54 FIX RAYFIELD",
   LoadingTitle = "No 404",
   ConfigurationSaving = { Enabled = false }
})

local T1 = Window:CreateTab("Ngumpet Tanah")
local T2 = Window:CreateTab("Curang")

local plr=game.Players.LocalPlayer
local Run=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local oldPos,noclip,antifling,fly,bv,bg=nil,false,false,false,nil,nil
local con=nil

T1:CreateButton({Name="MASUK TANAH", Callback=function()
    local hrp=plr.Character.HumanoidRootPart
    oldPos=hrp.CFrame
    plr.Character.Humanoid.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None
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

T2:CreateSlider({Name="Hitbox 3-20", Range={3,20}, Increment=1, CurrentValue=3, Callback=function(S)
    for _,p in pairs(game.Players:GetPlayers()) do if p~=plr and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Size=Vector3.new(S,S,S) p.Character.HumanoidRootPart.Transparency=0.6 end end
end})

T2:CreateButton({Name="RESET HITBOX", Callback=function()
    for _,p in pairs(game.Players:GetPlayers()) do if p~=plr and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Size=Vector3.new(2,2,1) p.Character.HumanoidRootPart.Transparency=1 end end
end})

T2:CreateToggle({Name="Anti Fling V2", CurrentValue=false, Flag="AF", Callback=function(V) antifling=V end})
T2:CreateToggle({Name="Noclip", CurrentValue=false, Flag="NC", Callback=function(V) noclip=V end})
T2:CreateToggle({Name="Fly", CurrentValue=false, Flag="Fly", Callback=function(V)
    fly=V local hrp=plr.Character.HumanoidRootPart
    if V then bg=Instance.new("BodyGyro",hrp) bg.P=90000 bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bv=Instance.new("BodyVelocity",hrp) bv.MaxForce=Vector3.new(9e9,9e9,9e9)
    else if bg then bg:Destroy() end if bv then bv:Destroy() end end
end})
T2:CreateSlider({Name="Speed 100-150", Range={100,150}, Increment=5, CurrentValue=100, Callback=function(S) plr.Character.Humanoid.WalkSpeed=S end})

Run.Stepped:Connect(function() if noclip or antifling then for _,v in pairs(plr.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false v.Velocity=Vector3.new(0,0,0) end end end end)
Run.Heartbeat:Connect(function() if fly and bv then local cam=workspace.CurrentCamera.CFrame bg.CFrame=cam local m=Vector3.new(0,0,0) if UIS:IsKeyDown(Enum.KeyCode.W) then m=m+cam.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S) then m=m-cam.LookVector end bv.Velocity=m*60 end end)
