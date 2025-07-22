-- Jet Force Gemini / Star Twins

-- include
local display = require("code.JF.display");

-- private
local private = {
	get = {},
	set = {},
};

-- public
local public = {};

-- runs every frame.
function public.main()
	display.update();
	return true;
end

-- runs once.
function public.init()
	-- add extra mem functions.
	mem.extend();
	
	display.init(string.format("%s | %s", game.name, game.header.id));
end

return public;