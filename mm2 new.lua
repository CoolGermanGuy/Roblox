-- Please execute script BEFORE round starts, ESP will not work mid-round
setfpscap(9999)

murder_sherrif_esp_key = "G"
gun_and_back_key = "C"
gun_key = "B"
find_gun_key = "Y"
fake_lag_key = "F"
walkspeed_19 = "R"
walkspeed_16 = "T"
noclipBool_key = "X"
player_esp_key = "P"
teleport_to_nearest_player = "E"



-- Usual Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local VPS = camera.ViewportSize
local Y75 = (0.75 * VPS.Y)

-- weird variables
local murder = nil
local sheriff = nil
local GunDrop = nil


-- booleans
local gundropBool = false
local noclipBool = false
local MurderSheriffESPBool = true
local PlayerESPBool = false
local ESPBool = true

-- Preloaded stuff to reduce lag
local gundropHighlight = Instance.new("Highlight")
gundropHighlight.FillTransparency = 1
gundropHighlight.OutlineColor = Color3.fromRGB(0,0,255)
gundropHighlight.Enabled = true
local GunDropLine = Drawing.new("Line")
GunDropLine.From = Vector2.new(VPS.X / 2, 0.75 * Y75)
GunDropLine.Visible = false
GunDropLine.Color = Color3.fromRGB(0,0,255)
GunDropLine.To = Vector2.new(0,0)

LineCollection = {}
HighlightCollection = {}
alivePlayers = {}
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
local UserInputService = Game:GetService('UserInputService')
functions = {
    [murder_sherrif_esp_key] = function()
        MurderSheriffESPBool = not MurderSheriffESPBool
        if murder and MurderSheriffESPBool then
            murder.PlayerHighlight.Enabled = true
        elseif murder and not MurderSheriffESPBool then
            murder.PlayerHighlight.Enabled = false
        elseif sheriff and not MurderSheriffESPBool then
            sheriff.PlayerHighlight.Enabled = true
        elseif sheriff and not MurderSheriffESPBool then
            sheriff.PlayerHighlight.Enabled = false
        end
    end,
    [gun_and_back_key] = function()
        if gundropBool then
            local ogcframe = Character.HumanoidRootPart.CFrame
            Character.HumanoidRootPart.CFrame = GunDrop.CFrame
            task.wait(0.2)
            Character.HumanoidRootPart.CFrame = ogcframe
        end
    end,
    [gun_key] = function()
        if gundropBool then
            Character.HumanoidRootPart.CFrame = GunDrop.CFrame
        end
    end,
    [fake_lag_key] = function()
        print("this doesnt work at all!")
        Character.HumanoidRootPart.Anchored = not Character.HumanoidRootPart.Anchored
    end,
    [walkspeed_19] = function()
        Character.Humanoid.WalkSpeed = 19
    end,
    [walkspeed_16] = function()
        Character.Humanoid.WalkSpeed = 16
    end,
    [noclipBool_key] = function()
        noclipBool = not noclipBool
        if noclipBool then
            Character.UpperTorso.CanCollide = false
            Character.LowerTorso.CanCollide = false
        elseif not noclipBool then
            Character.UpperTorso.CanCollide = true
            Character.LowerTorso.CanCollide = true
        end
    end,
    [teleport_to_nearest_player] = function()
        for i, v in ipairs(game.Players:GetPlayers()) do
            print("i", i)
            print("v", v)
            --[[
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                print("foo")
                local magnitude = (Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                print(magnitude)
                print("current", nearestPlayer)
                if magnitude < nearestPlayer then
                    print("new", nearestPlayer)
                    nearestPlayer = magnitude
                end
            end
            ]]
        end
    end,
    [player_esp_key] = function()
        player_esp = not player_esp
        if player_esp then
            for i, v in ipairs(game.Players:GetPlayers()) do

            end
        end
    end,
}

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode and functions[UserInputService:GetStringForKeyCode(input.KeyCode)] and not gameProcessed then
        functions[UserInputService:GetStringForKeyCode(input.KeyCode)]()
    end
end)

------------------------------------------------------------------------------------------------------------------------------------ Checking when sheriff died and shows gun
workspace.DescendantAdded:Connect(function(Instance)
    task.wait(0.01)
    if Instance.Name == "GunDrop" then
        gundropHighlight.Parent = Instance

        GunDropLine.Visible = true
        gundropBool = Instance
    end
end)
------------------------------------------------------------------------------------------------------------------------------------ Checking if gun is gone and making the Line gone
workspace.DescendantRemoving:Connect(function(Instance)
    if Instance.Name == "GunDrop" then
        GundDrop = nil
        GunDropLine.Visible = false
    end
end)
------------------------------------------------------------------------------------------------------------------------------------ player joins = make esp ready
Players.PlayerAdded:Connect(function(player)
    local PlayerHighlight = Instance.new("Highlight")
    PlayerHighlight.Name = "PlayerHighlight"
    PlayerHighlight.FillColor = Color3.fromRGB(0,0,0)
    PlayerHighlight.OutlineColor = Color3.fromRGB(0,0,0)
    PlayerHighlight.FillTransparency = 1
    PlayerHighlight.OutlineTransparency = 0
    PlayerHighlight.Enabled = player_esp
    local PlayerLine = Drawing.new("Line")
    PlayerLine.From = Vector2.new(VPS.X / 2, 0.75 * Y75)
    PlayerLine.Visible = false
    PlayerLine.Color = Color3.fromRGB(0,0,0)
    PlayerLine.To = Vector2.new(0,0)

    HighlightCollection[player.Name] = PlayerHighlight
    LineCollection[player.Name] = PlayerLine
end)

Players.PlayerRemoving:Connect(function(player)
    HighlightCollection[player.Name] = nil
    LineCollection[player.Name] = nil
end)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ ROUND START
------------------------------------------------------------------------------------------------------------------------------------
ReplicatedStorage.Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function() 
    for i, v in ipairs(game.Players:GetPlayers()) do
        if v.Backpack:FindFirstChild('Knife') or v.Character:FindFirstChild('Knife') then -- murder
            murder = v.Name
            if murder == LocalPlayer.Name then -- if YOU are the murder
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(255,0,0)
                HighlightCollection[v.Name].FillColor = Color3.fromRGB(255,0,0)
                HighlightCollection[v.Name].Enabled = true
                -- do nothing cuz I dont want a line to myself
            else
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(255,0,0)
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(255,0,0)
                HighlightCollection[v.Name].Enabled = true
                HighlightCollection[v.Name].Parent = v.Character
                LineCollection[v.Name].Color = Color3.fromRGB(255,0,0)
                LineCollection[v.Name].Visible = true
            end
        elseif v.Backpack:FindFirstChild('Gun') or v.Character:FindFirstChild('Gun') then -- sheriff
            sheriff = v.Name
            if sheriff == LocalPlayer.Name then -- if YOU are the sheriff
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(0,0,255)
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(0,0,255)
                HighlightCollection[v.Name].Enabled = true
                -- do nothing cuz I dont want a line to myself
            else
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(0,0,255)
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(0,0,255)
                HighlightCollection[v.Name].Parent = v.Character
                HighlightCollection[v.Name].Enabled = true
                LineCollection[v.Name].Color = Color3.fromRGB(0,0,255)
                LineCollection[v.Name].Visible = true
            end
        else
            HighlightCollection[v.Name].Parent = v.Character
            LineCollection[v.Name].Color = Color3.fromRGB(0,0,0)
            if not PlayerESPBool then
                HighlightCollection[v.Name].Enabled = false
                LineCollection[v.Name].Visible = false
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ ROUND START
------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ RENDERSTEPPED
------------------------------------------------------------------------------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    for index, player in ipairs(alivePlayers) do
        if player:FindFirstChild("Character") then
            local screenPosition, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            if isOnScreen then
                local screenVector = Vector2.new(screenPosition.X, screenPosition.Y + GuiInset.Y)
                LineCollection[player.Name].To = screenVector
            end
        end
    end
    if gundropBool then
        local screenPosition, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(gundropBool.Position)
        if isOnScreen then
            local screenVector = Vector2.new(screenPosition.X, screenPosition.Y + GuiInset.Y)
            GunDropLine.To = screenVector
        end
    end
    
    for i, v in ipairs(Character:GetDescendants()) do
        if noclipBool and v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ RENDERSTEPPED
------------------------------------------------------------------------------------------------------------------------------------

ReplicatedStorage.Remotes.Gameplay.GameOver.OnClientEvent:Connect(function()
    gundropBool = false
    nearestPlayer = 99999999999999
    GunDropLine.Visible = false
    for index, value in ipairs(alivePlayers) do
        value = nil
    end
    task.wait(0.5)
    for i, v in ipairs(Players:GetPlayers()) do
        table.insert(alivePlayers, v)

        v.Character.Died:Connect(function()
            print(v.Name, "died!")
        end)
    end
end)

ReplicatedStorage.Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
    for key, value in pairs(HighlightCollection) do
        value.FillColor = Color3.fromRGB(0,0,0)
        value.OutlineColor = Color3.fromRGB(0,0,0)
        value.Enabled = false
    end
    for key, value in pairs(LineCollection) do
        value.Color = Color3.fromRGB(0,0,0)
        value.Visible = false
    end
end)

Character.Humanoid.Died:Connect(function()
    print("YOU died!")
end)

ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:Connect(function()
    for i, v in ipairs(Players:GetPlayers()) do
        table.insert(alivePlayers, v)

        v.CharacterAdded:Connect(function(Character)

        end)
    end
end)

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ !!! ON EXECUTE !!!
------------------------------------------------------------------------------------------------------------------------------------
for index, player in ipairs(Players:GetPlayers()) do
    local PlayerHighlight = Instance.new("Highlight") -- make highlight
    PlayerHighlight.Name = "PlayerHighlight"
    PlayerHighlight.FillColor = Color3.fromRGB(0,0,0)
    PlayerHighlight.OutlineColor = Color3.fromRGB(0,0,0)
    PlayerHighlight.FillTransparency = 1
    PlayerHighlight.OutlineTransparency = 0
    PlayerHighlight.Enabled = player_esp

    local PlayerLine = Drawing.new("Line") -- make line
    PlayerLine.From = Vector2.new(VPS.X / 2, 0.75 * Y75)
    PlayerLine.Visible = false
    PlayerLine.Color = Color3.fromRGB(0,0,0)
    PlayerLine.To = Vector2.new(0,0)

    HighlightCollection[player.Name] = PlayerHighlight
    LineCollection[player.Name] = PlayerLine
end
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ !!! ON EXECUTE !!!
------------------------------------------------------------------------------------------------------------------------------------
print("CoolGermanGuy's MM2 script executed")
