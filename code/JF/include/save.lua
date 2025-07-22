local include = {};

include.addresses = {
	J = 0x1E3580,
	E = 0x1E6010,
	P = 0x2088E0,
};

include.character = {
	VELA = 0,
	JUNO = 1,
	LUPUS = 2,
	RACER = 3,
	MAX = 4,
};

include.characterNames = {
	[0] = "Vela",
	[1] = "Juno",
	[2] = "Lupus",
	[3] = "Racer",
	[4] = "Vela (Jet Pack)",
	[5] = "Juno (Jet Pack)",
	[6] = "Lupus (Jet Pack)",
};

include.velaCharacterModels = {
	DEFAULT = 0,
	SOLDIER_DRONE = 1,
	TRIBAL = 2,
	COWARD_DRONE = 3, 
	MAX = 4,
};

include.velaCharacterModelNames = {
	[0] = "Vela",
	[1] = "Soldier Drone",
	[2] = "Female Tribal",
	[3] = "Coward Drone",
};

include.junoCharacterModels = {
	DEFAULT = 0,
	SNIPER_DRONE = 1,
	TRIBAL = 2,
	TERMITE_DRONE = 3,
	ARMOR_DRONE = 4,
	STAG_DRONE = 5,
	WEEVIL = 6,
	CYBORG_DRONE = 7,
	STAG_ZOMBIE_DRONE = 8,
	MAX = 9,
};

include.junoCharacterModelNames = {
	[0] = "Juno",
	[1] = "Sniper Drone",
	[2] = "Male Tribal",
	[3] = "Termite Drone",
	[4] = "Armor Drone",
	[5] = "Stag Drone",
	[6] = "Weevil",
	[7] = "Cyborg Drone",
	[8] = "Stag Zombie Drone",
};

include.lupusCharacterModels = {
	DEFAULT = 0,
	MAX = 1,
};

include.lupusCharacterModelNames = {
	[0] = "Lupus",
};

include.robotMedals = {
	NONE = 0,
	MERIT = 1,
	BRONZE = 2,
	SILVER = 3,
	GOLD = 4,
	EXPERT = 5,
	MAX = 6,
};

include.robotMedalNames = {
	[0] = "None",
	[1] = "Merit",
	[2] = "Bronze",
	[3] = "Silver",
	[4] = "Gold",
	[5] = "Expert",
};

include.levels = {
	RITH_ESSA = 0,
	ASTEROID = 1,
	MIZARS_PALACE = 2,
	ICHOR = 3,
	ESCHEBONE = 4,
	TAWFRET = 5,
	SEKHMET = 6,
	CERULEAN = 7,
	SS_ANUBIS = 8,
	SPAWNSHIP = 9,
	GOLDWOOD = 10,
	GEM_QUARRY = 11,
	SPACESTATION = 12,
	WATER_RUIN = 13,
	WALKWAY = 14,
	MAX = 15,
};

include.levelNames = {
	[0] = "Rith Essa",
	[1] = "Asteroid",
	[2] = "Mizar's Palace",
	[3] = "Ichor",
	[4] = "Eschebone",
	[5] = "Tawfret",
	[6] = "Sekhmet",
	[7] = "Cerulean",
	[8] = "SS Anubis",
	[9] = "Spawnship",
	[10] = "Goldwood",
	[11] = "Gem Quarry",
	[12] = "Spacestation",
	[13] = "Water Ruin",
	[14] = "Walkway",
};

include.keys = {
	UNUSED_0 = 0,
	UNUSED_1 = 1,
	UNUSED_2 = 2,
	UNUSED_3 = 3,
	UNUSED_4 = 4,
	TRI_ROCKET_LAUNCHER = 5,
	BLUE = 6,
	UNUSED_7 = 7,
	UNUSED_8 = 8,
	UNUSED_9 = 9,
	UNUSED_10 = 10,
	UNUSED_11 = 11,
	GREEN = 12,
	MAGENTA = 13,
	RED = 14,
	YELLOW = 15,
	MAX = 16,
};

include.keyNames = {
	[0] = "",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "Tri-Rocket Launcher Key",
	[6] = "Blue Key",
	[7] = "",
	[8] = "",
	[9] = "",
	[10] = "",
	[11] = "",
	[12] = "Green Key",
	[13] = "Magenta Key",
	[14] = "Red Key",
	[15] = "Yellow Key",
};

include.objects = {
	UNUSED_0 = 0,
	UNUSED_1 = 1,
	UNUSED_2 = 2,
	UNUSED_3 = 3,
	ARCADE_CHIP = 4,
	EAR_PLUGS = 5,
	GOLD_BAR0 = 6,
	GOLD_BAR1 = 7,
	GOLD_BAR2 = 8,
	NIGHT_VISION_GOGGLES = 9,
	CROWBAR = 10,
	PANTS = 11,
	UNUSED_12 = 12,
	UNUSED_13 = 13,
	MINE_KEY = 14,
	SPECIALIST_MAG = 15,
	MAX = 16,
};

include.objectNames = {
	[0] = "",
	[1] = "",
	[2] = "",
	[3] = "",
	[4] = "Arcade Chip",
	[5] = "Ear Plugs",
	[6] = "Gold Bar",
	[7] = "Gold Bar",
	[8] = "Gold Bar",
	[9] = "Night Vision Goggles",
	[10] = "Crowbar",
	[11] = "Pants",
	[12] = "",
	[13] = "",
	[14] = "Mine Key",
	[15] = "Specialist Magazine",
};

include.weaponChange = {
	DISABLE = 1,
	ENABLE = 2,
};

include.headCounts = {
	tribals = 0x00, -- u16
	drones = 0x02, -- u16
};

--[[
	800A11C0 (USA)
	Action table (not all are used?)
		__size = 0x20
		0x0000 s16 unknown_0
		0x0002 s16 unknown_1
		0x0004 s16 unknown_2
		0x0006 string
]]--
include.actions = {
	unknown_0 = 0x00, -- s16 | timer?
	unknown_1 = 0x02, -- s16 | timer?
	unknown_2 = 0x04, -- s16 | timer?
	name = 0x06, -- string
};

include.characterData = {
	__size = 0x76,
	health = 0x00, -- s16 | this is a copy, actual health is stored in the player actor. upper byte is amount of links.
	geminiHolders = 0x02, -- u16
	charInfo = 0x04, -- u16 | bitpacked, has level and character model. 0xFFE0 >> 5 = scene, 0x1F >> 0 = model.
	headCounts = 0x06, -- u16[2]
	weapons = 0x0A, -- u16 | bitarray
	actions = 0x0C, -- s16[3]
	mizarTokens = 0x12, -- u16
	weaponAmmo = 0x14, -- u16[16]
	weaponCapacity = 0x34, -- u16[16]
	weaponGuage = 0x54, -- u8[16]
	levels = 0x64, -- u16 | bitarray
	keys = 0x66, -- u16 | bitarray
	objects = 0x68, -- u16 | bitarray
	weaponChange = 0x6F, -- u8 | 1 = can't change, 2 = can change
	weaponCurrent = 0x70, -- u8 | The current equipped weapon
	levelId = 0x71, -- s8 | from Scene.sceneData.levelId
	unused_0x72 = 0x72,
	spawnInfo = 0x74 -- u16 | bitpacked, has scene and entrance index. 0xFFE0 >> 5 = scene, 0x1F >> 0 = entrance. This is used to know where to place the player when loading a file or changing character in the pause menu then unpausing.
};

include.tribals = {
	__size = 0x03,
	rescued = 0x00, -- u8
	killed = 0x01, -- u8
	remaining = 0x02, -- u8
};

include.quickWeapons = {
	__size = 0x04,
	up = 0x00, -- u8
	right = 0x01, -- u8
	down = 0x02, -- u8
	left = 0x03, -- u8
};

include.save = {
	__size = 0x0538,
	character = 0x0000, -- u8
	sceneId = 0x0001, -- s8 | loaded as s16 then stored as s8.
	levelId = 0x0002, -- s8 | from Scene.sceneData.levelId
	tribals = 0x0004, -- include.tribals
	flags = 0x0008, -- Flags.flags
	unk_BC = 0x00BC, 
	characterData = 0x015C, -- characterData[4]
	region = 0x0334, -- Region.region
	frames = 0x0518, -- u32
	fileName = 0x051C, -- char[16]
	unk052C = 0x052C, -- 8 bytes
	unk530 = 0x0530, -- u16 or s16
	quickWeapons = 0x0534, -- quickWeapons
};

return include;