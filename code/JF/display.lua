-- include
local Window = require("common.window");
local Color = require("common.color");
local Timecode = require("common.timecode");
local Play = require("code.JF.play");
local Race = require("code.JF.race");
local Save = require("code.JF.save");
local Weapon = require("code.JF.include.weapon");
local Actor = require("code.JF.actor.actor");
local Player = require("code.JF.actor.player");
local Floyd = require("code.JF.actor.floyd");
local Enemy = require("code.JF.actor.enemy");
local Grenade = require("code.JF.actor.grenade");

local realTime = {
	START = 0,
	END = 0,
	TIME = 0,
};
local tasTime = {
	START = 0,
	END = 0,
	TIME = 0,
};

-- private
local private = {
	regionExit = false,
	lastTarget = nil,
	calc = {},
};

function private.calc.x(start, type, index)
	return start + Window.get.width("label") + (Window.get.width(type) * index) + (Window.get.padding() * (index + 2));
end

function private.calc.y(start, index)
	return start + (Window.get.padding() * (2 + index)) + (Window.get.height() * index);
end

function private.checkRegionTribals()
	console.clear();
	local regions = Save.get.region.clearedAll();
	for i = 0, #regions, 1 do
		print(string.format("[%s] %s", (regions[i].cleared and "X" or " "), regions[i].name));
	end
end
	
-- public
local public = {};

function public.init(title)

	local main = {
		width = (Window.get.width("h32") * 4) + (Window.get.padding() * 7),
		height = (Window.get.height() * 23) + (Window.get.padding() * 43),
		window = {
			padding = Window.get.padding(),
			height = Window.get.height(),
		},
	};
	Window.create.window({width = main.width, height = main.height}, title);
	
	local game = {
		x = main.window.padding,
		y = main.window.padding,
		width = main.width - (main.window.padding * 2),
		height = (main.window.height * 4) + (main.window.padding * 6),
	};
	Window.create.textbox("rng-seed-value", "0x00000000", {x = private.calc.x(game.x, "h32", 0), y = private.calc.y(game.y, 0)}, "h32");
	Window.create.label("rng-seed-title", "RNG Seed:", {x = game.x + main.window.padding, y = private.calc.y(game.y, 0)});
	Window.create.textbox("game-time-value", "0:00:00.00", {x = private.calc.x(game.x, "time", 0), y = private.calc.y(game.y, 1)}, "time");
	Window.create.label("game-time-title", "In-game Time:", {x = game.x + main.window.padding, y = private.calc.y(game.y, 1)});
	Window.create.button("tribals-check-button", "Check Tribals", {x = private.calc.x(game.x, "f32", 1), y = private.calc.y(game.y, 0)}, {width = 104}, private.checkRegionTribals);
	Window.create.checkbox("tribals-all-checkbox", "All Rescued?", {x = private.calc.x(game.x, "f32", 1), y = private.calc.y(game.y, 1)});
	Window.create.textbox("real-time-value", "0:00:00.00", {x = private.calc.x(game.x, "time", 0), y = private.calc.y(game.y, 2)}, "time");
	Window.create.textbox("real-time-start", realTime.START, {x = private.calc.x(game.x, "u32", 1), y = private.calc.y(game.y, 2)}, "u32");
	Window.create.textbox("real-time-end", realTime.END, {x = private.calc.x(game.x, "u32", 2), y = private.calc.y(game.y, 2)}, "u32");
	Window.create.label("real-time-title", "Real Time:", {x = game.x + main.window.padding, y = private.calc.y(game.y, 2)});
	Window.create.textbox("tas-time-value", "0:00:00.00", {x = private.calc.x(game.x, "time", 0), y = private.calc.y(game.y, 3)}, "time");
	Window.create.textbox("tas-time-start", tasTime.START, {x = private.calc.x(game.x, "u32", 1), y = private.calc.y(game.y, 3)}, "u32");
	Window.create.textbox("tas-time-end", tasTime.END, {x = private.calc.x(game.x, "u32", 2), y = private.calc.y(game.y, 3)}, "u32");
	Window.create.label("tas-time-title", "TAS Time:", {x = game.x + main.window.padding, y = private.calc.y(game.y, 3)});
	Window.create.section("game", "Game", {x = game.x, y = game.y}, {width = game.width, height = game.height}, nil);
	
	local region = {
		x = main.window.padding,
		y = game.y + game.height + (main.window.padding * 2),
		width = main.width - (main.window.padding * 2),
		height = (main.window.height * 4) + (main.window.padding * 6),
	};
	Window.create.textbox("region-name-value", "", {x = private.calc.x(region.x, "string", 0), y = private.calc.y(region.y, 0)}, "string");
	Window.create.label("region-name-title", "Name:", {x = region.x + main.window.padding, y = private.calc.y(region.y, 0)});
	Window.create.textbox("region-time-value", "", {x = private.calc.x(region.x, "time", 0), y = private.calc.y(region.y, 1)}, "time");
	Window.create.textbox("region-race-time-value", "", {x = private.calc.x(region.x, "time", 1), y = private.calc.y(region.y, 1)}, "time");
	Window.create.label("region-time-title", "Time:", {x = region.x + main.window.padding, y = private.calc.y(region.y, 1)});
	Window.create.textbox("region-continue-value", "", {x = private.calc.x(region.x, "u8", 0), y = private.calc.y(region.y, 2)}, "u8");
	Window.create.label("region-continue-title", "Continues:", {x = region.x + main.window.padding, y = private.calc.y(region.y, 2)});
	--Window.textbox["region-time-value"].set.bgcolor("#FFFFC0");
	Window.create.textbox("tribals-rescued-value", "", {x = private.calc.x(region.x, "u8", 0), y = private.calc.y(region.y, 3)}, "u8");
	Window.create.textbox("tribals-killed-value", "", {x = private.calc.x(region.x, "u8", 1), y = private.calc.y(region.y, 3)}, "u8");
	Window.create.textbox("tribals-remaining-value", "", {x = private.calc.x(region.x, "u8", 2), y = private.calc.y(region.y, 3)}, "u8");
	Window.create.label("tribals-title", "Tribals:", {x = region.x + main.window.padding, y = private.calc.y(region.y, 3)});
	Window.textbox["tribals-rescued-value"].set.backColor(Color.GREEN);
	Window.textbox["tribals-killed-value"].set.backColor(Color.RED);
	Window.textbox["tribals-remaining-value"].set.backColor(Color.LIGHT_BLUE);
	Window.create.section("region", "Region", {x = region.x, y = region.y}, {width = region.width, height = region.height}, nil);
	
	local player = {
		x = main.window.padding,
		y = region.y + region.height + (main.window.padding * 2),
		width = main.width - (main.window.padding * 2),
		height = (main.window.height * 7) + (main.window.padding * 9),
	};
	Window.create.textbox("health-value", "", {x = private.calc.x(player.x, "u16", 0), y = private.calc.y(player.y, 0)}, "s16");
	Window.create.textbox("jetfuel-value", "", {x = private.calc.x(player.x, "u16", 2), y = private.calc.y(player.y, 0)}, "u16");
	Window.create.textbox("model-value", "", {x = private.calc.x(player.x, "s16", 3), y = private.calc.y(player.y, 0)}, "time");
	Window.create.label("jetfuel-title", "Jet Fuel:", {x = private.calc.x(player.x, "u16", 1), y = private.calc.y(player.y, 0)}, "u16");
	Window.label["jetfuel-title"].set.align("right");
	Window.create.label("health-title", "Health:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 0)});
	Window.create.textbox("ammo-pistol-value", "", {x = private.calc.x(player.x, "u16", 0), y = private.calc.y(player.y, 1)}, "u16");
	Window.create.textbox("ammo-homing-value", "", {x = private.calc.x(player.x, "u16", 1), y = private.calc.y(player.y, 1)}, "u16");
	Window.create.textbox("ammo-machine-value", "", {x = private.calc.x(player.x, "u16", 2), y = private.calc.y(player.y, 1)}, "u16");
	Window.create.textbox("ammo-tri-value", "", {x = private.calc.x(player.x, "u16", 3), y = private.calc.y(player.y, 1)}, "u16");
	Window.textbox["ammo-pistol-value"].set.backColor(Color.LIGHT_BLUE);
	Window.textbox["ammo-homing-value"].set.backColor(Color.GRAY);
	Window.textbox["ammo-machine-value"].set.backColor(Color.BLUE);
	Window.textbox["ammo-tri-value"].set.backColor(Color.RED);
	Window.create.label("ammo-title", "Ammo:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 1)});
	Window.create.textbox("capacity-pistol-value", "", {x = private.calc.x(player.x, "u16", 0), y = private.calc.y(player.y, 2)}, "u16");
	Window.create.textbox("capacity-homing-value", "", {x = private.calc.x(player.x, "u16", 1), y = private.calc.y(player.y, 2)}, "u16");
	Window.create.textbox("capacity-machine-value", "", {x = private.calc.x(player.x, "u16", 2), y = private.calc.y(player.y, 2)}, "u16");
	Window.create.textbox("capacity-tri-value", "", {x = private.calc.x(player.x, "u16", 3), y = private.calc.y(player.y, 2)}, "u16");
	Window.textbox["capacity-pistol-value"].set.backColor(Color.LIGHT_BLUE);
	Window.textbox["capacity-homing-value"].set.backColor(Color.GRAY);
	Window.textbox["capacity-machine-value"].set.backColor(Color.BLUE);
	Window.textbox["capacity-tri-value"].set.backColor(Color.RED);
	Window.create.label("capacity-title", "Capacity:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 2)});
	Window.create.textbox("rotation-x-value", "", {x = private.calc.x(player.x, "deg", 0), y = private.calc.y(player.y, 3)}, "deg");
	Window.create.textbox("rotation-y-value", "", {x = private.calc.x(player.x, "deg", 1), y = private.calc.y(player.y, 3)}, "deg");
	Window.create.textbox("tokens-value", "", {x = private.calc.x(player.x, "u16", 3), y = private.calc.y(player.y, 3)}, "u16");
	Window.textbox["tokens-value"].set.backColor(Color.LIGHT_GRAY);
	Window.create.label("rotation-title", "Rotation:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 3)});
	Window.create.textbox("position-x-value", "", {x = private.calc.x(player.x, "f32", 0), y = private.calc.y(player.y, 4)}, "f32");
	Window.create.textbox("position-y-value", "", {x = private.calc.x(player.x, "f32", 1), y = private.calc.y(player.y, 4)}, "f32");
	Window.create.textbox("position-z-value", "", {x = private.calc.x(player.x, "f32", 2), y = private.calc.y(player.y, 4)}, "f32");
	Window.create.label("position-title", "Position:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 4)});
	Window.create.textbox("velocity-x-value", "", {x = private.calc.x(player.x, "f32", 0), y = private.calc.y(player.y, 5)}, "f32");
	Window.create.textbox("velocity-y-value", "", {x = private.calc.x(player.x, "f32", 1), y = private.calc.y(player.y, 5)}, "f32");
	Window.create.textbox("velocity-z-value", "", {x = private.calc.x(player.x, "f32", 2), y = private.calc.y(player.y, 5)}, "f32");
	Window.create.label("velocity-title", "Velocity:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 5)});
	Window.create.textbox("anim-timer-value", "", {x = private.calc.x(player.x, "f32", 0), y = private.calc.y(player.y, 6)}, "f32");
	Window.create.textbox("anim-id-value", "", {x = private.calc.x(player.x, "f32", 1), y = private.calc.y(player.y, 6)}, "u8");
	Window.create.label("anim-title", "Animation:", {x = player.x + main.window.padding, y = private.calc.y(player.y, 6)});
	Window.create.section("player", "Player", {x = player.x, y = player.y}, {width = player.width, height = player.height}, nil);
	
	local target = {
		x = main.window.padding,
		y = player.y + player.height + (main.window.padding * 2),
		width = main.width - (main.window.padding * 2),
		height = (main.window.height * 5) + (main.window.padding * 7),
	};
	Window.create.textbox("target-name", "", {x = private.calc.x(target.x, "string", 0), y = private.calc.y(target.y, 0)}, "string");
	Window.create.label("target-title", "Name:", {x = target.x + main.window.padding, y = private.calc.y(target.y, 0)});
	Window.create.textbox("target-rotation-value", "", {x = private.calc.x(target.x, "f32", 0), y = private.calc.y(target.y, 1)}, "deg");
	Window.create.textbox("target-health-value", "", {x = private.calc.x(target.x, "f32", 1), y = private.calc.y(target.y, 1)}, "s16");
	Window.create.label("target-rotation-title", "Rotation:", {x = target.x + main.window.padding, y = private.calc.y(target.y, 1)});
	Window.create.textbox("target-position-x-value", "", {x = private.calc.x(target.x, "f32", 0), y = private.calc.y(target.y, 2)}, "f32");
	Window.create.textbox("target-position-y-value", "", {x = private.calc.x(target.x, "f32", 1), y = private.calc.y(target.y, 2)}, "f32");
	Window.create.textbox("target-position-z-value", "", {x = private.calc.x(target.x, "f32", 2), y = private.calc.y(target.y, 2)}, "f32");
	Window.create.label("target-position-title", "Position:", {x = target.x + main.window.padding, y = private.calc.y(target.y, 2)});
	Window.create.textbox("target-velocity-x-value", "", {x = private.calc.x(target.x, "f32", 0), y = private.calc.y(target.y, 3)}, "f32");
	Window.create.textbox("target-velocity-y-value", "", {x = private.calc.x(target.x, "f32", 1), y = private.calc.y(target.y, 3)}, "f32");
	Window.create.textbox("target-velocity-z-value", "", {x = private.calc.x(target.x, "f32", 2), y = private.calc.y(target.y, 3)}, "f32");
	Window.create.label("target-velocity-title", "Velocity:", {x = target.x + main.window.padding, y = private.calc.y(target.y, 3)});
	Window.create.textbox("target-anim-timer-value", "", {x = private.calc.x(target.x, "f32", 0), y = private.calc.y(target.y, 4)}, "f32");
	Window.create.textbox("target-anim-id-value", "", {x = private.calc.x(target.x, "f32", 1), y = private.calc.y(target.y, 4)}, "u8");
	Window.create.label("target-anim-title", "Animation:", {x = target.x + main.window.padding, y = private.calc.y(target.y, 4)});
	Window.create.section("target", "Target", {x = target.x, y = target.y}, {width = target.width, height = target.height}, nil);
	
	local quarry = {
		x = main.window.padding,
		y = target.y + target.height + (main.window.padding * 2),
		width = main.width - (main.window.padding * 2),
		height = (main.window.height * 3) + (main.window.padding * 5),
	};
	Window.create.textbox("quarry-rotation-value", "", {x = private.calc.x(quarry.x, "s16", 0), y = private.calc.y(quarry.y, 0)}, "deg");
	Window.create.textbox("quarry-gem-value", "", {x = private.calc.x(quarry.x, "s16", 2), y = private.calc.y(quarry.y, 0)}, "s16");
	Window.create.textbox("quarry-power-value", "", {x = private.calc.x(quarry.x, "s16", 3), y = private.calc.y(quarry.y, 0)}, "s16");
	Window.create.label("quarry-power-title", "Power:", {x = private.calc.x(quarry.x, "s16", 1), y = private.calc.y(quarry.y, 0)}, "s16");
	Window.label["quarry-power-title"].set.align("right");
	Window.create.label("quarry-tank-title", "Tank:", {x = quarry.x + main.window.padding, y = private.calc.y(quarry.y, 0)});
	Window.create.textbox("quarry-gem-0-value", "", {x = private.calc.x(quarry.x, "s16", 0), y = private.calc.y(quarry.y, 1)}, "s16");
	Window.create.textbox("quarry-gem-1-value", "", {x = private.calc.x(quarry.x, "s16", 1), y = private.calc.y(quarry.y, 1)}, "s16");
	Window.create.textbox("quarry-gem-2-value", "", {x = private.calc.x(quarry.x, "s16", 2), y = private.calc.y(quarry.y, 1)}, "s16");
	Window.create.textbox("quarry-gem-3-value", "", {x = private.calc.x(quarry.x, "s16", 3), y = private.calc.y(quarry.y, 1)}, "s16");
	Window.create.textbox("quarry-gem-4-value", "", {x = private.calc.x(quarry.x, "s16", 0), y = private.calc.y(quarry.y, 2)}, "s16");
	Window.create.textbox("quarry-gem-5-value", "", {x = private.calc.x(quarry.x, "s16", 1), y = private.calc.y(quarry.y, 2)}, "s16");
	Window.create.textbox("quarry-gem-6-value", "", {x = private.calc.x(quarry.x, "s16", 2), y = private.calc.y(quarry.y, 2)}, "s16");
	Window.create.textbox("quarry-gem-7-value", "", {x = private.calc.x(quarry.x, "s16", 3), y = private.calc.y(quarry.y, 2)}, "s16");
	Window.create.label("quarry-gem-title", "Gems:", {x = quarry.x + main.window.padding, y = private.calc.y(quarry.y, 1)});
	Window.create.section("quarry", "Quarry", {x = quarry.x, y = quarry.y}, {width = quarry.width, height = quarry.height}, nil);

end

function public.update()
	local input = input.get();
	local currentScene = Play.get.currentScene();

	-- clear the last target on a load screen.
	if (Play.get.loading() ~= 0) then
		private.lastTarget = nil;
	end
	
	-- warn on region exit if any tribals are killed/not rescued.
	if (private.regionExit == false and Play.get.regionExit() == true) then
		private.regionExit = true;
		if (Save.get.tribals.killed() ~= 0) then
			gui.addmessage(string.format("Exiting region with %d Tribals killed!", Save.get.tribals.killed()));
		elseif (Save.get.tribals.remaining() ~= 0) then
			gui.addmessage(string.format("Exiting region with %d Tribals remaining!", Save.get.tribals.remaining()));
		end
	elseif (private.regionExit == true and Play.get.regionExit() == false) then
		private.regionExit = false;
	end
	
	-- game
	Window.textbox["rng-seed-value"].set.text(Play.get.rngSeed());
	Window.textbox["game-time-value"].set.text(Timecode.convert(Save.get.frames()).strings.time);
	
	realTime.TIME = emu.framecount() - Window.textbox["real-time-start"].get.number();
	if (realTime.TIME >= 0 and emu.framecount() <= Window.textbox["real-time-end"].get.number()) then
		Window.textbox["real-time-value"].set.text(Timecode.convert(realTime.TIME).strings.time);
	end
	tasTime.TIME = emu.framecount() - Window.textbox["tas-time-start"].get.number();
	if (tasTime.TIME >= 0 and emu.framecount() <= Window.textbox["tas-time-end"].get.number()) then
		Window.textbox["tas-time-value"].set.text(Timecode.convert(tasTime.TIME).strings.time);
	end
	
	-- region
	Window.textbox["region-time-value"].set.text(Timecode.convert(Save.get.region.frames()).strings.time);
	Window.textbox["region-continue-value"].set.text(Play.get.continues());
	if (Play.get.continues() == 0) then
		Window.textbox["region-continue-value"].set.backColor(Color.RED);
	else
		Window.textbox["region-continue-value"].set.backColor(Color.WHITE);
	end
	Window.textbox["region-name-value"].set.text(Play.get.region());
	Window.checkbox["tribals-all-checkbox"].set(Save.get.flags.game(Save.flags.gameFlags.ALL_TRIBALS_RESCUED));
	
	-- Mizar's Palace race timer.
	if (currentScene == Play.scenes.PALACE_RACE) then
		Window.textbox["region-race-time-value"].set.text(Race.get.player.time(0));
	else
		Window.textbox["region-race-time-value"].set.text();
	end
	
	-- tribals
	Window.textbox["tribals-rescued-value"].set.text(Save.get.tribals.rescued());
	Window.textbox["tribals-killed-value"].set.text(Save.get.tribals.killed());
	Window.textbox["tribals-remaining-value"].set.text(Save.get.tribals.remaining());
	
	-- player
	local player = Player.get.actor();
	if (player ~= nil) then
	
		Window.textbox["rotation-x-value"].set.text(player.rotation.x);
		Window.textbox["rotation-y-value"].set.text(player.rotation.y);
		Window.textbox["position-x-value"].set.text(player.position.x);
		Window.textbox["position-y-value"].set.text(player.position.y);
		Window.textbox["position-z-value"].set.text(player.position.z);
		Window.textbox["velocity-x-value"].set.text(player.velocity.x);
		Window.textbox["velocity-y-value"].set.text(player.velocity.y);
		Window.textbox["velocity-z-value"].set.text(player.velocity.z);
		Window.textbox["anim-timer-value"].set.text(player.animationTimer);
		Window.textbox["anim-id-value"].set.text(player.animationId);
		
		if (player.velocity.y > 10) then
			Window.textbox["velocity-y-value"].set.backColor(Color.GREEN);
		else
			Window.textbox["velocity-y-value"].set.backColor(Color.WHITE);
		end
		
		if (player.unk4C ~= nil) then
			local health = math.floor(player.unk4C.health / 256);
			Window.textbox["health-value"].set.text(health);
			if (health <= 6) then
				Window.textbox["health-value"].set.backColor(Color.RED);
			else
				Window.textbox["health-value"].set.backColor(Color.WHITE);
			end
		end
		
		
		if (player.data ~= nil) then
			
			local characterData = Save.get.characterData(player.data.characterType & 0x3);
			
			Window.textbox["model-value"].set.text(Save.get.characterModelName(player.data.characterType & 0x3, characterData.charInfo.model));
			
			if (player.data.characterType > 3) then
				Window.textbox["jetfuel-value"].set.text(player.data.jetFuel);
			else
				Window.textbox["jetfuel-value"].set.text();
			end
		
			if (characterData.weapons[Weapon.weapons.PISTOL] == true) then
				Window.textbox["ammo-pistol-value"].set.text(characterData.weaponAmmo[Weapon.weapons.PISTOL]);
				Window.textbox["capacity-pistol-value"].set.text(characterData.weaponCapacity[Weapon.weapons.PISTOL]);
			else
				Window.textbox["ammo-pistol-value"].set.text();
				Window.textbox["capacity-pistol-value"].set.text();
			end
			if (characterData.weapons[Weapon.weapons.HOMING_MISSILE_LAUNCHER] == true) then
				Window.textbox["ammo-homing-value"].set.text(characterData.weaponAmmo[Weapon.weapons.HOMING_MISSILE_LAUNCHER]);
				Window.textbox["capacity-homing-value"].set.text(characterData.weaponCapacity[Weapon.weapons.HOMING_MISSILE_LAUNCHER]);
			else
				Window.textbox["ammo-homing-value"].set.text();
				Window.textbox["capacity-homing-value"].set.text();
			end
			if (characterData.weapons[Weapon.weapons.MACHINE_GUN] == true) then
				Window.textbox["ammo-machine-value"].set.text(characterData.weaponAmmo[Weapon.weapons.MACHINE_GUN]);
				Window.textbox["capacity-machine-value"].set.text(characterData.weaponCapacity[Weapon.weapons.MACHINE_GUN]);
			else
				Window.textbox["ammo-machine-value"].set.text();
				Window.textbox["capacity-machine-value"].set.text();
			end
			if (characterData.weapons[Weapon.weapons.TRI_ROCKET_LAUNCHER] == true) then
				Window.textbox["ammo-tri-value"].set.text(characterData.weaponAmmo[Weapon.weapons.TRI_ROCKET_LAUNCHER]);
				Window.textbox["capacity-tri-value"].set.text(characterData.weaponCapacity[Weapon.weapons.TRI_ROCKET_LAUNCHER]);
			else
				Window.textbox["ammo-tri-value"].set.text();
				Window.textbox["capacity-tri-value"].set.text();
			end
			Window.textbox["tokens-value"].set.text(characterData.mizarTokens);
			
			-- update last targeted enemy.
			if (player.data.reticleTarget ~= nil) then
				private.lastTarget = player.data.reticleTarget.address;
			end
			-- display the last targeted enemy.
			if (private.lastTarget ~= nil) then
				local target = Enemy.get.byAddress(private.lastTarget);
				if (target.name ~= nil) then
					Window.textbox["target-name"].set.text(target.name);
				end
				Window.textbox["target-rotation-value"].set.text(target.rotation.y);
				
				if (target.unk4C ~= nil) then
					local health = math.floor(target.unk4C.health / 256);
					Window.textbox["target-health-value"].set.text(health);
					if (health <= 4) then
						Window.textbox["target-health-value"].set.backColor(Color.RED);
					else
						Window.textbox["target-health-value"].set.backColor(Color.WHITE);
					end
				end
		
				Window.textbox["target-position-x-value"].set.text(target.position.x);
				Window.textbox["target-position-y-value"].set.text(target.position.y);
				Window.textbox["target-position-z-value"].set.text(target.position.z);
				Window.textbox["target-velocity-x-value"].set.text(target.velocity.x);
				Window.textbox["target-velocity-y-value"].set.text(target.velocity.y);
				Window.textbox["target-velocity-z-value"].set.text(target.velocity.z);
				Window.textbox["target-anim-timer-value"].set.text(target.animationTimer);
				Window.textbox["target-anim-id-value"].set.text(target.animationId);
				
				if (target.data ~= nil) then
					-- if the target has died clear it.
					if (target.data.flags.DEAD == true) then
						private.lastTarget = nil;
						if (target.name ~= nil) then
							gui.addmessage(string.format("%s has died.", target.name));
						else
							gui.addmessage("Target has died.");
						end
					end
				end
			else
				Window.textbox["target-name"].set.text("");
				Window.textbox["target-rotation-value"].set.text();
				Window.textbox["target-health-value"].set.text();
				Window.textbox["target-position-x-value"].set.text();
				Window.textbox["target-position-y-value"].set.text();
				Window.textbox["target-position-z-value"].set.text();
				Window.textbox["target-velocity-x-value"].set.text();
				Window.textbox["target-velocity-y-value"].set.text();
				Window.textbox["target-velocity-z-value"].set.text();
				Window.textbox["target-anim-timer-value"].set.text();
				Window.textbox["target-anim-id-value"].set.text();
				Window.textbox["target-health-value"].set.backColor(Color.WHITE);
			end
			
			-- floyd
			local floyd = Floyd.get.actor();
			if (Play.get.inRobotMission() and
				(currentScene == Play.scenes.SS_ANUBIS_ROBOT or
				currentScene == Play.scenes.PALACE_COURTYARD or
				currentScene == Play.scenes.ASTEROID_FISSURE)) then
				Window.textbox["region-race-time-value"].set.text(Play.get.robotMissionTime());
				if (floyd ~= nil) then
					Window.textbox["rotation-x-value"].set.text(floyd.rotation.x);
					Window.textbox["rotation-y-value"].set.text(floyd.rotation.y);
					Window.textbox["position-x-value"].set.text(floyd.position.x);
					Window.textbox["position-y-value"].set.text(floyd.position.y);
					Window.textbox["position-z-value"].set.text(floyd.position.z);
					Window.textbox["velocity-x-value"].set.text(floyd.velocity.x);
					Window.textbox["velocity-y-value"].set.text(floyd.velocity.y);
					Window.textbox["velocity-z-value"].set.text(floyd.velocity.z);
					Window.textbox["anim-timer-value"].set.text();
					Window.textbox["anim-id-value"].set.text();
				end
			end
			
			-- Gem Quarry Generator / Gems
			if (currentScene == Play.scenes.GEM_QUARRY_QUARRY) then
				-- Tank
				local tank = Actor.get.byName("Hoovertank")[0];
				if (tank ~= nil) then
					Window.textbox["quarry-rotation-value"].set.text(tank.rotation.y);
					if (tank.data ~= nil) then
						local gem, power = mem.get.s16(tank.data + 0x02), mem.get.s16(tank.data + 0x28);
						Window.textbox["quarry-gem-value"].set.text(gem);
						if (gem / 6000 < 0.25) then
							Window.textbox["quarry-gem-value"].set.backColor(Color.RED);
						elseif (gem / 6000 < 0.5) then
							Window.textbox["quarry-gem-value"].set.backColor(Color.ORANGE);
						elseif (gem / 6000 < 0.75) then
							Window.textbox["quarry-gem-value"].set.backColor(Color.YELLOW);
						elseif (gem / 6000 < 0.875) then
							Window.textbox["quarry-gem-value"].set.backColor(Color.LIME);
						else
							Window.textbox["quarry-gem-value"].set.backColor(Color.GREEN);
						end
						Window.textbox["quarry-power-value"].set.text(power);
						if (power / 6000 < 0.25) then
							Window.textbox["quarry-power-value"].set.backColor(Color.RED);
						elseif (power / 6000 < 0.5) then
							Window.textbox["quarry-power-value"].set.backColor(Color.ORANGE);
						elseif (power / 6000 < 0.75) then
							Window.textbox["quarry-power-value"].set.backColor(Color.YELLOW);
						elseif (power / 6000 < 0.875) then
							Window.textbox["quarry-power-value"].set.backColor(Color.LIME);
						else
							Window.textbox["quarry-power-value"].set.backColor(Color.GREEN);
						end
					end
				end
				-- Gems (up to 8 at once)
				local gems = Actor.get.byName("HooverGem");
				for i = 0, 7, 1 do
					if (gems[i] ~= nil) then
						Window.textbox[string.format("quarry-gem-%d-value", i)].set.text(mem.get.u32(gems[i].address + 0x88));
					else
						Window.textbox[string.format("quarry-gem-%d-value", i)].set.text(0);
					end
				end
			else
				Window.textbox["quarry-rotation-value"].set.text();
				Window.textbox["quarry-gem-value"].set.text();
				Window.textbox["quarry-gem-value"].set.backColor(Color.WHITE);
				Window.textbox["quarry-power-value"].set.text();
				Window.textbox["quarry-power-value"].set.backColor(Color.WHITE);
				Window.textbox["quarry-gem-0-value"].set.text();
				Window.textbox["quarry-gem-1-value"].set.text();
				Window.textbox["quarry-gem-2-value"].set.text();
				Window.textbox["quarry-gem-3-value"].set.text();
				Window.textbox["quarry-gem-4-value"].set.text();
				Window.textbox["quarry-gem-5-value"].set.text();
				Window.textbox["quarry-gem-6-value"].set.text();
				Window.textbox["quarry-gem-7-value"].set.text();
			end
			
			local nade = Grenade.get.actor();
			if (nade ~= nil) then
				Window.textbox["region-race-time-value"].set.text(Timecode.convert(nade.data.timer).strings.time);
			end
			
			
			
			
			-- toggle floyd
			if (input.Home and Play.get.inRobotMission() == false) then
				if (floyd ~= nil) then
					if (floyd.data ~= nil) then
						Play.set.inRobotMission(true);
						Player.set.robotMission(true);
					end
				end
			elseif (input.End and Play.get.inRobotMission()) then
				if (floyd ~= nil) then
					if (floyd.data ~= nil) then
						Play.set.inRobotMission(false);
						Player.set.robotMission(false);
					end
				end
			end
			
			
			
			
		end
	else
		Window.textbox["health-value"].set.text();
		Window.textbox["model-value"].set.text();
		Window.textbox["rotation-x-value"].set.text();
		Window.textbox["rotation-y-value"].set.text();
		Window.textbox["position-x-value"].set.text();
		Window.textbox["position-y-value"].set.text();
		Window.textbox["position-z-value"].set.text();
		Window.textbox["velocity-x-value"].set.text();
		Window.textbox["velocity-y-value"].set.text();
		Window.textbox["velocity-z-value"].set.text();
	end
end

return public;