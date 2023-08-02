setfpscap(9999)

murder_sherrif_esp_key = "G"
gun_and_back_key = "C"
gun_key = "B"
find_gun_key = "Y"
fake_lag_key = "F"
walkspeed_19 = "R"
walkspeed_16 = "T"
noclip_key = "X"


--variables
local gundrop
local noclip = false
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local VPS = camera.ViewportSize
local Y75 = (0.75 * VPS.Y)

local Line = Drawing.new("Line")
Line.From = Vector2.new(VPS.X / 2, 0.75 * Y75)
Line.Visible = false
Line.Color = Color3.fromRGB(0,0,255)
Line.To = Vector2.new(0,0)


local UserInputService = Game:GetService('UserInputService')
functions = {
    [murder_sherrif_esp_key] = function()
        -- Sherrif
        for i, v in ipairs(game.Players:GetChildren()) do
            if v.Backpack:FindFirstChild('Gun') or v.Character:FindFirstChild('Gun') then
                if v.Character:FindFirstChild("HACKHIGHLIGHT") then
                    return
                end
                local high = Instance.new('Highlight')
                high.Name = "HACKHIGHLIGHT"
                high.FillColor = Color3.fromRGB(0,255,0)
                high.OutlineColor = Color3.fromRGB(0,0,255)
                high.FillTransparency = 0.5
                high.OutlineTransparency = 0
                high.Parent = v.Character
            end
        end
        -- murder
        for i, v in ipairs(game.Players:GetChildren()) do
            if v.Backpack:FindFirstChild('Knife') or v.Character:FindFirstChild('Knife') then
                if v.Character:FindFirstChild("HACKHIGHLIGHT") then
                    return
                end
                local high = Instance.new('Highlight')
                high.Name = "HACKHIGHLIGHT"
                high.FillColor = Color3.fromRGB(255,0,0)
                high.OutlineColor = Color3.fromRGB(255,0,0)
                high.FillTransparency = 0.5
                high.OutlineTransparency = 0
                high.Parent = v.Character
            end
        end
    end,
    [gun_and_back_key] = function()
        local ogcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local gun = workspace:FindFirstChild('GunDrop').CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gun
        task.wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ogcframe
    end,
    [gun_key] = function()
        local gun = workspace:FindFirstChild('GunDrop').CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = gun
    end,
    [fake_lag_key] = function()
        print("this doesnt work at all!")
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = not LocalPlayer.Character.HumanoidRootPart.Anchored
    end,
    [walkspeed_19] = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 19
    end,
    [walkspeed_16] = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end,
    [noclip_key] = function()
        noclip = not noclip
        if noclip then
            for i, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        elseif not noclip then
            for i, v in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end,
}

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode and functions[UserInputService:GetStringForKeyCode(input.KeyCode)] and not gameProcessed then
        functions[UserInputService:GetStringForKeyCode(input.KeyCode)]()
    end
end)

------------------------------------------------------------------------------------------------------------------------------------
workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.01)
    if obj.Name == "GunDrop" then
        local high = Instance.new("Highlight")
        high.FillTransparency = 1
        high.OutlineColor = Color3.fromRGB(0,0,255)
        high.Parent = obj

        Line.Visible = true
        gundrop = obj
    end
end)
------------------------------------------------------------------------------------------------------------------------------------
workspace.DescendantRemoving:Connect(function(obj)
    if obj.Name == "GunDrop" then
        gundrop = nil
        Line.Visible = false
    end
end)
------------------------------------------------------------------------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if gundrop then
        local screenPosition, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(gundrop.Position)
        local screenVector = Vector2.new(screenPosition.X, screenPosition.Y + GuiInset.Y)
        Line.To = screenVector
    end
end)
