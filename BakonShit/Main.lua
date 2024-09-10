-- Item ESP

local CurrentMap = workspace:FindFirstChild('CurrentMap')
if CurrentMap:FindFirstChildWhichIsA('Folder').Name == 'Chapter1' and CurrentMap:FindFirstChildWhichIsA('Folder'):FindFirstChild('KillParts') then
    CurrentMap:FindFirstChildWhichIsA('Folder'):FindFirstChild('KillParts'):Destroy()
end

for i, v in ipairs(CurrentMap:GetDescendants()) do
    if v.Name == 'Utilities' then
        local Utilities = v
        for i, v in ipairs(Utilities:GetChildren()) do
            local x = Instance.new('BillboardGui')
            x.Size = UDim2.new(5,0,3,0)
            x.AlwaysOnTop = true
            x.Parent = v:FindFirstChild('Bounds')
            local y = Instance.new('TextLabel')
            y.Size = UDim2.new(1,0,1,0)
            if workspace.CurrentMap:FindFirstChildWhichIsA('Folder').Name == 'Chapter4' and v.Name == 'Textbook' then
                y.BackgroundColor3 = v['Blue Book'].Color
            elseif v.Name == 'ID Card' then
                y.BackgroundColor3 = v['security access card'].Color
            elseif v.Name == 'Battery' then
                y.BackgroundColor3 = v['battery'].Color
            elseif v.Name == 'Power Button' then
                y.BackgroundColor3 = v['button for garage'].Color
            elseif v.Name == 'Ax' then
                y.BackgroundColor3 = v['Axe'].Color
            elseif v.Name == 'Ladder' then
                y.BackgroundColor3 = v['Ladder'].Part.Color
            else
                y.BackgroundColor3 = v[v.Name].Color
            end
            y.TextScaled = true
            y.Text = v.Name
            y.Parent = x
            local z = Instance.new('UICorner')
            z.CornerRadius = UDim.new(0,30)
            z.Parent = y
        end
    end
end

-- Bakon ESP
for i, v in ipairs(workspace:GetDescendants()) do
    if v.Name == 'BakonBot@' then
        local Highlight = Instance.new('Highlight')
        Highlight.OutlineColor = Color3.fromRGB(255,0,0)
        Highlight.FillColor = Color3.fromRGB(0,0,0)
        Highlight.FillTransparency = 0.5
        Highlight.Parent = v
    end
end
-- Doors ESP
local Currentmap = workspace:FindFirstChild('CurrentMap')
for i, v in ipairs(Currentmap:GetDescendants()) do
    if v.Name == 'LockedDoors' then
        local LockedDoors = v
        for i, v in ipairs(LockedDoors:GetChildren()) do
            local DoorHighlight = Instance.new('Highlight')
            DoorHighlight.OutlineColor = v.PadLock.Color
            DoorHighlight.FillColor = v.PadLock.Color
            DoorHighlight.FillTransparency = 0.5
            DoorHighlight.Parent = v
        end
    end
end
