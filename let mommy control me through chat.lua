local selected = "mew_Sp"
local prefix = "!"


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local controlList = {Players[selected]}

allcontrol = false

-- variables
loopteleport = false


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

function getPlayer(pattern: string)
	if string.match(pattern, "Me") or string.match(pattern, "me") then
		return selected;
	elseif string.match(pattern, "All") or string.match(pattern, "all") then
		return Players:GetPlayers();
	else
		for index, player in ipairs(Players:GetPlayers()) do
			if player.Name:match(pattern) or player.DisplayName:match(pattern) then
				return player;
			end
		end

		return nil;
	end
end

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

local commands = {
    ["summon"] = {func = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = Players[selected].Character.HumanoidRootPart.CFrame
    end, aliases = {"bring", "come", "here"}},
    ["say"] = {func = function(...)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(table.concat({...}, " "), "All")
    end, aliases = {"talk", "speak"}},
    ["jump"] = {func = function()
        LocalPlayer.Character.Humanoid.Jump = true
    end, aliases = {"bounce"}},
    ["die"] = {func = function()
        LocalPlayer.Character.Head:Destroy()
    end, aliases = {"death", "oof"}},
    ["goto"] = {func = function(player)
        print(player)
        player = getPlayer(player)
        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    end, aliases = {"tp", "teleport"}},
    ["loopgoto"] = {func = function(bool, player)
        if bool == "true" then
            loopteleport = true
            player = getPlayer(player)
            while task.wait() do
                if loopteleport then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end
        elseif bool == "false" then
            loopteleport = false
        else 
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bool.." is not valid, use either \"true\" or \"false\"", "All")
        end
    end, aliases = {"loopgoto", "looptp", "lp", "lg"}},
    ["addcontrol"] = {func = function(player)
        player = getPlayer(player)
        table.insert(controlList, player)
    end, aliases = {"addc", "ac", "controladd", "controla"}},
    ["removecontrol"] = {func = function(player)
        player = getPlayer(player)
        table.remove(controlList, table.find(controlList, player))
    end, aliases = {"removec", "rc", "controlremove", "controlr"}}
    --[[
    ["allcontrol"] = func = {function(bool)
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
        end, aliases = {"acontrol"}},
    ]]--
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

            for command, data in pairs(commands) do
                if lowercommand == command or (data.aliases and table.find(data.aliases, lowercommand)) then
                    data.func(table.unpack(args))
                    break
                end
            end
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    if allcontrol then
        table.insert(controlList, player)
    end
end)


LocalPlayer.Character.HumanoidRootPart.CFrame = Players[selected].Character.HumanoidRootPart.CFrame
ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("At your service, "..Players[selected].DisplayName, "All")
