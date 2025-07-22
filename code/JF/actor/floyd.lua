-- Floyd related functions and data.

-- include
local Actor = require("code.JF.actor.actor");
local Floyd = require("code.JF.include.actor.floyd");

-- private
local private = {
	get = {},
	set = {},
};

function private.get.data(addr)
	return {
		missionTimer = mem.get.s16(addr + Floyd.data.missionTimer),
	};
end

-- public
local public = {
	get = {},
	set = {},
};

function public.get.byAddress(addr)
	if (addr == nil) then
		return nil;
	end
	
	local actor = Actor.get.actor(addr);
	if (actor.data ~= nil) then
		actor.data = private.get.data(actor.data);
	end
	return actor;
end

function public.get.actor()
	local addr = mem.get.ptr(Floyd.addresses[game.header.country_code]);
	if (addr == nil) then
		return nil;
	end
	
	return public.get.byAddress(addr);
end



function public.set.missionTimer(frames)
	local addr = mem.get.ptr(Floyd.addresses[game.header.country_code]);
	if (addr == nil) then return; end
	addr = Actor.get.data(addr);
	if (addr == nil) then return; end
	if(type(frames) ~= "number" or frames > 9999) then frames = 9999; end
	mem.set.s16(addr + Floyd.data.missionTimer, frames);
end

return public;