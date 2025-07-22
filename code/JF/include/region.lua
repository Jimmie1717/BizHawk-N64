local include = {};

include.regions = {
	NONE = 0,
	OUTSET = 1,
	LODGE = 2,
	PASSAGEWAY = 3,
	INTERIOR = 4,
	RIM = 5,
	BLUFF = 6,
	HOLD = 7,
	BATTLE_CRUISER = 8,
	PEAK = 9,
	DEPOSITORY = 10,
	TROOP_CARRIER = 11,
	INTERIOR2 = 12,
	DUNE = 13,
	BOG = 14,
	BRIDGE = 15,
	CASTLE = 16,
	ASCENT = 17,
	MILITARY_BASE = 18,
	LOST_ISLAND = 19,
	MINE = 20,
	PERIMETER = 21,
	APPROACH = 22,
	THORAX = 23,
	CORTEX = 24,
	LANDING = 25,
	ABANDONED_WRECK = 26,
	LOBBY = 27,
	FLUME = 28,
	CHASM = 29,
	MIZARS_LAIR = 30,
	MAX = 31,
};

include.names = {
	[0] = "",
	"Outset",
	"Lodge",
	"Passageway",
	"Interior", -- Goldwood
	"Rim",
	"Bluff",
	"Hold",
	"Battle Cruiser",
	"Peak",
	"Depository",
	"Troop Carrier",
	"Interior", -- Rith Essa
	"Dune",
	"Bog",
	"Bridge",
	"Castle",
	"Ascent",
	"Military Base",
	"Lost Island",
	"Mine",
	"Perimeter",
	"Approach",
	"Thorax",
	"Cortex",
	"Landing",
	"Abandoned Wreck",
	"Lobby",
	"Flume",
	"Chasm",
	"Mizar's Lair",
};

include.tribals = {
	[0] = 0,
	7,
	15,
	8,
	9,
	11,
	8,
	10,
	15,
	6,
	14,
	15,
	4,
	8,
	10,
	12,
	6,
	6,
	16,
	8,
	16,
	8,
	6,
	12,
	5,
	5,
	12,
	14,
	6,
	10,
	0,
	-- total 282
};

include.best = {
	__size = 0x0008,
	tribalsRescued = 0x00, -- u8
	tribalsKilled = 0x01, -- u8
	totalKills = 0x02, -- u16
	frames = 0x04, -- u32
};

include.region = {
	__size = 0x01E4,
	bests = 0x0000, -- best[40], include.best
	shots = 0x0140, -- u32[16]
	hits = 0x0180, -- u32[16]
	kills = 0x01C0, -- u16[16]
	frames = 0x01E0, -- u32
};

return include;