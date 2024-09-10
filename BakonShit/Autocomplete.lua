-- Always Variables
Utilities = nil
Scavengers = nil
CurrentMap = nil
Player = game:GetService('Players').LocalPlayer

-- Chapters
-- Chapter 1 Process
Autocomplete = {
    ['Chapter1'] = function ()
        fireclickdetector(Utilities:FindFirstChild('USB').Bounds.PickUp) -- get USB
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.Computer.Screen.Redeem) -- use USB
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Wrench').Bounds.PickUp) -- get Wrench
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapeSwitch.Switch.Redeem) -- use Wrench at the final door
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Crowbar').Bounds.PickUp) -- get the Crowbar
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapePlanks.PlankTrigger.Redeem) -- use Crowbar
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Blue Book').Bounds.PickUp) -- get the Blue Book
        task.wait(0.5)
        fireclickdetector(Scavengers.Bookcase.BlueBook.Redeem) -- use blue Book @ Bookcase
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Red Book').Bounds.PickUp) -- get the Red Book
        task.wait(0.5)
        fireclickdetector(Scavengers.Bookcase.RedBook.Redeem) -- use red Book @ Bookcase
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Green Book').Bounds.PickUp) -- get the Green Book
        task.wait(0.5)
        fireclickdetector(Scavengers.Bookcase.GreenBook.Redeem) -- use green Book @ Bookcase
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('White Key').Bounds.PickUp) -- get White Key
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapeDoor.PadLock.ClickToUnlock) -- use White Key
    end,

    ['Chapter2'] = function ()
        fireclickdetector(Utilities:FindFirstChild('Crowbar').Bounds.PickUp) -- get the Crowbar
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapePlanks.PlankTrigger.Redeem) -- use Crowbar
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Wrench').Bounds.PickUp) -- get Wrench
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapeSwitch.Switch.Redeem) -- use Wrench at the final door
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Golden Gear').Bounds.PickUp) -- get Golden Gear
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapeGear.Gear.Redeem) -- use Golden Gear
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Green Wire').Bounds.PickUp) -- get Golden Gear
        task.wait(0.5)
        fireclickdetector(Scavengers.ElevatorWires.WireClick.Redeem) -- use Golden Gear
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('Red Wire').Bounds.PickUp) -- get Golden Gear
        task.wait(0.5)
        fireclickdetector(Scavengers.ElevatorWires.WireClick.Redeem) -- use Golden Gear
        task.wait(0.5)
        fireclickdetector(Utilities:FindFirstChild('White Key').Bounds.PickUp) -- get White Key
        task.wait(0.5)
        fireclickdetector(Scavengers.FinalEscape.EscapeDoor.PadLock.ClickToUnlock) -- use White Key
    end
}

-- Autocomplete
CurrentMap = workspace:FindFirstChild('CurrentMap'):FindFirstChildWhichIsA('Folder')
for i, v in ipairs(CurrentMap:GetDescendants()) do
    if v.Name == 'Utilities' then
        Utilities = v
    elseif v.Name == 'Scavengers' then
        Scavengers = v
    end
end
Autocomplete[CurrentMap.Name]()
