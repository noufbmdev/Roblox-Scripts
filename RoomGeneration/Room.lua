local room = {}

room.SPAWNROOM = workspace.SpawnRoom
room.list = require(script.RoomsList) -- Put the correct path for a module script that stores information about each room.
room.lastDirection = nil
room.randomNumber = Random.new()

function room.GetRandom(prevRoom, theme)
	-- Get the rooms from the workspace.
	local rooms = workspace.Rooms[theme]
	
	-- Select a room based on its Rarity.
	local totalRarity = 0
	for i, data in pairs(room.list[theme]) do
		totalRarity += data.Rarity
	end
	
	local randomRarity = room.randomNumber:NextInteger(0, totalRarity)
	local currentRarity = 0
	local selectedRoom = nil
	for roomName, data in pairs(room.list[theme]) do
		currentRarity += data.Rarity
		if randomRarity <= currentRarity and roomName ~= room.SPAWNROOM.Name then
			selectedRoom = rooms[roomName]
			break
		end
	end

	-- Gather and store information about the currently selected room and the previous one.
	local direction = room.list[theme][selectedRoom.Name]['Direction']
	local hasStairs = room.list[theme][selectedRoom.Name]['Stairs']
	local prevRoomHadStairs = room.list[theme][prevRoom.Name]['Stairs']

	-- Make sure the selected room matches requirements:
		-- The selected room is not the same as the previous room.
		-- The selected room's direction is not the same as the last turn direction.
		-- No two rooms with stairs in a row.
	if
		(prevRoom.Name == selectedRoom.Name) or
		(direction and direction == room.lastDirection) or
		(hasStairs and prevRoomHadStairs)
	then
		return room.GetRandom(prevRoom, theme)
	else
		-- Update direction only if the selected room has a corner.
		if direction then
			room.lastDirection = direction
		end
		return selectedRoom
	end
end

function room.Generate(prevRoom, theme)
	-- Clone the selected room.
	local newRoom = room.GetRandom(prevRoom, theme):Clone()

	-- Setup the room before adding it to the workspace.
	newRoom.PrimaryPart = newRoom.Entrance
	newRoom:PivotTo(prevRoom.Exit.CFrame)
	newRoom.Entrance.Transparency = 1
	newRoom.Exit.Transparency = 1

	-- Add the new room to the workspace.
	newRoom.Parent = workspace.Rooms
	
	return newRoom
end

return room
