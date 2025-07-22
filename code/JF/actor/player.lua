-- Player related functions and data.

--[[ notes ]--------------------
	Jumping adds ~10.0 when moving and ~12.0 when stationary.
]]--

-- include
local Actor = require("code.JF.actor.actor");
local Floyd = require("code.JF.actor.floyd");
local Player = require("code.JF.include.actor.player");

-- private
local private = {
	get = {},
	set = {},
};

function private.get.characterName(character)
	return Player.characterName[character];
end

function private.get.jetFuelNum(fuel)
	return math.floor((fuel / 3600) * 100);
end

function private.get.data(addr)
	return {
		characterType = mem.get.u8(addr + Player.data.characterType),
		inWater = mem.get.u8(addr + Player.data.inWater),
		speedZ = mem.get.f32(addr + Player.data.speedZ),
		speedX = mem.get.f32(addr + Player.data.speedX),
		rotationFloat = mem.get.f32(addr + Player.data.rotationFloat),
		lastFramePosition = mem.get.vec3f(addr + Player.data.lastFramePosition),
		robotMissionState = mem.get.u8(addr + Player.data.robotMissionState),
		rotation = mem.get.u16_rot(addr + Player.data.rotation),
		characterAlpha = 0xFF - (mem.get.s8(addr + Player.data.characterAlpha) << 2),
		reticleTarget = Actor.get.actor(mem.get.ptr(addr + Player.data.reticleTarget)),
		isAiming = mem.get.u8(addr + Player.data.isAiming),
		jetFuel = mem.get.u16(addr + Player.data.jetFuel),
	}
end

-- public
local public = {
	get = {},
	set = {},
};

function public.get.pointer(index)
	local addr = mem.get.ptr(Player.addresses[game.header.country_code]);
	if (addr == nil) then
		return nil;
	end
	addr = mem.get.ptr(addr + (index * 4));
	if (addr == nil) then
		return nil;
	end
	
	return addr;
end

function public.get.byAddress(addr)
	if (addr == nil) then
		return nil;
	end
	
	local actor = Actor.get.actor(addr);
	if (actor.data ~= nil) then
		actor.data = private.get.data(actor.data);
		actor.data.name = private.get.characterName(actor.data.characterType & 0x3);
		actor.data.jetFuelNum = private.get.jetFuelNum(actor.data.jetFuel);
	end
	return actor;
end

function public.get.actor(index)
	if (index == nil) then index = 0; end
	if (type(index) ~= "number" or index < 0 or index > 3) then
		return nil;
	end
	
	return public.get.byAddress(public.get.pointer(index));
end



function public.set.robotMission(state)
	local addr = public.get.pointer(0);
	if (addr == nil) then return; end
	addr = Actor.get.data(addr);
	if (addr == nil) then return; end
	if (state) then
		mem.set.u8(addr + Player.data.robotMissionState, Player.robotMissionStates.ENABLE)
		Floyd.set.missionTimer(9999);
	else
		mem.set.u8(addr + Player.data.robotMissionState, Player.robotMissionStates.DISABLE)
		Floyd.set.missionTimer(0);
	end
end

return public;