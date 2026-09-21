-- HOROMORI V51 FIX - NO ERROR
repeat task.wait() until game:IsLoaded()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Horomori V51 FIX FTAP", LoadingTitle = "Fixing...", LoadingSubtitle = "All Feature Fixed", ConfigurationSaving = {Enabled = false}})

local HitboxTab = Window:CreateTab("Hitbox", 4483362458)
local ProtectTab = Window:CreateTab("Protection", 4483362458)
local InvisTab = Window:CreateTab("Invisible", 4483362458)
local CamTab = Window:CreateTab("Freecam", 4483362458)

-- FIX HITBOX
_G.HitboxOn=false _G.HitboxSize=10
local function resetHitbox()
    for _,p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local h = p.Character.HumanoidRootPart
            h.Size=Vector3.new(2,2,1)
            h.Transparency=1
            h.BrickColor=BrickColor.new("Medium stone grey")
            h.Material=Enum.Material.Plastic
            h.CanCollide=true
        end
    end
end

HitboxTab:CreateToggle({Name="Hitbox ON/OFF [FIX]", CurrentValue=false, Callback=function(V) _G.HitboxOn=V if not V then resetHitbox() end end})
HitboxTab:CreateSlider({Name="Ukuran 3-35", Range={3,35}, Increment=1, CurrentValue=10, Callback=function(V) _G.HitboxSize=V end})
HitboxTab:CreateButton({Name="Reset Hitbox", Callback=function() _G.HitboxOn=false resetHitbox() Rayfield:Notify({Title="Fixed", Content="Hitbox Reset", Duration=2}) end})

-- FIX ANTI FLING V3 (GAK MENTAL LAGI)
_G.AntiFlingOn=false
ProtectTab:CreateToggle({Name="Anti Fling V3 FIX", CurrentValue=false, Callback=function(V)
    _G.AntiFlingOn=V
    if V then
        Rayfield:Notify({Title="Protection", Content="Anti Fling ON - Anti Lempar", Duration=3})
    end
end})

-- FIX INVISIBLE (GAK RESPAWN)
local oldTrans={}
InvisTab:CreateToggle({Name="Invisible Real [FIX]", CurrentValue=false, Callback=function(V)
    local c=game.Players.LocalPlayer.Character
    if not c then return end
    for _,o in pairs(c:GetDescendants()) do
        if o:IsA("BasePart") and o.Name~="HumanoidRootPart" then
            if V then
                oldTrans[o]=o.Transparency
                o.Transparency=1
            else
                o.Transparency=oldTrans[o] or 0
            end
        elseif o:IsA("Decal") or o:IsA("Texture") then
            o.Transparency = V and 1 or 0
        end
    end
    if c:FindFirstChild("Humanoid") then
        c.Humanoid.DisplayDistanceType = V and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
    end
end})

-- FIX FREECAM (GAK NYANGKUT)
local freecamOn=false local camSpeed=3 local conn=nil
CamTab:CreateToggle({Name="Freecam Bebas [FIX]", CurrentValue=false, Callback=function(V)
    freecamOn=V
    local cam=workspace.CurrentCamera
    local plr=game.Players.LocalPlayer
    if V then
        cam.CameraType=Enum.CameraType.Scriptable
        if conn then conn:Disconnect() end
        conn=game:GetService("RunService").RenderStepped:Connect(function()
            if not freecamOn then return end
            local UIS=game:GetService("UserInputService")
            local m=Vector3.new(0,0,0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then m+=Vector3.new(0,0,-camSpeed) end
            if UIS:IsKeyDown(Enum.KeyCode.S) then m+=Vector3.new(0,0,camSpeed) end
            if UIS:IsKeyDown(Enum.KeyCode.A) then m+=Vector3.new(-camSpeed,0,0) end
            if UIS:IsKeyDown(Enum.KeyCode.D) then m+=Vector3.new(camSpeed,0,0) end
            if UIS:IsKeyDown(Enum.KeyCode.E) then m+=Vector3.new(0,camSpeed,0) end
            if UIS:IsKeyDown(Enum.KeyCode.Q) then m+=Vector3.new(0,-camSpeed,0) end
            cam.CFrame=cam.CFrame*CFrame.new(m)
        end)
    else
        if conn then conn:Disconnect() conn=nil end
        cam.CameraType=Enum.CameraType.Custom
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            cam.CameraSubject=plr.Character:FindFirstChild("Humanoid")
        end
    end
end})
CamTab:CreateSlider({Name="Speed Freecam 1-10", Range={1,10}, Increment=1, CurrentValue=3, Callback=function(V) camSpeed=V end})

-- LOOP FIX
task.spawn(function()
    while task.wait(0.15) do
        -- HITBOX LOOP
        if _G.HitboxOn then
            for _,p in pairs(game.Players:GetPlayers()) do
                if p~=game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0 then
                    local hrp=p.Character.HumanoidRootPart
                    hrp.Size=Vector3.new(_G.HitboxSize,_G.HitboxSize,_G.HitboxSize)
                    hrp.Transparency=0.6
                    hrp.BrickColor=BrickColor.new("Really red")
                    hrp.Material=Enum.Material.Neon
                    hrp.CanCollide=false
                end
            end
        end
        -- ANTI FLING LOOP FIX V3
        if _G.AntiFlingOn then
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _,v in pairs(char:GetDescendants()) do
                    if v:IsA("BodyMover") or v:IsA("BodyPosition") or v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                        if v.Parent ~= hrp then
                            v:Destroy()
                        end
                    end
                end
                if hrp.AssemblyLinearVelocity.Magnitude > 80 or hrp.AssemblyAngularVelocity.Magnitude > 80 then
                    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
                end
            end
        end
    end
end)

Rayfield:Notify({Title="V51 FIX", Content="Semua fitur Fixed - No Error", Duration=3})
