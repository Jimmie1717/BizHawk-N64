-- include
local Play = require("code.JF.include.play");
local Region = require("code.JF.include.region");

local library = {};

library.symbols = {
	screenOverrideSize = { J = nil, E = 0x045B98, P = nil },
	randRange = { J = 0x048C5C, E = 0x048E2C, P = 0x048F7C },
}

function library.screenOverrideSize(current, dest, timer)
	-- current = { x1, y1, x2, y2 }
	-- dest = { x1, y1, x2, y2 }
end

function library.randRange(min, max)
	-- if(J)
	if (game.header.country_code == "J") then
		if (min >= max) then
			return min;
		end
	end
	-- endIf
	local seed = Play.playState.rngSeed;
	max = max - min;
	local lowestBit = (seed << 63) >> 31;
	local otherBits = (seed << 31) >> 32;
	local moreBits = (seed << 44) >> 32;
	lowestBit = (lowestBit | otherBits) ^ moreBits;
	local newSeed = ((lowestBit >> 20) & 0x0FFF) ^ lowestBit;
	Play.playState.rngSeed = newSeed;
	max = max + 1;
	newSeed = newSeed - min;
	if (max == 0) then
		error();
	end
	return (newSeed % max) + min;
end

--[[
	Play.playState.region gets cleared right before this function is called.
	So for "regionIndex" they look up the current loaded scene, then from the scene file they get the region index assigned to the scene.
	Probably would have been smarter to not clear Play.playState.region until after.
]]--
function library.regionExit()
	-- this is just the part for setting the flag jeff checks for stabilizer. (not fully accurate)
	if (Save.get.region.best(regionIndex).tribalsRescued < Save.get.tribals.rescued()) then
		Save.set.region.best(Save.get.tribals.rescued(), Save.get.tribals.killed(), Save.get.region.totalKills(), Save.get.region.frames())
		local tribalTotal, currentTotal = 0, 0;
		for i = 0, Region.regions.MAX, 1 do
			tribalTotal = tribalTotal + Play.get.regionTribals(i);
			currentTotal = currentTotal + Save.get.region.best(i).tribalsRescued;
		end
		if (currentTotal == tribalTotal and not Save.get.flags.game(Save.flags.gameFlags.ALL_TRIBALS_RESCUED) then
			Save.set.flags.game(Save.flags.gameFlags.ALL_TRIBALS_RESCUED);
		end
	end
end

--[[
	Mizar 1 attacks:
	result = randRange(0, 29);
	if (result < 10) setAttack(attacks.CLAW);
	elseif (result < 20) setAttack(attacks.MINTY_BREATH);
	else setAttack(attacks.LAZER_VISION);
]]--

return library;