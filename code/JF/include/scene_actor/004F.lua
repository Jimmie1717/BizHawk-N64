-- Actor 0x004F: Squadron
local include = {};

include.actorIdToSpawn = {
	[0x002B] = "Drone - Stealth",
	[0x002D] = "Drone - Cyclops",
	[0x0054] = "Drone - Arachano",
	[0x0066] = "Tribal - Male - King",
	[0x006D] = "Drone - Blue - Hovercraft",
	[0x0070] = "Tribal - Adult - Male (lantern)",
	[0x0083] = "Drone - Red - Wings",
	[0x0090] = "Tribal - Adult - Male (dark)",
	[0x0097] = "Tribal - Teen - Male (wheelbarrow)",
	[0x00A5] = "Tribal - Adult - Male",
	[0x00BD] = "Drone - Stag",
	[0x00BE] = "Drone - Armor",
	[0x00E6] = "?",
	[0x00F5] = "Drone - Blue - Turret",
	[0x00F6] = "Drone - Blue - Turret",
	[0x011C] = "Tribal - Adult - Male",
	[0x011D] = "Tribal - Adult - Female",
	[0x011E] = "Tribal - Teen - Male",
	[0x011F] = "Tribal - Teen - Female",
	[0x0120] = "Tribal - Baby",
	[0x0121] = "Drone - Zombie",
	[0x0150] = "Drone - Octo",
	[0x0152] = "Drone - Dragon",
	[0x0157] = "Tribal - Adult - Male",
	[0x01E5] = "Drone - Unknown Grasshopper?",
	[0x0269] = "Drone - Renagade",
	[0x02CE] = "FettBubb Bat",
	
	--[[ 8027E3D0
		== 0x02CE
		<  0x00BF
		<  0x01E6
		== 0x0269
		<  0x0167
		<  0x01E5
		<  0x00F7
		== 0x002B
		== 0x002D
		== 0x0054
		== 0x006D
		== 0x0083
		== 0x0150
		== 0x0152
		<  0x011C
		<  0x0121
		== 0x00E6
	]]--
}

include.parameters = {
	unk0A = 0x00, -- u8
	amountToSpawn = 0x01, -- u8 | amount of child actors to spawn.
	unk0C = 0x02, -- u8
	unk0D = 0x03, -- u8
	unk0E = 0x04, -- u8
	unk0F = 0x05, -- u8
	behaviour = 0x06, -- u8
	unk11 = 0x07, -- u8
	unk12 = 0x08, -- u8
	unk13 = 0x09, -- u8
	unk14 = 0x0A, -- u8
	modelSize = 0x0B, -- u8 | value << 8
	unk16 = 0x0C, -- u8
	unk17 = 0x0D, -- u8
	unk18 = 0x0E, -- u8
	unk19 = 0x0F, -- u8
	unk1A = 0x10, -- s8
	unk1B = 0x11, -- s8
	unk1C = 0x12, -- s8
	unk1D = 0x13, -- u8
	unk1E = 0x14, -- u8
	unk1F = 0x15, -- s8
	unk20 = 0x16, -- s8
	unk21 = 0x17, -- s8
	unk22 = 0x18, -- u8
	unk23 = 0x19, -- u8
	unk24 = 0x1A, -- u8
	unk25 = 0x1B, -- s8
	unk26 = 0x1C, -- s8
	unk27 = 0x1D, -- s8
	unk28 = 0x1E, -- u8
	unk29 = 0x1F, -- u8
	unk2A = 0x20, -- u8
	unk2B = 0x21, -- u8
	unk2C = 0x22, -- u8
	flag = 0x23, -- u8 | used to make a tribal unique, if 2 share the same flag then rescueing/killing the second won't change the tribal count.
	unk2E = 0x24, -- u8
	unk2F = 0x25, -- u8
	unk30 = 0x26, -- u8
	unk31 = 0x27, -- u8
	unk32 = 0x28, -- u8
	unk33 = 0x29, -- u8
	unk34 = 0x2A, -- u8
	unk35 = 0x2B, -- u8
	actorIdToSpawn = 0x2C, -- u16 | id of the child actor to spawn.
	unk38 = 0x2E, -- s8
	unk39 = 0x2F, -- s8
	unk3A = 0x30, -- u16 | bitfield, & 0xFFF7 (removing 0x0008 bit)
		--[[
			0x0030
			0x0040 = get player pointer and set it in actor. (this happens anyway without this? this uses the general game function to get it rather than getting the pointer stored in the actor's overlay)
			0x0400
			0x0800
			0x1000
			0x4000
			0x8000
		]]--
	unk3C = 0x32, -- u8
	unk3D = 0x33, -- u8
	unk3E = 0x34, -- u8
	unk3F = 0x35, -- s8
	unk40 = 0x36, -- u16
};

return include;

--[[
                                                                   v
	                                             u  u  u  u  u  u  u  u  u  u  u  u  u  u  u  u  s  s  s  u  u  s  s  s  u  u  u  s  s  s  u  u  u  u  u  u  u  u  u  u  u  u  u  u  u    s  s  u    u  u  u  s  u  
	outset pathway
	adult male tree		004F 4400 02EE 0000 FD1E 00 01 03 09 64 04 09 64 00 09 64 1E 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 8D 00 00 00 03 0F 28 00 01 1E 5A 14 00 00 00 04 00 011C 0A 00 0281 01 00 28 00 0000
	adult male behind	004F 4400 036D 0006 F20E 00 01 03 09 64 04 09 64 00 11 64 1E 32 64 0A 32 00 00 00 02 02 FB 10 E3 7B 12 02 DD 00 00 00 01 0F 28 00 06 1E 5A 14 00 00 00 04 00 011C 0A 00 0A91 01 00 28 03 0000
	adult male infront	004F 4400 03CA 0000 F35D 00 01 03 09 64 04 09 64 00 11 64 1E 32 64 0A 32 00 00 00 02 02 11 00 D4 A5 27 02 3D 00 00 00 02 0F 28 00 05 1E 5A 14 00 00 00 04 00 011C 0A 00 0A91 01 00 28 03 0000
	
	interior ninja drone
	adult male l front	004F 4400 FE5E FFF7 00C2 00 01 03 11 64 04 09 64 00 11 64 24 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 05 1E 5A 14 00 00 00 03 00 0090 0A 00 0A91 01 00 00 01 0000 
	adult male l back	004F 4400 FEF4 FFF8 FFA2 00 01 03 11 64 04 09 64 00 11 64 20 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 06 1E 5A 14 00 00 00 04 00 011C 0A 00 0A91 01 00 00 01 0000 
	adult male r back	004F 4400 0000 FFFE FFE7 00 01 03 11 64 04 09 64 00 11 64 22 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 07 1E 5A 14 00 00 00 03 00 00A5 0A 00 0A91 01 00 00 01 0000
	adult male r front	004F 4400 0134 FFFA 0059 00 01 03 11 64 04 09 64 00 11 64 22 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 08 1E 5A 14 00 00 00 03 00 00A5 0A 00 0A91 01 00 00 01 0000 
	
	sekhmet hanger
							      X    Y    Z    ?  a  ?  ?  ?  ?  ?  ?  ?  ?  ?  s  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?  f  ?  ?  ?  ?  ?  ?  ?  ?  ID   ?  ?  ?    ?  ?  ?  ?  ?
	adult female		004F 4400 0223 FD4D 017A 00 01 03 09 64 04 09 64 00 09 64 1E 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 01 0A B4 14 00 00 00 02 00 011D 0A 00 0A99 01 00 00 01 0000 
	adult male			004F 4400 01CF FD59 044A 00 01 03 09 64 04 09 64 00 09 64 1C 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 03 0A B4 14 00 00 00 02 00 011E 0A 00 0A99 01 00 00 01 0000
	teen female			004F 4400 FD5B FD5E 03A3 00 01 03 09 64 04 09 64 00 09 64 1A 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 02 0A B4 14 00 00 00 01 00 011F 0A 00 0A99 01 00 00 01 0000
	baby				004F 4400 FCD3 FD54 03AC 00 01 03 09 64 04 11 64 00 11 64 11 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 00 00 00 03 03 0F 28 00 04 0A B4 14 00 00 00 01 00 0120 05 00 0A99 01 00 00 01 0000
	
	tribal family	8027CFDE
	baby				004F 4400 0204 FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 11 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 13 1E 2D 14 00 00 00 04 00 0120 05 FB 0200 01 00 28 00 0000
	teen female			004F 4400 019E FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 1A 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 12 1E 2D 14 00 00 00 04 00 011F 05 FB 0200 01 00 28 00 0000
	teen male			004F 4400 013E FF4E FF89 00 01 03 09 64 04 09 64 00 09 64 1C 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 11 1E 2D 14 00 00 00 04 00 011E 05 FB 0200 01 00 28 00 0000
	adult female		004F 4400 00DE FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 1E 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 10 1E 2D 14 00 00 00 04 00 011D 05 FB 0200 01 00 28 00 0000
	adult male			004F 4400 007E FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 24 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0F 1E 2D 14 00 00 00 04 00 0157 05 FB 0200 01 00 28 00 0000
	teen male wheel-b	004F 4400 0018 FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 25 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0E 1E 2D 14 00 00 00 04 00 0097 05 FB 0200 01 00 28 00 0000
	adult male 2		004F 4400 FFA6 FF4E FF89 00 01 03 09 64 04 09 64 00 09 64 22 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0D 1E 2D 14 00 00 00 04 00 00A5 05 FB 0200 01 00 28 00 0000
	adult male 3 (dark)	004F 4400 FF3A FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 24 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0C 1E 2D 14 00 00 00 04 00 0090 05 FB 0200 01 00 28 00 0000
	adult male 4 (lan)	004F 4400 FEDA FF4E FF88 00 01 03 09 64 04 09 64 00 09 64 23 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0B 1E 2D 14 00 00 00 04 00 0070 05 FB 0200 01 00 28 00 0000
	adult male 5		004F 4400 FE7A FF4E FF89 00 01 03 09 64 04 09 64 00 09 64 24 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 0A 1E 2D 14 00 00 00 04 00 011C 05 FB 0200 01 00 28 00 0000
	adult king			004F 4400 FE14 FF4E FF89 00 01 03 09 64 04 09 64 00 09 64 28 32 64 0A 32 00 00 00 02 02 00 00 00 02 02 02 40 00 00 00 03 0F 28 00 09 1E 2D 14 00 00 00 04 00 0066 02 00 0200 01 00 28 00 0000
]]--