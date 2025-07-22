-- Actor 0x000B: exit
local include = {};

--[[ scale (0x08)
if (scale < 5) then
	actor.scale = 0.5;
else
	local temp = (float)scale;
	if (scale < 0) then
		temp += 4.294970000000000;
	end
	actor.scale = temp * 0.01;
end
]]--

--[[ levelToUnlock (0x0A)
if (levelToUnlock == -1) then
	warp(sceneDest, getCharacter(), entrance, getGameMode(), fadetype, 1);
else
	local character = Save.character & 0x03;
	local levels = Save.characterData[character].levels;
	
	if (levels & (1 << levelToUnlock) == 0) then
		local scene = Save.characterData[character].charInfo.scene;
		local level = getSceneLevel(scene);
		levels |= (1 << level); -- unlock current level for character.
		Save.characterData[character].levels = levels | (1 << levelToUnlock); -- unlock set level for this character.
		warp(sceneDest, getCharacter(), entrance, getGameMode(), fadetype, 1);
		if (setup ~= -1) then
			setSceneSetup(setup);
		end
	else
		local scene = Save.characterData[character].charInfo.scene;
		local level = getSceneLevel(scene);
		Save.characterData[character].levels = levels | (1 << level); -- unlock level for character.
		warp(0, 0, 0, 17, 1, 1); -- go to the map screen.
	end
end
if (setup ~= -1) then
	setSceneSetup(setup);
end
]]--

include.parameters = {
	sceneDest = 0x00, -- u8
	sceneDest2 = 0x01, -- u8 | if (value ~= 0xFF) then sceneDest |= value << 8; end
	entrance = 0x02, -- s8 | for warp function
	unk3 = 0x03, -- ?8
	unk4 = 0x00, -- ?8 or ?16
	unk5 = 0x00, -- ?8
	unk6 = 0x00, -- ?8 or ?16
	unk7 = 0x00, -- ?8
	scale = 0x08, -- u8
	rotation = 0x09, -- u8 | value << 10
	levelToUnlock = 0x0A, -- s8
	unkB = 0x0B, -- s8 | (s16)actor.data + 0x0016
	setup = 0x0C, -- s8 | to adjust scene being warped to.
	unkD = 0x0D, -- ?8
	unkE = 0x0E, -- s8 | (s16)actor.data + 0x0014
	unkF = 0x0D, -- ?8
	fadeType = 0x10, -- s8 | for warp function.
	unk11 = 0x11, -- u8 | value << 10, actor.orientation.z?
};

return include;