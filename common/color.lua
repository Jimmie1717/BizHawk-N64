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

--[[
const deg = Math.PI / 180;

function rotateRGBHue(r, g, b, hue) {
  const cosA = Math.cos(hue * deg);
  const sinA = Math.sin(hue * deg);
  const neo = [
    cosA + (1 - cosA) / 3,
    (1 - cosA) / 3 - Math.sqrt(1 / 3) * sinA,
    (1 - cosA) / 3 + Math.sqrt(1 / 3) * sinA,
  ];
  const result = [
    r * neo[0] + g * neo[1] + b * neo[2],
    r * neo[2] + g * neo[0] + b * neo[1],
    r * neo[1] + g * neo[2] + b * neo[0],
  ];
  return result.map(x => uint8(x));
}

function uint8(value) {
  return 0 > value ? 0 : (255 < value ? 255 : Math.round(value));
}
]]--