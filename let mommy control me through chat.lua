local selected = "Cool_Adri89"
local prefix = "!"


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local controlList = {Players[selected]}

allcontrol = false

function getArgs(splitmsg)
	local inString = false
	local newIndex = 1
	local args = {}
	for _, element in splitmsg do

		local numChars = string.len(element)

		if element:sub(1,1) == '"' then
			inString = true
		end
		if element:sub(numChars, numChars) == '"' then
			inString = false
		end
		element = string.gsub(element, '"', "")
		if args[newIndex] then
			args[newIndex] = args[newIndex].." "..element
		else
			args[newIndex] = element
		end
		if not inString then
			newIndex += 1
		end
	end
	table.remove(args, 1)
	return args
end

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

local commands = {
    ["summon"] = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = Players[selected].Character.HumanoidRootPart.CFrame
    end,
    ["say"] = function(...)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(table.concat({...}, " "), "All")
    end,
    ["jump"] = function()
        LocalPlayer.Character.Humanoid.Jump = true
    end,
    ["die"] = function()
        LocalPlayer.Character.Head:Destroy()
    end,
    ["allcontrol"] = function(bool)
        if bool == "true" then
            allcontrol = true
            for i, v in ipairs(Players:GetPlayers()) do
                if v.Name ~= selected then
                    table.insert(controlList, v)
                end
            end
        elseif bool == "false" then
            for i, v in ipairs(controlList) do
                if v.Name ~= selected then
                    table.remove(controlList, i)
                end
            end
        else 
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bool.." is not valid, use either \"true\" or \"false\"", "All")
        end
    end,
    ["playmusic"] = function(id)
        local id = "https://www.roblox.com/asset/?id="..tonumber(id)
        ReplicatedStorage.Remotes.Inventory.PlaySong:FireServer(id)
    end,
}
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

for i, v in ipairs(controlList) do
    v.Chatted:Connect(function(message)
        if string.sub(message,1,1) == prefix then
            local prefixsplitmsg = string.split(message, prefix)
            local splitmsg = string.split(prefixsplitmsg[2], " ")
            local args = getArgs(splitmsg)
            local lowercommand = string.lower(splitmsg[1])
            if commands[lowercommand] then
                commands[lowercommand](table.unpack(args))
            end
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    if allcontrol then
        table.insert(controlList, player)
    end
end)
