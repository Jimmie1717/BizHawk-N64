-- include
local Timecode = require("common.timecode");
local Race = require("code.JF.include.race");

-- private
local private = {
	get = {},
	set = {},
};

-- public
local public = {
	get = {
		player = {},
	},
	set = {},
};

function public.get.frames(index)
	return mem.get.u32(Race.addresses[game.header.country_code] + Race.race.racer + (Race.racer.__size * index) + Race.racer.frames);
end

function public.get.player.time(player)
	return Timecode.convert(public.get.frames(player)).strings.time;
end

return public;