local include = {};

include.addresses = {
	J = 0x0FEC70,
	E = 0x0FED50,
	P = nil,
};

include.racer = {
	__size = 0xA0,
	charcterData = 0x16, -- characterData?
	frames = 0x90, -- u32, timer for how long they have been racing.
};

include.race = {
	racer = 0x00, -- racer[4]
};

return include;