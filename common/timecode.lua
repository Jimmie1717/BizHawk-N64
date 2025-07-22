-- Convert game frame counters to timecode.

-- private
local private = {
	fps = (movie.isloaded() and movie.getfps() or 60), -- if a movie is loaded use it's fps otherwise default to 60.
};

function private.convert(frames)
	local seconds = math.floor(frames / private.fps);
	local results = {
		frames = frames,
		remainder = frames % private.fps,
		miliseconds = math.floor(((frames % private.fps) / private.fps) * 100),
		seconds = seconds % 60,
		minutes = math.floor(seconds / 60) % 60,
		hours = math.floor(seconds / 3600),
		strings = {},
	};
	results.strings.timecode = string.format("%1d:%02d:%02d %02d", results.hours, results.minutes, results.seconds, results.remainder);
	results.strings.time = string.format("%1d:%02d:%02d.%02d", results.hours, results.minutes, results.seconds, results.miliseconds);
	results.strings.time_hseg = string.format("%1d:%02d:%02d.%1d", results.hours, results.minutes, results.seconds, math.floor(results.miliseconds / 10));
	results.strings.time_m = string.format("%1d:%02d:%02d", results.hours, results.minutes, results.seconds);
	results.strings.time_seg = string.format("%02d:%02d.%1d", results.minutes, results.seconds, math.floor(results.miliseconds / 10));
	results.strings.time_seg_2 = string.format("%02d:%02d.%02d", results.minutes, results.seconds, results.miliseconds);
	results.strings.time_s = string.format("%02d.%1d", results.seconds, math.floor(results.miliseconds / 10));
	return results;
end

-- public
local public = {};

function public.get(addr)
	return private.convert(mem.get.u32(addr));
end

function public.convert(frames)
	return private.convert(frames);
end

return public;