# The rivals

You always play seat 0 against three computer players chosen from eight characters of
Konami's own games, in the order they appear on the opponent-selection screen (面子選択):

| # | character |
|---|---|
| 1 | シモン (Simon) |
| 2 | アフロディーテ (Aphrodite) |
| 3 | スナッチャー (Snatcher) |
| 4 | ヴェノム (Venom) |
| 5 | ゴエモン (Goemon) |
| 6 | ポポロン (Popolon) |
| 7 | ペンギン (Penguin) |
| 8 | モアイ (Moai) |

![the eight portraits](imagenes/retratos.png)

![choosing the three rivals](imagenes/eleccion_rivales.png)

## Seven counters per character

Every character has seven numbers from 0 to 63 (0x3F), shown as red bars on the
personality screen (性格設定):

![the personality screen](imagenes/personalidad.png)

| counter | label | what the code does with it |
|---|---|---|
| 0 | 立直 (riichi) | goes up when a hand won by the human carries riichi (yaku 0x01) |
| 1 | 鳴き (calls) | goes up when the winning hand is open (p03:BDCF) |
| 2 | 断幺 (tanyao) | up with tanyao (yaku 0x05), down with chanta (0x12) |
| 3 | 清一 (chinitsu) | up with honitsu or chinitsu (0x19, 0x1B) |
| 4 | 対々 (toitoi) | up with toitoi or seven pairs (0x0E, 0x0D) |
| 5 | 国士 (kokushi) | up with kokushi (0x28) |
| 6 | 降りる (fold) | moves with who won |

The starting values are eight rows of eight bytes at p15:A00C, and they match the bars on
screen (Simon's row, `35 22 52 14 54 51 63`, is 56 %, 35 %, 83 %, 22 %, 86 %, 81 % and 100 %
of the bar):

| # | riichi | calls | tanyao | chinitsu | toitoi | kokushi | fold |
|---|---|---|---|---|---|---|---|
| 1 | 35 | 22 | 52 | 14 | 54 | 51 | 63 |
| 2 | 16 | 63 | 4 | 52 | 44 | 2 | 5 |
| 3 | 63 | 1 | 42 | 19 | 11 | 36 | 30 |
| 4 | 5 | 35 | 18 | 44 | 31 | 19 | 47 |
| 5 | 30 | 36 | 0 | 2 | 33 | 2 | 34 |
| 6 | 35 | 31 | 33 | 38 | 41 | 16 | 21 |
| 7 | 50 | 8 | 35 | 63 | 20 | 2 | 52 |
| 8 | 3 | 52 | 51 | 21 | 30 | 53 | 1 |

At the start of a game p15:A04C copies the eight bytes of each chosen rival into its
hand (offset +0x90). During play the counters are not fixed: after a hand won by the
human p03:BD8E walks the list of yaku (0xC2E0) and moves the counters of the other
players, up to 0x3F, so the computer players drift towards the style they have just lost
to. The same counters drive p15:A0B5 (which suit the computer keeps), p15:A108 (when it
asks for tiles) and p15:A14C (how willing it is to call).

The hand analysis the computer uses is in p01:72D2-7FFF: it splits the 13 tiles by suit,
looks for runs, pairs, gaps and edge pairs (lists at hand offsets +0x160 to +0x1B0), and
looks up the combinations in a pattern table of bank 15 (p15:A306).
