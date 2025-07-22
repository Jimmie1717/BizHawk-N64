local include = {};

include.weapons = {
	PISTOL = 0,
	HOMING_MISSILE_LAUNCHER = 1,
	MACHINE_GUN = 2,
	PLASMA_SHOTGUN = 3,
	SHOCKER = 4,
	TRI_ROCKET_LAUNCHER = 5,
	FLAMETHROWER = 6,
	SNIPER_RIFLE = 7,
	GRENADES = 8,
	SHURIKENS = 9,
	FISH_FOOD = 10,
	TIMED_MINES = 11,
	REMOTE_MINES = 12,
	FLARES = 13,
	CLUSTER_BOMBS = 14,
	SPLITTER = 15,
	MAX = 16,
};

include.names = {
	[0] = "Pistol",
	[1] = "Homing Missile Launcher",
	[2] = "Machine Gun",
	[3] = "Plasma Shotgun",
	[4] = "Shocker",
	[5] = "Tri-Rocket Launcher",
	[6] = "Flamethrower",
	[7] = "Sniper Rifle",
	[8] = "Grenades",
	[9] = "Shurikens",
	[10] = "Fishfood",
	[11] = "Timed Mines",
	[12] = "Remote Mines",
	[13] = "Flares",
	[14] = "Cluster Bombs",
	[15] = "Spilter",
};

include.weaponData = {
	__size = 0x30,
	__addr = {
		J = 0x0A1350,
		E = 0x0A1490,
	},
	info = 0x00, -- u8 | bitpacked | & 0x10 >> 3 = raise weapon
	bulletSplit = 0x01, -- u8
	upperBodyRecoil = 0x02, -- s8 | positive = lean back, negative = lean forward.
	damage = 0x03, -- u8
	unk_04 = 0x04,
	fireRate = 0x05, -- s8 | 0 = no delay, 127 = max delay? (frames)
	delay = 0x06, -- s8 | frames to delay the shot by from button press.
	timer = 0x07, -- u8 | how many frames the bullet lasts until destroyed?
	spreadHorizontal = 0x08, -- u16
	spreadVertical = 0x0A, -- u16
	unk_0C = 0x0C, -- f32 | affects auto aim?
	bulletRange = 0x10, -- f32 | radius of sphere around character the buttle can travel. aimer turns red if target is in range.
	unk_14 = 0x14, -- f32 | affects auto aim?
	unk_18 = 0x18, -- f32 | affects auto aim?
	unk_1C = 0x1C, -- f32 | affects auto aim?
	unk_20 = 0x20, -- f32 | affects auto aim?
	capacityInit = 0x24, -- u16
	capacityCrate = 0x26, -- u16
	ammoInit = 0x28, -- u16
	ammoCrate = 0x2A, -- u16
	capacityInit1 = 0x2C, -- u16
	capacityMax = 0x2E, -- u16
};

return include;