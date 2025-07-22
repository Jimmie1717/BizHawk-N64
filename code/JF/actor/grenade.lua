-- Floyd related functions and data.

-- include
local Actor = require("code.JF.actor.actor");
local Grenade = require("code.JF.include.actor.grenade");

-- private
local private = {
	get = {},
	set = {},
};

function private.get.data(addr)
	return {
		timer = mem.get.s16(addr + Grenade.data.timer),
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
	local grenade = Actor.get.byName("grenade")[0];
	if (grenade == nil) then
		return nil;
	end
	
	return public.get.byAddress(grenade.address);
end

return public;