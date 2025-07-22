-- Map related functions and data.

-- include
local Map = require("code.JF.include.actor.map");

-- private
local private = {
	get = {},
	set = {},
};

function private.set.level(level)
	mem.set.u32(Map.addresses[game.header.country_code].level, Map.levels[level]);
end

function private.set.position(level)
	mem.set.f32(Map.addresses[game.header.country_code].position.x, Map.levelPositions[level].x);
	mem.set.f32(Map.addresses[game.header.country_code].position.y, Map.levelPositions[level].y);
end

-- public
local public = {
	get = {},
	set = {},
};

function public.update(level)
	private.set.level(level);
	private.set.position(level);
end

return public;