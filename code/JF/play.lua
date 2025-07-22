-- include
local Timecode = require("common.timecode");
local Play = require("code.JF.include.play");
local Scene = require("code.JF.include.scene");
local Region = require("code.JF.include.region");

-- private
local private = {
	get = {},
	set = {},
};

-- TODO: fix this hacky solution
function private.playStateOffset(offset)
	local o = 0x00;
	if (game.header.country_code == "J") then
		if (offset > Play.playState.rngSeed) then
			o = 0x50;
		elseif (offset > Play.playState.titleCodeButtons) then
			o = 0x40;
		elseif (offset > Play.playState.landingSkipTable) then
			o = 0x48;
		elseif (offset > Play.playState.mapLevelSelected) then
			o = 0x04;
		end
	end
	return offset + o;
end

-- public
local public = {
	get = {},
	set = {},
	scenes = Scene.scenes,
};

function public.get.robotMissionTime()
	return Timecode.convert(mem.get.u32(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.robotMissionFrames))).strings.time;
end

function public.get.inRobotMission()
	if (mem.get.u8(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.robotMissionFlag)) == 1) then
		return true;
	end
	return false;
end

function public.get.currentScene()
	return mem.get.u16(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.currentScene));
end

function public.get.scene()
	return mem.get.u16(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.scene));
end

function public.get.region()
	return Region.names[mem.get.u16(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.region))];
end

function public.get.continues()
	return mem.get.u16(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.continues));
end

function public.get.loading()
	return mem.get.u8(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.loading));
end

function public.get.rngSeed()
	return mem.get.h32(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.rngSeed));
end

function public.get.regionExit()
	if (mem.get.u8(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.regionResultsFlag)) == 0) then
		return false;
	else
		return true;
	end
end



function public.set.inRobotMission(state)
	if (state) then
		mem.set.u8(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.robotMissionFlag), 1);
	else
		mem.set.u8(Play.addresses[game.header.country_code] + private.playStateOffset(Play.playState.robotMissionFlag), 0);
	end
end

return public;