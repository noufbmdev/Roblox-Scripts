-- ROOM GENERATION --
local room = require(script.Room) -- Put the correct path for the room script.
local prevRoom = workspace.SpawnRoom -- Initialize this with the first room that you plan to put the players in.
local levels = workspace.Rooms:GetChildren() -- Levels are stored as folders in the workspace.
local roomsPerLevel = 10 -- Adjust this to how many rooms you want to have for each level.

for level=1, #levels do
	for i=1, roomsPerLevel do
		prevRoom = room.Generate(prevRoom, levels[level].Name)
	end
end