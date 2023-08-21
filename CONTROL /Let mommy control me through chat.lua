local selected = game:GetService("Players").LocalPlayer.Name
local prefix = "!"


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")

controlList = {}
PlayerList = {}
-- Add everything to the lists

for index, player in ipairs(Players:GetPlayers()) do
    if player.Name == selected or player.Name == LocalPlayer.Name then
        controlList[player.Name] = true
    else
        controlList[player.Name] = false
    end
    table.insert(PlayerList, player)
end

Players.PlayerAdded:Connect(function(player)
    controlList[player.Name] = false
    table.insert(PlayerList, player)
end)
Players.PlayerRemoving:Connect(function(player)
    controlList[player.Name] = nil
    table.remove(PlayerList, table.find(PlayerList, player))
end)





-- variables
loopteleport = false
animestand = false
stare = false
BodyAngularVelocity = false

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
	if pattern == "Me" or pattern == "me" then
		return Players[selected];
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
    ["summon"] = {func = function(whoFired)
        LocalPlayer.Character.HumanoidRootPart.CFrame = whoFired.Character.HumanoidRootPart.CFrame
    end, aliases = {"bring", "come", "here"}},
    ["say"] = {func = function(whoFired, ...)
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(table.concat({...}, " "), "All")
    end, aliases = {"talk", "speak"}},
    ["jump"] = {func = function(whoFired)
        LocalPlayer.Character.Humanoid.Jump = true
    end, aliases = {"bounce"}},
    ["die"] = {func = function(whoFired)
        LocalPlayer.Character.Humanoid.Health = 0
    end, aliases = {"death", "oof"}},
    ["stare"] = {func = function(whofired, player)
        stare = true
        player = getPlayer(player)
        while task.wait() do
            if stare then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(LocalPlayer.Character.HumanoidRootPart.Position, player.Character.Head.Position)
            else
                break
            end
        end
    end, aliases = {"creep", "lookat"}},
    ["unstare"] = {func = function(whoFired)
        stare = false
    end, aliases = {"uncreep", "unlookat"}},
    ["walkspeed"] = {func = function(whoFired, number)
        LocalPlayer.Character.Humanoid.WalkSpeed = number
    end, aliases = {"ws", "speed"}},
    ["jumppower"] = {func = function(whoFired, number)
        LocalPlayer.Character.Humanoid.JumpPower = number
    end, aliases = {"jp"}},
    ["gravity"] = {func = function(whoFired, number)
        workspace.Gravity = number
    end, aliases = {"grav"}},
    ["anchor"] = {func = function(whoFired)
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
    end, aliases = {"anchored", "staystill", "stay", "still", "dontmove", "lazy"}},
    ["unanchor"] = {func = function(whoFired)
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end, aliases = {"unanchored", "unstaystill", "unstay", "unstill", "undontmove", "unlazy"}},
    --[[
    ["animestand"] = {func = function(bool, player)
        if bool == "true" then
            animestand = true
            player = getPlayer(player)
            LocalPlayer.Character.Humanoid.PlatformStand = true
            LocalPlayer.Character.HumanoidRootPart.Anchored = true
            while task.wait() do
                if animestand then
                    local targetPosition = player.Character.HumanoidRootPart.Position
                    local targetLookVector = player.Character.HumanoidRootPart.CFrame.LookVector * -1
                    local offset = targetLookVector * 3 - Vector3.new(3, 0, 0)
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + offset)
                else
                    break
                end
            end
        elseif bool == "false" then
            animestand = false
        else
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bool.." is not valid, use either \"true\" or \"false\"", "All")
        end
    end, aliases = {"stand", "anime", "gay"}},
    ["fling"] = {func = function(player)
        local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity.AngularVelocity = Vector3.new(10^6, 10^6, 10^6)
        BodyAngularVelocity.MaxTorque = Vector3.new(10^6, 10^6, 10^6)
        BodyAngularVelocity.P = 10^6
        BodyAngularVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        startTime = tick()
        while tick() - startTime < 5 do
            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new()
            task.wait()
        end
    end, aliases = {}},
    ]]--
    ["goto"] = {func = function(whoFired, player)
        player = getPlayer(player)
        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    end, aliases = {"tp", "teleport"}},
    ["loopgoto"] = {func = function(whoFired, player)
        loopteleport = true
        player = getPlayer(player)
        while task.wait() do
            if loopteleport then
                LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            else
                break
            end
        end
    end, aliases = {"loopgoto", "looptp", "lp", "lg"}},
    ["unloopgoto"] = {func = function(whoFired)
        loopteleport = false
    end, aliases = {"unloopgoto", "unlooptp", "unlp", "unlg"}},
    ["addcontrol"] = {func = function(whoFired, player)
        player = getPlayer(player)
        controlList[player.Name] = true
    end, aliases = {"addc", "ac", "controladd", "controla"}},
    ["removecontrol"] = {func = function(whoFired, player)
        player = getPlayer(player)
        controlList[player.Name] = false
    end, aliases = {"removec", "rc", "controlremove", "controlr"}},
    ["spin"] = {func = function(whoFired, speed)
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SpinVelocityShit") then
            LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SpinVelocityShit"):Destroy()
        end
        local SpinSpeed = 20
        if speed then
            SpinSpeed = speed
        end
        local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity.Name = "SpinVelocityShit"
        BodyAngularVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
        BodyAngularVelocity.MaxTorque = Vector3.new(0, math.huge, 0)
        BodyAngularVelocity.AngularVelocity = Vector3.new(0,SpinSpeed,0)        
    end, aliases = {"turn", "around", "funny"}},
    ["unspin"] = {func = function(whoFired)
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SpinVelocityShit") then
            LocalPlayer.Character.HumanoidRootPart:FindFirstChild("SpinVelocityShit"):Destroy()
        end
    end, aliases = {"unturn", "unaround", "unfunny"}}
}
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

for index, player in ipairs(PlayerList) do
    player.Chatted:Connect(function(message)
        local user = player
        if controlList[player.Name] == true and string.sub(message,1,1) == prefix then
            local prefixsplitmsg = string.split(message, prefix)
            local splitmsg = string.split(prefixsplitmsg[2], " ")
            local args = getArgs(splitmsg)
            local lowercommand = string.lower(splitmsg[1])

            for command, data in pairs(commands) do
                if lowercommand == command or (data.aliases and table.find(data.aliases, lowercommand)) then
                    data.func(user, table.unpack(args))
                    break
                end
            end
        end
    end)
end





LocalPlayer.Character.HumanoidRootPart.CFrame = Players[selected].Character.HumanoidRootPart.CFrame
ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("At your service, "..Players[selected].DisplayName, "All")
task.wait(0.5)
ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Visit my GitHub \"CGGonGitHub\" to find out how to use commands", "All")
