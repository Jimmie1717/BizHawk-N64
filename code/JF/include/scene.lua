local include = {};

include.addresses = {
	J = 0x1E2980,
	E = 0x1E5430,
	P = 0x000000,
};

include.scenes = {
	GAME_MENU = 0x0000,
	GAME_MENU2 = 0x0001,
	CERULEAN_ = 0x0002,
	SS_ANUBIS_ROBOT = 0x0083,
	GEM_QUARRY_QUARRY = 0x010B,
	PALACE_RACE = 0x010C,
	PALACE_COURTYARD = 0x011E,
	ASTEROID_FISSURE = 0x0152,
	BOSS_MIZAR_2 = 0x00E9,
};

include.scene = {
	__length = 0x019C,
	__size = 0x05,
	type = 0x00, -- u8 | 0 = gameplay, 1 = cutscene, 2 = menu
	levelId = 0x01, -- s8
	regionId = 0x02, -- u8
	unk03 = 0x03, -- u8 | bitpacked 
	unk04 = 0x04, -- u8
};
--[[
	unk03:
		(value & 0xE0) >> 5 = ?
		(value & 0x08) >> 3 = ?
		(value & 0x07) = ?
]]--

return include;