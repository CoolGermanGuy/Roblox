-- Services
local Players = game:GetService("Players")

-- Variables
LocalPlayer = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui") -- create ScreenGui
ScreenGui.Name = "CoolGermanGuy's MM2 Script"
ScreenGui.Parent = LocalPlayer.PlayerGui

local BackgroundFrame = Instance.new("Frame") -- create BackgroundFrame
BackgroundFrame.Name = "BackgroundFrame"
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Instance.new("UICorner").Parent = BackgroundFrame -- add UICorner
BackgroundFrame.Parent = ScreenGui

local HolderFrame = Instance.new("Frame")
local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.CellPadding = {0, 10, 0, 7}
UIGridLayout.CellSize = {0.5, -5, 0, 50}
UIGridLayout.Parent = HolderFrame

for i = 0, 12, 1 do
    local PlayerFrame = Instance.new("Frame")
    PlayerFrame.BackgroundColor = Color3.fromRGB(94,94,94)
    Instance.new("UICorner").Parent = PlayerFrame
end
HolderFrame.Parent = BackgroundFrame
