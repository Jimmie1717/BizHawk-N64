-- Memory read/write wrapper.
local public = {
	get = {},
	set = {},
};

-- add extra data types.
function public.extend()
	local m = require(string.format("code.%s.include.memory", game.header.cartridge_id));
	for key, value in pairs(m) do
		for name, func in pairs(m[key]) do
			public[key][name] = func;
		end
	end
end

-- get
function public.get.u8(addr)
	return memory.read_u8(addr, "RDRAM");
end
function public.get.s8(addr)
	return memory.read_s8(addr, "RDRAM");
end
function public.get.u16(addr)
	return memory.read_u16_be(addr, "RDRAM");
end
function public.get.s16(addr)
	return memory.read_s16_be(addr, "RDRAM");
end
function public.get.u32(addr)
	return memory.read_u32_be(addr, "RDRAM");
end
function public.get.s32(addr)
	return memory.read_s32_be(addr, "RDRAM");
end
function public.get.f32(addr)
	return memory.readfloat(addr, true, "RDRAM");
end
function public.get.ptr(addr)
	local range = memory.read_u8(addr, "RDRAM");
	if (range ~= 0x80 and range ~= 0x81) then return nil; end
	local pointer = memory.read_u32_be(addr, "RDRAM") & 0xFFFFFF;
	if (pointer ~= 0) then return pointer; end
	return nil;
end
function public.get.string(addr, length)
	local text = "";
	if (length ~= nil) then
		for i = 0, (length - 1), 1 do
			text = text .. string.char(memory.read_u8(addr + i, "RDRAM"));
		end
	else
		local i = 0;
		repeat
			local byte = memory.read_u8(addr + i, "RDRAM");
			if (byte ~= 0) then 
				text = text .. string.char(byte);
			end
			i = i + 1;
		until (byte == 0)
	end
	return text;
end
function public.get.vec3s(addr)
	return {
		x = memory.read_s16_be(addr, "RDRAM"),
		y = memory.read_s16_be(addr + 0x02, "RDRAM"),
		z = memory.read_s16_be(addr + 0x04, "RDRAM"),
	};
end
function public.get.vec3f(addr)
	return {
		x = memory.readfloat(addr, true, "RDRAM"),
		y = memory.readfloat(addr + 0x04, true, "RDRAM"),
		z = memory.readfloat(addr + 0x08, true, "RDRAM"),
	};
end
function public.get.bit(bits, bit)
	if ((bits & (1 << bit)) >> bit == 1) then
		return true;
	end
	return false;
end

-- set
function public.set.u8(addr, value)
	memory.write_u8(addr, value, "RDRAM");
end
function public.set.s8(addr, value)
	memory.write_s8(addr, value, "RDRAM");
end
function public.set.u16(addr, value)
	memory.write_u16_be(addr, value, "RDRAM");
end
function public.set.s16(addr, value)
	memory.write_s16_be(addr, value, "RDRAM");
end
function public.set.u32(addr, value)
	memory.write_u32_be(addr, value, "RDRAM");
end
function public.set.s32(addr, value)
	memory.write_s32_be(addr, value, "RDRAM");
end
function public.set.f32(addr, value)
	memory.writefloat(addr, value, true, "RDRAM");
end
function public.set.vec3s(addr, value)
	memory.read_s16_be(addr, value.x, "RDRAM");
	memory.read_s16_be(addr + 0x02, valeu.y, "RDRAM");
	memory.read_s16_be(addr + 0x04, value.z, "RDRAM");
end
function public.set.vec3f(addr, value)
	memory.readfloat(addr, value.x, true, "RDRAM");
	memory.readfloat(addr + 0x04, value.y, true, "RDRAM");
	memory.readfloat(addr + 0x08, value.z, true, "RDRAM");
end
function public.set.bit(bits, bit)
	return bits | (1 << bit);
end

return public;