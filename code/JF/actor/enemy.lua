-- Enemy related functions and data.

-- include
local Actor = require("code.JF.actor.actor");
local Enemy = require("code.JF.include.actor.enemy");

-- private
local private = {
	get = {},
	set = {},
};

--[[
function private.get.flags(addr)
	local ptr = mem.get.ptr(addr + Enemy.data.flags);
	if (ptr == nil) then return nil; end
	local state = mem.get.u8(ptr);
	return {
		mode = mem.get.u8(ptr + Enemy.flags.mode),
		unk1 = mem.get.u8(ptr + Enemy.flags.unk1),
		unk2 = mem.get.u8(ptr + Enemy.flags.unk2),
		state = {
			unk0 = mem.get.bit(state, Enemy.state.UNKNOWN_0),
			unk1 = mem.get.bit(state, Enemy.state.UNKNOWN_1),
			runningToPlayer = mem.get.bit(state, Enemy.state.RUNNING_TO_PLAYER),
			unk3 = mem.get.bit(state, Enemy.state.UNKNOWN_3),
			unk4 = mem.get.bit(state, Enemy.state.UNKNOWN_4),
			unk5 = mem.get.bit(state, Enemy.state.UNKNOWN_5),
			unk6 = mem.get.bit(state, Enemy.state.UNKNOWN_6),
			unk7 = mem.get.bit(state, Enemy.state.UNKNOWN_7),
		},
	};
end
]]--

function private.get.flags(addr)
	local flags = mem.get.u8(addr + Enemy.data.flags);
	return {
		UNKNOWN_0 = mem.get.bit(flags, Enemy.flags.UNKNOWN_0),
		UNKNOWN_1 = mem.get.bit(flags, Enemy.flags.UNKNOWN_1),
		UNKNOWN_2 = mem.get.bit(flags, Enemy.flags.UNKNOWN_2),
		UNKNOWN_3 = mem.get.bit(flags, Enemy.flags.UNKNOWN_3),
		UNKNOWN_4 = mem.get.bit(flags, Enemy.flags.UNKNOWN_4),
		UNKNOWN_5 = mem.get.bit(flags, Enemy.flags.UNKNOWN_5),
		UNKNOWN_6 = mem.get.bit(flags, Enemy.flags.UNKNOWN_6),
		DEAD = mem.get.bit(flags, Enemy.flags.DEAD),
	};
end

function private.get.unk4C(addr)
	return {
		health = mem.get.s16(addr + Enemy.unk4C.health),
	};
end

function private.get.data(addr)
	return {
		flags = private.get.flags(addr),
		parent = mem.get.ptr(addr + Enemy.data.parent),
		player = mem.get.ptr(addr + Enemy.data.player),
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
	local addr = mem.get.ptr(Enemy.addresses[game.header.country_code]);
	if (addr == nil) then return nil; end
	return public.get.byAddress(addr);
end

return public;