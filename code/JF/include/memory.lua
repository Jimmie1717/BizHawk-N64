local public = {
	get = {},
	set = {},
};

-- Get a u16 rotation and convert it to degrees.
function public.get.u16_rot(addr)
	return mem.get.u16(addr) / 182.04444444444444444444444444444;
end

-- Set a rotation to a u16.
function public.set.u16_rot(addr, degrees)
	local divisor = math.floor(degrees / 360);
	if (divisor > 0) then
		-- force degrees to be in range of 0 to 359;
		degrees = degrees - (divisor * 360);
	end
	mem.set.u16(addr, math.floor(degrees * 182.04444444444444444444444444444));
end

return public;