-- Dependencies
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local flashlight = script.Parent
local light = flashlight.Model.Body.LightRing.SurfaceLight -- Path to a light source [https://create.roblox.com/docs/effects/light-sources]

-- Events --
local pickupEvent = ReplicatedStorage.GameEvents:WaitForChild("BatteryPickup")

-- Tool properties --
local level = 1
light.Range = 6
light.Brightness = 3
local batteryMaxAmount = 100 -- Percent
local currentBatteryAmount = batteryMaxAmount -- Percent
-- The time it takes to decrease the battery by 'batteryDecreaseAmount'.
local batteryDecreaseTime = 5 -- Seconds
-- The amount to be decreased by every 'batteryDecreaseTime'.
local batteryDecreaseAmount = 1 -- Percent

-- Batteries' Amounts in percentage
local batteries = {
	["Weak"] = 10,
	["Medium"] = 100,
	["Strong"] = 1000
}

function update()
	-- Play light switch sound
	if not light.Enabled then
		SoundService:PlayLocalSound(SoundService.LightSwitchOn)
	else
		SoundService:PlayLocalSound(SoundService.LightSwitchOff)
	end

	-- Update battery amount
	while light.Enabled do
		if currentBatteryAmount <= 0 then
			light.Enabled = false
			return
		end
		task.wait(batteryDecreaseTime)
		currentBatteryAmount -= batteryDecreaseAmount
		
		print('Current flashlight battery is ' .. tostring(currentBatteryAmount) .. '%')
	end
end

function toggleLight()
	light.Enabled = not light.Enabled
	update()
end

function unequip()
    -- Turn the flashlight off when it is unequiped
	light.Enabled = false
	update()
end

function increaseBattery(battery)
	if currentBatteryAmount < batteryMaxAmount then
		-- Calculate the new amount
		local temp = currentBatteryAmount + (currentBatteryAmount * batteries[battery:GetAttribute("Strength")])
		-- Shave off extra
		local newAmount = temp - (temp - batteryMaxAmount)
		-- Update amount
		currentBatteryAmount = newAmount
		print("Battery Filled! " .. currentBatteryAmount)
		battery:Destroy()
	else
		print("You want to use the batteries? Let me get it approved first.")
	end
end

function upgrade(property, level)
	if property == "Battery" then
		batteryMaxAmount += 25 * level
	elseif property == "Range" then
		light.Range += 4 * level
	elseif property == "Brightness" then
		light.Brightness += 4 * level
	end
end

-- Connections
flashlight.Activated:Connect(toggleLight)
flashlight.Unequipped:Connect(unequip)
pickupEvent.OnClientEvent:Connect(increaseBattery)
