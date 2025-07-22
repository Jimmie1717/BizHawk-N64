-- MizarBoss related functions and data.

-- include
local Actor = require("code.JF.actor.actor");
local MizarBoss = require("code.JF.include.actor.mizarBoss");

-- private
local private = {
	get = {},
	set = {},
};

function private.get.data(addr)
	return {
		damage = mem.get.u32(addr + MizarBoss.data.damage),
	};
end

-- public
local public = {
	get = {},
	set = {},
};

function public.get.byAddress(addr)
	if (addr == nil) then return nil; end
	
	local actor = Actor.get.actor(addr);
	if (actor.data ~= nil) then
		actor.data = private.get.data(actor.data);
	end
	
	return actor;
end

function public.get.actor()
	local addr = Actor.get.byName("MizarBoss")[0].address;
	if (addr == nil) then return nil; end
	return public.get.byAddress(addr);
end

return public;