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
local BackgroundFrameUICorner = Instance.new("UICorner")
BackgroundFrameUICorner.CornerRadius = UDim.new(0, 10)
BackgroundFrameUICorner.Parent = BackgroundFrame
BackgroundFrame.Parent = ScreenGui

local HolderFrame = Instance.new("Frame") -- create HolderFrame
local UIGridLayout = Instance.new("UIGridLayout") -- manages player UI
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 7)
UIGridLayout.CellSize = UDim2.new(0.5, -5, 0, 50)
UIGridLayout.Parent = HolderFrame

for i = 0, 12, 1 do -- add UI for each player
    local PlayerFrame = Instance.new("Frame")
    PlayerFrame.BackgroundColor3 = Color3.fromRGB(94,94,94)
    local PlayerFrameUICorner = Instance.new("UICorner")
    PlayerFrameUICorner.CornerRadius = UDim.new(0, 8)
    PlayerFrameUICorner.Parent = PlayerFrame
end
HolderFrame.Parent = BackgroundFrame
