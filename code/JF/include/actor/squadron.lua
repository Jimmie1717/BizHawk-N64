local include = {};

include.addresses = {
	J = 0x0,
	E = 0x0,
};

include.data = {
	behaviour = 0x07, -- u8
	actorId = 0x2C, -- u16
	state = 0x30, -- u8
	behaviourCopy = 0x32, -- u8
	spawnedActor = 0x58, -- actor*
};

return include;