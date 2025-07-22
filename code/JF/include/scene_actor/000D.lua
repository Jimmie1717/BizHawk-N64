-- Actor 0x000D: setuppoint (player spawn point)
local include = {};

include.parameters = {
	unk00 = 0x00, -- u8 | stored to actor + 0x88 as a u32.
	unk01 = 0x01, -- u8
	unk02 = 0x02, -- u8 | value << 10, stored to actor rotation?
	
};

return include;