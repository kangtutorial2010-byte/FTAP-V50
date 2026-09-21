repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Horomori V50 FTAP", LoadingTitle = "Horomori V50", ConfigurationSaving = {Enabled = false}})
local HitboxTab = Window:CreateTab("Hitbox", 4483362458)
local ProtectTab = Window:CreateTab("Protection", 4483362458)
local InvisTab = Window:CreateTab("Invisible", 4483362458)
local CamTab = Window:CreateTab("Freecam", 4483362458)
_G.HitboxOn=false _G.HitboxSize=10 _G.AntiFlingOn=false
local function resetHitbox() for _,p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.Size=Vector3.new(2,2,1) p.Character.HumanoidRootPart.Transparency=1 end end end
HitboxTab:CreateToggle({Name="Hitbox ON/OFF", CurrentValue=false, Callback=function(V) _G.HitboxOn=V if not V then resetHitbox() end end})
HitboxTab:CreateSlider({Name="Ukuran 3-30", Range={3,30}, Increment=1, CurrentValue=10, Callback=function(V) _G.HitboxSize=V end})
HitboxTab:CreateButton({Name="Reset", Callback=function() _G.HitboxOn=false resetHitbox() end})
ProtectTab:CreateToggle({Name="Anti Fling V2", CurrentValue=false, Callback=function(V) _G.AntiFlingOn=V end})
InvisTab:CreateToggle({Name="Invisible Real", CurrentValue=false, Callback=function(V) local c=game.Players.LocalPlayer.Character if not c then return end for _,o in pairs(c:GetDescendants()) do if o:IsA("BasePart") and o.Name~="HumanoidRootPart" then o.Transparency=V and 1 or 0 end end end})
local freecamOn=false local camSpeed=2 local conn=nil
CamTab:CreateToggle({Name="Freecam Bebas", CurrentValue=false, Callback=function(V) freecamOn=V local cam=workspace.CurrentCamera local plr=game.Players.LocalPlayer if V then cam.CameraType=Enum.CameraType.Scriptable if conn then conn:Disconnect() end conn=game:GetService("RunService").RenderStepped:Connect(function() if not freecamOn then return end local UIS=game:GetService("UserInputService") local m=Vector3.new(0,0,0) if UIS:IsKeyDown(Enum.KeyCode.W) then m+=Vector3.new(0,0,-camSpeed) end if UIS:IsKeyDown(Enum.KeyCode.S) then m+=Vector3.new(0,0,camSpeed) end if UIS:IsKeyDown(Enum.KeyCode.A) then m+=Vector3.new(-camSpeed,0,0) end if UIS:IsKeyDown(Enum.KeyCode.D) then m+=Vector3.new(camSpeed,0,0) end if UIS:IsKeyDown(Enum.KeyCode.E) then m+=Vector3.new(0,camSpeed,0) end if UIS:IsKeyDown(Enum.KeyCode.Q) then m+=Vector3.new(0,-camSpeed,0) end cam.CFrame=cam.CFrame*CFrame.new(m) end) else if conn then conn:Disconnect() conn=nil end cam.CameraType=Enum.CameraType.Custom cam.CameraSubject=plr.Character:FindFirstChild("Humanoid") end end})
CamTab:CreateSlider({Name="Speed", Range={1,10}, Increment=1, CurrentValue=2, Callback=function(V) camSpeed=V end})
task.spawn(function() while task.wait(0.1) do if _G.HitboxOn then for _,p in pairs(game.Players:GetPlayers()) do if p~=game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then local hrp=p.Character.HumanoidRootPart hrp.Size=Vector3.new(_G.HitboxSize,_G.HitboxSize,_G.HitboxSize) hrp.Transparency=0.7 hrp.BrickColor=BrickColor.new("Really red") hrp.Material=Enum.Material.Neon end end end if _G.AntiFlingOn then local hrp=game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if hrp and hrp.Velocity.Magnitude>70 then hrp.Velocity=Vector3.new(0,0,0) end end end end)
