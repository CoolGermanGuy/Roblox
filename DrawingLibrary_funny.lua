local Drawing1 = Drawing.new("Circle")
local Drawing2 = Drawing.new("Circle")
local Drawing3 = Drawing.new("Quad")
local Drawing4 = Drawing.new("Circle")

local camera = workspace.CurrentCamera
local VPS = camera.ViewportSize
local GuiInset= game:GetService("GuiService"):GetGuiInset()
local RunService = game:GetService("RunService")
HueOffset = 0

Drawing1.NumSides = 32
Drawing1.Radius = 150
--                             |        X       |       Y            |
Drawing1.Position = Vector2.new(0.85 * (VPS.X / 2),  1.4 * (VPS.Y / 2))
Drawing1.Thickness = 4
Drawing1.Filled = true
Drawing1.Visible = true
Drawing1.Color = Color3.fromRGB(1,1,1)
Drawing1.Transparency = 1

Drawing2.NumSides = 32
Drawing2.Radius = 150
--                             |        X       |       Y            |
Drawing2.Position = Vector2.new(1.15 * (VPS.X / 2),  1.4 * (VPS.Y / 2))
Drawing2.Thickness = 4
Drawing2.Filled = true
Drawing2.Visible = true
Drawing2.Color = Color3.fromRGB(1,1,1)
Drawing2.Transparency = 1
--                             |        X       |       Y            |
Drawing3.PointA = Vector2.new(0.884 * (VPS.X / 2), 0.4 * (VPS.Y / 2))
Drawing3.PointB = Vector2.new(1.116 * (VPS.X / 2), 0.4 * (VPS.Y / 2))
Drawing3.PointC = Vector2.new(1.116 * (VPS.X / 2), 1.4 * (VPS.Y / 2))
Drawing3.PointD = Vector2.new(0.884 * (VPS.X / 2), 1.4 * (VPS.Y / 2))
Drawing3.Thickness = 4
Drawing3.Filled = true
Drawing3.Visible = true
Drawing3.Color = Color3.fromRGB(1,1,1)
Drawing3.Transparency = 1

Drawing4.NumSides = 32
Drawing4.Radius = 150
--                             |        X       |       Y            |
Drawing4.Position = Vector2.new(VPS.X / 2,  0.4 * (VPS.Y / 2))
Drawing4.Thickness = 4
Drawing4.Filled = true
Drawing4.Visible = true
Drawing4.Color = Color3.fromRGB(1,1,1)
Drawing4.Transparency = 1


RunService.RenderStepped:Connect(function()
    --skidded this part :/ (idk how Hue works)
    HueOffset = (HueOffset + 0.001) % 1
    local rainbowColor = Color3.fromHSV(HueOffset, 1, 1)
    Drawing1.Color = rainbowColor
    Drawing2.Color = rainbowColor
    Drawing3.Color = rainbowColor
    Drawing4.Color = rainbowColor
end)
