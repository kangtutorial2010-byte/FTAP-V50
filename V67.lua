-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Hitbox Hub | TUBA",
   LoadingTitle = "Memuat Script...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Hitbox Feature", 4483362458) -- Icon Tab

-- Variables
local hitboxOn = false
local currentSize = 10
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Fungsi Update Hitbox
local function updateHitbox()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "HumanoidRootPart" or obj.Name == "Torso" or obj.Name == "UpperTorso" or obj.Name == "Head") then
            if not LocalPlayer.Character or not obj:IsDescendantOf(LocalPlayer.Character) then
                if hitboxOn then
                    obj.Size = Vector3.new(currentSize, currentSize, currentSize)
                    obj.Transparency = 0.5
                    obj.Color = Color3.fromRGB(255, 255, 255) -- Warna Putih
                    obj.Material = Enum.Material.ForceField
                    obj.CanCollide = false
                else
                    obj.Size = Vector3.new(2, 2, 1)
                    obj.Transparency = 1
                end
            end
        end
    end
end

-- Toggle Hitbox (ON/OFF)
local Toggle = Tab:CreateToggle({
   Name = "Aktifkan Hitbox",
   CurrentValue = false,
   Flag = "HitboxToggle",
   Callback = function(Value)
       hitboxOn = Value
       if not hitboxOn then
           updateHitbox()
       end
   end,
})

-- Slider Ukuran (10 - 130)
local Slider = Tab:CreateSlider({
   Name = "Ukuran Hitbox (Putih)",
   Range = {10, 130},
   Increment = 5,
   Suffix = " Studs",
   CurrentValue = 10,
   Flag = "HitboxSize",
   Callback = function(Value)
       currentSize = Value
   end,
})

-- Loop Render Khusus Rayfield & Delta
RunService.RenderStepped:Connect(function()
    if hitboxOn then
        updateHitbox()
    end
end)
