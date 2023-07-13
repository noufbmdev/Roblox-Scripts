-- Client-side script
-- Dependencies
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Events
local event = ReplicatedStorage.GameEvents:WaitForChild("pickupEvent")

local maxHealth = 100 -- Percent
local maxBattery = 100 -- Percent
local currentBattery = 100 -- Percent
local used = false -- Destroys the pickup item if it is true

-- Add all your pickups and their properties here and handle them below.
local pickupList = {
    ["Heal"] = {
        ["Amount"] = 0.5, -- Percent
    },
    ["Battery"] = {
        ["Weak"] = 0.2, -- Percent
        ["Strong"] = 0.6 -- Percent
    }
}

-- addAmount is the new amount to add to the current amount.
local function calculateAmount(currentAmount, addAmount, maxAmount)
    -- Makes sure player can't use the item if they are already filled up.
    if currentAmount < maxAmount then
        -- Calculate the new amount
        local increasedAmount = currentAmount + (currentAmount * addAmount)
        -- Return new amount without surpassing the maximum amount
        return math.min(increasedAmount, maxAmount)
    end
    return 0
end

local function use(player, pickup)
    -- Reset used status
	used = false
	
	if pickup:HasTag("Heal") then
		local humanoid = player.Character:WaitForChild("Humanoid")
        local newAmount = calculateAmount(humanoid.maxHealth, pickupList.Heal.Amount, maxHealth)
		if humanoid and newAmount then
            humanoid.maxHealth = newAmount
            print("Player Health Updated! " .. currentHealth)
			used = true
        end
    end
	
    -- If your pickup has different attributes or in this case "strengths", it could be done as shown below
    if pickup:HasTag("Battery") then
        local newAmount = calculateAmount(currentBattery, pickupList.Battery[pickup:GetAttribute("Strength")], maxBattery)
        if newAmount then
            currentBattery = newAmount
            print("Player Battery Updated! " .. currentBattery .. "%")
            used = true
        end
	end

    if used then
        pickup:Destroy()
    end
end

-- Connections
event.OnClientEvent:Connect(use)
