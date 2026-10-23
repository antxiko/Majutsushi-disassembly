# Curiosities

## A false win has its own "yaku"

If the human player declares a win without a hand that wins, p01:6CB1 does not refuse: it writes
yaku 0x35 with value 0x83 into the list (p01:6CC9) and the scoring screen takes the special path
of p04:A943, which plays voice 0x17 (p04:A5D5). It is the game's penalty for a false
declaration; the standard name would be *chombo* but the name the screen draws was not
read, so the page calls it 0x35.

## The computer players learn

Seven counters per character drift after every hand the human wins
([The rivals](THE-RIVALS.html)): a player who keeps winning with toitoi makes the others
a little more toitoi-minded. The code is p03:BD8E-BFD6 and it is the reason the game is called
"the tile magician" in this disassembly's notes only as a joke: nothing in the ROM says so.

## Three rules most mahjong games do not have

四連刻 (four consecutive triplets), 大車輪 (seven consecutive pairs) and 八連荘 (eight
consecutive dealer wins) are on the rule screen and wired to yaku 0x2C, 0x2D and 0x34, all of
them off by default ([The rules](THE-RULES.html)).

## The DAC and a register that is not a bank register

Sound 0x17 and 0x18 need the last bank at 0xA000. The engine does not use the mapper's register
at 0xB000 for it: p12:6060 and p12:627C write 0x0F to 0xA000 and p12:6055 and p12:62EC write 0x0E back. The voices
at 0xAE00 and 0xB6E2 are the only data of bank 15 beyond its tables and code.

## Space nobody uses

The tails of 0xFF at the end of the banks add up to 1,649 bytes; the largest is 1,157 bytes at the
end of bank 14 (0xBB7B-0xBFFF).

## Code nobody calls

Eight fragments are never reached by any call, jump or table: p00:533F, 5342, 5367, 5565, 5568 and
570B, p01:68F3 and p03:BFAB. They are the second entry of routines whose first entry is used
(a `xor a` and a `ld a,1` before a shared `ld (0xC0B9),a`, for instance); the listing marks them as
orphan code.

## A table of sounds with a slot for each voice

The sound table at p12:61B0 has 16 rows, but the table has room for 24 entries because the
indexing does not skip the voices: the eight slots of sounds 0x11-0x18 (p12:61D2) hold eight
copies of 0x6254, the address of the sound frame itself, and are never read.
