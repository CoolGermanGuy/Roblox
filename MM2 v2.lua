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
Instance.new("UICorner").Parent = BackgroundFrame -- add UICorner
BackgroundFrame.Parent = ScreenGui

