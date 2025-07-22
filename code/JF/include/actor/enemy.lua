local include = {};

include.addresses = {
	J = nil,
	E = nil,
};

include.flags = {
	UNKNOWN_0 = 0,
	UNKNOWN_1 = 1,
	UNKNOWN_2 = 2,
	UNKNOWN_3 = 3,
	UNKNOWN_4 = 4,
	UNKNOWN_5 = 5,
	UNKNOWN_6 = 6,
	DEAD = 7,
};

include.infoState = {
	UNKNOWN_0 = 0,
	UNKNOWN_1 = 1,
	RUNNING_TO_PLAYER = 2,
	UNKNOWN_3 = 3,
	UNKNOWN_4 = 4,
	UNKNOWN_5 = 5,
	UNKNOWN_6 = 6,
	UNKNOWN_7 = 7,
};


include.info = {
	mode = 0x00, -- u8
	unk1 = 0x01,
	unk2 = 0x02,
	state = 0x03, -- u8 | bitfield
};

include.unk50 = {
	__size = 0x24,
};

include.unk54 = {
	__size = 0x90, -- 0x30[3]?
};

include.data = {
	__size = 0x00C8, -- TODO: validate this.
	flags = 0x0007, -- u8
	mode = 0x001A, -- u16
	parent = 0x0024, -- actor*
	deathTimer = 0x0050, -- u16 | 
	alpha = 0x0055, -- u8 | reversed. 
	player = 0x0064, -- actor*
	shotByPlayer = 0x00A4, -- u16 | boolean?
	healthCopy = 0x00A6, -- s16
	info = 0x00B0, -- struct*
};

return include;

--[[	
	actor.data + 0x24 = parent*
	actor.data + 0x64 = player*
	parent.data + 0x07 = u8 | behaviour
		baby:
			0x11 = run to you when it notices you.
	parent.data + 0x2A = s16 | init health
	parent.data + 0x2C = u16 | actor id
	parent.data + 0x30 = u8 | 
	parent.data + 0x32 = u8 | behaviourCopy, this actually controls it's behaviour
	parent.data + 0x58 = child
	
	
	player: x = -254.712, z = 789.665
	tribal: x = -813.000, z = 940.000
	
	function(tribal.x - player.x, tribal.z - player.z); // distance formula?
	function(-558.288, 150.335);
	
	800A8D98
	
	
	if(player + 0x48 ~= 1) then
		tribal.parent.data + 0x38 = 4; -- will run away from player.
	else
		if((tribal.data + 0x04) & 0x0001 ~= 0) then
			tribal.parent.data + 0x38 = 5; -- will run to player when detected.
		else
			tribal.parent.data + 0x38 = 8; -- won't run to player.
			tribal.parent.data + 0x39 = 8; -- ?
			
			((tribal.data + 0xB0) + 0x03) & 0xFFFD
		end
	end
	
	if ((tribal.data + 0xB0) + 0x05 & 0x4 ~= 0) then
		-- tribal is running to player
	end
]]--