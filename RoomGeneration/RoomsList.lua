-- This is just an example room list, the purpose is to show you the structure of the information to be stored about each room.
local roomsList = {
	["Level1"] = {
		['SpawnRoom'] = {
			['Rarity'] = 1, -- Default ratity is 1, the higher the number the more it will appear, the lower the less it will appear.
            ['Direction'] = 'Left', -- If it has a turn, add this line and define the direction of the turn (Left or Right).
            ['Stairs'] = true, -- If it has stairs, add this line and set it to true.
		},
	},
}

return roomsList