# Usage
Download the repository and place into your Base N64 lua folder.
Load your ROM into BizHawk.
Then run the `init_n64.lua` file.

# Setup
The game must be included in `common/gameList.lua` as a table entry.
Each entry is keyed by the ROM's full ID which includes the Media Format, Cartridge ID, Country Code, and Version number. *e.g. Jet Force Gemini's full ID is NJFE0.*
The entry consists of three values: `support`, `crc`, and `name`.
If `support` is not `true` then the init code will exit.
If `crc` does not match the ROM's crc then a message will display to indicate there was a mismatch but the code will still attempt to run anyway.
Finally `name` is just used in a display message to indicate the game was detected and code was loaded for it.
An example is show below.
```
NJFE0 = {
  support = true,
  crc = { 0x8A6009B6, 0x94ACE150 },
  name = "Jet Force Gemini (USA)",
},
```
Within the `code` **folder** there should be a **lua file** and a folder that are both named the same as the ROM's Cartridge ID. *e.g. Jet Force Gemini's cartridge ID is JF.*
The **lua file** should have both an `init()` and `main()` function. The `init()` function is called first and ran once. The `main()` function is called every frame.
Within the **folder** should be another folder named `include`. This can be used for data that you may want to include in classes.
In the **lua file's** `init()` function the `mem.extend()` function can be called. This will load the file `code/<Cartridge ID>/include/memory.lua` and include it's functions as part of the `common/memory.lua` memory wrapper.

# Memory Wrapper
A custom memory wrapper is used in this project for convenience and a better naming convention (in my opinion anyway).
All functions are big endian.
It is used with `mem.get` or `mem.set`.
The following are what is available with it without extending it:
* ` u8(int address)`: returns an 8bit unsigned integer at `address` in `RDRAM`.
* `u16(int address)`: returns an 16bit unsigned integer at `address` in `RDRAM`.
* `u32(int address)`: returns an 32bit unsigned integer at `address` in `RDRAM`.
* ` s8(int address)`: returns an 8bit signed integer at `address` in `RDRAM`.
* `s16(int address)`: returns an 16bit signed integer at `address` in `RDRAM`.
* `s32(int address)`: returns an 32bit signed integer at `address` in `RDRAM`.
* `f32(int address)`: returns an 32bit floating point at `address` in `RDRAM`.
* `ptr(int address)`: returns the pointer at `address` in `RDRAM`, if the pointer is null then `nil` is returned.
* `string(int address[, int length])`: returns a ascii string at `address` in `RDRAM`, if `length` is `nil` then the string will be read until a null (`0x00`) character is encounted.
* `vec3s(int address)`: returns a table of a 16bit signed position in 3D space at `address` in `RDRAM`.
* `vec3f(int address)`: returns a table of a 32bit floating point position in 3D space at `address` in `RDRAM`.
* `bit(bitfield bits, int bit)`: returns `true` if the `bit` in `bits` is 1, otherwise it returns `false`.
Custom get and set functions can be included in the `code/<Cartridge ID>/include/memory.lua` file if needed for unique game data structures.