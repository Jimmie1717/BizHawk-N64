-- include
local Save = require("code.JF.include.save");
local Weapon = require("code.JF.include.weapon");

-- private
local private = {
	get = {},
	set = {},
};

-- public
local public = {
	get = {},
	set = {},
	clear = {},
};

function public.get.health(addr)
	return mem.get.s8(addr + Save.characterData.health);
end

function public.get.geminiHolders(addr)
	return mem.get.u16(addr + Save.characterData.geminiHolders);
end

function public.get.charInfo(addr)
	local info = mem.get.u16(addr + Save.characterData.charInfo);
	return {
		scene = (info & 0xFFE0) >> 5,
		model = info & 0x1F,
	};
end

function public.get.weapons(addr)
	local bits = mem.get.u16(addr + Save.characterData.weapons);
	return {
		[Weapon.weapons.PISTOL] = mem.get.bit(bits, Weapon.weapons.PISTOL),
		[Weapon.weapons.HOMING_MISSILE_LAUNCHER] = mem.get.bit(bits, Weapon.weapons.HOMING_MISSILE_LAUNCHER),
		[Weapon.weapons.MACHINE_GUN] = mem.get.bit(bits, Weapon.weapons.MACHINE_GUN),
		[Weapon.weapons.PLASMA_SHOTGUN] = mem.get.bit(bits, Weapon.weapons.PLASMA_SHOTGUN),
		[Weapon.weapons.SHOCKER] = mem.get.bit(bits, Weapon.weapons.SHOCKER),
		[Weapon.weapons.TRI_ROCKET_LAUNCHER] = mem.get.bit(bits, Weapon.weapons.TRI_ROCKET_LAUNCHER),
		[Weapon.weapons.FLAMETHROWER] = mem.get.bit(bits, Weapon.weapons.FLAMETHROWER),
		[Weapon.weapons.SNIPER_RIFLE] = mem.get.bit(bits, Weapon.weapons.SNIPER_RIFLE),
		[Weapon.weapons.GRENADES] = mem.get.bit(bits, Weapon.weapons.GRENADES),
		[Weapon.weapons.SHURIKENS] = mem.get.bit(bits, Weapon.weapons.SHURIKENS),
		[Weapon.weapons.FISH_FOOD] = mem.get.bit(bits, Weapon.weapons.FISH_FOOD),
		[Weapon.weapons.TIMED_MINES] = mem.get.bit(bits, Weapon.weapons.TIMED_MINES),
		[Weapon.weapons.REMOTE_MINES] = mem.get.bit(bits, Weapon.weapons.REMOTE_MINES),
		[Weapon.weapons.FLARES] = mem.get.bit(bits, Weapon.weapons.FLARES),
		[Weapon.weapons.CLUSTER_BOMBS] = mem.get.bit(bits, Weapon.weapons.CLUSTER_BOMBS),
		[Weapon.weapons.SPLITTER] = mem.get.bit(bits, Weapon.weapons.SPLITTER),
	};
end

function public.get.mizarTokens(addr)
	return mem.get.u16(addr + Save.characterData.mizarTokens);
end

function public.get.weaponAmmo(addr)
	local ammo = {};
	for i = 0, (Weapon.weapons.MAX - 1), 1 do
		ammo[i] = mem.get.u16(addr + Save.characterData.weaponAmmo + (i * 2));
	end
	return ammo;
end

function public.get.weaponCapacity(addr)
	local capacity = {};
	for i = 0, (Weapon.weapons.MAX - 1), 1 do
		capacity[i] = mem.get.u16(addr + Save.characterData.weaponCapacity + (i * 2));
	end
	return capacity;
end

function public.get.weaponGuage(addr)
	local guage = {};
	for i = 0, (Weapon.weapons.MAX - 1), 1 do
		guage[i] = mem.get.u8(addr + Save.characterData.weaponGuage + i);
	end
	return guage;
end

function public.get.levels(addr)
	local bits = mem.get.u16(addr + Save.characterData.levels);
	return {
		[Save.levels.RITH_ESSA] = mem.get.bit(bits, Save.levels.RITH_ESSA),
		[Save.levels.ASTEROID] = mem.get.bit(bits, Save.levels.ASTEROID),
		[Save.levels.MIZARS_PALACE] = mem.get.bit(bits, Save.levels.MIZARS_PALACE),
		[Save.levels.ICHOR] = mem.get.bit(bits, Save.levels.ICHOR),
		[Save.levels.ESCHEBONE] = mem.get.bit(bits, Save.levels.ESCHEBONE),
		[Save.levels.TAWFRET] = mem.get.bit(bits, Save.levels.TAWFRET),
		[Save.levels.SEKHMET] = mem.get.bit(bits, Save.levels.SEKHMET),
		[Save.levels.CERULEAN] = mem.get.bit(bits, Save.levels.CERULEAN),
		[Save.levels.SS_ANUBIS] = mem.get.bit(bits, Save.levels.SS_ANUBIS),
		[Save.levels.SPAWNSHIP] = mem.get.bit(bits, Save.levels.SPAWNSHIP),
		[Save.levels.GOLDWOOD] = mem.get.bit(bits, Save.levels.GOLDWOOD),
		[Save.levels.GEM_QUARRY] = mem.get.bit(bits, Save.levels.GEM_QUARRY),
		[Save.levels.SPACESTATION] = mem.get.bit(bits, Save.levels.SPACESTATION),
		[Save.levels.WATER_RUIN] = mem.get.bit(bits, Save.levels.WATER_RUIN),
		[Save.levels.WALKWAY] = mem.get.bit(bits, Save.levels.WALKWAY),
	};
end

function public.get.keys(addr)
	local bits = mem.get.u16(addr + Save.characterData.keys);
	return {
		[Save.keys.UNUSED_0] = mem.get.bit(bits, Save.keys.UNUSED_0),
		[Save.keys.UNUSED_1] = mem.get.bit(bits, Save.keys.UNUSED_1),
		[Save.keys.UNUSED_2] = mem.get.bit(bits, Save.keys.UNUSED_2),
		[Save.keys.UNUSED_3] = mem.get.bit(bits, Save.keys.UNUSED_3),
		[Save.keys.UNUSED_4] = mem.get.bit(bits, Save.keys.UNUSED_4),
		[Save.keys.TRI_ROCKET_LAUNCHER] = mem.get.bit(bits, Save.keys.TRI_ROCKET_LAUNCHER),
		[Save.keys.BLUE] = mem.get.bit(bits, Save.keys.BLUE),
		[Save.keys.UNUSED_7] = mem.get.bit(bits, Save.keys.UNUSED_7),
		[Save.keys.UNUSED_8] = mem.get.bit(bits, Save.keys.UNUSED_8),
		[Save.keys.UNUSED_9] = mem.get.bit(bits, Save.keys.UNUSED_9),
		[Save.keys.UNUSED_10] = mem.get.bit(bits, Save.keys.UNUSED_10),
		[Save.keys.UNUSED_11] = mem.get.bit(bits, Save.keys.UNUSED_11),
		[Save.keys.GREEN] = mem.get.bit(bits, Save.keys.GREEN),
		[Save.keys.MAGENTA] = mem.get.bit(bits, Save.keys.MAGENTA),
		[Save.keys.RED] = mem.get.bit(bits, Save.keys.RED),
		[Save.keys.YELLOW] = mem.get.bit(bits, Save.keys.YELLOW),
	};
end

function public.get.objects(addr)
	local bits = mem.get.u16(addr + Save.characterData.objects);
	return {
		[Save.objects.UNUSED_0] = mem.get.bit(bits, Save.objects.UNUSED_0),
		[Save.objects.UNUSED_1] = mem.get.bit(bits, Save.objects.UNUSED_1),
		[Save.objects.UNUSED_2] = mem.get.bit(bits, Save.objects.UNUSED_2),
		[Save.objects.UNUSED_3] = mem.get.bit(bits, Save.objects.UNUSED_3),
		[Save.objects.ARCADE_CHIP] = mem.get.bit(bits, Save.objects.ARCADE_CHIP),
		[Save.objects.EAR_PLUGS] = mem.get.bit(bits, Save.objects.EAR_PLUGS),
		[Save.objects.GOLD_BAR0] = mem.get.bit(bits, Save.objects.GOLD_BAR0),
		[Save.objects.GOLD_BAR1] = mem.get.bit(bits, Save.objects.GOLD_BAR1),
		[Save.objects.GOLD_BAR2] = mem.get.bit(bits, Save.objects.GOLD_BAR2),
		[Save.objects.NIGHT_VISION_GOGGLES] = mem.get.bit(bits, Save.objects.NIGHT_VISION_GOGGLES),
		[Save.objects.CROWBAR] = mem.get.bit(bits, Save.objects.CROWBAR),
		[Save.objects.PANTS] = mem.get.bit(bits, Save.objects.PANTS),
		[Save.objects.UNUSED_12] = mem.get.bit(bits, Save.objects.UNUSED_12),
		[Save.objects.UNUSED_13] = mem.get.bit(bits, Save.objects.UNUSED_13),
		[Save.objects.MINE_KEY] = mem.get.bit(bits, Save.objects.MINE_KEY),
		[Save.objects.SPECIALIST_MAG] = mem.get.bit(bits, Save.objects.SPECIALIST_MAG),
	};
end

function public.get.weaponChange(addr)
	local bool = mem.get.u8(addr + Save.characterData.weaponChange);
	if (bool == Save.weaponChange.ENABLE) then
		return true;
	end
	return false;
end

function public.get.weaponCurrent(addr)
	return Weapon.names[mem.get.u8(addr + Save.characterData.weaponCurrent)];
end

function public.get.levelId(addr)
	return mem.get.s8(addr + Save.characterData.levelId);
end

function public.get.spawnInfo(addr)
	local info = mem.get.u16(addr + Save.characterData.spawnInfo);
	return {
		scene = (info & 0xFFE0) >> 5,
		entrance = info & 0x1F,
	};
end

function public.get.data(index)
	local addr = Save.addresses[game.header.country_code] + Save.save.characterData + (Save.characterData.__size * index);
	return {
		health = public.get.health(addr),
		geminiHolders = public.get.geminiHolders(addr),
		charInfo = public.get.charInfo(addr),
		weapons = public.get.weapons(addr),
		mizarTokens = public.get.mizarTokens(addr),
		weaponAmmo = public.get.weaponAmmo(addr),
		weaponCapacity = public.get.weaponCapacity(addr),
		weaponGuage = public.get.weaponGuage(addr),
		levels = public.get.levels(addr),
		keys = public.get.keys(addr),
		objects = public.get.objects(addr),
		weaponChange = public.get.weaponChange(addr),
		weaponCurrent = public.get.weaponCurrent(addr),
		levelId = public.get.levelId(addr),
		spawnInfo = public.get.spawnInfo(addr),
	};
end




function public.set.level(index, level)
	local addr = Save.addresses[game.header.country_code] + Save.save.characterData + (Save.characterData.__size * index);
	local bits = mem.get.u16(addr + Save.characterData.levels);
	mem.set.u16(addr + Save.characterData.levels, mem.set.bit(bits, Save.levels[level]));
end

function public.clear.levels(index)
	local addr = Save.addresses[game.header.country_code] + Save.save.characterData + (Save.characterData.__size * index);
	mem.set.u16(addr + Save.characterData.levels, 0x0000);
end

return public;