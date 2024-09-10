local TOOL_NAME = 'TOOL NAME HERE'



local Currentmap = workspace:FindFirstChild('CurrentMap')
for i, v in ipairs(Currentmap:GetDescendants()) do
    if v.Name == 'Utilities' then
        tool = v:FindFirstChild(TOOL_NAME).Bounds.PickUp
    end
end

fireclickdetector(tool)
