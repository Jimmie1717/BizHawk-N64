local private = {};

function private.generate()
	return string.format("#%02X%02X%02X", math.random(0, 255), math.random(0, 255), math.random(0, 255));
end

local public = {
	RED = "#FFC0C0",
	ORANGE = "#FFE0C0",
	YELLOW = "#FFFFC0",
	LIME = "#E0FFC0",
	GREEN = "#C0FFC0",
	SPRING_GREEN = "#C0FFE0",
	CYAN = "#C0FFFF",
	LIGHT_BLUE = "#C0E0FF",
	BLUE = "#C0C0FF",
	PURPLE = "#E0C0FF",
	MAGENTA = "#FFC0FF",
	PINK = "#FFC0E0",
	WHITE = "#FFFFFF",
	LIGHT_GRAY = "#E4E4E4",
	GRAY = "#C0C0C0",
	BLACK = "#000000",
	RANDOM = private.generate(),
};

return public;