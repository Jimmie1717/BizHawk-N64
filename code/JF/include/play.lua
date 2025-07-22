local include = {};

include.addresses = {
	J = 0x0A3090,
	E = 0x0A31D0,
	P = 0x0A3440,
};

include.screenOverride = {
	__size = 0x14,
	x1 = 0x00, -- s16
	y1 = 0x04, -- s16
	x2 = 0x08, -- s16
	y2 = 0x0C, -- s16
	timer = 0x10, -- s16
}

include.cheats = {
	levels = 0x00, -- u8
	unknown_1 = 0x04, -- u8
	health = 0x08, -- u8
	ammo = 0x0C, -- u8
	weapons = 0x10, -- u8
	floyd = 0x14, -- u8
	blood = 0x18, -- u8
	kids = 0x1C, -- u8
	pants = 0x20, -- u8
};

include.transition = {
	__size = 0x08,
	flags = 0x00, -- u8 | bitfield
	color = 0x01, -- u8[3] | rgb
	timer = 0x04, -- u16 | time to fade the transition
	timer2 = 0x06, -- u16 | time to remove transition? 8+ = not enough time to remove the tranisition before it's already completed?
};
--[[
	flags:
		(value & 0x80) ? true = fade in : false = fade out;
		(value & 0x40) ? true = ? : false = ?; // this is not used in any of the game transitions.
		(value & 0x3F) = type // although this allows for 0-63 indexes the game caps it at 0-6.
			0 = full screen fade
			1 = swipe from left/right
			2 = swipe from top/bottom
			3 = swipe from top-left/bottom-right
			4 = swipe from top-left/bottom-right
			5 = swipe from top-left/bottom-right
			6 = instant cover
]]--

include.characterInitScene = {
	VELA = 0x0042, -- sekhmet landing
	JUNO = 0x016D, -- goldwood landing
	LUPUS = 0x003D, -- spawnship elevator
	RACER = 0x0042, -- sekhmet landing
};

-- J only.
include.landingSkipTable = {
	[0] = { -- rith essa
		current = { scene = 0x0141, setup = 0 },
		dest = 0x0051
	},
	[1] = { -- asteroid
		current = { scene = 0x014F, setup = 0 },
		dest = 0x014C },
	[2] = { -- mizar's palace (juno/vela)
		current = { scene = 0x0133, setup = 0 },
		dest = 0x009B
	},
	[3] = { -- mizar's palace (lupus)
		current = { scene = 0x016F, setup = 0 },
		dest = 0x0137
	},
	[4] = { -- ichor
		current = { scene = 0x016A, setup = 0 },
		dest = 0x002B
	},
	[5] = { -- eschebone
		current = { scene = 0x014A, setup = 0 },
		dest = 0x00D8
	},
	[6] = { -- tawfret
		current = { scene = 0x0087, setup = 0 },
		dest = 0x009E
	},
	[7] = { -- sekhmet
		current = { scene = 0x0042, setup = 0 },
		dest = 0x0043
	},
	[8] = { -- cerulean
		current = { scene = 0x0170, setup = 0 },
		dest = 0x0035
	},
	[9] = { -- ss anubis
		current = { scene = 0x0065, setup = 0 },
		dest = 0x0023
	},
	[10] = { -- spawnship
		current = { scene = 0x0064, setup = 0 },
		dest = 0x0048
	},
	[11] = { -- goldwood
		current = { scene = 0x005D, setup = 0 },
		dest = 0x005C
	},
	[12] = { -- gem quarry
		current = { scene = 0x019B, setup = 0 },
		dest = 0x0110
	},
	[13] = { -- ufo
		current = { scene = 0x0113, setup = 0 },
		dest = 0x0114
	},
	[14] = { -- water ruin
		current = { scene = 0x0156, setup = 0 },
		dest = 0x00E5
	},
	[15] = { -- walkway
		current = { scene = 0x000F, setup = 0 },
		dest = 0x0016
	},
};

include.actorState = {
	[1] = "loading",
	[2] = "unloading",
	[3] = "loaded",
	[4] = "?",
};

include.playState = {
	buildVersion = 0x0000, -- char*
	buildDate = 0x0004, -- char*
	buildAuthor = 0x0008, -- char*
	buildString = 0x000C, -- char[64]
	robotMissionFrames = 0x0034, -- u32
	robotMissionFlag = 0x0038, -- u8 | boolean
	screenOverrideFlag = 0x004C, -- u8 | 0 = don't use screenOverride, 1 = use screenOverride. hudFlag (0x0068) is used to set this every frame.
	screenOverride = 0x0050, -- s16
	hudFlag = 0x0068, -- u16 | 1 = display hud, 0 = hide hud
	currentScene = 0x006C, -- u16
	currentCharacter = 0x0070, -- u16
	currentEntrance = 0x0074, -- u16
	currentSetup = 0x0078, -- u16
	currentMode = 0x007C, -- u16
	scene = 0x80, -- u16 | gets set from the warp function.
	setup = 0x84, -- u16
	entrance = 0x88, -- u16 | gets set from the warp function.
	character = 0x90, -- u16 | gets set from the warp function.
	mode = 0x94, -- u16 | gets set from the warp function.
	region = 0x98, -- u16
	continues = 0xB0, -- u16
	loading = 0xC4, -- u8
	regionResultsFlag = 0xCC, -- u8 | if non-zero pressing A or Start trigger a load to the current set scene.
	transitionType = 0xD0, -- u8 | gets set based on what was passed to the warp function.
	mapLevelSelected = 0x00EC, -- s32 | boolean
		-- +0x04 after this for J.
	gameDebug = 0x0100, -- u32 | boolean
	transitions = 0x114, -- transition[6]
	characterInitScene = 0x0144, -- s16[4]
	gameFreeze = 0x0158, -- u32 | boolean
	stopSceenUpdate = 0x015C, -- u32 | boolean, if true the game will still keep running but the screen will not update anymore.
	unkTimer = 0x0160, -- s32 | counts down by gameSpeed each frame until 0.
	unk0168 = 0x0168, -- s32 | boolean
	actorState = 0x016C, -- s32 | is this actually what this is?
	gameSpeed = 0x01A4, -- s32 | 2 = normal, 1 = half speed?, 3+ = faster.
	unkTimer2 = 0x01A8, -- s32 | counts down by 1 in a loop that happens 8 times per frame.
	titleSceneIds = 0x01AC, -- u32[7]
	landingSkipTable = 0x01CC, -- u32[17] | 0x44 size
		-- +0x48 after this for J.
	titleCodeCorrect = 0x01C8, -- u32 | the amount of button presses in the correct order.
	titleCodeButtons = 0x01CC, -- u32[14]
		-- +0x40 after this for J.
	rngSeed = 0x0214, -- u32
		-- +0x50 after this on J.
	cheats = 0x1E98,
};

return include;

--[[
	Scene Data Entries / 5 bytes each.
	0x00 = number of players for this scene?
]]--