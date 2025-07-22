local include = {};

include.addresses = {
	J = {
		pointer = 0x0F2BB4,
		amount = 0x0F2BB8,
	},
	E = {
		pointer = 0x0F2CA4,
		amount = 0x0F2CA8,
	},
};

include.header = {
	__size = 0xE0,
	name = 0x0004, -- string, length of 0x10.
	amount_of = 0x001A, -- uint8, the amount of this type of actor.
	footer = 0x00D8, -- uint64 "ÿÿneStar"
};

--[[
	-- 800A7D94 table of floats / length of 0x3FF
	
	local temp0 = value & 0x3FF0 >> 4;
	if (0x4000 == true and 0x000F == true) then
		temp0 = 0x0001
	end
	temp0 = 0x0400 - temp0;
	temp0 = temp0 << 2; // * 4
	local temp2 = 800A7D94 + temp0;
	
	local float0 = loadFloat(temp2 + 0x0000);
	
	if (0x8000 == true) then
		float0 = -float0;
	end
	return float0;
]]--
include.rotation = {
	__size = 0x06,
	y = 0x00, -- s16
	x = 0x02, -- s16
	z = 0x04, -- s16
};

include.unk4C = {
	health = 0x0006, -- s16
};

include.actor = {
	__size = 0xA0,
	rotation = 0x00, -- s16[3] | this is a copy.
	debugVars = 0x06, --[[ s16 | bitfield
			0x0200 render actor and shadow
			0x0400 don't render actor or shadow
			0x0800 don't render actor but render shadow
			0x0C00 don't render actor or shadow
		]]--
	scale = 0x08, -- float, the scale modifier for this actors size.
	position = 0x0C, -- xyzf
	grounded = 0x1A, -- uint16, set to 1 the frame landing on the ground.
	velocity = 0x1C, -- xyzf
	animationTimer = 0x28, -- float, 0.0 -> 1.0 / (<value> * 100 = %)
	animationId = 0x3B, -- uint8
	sceneActor = 0x3C, -- sceneActor* (the actor instance from the scene file)
	header = 0x40, -- header*
	unk48 = 0x48, -- s16
	unk4A = 0x4A, -- s16
	unk4C = 0x4C, -- unk4C*
	unk50 = 0x50, -- unk50*
	unk54 = 0x54, -- unk54*
	data = 0x68, -- data*
	unk70 = 0x70, -- unk70*
	unk88 = 0x88, -- unk88, for Gem Quarry green gems this is the timer.
	killActor = 0xA0, -- s8, boolean
};

return include;