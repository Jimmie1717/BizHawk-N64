local include = {};

include.addresses = {
	J = nil,
	E = {
		level = 0x293E6C,
		character = 0x293E74,
		position = {
			x = 0x298D00,
			y = 0x298D04,
		}
	},
	P = nil,
};

include.character = {
	VELA = 0,
	JUNO = 1,
	LUPUS = 2,
};

include.levels = {
	GOLDWOOD = 0,
	GEM_QUARRY = 1,
	TAWFRET = 2,
	RITH_ESSA = 3,
	CERULEAN = 4,
	ESCHEBONE = 5,
	WALKWAY = 6,
	WATER_RUIN = 7,
	SPACESTATION = 8,
	SS_ANUBIS = 9,
	MIZARS_PALACE = 10,
	ASTEROID = 11,
	ICHOR = 12,
	SEKHMET = 13,
	SPAWNSHIP = 14,
	EARTH = 11,
	MAX = 16,
};

include.levelNames = {
	[0] = "Goldwood",
	[1] = "Gem Quarry",
	[2] = "Tawfret",
	[3] = "Rith Essa",
	[4] = "Cerulean",
	[5] = "Eschebone",
	[6] = "Walkway",
	[7] = "Water Ruin",
	[8] = "Spacestation",
	[9] = "SS Anubis",
	[10] = "Mizar's Palace",
	[11] = "Asteroid",
	[12] = "Ichor",
	[13] = "Sekhmet",
	[14] = "Spawnship",
};

include.levelPositions = {
	GOLDWOOD = { x = 160.0, y = 120.0 },
	GEM_QUARRY = { x = 300.0, y = 45.0 },
	TAWFRET = { x = 160.0, y = 320.0 },
	RITH_ESSA = { x = 95.0, y = 620.0 },
	CERULEAN = { x = 360.0, y = 520.0 },
	ESCHEBONE = { x = 95.0, y = 520.0 },
	WALKWAY = { x = 335.0, y = 170.0 },
	WATER_RUIN = { x = 360.0, y = 720.0 },
	SPACESTATION = { x = 45.0, y = 60.0 },
	SS_ANUBIS = { x = 160.0, y = 220.0 },
	MIZARS_PALACE = { x = 160.0, y = 420.0 },
	ASTEROID = { x = 5.0, y = 360.0 },
	ICHOR = { x = 360.0, y = 420.0 },
	SEKHMET = { x = 360.0, y = 620.0 },
	SPAWNSHIP = { x = -120.0, y = 620.0 },
	EARTH = { x = -120.0, y = 360.0 },
};

return include;