local include = {};

include.actor = {
	id = 0x00, -- u16
	size = 0x02, -- u8
	position = 0x04, -- vec3s
	parameters = 0x0A,
};

return include;