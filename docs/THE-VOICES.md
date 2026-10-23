# The voices

The cartridge has a DAC. Sounds 0x11-0x18 are not PSG tunes but eight short digitised voices,
played by p12:6265 straight into the DAC register at 0x5000 while the interrupt is held back.

| sound | said when | bytes | audio |
|---|---|---|---|
| 0x11 | PON (p00:414D) | 1,154 | <audio controls src="audio/voz_11.wav"></audio> |
| 0x12 | CHI (p00:4158) | 2,272 | <audio controls src="audio/voz_12.wav"></audio> |
| 0x13 | KAN (p00:4163) | 1,440 | <audio controls src="audio/voz_13.wav"></audio> |
| 0x14 | RON (p00:416E) | 1,431 | <audio controls src="audio/voz_14.wav"></audio> |
| 0x15 | riichi (p00:4179) | 2,704 | <audio controls src="audio/voz_15.wav"></audio> |
| 0x16 | tsumo (p00:4184) | 2,054 | <audio controls src="audio/voz_16.wav"></audio> |
| 0x17 | with the penalty (p00:418F) | 2,272 | <audio controls src="audio/voz_17.wav"></audio> |
| 0x18 | asked by the engine when an effect channel ends (p12:6941) | 2,332 | <audio controls src="audio/voz_18.wav"></audio> |

## The format

The table at p12:6065 holds eight pointers: 0x9040, 0x94C4, 0x9DA6, 0xA348, 0xA8E1 and 0xB373
(banks 13 and 14 mapped one after the other at 0x8000-0xBFFF) and 0xAE00 and 0xB6E2 (bank 15 in
0xA000, which p12:6059 selects). A sample starts with a marker byte and ends at the first byte
that repeats it: the six lengths measured in the ROM are 1,156, 2,274, 1,442, 1,433, 2,706 and 2,056
bytes including both markers, and the two in bank 15 are 2,274 and 2,334, which end exactly at
the next sample or at the end of the bank.

Each byte carries two nibbles, high first. The DAC starts at 0x80 and every nibble adds one of
sixteen steps (the table at p12:62D1: 0, 1, 2, 4, 8, 16, 32, 64, -128, -64, -32, -16, -8, -4, -2, -1),
modulo 256, and the result goes to 0x5000. The pace is a loop of 0xCF2F laps (p12:62AB): 3 by
default, 10 or 21 when p00:41AD asks for the voice of one character or another (the pitch of
each rival's voice). The files here use 18 kHz, an estimate from the instruction count of the
loop at its default pace, and every value stays between 12 and 247, as a real waveform should.

`tools/voces.py` writes them: `python tools/voces.py docs/audio`.
