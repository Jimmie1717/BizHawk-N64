-- ROM Header functions.

-- private
local private = {
	get = {},
};

function private.get.clock_rate()
	return memory.read_u32_be(0x04, "ROM");
end

function private.get.program_counter()
	return memory.read_u32_be(0x08, "ROM");
end

function private.get.release_address()
	return memory.read_u32_be(0x0C, "ROM");
end

function private.get.crc()
	return {
		memory.read_u32_be(0x10, "ROM"),
		memory.read_u32_be(0x14, "ROM"),
	};
end

function private.get.title()
	local title = "";
	for i = 0, 19, 1 do
		title = title .. string.char(memory.read_u8(i + 0x20, "ROM"));
	end
	return title;
end

function private.get.media_format()
	return string.char(memory.read_u32_be(0x38, "ROM"));
end

function private.get.cartridge_id()
	return string.char(memory.read_u8(0x3C, "ROM")) .. string.char(memory.read_u8(0x3D, "ROM"));
end

function private.get.country_code()
	return string.char(memory.read_u8(0x3E, "ROM"));
end

function private.get.version()
	return memory.read_u8(0x3F, "ROM");
end

function private.get.id()
	return string.format("%s%s%s%d", private.get.media_format(), private.get.cartridge_id(), private.get.country_code(), private.get.version());
end

-- public
local public = {};

function public.get()
	return {
		clock_rate = private.get.clock_rate(),
		program_counter = private.get.program_counter(),
		release_address = private.get.release_address(),
		crc = private.get.crc(),
		title = private.get.title(),
		media_format = private.get.media_format(),
		cartridge_id = private.get.cartridge_id(),
		country_code = private.get.country_code(),
		version = private.get.version(),
		id = private.get.id(),
	};
end

return public;