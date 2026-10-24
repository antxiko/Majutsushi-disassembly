# The yaku

When a hand wins, the game builds a list of yaku at 0xC2E0: 32 pairs of bytes (code, value)
that p01:6CD5 fills by calling 32 small checks of bank 4 (the table at p01:716B, plus 20 more
at p01:71A5). p04:A341 appends a pair; the value is the number of *han*, or 0x81, 0x82 or 0x83
for a limit hand (one, two or three times). The screen then writes each name and its han:

![concealed self-draw, one han, 30 fu](imagenes/victoria.png)

That screen is the cross-check of the first row of the table: code 0x04 is 門前清摸和
(*menzen tsumo*), worth one han.

## How the codes were established

`tools/prueba_yaku.py` runs the cartridge's own analysis (a Z80 emulator with the mapper) on a
hand written into RAM and reads the list back. 6,000 random winning hands gave 24 codes; the other
24 came out of hands built for them (`tools/yaku_hechos.py`): riichi with the draw two turns after
the declaration for ippatsu, 0xCD0C set for rinshan, the last tile of the wall for haitei and
houtei, the first draw for tenhou and chiihou, the rule options switched on for 0x2C, 0x2D, 0x2F and
0x34. Every code of both tables has been seen coming out of the cartridge, and `tests/test_cartucho.py`
pins one of each kind. The names are the standard Japanese ones; the game draws them as kanji.

Two things the measurements show: pinfu (0x03) only appears on a ron, because the rule
自摸平和 is off by default and a self-drawn pinfu hand only gets menzen tsumo; and a ron while the
winner has not discarded yet is always renhou (0x2B), which swallows the rest of the list.

| code | yaku | han | how |
|---|---|---|---|
| 0x01 | 立直 riichi | 1 | measured |
| 0x02 | riichi + 一発 ippatsu | 2 | measured |
| 0x03 | 平和 pinfu | 1 | measured |
| 0x04 | 門前清摸和 menzen tsumo | 1 | measured, on screen |
| 0x05 | 断幺九 tanyao | 1 | measured |
| 0x06 | 一盃口 iipeikou | 1 | measured |
| 0x07 | 役牌 yakuhai | one per triplet | measured |
| 0x08 | 嶺上開花 rinshan kaihou | 1 | measured |
| 0x09 | 海底摸月 haitei | 1 | measured |
| 0x0A | 河底撈魚 houtei | 1 | measured |
| 0x0B | 槍槓 chankan | 1 | measured |
| 0x0C | double riichi | 2 | measured |
| 0x0D | 七対子 chiitoitsu | 2 | measured |
| 0x0E | 対々和 toitoi | 2 | measured |
| 0x0F | 二盃口 ryanpeikou | 2 | measured |
| 0x10 | 一気通貫 ittsu | 2 closed, 1 open | measured |
| 0x11 | 三色同順 sanshoku doujun | 2 closed, 1 open | measured |
| 0x12 | 混全帯幺九 chanta | 2 closed, 1 open | measured |
| 0x13 | 三暗刻 sanankou | 2 | measured |
| 0x14 | 三槓子 sankantsu | 2 | measured |
| 0x15 | 三連刻 sanrenkou | 2 | measured |
| 0x16 | 三色同刻 sanshoku doukou | 2 | measured |
| 0x17 | 小三元 shousangen | 2 | measured |
| 0x18 | 混老頭 honroutou | 2 | measured |
| 0x19 | 混一色 honitsu | 3 closed, 2 open | measured |
| 0x1A | 純全帯幺九 junchan | 3 closed, 2 open | measured |
| 0x1B | 清一色 chinitsu | 6 closed, 5 open | measured |
| 0x1C | ドラ dora | one per tile | measured |
| 0x1D | double riichi + ippatsu | 3 | measured |

Limit hands (value 0x81 unless said):

| code | yaku | how |
|---|---|---|
| 0x20 | 四暗刻 suuankou | measured |
| 0x22 | 大三元 daisangen | measured |
| 0x23 | 小四喜 shousuushii | measured |
| 0x24 | 字一色 tsuuiisou | measured |
| 0x25 | 清老頭 chinroutou | measured |
| 0x26 | 緑一色 ryuuiisou (2, 3, 4, 6, 8 of bamboo and the green dragon) | measured |
| 0x27 | 九蓮宝燈 chuuren poutou | measured |
| 0x28 | 国士無双 kokushi musou | measured |
| 0x29 | 天和 tenhou | measured |
| 0x2A | 地和 chiihou | measured |
| 0x2B | 人和 renhou (ron before any discard) | measured |
| 0x2C | four consecutive triplets (option 0xC025) | measured |
| 0x2D | 大車輪 seven consecutive pairs (option 0xC026) | measured |
| 0x2F | 十三不搭, value 0x83 (option 0xC022; checked by p01:70DD in the first turn) | measured |
| 0x30 | suuankou on a pair wait, value 0x82 | measured |
| 0x31 | kokushi on a thirteen-tile wait, 0x82 | measured |
| 0x32 | 大四喜 daisuushii, 0x82 | measured |
| 0x33 | chuuren poutou on a nine-tile wait, 0x82 | measured |
| 0x34 | eight consecutive wins (option 0xC024; value 0x51) | measured |
| 0x35 | the penalty of the next page, value 0x83 | measured |

The fu are computed by p15:A1A6 (20 or 30 to start with, 10 for a closed ron, 2 for a
self-draw, per triplet and per kan, and for the wait), and the payment by p04:ACB4, which also
adds the honba (100 each) and the riichi sticks (1,000 each).
