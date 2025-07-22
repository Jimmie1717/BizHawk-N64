-- private
local private = {
	get = {},
	set = {},
	
	index = -1,
	
	window = nil,
	canvas = nil,
	
	label = {},
	dropdown = {},
	button = {},
	checkbox = {},
	textbox = {},
	
	sizes = {
		padding = 5,
		width = {
			deg = 49,
			u4 = 20, -- 2d
			u8 = 28, -- 3d
			s8 = 34, -- 4
			h8 = 34, -- 4
			s16 = 49, -- 6
			u16 = 49, -- 6
			h16 = 49, -- 6
			s32 = 77, -- 10
			u32 = 77, -- 10
			h32 = 77, -- 10
			f16 = 49, -- 6
			f32 = 77, -- 10
			label = 77, -- 10
			time = 77,
			string = (77 * 3) + (5 * 2), -- full + padding
		},
		height = 20,
	},
	formats = {
		deg = "% 6.2f",
		u8 = "% 3d",
		s8 = "% 4d",
		h8 = "0x%02X",
		s16 = "% 6d",
		u16 = "% 6d",
		h16 = "0x%04X",
		s32 = "% 10d",
		u32 = "% 10d",
		h32 = "0x%08X",
		f16 = "% 6.1f",
		f32 = "% 10.2f",
		time = "%s",
		string = "%s",
	}
};

-- public
local public = {
	get = {},
	set = {},
	
	create = {},
	label = {},
	dropdown = {},
	button = {},
	checkbox = {},
	textbox = {},
};

function public.get.padding()
	return private.sizes.padding;
end

function public.get.width(type)
	local s = private.sizes.width[type];
	if (s ~= nil) then
		return s;
	end
	return 0;
end

function public.get.height()
	return private.sizes.height;
end

function public.get.format(type)
	local f = private.formats[type];
	if (f ~= nil) then
		return f;
	end
	return "";
end

function public.labelSize(text)
	return (string.len(text) * 7) + 8;
end

-- create a form window.
function public.create.window(size, title)
	private.index = private.index + 1;
	if (private.window == nil) then
		private.window = forms.newform(size.width, size.height, title);
		return private.index;
	else
		return nil;
	end
end

-- create a canvas to draw on.
function public.create.canvas(pos, size)
	if (private.canvas == nil) then
		private.canvas = forms.pictureBox(private.window, pos.x, pos.y, size.width, size.height);
		return true;
	else
		return false;
	end
end

-- create a section with a border around it with a title.
function public.create.section(name, title, pos, size, color)
	if (private.label[string.format("%s-border", name)] == nil) then
		private.label[string.format("%s-title", name)] = forms.label(private.window, title, pos.x + private.sizes.padding, pos.y - 7, public.labelSize(title), 14);
		private.label[string.format("%s-border", name)] = forms.label(private.window, "", pos.x, pos.y, size.width, size.height);
		forms.setproperty(private.label[string.format("%s-title", name)], "TextAlign", "MiddleLeft");
		forms.setproperty(private.label[string.format("%s-border", name)], "BorderStyle", "FixedSingle");
		if (color ~= nil) then forms.setproperty(private.label[string.format("%s-border", name)], "BackColor", color); end
	end
end

function public.create.label(name, text, pos, size)
	if (private.label[name] == nil) then
		if (size == nil) then
			size = public.get.width("label");
		elseif (type(size) == "string") then
			size = public.get.width(size);
		end
		private.label[name] = forms.label(private.window, text, pos.x, pos.y, size, private.sizes.height);
		-- default to MiddleLeft align.
		forms.setproperty(private.label[name], "TextAlign", "MiddleLeft");
		public.label[name] = {
			set = {
				text = function (text) forms.setproperty(private.label[name], "Text", text); end,
				align = function(align) forms.setproperty(private.label[name], "TextAlign", string.format("Middle%s", align:gsub("^%l", string.upper))); end,
				foreColor = function (color) forms.setproperty(private.label[name], "ForeColor", color); end,
				backColor = function (color) forms.setproperty(private.label[name], "BackColor", color); end,
			},
		};
	end
end

function public.create.checkbox(name, text, pos)
	if (private.checkbox[name] == nil) then
		private.checkbox[name] = forms.checkbox(private.window, text, pos.x, pos.y);
		public.checkbox[name] = {
			set = function (state)
				if(type(state) ~= "boolean") then
					return;
				elseif (state) then
					forms.setproperty(private.checkbox[name], "Checked", true);
				else
					forms.setproperty(private.checkbox[name], "Checked", false);
				end
			end,
			get = function ()
				return forms.getproperty(private.checkbox[name], "Checked");
			end
		};
	end
end

function public.create.button(name, text, pos, size, func)
	if (private.button[name] == nil) then
		private.button[name] = forms.button(private.window, text, func, pos.x, pos.y, size.width, private.sizes.height + 2);
	end
end

function public.create.textbox(name, text, pos, width, textFormat)
	-- textFormat = {nil, "HEX", "SIGNED", "UNSIGNED"}
	if (private.textbox[name] == nil) then
		local format = "string";
		if (type(width) == "string") then
			format = width;
			width = public.get.width(width);
		end
		private.textbox[name] = forms.textbox(private.window, text, width, public.get.height(), textFormat, pos.x, pos.y, false, true, nil);	
		public.textbox[name] = {
			set = {
				text = function (text)
					if (text == nil) then
						forms.setproperty(private.textbox[name], "Text", "");
					else
						forms.setproperty(private.textbox[name], "Text", string.format(public.get.format(format), text));
					end
				end,
				foreColor = function (color) forms.setproperty(private.textbox[name], "ForeColor", color); end,
				backColor = function (color) forms.setproperty(private.textbox[name], "BackColor", color); end,
			},
			get = {
				text = function ()
					return forms.getproperty(private.textbox[name], "Text");
				end,
				number = function ()
					if (format == "s8" or format == "s16" or format == "s32" or format == "u8" or format == "u16" or format == "u32") then
						return tonumber(forms.getproperty(private.textbox[name], "Text"));
					end
					return nil;
				end,
			},
		};
	end
end

function public.create.dropdown(name, list, pos, size)
	-- {"a", "b", ...}
	if (private.dropdown[name] == nil) then
		private.dropdown[name] = forms.dropdown(private.window, list, pos.x, pos.y, size.width, private.sizes.height);
		public.dropdown[name] = {
			get = {
				index = function () return tonumber(forms.getproperty(private.dropdown[name], "SelectedIndex")); end,
				item = function () return forms.getproperty(private.dropdown[name], "SelectedItem"); end,
			},
		};
	end
end




-- refresh the canvas.
function public.refresh()
	forms.refresh(private.canvas);
end

function public.rect(pos, size, color)
	if (private.canvas ~= nil) then
		forms.drawRectangle(private.canvas, pos.x, pos.y, size.width, size.height, color, color);
	else
		return false;
	end
end

-- add an image to the the window canvas.
function public.image(path, pos, size)
	if (private.canvas ~= nil and path ~= nil) then
		if (size ~= nil) then
			forms.drawImage(private.canvas, path, pos.x, pos.y, size.width, size.height);
		else
			forms.drawImage(private.canvas, path, pos.x, pos.y);
		end
		return true;
	else
		return false;
	end
end

-- add a sprite from an image to the the window canvas.
function public.sprite(path, source, dest)
	if (private.canvas ~= nil and path ~= nil) then
		forms.drawImageRegion(private.canvas, path, source.x, source.y, source.width, source.height, dest.x, dest.y, dest.width, dest.height);
		return true;
	else
		return false;
	end
end

return public;