# Hai no Majutsushi - Mahjong 2 - commented disassembly

*(También [en castellano](README.es.md).)*

The commented disassembly of **Hai no Majutsushi - Mahjong 2** (牌の魔術師; Konami, 1989, RC-765) for the MSX2: a 128 KB MegaROM with Konami's mapper and a DAC, sixteen 8 KB banks.

- **100 %** of the binary explained: 39,774 bytes of code and 91,298 of named data, not a single unassigned byte.
- **25.9 %** of the listing commented, 2,450 routines, none below 10 % comments.
- The listing reassembles into the original ROM **byte for byte**.
- All 48 yaku codes were **measured by running the game's own code** on written hands; the eight digital voices are decoded from the ROM; the fourteen PSG tunes and effects are played by the cartridge's own engine (the title tune checked against openMSX); a [tutorial patch](https://antxiko.github.io/Majutsushi-TutorialPatch/) adds an English tutorial on F1; the pictures are openMSX screenshots of the cartridge running.

The website: <https://antxiko.github.io/Majutsushi-disassembly/>
(in Spanish: <https://antxiko.github.io/Majutsushi-disassembly/es/>).

## Reproducing it

The cartridge image is not distributed. Put yours in the root as `majutsushi.rom` (sha256 `7839c843...`) and run `make`. The details, in [UNDER THE HOOD](docs/UNDER-THE-HOOD.md).

## Legal

The game belongs to Konami and its rights holders. The licence in `LICENSE` only covers the tools, the comments, the analysis and the documentation here. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
