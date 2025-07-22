

local private = {
	files = {},
	get = {},
	set = {},
};

function private.get.mode(mode)
	local modes = {
		READ = "r",
		WRITE = "w",
		APPEND = "a",
		BINARY = "b",
	};
	return modes[mode];
end

local public = {
	get = {},
	set = {},
};

function public.create(name, path, mode);
	if (private.files[name] == nil) then
		private.files[name] = io.open(path, mode);
	end
end

return public;