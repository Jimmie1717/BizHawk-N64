local include = {};

include.addresses = {
	J = 0x0F2C1C,
	E = 0x0F2D0C,
	P = 0x0F276C,
};

include.characterName = {
	[0] = "Vela",
	[1] = "Juno",
	[2] = "Lupus",
	[3] = "Racer",
	[4] = "Vela (Jet Pack)",
	[5] = "Juno (Jet Pack)",
	[6] = "Lupus (Jet Pack)",
};

include.characterType = {
	VELA = 0,
	JUNO = 1,
	LUPUS = 2,
	RACER = 3,
	JETPACK_VELA = 4,
	JETPACK_JUNO = 5,
	JETPACK_LUPUS = 6,
	JETPACK_RACER = 7,
	MAX = 8,
};

include.robotMissionStates = {
	DISABLED = 0x00,
	ENABLE = 0x01,
	ACTIVATING = 0x02,
	FAILED = 0x03,
	DISABLE = 0x04,
};

include.data = {
	unk_00 = 0x0000, -- s8
	characterType = 0x0001, -- u8
	inWater = 0x0002, -- u8 | 0 = no, 1 = yes.
	inWaterCopy = 0x0003, -- u8
	speedZ = 0x0004, -- f32
	speedX = 0x0008, -- f32
	
	unk_gravity = 0x0040, -- f32
	
	rotationFloat = 0x0038, -- -1.0 to +1.0
	lastFramePosition = 0x003C, -- xyzf
	verticalScale = 0x0048,
	verticalScaleSetter = 0x004C,
	camera_rotation = 0x0104,
	camera_unknown_u16 = 0x0106,
	camera_center_character_flag = 0x0108,
	camera_center_character_timer = 0x0109,
	robotMissionState = 0x010D, -- u8
	camera_position_offset = 0x0118, -- f32
	rotation = 0x011C, -- u16_rot | this is actual rotation (changing this will rotate the character).
	rotationCopy = 0x0122, -- u16
	
	unknown0124 = 0x0124, -- s16 | loaded from Actor.actor.unknown02 then stored here.
	
	unknown0140 = 0x0140, -- s16
	unknown0142 = 0x0142, -- s16 | loaded and added to Actor.actor.unknown04
	unknown0144 = 0x0144, -- s16 | loaded and added to Actor.actor.unknown02
	
	characterAlpha = 0x019C, -- s8 | 0xFF - (<value> * 4)
	
	reticleTarget = 0x01BC, -- actor*
	reticleRotationX = 0x01C6, -- u16_rot
	reticleRotationY = 0x01C8, -- u16_rot
	reticleRotationZ = 0x01CA, -- u16_rot
	
	aimingWeaponRotationX = 0x01CE, -- u16_rot
	aimingWeaponRotationY = 0x01D0, -- u16_rot
	
	aimingHeadRotationX = 0x01DC, -- u16_rot
	aimingHeadRotationY = 0x01DE, -- u16_rot
	aimingHeadRotationZ = 0x01E0, -- u16_rot
	
	reticleCameraSpeedX = 0x01E4, -- f32 | + = left, - = right
	reticleCameraSpeedY = 0x01E8, -- f32 | + = up, - = down
	
	isAiming = 0x01F4, -- u8 | 0 = not aiming, 1 = aiming
	
	collision_unknown = 0x364, -- 5 groups of xyzf
	
	lastFramePositionCopy = 0x0524, -- xyzf
	
	unknown_0x0586 = 0x0586, -- s16 | copied to characterData 0x000C.
	unknown_0x0588 = 0x0588, -- s16
	unknown_0x058A = 0x058A, -- s16
	
	jetFuel = 0x058C, -- u16
	
	unk05C0 = 0x05C0, -- s32 | 1 = freeze game, 0 = unfreeze game. Same as Play.playState.gameFreeze?
};

return include;