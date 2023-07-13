# Roblox-Scripts

Ready to use roblox scripts, feel free to use them! 🙌 No need for credit but would appreciate it if you do 💗

Currently available:

- Room Generation
  - It randomly selects rooms for each level and connects these rooms together in the space.
  - You can adjust how many rooms you want to have for each level and the rarity of the room, there is no cap on the number of levels you can have.
  - It ensures that when selecting rooms it wont loop over itself and create a circle, no two same rooms in a row, can't select spawn room, and no two rooms with stairs in a row.
  - Requirement: Each room must have two Parts one called Entrance and the other called Exit, the code needs this to connect the rooms together.
- Tools
  - Flashlight: toggle light, manage battery levels, upgrade stats (battery, range, brightness).
- Pickups
  - Heal: Update player's max health amount on item pick up.
  - It generates proximity prompts for all pickups in the game granted they are tagged with "Pickup".
  - It tells the client to handle the pickup by updating the specified property (E.g. heal item increases player's health by 20).
  - You can defined more attributes for the pickup and handle them (E.g. weak heal gives 10 while strong heal gives 50).

I'm thinking of making a plugin for roblox engine to easily access these scripts from the engine but idk if I will have the time. So I will just upload them here from time to time and hope that I will have the opportunity to do the plugin.
