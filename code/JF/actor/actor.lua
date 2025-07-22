-- include
local Actor = require("code.JF.include.actor");

-- private
local private = {
	get = {},
	set = {},
};

-- list
function private.get.list_pointer()
	return mem.get.ptr(Actor.addresses[game.header.country_code].pointer);
end

function private.get.list_amount()
	return mem.get.u32(Actor.addresses[game.header.country_code].amount);
end


-- unk4C
function private.get.unk4C(addr)
	return {
		health = mem.get.s16(addr + Actor.unk4C.health),
	};
end

-- public
local public = {
	get = {},
	set = {},
};

function public.get.rotation(addr)
	return {
		x = mem.get.u16_rot(addr + Actor.actor.rotation + Actor.rotation.x),
		y = mem.get.u16_rot(addr + Actor.actor.rotation + Actor.rotation.y),
		z = mem.get.u16_rot(addr + Actor.actor.rotation + Actor.rotation.z),
	};
end

function public.get.scale(addr)
	return mem.get.f32(addr + Actor.actor.scale);
end

function public.get.position(addr)
	return mem.get.vec3f(addr + Actor.actor.position);
end

function public.get.velocity(addr)
	return mem.get.vec3f(addr + Actor.actor.velocity);
end

function public.get.animationTimer(addr)
	return mem.get.f32(addr + Actor.actor.animationTimer) * 100;
end

function public.get.animationId(addr)
	return mem.get.u8(addr + Actor.actor.animationId);
end

function public.get.sceneActor(addr)
	return mem.get.ptr(addr + Actor.actor.sceneActor);
end

function public.get.header(addr)
	return mem.get.ptr(addr + Actor.actor.header);
end

function public.get.unk4C(addr)
	local ptr = mem.get.ptr(addr + Actor.actor.unk4C);
	if (ptr == nil) then return nil; end
	return private.get.unk4C(ptr);
end

function public.get.data(addr)
	return mem.get.ptr(addr + Actor.actor.data);
end

function public.get.name(addr)
	local ptr = public.get.header(addr);
	if (ptr == nil) then return nil; end
	return mem.get.string(ptr + Actor.header.name);
end






-- get the actor list.
function public.get.list()
	local pointer = private.get.list_pointer();
	local amount = private.get.list_amount();
	local list = {};
	for i = 0, (amount - 1), 1 do
		list[i] = mem.get.ptr(pointer + (i * 4));
	end
	return list;
end

-- get an actor.
function public.get.actor(addr)
	if (addr == nil) then return nil; end
	return { 
		address = addr,
		rotation = public.get.rotation(addr),
		scale = public.get.scale(addr),
		position = public.get.position(addr),
		velocity = public.get.velocity(addr),
		animationTimer = public.get.animationTimer(addr),
		animationId = public.get.animationId(addr),
		sceneActor = public.get.sceneActor(addr),
		header = public.get.header(addr),
		unk4C = public.get.unk4C(addr),
		data = public.get.data(addr),
		name = public.get.name(addr),
	};
end

function public.get.byName(name)
	local list, actors, i = public.get.list(), {}, 0;
	for index, value in ipairs(list) do
		if (public.get.name(value) == name) then
			actors[i] = public.get.actor(value);
			i = i + 1;
		end
	end
	return actors;
end



return public;