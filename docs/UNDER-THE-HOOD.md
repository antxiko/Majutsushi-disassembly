# Under the hood

## Rebuilding the ROM

```
make            # listing, reassembly, checks and tests
make verify     # the 16 reassembled banks give the whole ROM, byte for byte
make sanity     # nothing declared as data runs as code; not a byte without an owner
```

You need the cartridge image (`majutsushi.rom`, 131,072 bytes, sha256
`7839c843dc787e01765c1ba3efbd26dcf5209d27e38bcee1345db3b3cffdf5db`), which is not distributed.

## In numbers

| | |
|---|---|
| explained | 100% of the 131,072 bytes |
| code | 39,774 bytes, 20,780 instructions |
| data | 91,298 bytes |
| routines | 2,450, none under 10% commented |

## The cartridge

A MegaROM of 16 banks of 8 KB. Bank 0 is fixed at 0x4000-0x5FFF and holds the interrupt, the
VDP routines and the drawing helpers. The other three windows (0x6000, 0x8000 and 0xA000) are
switched by writing the bank number to 0x7000, 0x9000 and 0xB000 (Konami's mapper); the game
keeps copies of the three numbers in 0xF0F1-0xF0F3 and p00:4207-425B set them. The cartridge also
has a DAC at 0x5000 (p12:62A8).

| bank | at | what it holds |
|---|---|---|
| 0 | 0x4000 | interrupt, VDP commands, tile drawing, keys, the state machine |
| 1 | 0x6000 | save/load to a second cartridge, hand analysis, yaku tables, the hand splitter |
| 2 | 0x8000 | the computer's decisions, dealing, discarding, calls, dice, dialogue boxes |
| 3 | 0xA000 | the menus (rules, rivals, personalities), end of the hand, results |
| 4 | 0xA000 | the yaku checks, the payment, the animations of the rivals' faces |
| 5 | 0x8000 | a font of 128 glyphs of 16 x 16 points, 64 bytes each |
| 6 | 0xA000 | title and menu graphics, palettes and RLE lists |
| 7-9 | 0x6000-0xBFFF | table, tiles and dialogue graphics (the image lists of p00:5911) |
| 10-11 | 0x8000-0xBFFF | portraits, menu graphics |
| 12 | 0x6000 | the sound engine, rhythm patterns, the first tunes |
| 13-14 | 0x8000-0xBFFF | the rest of the tunes, then the voices |
| 15 | 0xA000 | the computer's pattern tables, the fu, the wall shuffle, two voices |

## The state machine

0xC000 holds the state and 0xC001 the step inside it. The interrupt (hooked in H.KEYI by INIT,
p00:4010) first runs the sound engine with banks 12-13-14, restores the game's banks and then
runs one frame of the game: p00:55F0 reads the keys and p00:425D dispatches through the table
of nine states at p00:4271. The loop `jr $` at p00:40BF does nothing else.

## A hand in RAM

Each player has 0x400 bytes at 0xD000 + 0x400 x seat (p02:85D8):

| offset | what |
|---|---|
| +0x00 | the 13 tiles, sorted |
| +0x0E | the number of called groups |
| +0x0F, +0x10 | the number of discards and the list |
| +0x34, +0x35 | riichi, double riichi |
| +0x37, +0x3F | the called groups and how many |
| +0x40 | 1 if the hand is open |
| +0x41 | the list of own discards (furiten check) |
| +0x60 | what the player may say to the last discard: bit 0 pon, 1 chi, 2 kan, 3 ron |
| +0x81 | tenpai at the end of the hand |
| +0x90..+0x96 | the seven style counters |
| +0x100..+0x3FF | the computer's analysis: tiles by suit, runs, pairs, gaps |

A tile is one byte: the number in the low nibble, the suit in bits 4-5 (0, 1, 2; 3 is honours:
0x31-0x34 winds and 0x35-0x37 dragons), and bits 6-7 flag a tile that is part of a called
group. The wall is 136 bytes at 0xC100, shuffled by p15:A2A8 with at most four of each tile.

## The screen

SCREEN 7, 512 x 212, 16 colours. Everything is drawn with VDP commands: tiles are copied with
HMMM from a sheet at y = 0xB0 (p00:5398), panels are filled with HMMV (p00:4FE5), letters and
images go in with LMMC (p00:5074), and the portraits are decoded from tiles of 1, 2 or 3 bits
per point with a 2-, 4- or 8-colour palette by p00:5911. The image lists have six bytes per
entry (format, palette, tile, count, pointer) and end in 0xFF.

## The data banks

`tools/lectores.py` walks every list the loaders read, with the bank that is mapped when the
loader runs (`tools/bancos.py` follows the mapper through the whole cartridge). That
accounts for the image lists, the palettes, the RLE streams, the tile lists, the font, the
voices and the sound streams; the rest are tables that an instruction points to or an explicit
note in the listing.

### What a game reads, measured

`tools/omsx_leido.tcl` runs the cartridge in openMSX with a watchpoint on every read of
0x6000-0xBFFF and notes, the first time, which byte of which bank was read and by which
instruction; the bank is the one the mapper really has, followed through its writes (the voices
0x17 and 0x18 switch bank 15 in without touching the copies at 0xF0F1-3). Fifteen minutes of
title, menus and two hands, with space pressed every few seconds (`tools/cobertura_leido.py`):

| bank | data read |
|---|---|
| 5 | 2,753 of 8,192 bytes |
| 6 | 5,041 of 7,985 |
| 7 | 6,495 of 8,192 |
| 8 | 8,135 of 8,192 |
| 9 | 6,711 of 8,030 |
| 10 | 2,894 of 8,192 |
| 11 | 1,493 of 8,178 |
| 13 | 6,247 of 8,192 |
| 14 | 7,035 of 7,035 |
| 15 | 2,859 of 7,375 |
| total | 49,663 of 79,563 (62.4 %) |

A byte this run does not read is not a byte nobody reads: the run only goes through the screens
that the space key leads to. What it does show is that not a single read falls in the 0xFF fill at
the ends of the banks.

## The sound

p12 runs five channels (three tunes on the PSG and two for effects that take over the
PSG channels B and C) with a stream of notes (high nibble the note, low nibble the length) and
commands: 0xD0-0xDF and 0xE0-0xFE, 0xFF ends. The streams of the 16 sounds are in p12:6F72-p13:903F,
and all of them end exactly where the next one starts once the subroutines called by 0xF9 are
counted. Sounds 0x11-0x18 are the voices of [The voices](THE-VOICES.html).
