-- include
local GameList = require("common.gameList");
local ROMHeader = require("common.romHeader");

local private = {
	error = {},
};

function private.error.unknownGame()
	gui.addmessage("Error: Unknown Game");
	gui.addmessage("The current loaded game was not found in the supported game list.");
end

function private.error.crcMismatch(header, data)
	gui.addmessage("Error: CRC Mismatch");
	gui.addmessage(string.format("0x%08X 0x%08X -> 0x%08X 0x%08X", header[1], header[2], data[1], data[2]));
end

-- public
local public = {};

function public.get()
	local header = ROMHeader.get();
	for id, value in pairs(GameList) do
		if(id == header.id) then
			local data = GameList[id];
			data.header = header;
			if (data.support) then
				gui.addmessage(string.format("%s is supported.", data.name));
			end
			if (data.crc[1] ~= header.crc[1] or data.crc[2] ~= header.crc[2]) then
				private.error.crcMismatch(header.crc, data.crc);
			end
			return data;
		end
	end
	private.error.unknownGame();
	return nil;
end

return public;