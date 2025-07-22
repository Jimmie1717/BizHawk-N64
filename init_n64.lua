console.clear();

if(emu.getsystemid() ~= "N64") then
	print("System ID is not Nintendo 64.\nThese scripts are only designed to work with N64.\nExiting...");
	gui.addmessage("System ID is not N64. Exiting...");
	return;
end

-- Global
mem = require("common.memory"); -- memory wrapper.
game = require("common.boot").get(); -- read ROM header and check for it in /common/game_list.lua.

if (game and game.support) then
	-- Display the ROM Header.
	gui.addmessage(string.format("ROM Header: %s, 0x%08X 0x%08X, %s", game.header.id, game.header.crc[1], game.header.crc[2], game.header.title));
	
	-- Load game specific code and run.
	local code = require(string.format("code.%s", game.header.cartridge_id));
	code.init();
	while (code.main()) do
		emu.frameadvance();
	end
end