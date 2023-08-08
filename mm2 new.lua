-- Welcome to valyse!-- Please execute script BEFORE round starts, ESP will not work mid-round
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
toggle_infinite_jump = "H"
teleport_to_nearest_player = "N"



-- Usual Variables
local UserInputService = Game:GetService('UserInputService')
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local camera = workspace.CurrentCamera
local VPS = camera.ViewportSize
local Y75 = (0.75 * VPS.Y)

-- weird variables
local murder = nil
local sheriff = nil
local GunDropCFrame = nil
local GunDropVec3


-- booleans
local noclipBool = false
local MurderSheriffESPBool = true
local PlayerESPBool = true
local ESPBool = true
local deadBool = false
local infiniteJumpBool = false

-- Preloaded stuff to reduce lag
local gundropHighlight = Instance.new("Highlight")
gundropHighlight.FillTransparency = 1
gundropHighlight.OutlineColor = Color3.fromRGB(0,0,255)
gundropHighlight.Enabled = true
local GunDropLine = Drawing.new("Line")
GunDropLine.From = Vector2.new(VPS.X / 2, 0.75 * Y75)
GunDropLine.Visible = false
GunDropLine.Color = Color3.fromRGB(0,255,255)
GunDropLine.To = Vector2.new(0,0)

LineCollection = {}
HighlightCollection = {}
alivePlayers = {}
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

functions = {
    [murder_sherrif_esp_key] = function()
        MurderSheriffESPBool = not MurderSheriffESPBool
        if MurderSheriffESPBool then
            HighlightCollection[murder].Enabled = true
            HighlightCollection[sheriff].Enabled = true
            LineCollection[murder.Visible = true
            LineCollection[sheriff].Visible = true
        else
            HighlightCollection[murder].Enabled = false
            HighlightCollection[sheriff].Enabled = false
            LineCollection[murder.Visible = false
            LineCollection[sheriff].Visible = false
        end
    end,
    [gun_and_back_key] = function()
        if GunDropCFrame then
            local ogcframe = LocalPlayer.Character.HumanoidRootPart.CFrame
            LocalPlayer.Character.HumanoidRootPart.CFrame = GunDropCFrame
            task.wait(0.2)
            LocalPlayer.Character.HumanoidRootPart.CFrame = ogcframe
        end
    end,
    [gun_key] = function()
        if GunDropCFrame then
            LocalPlayer.Character.HumanoidRootPart.CFrame = GunDropCFrame
        end
    end,
    [fake_lag_key] = function()
        print("this doesnt work at all!")
        LocalPlayer.Character.HumanoidRootPart.Anchored = not LocalPlayer.Character.HumanoidRootPart.Anchored
    end,
    [walkspeed_19] = function()
        LocalPlayer.Character.Humanoid.WalkSpeed = 19
    end,
    [walkspeed_16] = function()
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end,
    [noclipBool_key] = function()
        noclipBool = not noclipBool
        if noclipBool then
            LocalPlayer.Character.UpperTorso.CanCollide = false
            LocalPlayer.Character.LowerTorso.CanCollide = false
        elseif not noclipBool then
            LocalPlayer.Character.UpperTorso.CanCollide = true
            LocalPlayer.Character.LowerTorso.CanCollide = true
        end
    end,
    [player_esp_key] = function()
        PlayerESPBool = not PlayerESPBool
        if PlayerESPBool then
            for i, v in ipairs(alivePlayers)) do
                if v.Name ~= murder or sheriff then
                    HighlightCollection[v.Name].Enabled = true
                    LineCollection[v.Name].Visible = true
                end
            end
        else
            for i, v in ipairs(alivePlayers)) do
                if v.Name ~= murder or sheriff then
                    HighlightCollection[v.Name].Enabled = false
                    LineCollection[v.Name].Visible = false
                end
            end
        end
    end,
    [toggle_infinite_jump] = function()
        infiniteJumpBool = not infiniteJumpBool
    end,
    [teleport_to_nearest_player] = function()
        Magnitude = 999999999
        nearestPlayer = nil
        for i, v in ipairs(game:GetService("Players"):GetPlayers()) do
            if v.Character and  v.Character:FindFirstChild("HumanoidRootPart") and v.Name ~= LocalPlayer.Name then
                if (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < Magnitude then
                    Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    nearestPlayer = v
                end
            end
        end
        LocalPlayer.Character.HumanoidRootPart.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame
    end,
}

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpBool then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode and functions[UserInputService:GetStringForKeyCode(input.KeyCode)] and not gameProcessed then
        functions[UserInputService:GetStringForKeyCode(input.KeyCode)]()
    end
end)

------------------------------------------------------------------------------------------------------------------------------------ Checking when sheriff died and shows gun
workspace.DescendantAdded:Connect(function(Instance)
    task.wait(0.01)
    if Instance.Name == "GunDrop" and not deadBool then
        gundropHighlight.Parent = Instance

        GunDropLine.Visible = true
        GunDropVec3 = Instance.Position
        GunDropCFrame = Instance.CFrame
    end
end)
------------------------------------------------------------------------------------------------------------------------------------ Checking if gun is gone and making the Line gone
workspace.DescendantRemoving:Connect(function(Instance) -- SETTING NEW SHERIFF DOESNT WORK
    if Instance.Name == "GunDrop" then
        GundDropVec3 = nil
        GunDropCFrame = nil
        GunDropLine.Visible = false
        for i, v in ipairs(alivePlayers) do
            if v.Character then
                if v.Backpack:FindFirstChild('Gun') or v.Character:FindFirstChild('Gun') then -- sheriff
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
                end
            end
        end
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
    HighlightCollection[player.Name].Enabled = false
    LineCollection[player.Name].Visible = false
    HighlightCollection[player.Name] = nil
    LineCollection[player.Name] = nil
end)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ ROUND START
------------------------------------------------------------------------------------------------------------------------------------
ReplicatedStorage.Remotes.Gameplay.RoundStart.OnClientEvent:Connect(function()
    deadBool = false
    for i, v in ipairs(alivePlayers) do
        if v.Character then
            v.Character.UpperTorso.CanCollide = false
            v.Character.LowerTorso.CanCollide = false
            if v.Backpack:FindFirstChild('Knife') or v.Character:FindFirstChild('Knife') then -- murder
                murder = v.Name
                if murder == LocalPlayer.Name then -- if YOU are the murder
                    HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(255,0,0)
                    HighlightCollection[v.Name].FillColor = Color3.fromRGB(255,0,0)
                    HighlightCollection[v.Name].Enabled = true
                    for i, v in ipairs(alivePlayers) do
                        if HighlightCollection[v.Name] and LineCollection[v.Name] and v.Name ~= LocalPlayer.Name then
                            HighlightCollection[v.Name].Enabled = true
                            LineCollection[v.Name].Visible = true
                        end
                    end
                else
                    murder = v.Name
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
                HighlightCollection[v.Name].OutlineColor = Color3.fromRGB(0,0,0)
                LineCollection[v.Name].Color = Color3.fromRGB(0,0,0)
                if not PlayerESPBool then
                    HighlightCollection[v.Name].Enabled = false
                    LineCollection[v.Name].Visible = false
                end
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
    for index, value in ipairs(alivePlayers) do
        if value.Character and value.Character:FindFirstChild("HumanoidRootPart") then
            local screenPosition, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(value.Character.HumanoidRootPart.Position)
            if isOnScreen then
                local screenVector = Vector2.new(screenPosition.X, screenPosition.Y + GuiInset.Y)
                LineCollection[value.Name].To = screenVector
            end
        end
    end
    if GunDropVec3 then
        local screenPosition, isOnScreen = workspace.CurrentCamera:WorldToScreenPoint(GunDropVec3)
        if isOnScreen then
            local screenVector = Vector2.new(screenPosition.X, screenPosition.Y + GuiInset.Y)
            GunDropLine.To = screenVector
        end
    end
    if LocalPlayer.Character then
        for i, v in ipairs(LocalPlayer.Character:GetDescendants()) do
            if noclipBool and v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------ RENDERSTEPPED
------------------------------------------------------------------------------------------------------------------------------------


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

ReplicatedStorage.Remotes.Gameplay.VictoryScreen.OnClientEvent:Connect(function()
    GunDropCFrame = nil
    GunDropVec3 = nil
    GunDropLine.Visible = false
    for i = 1, #alivePlayers do
        table.remove(alivePlayers, i)
    end
end)

ReplicatedStorage.Remotes.Gameplay.RoleSelect.OnClientEvent:Connect(function()
    task.wait(2)
    for i, v in ipairs(game.Players:GetPlayers()) do
        table.insert(alivePlayers, v)
        v.Character.Humanoid.Died:Connect(function() -- attempt to index nil with humanoid
            for index = 1, #alivePlayers do
                if alivePlayers[index].Name == v.Name then                       
                    table.remove(alivePlayers, index)
                    break
                end
            end
            if v.Name == LocalPlayer.Name then
                deadBool = true
                GunDropLine.Visible = false
                for i, v in ipairs(HighlightCollection) do
                    v.Enabled = false
                end
                for i, v in ipairs(LineCollection) do
                    v.Visible = false
                end
            end
            HighlightCollection[v.Name].Enabled = false
            LineCollection[v.Name].Visible = false
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
