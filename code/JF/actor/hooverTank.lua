-- Floyd related functions and data.

-- include
local Actor = require("code.JF.actor.actor");
local HooverTank = require("code.JF.include.actor.hooverTank");

-- private
local private = {
	get = {},
	set = {},
};

function private.get.data(addr)
	return {
		gemPower = mem.get.s16(addr + HooverTank.data.gemPower),
		tankPower = mem.get.s16(addr + HooverTank.data.tankPower),
	};
end

-- public
local public = {
	get = {},
	set = {},
};

function public.get.actor()
	local addr = mem.get.ptr(HooverTank.addresses[game.header.country_code]);
	if (addr == nil) then
		return nil;
	end
	
	local actor = Actor.get.actor(addr);
	if (actor.data ~= nil) then
		actor.data = private.get.data(actor.data);
	end
	return actor;
end

return public;