-- Server-side script
-- Dependencies
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Add proximity prompts for pick up items
for _, pickup in CollectionService:GetTagged("Pickup") do
	-- Create a proximity prompt
	local instance = Instance.new("ProximityPrompt")
	
	-- Setup its properties
	instance.ObjectText = "Item"
	if pickup:HasTag("Heal") then
		instance.ObjectText = "Balm"
	elseif pickup:HasTag("Battery") then
		instance.ObjectText = "Battery"
	end
	instance.ActionText = "Use"
	instance.MaxActivationDistance = 10
	instance.HoldDuration = 1
	instance.KeyboardKeyCode = Enum.KeyCode.E
	instance.GamepadKeyCode = Enum.KeyCode.X
	instance.ClickablePrompt = true
	
	-- Connect it to fire an event to the client
	instance.Triggered:Connect(
		function(player)
			local event = ReplicatedStorage.GameEvents:WaitForChild("pickupEvent")
			event:FireClient(player, pickup)
		end
	)
	
	-- Attach it to the model
	instance.Parent = pickup
end