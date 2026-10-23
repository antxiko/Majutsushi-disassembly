; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 13 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS subflujo_7FF7_cola: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8000..0x805c  (92 bytes)
DATA_subflujo_7FF7_cola:
	defb 00ah,0ebh,032h,033h,0dbh,005h,0d4h,050h,0eah,008h,050h,0eah,00ah,0a0h,0a0h,0d3h	; 8000  ..23...P..P.....
	defb 050h,0eah,008h,050h,0eah,00ah,0d4h,0a0h,0eah,008h,0a0h,0eah,00ah,070h,0d3h,020h	; 8010  P..P.........p.
	defb 0eah,008h,020h,0eah,00ah,020h,0d4h,090h,0d3h,040h,0eah,008h,040h,0eah,00ah,040h	; 8020  .. .. ...@..@..@
	defb 020h,0eah,008h,020h,0eah,00ah,090h,090h,0d2h,020h,0eah,008h,020h,0eah,00ah,0d3h	; 8030   .. ..... .. ...
	defb 090h,0eah,008h,090h,0eah,00ah,000h,0eah,008h,000h,0eah,00ah,070h,070h,0d2h,000h	; 8040  ............pp..
	defb 0eah,008h,000h,0eah,00ah,0d3h,070h,0eah,008h,070h,0fah,0ffh	; 8050  ......p..p..

; ----------------------------------------------------------------------
; DATOS subflujo_805C: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x805c..0x80c5  (105 bytes)
DATA_subflujo_805C:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0ebh,042h,033h,0dbh,005h,0d4h	; 805c  .....(.....B3...
	defb 070h,0eah,008h,070h,0eah,00ah,0d3h,020h,020h,070h,0eah,008h,070h,0eah,00ah,020h	; 806c  p..p...  p..p..
	defb 0eah,008h,020h,0eah,00ah,0d4h,090h,0d3h,040h,0eah,008h,040h,0eah,00ah,040h,090h	; 807c  .. .....@..@..@.
	defb 0eah,008h,090h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d4h,050h,0eah,008h,050h	; 808c  .....@..@...P..P
	defb 0eah,00ah,0d3h,000h,000h,050h,0eah,008h,050h,0eah,00ah,000h,0eah,008h,000h,0eah	; 809c  .....P..P.......
	defb 00ah,0d4h,050h,0d3h,000h,0eah,008h,000h,0eah,00ah,000h,050h,0eah,008h,050h,0eah	; 80ac  ..P........P..P.
	defb 00ah,000h,0eah,008h,000h,0eah,00ah,0fah,0ffh	; 80bc  .........

; ----------------------------------------------------------------------
; DATOS subflujo_80C5: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x80c5..0x8158  (147 bytes)
DATA_subflujo_80C5:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0ebh,042h,033h,0dbh,005h,0d4h	; 80c5  .....(.....B3...
	defb 0a0h,0eah,008h,0a0h,0eah,00ah,0d3h,050h,050h,0a0h,0eah,008h,0a0h,0eah,00ah,050h	; 80d5  .......PP......P
	defb 0eah,008h,050h,0eah,00ah,000h,070h,0eah,008h,070h,0eah,00ah,070h,0d2h,000h,0eah	; 80e5  ..P...p..p..p...
	defb 008h,000h,0eah,00ah,0d3h,070h,0eah,008h,070h,0eah,00ah,0d4h,050h,0eah,008h,050h	; 80f5  .....p..p...P..P
	defb 0eah,00ah,0d3h,000h,000h,050h,0eah,008h,050h,0eah,00ah,000h,0eah,008h,000h,0eah	; 8105  .....P..P.......
	defb 00ah,0d4h,050h,0d3h,000h,0eah,008h,000h,0eah,00ah,000h,050h,0eah,008h,050h,0eah	; 8115  ..P........P..P.
	defb 00ah,000h,0eah,008h,000h,0eah,00ah,0d4h,0a0h,0eah,008h,0a0h,0eah,00ah,0d3h,050h	; 8125  ...............P
	defb 050h,0a0h,0eah,008h,0a0h,0eah,00ah,050h,0eah,008h,050h,0eah,00ah,0d4h,090h,0d3h	; 8135  P......P..P.....
	defb 040h,0eah,008h,040h,0eah,00ah,040h,090h,0eah,008h,090h,0eah,00ah,040h,0eah,008h	; 8145  @..@..@......@..
	defb 040h,0fah,0ffh	; 8155

; ----------------------------------------------------------------------
; DATOS subflujo_8158: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8158..0x8182  (42 bytes)
DATA_subflujo_8158:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0edh,009h,0ebh,081h,054h,0dbh	; 8158  .....(........T.
	defb 004h,0d4h,070h,0a0h,0d3h,020h,070h,0d4h,090h,0d3h,000h,040h,090h,0d4h,0a0h,0d3h	; 8168  ..p.. p....@....
	defb 020h,050h,0a0h,000h,040h,070h,0d2h,000h,0fah,0ffh	; 8178   P..@p....

; ----------------------------------------------------------------------
; DATOS subflujo_8182: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8182..0x8216  (148 bytes)
DATA_subflujo_8182:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0ebh,042h,033h,0dbh,005h,0d3h	; 8182  .....(.....B3...
	defb 020h,0eah,008h,020h,0eah,00ah,090h,090h,0d2h,020h,0eah,008h,020h,0eah,00ah,0d3h	; 8192   .. ..... .. ...
	defb 090h,0eah,008h,090h,0eah,00ah,0d4h,090h,0eah,008h,090h,0eah,00ah,0d3h,040h,040h	; 81a2  ..............@@
	defb 090h,0eah,008h,090h,0eah,00ah,0d4h,090h,0eah,008h,090h,0eah,00ah,070h,0eah,008h	; 81b2  .............p..
	defb 070h,0eah,00ah,0d3h,020h,020h,070h,0eah,008h,070h,0eah,00ah,020h,0eah,008h,020h	; 81c2  p...  p..p.. ..
	defb 0eah,00ah,0d4h,030h,0eah,008h,030h,0eah,00ah,0a0h,0a0h,0d3h,030h,0eah,008h,030h	; 81d2  ...0..0.....0..0
	defb 0eah,00ah,0d4h,0a0h,0eah,008h,0a0h,0eah,00ah,070h,0eah,008h,070h,0eah,00ah,0d3h	; 81e2  .........p..p...
	defb 020h,020h,070h,0eah,008h,070h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,0d4h,090h	; 81f2    p..p.. .. ....
	defb 0d3h,040h,0eah,008h,040h,0eah,00ah,040h,090h,0eah,008h,090h,0eah,00ah,040h,0eah	; 8202  .@..@..@......@.
	defb 008h,040h,0fah,0ffh	; 8212

; ----------------------------------------------------------------------
; DATOS subflujo_8216: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8216..0x8253  (61 bytes)
DATA_subflujo_8216:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0ebh,042h,033h,0dbh,005h,0d3h	; 8216  .....(.....B3...
	defb 020h,0eah,008h,020h,0eah,00ah,090h,090h,0d2h,020h,0eah,008h,020h,0eah,00ah,0d3h	; 8226   .. ..... .. ...
	defb 090h,0eah,008h,090h,0eah,00ah,0d4h,020h,090h,0eah,008h,090h,0eah,00ah,090h,0d3h	; 8236  ....... ........
	defb 020h,0eah,008h,020h,0eah,00ah,0d4h,090h,0eah,008h,090h,0fah,0ffh	; 8246   .. .........

; ----------------------------------------------------------------------
; DATOS sonido11_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 11: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8253..0x8275  (34 bytes)
DATA_sonido11_canal2:
	defb 0f9h,075h,082h,0f9h,0b3h,082h,0f9h,075h,082h,0f9h,0ddh,082h,0f9h,075h,082h,0f9h	; 8253  .u.....u.....u..
	defb 0b3h,082h,0f9h,075h,082h,0f9h,00fh,083h,0f9h,03dh,083h,0f9h,0a0h,083h,0f9h,053h	; 8263  ...u.....=.....S
	defb 082h,0ffh	; 8273

; ----------------------------------------------------------------------
; DATOS subflujo_8275: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8275..0x82b3  (62 bytes)
DATA_subflujo_8275:
	defb 0feh,001h,0e9h,008h,0f2h,00dh,0f1h,042h,0eah,009h,0edh,008h,0ebh,085h,045h,0dbh	; 8275  .......B......E.
	defb 002h,0d1h,005h,0ebh,085h,048h,001h,0ebh,085h,045h,025h,0ebh,085h,048h,021h,0dbh	; 8285  .....H...E%..H!.
	defb 005h,0ebh,081h,030h,0edh,007h,0d1h,040h,070h,040h,020h,0ebh,085h,048h,0d1h,041h	; 8295  ...0...@p@ ..H.A
	defb 021h,0ebh,085h,045h,005h,0ebh,081h,030h,0d2h,090h,0d1h,000h,0fah,0ffh	; 82a5  !..E...0......

; ----------------------------------------------------------------------
; DATOS subflujo_82B3: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x82b3..0x82dd  (42 bytes)
DATA_subflujo_82B3:
	defb 0feh,001h,0e9h,008h,0f2h,00dh,0f1h,041h,0eah,009h,0edh,007h,0ebh,085h,045h,0dbh	; 82b3  .......A......E.
	defb 005h,0d1h,022h,052h,001h,022h,002h,0ebh,081h,030h,0d2h,090h,0d1h,000h,0ebh,087h	; 82c3  .."R."...0......
	defb 013h,0edh,007h,0d2h,053h,0a3h,073h,043h,0fah,0ffh	; 82d3  ....S.sC..

; ----------------------------------------------------------------------
; DATOS subflujo_82DD: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x82dd..0x830f  (50 bytes)
DATA_subflujo_82DD:
	defb 0feh,001h,0e9h,008h,0f2h,00dh,0f1h,042h,0eah,009h,0edh,008h,0ebh,085h,045h,0dbh	; 82dd  .......B......E.
	defb 005h,0d2h,0a2h,0d1h,002h,0d2h,091h,0a3h,0ebh,083h,033h,091h,0dbh,006h,0edh,007h	; 82ed  ..........3.....
	defb 0ebh,084h,012h,050h,040h,0f1h,054h,0f2h,015h,0ebh,086h,034h,055h,021h,045h,071h	; 82fd  ...P@.T....4U!Eq
	defb 0fah,0ffh	; 830d

; ----------------------------------------------------------------------
; DATOS subflujo_830F: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x830f..0x833d  (46 bytes)
DATA_subflujo_830F:
	defb 0feh,001h,0e9h,008h,0f2h,00dh,0f1h,051h,0eah,009h,0edh,008h,0ebh,085h,025h,0dbh	; 830f  .......Q......%.
	defb 005h,0d2h,0a2h,0a2h,0a1h,0ebh,087h,046h,0d1h,003h,0d2h,093h,0d1h,003h,0ebh,084h	; 831f  .......F........
	defb 012h,0d2h,050h,070h,050h,070h,0ebh,087h,046h,093h,0d1h,003h,0fah,0ffh	; 832f  ..PpPp..F.....

; ----------------------------------------------------------------------
; DATOS subflujo_833D: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x833d..0x83a0  (99 bytes)
DATA_subflujo_833D:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,041h,0eah,009h,0ebh,085h,045h,0edh,008h,0dbh	; 833d  .......A....E...
	defb 005h,0d1h,092h,092h,091h,071h,021h,0edh,007h,0ebh,081h,011h,040h,070h,040h,020h	; 834d  .....q!.....@p@
	defb 0ebh,086h,045h,005h,0ebh,081h,011h,0d2h,070h,090h,0ebh,086h,045h,0d1h,005h,0ebh	; 835d  ..E.....p...E...
	defb 081h,011h,040h,070h,0ebh,085h,045h,092h,092h,091h,071h,021h,0ebh,081h,011h,040h	; 836d  ..@p..E...q!...@
	defb 020h,000h,0d2h,070h,0ebh,084h,012h,0edh,009h,0eah,00ah,0a0h,070h,090h,0a0h,0d1h	; 837d   ..p........p...
	defb 000h,0d2h,090h,0a0h,0d1h,000h,020h,0d2h,0a0h,0d1h,000h,020h,040h,020h,000h,0d2h	; 838d  ...... .... @ ..
	defb 0a0h,0fah,0ffh	; 839d

; ----------------------------------------------------------------------
; DATOS subflujo_83A0: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x83a0..0x83ef  (79 bytes)
DATA_subflujo_83A0:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,042h,0eah,009h,0ebh,081h,022h,0edh,008h,0dbh	; 83a0  .......B...."...
	defb 004h,0d2h,091h,070h,090h,0ebh,081h,032h,051h,0ebh,081h,021h,0d1h,021h,001h,0d2h	; 83b0  ...p...2Q..!.!..
	defb 0a0h,0d1h,000h,0ebh,081h,032h,0d2h,091h,0ebh,081h,021h,0d1h,041h,0ebh,085h,046h	; 83c0  .....2....!.A..F
	defb 055h,021h,0ebh,087h,036h,0d2h,077h,0a7h,097h,093h,0ebh,081h,011h,050h,040h,050h	; 83d0  U!..6.w......P@P
	defb 040h,0eah,00ah,0edh,009h,050h,070h,090h,070h,090h,070h,090h,0a0h,0fah,0ffh	; 83e0  @....Pp.p.p....

; ----------------------------------------------------------------------
; DATOS sonido12_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 12: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x83ef..0x8438  (73 bytes)
DATA_sonido12_canal0:
	defb 0feh,001h,0e9h,005h,0eah,008h,0ebh,043h,023h,0d3h,091h,0eah,00ah,0d2h,091h,071h	; 83ef  .......C#......q
	defb 0eah,008h,071h,0eah,00ah,091h,0eah,008h,091h,0eah,00ah,071h,091h,0eah,008h,091h	; 83ff  ..q........q....
	defb 0eah,00ah,091h,071h,091h,0d1h,001h,0d2h,0b1h,091h,071h,0eah,008h,0d3h,091h,0eah	; 840f  ...q......q.....
	defb 00ah,0d2h,091h,071h,0eah,008h,071h,0eah,00ah,091h,0eah,008h,091h,0eah,00ah,071h	; 841f  ...q..q........q
	defb 091h,0d1h,001h,021h,001h,041h,0eah,007h,041h	; 842f  ...!.A..A

; ----------------------------------------------------------------------
; DATOS subflujo_8438: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8438..0x85c1  (393 bytes)
DATA_subflujo_8438:
	defb 0feh,001h,0e9h,005h,0eah,00ah,0ebh,023h,023h,0f1h,044h,0f2h,00fh,0edh,009h,0d1h	; 8438  .......##.D.....
	defb 041h,021h,041h,0ebh,081h,023h,025h,001h,0ebh,013h,023h,0d2h,0b1h,0eah,008h,0b1h	; 8448  A!A..#%...#.....
	defb 0eah,00ah,071h,093h,0eah,009h,0ebh,017h,042h,0d1h,041h,071h,091h,0eah,007h,091h	; 8458  ..q.....B.Aq....
	defb 0eah,00ah,0ebh,023h,023h,041h,021h,041h,0ebh,081h,023h,025h,0ebh,023h,023h,001h	; 8468  ...##A!A..#%.##.
	defb 021h,041h,071h,0ebh,023h,034h,043h,0ebh,017h,042h,0eah,009h,071h,091h,0d0h,001h	; 8478  !Aq.#4C..B..q...
	defb 0eah,007h,001h,0eah,00ah,0ebh,023h,023h,0d1h,041h,021h,041h,0feh,001h,0e9h,005h	; 8488  ......##.A!A....
	defb 0eah,00ah,0edh,009h,0ebh,081h,023h,0f1h,044h,0f2h,00fh,0d1h,025h,001h,0ebh,013h	; 8498  ......#.D...%...
	defb 023h,0d2h,0b1h,0eah,008h,0b1h,0eah,00ah,071h,0ebh,023h,034h,093h,0ebh,017h,042h	; 84a8  #.......q.#4...B
	defb 0eah,009h,0d1h,041h,071h,091h,0eah,007h,091h,0eah,00ah,0ebh,023h,023h,041h,021h	; 84b8  ...Aq.......##A!
	defb 041h,021h,021h,001h,0eah,007h,001h,0eah,00ah,0d2h,0b1h,0eah,007h,0b1h,0eah,00ah	; 84c8  A!!.............
	defb 071h,091h,0eah,008h,091h,0eah,009h,0ebh,017h,042h,041h,071h,091h,0eah,007h,091h	; 84d8  q........BAq....
	defb 0eah,009h,0d1h,041h,071h,091h,0eah,007h,091h,0eah,009h,0d0h,041h,071h,091h,0eah	; 84e8  ...Aq.......Aq..
	defb 006h,091h,0eah,00ah,0ebh,023h,023h,0d2h,071h,0d1h,001h,021h,0feh,001h,0e9h,005h	; 84f8  .....##.q..!....
	defb 0eah,00ah,0edh,009h,0ebh,081h,023h,0f1h,044h,0f2h,00fh,0d1h,045h,041h,0ebh,023h	; 8508  ......#.D...EA.#
	defb 023h,021h,0eah,008h,021h,0eah,00ah,0ebh,013h,034h,021h,001h,0ebh,016h,023h,023h	; 8518  #!..!....4!...##
	defb 073h,0ebh,013h,023h,041h,0d2h,071h,0d1h,001h,021h,0ebh,081h,023h,043h,071h,041h	; 8528  s..#A.q..!..#CqA
	defb 091h,071h,041h,001h,0ebh,083h,032h,029h,0ebh,013h,023h,0d2h,071h,0d1h,001h,021h	; 8538  .qA...2)..#.q..!
	defb 0ebh,081h,023h,045h,041h,0ebh,023h,023h,021h,0eah,008h,021h,0eah,00ah,0ebh,013h	; 8548  ..#EA.##!..!....
	defb 034h,021h,001h,0ebh,016h,023h,023h,073h,0ebh,013h,023h,041h,091h,0d0h,001h,021h	; 8558  4!...##s..#A...!
	defb 0ebh,081h,023h,045h,041h,0ebh,013h,023h,021h,0d1h,0b1h,071h,0ebh,082h,043h,093h	; 8568  ..#EA..#!..q..C.
	defb 0feh,001h,0e9h,005h,0eah,00ah,0ebh,043h,023h,0d2h,091h,071h,0eah,008h,071h,0eah	; 8578  .......C#..q..q.
	defb 00ah,091h,0eah,008h,091h,0eah,00ah,071h,091h,0eah,008h,091h,0eah,00ah,091h,071h	; 8588  .......q.......q
	defb 091h,0d1h,001h,0d2h,0b1h,091h,071h,0eah,008h,0d3h,091h,0eah,00ah,0d2h,091h,071h	; 8598  ......q........q
	defb 0eah,008h,071h,0eah,00ah,091h,0eah,008h,091h,0eah,00ah,071h,091h,0d1h,001h,021h	; 85a8  ..q........q...!
	defb 001h,041h,0eah,007h,041h,0f9h,038h,084h,0ffh	; 85b8  .A..A.8..

; ----------------------------------------------------------------------
; DATOS sonido12_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 12: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x85c1..0x871f  (350 bytes)
DATA_sonido12_canal1:
	defb 0feh,001h,0e9h,005h,0eah,00ah,0ebh,043h,023h,0d4h,091h,0d3h,091h,0d4h,071h,0d3h	; 85c1  .......C#.....q.
	defb 071h,0d4h,091h,0d3h,091h,0d4h,091h,0d3h,091h,0d4h,021h,0d3h,021h,0d4h,021h,0d3h	; 85d1  q.........!.!.!.
	defb 021h,0d4h,041h,0d3h,041h,0d4h,041h,0d3h,041h,0d4h,091h,0d3h,091h,0d4h,071h,0d3h	; 85e1  !.A.A.A.A.....q.
	defb 071h,0d4h,091h,0d3h,091h,0d4h,091h,0d3h,091h,0d4h,051h,0d3h,051h,0d4h,051h,043h	; 85f1  q.........Q.Q.QC
	defb 0d3h,041h,0d4h,041h,0d3h,041h,0feh,001h,0e9h,005h,0eah,00ah,0ebh,033h,023h,0d4h	; 8601  .A.A.A.......3#.
	defb 0d4h,021h,0d3h,021h,0d4h,021h,0d3h,021h,0d4h,041h,0d3h,041h,0d4h,041h,0d3h,041h	; 8611  .!.!.!.!.A.A.A.A
	defb 0d4h,091h,0d3h,091h,0d4h,071h,0d3h,071h,0d4h,051h,0d3h,051h,0d4h,041h,0d3h,041h	; 8621  .....q.q.Q.Q.A.A
	defb 0d4h,021h,0d3h,021h,0d4h,021h,0d3h,021h,0d4h,071h,0d3h,071h,0d4h,071h,0d3h,071h	; 8631  .!.!.!.!.q.q.q.q
	defb 0d3h,001h,0d2h,001h,0d4h,071h,0d3h,071h,0d4h,091h,0d3h,091h,0d4h,041h,0d3h,041h	; 8641  .....q.q.....A.A
	defb 0d4h,051h,0d3h,051h,0d4h,051h,0d3h,051h,0d4h,041h,0d3h,041h,0d4h,041h,0d3h,041h	; 8651  .Q.Q.Q.Q.A.A.A.A
	defb 0d4h,091h,0d3h,091h,0d4h,071h,0d3h,071h,0d4h,051h,0d3h,051h,0d4h,041h,0d3h,041h	; 8661  .....q.q.Q.Q.A.A
	defb 0d4h,051h,0d3h,051h,0d4h,051h,0d3h,051h,0d4h,041h,0d3h,041h,0d4h,041h,0d3h,041h	; 8671  .Q.Q.Q.Q.A.A.A.A
	defb 0d4h,091h,0d3h,091h,0d4h,091h,0d3h,091h,0d4h,091h,0d3h,091h,0d4h,091h,0d3h,091h	; 8681  ................
	defb 0d4h,091h,0d3h,091h,091h,091h,0eah,008h,091h,0eah,00ah,0ebh,023h,022h,071h,0d2h	; 8691  ............#"q.
	defb 001h,0d3h,071h,0feh,001h,0e9h,005h,0eah,00ah,0ebh,023h,022h,0d3h,001h,0d2h,001h	; 86a1  ..q.......#"....
	defb 0d3h,001h,0d2h,001h,0d3h,021h,0d2h,021h,0d3h,021h,0d2h,021h,0d4h,071h,0d3h,071h	; 86b1  .....!.!.!.!.q.q
	defb 0d4h,071h,0d3h,071h,001h,0d2h,001h,0d4h,0b1h,0d3h,0b1h,0d4h,091h,0d3h,091h,0d4h	; 86c1  .q.q............
	defb 091h,0d3h,091h,0d4h,051h,0d3h,051h,0d4h,061h,0d3h,061h,0d4h,071h,0d3h,071h,0d4h	; 86d1  ....Q.Q.a.a.q.q.
	defb 071h,0d3h,071h,0d4h,071h,0d3h,071h,0d4h,071h,071h,0d3h,001h,0d2h,001h,0d3h,001h	; 86e1  q.q.q.q.qq......
	defb 0d2h,001h,0d3h,021h,0d2h,021h,0d3h,021h,0d2h,021h,0d4h,071h,0d3h,071h,0d4h,071h	; 86f1  ...!.!.!.!.q.q.q
	defb 0d3h,071h,0d4h,091h,0d3h,091h,0d4h,071h,0d3h,071h,0d4h,051h,0d3h,051h,0d4h,051h	; 8701  .q.....q.q.Q.Q.Q
	defb 0d3h,051h,0d4h,041h,0d3h,041h,0d4h,041h,0d3h,041h,0f9h,0c1h,085h,0ffh	; 8711  .Q.A.A.A.A....

; ----------------------------------------------------------------------
; DATOS sonido12_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 12: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x871f..0x8763  (68 bytes)
DATA_sonido12_canal2:
	defb 0feh,001h,0e9h,005h,0eah,007h,0ebh,043h,023h,0d3h,041h,0eah,009h,0d2h,041h,021h	; 871f  .......C#.A...A!
	defb 0eah,007h,021h,0eah,009h,041h,0eah,007h,041h,0eah,009h,021h,041h,0eah,008h,041h	; 872f  ..!..A..A..!A..A
	defb 0eah,009h,051h,041h,051h,091h,071h,051h,041h,0eah,007h,041h,0eah,009h,041h,021h	; 873f  ..QAQ.qQA..A..A!
	defb 0eah,007h,021h,0eah,009h,041h,0eah,007h,041h,0eah,009h,021h,041h,091h,091h,091h	; 874f  ..!..A..A..!A...
	defb 081h,0eah,006h,081h	; 875f

; ----------------------------------------------------------------------
; DATOS subflujo_8763: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8763..0x88f9  (406 bytes)
DATA_subflujo_8763:
	defb 0feh,001h,0e9h,005h,0eah,009h,0ebh,023h,023h,0f1h,044h,0f2h,010h,0edh,008h,0d1h	; 8763  .......##.D.....
	defb 001h,0d2h,0b1h,0d1h,001h,0ebh,081h,023h,0d2h,095h,071h,0ebh,013h,023h,071h,0eah	; 8773  .......#..q..#q.
	defb 007h,071h,0eah,009h,021h,0ebh,023h,034h,043h,0ebh,017h,042h,0eah,008h,0b1h,0d1h	; 8783  .q..!.#4C..B....
	defb 021h,041h,0eah,006h,041h,0eah,009h,0ebh,023h,023h,001h,0d2h,0b1h,0d1h,001h,0ebh	; 8793  !A..A...##......
	defb 081h,023h,0d2h,095h,0ebh,023h,023h,071h,091h,0b1h,0d1h,021h,0ebh,023h,034h,003h	; 87a3  .#...##q...!.#4.
	defb 0eah,008h,0ebh,017h,042h,041h,051h,071h,0eah,006h,071h,0eah,009h,0ebh,023h,023h	; 87b3  ....BAQq..q...##
	defb 001h,0d2h,0b1h,0d1h,001h,0feh,001h,0e9h,005h,0eah,009h,0edh,008h,0ebh,081h,023h	; 87c3  ...............#
	defb 0f1h,044h,0f2h,010h,0d2h,095h,071h,0ebh,013h,023h,071h,0eah,007h,071h,0eah,009h	; 87d3  .D....q..#q..q..
	defb 021h,0ebh,023h,034h,043h,0ebh,017h,042h,0eah,008h,0b1h,0d1h,021h,041h,0eah,006h	; 87e3  !.#4C..B....!A..
	defb 041h,0eah,009h,0ebh,023h,023h,001h,0d2h,0b1h,0d1h,001h,0d2h,091h,091h,071h,0eah	; 87f3  A...##........q.
	defb 007h,071h,0eah,009h,071h,0eah,007h,071h,0eah,009h,021h,041h,0eah,007h,041h,0eah	; 8803  .q..q..q..!A..A.
	defb 008h,0ebh,017h,042h,0d3h,0b1h,0d2h,021h,041h,0eah,006h,041h,0eah,008h,0b1h,0d1h	; 8813  ...B...!A..A....
	defb 021h,041h,0eah,006h,041h,0eah,008h,0b1h,0d0h,021h,041h,0eah,006h,041h,0eah,009h	; 8823  !A..A....!A..A..
	defb 0ebh,023h,023h,0d2h,041h,071h,0b1h,0feh,001h,0e9h,005h,0eah,009h,0edh,008h,0ebh	; 8833  .##.Aq..........
	defb 081h,023h,0f1h,044h,0f2h,010h,0d1h,005h,001h,0ebh,023h,023h,0d2h,091h,0eah,007h	; 8843  .#.D......##....
	defb 091h,0eah,009h,0ebh,023h,034h,091h,071h,0ebh,080h,023h,093h,0d1h,023h,0ebh,023h	; 8853  ....#4.q..#..#.#
	defb 023h,001h,0d2h,041h,071h,071h,0ebh,080h,022h,0d1h,003h,021h,001h,041h,021h,001h	; 8863  #..Aqq.."..!.A!.
	defb 0d2h,091h,0d1h,003h,0d2h,093h,0ebh,023h,023h,0b1h,051h,091h,0b1h,0ebh,081h,023h	; 8873  .......##.Q....#
	defb 0d1h,005h,001h,0ebh,023h,023h,0d2h,091h,0eah,007h,091h,0eah,009h,0ebh,023h,034h	; 8883  ....##........#4
	defb 091h,071h,0ebh,080h,023h,093h,0d1h,023h,0ebh,023h,023h,001h,041h,071h,091h,0ebh	; 8893  .q..#..#.##.Aq..
	defb 081h,023h,0d0h,005h,001h,0ebh,081h,022h,0d1h,0b1h,071h,021h,0ebh,082h,042h,043h	; 88a3  .#....."..q!..BC
	defb 0feh,001h,0e9h,005h,0eah,009h,0ebh,043h,023h,0d2h,041h,021h,0eah,007h,021h,0eah	; 88b3  .......C#.A!..!.
	defb 009h,041h,0eah,007h,041h,0eah,009h,021h,041h,0eah,008h,041h,0eah,009h,051h,041h	; 88c3  .A..A..!A..A..QA
	defb 051h,091h,071h,051h,041h,0eah,007h,041h,0eah,009h,041h,021h,0eah,007h,021h,0eah	; 88d3  Q.qQA..A..A!..!.
	defb 009h,041h,0eah,007h,041h,0eah,009h,021h,041h,091h,091h,091h,081h,0eah,006h,081h	; 88e3  .A..A..!A.......
	defb 0eah,009h,0f9h,063h,087h,0ffh	; 88f3

; ----------------------------------------------------------------------
; DATOS sonido13_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 13: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x88f9..0x8925  (44 bytes)
DATA_sonido13_canal0:
	defb 0feh,001h,0e9h,006h,0c2h,0feh,001h,0e9h,007h,0f2h,00bh,0f1h,052h,0eah,00ah,0d6h	; 88f9  ............R...
	defb 002h,001h,0ebh,003h,050h,0d2h,0c1h,0b0h,0b0h,091h,0b1h,0d1h,022h,040h,063h,040h	; 8909  ....P......."@c@
	defb 060h,090h,060h,091h,0b1h,0f1h,051h,0ebh,003h,030h,0b3h,0ffh	; 8919  `.`...Q..0..

; ----------------------------------------------------------------------
; DATOS sonido13_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 13: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8925..0x8956  (49 bytes)
DATA_sonido13_canal1:
	defb 0feh,001h,0e9h,006h,0c2h,0feh,001h,0e9h,007h,0eah,00ah,0d6h,012h,003h,0ebh,004h	; 8925  ................
	defb 040h,0d4h,0b3h,0d6h,006h,003h,0ebh,003h,051h,0b1h,0b0h,0b0h,0b1h,0b0h,0b0h,0b1h	; 8935  @.......Q.......
	defb 0b0h,0b0h,0d6h,003h,002h,0d3h,041h,040h,040h,061h,061h,0ebh,004h,030h,0d4h,0b3h	; 8945  ......A@@aa..0..
	defb 0ffh	; 8955

; ----------------------------------------------------------------------
; DATOS sonido13_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 13: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8956..0x8982  (44 bytes)
DATA_sonido13_canal2:
	defb 0feh,001h,0e9h,006h,0c2h,0feh,001h,0e9h,007h,0f2h,00bh,0f1h,052h,0eah,009h,0d6h	; 8956  ............R...
	defb 002h,001h,0ebh,003h,050h,0d2h,0c1h,060h,060h,041h,061h,092h,0b0h,0b3h,0b0h,0d1h	; 8966  ....P..``Aa.....
	defb 010h,040h,0d2h,0b0h,0d1h,041h,061h,0ebh,003h,030h,063h,0ffh	; 8976  .@...Aa..0c.

; ----------------------------------------------------------------------
; DATOS sonido14_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 14: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8982..0x89cd  (75 bytes)
DATA_sonido14_canal0:
	defb 0feh,001h,0e9h,005h,0f2h,008h,0f1h,046h,0ebh,086h,020h,0edh,009h,0eah,009h,0c1h	; 8982  .......F.. .....
	defb 0d2h,041h,0eah,00ah,0ebh,003h,023h,0f2h,01ah,0f1h,043h,0d2h,091h,0efh,0d1h,001h	; 8992  .A....#...C.....
	defb 021h,0ebh,082h,014h,0dch,0d6h,002h,002h,047h,0ebh,003h,043h,0d8h,041h,0ebh,003h	; 89a2  !.......G..C.A..
	defb 023h,0dbh,007h,071h,021h,041h,071h,0ebh,004h,020h,0d0h,001h,0d1h,0ebh,003h,045h	; 89b2  #..q!Aq.. .....E
	defb 0b1h,071h,0f1h,052h,0ebh,086h,033h,0dbh,007h,099h,0ffh	; 89c2  .q.R..3....

; ----------------------------------------------------------------------
; DATOS sonido14_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 14: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x89cd..0x8a1a  (77 bytes)
DATA_sonido14_canal1:
	defb 0feh,001h,0e9h,005h,0f1h,046h,0f2h,005h,0edh,009h,0dbh,006h,0eah,009h,0ebh,086h	; 89cd  .....F..........
	defb 020h,0c1h,0d3h,081h,0ebh,003h,023h,0eah,00ah,0f2h,008h,091h,071h,051h,0eah,00bh	; 89dd   .....#.....qQ..
	defb 0d4h,043h,0eah,00ah,0d8h,0ebh,003h,043h,0d3h,0b1h,0d2h,041h,0d3h,041h,0d6h,006h	; 89ed  .C.....C...A.A..
	defb 002h,0dbh,006h,0ebh,083h,043h,0eeh,001h,021h,0efh,0d8h,0ebh,003h,043h,091h,0d2h	; 89fd  .....C..!....C..
	defb 021h,0d3h,021h,051h,041h,0d4h,041h,0eah,00bh,0f1h,069h,099h,0ffh	; 8a0d  !.!QA.A...i..

; ----------------------------------------------------------------------
; DATOS sonido14_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 14: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8a1a..0x8a4a  (48 bytes)
DATA_sonido14_canal2:
	defb 0feh,001h,0e9h,005h,0f1h,052h,0eah,008h,0edh,008h,0ebh,003h,020h,0c1h,0d3h,0b1h	; 8a1a  .....R...... ...
	defb 0eah,009h,0ebh,003h,023h,0d2h,041h,071h,091h,0b1h,071h,091h,0b1h,071h,0d1h,021h	; 8a2a  ....#.Aq..q..q.!
	defb 0d2h,091h,0b1h,0d1h,021h,0d2h,091h,071h,021h,0ebh,087h,023h,0f1h,054h,009h,0ffh	; 8a3a  ....!..q!..#.T..

; ----------------------------------------------------------------------
; DATOS sonido15_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 15: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8a4a..0x8abb  (113 bytes)
DATA_sonido15_canal0:
	defb 0feh,001h,0e9h,008h,0ebh,025h,022h,0eah,00ah,0d4h,070h,0eah,008h,070h,0eah,009h	; 8a4a  .....%"...p..p..
	defb 0d3h,070h,070h,0d4h,040h,0eah,008h,040h,0eah,00ah,0d3h,040h,0eah,008h,040h,0eah	; 8a5a  .pp.@..@...@..@.
	defb 00ah,0d4h,020h,0eah,008h,020h,0eah,00ah,0d3h,020h,0eah,008h,020h,0eah,00ah,0d5h	; 8a6a  .. .. ... .. ...
	defb 0b0h,0eah,008h,0b0h,0eah,00ah,0d4h,0b0h,0eah,008h,0b0h,0eah,00ah,0ebh,012h,020h	; 8a7a  ...............
	defb 0d4h,090h,0edh,009h,0ebh,080h,020h,0d3h,0b0h,070h,040h,0eah,00ah,0ebh,012h,020h	; 8a8a  ...... ..p@....
	defb 0d4h,020h,0ebh,080h,020h,0d3h,020h,090h,070h,0ebh,087h,022h,0dbh,005h,0d4h,0a1h	; 8a9a  . .. . .p.."....
	defb 090h,080h,0ebh,084h,010h,070h,0ech,0eah,008h,070h,0eah,006h,070h,0eah,004h,070h	; 8aaa  .....p...p..p..p
	defb 0ffh	; 8aba

; ----------------------------------------------------------------------
; DATOS sonido15_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 15: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8abb..0x8b22  (103 bytes)
DATA_sonido15_canal1:
	defb 0feh,001h,0e9h,008h,0f1h,064h,0f2h,010h,0edh,008h,0ebh,0a1h,033h,0eah,009h,0d1h	; 8abb  .....d......3...
	defb 020h,020h,020h,0eah,007h,020h,0eah,009h,0d2h,0b0h,0eah,007h,0b0h,0eah,009h,0b0h	; 8acb     .. ..........
	defb 0eah,007h,0b0h,0eah,009h,090h,0eah,007h,090h,0eah,009h,0b0h,0eah,007h,0b0h,0eah	; 8adb  ................
	defb 009h,0edh,006h,0ebh,084h,012h,0edh,009h,0dbh,004h,0f1h,053h,063h,0edh,008h,0eah	; 8aeb  ...........Sc...
	defb 009h,0ebh,097h,041h,040h,060h,020h,0d3h,0b0h,090h,0b0h,0d2h,040h,020h,0ebh,004h	; 8afb  ...A@` .....@ ..
	defb 034h,0edh,008h,0eah,007h,0ebh,006h,034h,051h,040h,030h,0ech,020h,0eah,006h,020h	; 8b0b  4......4Q@0. ..
	defb 0eah,005h,020h,0eah,004h,020h,0ffh	; 8b1b

; ----------------------------------------------------------------------
; DATOS sonido15_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 15: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8b22..0x8b7a  (88 bytes)
DATA_sonido15_canal2:
	defb 0feh,001h,0e9h,008h,0f1h,053h,0edh,008h,0ebh,013h,072h,0eah,00ah,0d1h,070h,070h	; 8b22  .....S....r...pp
	defb 070h,0eah,008h,070h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h	; 8b32  p..p..@..@..@..@
	defb 0eah,00ah,020h,0eah,008h,020h,0eah,00ah,040h,0eah,008h,040h,0f1h,043h,0f2h,00dh	; 8b42  .. .. ..@..@.C..
	defb 0eah,00ah,0ebh,083h,012h,0dbh,005h,0edh,00ah,0d2h,0b3h,0ebh,083h,022h,0eah,009h	; 8b52  ............."..
	defb 0edh,009h,090h,0b0h,070h,040h,020h,040h,090h,075h,0ech,0eah,005h,070h,0eah,004h	; 8b62  ....p@ @.u...p..
	defb 070h,0eah,003h,070h,0eah,002h,070h,0ffh	; 8b72  p..p..p.

; ----------------------------------------------------------------------
; DATOS sonido16_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 16: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8b7a..0x8bdd  (99 bytes)
DATA_sonido16_canal0:
	defb 0feh,001h,0e9h,007h,0f1h,042h,0f2h,008h,0eah,00ah,0ebh,004h,023h,0d1h,070h,0eah	; 8b7a  .....B......#.p.
	defb 008h,070h,0eah,00ah,020h,020h,070h,0eah,008h,070h,0eah,00ah,0ebh,004h,022h,072h	; 8b8a  .p..  p..p...."r
	defb 0eah,007h,070h,0eah,00ah,0ebh,004h,023h,010h,010h,070h,0eah,008h,070h,0eah,00ah	; 8b9a  ..p....#..p..p..
	defb 0ebh,004h,022h,072h,0eah,007h,070h,0eah,00ah,0ebh,004h,023h,000h,000h,070h,0eah	; 8baa  .."r..p....#..p.
	defb 008h,070h,0eah,00ah,0ebh,004h,022h,072h,0eah,007h,070h,0eah,00ah,0ebh,004h,023h	; 8bba  .p...."r..p....#
	defb 070h,0eah,008h,070h,0eah,00ah,060h,060h,060h,060h,0feh,001h,0e9h,007h,0eah,00ah	; 8bca  p..p..````......
	defb 0ebh,090h,032h	; 8bda

; ----------------------------------------------------------------------
; DATOS subflujo_8BDD: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8bdd..0x8c9b  (190 bytes)
DATA_subflujo_8BDD:
	defb 0edh,009h,0d3h,0b0h,0eah,00ah,0d1h,020h,040h,0d2h,0b0h,0d1h,020h,040h,0d2h,0b0h	; 8bdd  ....... @... @..
	defb 0d1h,020h,040h,070h,020h,040h,070h,090h,040h,0ech,0e9h,001h,0eah,008h,073h,0eah	; 8bed  . @p @p.@.....s.
	defb 009h,092h,0ebh,090h,032h,0d8h,0e9h,007h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah	; 8bfd  ....2...........
	defb 090h,070h,040h,0eah,008h,040h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah,070h,040h	; 8c0d  .p@..@........p@
	defb 020h,0eah,007h,020h,0eah,00ah,0d0h,070h,040h,020h,0d1h,0b0h,0fbh,002h,0ddh,08bh	; 8c1d   .. ...p@ ......
	defb 0feh,001h,0e9h,007h,0f1h,052h,0f2h,007h,0eah,00ah,0edh,008h,0ebh,087h,010h,0d1h	; 8c2d  .....R..........
	defb 045h,0d8h,071h,0ebh,080h,011h,0b3h,0ebh,087h,011h,091h,0eah,009h,071h,0ebh,091h	; 8c3d  E.q..........q..
	defb 011h,0d0h,070h,090h,040h,070h,020h,040h,0d1h,0b0h,0d0h,020h,0d1h,090h,0b0h,070h	; 8c4d  ..p.@p @... ...p
	defb 090h,040h,070h,020h,040h,0eah,00ah,0ebh,087h,010h,0f1h,053h,035h,071h,0ebh,080h	; 8c5d  .@p @......S5q..
	defb 011h,0b3h,0ebh,087h,011h,091h,0eah,009h,071h,0eah,00ah,0ebh,004h,012h,0f1h,062h	; 8c6d  ........q......b
	defb 0d6h,001h,001h,0eah,009h,0d0h,021h,020h,004h,0d1h,0a1h,0a0h,032h,0d8h,0f1h,042h	; 8c7d  ......! ....2..B
	defb 0f2h,008h,0eah,00ah,0ebh,004h,023h,0d1h,090h,070h,0f9h,07ah,08bh,0ffh	; 8c8d  ......#..p.z..

; ----------------------------------------------------------------------
; DATOS sonido16_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 16: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8c9b..0x8d01  (102 bytes)
DATA_sonido16_canal1:
	defb 0feh,001h,0e9h,007h,0f1h,048h,0f2h,008h,0eah,00ah,0ebh,004h,023h,0d3h,040h,0eah	; 8c9b  .....H......#.@.
	defb 008h,040h,0eah,00ah,0d2h,040h,040h,0d3h,040h,0eah,008h,040h,0eah,00ah,0ebh,004h	; 8cab  .@...@@.@..@....
	defb 022h,032h,0eah,007h,030h,0eah,00ah,0ebh,004h,023h,0d2h,030h,030h,0d3h,030h,0eah	; 8cbb  "2..0....#.00.0.
	defb 008h,030h,0eah,00ah,0ebh,004h,022h,022h,0eah,007h,020h,0eah,00ah,0ebh,004h,023h	; 8ccb  .0...."".. ....#
	defb 0d2h,020h,020h,0d3h,020h,0eah,008h,020h,0eah,00ah,0ebh,004h,022h,0d4h,022h,0eah	; 8cdb  .  . .. ....".".
	defb 007h,0ebh,004h,023h,020h,0eah,00ah,0d3h,020h,0eah,008h,020h,0eah,00ah,0d4h,020h	; 8ceb  ...# ... .. ...
	defb 0d3h,020h,0d2h,020h,0d3h,020h	; 8cfb

; ----------------------------------------------------------------------
; DATOS subflujo_8D01: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8d01..0x8d82  (129 bytes)
DATA_subflujo_8D01:
	defb 0feh,001h,0e9h,007h,0f1h,06ah,0f2h,00dh,0eah,009h,0ebh,004h,021h,0d7h,003h,004h	; 8d01  .....j......!...
	defb 0d4h,071h,0ebh,004h,023h,0d3h,090h,090h,0ebh,004h,021h,0d4h,071h,043h,0ebh,004h	; 8d11  .q..#.....!.qC..
	defb 023h,0d3h,070h,070h,0ebh,004h,021h,0d4h,041h,093h,0ebh,004h,023h,0d3h,070h,070h	; 8d21  #.pp..!.A...#.pp
	defb 0ebh,004h,021h,0d4h,091h,0f1h,08fh,023h,0ebh,004h,023h,0d3h,060h,060h,0d8h,0d4h	; 8d31  ..!....#..#.``..
	defb 020h,0d3h,020h,090h,020h,0fbh,002h,001h,08dh,0feh,001h,0e9h,007h,0eah,00ah,0f1h	; 8d41   . . ...........
	defb 04bh,0f2h,012h,0d6h,004h,008h,0ebh,004h,021h,0d3h,005h,0eah,009h,075h,003h,0d8h	; 8d51  K.......!....u..
	defb 003h,0d2h,003h,0d3h,001h,001h,0d2h,003h,0eah,00ah,0d3h,005h,025h,033h,0eah,009h	; 8d61  ............%3..
	defb 003h,0d2h,003h,0eah,00ah,0d3h,031h,031h,0eah,009h,0d2h,033h,0d8h,0f9h,09bh,08ch	; 8d71  ......11...3....
	defb 0ffh	; 8d81

; ----------------------------------------------------------------------
; DATOS sonido16_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 16: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8d82..0x8dc4  (66 bytes)
DATA_sonido16_canal2:
	defb 0feh,001h,0e9h,007h,0f1h,042h,0f2h,009h,0eah,009h,0ebh,004h,023h,0d2h,0b0h,0eah	; 8d82  .....B......#...
	defb 007h,0b0h,0eah,009h,0b0h,0b0h,0b0h,0eah,007h,0b0h,0eah,009h,0ebh,004h,022h,0a3h	; 8d92  ..............".
	defb 0ebh,004h,023h,0a0h,0a0h,0a0h,0eah,007h,0a0h,0eah,009h,0ebh,004h,022h,093h,0ebh	; 8da2  ..#.........."..
	defb 004h,023h,090h,090h,090h,090h,0d1h,000h,000h,040h,040h,000h,000h,0d2h,090h,090h	; 8db2  .#.......@@.....
	defb 090h,090h	; 8dc2

; ----------------------------------------------------------------------
; DATOS subflujo_8DC4: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8dc4..0x8e39  (117 bytes)
DATA_subflujo_8DC4:
	defb 0feh,001h,0e9h,007h,0f1h,046h,0f2h,00ch,0eah,009h,0ebh,014h,023h,0d7h,002h,004h	; 8dc4  .....F......#...
	defb 0d2h,020h,0eah,007h,020h,0eah,009h,0ebh,004h,023h,0d3h,0b0h,0b0h,0ebh,014h,023h	; 8dd4  . .. ....#.....#
	defb 0d2h,020h,0eah,007h,020h,0eah,009h,022h,0eah,007h,020h,0eah,009h,0ebh,004h,023h	; 8de4  . .. ..".. ....#
	defb 0d3h,0b0h,0b0h,0ebh,014h,023h,0d2h,020h,0eah,007h,020h,0eah,009h,022h,0eah,007h	; 8df4  .....#. .. .."..
	defb 020h,0eah,009h,0ebh,004h,023h,0d3h,090h,090h,0ebh,014h,023h,0d2h,020h,0eah,007h	; 8e04   ....#.....#. ..
	defb 020h,0eah,009h,022h,0eah,007h,020h,0eah,009h,0ebh,004h,023h,0d3h,090h,090h,0d8h	; 8e14   ..".. ....#....
	defb 060h,0d2h,000h,0d1h,020h,0d2h,000h,0fbh,002h,0c4h,08dh,0d8h,0feh,001h,0e9h,007h	; 8e24  `... ...........
	defb 0eah,008h,0ebh,091h,032h	; 8e34

; ----------------------------------------------------------------------
; DATOS subflujo_8E39: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x8e39..0x8e77  (62 bytes)
DATA_subflujo_8E39:
	defb 0edh,006h,0d6h,002h,002h,0d2h,000h,070h,0d1h,000h,0d2h,070h,0d1h,000h,0d2h,070h	; 8e39  .......p...p...p
	defb 000h,070h,000h,070h,0d1h,000h,0d2h,070h,0d1h,000h,0d2h,070h,000h,070h,000h,070h	; 8e49  .p.p...p...p.p.p
	defb 0d1h,000h,0d2h,070h,070h,0d1h,000h,070h,000h,0d2h,000h,070h,0d1h,000h,0d2h,070h	; 8e59  ...pp..p...p...p
	defb 0d1h,000h,0d2h,070h,000h,070h,0fbh,002h,039h,08eh,0f9h,082h,08dh,0ffh	; 8e69  ...p.p..9.....

; ----------------------------------------------------------------------
; DATOS sonido03_canal3: el flujo de ordenes y notas del canal 3 (efecto) del
;   sonido 3: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8e77..0x8e9a  (35 bytes)
DATA_sonido03_canal3:
	defb 0feh,002h,0e2h,002h,0a0h,064h,090h,032h,070h,019h,080h,064h,080h,032h,060h,019h	; 8e77  .....d.2p..d.2`.
	defb 060h,064h,060h,032h,050h,019h,060h,064h,060h,032h,050h,019h,040h,064h,040h,032h	; 8e87  `d`2P.`d`2P.@d@2
	defb 030h,019h,0ffh	; 8e97

; ----------------------------------------------------------------------
; DATOS sonido03_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 3: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8e9a..0x8ebd  (35 bytes)
DATA_sonido03_canal4:
	defb 0feh,002h,0e2h,002h,090h,085h,080h,042h,060h,021h,070h,085h,070h,042h,050h,021h	; 8e9a  .......B`!p.pBP!
	defb 050h,085h,050h,042h,040h,021h,050h,085h,050h,042h,040h,021h,030h,085h,030h,042h	; 8eaa  P.PB@!P.PB@!0.0B
	defb 020h,021h,0ffh	; 8eba

; ----------------------------------------------------------------------
; DATOS sonido04_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 4: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8ebd..0x8ed0  (19 bytes)
DATA_sonido04_canal4:
	defb 0feh,002h,0e1h,001h,0e4h,00ch,0e5h,000h,000h,080h,000h,0e4h,006h,0e1h,002h,003h	; 8ebd  ................
	defb 002h,001h,0ffh	; 8ecd

; ----------------------------------------------------------------------
; DATOS sonido05_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 5: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8ed0..0x8fd8  (264 bytes)
DATA_sonido05_canal4:
	defb 0feh,002h,0e2h,002h,050h,030h,060h,031h,070h,032h,070h,033h,070h,034h,070h,035h	; 8ed0  ....P0`1p2p3p4p5
	defb 070h,036h,070h,037h,070h,038h,070h,039h,070h,03ah,070h,03bh,070h,03ch,070h,03dh	; 8ee0  p6p7p8p9p:p.p<p=
	defb 070h,03eh,070h,03fh,070h,040h,070h,041h,070h,042h,070h,043h,0e2h,001h,070h,044h	; 8ef0  p>p?p@pApBpC..pD
	defb 070h,045h,070h,046h,070h,047h,070h,048h,070h,049h,070h,04ah,070h,04bh,070h,04ch	; 8f00  pEpFpGpHpIpJpKpL
	defb 070h,04dh,070h,04eh,070h,04fh,060h,050h,050h,051h,0feh,002h,0e4h,007h,0e3h,002h	; 8f10  pMpNpO`PPQ......
	defb 0e5h,009h,000h,00bh,000h,048h,0e0h,002h,0e3h,002h,0e5h,009h,000h,00bh,000h,048h	; 8f20  .....H.........H
	defb 0e0h,00bh,0e3h,002h,0e5h,009h,000h,00bh,000h,048h,0e0h,001h,0e3h,002h,0e5h,009h	; 8f30  .........H......
	defb 000h,00bh,000h,048h,0e0h,009h,0feh,002h,0e4h,007h,0e3h,002h,0e5h,009h,000h,00bh	; 8f40  ...H............
	defb 000h,048h,0e3h,002h,0e5h,009h,000h,00bh,000h,048h,0e8h,0e0h,006h,0e3h,002h,0e5h	; 8f50  .H.......H......
	defb 009h,000h,00bh,000h,048h,0e3h,002h,0e5h,009h,000h,00bh,000h,048h,0e8h,0e0h,006h	; 8f60  ....H.......H...
	defb 0e3h,001h,0e5h,009h,000h,00bh,000h,048h,0e0h,006h,0e3h,001h,0e5h,009h,000h,00bh	; 8f70  .......H........
	defb 000h,048h,0e8h,0e0h,004h,0feh,002h,0e4h,007h,0e3h,001h,0e5h,009h,000h,00bh,000h	; 8f80  .H..............
	defb 048h,0e0h,003h,0e3h,001h,0e5h,009h,000h,00bh,000h,048h,0e0h,003h,0e3h,001h,0e5h	; 8f90  H.........H.....
	defb 009h,000h,00bh,000h,048h,0e0h,002h,0e3h,001h,0e5h,009h,000h,009h,000h,048h,0e0h	; 8fa0  ....H.........H.
	defb 002h,0e3h,001h,0e5h,009h,000h,007h,000h,048h,0e0h,002h,0e3h,001h,0e5h,009h,000h	; 8fb0  ........H.......
	defb 005h,000h,048h,0e0h,001h,0e3h,001h,0e5h,009h,000h,003h,000h,048h,0e0h,001h,0e3h	; 8fc0  ..H.........H...
	defb 001h,0e5h,009h,000h,001h,000h,048h,0ffh	; 8fd0  ......H.

; ----------------------------------------------------------------------
; DATOS sonido06_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 6: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8fd8..0x8ff9  (33 bytes)
DATA_sonido06_canal4:
	defb 0feh,002h,0e2h,001h,0a0h,0a8h,090h,050h,050h,038h,000h,000h,000h,000h,000h,000h	; 8fd8  .......PP8......
	defb 060h,0a8h,060h,050h,030h,038h,000h,000h,000h,000h,030h,0a8h,020h,050h,010h,038h	; 8fe8  `.`P08....0. P.8
	defb 0ffh	; 8ff8

; ----------------------------------------------------------------------
; DATOS sonido07_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 7: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x8ff9..0x9026  (45 bytes)
DATA_sonido07_canal4:
	defb 0feh,002h,0e2h,001h,0a0h,0bch,0a0h,08eh,080h,047h,050h,08ch,050h,06ah,020h,035h	; 8ff9  .........GP.Pj 5
	defb 000h,000h,090h,08ch,090h,06ah,060h,035h,000h,000h,000h,000h,040h,08ch,040h,06ah	; 9009  .....j`5....@.@j
	defb 010h,035h,000h,000h,000h,000h,020h,08ch,020h,06ah,000h,035h,0ffh	; 9019  .5.... . j.5.

; ----------------------------------------------------------------------
; DATOS sonido08_canal4: el flujo de ordenes y notas del canal 4 (efecto) del
;   sonido 8: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x9026..0x9040  (26 bytes)
DATA_sonido08_canal4:
	defb 0feh,002h,0e1h,001h,0e4h,00ah,000h,007h,0e0h,002h,0e1h,001h,0e4h,005h,0e5h,009h	; 9026  ................
	defb 000h,040h,000h,0e1h,001h,0e4h,004h,001h,000h,0ffh	; 9036  .@........

; ----------------------------------------------------------------------
; DATOS voz_0x11: la voz digital 0x11 (el primer byte, 0xAD, es la marca del
;   final): dos nibbles de salto por byte (p12:6292), hasta que un byte repite
;   esa marca
;   0x9040..0x94c4  (1156 bytes)
DATA_voz_0x11:
	defb 0adh,030h,01fh,00fh,00fh,001h,0f1h,0f0h,0f1h,0ffh,00fh,00fh,01fh,000h,00fh,000h	; 9040  .0..............
	defb 000h,000h,001h,000h,000h,000h,00fh,000h,01fh,010h,010h,000h,000h,001h,001h,000h	; 9050  ................
	defb 000h,010h,01fh,01fh,000h,00fh,000h,0f0h,0e0h,0f0h,0f0h,000h,001h,001h,020h,021h	; 9060  .............. !
	defb 010h,020h,011h,002h,002h,002h,000h,00eh,0feh,0fdh,0edh,0ddh,0ddh,0ddh,0ddh,0f2h	; 9070  . ..............
	defb 023h,044h,044h,044h,043h,02fh,0eeh,0deh,0eeh,0eeh,0e0h,0ffh,00fh,0efh,0dch,0cbh	; 9080  #DDDC/..........
	defb 0bbh,0bch,0f4h,055h,056h,055h,043h,0ddh,0edh,0ddh,0edh,0d1h,0e1h,012h,020h,032h	; 9090  ...UVUC....... 2
	defb 013h,0ddh,0bbh,0bah,0abh,024h,034h,066h,066h,055h,0cbh,0bbh,0bbh,0cfh,035h,043h	; 90a0  .....$4ffU....5C
	defb 043h,033h,033h,024h,03eh,0ddh,0cbh,0bah,09bh,0e3h,043h,046h,067h,056h,03bh,0bah	; 90b0  C33$>.....CFgV..
	defb 0abh,0bbh,014h,055h,055h,044h,044h,03fh,03fh,0ddh,0cbh,0bbh,0a9h,0b2h,043h,044h	; 90c0  ...UUDD??.....CD
	defb 066h,076h,063h,0bah,0aah,0abh,0b2h,045h,055h,065h,044h,04dh,012h,0ech,0dch,0bbh	; 90d0  fvc....EUeDM....
	defb 0aah,0abh,0c3h,043h,046h,077h,055h,0fbh,0aah,0aah,0a2h,035h,055h,065h,053h,043h	; 90e0  ...CFwU....5UeSC
	defb 0f2h,02dh,0dch,0bbh,0aah,09dh,0e4h,043h,046h,077h,064h,0dbh,0aah,09ah,0c0h,045h	; 90f0  .-.....CFwd....E
	defb 065h,056h,044h,033h,0e1h,01dh,0cch,0bbh,0a9h,0aeh,034h,034h,046h,077h,061h,0dbh	; 9100  eVD3......44Fwa.
	defb 0a9h,0aah,0b3h,055h,065h,065h,054h,001h,0e2h,0ddh,0cbh,0bah,09ah,0c1h,043h,043h	; 9110  ...UeeT.......CC
	defb 067h,076h,04dh,0bah,09ah,0abh,034h,056h,056h,055h,042h,03fh,02fh,0dch,0bbh,0a9h	; 9120  gvM...4VVUB?/...
	defb 0ach,0f4h,034h,036h,077h,063h,0dbh,0a9h,0aah,0b3h,055h,066h,055h,054h,022h,0e3h	; 9130  ..46wc....UfUT".
	defb 0dch,0bbh,0bah,09ah,0e4h,034h,045h,067h,075h,03ch,0aah,09ah,0bfh,045h,056h,064h	; 9140  .....4Egu<...EVd
	defb 054h,034h,032h,0ech,0bbh,0bah,09ah,0d3h,043h,045h,077h,065h,03bh,0aah,0aah,0a3h	; 9150  T42.....CEwe....
	defb 045h,055h,064h,054h,044h,033h,0dch,0bbh,0a9h,0abh,0d3h,044h,036h,077h,064h,0bbh	; 9160  EUdTD3.....D6wd.
	defb 0a9h,0bbh,0b4h,045h,056h,053h,054h,044h,030h,0cbh,0bah,0a9h,0bch,034h,034h,066h	; 9170  ...EVSTD0....44f
	defb 076h,06ch,0bah,0aah,0ach,044h,055h,055h,025h,044h,053h,02dh,0bbh,0b9h,0aah,0c1h	; 9180  vl...DUU%DS-....
	defb 034h,046h,067h,066h,0bbh,0aah,0abh,0b4h,045h,055h,053h,054h,044h,040h,0cbh,0bah	; 9190  4Fgf....EUSTD@..
	defb 0a9h,0bdh,034h,043h,067h,066h,05dh,0bah,0aah,0bch,044h,055h,054h,045h,035h,043h	; 91a0  ..4Cgf]...DUTE5C
	defb 0ech,0bbh,0aah,09bh,003h,044h,056h,076h,063h,0cbh,0aah,0abh,0e4h,045h,054h,045h	; 91b0  .....DVvc....ETE
	defb 055h,044h,02dh,0bbh,0aah,09ah,013h,044h,036h,076h,065h,0dbh,0aah,0bah,0d4h,035h	; 91c0  UD-....D6ve....5
	defb 054h,045h,054h,055h,00dh,0cbh,0aah,09ah,0c3h,043h,045h,077h,056h,0cbh,0aah,0abh	; 91d0  TETU.....CEwV...
	defb 0b2h,0f5h,055h,055h,055h,044h,02dh,0cbh,0bah,09ah,0bdh,043h,045h,067h,066h,04ch	; 91e0  ..UUUD-....CEgfL
	defb 0bah,0aah,0a4h,034h,055h,055h,055h,044h,02dh,0dbh,0bah,0aah,0abh,033h,044h,066h	; 91f0  ...4UUUD-....3Df
	defb 076h,05dh,0bah,0aah,0bch,040h,055h,055h,055h,043h,03eh,0dch,0bah,0aah,0abh,0e3h	; 9200  v]...@UUUC>.....
	defb 043h,066h,076h,053h,0bah,0aah,0bbh,043h,056h,045h,053h,044h,0e0h,0dch,0bbh,0a9h	; 9210  CfvS...CVESD....
	defb 0bbh,003h,044h,056h,076h,064h,0bah,0aah,0abh,044h,056h,055h,06dh,042h,0c0h,0dch	; 9220  ..DVvd...DVUmB..
	defb 0bbh,0aah,0aah,013h,044h,056h,076h,065h,0bah,0aah,0aah,035h,056h,055h,064h,0e4h	; 9230  ....DVve...5VUd.
	defb 0cdh,0ech,0bch,0aah,0aah,0c3h,034h,046h,077h,054h,0eah,0a9h,0abh,0f5h,056h,065h	; 9240  ......4FwT....Ve
	defb 064h,0c4h,0dch,02dh,0cbh,0bah,0a9h,0c4h,034h,045h,067h,075h,03bh,09ah,0aah,0b3h	; 9250  d..-....4Egu....
	defb 056h,066h,055h,03ch,04ch,0c4h,0ech,0cbh,0aah,09ch,014h,034h,056h,077h,052h,0b9h	; 9260  VfU<L......4VwR.
	defb 0a9h,0beh,035h,066h,065h,053h,0b4h,0deh,050h,0dch,0bah,0a9h,0bdh,034h,044h,067h	; 9270  ..5feS..P....4Dg
	defb 076h,0ech,09ah,09ah,024h,056h,066h,054h,03bh,0e4h,0c5h,05dh,0ech,0bah,09ah,0bdh	; 9280  v...$VfT...]....
	defb 034h,036h,077h,064h,0cbh,09ah,09bh,014h,056h,066h,052h,04bh,034h,0e5h,040h,0dbh	; 9290  46wd....VfRK4.@.
	defb 0bah,09ah,0beh,034h,036h,077h,064h,0cbh,09ah,0aah,0d2h,056h,046h,05fh,05fh,0d5h	; 92a0  ...46wd....VF__.
	defb 034h,05dh,0ech,0bah,0a9h,0aeh,034h,034h,067h,066h,05dh,0bah,0aah,0bbh,0d2h,055h	; 92b0  4]....44gf]....U
	defb 045h,055h,054h,054h,0f3h,0dch,0cch,0bbh,0aah,0aah,034h,034h,057h,056h,063h,0ech	; 92c0  EUTT......44WVc.
	defb 0aah,0abh,0cdh,045h,046h,044h,052h,024h,0d2h,04dh,041h,0cdh,0cah,0bah,09ch,034h	; 92d0  ...EFDR$.MA....4
	defb 043h,066h,066h,06bh,04bh,0abh,0bch,0fch,041h,0e4h,014h,050h,055h,045h,040h,04ch	; 92e0  CffkK...A..PUE@L
	defb 0bdh,0bbh,0bah,0aah,0b3h,043h,046h,066h,066h,0b3h,0cah,0cbh,0bch,0cdh,022h,044h	; 92f0  .....CFff....."D
	defb 035h,045h,052h,044h,0d4h,0dch,0dch,0cch,0bbh,0aah,0cbh,0d5h,0e5h,065h,065h,024h	; 9300  5ERD.........ee$
	defb 03bh,0ddh,0deh,0cdh,0dbh,03dh,0c5h,024h,053h,045h,0d4h,03eh,03fh,0feh,0cch,0cbh	; 9310  .....=.$SE.>?...
	defb 0aah,0bbh,0c0h,045h,065h,056h,042h,04ch,0deh,0cdh,0cdh,02ch,0dfh,0cdh,03dh,044h	; 9320  ...EeVBL...,..=D
	defb 035h,044h,05eh,03eh,0ceh,0dch,02dh,0cdh,0bah,0fbh,0bfh,024h,045h,054h,05eh,034h	; 9330  5D^>..-....$ET^4
	defb 0edh,040h,0f3h,0deh,0ddh,0dch,03dh,0d4h,0e3h,043h,043h,03fh,0e0h,0deh,03fh,0f4h	; 9340  .@....=..CC?..?.
	defb 0deh,0dbh,0b0h,0bch,03ch,040h,0e3h,0e4h,0d2h,050h,035h,033h,04dh,0deh,0ech,0e4h	; 9350  ....<@...P53M...
	defb 0e1h,04dh,00eh,0efh,0e0h,0f1h,022h,0e3h,03eh,03fh,0f1h,0feh,0cch,03bh,004h,0c1h	; 9360  .M....".>?......
	defb 0dch,0dbh,03dh,0d5h,023h,053h,044h,003h,0f0h,03dh,043h,0d4h,0dch,0edh,0eeh,01eh	; 9370  ..=.#SD..=C.....
	defb 012h,00eh,010h,0d2h,01eh,032h,012h,0ffh,0beh,04bh,033h,0c2h,0dch,0dch,02eh,015h	; 9380  .....2...K3.....
	defb 0e3h,043h,033h,022h,013h,021h,040h,002h,0ddh,0eeh,0e0h,020h,0e1h,0ddh,00dh,0d1h	; 9390  .C3".!@.... ....
	defb 0feh,032h,032h,033h,011h,0fch,0c2h,0dch,01fh,0ddh,0edh,0dfh,00dh,043h,034h,043h	; 93a0  .223.........C4C
	defb 032h,02fh,0f3h,0e3h,030h,032h,0efh,0deh,0edh,00dh,000h,0efh,0feh,0eeh,0efh,002h	; 93b0  2/..02..........
	defb 032h,033h,022h,02fh,00dh,0c1h,0ddh,00fh,0edh,0ddh,0dfh,00fh,033h,033h,033h,032h	; 93c0  23"/........3332
	defb 021h,023h,013h,032h,01eh,00dh,0dfh,0deh,00eh,0efh,0feh,0ffh,0feh,0e2h,0d3h,022h	; 93d0  !#.2..........."
	defb 032h,030h,010h,010h,000h,0edh,0ffh,0efh,0edh,0ddh,0ddh,0e2h,022h,041h,023h,022h	; 93e0  20.........."A#"
	defb 011h,012h,023h,022h,021h,0ffh,0feh,010h,00fh,0feh,0deh,0edh,0efh,0efh,002h,0f2h	; 93f0  ..#"!...........
	defb 02fh,01fh,020h,022h,022h,021h,011h,001h,0eeh,0cfh,02dh,0f2h,0deh,0ddh,0deh,02fh	; 9400  /. ""!....-..../
	defb 023h,033h,023h,012h,021h,022h,023h,022h,00eh,00dh,0e0h,0f0h,000h,0feh,0ffh,0dfh	; 9410  #3#.!"#"........
	defb 0eeh,0eeh,0f0h,00fh,020h,002h,002h,022h,031h,022h,001h,00fh,00fh,0f0h,01eh,01eh	; 9420  .... .."1"......
	defb 0deh,0edh,00eh,0feh,0d2h,0d3h,00fh,032h,031h,023h,002h,030h,022h,022h,002h,0efh	; 9430  .......21#.0""..
	defb 0feh,0feh,01fh,0f0h,0eeh,0eeh,0eeh,0feh,0d1h,00fh,002h,012h,002h,020h,022h,012h	; 9440  ............. ".
	defb 02fh,022h,00fh,01eh,0f0h,0ffh,0f0h,0e0h,0eeh,0feh,0edh,00eh,0f0h,011h,003h,002h	; 9450  /"..............
	defb 023h,022h,021h,012h,001h,000h,010h,000h,00fh,00fh,0f0h,0e0h,0efh,0ffh,0feh,00fh	; 9460  #"!.............
	defb 00eh,0feh,0eeh,010h,000h,011h,0e1h,0f1h,021h,022h,032h,012h,021h,000h,02fh,01fh	; 9470  ........!"2.!./.
	defb 0f1h,0efh,0efh,0ffh,01fh,00eh,00fh,0f0h,00fh,000h,0f0h,001h,0e2h,0f1h,000h,011h	; 9480  ................
	defb 010h,010h,010h,000h,00fh,00fh,0f1h,0f1h,0f1h,000h,000h,010h,00fh,01eh,01fh,000h	; 9490  ................
	defb 0f0h,011h,0f1h,001h,0e2h,001h,01fh,02eh,02eh,0ffh,00fh,002h,0f1h,010h,0f0h,0ffh	; 94a0  ................
	defb 0f0h,00fh,010h,010h,00fh,01fh,0f1h,0f1h,001h,001h,010h,01fh,000h,000h,001h,001h	; 94b0  ................
	defb 001h,0f1h,0f1h,0adh	; 94c0

; ----------------------------------------------------------------------
; DATOS voz_0x12: la voz digital 0x12 (la marca del final es 0x84)
;   0x94c4..0x9da6  (2274 bytes)
DATA_voz_0x12:
	defb 084h,0c4h,0f3h,0feh,0c5h,0c3h,001h,0efh,0f1h,0f0h,0f0h,01eh,0ffh,0e4h,0d2h,0d0h	; 94c4  ................
	defb 030h,00dh,04dh,0f0h,0f1h,0e3h,0f1h,0e2h,0d3h,0d3h,0c4h,0d3h,0e2h,0feh,02eh,03dh	; 94d4  0.M............=
	defb 03dh,012h,0edh,04dh,0e3h,0d2h,002h,0d3h,0d2h,03ch,04ch,031h,0d4h,0c4h,0c4h,0cfh	; 94e4  =..M.....<L1....
	defb 031h,0edh,042h,0ddh,0f3h,031h,0b4h,020h,04ch,033h,0c3h,0c4h,0d3h,0b5h,0ech,04eh	; 94f4  1.B..1. L3.....N
	defb 032h,0d3h,0b5h,0c0h,0e5h,0c2h,0c3h,04ch,0c5h,0b5h,0cch,06ah,05dh,01bh,034h,03bh	; 9504  2......L...j].4.
	defb 035h,0b4h,0edh,04ch,05bh,05ch,01fh,0dch,05ah,06ch,0e5h,0a4h,054h,0a4h,06ah,05dh	; 9514  5..L[\..Zl..T.j]
	defb 0ech,05bh,05eh,0d5h,0a5h,0deh,05ch,0b6h,0b3h,02bh,04bh,06ah,06ah,06bh,0d1h,04dh	; 9524  .[^...\..+Kjjk.M
	defb 0c1h,044h,0bdh,025h,0b5h,0b4h,0deh,02eh,0f4h,0cch,06bh,03ch,0e3h,0e3h,0b5h,0b6h	; 9534  .D.%......k<....
	defb 0a6h,0a6h,0cbh,069h,066h,0a6h,0ach,06ah,05dh,0e3h,03ch,043h,0b4h,05ah,044h,03dh	; 9544  ...if..j].<C.ZD=
	defb 0c4h,02ch,044h,0a6h,0bfh,06ah,034h,0dbh,06ah,05bh,05ch,0e5h,00ch,013h,0b5h,0b5h	; 9554  .,D..j4.j[\.....
	defb 0c3h,0c5h,0a6h,0a5h,05bh,06ah,052h,0cdh,03bh,06ah,04dh,05ch,05ch,0a6h,0dbh,05bh	; 9564  ....[jR..jM\\..[
	defb 054h,0a7h,095h,006h,0a5h,0bch,06ah,06bh,0b5h,0b5h,012h,0b4h,04fh,0b3h,05bh,05ch	; 9574  T.....jk....O.[\
	defb 0c6h,0a6h,0a5h,0cdh,06ah,05ah,06ah,06ah,06ch,0b6h,0beh,0b4h,04ch,069h,079h,07ah	; 9584  ....jZjjl...Liyz
	defb 035h,0bdh,03eh,04ch,0c6h,0a5h,0fdh,04ah,079h,055h,0b6h,0ach,06ch,0b6h,0bbh,06ah	; 9594  5.>L...JyU..l..j
	defb 026h,0a4h,03bh,06ah,06ah,05bh,06ah,054h,0dbh,05ch,03bh,05bh,0d5h,05ah,05ch,069h	; 95a4  &..jj[jT.\.[.Z\i
	defb 064h,0b6h,0b4h,0b4h,04ah,079h,06ah,06ah,06bh,04dh,0a7h,095h,035h,0c6h,0a4h,0b6h	; 95b4  d...JyjjkM..5...
	defb 0bch,05ah,06bh,0ech,06ah,056h,096h,0c5h,0a6h,0bbh,079h,06ah,079h,06ch,0c5h,0a6h	; 95c4  .Zk.jV....yjyl..
	defb 0a6h,0eah,06ah,063h,0b5h,0a6h,0bdh,06bh,05ah,0c6h,0a6h,0b5h,0bdh,054h,0a4h,05bh	; 95d4  ..jc...kZ....T.[
	defb 069h,065h,0dbh,06ah,043h,03bh,043h,0c5h,0b4h,0c4h,0dch,05eh,0b6h,0bbh,053h,0c4h	; 95e4  ie.jC.C....^..S.
	defb 0b3h,044h,0a6h,0a6h,0a6h,0a6h,0beh,05ch,0c4h,02fh,0b5h,0b6h,0a5h,04bh,034h,0ceh	; 95f4  .D.....\./...K4.
	defb 04bh,06ah,054h,0cbh,06ah,042h,04bh,045h,0a5h,04bh,05dh,0ddh,003h,0b6h,0a5h,0c4h	; 9604  KjT.jBKE.K].....
	defb 013h,03bh,06ah,06ah,06ah,05dh,0b5h,0b5h,0c3h,0d3h,03bh,06bh,0d3h,0edh,05bh,04dh	; 9614  ..jjj].....k..[M
	defb 01bh,06ah,05dh,02eh,02dh,0c5h,0b5h,0b5h,0a7h,096h,0b5h,0b5h,0c2h,04ch,023h,0c2h	; 9624  .j].-........L#.
	defb 0f5h,0a6h,0b1h,033h,0cbh,06ah,05bh,053h,0c3h,0d5h,0b2h,05bh,04ch,03dh,05bh,05bh	; 9634  ...3.j[S...[L=[[
	defb 04fh,0d5h,0b5h,0dch,04ch,04bh,05dh,0edh,03bh,05bh,0c5h,0b3h,0f4h,0a6h,0cch,05bh	; 9644  O...LK]..[.....[
	defb 06ah,06bh,053h,024h,0d5h,0b5h,0bdh,05ah,06bh,00ch,0cfh,0a6h,0a2h,0bch,031h,04dh	; 9654  jkS$...Zk.....1M
	defb 053h,055h,045h,045h,034h,0e2h,0dch,01bh,01dh,0bch,0b2h,0a3h,0bbh,00bh,03bh,05ch	; 9664  SUEE4..........\
	defb 054h,025h,054h,056h,035h,053h,044h,0c1h,0ech,0cch,0c4h,0aah,06ah,0a5h,0abh,05ah	; 9674  T%TV5SD.....j..Z
	defb 0e3h,05bh,046h,0c5h,05dh,056h,0e3h,060h,005h,0d3h,05ch,0b5h,0cdh,0ddh,0c9h,07ah	; 9684  .[F.]V.`..\....z
	defb 096h,0abh,069h,032h,05ah,046h,0c6h,04bh,065h,020h,063h,025h,0c5h,05bh,024h,04ch	; 9694  ..i2ZF.Ke c%.[$L
	defb 0feh,0dch,096h,0b9h,06ah,0c5h,094h,0d5h,0b1h,06ch,065h,0b6h,05fh,046h,030h,05ch	; 96a4  ....j....le._F0\
	defb 055h,0b3h,05eh,0eeh,04bh,0a5h,0b9h,05bh,096h,0abh,043h,0bdh,055h,045h,044h,064h	; 96b4  U.^.K..[..C.UEDd
	defb 0e6h,05dh,051h,045h,0d1h,050h,0c0h,0fbh,096h,0b9h,06ah,0a5h,0abh,031h,0bfh,06fh	; 96c4  .]QE.P....j..1.o
	defb 055h,036h,054h,0f6h,040h,052h,045h,0b5h,033h,0c3h,0dah,0b5h,09bh,059h,05ch,0adh	; 96d4  U6T.@RE.3....Y\.
	defb 0dch,0d4h,06bh,063h,047h,0b2h,065h,0c5h,044h,05dh,0b6h,0fch,0e4h,0b9h,06ch,095h	; 96e4  ..kcG.e.D]....l.
	defb 0b9h,06ah,0b2h,0cch,0f5h,044h,06bh,066h,0c5h,064h,025h,024h,05ch,016h,0bdh,04dh	; 96f4  .j...Dkf.d%$\..M
	defb 0aah,069h,0a6h,095h,0cah,0cbh,0dfh,036h,0b6h,040h,07ch,0c6h,05eh,054h,045h,00bh	; 9704  .i.....6.@|.^TE.
	defb 055h,0b4h,04bh,097h,0a9h,05ah,0a5h,09ch,040h,0ceh,06bh,056h,0b6h,06dh,056h,03dh	; 9714  U.K..Z..@.kV.mV=
	defb 06dh,045h,0b4h,06ah,044h,0e9h,054h,09fh,049h,05ah,0a5h,0cch,0d5h,04dh,06fh,056h	; 9724  mE.jD.T.IZ...MoV
	defb 034h,065h,0e5h,024h,05dh,004h,05bh,044h,0aah,06ah,0a4h,09ch,059h,00dh,03ch,0d6h	; 9734  4e.$].[D.j..Y.<.
	defb 0b5h,051h,07ch,035h,06dh,036h,0c5h,03bh,055h,0cdh,05eh,095h,049h,0e3h,096h,0aah	; 9744  .Q|5m6..U.^.I...
	defb 02bh,0deh,053h,0d6h,0e5h,07ah,056h,05ch,054h,045h,0fch,054h,0b5h,04ah,0a6h,0aah	; 9754  +.S..zV\TE.T.J..
	defb 04ah,0a4h,09dh,0f3h,0cdh,06bh,055h,016h,053h,056h,021h,060h,043h,0c5h,05bh,025h	; 9764  J....kU.SV!`C.[%
	defb 0e9h,0d6h,09bh,059h,05bh,0a4h,0a3h,0dfh,06ah,064h,057h,0a5h,066h,0b5h,052h,04eh	; 9774  ...Y[...jdW.f.RN
	defb 0e6h,0dbh,035h,0bah,05ch,093h,0bah,049h,0b5h,0beh,006h,0cdh,06ch,065h,006h,055h	; 9784  ..5.\..I....le.U
	defb 0e6h,0e4h,04ch,054h,0dch,053h,0aah,06ah,096h,095h,0c9h,05bh,04bh,006h,0a6h,045h	; 9794  ..LT.S.j...[K..E
	defb 07ah,056h,05ch,056h,0d2h,03dh,06dh,0b5h,04bh,0ach,059h,0c4h,096h,09bh,05bh,0ceh	; 97a4  zV\V.=m.K.Y...[.
	defb 054h,0b6h,026h,06bh,056h,05bh,064h,042h,044h,05ch,0c5h,04ah,0a6h,0b9h,04ah,0b2h	; 97b4  T.&kV[dBD\.J..J.
	defb 092h,01dh,0cdh,06bh,035h,046h,045h,056h,00dh,064h,014h,0e5h,03eh,0d5h,02ah,0a6h	; 97c4  ...k5FEV.d..>.*.
	defb 0a9h,06ah,0cbh,095h,0b3h,0cdh,06ah,065h,046h,015h,056h,0c3h,060h,034h,035h,0d1h	; 97d4  .j....jeF.V.`45.
	defb 0c5h,00ah,0a6h,0a9h,06ah,0cbh,096h,0a4h,0ceh,06ah,065h,055h,0c6h,046h,0f4h,06eh	; 97e4  ....j....jeU.F.n
	defb 0f5h,0f5h,0c4h,0b6h,0bch,097h,0a9h,05bh,0adh,096h,0adh,0efh,06ah,056h,045h,046h	; 97f4  .......[....jVEF
	defb 046h,0b5h,06ch,004h,051h,0c5h,0c5h,0dch,0a3h,049h,0d4h,0ach,094h,0ebh,0ceh,06bh	; 9804  F.l.Q....I.....k
	defb 0b6h,056h,0c6h,054h,053h,06ch,0d5h,052h,0b5h,04bh,05ch,0bah,069h,0b6h,0abh,0aah	; 9814  .V.TSl.R.K\.i...
	defb 04ah,04ch,054h,0b6h,054h,045h,056h,03ch,064h,0c4h,045h,0b5h,04dh,014h,0cah,0f4h	; 9824  JLT.TEV<d.E.M...
	defb 091h,04ah,0cah,0bch,0bch,0d6h,0cbh,065h,054h,055h,054h,036h,0edh,054h,04bh,054h	; 9834  .J.....eTUT6.TKT
	defb 0c0h,025h,0aah,069h,0b5h,0adh,0aah,04bh,04bh,045h,0b6h,045h,044h,064h,05dh,055h	; 9844  .%.i...KKE.EDd]U
	defb 022h,044h,0eeh,05dh,02dh,05bh,0a6h,0b9h,04bh,0bbh,0adh,0beh,0bdh,06ah,056h,055h	; 9854  "D.]-[..K....jVU
	defb 0d5h,064h,042h,06ch,005h,033h,0c3h,043h,0ceh,05ch,0a4h,039h,03fh,0adh,0ach,0cbh	; 9864  .dBl.3.C.\.9?...
	defb 0cdh,06bh,0d5h,065h,0d5h,062h,05ch,06eh,031h,052h,0c2h,05dh,02bh,06bh,0b9h,07ah	; 9874  .k.e.b\n1R.]+k.z
	defb 0a5h,0ach,0aah,05ah,05bh,0c6h,0a6h,055h,05dh,065h,05ch,056h,0b2h,045h,0b2h,040h	; 9884  ...Z[..U]e\V.E.@
	defb 01eh,0d5h,0dbh,097h,0aah,05ah,0cah,0a5h,0a5h,0b5h,05ah,065h,054h,026h,045h,0c5h	; 9894  .....Z....ZeT&E.
	defb 053h,0d4h,05bh,0e5h,0d0h,0d4h,04dh,0c9h,07bh,095h,0dbh,0aah,05ah,04bh,0c7h,095h	; 98a4  S.[...M.{...ZK..
	defb 065h,05ch,064h,052h,046h,0cdh,045h,0fbh,05eh,0ddh,033h,0f3h,0dah,053h,094h,04ah	; 98b4  e\dRF.E.^.3..S.J
	defb 0cah,03bh,0a4h,0c6h,0b2h,064h,05eh,065h,0d6h,0b6h,0b4h,045h,0dbh,053h,0b0h,0d5h	; 98c4  .....d^e...E.S..
	defb 0b5h,0d2h,097h,0b9h,06ah,0bch,0a5h,0a5h,0ach,07ah,044h,056h,0b6h,0f4h,052h,06bh	; 98d4  ....j....zDV..Rk
	defb 05fh,041h,0b3h,03dh,0cdh,04dh,0d4h,04dh,097h,0bah,04bh,0bbh,0a5h,0a5h,0ach,07ah	; 98e4  _A.=.M.M..K....z
	defb 054h,055h,0b6h,035h,032h,06bh,043h,04eh,0b3h,0feh,0cch,05ch,020h,05fh,0d9h,07bh	; 98f4  TU.52kCN...\ _.{
	defb 096h,0b3h,0bah,069h,06ah,036h,0a6h,025h,05bh,07bh,04dh,027h,0aeh,0c6h,0bbh,033h	; 9904  ...ij6.%[{M'...3
	defb 0cch,0c5h,0c3h,0c5h,04dh,049h,07ch,096h,0dbh,0bah,06ah,01ah,0b7h,096h,054h,05ah	; 9914  ....MI|...j...TZ
	defb 07ch,025h,0c7h,0adh,053h,03ah,06dh,0bch,0d5h,0bdh,025h,0dch,052h,059h,07bh,0a5h	; 9924  |%..S:m...%.RY{.
	defb 0a4h,0aah,069h,079h,0c7h,096h,0c6h,05ah,07ah,063h,0c7h,0a5h,0c5h,04ah,052h,04ah	; 9934  ..iy...Zzc...JRJ
	defb 0e5h,0bdh,0b5h,0ech,034h,05ch,04bh,0b6h,095h,05bh,0dah,06ah,0a5h,0a7h,0ach,053h	; 9944  ....4\K..[.j...S
	defb 06ah,065h,0c6h,0a7h,0beh,04ch,06ah,053h,0ddh,0a6h,0adh,0ddh,04ah,053h,04dh,016h	; 9954  je...LjS....JSM.
	defb 0c4h,0bdh,06ah,0c4h,0bdh,0a5h,0bbh,01ah,07ah,0b5h,026h,0a6h,041h,05bh,07ah,043h	; 9964  ..j.....z.&.A[zC
	defb 006h,0a5h,04ch,03ah,05bh,0cch,0c5h,0a0h,033h,0dch,06ch,04dh,055h,0dbh,045h,0a2h	; 9974  ..L:[...3.lMU.E.
	defb 0ebh,0dah,05bh,0cbh,0b6h,0a5h,015h,05ah,064h,054h,0c6h,0d5h,0c5h,05bh,05ch,05bh	; 9984  ..[....ZdT...[\[
	defb 0c2h,0b3h,0a4h,0cbh,02bh,05bh,0d4h,034h,0c5h,044h,045h,04dh,0deh,04bh,0b2h,0bdh	; 9994  ....+[.4.DEM.K..
	defb 0a3h,0cch,0dbh,05ch,0d4h,044h,0d5h,045h,043h,054h,05eh,054h,0c4h,0d4h,0cch,0dch	; 99a4  ...\.D.ECT^T....
	defb 0dah,013h,0a2h,0b4h,0cbh,043h,013h,005h,044h,045h,042h,045h,0fdh,0dch,04bh,0bdh	; 99b4  .....C..DEBE..K.
	defb 0bch,0aeh,03ah,05ah,053h,0c5h,0d6h,0c4h,06ch,06bh,063h,025h,0e5h,0c4h,00dh,0fbh	; 99c4  ..:ZS...lkc%....
	defb 03bh,0cbh,0cfh,0bbh,03ah,05bh,03eh,04dh,0f4h,05dh,053h,052h,053h,05eh,033h,04ch	; 99d4  ....:[>M.]SRS^3L
	defb 02ch,01ch,0bdh,0bch,0bch,0cbh,0cbh,00dh,0f2h,044h,035h,045h,045h,045h,044h,053h	; 99e4  ,........D5EEEDS
	defb 033h,022h,0deh,0dch,0cch,0cch,0bch,0cch,0cch,0cdh,0b5h,0b3h,033h,033h,052h,045h	; 99f4  3"..........33RE
	defb 024h,044h,034h,03eh,03fh,0deh,0deh,0cdh,0ech,0cch,0ebh,0dbh,03ch,0b4h,0b4h,0ceh	; 9a04  $D4>?.......<...
	defb 05dh,06bh,054h,045h,026h,0c4h,043h,04dh,040h,01dh,0c1h,0cch,0cch,0dbh,0cdh,0cdh	; 9a14  ]kTE&.CM@.......
	defb 0cdh,0edh,0ffh,04fh,024h,034h,0f4h,043h,032h,043h,021h,033h,0d0h,0e1h,0ddh,0dfh	; 9a24  ...O$4.C2C!3....
	defb 0cdh,0eeh,0ddh,0feh,0edh,0eeh,00ch,03eh,0d2h,0d3h,02eh,033h,042h,034h,033h,034h	; 9a34  .......>...3B434
	defb 031h,03fh,04eh,0d3h,0efh,0deh,0edh,0dch,0fdh,0ddh,0edh,0deh,01eh,00fh,023h,0e3h	; 9a44  1?N...........#.
	defb 013h,0d5h,0c2h,04ch,030h,04dh,013h,0d3h,0edh,02eh,0feh,01fh,0d0h,0efh,00eh,02eh	; 9a54  ...L0M..........
	defb 01eh,022h,0e1h,021h,000h,022h,001h,0f1h,0fdh,03dh,0d0h,0d2h,0c3h,0d1h,03dh,03eh	; 9a64  .".!."...=....=>
	defb 032h,014h,0d4h,012h,03fh,03fh,030h,0f2h,0feh,0feh,0fdh,0e0h,0dfh,0deh,0fdh,00dh	; 9a74  2...??0.........
	defb 02dh,01fh,010h,0f2h,021h,0f3h,010h,03fh,0e3h,023h,0d3h,02eh,01eh,030h,0e1h,0f3h	; 9a84  -...!..?.#...0..
	defb 0ddh,02eh,0eeh,01eh,0eeh,0f2h,0feh,010h,01eh,022h,0e3h,0e3h,001h,002h,02eh,011h	; 9a94  ........."......
	defb 010h,00fh,02eh,0feh,02fh,0d2h,0e2h,0d1h,000h,0feh,020h,0f0h,020h,00fh,010h,01fh	; 9aa4  ..../..... . ...
	defb 012h,0f1h,0f2h,01fh,010h,01eh,01fh,01eh,000h,000h,0efh,011h,0e0h,002h,0e0h,0f2h	; 9ab4  ................
	defb 0efh,02fh,02eh,022h,0f1h,0f3h,000h,022h,000h,002h,000h,00fh,02dh,02eh,00eh,0eeh	; 9ac4  ./."..."....-...
	defb 0d2h,0cdh,02ch,02eh,0c4h,0c4h,0deh,04ch,05ch,044h,0d5h,0c5h,0d1h,04ch,04dh,031h	; 9ad4  ..,....L\D...LM1
	defb 0d2h,0dfh,0edh,0edh,0edh,0dfh,0edh,0ffh,00fh,0e3h,0e2h,011h,03fh,03fh,031h,022h	; 9ae4  ............??1"
	defb 0f3h,0e2h,001h,0feh,000h,0efh,0ffh,00eh,0eeh,02eh,0e1h,01eh,002h,0f2h,0f2h,002h	; 9af4  ................
	defb 001h,020h,02fh,03eh,01fh,02fh,0ffh,001h,0efh,0f1h,0eeh,000h,00eh,01fh,01eh,010h	; 9b04  . />./..........
	defb 010h,001h,011h,0f2h,001h,0f2h,01fh,01fh,01fh,01eh,02eh,00fh,000h,0e0h,000h,0e1h	; 9b14  ................
	defb 000h,0f0h,000h,01fh,02fh,02fh,011h,0f1h,002h,0e2h,0f1h,00fh,001h,0ffh,01fh,00fh	; 9b24  ....//..........
	defb 00fh,00fh,0f2h,0e1h,0f2h,0f1h,0f1h,000h,01fh,010h,010h,01eh,011h,0f1h,0f2h,0f0h	; 9b34  ................
	defb 0f1h,0f0h,00fh,01eh,01fh,01eh,02fh,001h,0e2h,0f1h,0f1h,000h,000h,000h,000h,01fh	; 9b44  ....../.........
	defb 01fh,010h,000h,0f1h,0f1h,0e2h,0f0h,0f0h,01eh,02eh,010h,000h,01fh,010h,001h,0f1h	; 9b54  ................
	defb 0f1h,0f1h,000h,000h,01eh,02eh,02fh,00fh,010h,0e1h,0f1h,0feh,03eh,0e2h,0e3h,0d2h	; 9b64  ....../.....>...
	defb 010h,02fh,011h,0f2h,0e2h,0e1h,0f0h,00fh,0f1h,0e0h,01eh,01eh,02eh,01fh,001h,0f1h	; 9b74  ./..............
	defb 0f1h,001h,0f1h,001h,010h,01fh,02eh,02fh,01fh,0f2h,0e1h,0f1h,0e1h,0f0h,000h,0f0h	; 9b84  ......./........
	defb 01fh,01fh,01fh,010h,010h,0f2h,0e2h,0e1h,000h,01fh,000h,00fh,01fh,00fh,01fh,001h	; 9b94  ................
	defb 0f1h,0e2h,0e2h,0f1h,00fh,01fh,01fh,02fh,01fh,000h,000h,001h,000h,0f2h,0e1h,00fh	; 9ba4  ......./........
	defb 01fh,01eh,02eh,010h,000h,000h,0f1h,0f1h,000h,000h,000h,000h,01fh,01eh,02fh,001h	; 9bb4  ............../.
	defb 0f1h,0e2h,0f1h,0e1h,000h,000h,01fh,01fh,01fh,00fh,010h,000h,0f1h,0f2h,0f1h,000h	; 9bc4  ................
	defb 00fh,01eh,02fh,01fh,01fh,01fh,001h,0f0h,001h,0f1h,0f0h,00fh,01fh,02eh,02fh,000h	; 9bd4  ../.........../.
	defb 000h,001h,0e2h,0e2h,0f1h,0f0h,01fh,000h,01fh,01fh,01fh,000h,001h,0e1h,0f2h,0e1h	; 9be4  ................
	defb 000h,000h,00fh,02fh,01fh,01eh,011h,0e1h,0f1h,0f1h,000h,001h,0f0h,01fh,01fh,01eh	; 9bf4  .../............
	defb 02fh,001h,0f0h,0f2h,0f0h,0f1h,000h,00fh,02eh,02eh,02fh,01fh,010h,0f1h,0f1h,0e1h	; 9c04  /........./.....
	defb 001h,0f0h,01fh,000h,01fh,01fh,000h,010h,0f1h,0f1h,0e2h,0f0h,000h,000h,01eh,02eh	; 9c14  ................
	defb 010h,010h,0e2h,0f0h,001h,0e1h,0f1h,000h,01fh,01eh,02fh,01fh,010h,0f0h,001h,0e2h	; 9c24  ........../.....
	defb 0e1h,0f1h,000h,00fh,01fh,02fh,000h,01fh,001h,0f1h,0e2h,0f0h,000h,01fh,000h,01eh	; 9c34  ...../..........
	defb 02eh,02fh,000h,001h,0e2h,0e2h,0e1h,0f1h,0f0h,01fh,02fh,01fh,01fh,001h,0f1h,0f1h	; 9c44  ./......../.....
	defb 0e2h,0f0h,000h,000h,00fh,010h,01eh,02fh,000h,001h,0f1h,0e2h,0f1h,0f0h,000h,01eh	; 9c54  ......./........
	defb 01fh,02fh,01fh,001h,0f0h,001h,0e2h,0f1h,0f0h,01fh,00fh,02eh,02fh,01fh,010h,0f1h	; 9c64  ./........../...
	defb 0f1h,0e1h,001h,0f0h,01fh,01eh,02eh,010h,000h,001h,0f0h,0f2h,0e2h,0e1h,000h,000h	; 9c74  ................
	defb 00fh,02eh,02eh,02fh,010h,0f1h,0f1h,0f1h,0f1h,0f0h,01fh,01fh,000h,01fh,000h,000h	; 9c84  .../............
	defb 000h,0f2h,0e2h,0f0h,000h,00fh,01fh,01fh,010h,000h,001h,0f1h,0f1h,0f1h,0f0h,000h	; 9c94  ................
	defb 000h,01eh,02eh,02eh,01fh,011h,0f1h,0f1h,0f1h,0f1h,0f0h,01fh,01fh,01fh,01fh,000h	; 9ca4  ................
	defb 000h,001h,0e2h,0e1h,000h,000h,000h,00fh,02fh,01eh,010h,001h,0e1h,001h,0f1h,0f0h	; 9cb4  ......../.......
	defb 000h,01fh,000h,01eh,02fh,000h,000h,001h,0e2h,0f1h,0f0h,000h,01eh,02eh,02fh,01fh	; 9cc4  ..../........./.
	defb 000h,000h,0f1h,0f2h,0f1h,0f0h,000h,01fh,01fh,000h,000h,001h,0f1h,0e2h,0e2h,0f1h	; 9cd4  ................
	defb 0f0h,000h,01fh,01fh,01fh,01fh,000h,000h,0f1h,0f2h,0f1h,0f0h,01fh,01eh,02eh,02eh	; 9ce4  ................
	defb 02fh,000h,000h,0f2h,0e2h,0f0h,000h,01fh,01fh,01fh,01fh,01fh,001h,0f0h,0f1h,0f2h	; 9cf4  /...............
	defb 0f1h,0f0h,00fh,02eh,02fh,00fh,010h,000h,001h,0e2h,0f1h,0f0h,000h,01fh,000h,01fh	; 9d04  ..../...........
	defb 01fh,000h,000h,000h,0f1h,0f2h,0f0h,000h,00fh,02eh,02eh,02fh,000h,000h,001h,0e2h	; 9d14  .........../....
	defb 0f1h,0f0h,000h,01fh,00fh,02eh,02fh,01fh,000h,001h,0e2h,0f1h,0f0h,000h,01eh,010h	; 9d24  ....../.........
	defb 00fh,02fh,000h,001h,0f0h,0f1h,0f1h,0f1h,00fh,010h,01fh,01fh,01fh,000h,000h,0f2h	; 9d34  ./..............
	defb 0f1h,0f1h,0f0h,000h,01fh,000h,01fh,01fh,001h,0f1h,0f1h,0e2h,0f1h,0f0h,000h,01eh	; 9d44  ................
	defb 01fh,02eh,02fh,000h,001h,0e1h,001h,0f1h,0f0h,000h,00fh,02fh,01fh,01fh,000h,001h	; 9d54  ../......../....
	defb 0f1h,0f1h,0e1h,000h,000h,00fh,02fh,000h,01fh,000h,001h,0f1h,0e2h,0f1h,0e1h,000h	; 9d64  ....../.........
	defb 00fh,02fh,00fh,010h,000h,001h,0f1h,0f1h,0f1h,0f0h,000h,01fh,01eh,02fh,000h,000h	; 9d74  ./.........../..
	defb 000h,001h,0f0h,001h,0f0h,000h,00fh,000h,02fh,000h,001h,0f1h,0f1h,0f0h,001h,0ffh	; 9d84  ......../.......
	defb 02fh,01fh,01fh,01fh,01fh,001h,0f1h,0f1h,0e2h,0f0h,000h,000h,0f3h,0c4h,0c4h,0c4h	; 9d94  /...............
	defb 0c4h,084h	; 9da4

; ----------------------------------------------------------------------
; DATOS voz_0x13: la voz digital 0x13 (la marca del final es 0xAF); sigue en
;   el banco 14
;   0x9da6..0xa000  (602 bytes)
DATA_voz_0x13:
	defb 0afh,0ddh,003h,044h,0feh,0ddh,013h,03fh,0edh,0dfh,023h,01eh,0deh,0e1h,032h,00fh	; 9da6  ...D...?..#...2.
	defb 0efh,022h,020h,0eeh,0e0h,022h,00fh,0deh,000h,022h,021h,00eh,0feh,0ffh,0efh,011h	; 9db6  ." .."..."!.....
	defb 022h,020h,001h,012h,021h,00fh,0efh,0eeh,0dch,0e3h,043h,0dbh,0d3h,056h,04dh,0bah	; 9dc6  " ..!.....C..VM.
	defb 0c4h,065h,01bh,0ach,035h,054h,0cbh,0b3h,055h,04ch,0bch,024h,053h,0dch,0cch,013h	; 9dd6  .e..5T..UL.$S...
	defb 02dh,0cch,0e3h,033h,01eh,0dfh,034h,04fh,0edh,0edh,0dch,0cch,0e4h,044h,033h,0e2h	; 9de6  -..3..4O.....D3.
	defb 034h,03fh,0cch,0cdh,034h,033h,0ddh,004h,045h,03dh,0cch,0e3h,044h,01ch,0cch,034h	; 9df6  4?..43..E=..D..4
	defb 041h,0dch,0cdh,032h,0edh,0ddh,0d1h,033h,01fh,0edh,0f0h,023h,00eh,0ddh,002h,032h	; 9e06  A..2...3...#...2
	defb 01dh,0deh,023h,032h,0fdh,0ddh,023h,031h,0ddh,0d1h,034h,031h,0edh,0ddh,003h,022h	; 9e16  ..#2..#1..41..."
	defb 00eh,0e2h,032h,000h,012h,013h,022h,0efh,011h,023h,03fh,0ddh,0d0h,022h,02eh,0ddh	; 9e26  ..2..."..#?.."..
	defb 0e0h,01fh,0edh,0ddh,023h,020h,0deh,012h,032h,01eh,011h,023h,0edh,0ddh,012h,031h	; 9e36  ....# ..2..#...1
	defb 0feh,0dch,0f3h,011h,0fdh,0ddh,0e2h,012h,022h,01fh,0ffh,0f0h,01eh,0f1h,033h,033h	; 9e46  ........".....33
	defb 032h,0feh,000h,033h,042h,010h,010h,010h,0efh,010h,02eh,0dch,0cch,0ceh,033h,01dh	; 9e56  2..3B.........3.
	defb 0dch,0d0h,033h,044h,043h,01fh,0e2h,033h,043h,032h,010h,00fh,0f0h,023h,032h,0ech	; 9e66  ..3DC..3C2...#2.
	defb 0cch,0efh,0feh,0dch,0bch,0bch,0cch,0c0h,034h,045h,044h,042h,002h,023h,044h,033h	; 9e76  ........4EDB.#D3
	defb 021h,002h,034h,043h,03eh,0cdh,003h,044h,03eh,0cch,0bbh,0abh,0abh,0cch,035h,055h	; 9e86  !.4C>..D>.....5U
	defb 055h,02dh,0dfh,034h,044h,033h,002h,024h,043h,031h,0edh,0ddh,0e0h,01fh,0edh,0ddh	; 9e96  U-.4D3.$C1......
	defb 0cch,0cbh,0aah,0bch,0e3h,066h,064h,02bh,0bbh,0c1h,055h,055h,053h,0e0h,033h,044h	; 9ea6  .....fd+..UUS.3D
	defb 053h,00dh,0cch,0ceh,024h,033h,0dch,0bbh,0a9h,0bch,023h,066h,066h,0dbh,0aah,0c0h	; 9eb6  S...$3....#ff...
	defb 055h,065h,043h,0cdh,024h,055h,054h,0fch,0bbh,0cfh,045h,044h,0dbh,0bah,09ah,0bfh	; 9ec6  UeC.$UT...ED....
	defb 035h,067h,063h,0bah,0abh,0b4h,056h,065h,00ch,0cch,024h,056h,054h,0cbh,0bbh,0b4h	; 9ed6  5gc...Ve..$VT...
	defb 055h,043h,0cbh,0a9h,09fh,000h,047h,066h,05ch,0aah,0ach,045h,065h,055h,0dch,0dfh	; 9ee6  UC....Gf\..EeU..
	defb 045h,055h,043h,0cbh,0bbh,0d4h,055h,03dh,0bah,09ah,0bch,0d5h,077h,05ch,0aah,0abh	; 9ef6  EUC...U=....w\..
	defb 0d5h,055h,055h,043h,0e2h,034h,045h,054h,02ch,0bbh,0b0h,045h,051h,0cah,099h,0ceh	; 9f06  .UUC.4ET,..EQ...
	defb 024h,077h,06dh,0aah,0abh,0c3h,055h,055h,044h,033h,032h,034h,054h,043h,0cbh,0adh	; 9f16  $wm...UUD324TC..
	defb 045h,054h,0dah,099h,0b0h,024h,077h,060h,0aah,0aah,014h,055h,054h,044h,043h,044h	; 9f26  ET...$w`...UTDCD
	defb 043h,044h,040h,0cbh,0bbh,035h,054h,0dah,099h,0ceh,035h,077h,06ch,0a9h,0ach,045h	; 9f36  CD@..5T...5wl..E
	defb 055h,043h,034h,045h,043h,044h,044h,03dh,0bbh,0bdh,045h,054h,0bah,099h,0dfh,046h	; 9f46  UC4ECDD=..ET...F
	defb 077h,05bh,09ah,0aeh,045h,055h,024h,044h,054h,044h,034h,034h,03ch,0bbh,0bfh,055h	; 9f56  w[..EU$DTD44<..U
	defb 05fh,0a9h,09bh,0e3h,057h,076h,0dah,09ah,0d4h,055h,03eh,024h,055h,055h,03fh,002h	; 9f66  _...Wv...U>$UU?.
	defb 034h,03ch,0bbh,0b4h,055h,04ch,0a9h,09dh,0f4h,077h,065h,0a9h,0abh,045h,055h,0dch	; 9f76  4<..UL...we..EU.
	defb 004h,056h,064h,02dh,0cdh,001h,0dch,0bdh,045h,053h,0bah,099h,0e2h,037h,076h,05ah	; 9f86  .Vd-....ES...7vZ
	defb 0aah,0a4h,055h,0fbh,0ceh,046h,066h,054h,0bbh,0cdh,022h,0fdh,0d1h,045h,01bh,0a9h	; 9f96  ..U..FfT.."..E..
	defb 0abh,0c3h,067h,074h,0aah,0abh,035h,05dh,0bch,0c4h,066h,066h,02bh,0bah,0e3h,044h	; 9fa6  ..gt..5]..ff+..D
	defb 01eh,013h,040h,0bah,09ah,0bdh,036h,077h,04bh,0aah,0bch,044h,0ech,0b1h,056h,066h	; 9fb6  ..@...6wK..D..Vf
	defb 06eh,0bah,0bbh,044h,044h,022h,043h,0dbh,0a9h,0abh,0d3h,067h,074h,0bah,0abh,014h	; 9fc6  n..DD"C....gt...
	defb 02ch,0bbh,0e5h,066h,075h,04bh,0aah,0beh,055h,044h,002h,00dh,0bah,09ah,0bfh,036h	; 9fd6  ,..fuK..UD.....6
	defb 076h,06ch,0abh,0bch,03fh,0cbh,0bdh,056h,067h,06eh,0bah,0aah,015h,055h,043h,01eh	; 9fe6  vl..?..Vgn...UC.
	defb 0dbh,0a9h,0abh,0e3h,067h,066h,0dbh,0abh,0c3h,0ebh	; 9ff6  ....gf....
