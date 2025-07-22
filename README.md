# Usage
Download the repository and place into your Base N64 lua folder.
Load your ROM into BizHawk.
Then run the `init_n64.lua` file.

The game must be included in `common/gameList.lua` keyed by the full ROM Header ID at `0x3B` in the ROM and in the `code` folder there should be a lua file using the Cartridge ID.
*e.g. Jet Force Gemini's full game id is `NJFE0`, making the Cartridge ID `JF`.*
This file is what will be loaded an ran from the the `init_n64.lua` file.
From here your file structure can be however you decide to set it up.
