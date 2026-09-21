-- HOROMORI V58 ALL IN ONE FINAL HP - 17 SEPT 2025
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name="Horomori V58 ALL IN ONE", LoadingTitle="HP Final", LoadingSubtitle="All Features", ConfigurationSaving={Enabled=false}})

local HitboxTab = Window:CreateTab("Hitbox", 4483362458)
local ProtectTab = Window:CreateTab("Protection", 4483362458)
local TanahTab = Window:CreateTab("Ngumpet Tanah", 4483362458)
local MoveTab = Window:CreateTab("Fly & Speed", 4483362458)
local CamTab = Window:CreateTab("Freecam HP", 4483362458)

-- ===== HITBOX =====
_G.HitboxOn=false _G.HitboxSize=10
local function resetHitbox() for _,p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then local h=p.Character.HumanoidRootPart h.Size=Vector3.new(2,2,1) h.Transparency=1 h.BrickColor=BrickColor.new("Medium stone grey") h.Material=Enum.Material.Plastic h.CanCollide=true end end end
HitboxTab:CreateToggle({Name="Hitbox ON/OFF", CurrentValue=false, Callback=function(V) _G.HitboxOn=V if not V then resetHitbox() end end})
HitboxTab:CreateSlider({Name="Size 3-35", Range={3,35}, Increment=1, CurrentValue=10, Callback=function(V) _G.HitboxSize=V end})
HitboxTab:CreateButton({Name="Reset Hitbox", Callback=function() _G.HitboxOn=false resetHitbox() end})

-- ===== PROTECTION + NOCLIP =====
_G.AntiFlingOn=false _G.NoclipOn=false
ProtectTab:CreateToggle({Name="Anti Fling V3", CurrentValue=false, Callback=function(V) _G.AntiFlingOn=V end})
ProtectTab:CreateToggle({Name="Noclip Tembus Tembok", CurrentValue=false, Callback=function(V) _G.NoclipOn=V end})
ProtectTab:CreateLabel("Noclip = tembus tembok ON")

-- ===== TANAH BISA BALIK + XRAY BISA BALIK =====
local oldPos=nil local oldHip=0 local tanahCon=nil _G.TanahLock=false local savedData={}
local function balikinTanah() for obj,data in pairs(savedData) do if obj and obj.Parent then obj.Transparency=data.T obj.CanCollide=data.C end end savedData={} for _,obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and obj.Transparency==1 and obj.Parent~=game.Players.LocalPlayer.Character and obj.Name~="HumanoidRootPart" then obj.Transparency=0 obj.CanCollide=true end end end
TanahTab:CreateButton({Name="1. MASUK KE TANAH", Callback=function() local char=game.Players.LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChild("Humanoid") if not hrp or not hum then return end if not _G.TanahLock then oldPos=hrp.CFrame end oldHip=hum.HipHeight hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None hum.NameDisplayDistance=0 for _,v in pairs(char:GetDescendants()) do if v:IsA("BillboardGui") then v.Enabled=false end if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.Transparency=1 end end hum.HipHeight=-12 hrp.CFrame=CFrame.new(oldPos.X, oldPos.Y - 12, oldPos.Z) _G.TanahLock=true if tanahCon then tanahCon:Disconnect() end tanahCon=game:GetService("RunService").Heartbeat:Connect(function() if _G.TanahLock and hrp and oldPos then hrp.CFrame=CFrame.new(hrp.Position.X, oldPos.Y - 12, hrp.Position.Z) hrp.Velocity=Vector3.new(0,0,0) end end) Rayfield:Notify({Title="Ngumpet", Content="Masuk tanah + nama hilang", Duration=2}) end})
TanahTab:CreateButton({Name="2. NAIK KE ATAS BALIK SEMULA", Callback=function() local char=game.Players.LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChild("Humanoid") _G.TanahLock=false if tanahCon then tanahCon:Disconnect() tanahCon=nil end if hum then hum.HipHeight=oldHip or 0 hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.Viewer hum.NameDisplayDistance=100 end for _,v in pairs(char:GetDescendants()) do if v:IsA("BasePart") and v.Name~="HumanoidRootPart" then v.Transparency=0 end if v:IsA("BillboardGui") then v.Enabled=true end end if hrp and oldPos then hrp.CFrame=oldPos + Vector3.new(0,3,0) end Rayfield:Notify({Title="Naik", Content="Balik ke posisi semula!", Duration=2}) end})
TanahTab:CreateSection("Tanah Hilang Bisa Balik")
TanahTab:CreateToggle({Name="Tanah Hilang (X-Ray)", CurrentValue=false, Callback=function(V) if V then savedData={} for _,obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and obj.Parent~=game.Players.LocalPlayer.Character and obj.Transparency<1 and obj.Name~="HumanoidRootPart" then savedData[obj]={T=obj.Transparency,C=obj.CanCollide} obj.Transparency=1 obj.CanCollide=false end end Rayfield:Notify({Title="X-Ray", Content="Tanah hilang, bisa ngintip", Duration=2}) else balikinTanah() Rayfield:Notify({Title="Balik", Content="Tanah balik normal", Duration=2}) end end})
TanahTab:CreateButton({Name="BALIKIN TANAH 100% NORMAL", Callback=function() balikinTanah() Rayfield:Notify({Title="Fix", Content="Tanah 100% balik", Duration=2}) end})

-- ===== FLY HP + SPEED 100-150 =====
_G.FlyOn=false _G.FlySpeed=80 local flyCon=nil local bv=nil local bg=nil _G.FlyDir=Vector3.new(0,0,0)
MoveTab:CreateToggle({Name="FLY HP ON/OFF", CurrentValue=false, Callback=function(V) _G.FlyOn=V local char=game.Players.LocalPlayer.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChild("Humanoid") if not hrp then return end if V then bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.new(0,0,0) bv.MaxForce=Vector3.new(9e9,9e9,9e9) bv.Parent=hrp bg=Instance.new("BodyGyro") bg.MaxTorque=Vector3.new(9e9,9e9,9e9) bg.P=9e4 bg.CFrame=hrp.CFrame bg.Parent=hrp if flyCon then flyCon:Disconnect() end flyCon=game:GetService("RunService").Heartbeat:Connect(function() if not _G.FlyOn then return end local cam=workspace.CurrentCamera local move=Vector3.new(0,0,0) if hum then move+=hum.MoveDirection * _G.FlySpeed end move+=_G.FlyDir if move.Magnitude>0 then bv.Velocity=move else bv.Velocity=Vector3.new(0,0,0) end bg.CFrame=cam.CFrame end) else if flyCon then flyCon:Disconnect() flyCon=nil end if bv then bv:Destroy() bv=nil end if bg then bg:Destroy() bg=nil end end end})
MoveTab:CreateSlider({Name="Fly Speed 20-150", Range={20,150}, Increment=10, CurrentValue=80, Callback=function(V) _G.FlySpeed=V end})
MoveTab:CreateButton({Name="⬆️ NAIK ATAS", Callback=function() _G.FlyDir=Vector3.new(0,_G.FlySpeed,0) end})
MoveTab:CreateButton({Name="⬇️ TURUN BAWAH", Callback=function() _G.FlyDir=Vector3.new(0,-_G.FlySpeed,0) end})
MoveTab:CreateButton({Name="⏹️ STOP NAIK/TURUN", Callback=function() _G.FlyDir=Vector3.new(0,0,0) end})
MoveTab:CreateSection("Speed 100-150")
MoveTab:CreateSlider({Name="Walk Speed 16-150", Range={16,150}, Increment=5, CurrentValue=16, Callback=function(V) local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") if hum then hum.WalkSpeed=V end end})
MoveTab:CreateButton({Name="Speed 100", Callback=function() local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") if hum then hum.WalkSpeed=100 end end})
MoveTab:CreateButton({Name="Speed 150 NGACIR", Callback=function() local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") if hum then hum.WalkSpeed=150 end end})
MoveTab:CreateButton({Name="Reset Speed 16", Callback=function() local hum=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") if hum then hum.WalkSpeed=16 end end})

-- ===== FREECAM HP NOCLIP BISA GERAK =====
local freecamOn=false local fSpeed=3 local fConn=nil local fPos=nil _G.FCamMove=Vector3.new(0,0,0)
CamTab:CreateToggle({Name="FREECAM HP ON/OFF + NOCLIP", CurrentValue=false, Callback=function(V) freecamOn=V local cam=workspace.CurrentCamera local plr=game.Players.LocalPlayer local char=plr.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChild("Humanoid") if V then fPos=cam.CFrame.Position cam.CameraType=Enum.CameraType.Scriptable _G.FreecamOld=hrp and hrp.CFrame or CFrame.new(0,5,0) if fConn then fConn:Disconnect() end fConn=game:GetService("RunService").RenderStepped:Connect(function() if not freecamOn then return end local move=Vector3.new(0,0,0) if hum and hum.MoveDirection.Magnitude>0 then move+=cam.CFrame.LookVector * hum.MoveDirection.Z * -1 * fSpeed move+=cam.CFrame.RightVector * hum.MoveDirection.X * fSpeed end move+=_G.FCamMove * fSpeed fPos+=move cam.CFrame=CFrame.new(fPos, fPos + cam.CFrame.LookVector) if hrp then hrp.CFrame=CFrame.new(fPos) hrp.Velocity=Vector3.new(0,0,0) for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end) else if fConn then fConn:Disconnect() fConn=nil end cam.CameraType=Enum.CameraType.Custom if plr.Character and plr.Character:FindFirstChild("Humanoid") then cam.CameraSubject=plr.Character:FindFirstChild("Humanoid") end if _G.FreecamOld and char and hrp then hrp.CFrame=_G.FreecamOld + Vector3.new(0,3,0) for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end _G.FCamMove=Vector3.new(0,0,0) end end})
CamTab:CreateSlider({Name="Speed Freecam 1-10", Range={1,10}, Increment=1, CurrentValue=3, Callback=function(V) fSpeed=V end})
CamTab:CreateButton({Name="⏩ MAJU", Callback=function() _G.FCamMove=workspace.CurrentCamera.CFrame.LookVector end})
CamTab:CreateButton({Name="⬆️ NAIK", Callback=function() _G.FCamMove=Vector3.new(0,1,0) end})
CamTab:CreateButton({Name="⬇️ TURUN", Callback=function() _G.FCamMove=Vector3.new(0,-1,0) end})
CamTab:CreateButton({Name="⏹️ STOP", Callback=function() _G.FCamMove=Vector3.new(0,0,0) end})

-- LOOP ALL
task.spawn(function() while task.wait(0.1) do if _G.HitboxOn then for _,p in pairs(game.Players:GetPlayers()) do if p~=game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0 then local h=p.Character.HumanoidRootPart h.Size=Vector3.new(_G.HitboxSize,_G.HitboxSize,_G.HitboxSize) h.Transparency=0.6 h.BrickColor=BrickColor.new("Really red") h.Material=Enum.Material.Neon h.CanCollide=false end end end if _G.AntiFlingOn then local c=game.Players.LocalPlayer.Character local hrp=c and c:FindFirstChild("HumanoidRootPart") if hrp then for _,v in pairs(c:GetDescendants()) do if v:IsA("BodyMover") or v:IsA("BodyVelocity") then if v.Parent~=hrp then v:Destroy() end end end if hrp.AssemblyLinearVelocity.Magnitude>80 then hrp.AssemblyLinearVelocity=Vector3.new(0,0,0) hrp.AssemblyAngularVelocity=Vector3.new(0,0,0) end end end if _G.NoclipOn then local c=game.Players.LocalPlayer.Character if c then for _,v in pairs(c:GetDescendants()) do if v:IsA("BasePart") and v.CanCollide then v.CanCollide=false end end end end end end)

Rayfield:Notify({Title="V58 ALL IN ONE", Content="Semua fitur ada! HP Ready", Duration=4})
