-- include
local CharacterData = require("code.JF.characterData");
local Save = require("code.JF.include.save");
local Flags = require("code.JF.include.flags");
local Region = require("code.JF.include.region");
local Weapon = require("code.JF.include.weapon");

-- private
local private = {
	get = {},
	set = {},
};

-- public
local public = {
	get = {
		tribals = {},
		flags = {},
		region = {},
	},
	set = {},
	flags = Flags,
	weapons = Weapon.weapons,
};


function public.get.weaponNames()
	return Weapon.names;
end




function public.get.tribals.rescued()
	return mem.get.u8(Save.addresses[game.header.country_code] + Save.save.tribals + Save.tribals.rescued);
end

function public.get.tribals.killed()
	return mem.get.u8(Save.addresses[game.header.country_code] + Save.save.tribals + Save.tribals.killed);
end

function public.get.tribals.remaining()
	return mem.get.u8(Save.addresses[game.header.country_code] + Save.save.tribals + Save.tribals.remaining);
end

function public.get.flags.game(flag)
	local addr, index = Save.addresses[game.header.country_code] + Save.save.flags + Flags.flags.game, nil;
	if (type(flag) == "string") then
		index = Flags.gameFlags[flag];
	elseif (type(flag) == "number") then
		index = flag;
	else
		return nil;
	end
	if (index == nil) then return nil; end
	return mem.get.bit(mem.get.u8(addr + math.floor(index / 8)), index % 8);
end





function public.get.frames()
	return mem.get.u32(Save.addresses[game.header.country_code] + Save.save.frames);
end



function public.get.region.best(index)
	local addr = Save.addresses[game.header.country_code] + Save.save.region + Region.region.bests + (index * Region.best.__size);
	return {
		tribalsRescued = mem.get.u8(addr + Region.best.tribalsRescued),
		tribalsKilled = mem.get.u8(addr + Region.best.tribalsKilled),
		totalKills = mem.get.u16(addr + Region.best.totalKills),
		frames = mem.get.u32(addr + Region.best.frames),
	};
end

function public.get.region.shots(index)
	if (index >= 0 and index < Weapon.weapons.MAX) then
		return mem.get.u32(Save.addresses[game.header.country_code] + Save.save.region + Region.region.shots + (index * 4));
	else
		return nil;
	end
end

function public.get.region.hits(index)
	if (index >= 0 and index < Weapon.weapons.MAX) then
		return mem.get.u32(Save.addresses[game.header.country_code] + Save.save.region + Region.region.hits + (index * 4));
	else
		return nil;
	end
end

function public.get.region.kills(index)
	if (index >= 0 and index < Weapon.weapons.MAX) then
		return mem.get.u16(Save.addresses[game.header.country_code] + Save.save.region + Region.region.kills + (index * 2));
	else
		return nil;
	end
end

function public.get.region.accuracy(index)
	local hits, shots = public.get.region.hits(index), public.get.region.shots(index);
	if (hits == nil or shots == nil) then
		return nil;
	elseif (shots == 0) then
		return 0;
	end
	return (hits / shots) * 100;
end

function public.get.region.frames()
	return mem.get.u32(Save.addresses[game.header.country_code] + Save.save.region + Region.region.frames);
end

function public.get.region.cleared(index)
	local region, cleared = public.get.region.best(index), false;
	if (region.tribalsRescued == Region.tribals[index]) then
		cleared = true;
	end
	return {
		name = Region.names[index],
		totalKills = region.totalKills,
		frames = region.frames,
		cleared = cleared,
	};
end

function public.get.region.clearedAll()
	local list = {};
	-- first entry is for non-region (not used).
	for i = 1, (Region.regions.MAX - 1), 1 do
		list[i-1] = public.get.region.cleared(i);
	end
	return list;
end

function public.get.region.totalKills()
	local total = 0;
	for i = 0, Weapon.weapons.MAX, 1 do
		local kills = public.get.region.kills(i);
		if (kills ~= nil) then
			total = total + kills;
		end
	end
	return total;
end



function public.get.characterData(index)
	if (type(index) == "string" and index == "current") then
		index = mem.get.u8(Save.addresses[game.header.country_code] + Save.save.character);
	end
	if (type(index) == "number" and index >= 0 and index < Save.character.MAX) then
		return CharacterData.get.data(index);
	else
		return nil;
	end
end

function public.get.characterModelName(character, model)
	if (character == Save.character.VELA) then
		return Save.velaCharacterModelNames[model];
	elseif (character == Save.character.JUNO) then
		return Save.junoCharacterModelNames[model];
	elseif (character == Save.character.LUPUS) then
		return Save.lupusCharacterModelNames[model];
	else
		return nil;
	end
end



function public.set.characterDataLevels(index, levels)
	if (type(index) == "string" and index == "current") then
		index = mem.get.u8(Save.addresses[game.header.country_code] + Save.save.character);
	end
	if (type(index) == "number" and index >= 0 and index < Save.character.MAX) then
		for i = 1, #levels, 1 do
			CharacterData.set.level(index, levels[i]);
		end
	end
end

function public.set.characterDataLevelsClear(index)
	if (type(index) == "string" and index == "current") then
		index = mem.get.u8(Save.addresses[game.header.country_code] + Save.save.character);
	end
	if (type(index) == "number" and index >= 0 and index < Save.character.MAX) then
		CharacterData.clear.levels(index);
	end
end


return public;