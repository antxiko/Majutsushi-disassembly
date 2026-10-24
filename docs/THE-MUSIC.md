# The music

Sounds 0x01-0x10 are the PSG's: the tunes and the short effects. The engine is in bank 12
(p12:6000 starts it, p12:6003 asks for a sound, p12:6006 plays one frame), with five channels in
RAM at 0xCE00, 0x2C bytes each. Every channel reads a stream of notes and commands: 0xD0-0xDF go
through the table at p12:6B94 and 0xE0-0xFE through the one at p12:6962, among them a call (0xF9),
its return (0xFA), two counted loops (0xFB, 0xFC), a jump (0xFD) and the end (0xFF). The sixteen
sounds have their rows at p12:61E2, reached through the pointers at p12:61B2.

The recordings below are not taken from an emulator's sound output. `tools/musica.py` runs the
cartridge's own engine in a Z80 emulator with the mapper, one call to p12:6006 per 1/60 s, and
writes down what it sends to the PSG; the file is synthesised from those register values. A tune
that loops is played to its loop point and once more; the loop is found when the five channels
are back in the same state (pointer, note counter, loop counters and return address).

Checked against openMSX (`tools/omsx_psg.tcl` writes down the PSG registers every frame,
`tools/coteja_psg.py` lines them up): over the first 50 s of the title tune, 0x09, 2,778 of 3,000
frames are identical in the three tones and the three volumes, and the other 222 differ by 2 to 8
units in channel A's fine tone or by 1 in a volume, the phase of a vibrato and of an envelope. The
other tunes are run the same way but have not been checked against the emulator: the demo that
follows the title does not line up with any of them, probably because the effects of the dice and
the discards play over the same channels.

| sound | when | asked from | audio |
|---|---|---|---|
| 0x09 | The menus (and the F4 key during play) | p00:42BD, p00:49D7 | <audio controls preload="none" src="audio/musica_09.mp3"></audio> |
| 0x0A | The settings menus (and the F5 key) | p00:4369, p00:4888 | <audio controls preload="none" src="audio/musica_0A.mp3"></audio> |
| 0x0C | The game: the default tune (and the F2 key) | p00:44A4 | <audio controls preload="none" src="audio/musica_0C.mp3"></audio> |
| 0x0B | The game: the F3 key | p01:616D | <audio controls preload="none" src="audio/musica_0B.mp3"></audio> |
| 0x0D | The player wins | p00:457E | <audio controls preload="none" src="audio/musica_0D.mp3"></audio> |
| 0x0E | A rival wins | p00:4581, p00:4907 | <audio controls preload="none" src="audio/musica_0E.mp3"></audio> |
| 0x0F | The hand ends with no winner | p00:48F3 | <audio controls preload="none" src="audio/musica_0F.mp3"></audio> |
| 0x10 | The box of p00:473E (state 5, step 6) | p00:475D | <audio controls preload="none" src="audio/musica_10.mp3"></audio> |
| 0x03 | A question box opens | p00:5EBC, p02:949A, p02:97AE | <audio controls preload="none" src="audio/musica_03.mp3"></audio> |
| 0x04 | A tile is discarded | p02:8D49 | <audio controls preload="none" src="audio/musica_04.mp3"></audio> |
| 0x05 | The dice | p02:8F0B, p02:8F53 | <audio controls preload="none" src="audio/musica_05.mp3"></audio> |
| 0x06 | The cursor | p00:43AC, p02 (4), p03 (6) | <audio controls preload="none" src="audio/musica_06.mp3"></audio> |
| 0x07 | A choice is made | p00:43D3, p03 (5) | <audio controls preload="none" src="audio/musica_07.mp3"></audio> |
| 0x08 | Tiles are dealt | p02:8AED | <audio controls preload="none" src="audio/musica_08.mp3"></audio> |

Sound 0x01 silences the three channels in a single frame, and 0x02 is silent as well.

## The function keys

On the player's turn (p00:5E7B), p01:6146 turns the function keys just pressed (0xC00C, bit 0 = F1) into a sound,
the first key that is down wins, and only if it is not the one already asked for (0xC0C2):
F1 asks for 0x01 (silence), F2 for 0x0C, F3 for 0x0B, F4 for 0x09 and F5 for 0x0A. So the
player can choose the background tune, or switch it off.

| sound | length |
|---|---|
| 0x09 | 72.6 s, loops from the start |
| 0x0A | 78.4 s, loops from 41.1 s |
| 0x0B | 51.2 s, loops from the start |
| 0x0C | 58.2 s, loops from 31.5 s |
| 0x10 | 37.4 s, loops from 18.7 s |
| 0x0D, 0x0E, 0x0F | 3.6, 3.7 and 4.4 s |
