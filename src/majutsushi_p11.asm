; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 11 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS tiles_9F39_cola: los dibujos de 25 tiles de una entrada de la imagen
;   9502 de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949) (sigue
;   del banco 10); lo leen p00:5CC2 (201 bytes)
;   0xa000..0xa0c9  (201 bytes)
DATA_tiles_9F39_cola:
	defb 094h,0ffh,09ch,07fh,041h,03eh,03eh,000h,000h,03fh,03fh,0ffh,0c0h,0ffh,09fh,0ffh	; a000  ....A>>..??.....
	defb 0c1h,0ffh,0fch,0ffh,081h,07eh,07eh,000h,000h,063h,063h,0f7h,094h,0ffh,09ch,0ffh	; a010  .....~~..cc.....
	defb 080h,0ffh,09ch,0f7h,094h,063h,063h,000h,000h,000h,000h,080h,080h,080h,080h,080h	; a020  .....cc.........
	defb 080h,080h,080h,080h,080h,000h,000h,000h,000h,03fh,03fh,07fh,040h,0ffh,09fh,07fh	; a030  .........??.@...
	defb 041h,07fh,07ch,0ffh,081h,07eh,07eh,000h,000h,07eh,07eh,0ffh,081h,0ffh,09ch,0ffh	; a040  A.|..~~..~~.....
	defb 081h,0feh,09eh,0f0h,090h,060h,060h,000h,000h,03eh,03eh,07fh,041h,0ffh,09ch,0ffh	; a050  .....``..>>.A...
	defb 09ch,0ffh,080h,0ffh,09ch,063h,063h,000h,000h,03eh,03eh,07fh,041h,0ffh,09ch,0f3h	; a060  .....cc..>>.A...
	defb 093h,0ffh,09ch,0ffh,0c1h,03eh,03eh,000h,000h,07fh,07fh,0ffh,080h,0ffh,09fh,0feh	; a070  .....>>.........
	defb 082h,0ffh,09fh,0ffh,080h,07fh,07fh,000h,000h,000h,000h,080h,080h,000h,000h,000h	; a080  ................
	defb 000h,000h,000h,080h,080h,000h,000h,000h,000h,067h,067h,0ffh,098h,0ffh,091h,0feh	; a090  .........gg.....
	defb 082h,0ffh,091h,0ffh,098h,067h,067h,000h,000h,07fh,07fh,0ffh,080h,0ffh,09fh,0feh	; a0a0  .....gg.........
	defb 082h,0ffh,09fh,0ffh,080h,07fh,07fh,000h,000h,066h,066h,0ffh,099h,0ffh,099h,07eh	; a0b0  .........ff....~
	defb 042h,03ch,024h,0bch,0a4h,018h,018h,000h,000h	; a0c0  B<$......

; ----------------------------------------------------------------------
; DATOS tiles_A0C9: los dibujos de 2 tiles de una entrada de la imagen 9502 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5CC2 (32 bytes)
;   0xa0c9..0xa0e9  (32 bytes)
DATA_tiles_A0C9:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,000h,0ffh,0ffh	; a0c9  ................
	defb 000h,000h,000h,000h,0ffh,0ffh,0ffh,000h,0ffh,000h,0ffh,0ffh,0ffh,0ffh,000h,0ffh	; a0d9  ................

; ----------------------------------------------------------------------
; DATOS bloques_A0E9: lista de tiles (p00:58C5): X, Y y bloques (bit 7: n
;   tiles seguidos; si no, un tile repetido n veces), 0xFF acaba; lo leen
;   p00:5CDD (874 bytes)
;   0xa0e9..0xa453  (874 bytes)
DATA_bloques_A0E9:
	defb 000h,000h,0feh,088h,089h,000h,081h,000h,000h,08ah,07eh,081h,088h,089h,000h,088h	; a0e9  ..........~.....
	defb 089h,07fh,000h,000h,088h,07eh,080h,07eh,000h,088h,089h,000h,088h,089h,084h,088h	; a0f9  .....~.~........
	defb 088h,089h,07eh,088h,089h,000h,082h,000h,000h,088h,07fh,083h,088h,089h,000h,08ah	; a109  ..~.............
	defb 08bh,07eh,000h,000h,08ah,07eh,000h,07eh,000h,08ah,08bh,000h,088h,089h,085h,088h	; a119  .~...~.~........
	defb 088h,089h,07eh,088h,089h,081h,091h,080h,08fh,088h,07eh,000h,088h,089h,000h,088h	; a129  ..~.......~.....
	defb 089h,07eh,081h,000h,088h,07eh,000h,07fh,000h,088h,089h,000h,088h,089h,086h,08ah	; a139  .~...~..........
	defb 088h,089h,07eh,08ah,08bh,082h,092h,000h,07eh,088h,07eh,000h,08ah,08bh,000h,088h	; a149  ..~.....~.~.....
	defb 089h,07eh,082h,000h,088h,07fh,081h,07eh,000h,088h,089h,000h,08ah,08bh,087h,088h	; a159  .~.....~........
	defb 088h,0feh,089h,07eh,088h,089h,091h,093h,080h,07eh,088h,07eh,081h,088h,089h,000h	; a169  ...~.....~.~....
	defb 088h,089h,07fh,091h,000h,088h,07eh,083h,07eh,000h,088h,089h,080h,088h,089h,082h	; a179  ......~.~.......
	defb 088h,08ah,08bh,07fh,088h,089h,092h,094h,000h,07fh,08ah,07eh,082h,088h,089h,000h	; a189  ...........~....
	defb 088h,089h,07eh,092h,084h,088h,07eh,080h,07eh,000h,08ah,08bh,000h,088h,089h,091h	; a199  ..~...~.~.......
	defb 088h,088h,089h,07eh,088h,089h,093h,095h,000h,07eh,088h,07fh,091h,088h,089h,000h	; a1a9  ...~.....~......
	defb 088h,089h,07eh,093h,085h,088h,07eh,000h,07eh,081h,088h,089h,000h,088h,089h,092h	; a1b9  ..~...~.~.......
	defb 088h,088h,089h,07eh,088h,089h,094h,000h,081h,07eh,088h,07eh,092h,088h,089h,000h	; a1c9  ...~.....~.~....
	defb 088h,089h,07eh,094h,086h,088h,07eh,000h,07fh,083h,088h,089h,081h,088h,089h,093h	; a1d9  ..~...~.........
	defb 0feh,088h,088h,089h,07eh,088h,089h,095h,000h,082h,07eh,088h,07eh,093h,088h,089h	; a1e9  ....~.....~.~...
	defb 000h,08ah,08bh,07eh,095h,087h,08ah,07eh,000h,07eh,000h,088h,089h,083h,088h,089h	; a1f9  ...~...~.~......
	defb 094h,088h,088h,089h,07eh,08ah,08bh,097h,000h,091h,07eh,088h,07eh,094h,088h,089h	; a209  ....~.....~.~...
	defb 000h,088h,089h,07fh,000h,082h,088h,07fh,084h,07eh,000h,088h,089h,084h,08ah,08bh	; a219  .........~......
	defb 095h,08ah,088h,089h,07eh,088h,089h,088h,096h,092h,07eh,088h,07eh,095h,088h,089h	; a229  ....~.....~.~...
	defb 084h,088h,089h,07eh,000h,091h,088h,07eh,085h,07eh,000h,088h,089h,085h,088h,089h	; a239  ...~...~.~......
	defb 081h,088h,088h,089h,07fh,088h,089h,088h,089h,093h,07fh,08ah,07eh,000h,08ah,08bh	; a249  ............~...
	defb 085h,088h,089h,07eh,000h,092h,088h,07eh,086h,07eh,000h,08ah,08bh,086h,088h,0feh	; a259  ...~...~.~......
	defb 089h,083h,088h,08ah,08bh,07eh,088h,089h,08ah,08bh,094h,07eh,088h,07fh,081h,088h	; a269  .....~.....~....
	defb 089h,086h,088h,089h,07eh,000h,093h,088h,07eh,087h,07eh,000h,088h,089h,087h,088h	; a279  ....~...~.~.....
	defb 089h,084h,088h,088h,089h,07eh,088h,089h,088h,089h,095h,07eh,088h,07eh,083h,088h	; a289  .....~.....~.~..
	defb 089h,087h,088h,089h,07eh,084h,094h,088h,07eh,082h,07fh,000h,088h,089h,080h,088h	; a299  ....~...~.......
	defb 089h,085h,088h,088h,089h,07eh,088h,089h,088h,089h,08dh,07eh,088h,07eh,000h,088h	; a2a9  .....~.....~.~..
	defb 089h,081h,088h,089h,07fh,085h,095h,088h,07eh,091h,07eh,000h,088h,089h,000h,088h	; a2b9  ........~.~.....
	defb 089h,086h,088h,088h,089h,07eh,088h,089h,088h,090h,089h,07eh,088h,07eh,000h,088h	; a2c9  .....~.....~.~..
	defb 089h,083h,088h,089h,07eh,086h,08fh,088h,07fh,092h,07eh,000h,088h,089h,0feh,000h	; a2d9  ....~.....~.....
	defb 088h,089h,087h,088h,088h,089h,07eh,088h,089h,088h,08ah,08bh,07eh,088h,07eh,000h	; a2e9  ......~.....~.~.
	defb 088h,089h,000h,088h,089h,07eh,087h,07eh,08ah,07eh,093h,07eh,000h,088h,089h,000h	; a2f9  .....~.~.~.~....
	defb 08ah,08bh,082h,088h,088h,089h,07fh,08ah,08bh,088h,088h,089h,07eh,088h,07eh,080h	; a309  ............~.~.
	defb 088h,089h,000h,08ah,08bh,07eh,080h,07eh,088h,07eh,094h,07eh,000h,08ah,08bh,000h	; a319  .....~.~.~.~....
	defb 088h,089h,091h,08ah,088h,089h,07eh,088h,089h,08ah,088h,089h,07fh,08ah,07eh,081h	; a329  ......~.......~.
	defb 088h,089h,000h,088h,089h,07eh,081h,07eh,088h,07eh,095h,07eh,000h,088h,089h,08ch	; a339  .....~.~.~.~....
	defb 088h,089h,092h,088h,088h,089h,07eh,088h,089h,088h,088h,089h,07eh,088h,07fh,083h	; a349  ......~.....~...
	defb 088h,089h,000h,088h,089h,07fh,082h,07eh,088h,07eh,000h,07fh,000h,0feh,088h,089h	; a359  .......~.~......
	defb 088h,088h,089h,093h,088h,08ah,08bh,07eh,088h,089h,088h,088h,089h,07eh,088h,07eh	; a369  .......~.....~.~
	defb 000h,08ah,08bh,000h,088h,089h,07eh,091h,07fh,088h,07eh,000h,07eh,000h,088h,089h	; a379  ......~...~.~...
	defb 088h,088h,089h,094h,088h,088h,089h,07eh,088h,089h,088h,088h,089h,07eh,088h,07eh	; a389  .......~.....~.~
	defb 084h,088h,089h,000h,088h,089h,07eh,092h,07eh,088h,07eh,08dh,07eh,000h,088h,089h	; a399  ......~.~.~.~...
	defb 08ah,088h,089h,095h,088h,088h,089h,07eh,088h,089h,088h,088h,089h,07eh,088h,07eh	; a3a9  .......~.....~.~
	defb 091h,088h,089h,084h,088h,089h,07eh,093h,07eh,088h,08eh,089h,07eh,080h,088h,089h	; a3b9  ......~.~...~...
	defb 088h,088h,089h,081h,088h,088h,089h,07eh,088h,089h,088h,08ah,08bh,07eh,088h,07eh	; a3c9  .......~.....~.~
	defb 092h,088h,089h,085h,088h,089h,07eh,094h,07eh,088h,088h,089h,0ech,07eh,000h,08ah	; a3d9  ......~.~....~..
	defb 08bh,088h,088h,089h,083h,088h,088h,089h,07fh,088h,089h,08ah,088h,089h,07eh,088h	; a3e9  ..............~.
	defb 07eh,093h,088h,089h,094h,088h,089h,07fh,095h,07eh,08ah,088h,089h,07eh,081h,088h	; a3f9  ~........~...~..
	defb 089h,088h,08ah,08bh,081h,088h,088h,089h,07eh,08ah,08bh,088h,088h,089h,07fh,08ah	; a409  ........~.......
	defb 07eh,094h,088h,089h,095h,088h,089h,07eh,000h,07eh,088h,088h,089h,07fh,083h,088h	; a419  ~......~.~......
	defb 089h,088h,088h,089h,083h,08ah,088h,089h,07eh,088h,089h,088h,088h,089h,07eh,088h	; a429  ........~.....~.
	defb 07eh,084h,088h,089h,081h,088h,089h,07eh,000h,07eh,088h,08ah,08bh,07eh,087h,088h	; a439  ~......~.~...~..
	defb 089h,088h,088h,089h,094h,088h,088h,089h,07eh,0ffh	; a449  ........~.

; ----------------------------------------------------------------------
; DATOS bloques_A453: lista de tiles (p00:58C9): X, Y y bloques (bit 7: n
;   tiles seguidos; si no, un tile repetido n veces), 0xFF acaba; lo leen
;   p00:5CD1 (162 bytes)
;   0xa453..0xa4f5  (162 bytes)
DATA_bloques_A453:
	defb 028h,038h,086h,024h,025h,026h,027h,028h,029h,01ah,000h,097h,02ah,05eh,02bh,05ch	; a453  (8.$%&'()...*^+\
	defb 00bh,02ch,02dh,002h,003h,000h,02eh,013h,06eh,014h,06fh,070h,071h,015h,072h,016h	; a463  .,-.....n.opq.r.
	defb 017h,018h,001h,009h,000h,097h,02fh,059h,05ah,05bh,00ch,00dh,030h,079h,05dh,031h	; a473  ....../YZ[..0y]1
	defb 07ah,063h,044h,00fh,073h,045h,046h,004h,047h,048h,049h,019h,01ah,009h,000h,097h	; a483  zcD.sEF.GHI.....
	defb 032h,05fh,060h,061h,00eh,010h,07bh,062h,033h,043h,07ch,04ah,04bh,01bh,04ch,04dh	; a493  2_`a..{b3C|JK.LM
	defb 04eh,005h,04fh,050h,051h,006h,01ch,009h,000h,097h,034h,064h,065h,066h,011h,035h	; a4a3  N.OPQ.....4def.5
	defb 07dh,067h,068h,036h,069h,052h,053h,007h,054h,055h,056h,008h,057h,058h,009h,00ah	; a4b3  }gh6iRS.TUV.WX..
	defb 01dh,009h,000h,098h,037h,06ah,06bh,06ch,012h,038h,039h,03ah,03bh,03ch,03dh,077h	; a4c3  ....7jkl.89:.<=w
	defb 075h,01eh,078h,01fh,077h,020h,078h,021h,022h,023h,098h,099h,008h,000h,086h,03eh	; a4d3  u.x.w x!"#.....>
	defb 06dh,03fh,040h,041h,042h,029h,000h,089h,09ah,09bh,09ch,09dh,09eh,09fh,0a0h,0a1h	; a4e3  m?@AB)..........
	defb 0a2h,0ffh	; a4f3

; ----------------------------------------------------------------------
; DATOS paletas_A4F5: las 40 palabras que apuntan a las paletas de la imagen
;   A635 (p00:5911: palabra A de la tabla); lo leen p00:56FC (80 bytes)
;   0xa4f5..0xa545  (80 bytes)
DATA_paletas_A4F5:
	defw 0a545h,0a54dh,0a551h,0a555h,0a559h,0a55dh,0a561h,0a565h	; a4f5
	defw 0a569h,0a571h,0a575h,0a579h,0a57dh,0a581h,0a585h,0a589h	; a505
	defw 0a591h,0a595h,0a599h,0a59dh,0a5a1h,0a5a5h,0a5a9h,0a5b1h	; a515
	defw 0a5b9h,0a5c1h,0a5c9h,0a5d1h,0a5d9h,0a5e5h,0a5edh,0a5f5h	; a525
	defw 0a5f9h,0a601h,0a609h,0a611h,0a619h,0a621h,0a629h,0a631h	; a535

; ----------------------------------------------------------------------
; DATOS paleta_A545: la paleta 0 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F) (las entradas que la piden copian 2 bytes; el
;   resto, hasta la siguiente paleta, es de otro formato de la misma tabla);
;   lo leen p00:56FC (8 bytes)
;   0xa545..0xa54d  (8 bytes)
DATA_paleta_A545:
	defb 00bh,00fh,006h,00fh,003h,006h,006h,00eh	; a545  ........

; ----------------------------------------------------------------------
; DATOS paleta_A54D: la paleta 1 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa54d..0xa551  (4 bytes)
DATA_paleta_A54D:
	defb 001h,002h,00eh,00fh	; a54d

; ----------------------------------------------------------------------
; DATOS paleta_A551: la paleta 2 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa551..0xa555  (4 bytes)
DATA_paleta_A551:
	defb 005h,00ah,00bh,00fh	; a551

; ----------------------------------------------------------------------
; DATOS paleta_A555: la paleta 3 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa555..0xa559  (4 bytes)
DATA_paleta_A555:
	defb 003h,00bh,00eh,00fh	; a555

; ----------------------------------------------------------------------
; DATOS paleta_A559: la paleta 4 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa559..0xa55d  (4 bytes)
DATA_paleta_A559:
	defb 005h,009h,00bh,00fh	; a559

; ----------------------------------------------------------------------
; DATOS paleta_A55D: la paleta 5 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa55d..0xa561  (4 bytes)
DATA_paleta_A55D:
	defb 009h,00bh,00eh,00fh	; a55d

; ----------------------------------------------------------------------
; DATOS paleta_A561: la paleta 6 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa561..0xa565  (4 bytes)
DATA_paleta_A561:
	defb 006h,008h,00eh,00fh	; a561

; ----------------------------------------------------------------------
; DATOS paleta_A565: la paleta 7 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa565..0xa569  (4 bytes)
DATA_paleta_A565:
	defb 002h,004h,008h,00fh	; a565

; ----------------------------------------------------------------------
; DATOS paleta_A569: la paleta 8 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F) (las entradas que la piden copian 4 bytes; el
;   resto, hasta la siguiente paleta, es de otro formato de la misma tabla);
;   lo leen p00:56FC (8 bytes)
;   0xa569..0xa571  (8 bytes)
DATA_paleta_A569:
	defb 006h,00bh,00eh,00fh,003h,006h,00eh,00fh	; a569  ........

; ----------------------------------------------------------------------
; DATOS paleta_A571: la paleta 9 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa571..0xa575  (4 bytes)
DATA_paleta_A571:
	defb 006h,00ah,00ch,00fh	; a571

; ----------------------------------------------------------------------
; DATOS paleta_A575: la paleta 10 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa575..0xa579  (4 bytes)
DATA_paleta_A575:
	defb 005h,009h,00ah,00fh	; a575

; ----------------------------------------------------------------------
; DATOS paleta_A579: la paleta 11 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa579..0xa57d  (4 bytes)
DATA_paleta_A579:
	defb 005h,00ah,00ch,00fh	; a579

; ----------------------------------------------------------------------
; DATOS paleta_A57D: la paleta 12 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa57d..0xa581  (4 bytes)
DATA_paleta_A57D:
	defb 009h,00ah,00bh,00fh	; a57d

; ----------------------------------------------------------------------
; DATOS paleta_A581: la paleta 13 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa581..0xa585  (4 bytes)
DATA_paleta_A581:
	defb 006h,00bh,00ch,00fh	; a581

; ----------------------------------------------------------------------
; DATOS paleta_A585: la paleta 14 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa585..0xa589  (4 bytes)
DATA_paleta_A585:
	defb 008h,00bh,00eh,00fh	; a585

; ----------------------------------------------------------------------
; DATOS paleta_A589: la paleta 15 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F) (las entradas que la piden copian 4 bytes; el
;   resto, hasta la siguiente paleta, es de otro formato de la misma tabla);
;   lo leen p00:56FC (8 bytes)
;   0xa589..0xa591  (8 bytes)
DATA_paleta_A589:
	defb 003h,006h,00bh,00fh,003h,00bh,00eh,00fh	; a589  ........

; ----------------------------------------------------------------------
; DATOS paleta_A591: la paleta 16 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa591..0xa595  (4 bytes)
DATA_paleta_A591:
	defb 002h,006h,00ah,00fh	; a591

; ----------------------------------------------------------------------
; DATOS paleta_A595: la paleta 17 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa595..0xa599  (4 bytes)
DATA_paleta_A595:
	defb 001h,002h,00eh,00fh	; a595

; ----------------------------------------------------------------------
; DATOS paleta_A599: la paleta 18 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa599..0xa59d  (4 bytes)
DATA_paleta_A599:
	defb 001h,002h,00ch,00fh	; a599

; ----------------------------------------------------------------------
; DATOS paleta_A59D: la paleta 19 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa59d..0xa5a1  (4 bytes)
DATA_paleta_A59D:
	defb 001h,002h,009h,00fh	; a59d

; ----------------------------------------------------------------------
; DATOS paleta_A5A1: la paleta 20 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa5a1..0xa5a5  (4 bytes)
DATA_paleta_A5A1:
	defb 001h,002h,00bh,00fh	; a5a1

; ----------------------------------------------------------------------
; DATOS paleta_A5A5: la paleta 21 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa5a5..0xa5a9  (4 bytes)
DATA_paleta_A5A5:
	defb 004h,006h,00eh,00fh	; a5a5

; ----------------------------------------------------------------------
; DATOS paleta_A5A9: la paleta 22 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5a9..0xa5b1  (8 bytes)
DATA_paleta_A5A9:
	defb 004h,006h,007h,008h,009h,00bh,00eh,00fh	; a5a9  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5B1: la paleta 23 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5b1..0xa5b9  (8 bytes)
DATA_paleta_A5B1:
	defb 001h,002h,009h,00bh,00ch,00dh,00eh,00fh	; a5b1  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5B9: la paleta 24 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5b9..0xa5c1  (8 bytes)
DATA_paleta_A5B9:
	defb 001h,002h,003h,006h,009h,00bh,00eh,00fh	; a5b9  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5C1: la paleta 25 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5c1..0xa5c9  (8 bytes)
DATA_paleta_A5C1:
	defb 001h,002h,006h,008h,00bh,00dh,00eh,00fh	; a5c1  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5C9: la paleta 26 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5c9..0xa5d1  (8 bytes)
DATA_paleta_A5C9:
	defb 001h,002h,006h,009h,00ah,00ch,00eh,00fh	; a5c9  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5D1: la paleta 27 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5d1..0xa5d9  (8 bytes)
DATA_paleta_A5D1:
	defb 001h,002h,005h,007h,009h,00bh,00eh,00fh	; a5d1  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5D9: la paleta 28 de la imagen A635: 12 bytes de colores que
;   se copian a 0xE800 (p00:592F) (las entradas que la piden copian 8 bytes;
;   el resto, hasta la siguiente paleta, es de otro formato de la misma
;   tabla); lo leen p00:56FC (12 bytes)
;   0xa5d9..0xa5e5  (12 bytes)
DATA_paleta_A5D9:
	defb 001h,002h,008h,00ch,00fh,009h,007h,004h,001h,002h,00bh,00fh	; a5d9  ............

; ----------------------------------------------------------------------
; DATOS paleta_A5E5: la paleta 29 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5e5..0xa5ed  (8 bytes)
DATA_paleta_A5E5:
	defb 001h,002h,003h,006h,008h,00bh,00eh,00fh	; a5e5  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5ED: la paleta 30 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5ed..0xa5f5  (8 bytes)
DATA_paleta_A5ED:
	defb 001h,002h,006h,00ah,00ch,00bh,00eh,00fh	; a5ed  ........

; ----------------------------------------------------------------------
; DATOS paleta_A5F5: la paleta 31 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa5f5..0xa5f9  (4 bytes)
DATA_paleta_A5F5:
	defb 004h,007h,008h,00fh	; a5f5

; ----------------------------------------------------------------------
; DATOS paleta_A5F9: la paleta 32 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa5f9..0xa601  (8 bytes)
DATA_paleta_A5F9:
	defb 001h,002h,004h,007h,008h,00bh,00eh,00fh	; a5f9  ........

; ----------------------------------------------------------------------
; DATOS paleta_A601: la paleta 33 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa601..0xa609  (8 bytes)
DATA_paleta_A601:
	defb 001h,002h,003h,006h,00bh,00ch,00eh,00fh	; a601  ........

; ----------------------------------------------------------------------
; DATOS paleta_A609: la paleta 34 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa609..0xa611  (8 bytes)
DATA_paleta_A609:
	defb 001h,002h,004h,007h,008h,00bh,00eh,00fh	; a609  ........

; ----------------------------------------------------------------------
; DATOS paleta_A611: la paleta 35 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa611..0xa619  (8 bytes)
DATA_paleta_A611:
	defb 001h,002h,003h,006h,009h,00bh,00eh,00fh	; a611  ........

; ----------------------------------------------------------------------
; DATOS paleta_A619: la paleta 36 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa619..0xa621  (8 bytes)
DATA_paleta_A619:
	defb 001h,003h,004h,006h,008h,00bh,00eh,00fh	; a619  ........

; ----------------------------------------------------------------------
; DATOS paleta_A621: la paleta 37 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa621..0xa629  (8 bytes)
DATA_paleta_A621:
	defb 001h,004h,006h,007h,008h,00bh,00eh,00fh	; a621  ........

; ----------------------------------------------------------------------
; DATOS paleta_A629: la paleta 38 de la imagen A635: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (8 bytes)
;   0xa629..0xa631  (8 bytes)
DATA_paleta_A629:
	defb 001h,004h,006h,007h,008h,00bh,00eh,00fh	; a629  ........

; ----------------------------------------------------------------------
; DATOS paleta_A631: la paleta 39 de la imagen A635: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:56FC (4 bytes)
;   0xa631..0xa635  (4 bytes)
DATA_paleta_A631:
	defb 004h,008h,00bh,00fh	; a631

; ----------------------------------------------------------------------
; DATOS imagen_A635: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:56FC (253 bytes)
;   0xa635..0xa732  (253 bytes)
DATA_imagen_A635:
	defb 000h,000h,001h,00ch,032h,0a7h	; a635
	defb 002h,001h,011h,010h,092h,0a7h	; a63b
	defb 002h,002h,021h,017h,092h,0a8h	; a641
	defb 002h,003h,038h,001h,002h,0aah	; a647
	defb 002h,004h,039h,002h,012h,0aah	; a64d
	defb 002h,005h,03bh,005h,032h,0aah	; a653
	defb 002h,006h,040h,003h,082h,0aah	; a659
	defb 002h,007h,043h,001h,0b2h,0aah	; a65f
	defb 002h,008h,048h,002h,0c2h,0aah	; a665
	defb 002h,009h,04fh,001h,0e2h,0aah	; a66b
	defb 002h,00ah,050h,008h,0f2h,0aah	; a671
	defb 002h,00bh,058h,004h,072h,0abh	; a677
	defb 002h,00ch,05ch,002h,0b2h,0abh	; a67d
	defb 002h,00dh,05eh,002h,0d2h,0abh	; a683
	defb 002h,00eh,060h,001h,0f2h,0abh	; a689
	defb 002h,00fh,061h,005h,002h,0ach	; a68f
	defb 002h,010h,070h,002h,052h,0ach	; a695
	defb 002h,011h,072h,001h,072h,0ach	; a69b
	defb 002h,012h,073h,005h,082h,0ach	; a6a1
	defb 002h,013h,078h,002h,0d2h,0ach	; a6a7
	defb 002h,014h,07ah,008h,0f2h,0ach	; a6ad
	defb 002h,015h,082h,002h,072h,0adh	; a6b3
	defb 004h,016h,084h,012h,092h,0adh	; a6b9
	defb 005h,016h,096h,004h,0e2h,0aeh	; a6bf
	defb 004h,017h,09ah,010h,042h,0afh	; a6c5
	defb 004h,018h,0abh,00bh,0c2h,0b0h	; a6cb
	defb 004h,019h,0b6h,008h,0cah,0b1h	; a6d1
	defb 004h,01ah,0beh,006h,08ah,0b2h	; a6d7
	defb 004h,01bh,0c9h,003h,01ah,0b3h	; a6dd
	defb 004h,01ch,0ceh,001h,062h,0b3h	; a6e3
	defb 004h,01dh,0e6h,014h,012h,0b6h	; a6e9
	defb 004h,01eh,0cfh,010h,07ah,0b3h	; a6ef
	defb 002h,01fh,066h,007h,0a2h,0b5h	; a6f5
	defb 004h,020h,0dfh,007h,0fah,0b4h	; a6fb
	defb 004h,021h,0fah,002h,022h,0b8h	; a701
	defb 004h,022h,0fch,002h,0fah,0b8h	; a707
	defb 004h,023h,04ah,002h,0f2h,0b7h	; a70d
	defb 004h,024h,044h,004h,052h,0b8h	; a713
	defb 004h,025h,00dh,002h,02ah,0b9h	; a719
	defb 005h,025h,00fh,002h,02ah,0b9h	; a71f
	defb 004h,026h,06dh,003h,0b2h,0b8h	; a725
	defb 002h,027h,0cch,002h,05ah,0b9h	; a72b
	defb 0ffh	; a731

; ----------------------------------------------------------------------
; DATOS tiles_A732: los dibujos de 12 tiles de una entrada de la imagen A635
;   de p00:5911: 8 por tile, tiles de 1 bits por punto (p00:5949); lo leen
;   p00:56FC (96 bytes)
;   0xa732..0xa792  (96 bytes)
DATA_tiles_A732:
	defb 000h,001h,003h,001h,000h,00fh,007h,003h	; a732  ........
	defb 017h,09fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a73a  ........
	defb 087h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a742  ........
	defb 09fh,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a74a  ........
	defb 070h,0e3h,0f7h,0ffh,0feh,0ffh,0ffh,0ffh	; a752  p.......
	defb 0c0h,080h,000h,018h,078h,0f0h,0e0h,0c8h	; a75a  ....x...
	defb 021h,03bh,01fh,01fh,00fh,007h,00fh,03fh	; a762  !......?
	defb 017h,003h,007h,007h,00ch,008h,000h,000h	; a76a  ........
	defb 00fh,00fh,00fh,007h,007h,007h,003h,001h	; a772  ........
	defb 0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0c0h,080h	; a77a  ........
	defb 000h,000h,000h,000h,000h,000h,000h,086h	; a782  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a78a  ........

; ----------------------------------------------------------------------
; DATOS tiles_A792: los dibujos de 16 tiles de una entrada de la imagen A635
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (256 bytes)
;   0xa792..0xa892  (256 bytes)
DATA_tiles_A792:
	defb 000h,000h,000h,000h,001h,001h,002h,002h,000h,000h,000h,000h,000h,000h,0c0h,000h	; a792  ................
	defb 007h,001h,083h,083h,082h,083h,080h,081h,081h,000h,080h,000h,080h,000h,000h,000h	; a7a2  ................
	defb 080h,000h,0c0h,080h,000h,000h,000h,000h,0f0h,0f0h,088h,088h,060h,000h,000h,000h	; a7b2  ............`...
	defb 03eh,0efh,01eh,0f3h,05eh,0f3h,01eh,0f7h,037h,0f1h,0e1h,0e0h,038h,010h,000h,000h	; a7c2  >...^...7...8...
	defb 097h,078h,06eh,000h,018h,000h,000h,000h,000h,000h,000h,000h,083h,001h,001h,000h	; a7d2  .xn.............
	defb 0e9h,01eh,076h,000h,018h,000h,000h,000h,040h,000h,040h,000h,0e1h,080h,0c0h,000h	; a7e2  ..v.....@.@.....
	defb 000h,000h,000h,000h,00fh,007h,098h,008h,0c3h,080h,0e1h,0c0h,0f0h,0e0h,0fch,0f0h	; a7f2  ................
	defb 000h,000h,000h,000h,0f0h,0e0h,019h,010h,0c3h,001h,087h,003h,00fh,007h,03fh,00fh	; a802  ..............?.
	defb 0ffh,01bh,0dfh,001h,083h,080h,0e0h,060h,0f9h,010h,0ffh,0f9h,00fh,0fch,016h,0fch	; a812  .......`........
	defb 08ch,0f8h,078h,070h,000h,000h,000h,000h,000h,000h,000h,000h,0a3h,001h,041h,000h	; a822  ..xp..........A.
	defb 031h,01fh,01eh,00eh,000h,000h,000h,000h,040h,000h,040h,000h,0e5h,080h,0c2h,000h	; a832  1.......@.@.....
	defb 0e0h,080h,0e0h,0c0h,0e0h,0e0h,060h,020h,000h,000h,000h,000h,000h,000h,000h,000h	; a842  ......` ........
	defb 000h,000h,000h,000h,020h,020h,03fh,01fh,01fh,000h,006h,006h,000h,000h,0c0h,000h	; a852  ....  ?.........
	defb 004h,004h,000h,000h,001h,001h,002h,002h,080h,000h,080h,000h,080h,000h,000h,000h	; a862  ................
	defb 03fh,0edh,01eh,0f3h,01eh,0f3h,01fh,0f7h,0f7h,0f1h,0e1h,020h,038h,010h,000h,000h	; a872  ?.......... 8...
	defb 0e0h,0e0h,0a0h,0e0h,080h,0c0h,080h,0c0h,000h,080h,080h,000h,000h,000h,000h,000h	; a882  ................

; ----------------------------------------------------------------------
; DATOS tiles_A892: los dibujos de 23 tiles de una entrada de la imagen A635
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (368 bytes)
;   0xa892..0xaa02  (368 bytes)
DATA_tiles_A892:
	defb 000h,0ffh,0fch,0ffh,003h,003h,000h,000h,000h,000h,000h,000h,080h,000h,042h,002h	; a892  ..............B.
	defb 000h,0ffh,000h,0ffh,080h,0ffh,060h,07fh,018h,01fh,00ch,00fh,006h,007h,043h,043h	; a8a2  ......`.......CC
	defb 001h,0ffh,007h,0ffh,018h,0f8h,061h,0e0h,087h,080h,0c3h,0c0h,07fh,0f0h,03fh,0fah	; a8b2  ......a.......?.
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,001h,0ffh,002h,0feh,003h,0feh	; a8c2  ................
	defb 091h,091h,021h,020h,041h,040h,020h,020h,090h,090h,040h,040h,000h,000h,000h,000h	; a8d2  ..! A@  ..@@....
	defb 080h,0ffh,080h,0ffh,0c0h,0ffh,0c0h,07fh,0c0h,07fh,0e0h,07fh,0e0h,03fh,0e0h,03fh	; a8e2  .............?.?
	defb 07fh,0dch,0bdh,080h,060h,0e0h,018h,0f8h,004h,0fch,002h,0feh,001h,0ffh,000h,0ffh	; a8f2  ....`...........
	defb 0c0h,000h,0c0h,000h,0c0h,000h,040h,000h,060h,000h,038h,010h,01fh,004h,087h,082h	; a902  ......@.`.8.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,010h,000h,008h,000h,088h,000h	; a912  ................
	defb 000h,000h,001h,000h,001h,000h,003h,000h,00fh,007h,000h,000h,000h,000h,00fh,00fh	; a922  ................
	defb 0e0h,03fh,0e0h,03fh,0c0h,07fh,0c0h,07fh,0c0h,0ffh,0c0h,0ffh,020h,03fh,090h,09fh	; a932  .?.?........ ?..
	defb 043h,0c0h,021h,0e0h,011h,0f0h,011h,0f0h,012h,0f0h,026h,0e0h,048h,0c0h,080h,080h	; a942  C.!.......&.H...
	defb 08ch,000h,08ch,000h,088h,000h,010h,000h,001h,000h,003h,000h,003h,000h,007h,000h	; a952  ................
	defb 03fh,030h,07ch,040h,078h,040h,031h,031h,086h,087h,0f8h,07fh,0f0h,01fh,0f0h,03fh	; a962  ?0|@x@11.......?
	defb 020h,03fh,040h,07fh,080h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; a972   ?@.............
	defb 000h,000h,000h,000h,000h,000h,003h,000h,00fh,000h,01fh,010h,07eh,070h,0feh,0f8h	; a982  ............~p..
	defb 01fh,000h,03fh,000h,0f7h,000h,0c3h,000h,083h,000h,003h,000h,003h,000h,003h,001h	; a992  ..?.............
	defb 0feh,042h,0f8h,040h,0f0h,0e0h,070h,0e0h,030h,0e0h,038h,0f0h,01ch,0f8h,01fh,0f4h	; a9a2  .B.@..p.0.8.....
	defb 03fh,03fh,01fh,016h,00eh,002h,01fh,004h,01eh,008h,034h,010h,07dh,028h,0ffh,084h	; a9b2  ??........4.}(..
	defb 0fch,0fch,0f8h,068h,070h,040h,0f8h,020h,078h,010h,02ch,008h,0beh,014h,0ffh,021h	; a9c2  ...hp@. x.,....!
	defb 07fh,042h,01fh,002h,00fh,007h,00eh,007h,00ch,007h,01ch,00fh,078h,01fh,0f8h,02fh	; a9d2  .B..........x../
	defb 0efh,003h,0c7h,003h,0c0h,000h,081h,001h,043h,003h,003h,003h,083h,003h,0c1h,001h	; a9e2  ........C.......
	defb 0f3h,0c0h,0e3h,0c0h,001h,000h,081h,080h,0c2h,0c0h,0c0h,0c0h,0c1h,0c0h,083h,080h	; a9f2  ................

; ----------------------------------------------------------------------
; DATOS tiles_AA02: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (16 bytes)
;   0xaa02..0xaa12  (16 bytes)
DATA_tiles_AA02:
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0f7h,0f0h,01bh,018h,007h,004h,037h,03ch,077h,07ch	; aa02  ............7<w|

; ----------------------------------------------------------------------
; DATOS tiles_AA12: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xaa12..0xaa32  (32 bytes)
DATA_tiles_AA12:
	defb 000h,0ffh,007h,0ffh,03eh,0f6h,0feh,0d8h,0f8h,060h,0c0h,080h,000h,000h,000h,000h	; aa12  ....>....`......
	defb 001h,0ffh,002h,0feh,00ch,0fch,010h,0f0h,0cch,0fch,0e8h,038h,0fch,07ch,0ffh,067h	; aa22  ...........8.|.g

; ----------------------------------------------------------------------
; DATOS tiles_AA32: los dibujos de 5 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (80 bytes)
;   0xaa32..0xaa82  (80 bytes)
DATA_tiles_AA32:
	defb 001h,0ffh,000h,0ffh,078h,0ffh,0fch,0ffh,034h,0ffh,002h,0ffh,002h,0feh,004h,0fch	; aa32  ....x...4.......
	defb 080h,0ffh,000h,0ffh,01eh,0ffh,03fh,0ffh,02ch,0ffh,040h,0ffh,040h,07fh,020h,03fh	; aa42  ......?.,.@.@. ?
	defb 0f8h,00fh,0f0h,01eh,0e0h,03ch,0e0h,03ch,0c0h,07ch,0c0h,07ch,0c0h,07eh,0e0h,03fh	; aa52  .....<.<.|.|.~.?
	defb 003h,0feh,001h,03fh,000h,01fh,000h,01fh,000h,01fh,000h,01fh,000h,03fh,000h,0ffh	; aa62  ...?.........?..
	defb 0ffh,001h,0ffh,001h,0ffh,001h,0ffh,001h,0ffh,001h,0ffh,001h,0ffh,001h,0feh,007h	; aa72  ................

; ----------------------------------------------------------------------
; DATOS tiles_AA82: los dibujos de 3 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (48 bytes)
;   0xaa82..0xaab2  (48 bytes)
DATA_tiles_AA82:
	defb 0f0h,033h,0f0h,033h,0f0h,0d3h,0f0h,013h,0f0h,013h,0f0h,011h,0f0h,011h,0f8h,008h	; aa82  .3.3............
	defb 00fh,0c8h,00fh,0c8h,00fh,0c8h,00fh,0c8h,00fh,0c8h,00fh,088h,00fh,088h,01fh,010h	; aa92  ................
	defb 0ffh,080h,07fh,040h,07fh,040h,03fh,020h,03fh,0a0h,01fh,090h,01fh,090h,01fh,090h	; aaa2  ...@.@? ?.......

; ----------------------------------------------------------------------
; DATOS tiles_AAB2: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (16 bytes)
;   0xaab2..0xaac2  (16 bytes)
DATA_tiles_AAB2:
	defb 03fh,0cdh,00fh,0f5h,0c5h,0fbh,0f8h,0ffh,09eh,09fh,007h,007h,003h,003h,0f9h,0f9h	; aab2  ?...............

; ----------------------------------------------------------------------
; DATOS tiles_AAC2: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xaac2..0xaae2  (32 bytes)
DATA_tiles_AAC2:
	defb 001h,0ffh,000h,0ffh,080h,0ffh,0f3h,0eeh,0ffh,0f2h,0ffh,07ch,0ffh,03eh,0ffh,0feh	; aac2  ...........|.>..
	defb 080h,0ffh,00ah,0ffh,02bh,0ffh,02bh,0ffh,0efh,0bfh,0ffh,0beh,0ffh,07ch,0ffh,07fh	; aad2  ....+.+......|..

; ----------------------------------------------------------------------
; DATOS tiles_AAE2: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (16 bytes)
;   0xaae2..0xaaf2  (16 bytes)
DATA_tiles_AAE2:
	defb 07eh,0ffh,04fh,0cfh,0b7h,087h,09fh,09bh,0dfh,0cfh,04fh,0c7h,02fh,0e1h,013h,0f0h	; aae2  ~.O.......O./...

; ----------------------------------------------------------------------
; DATOS tiles_AAF2: los dibujos de 8 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (128 bytes)
;   0xaaf2..0xab72  (128 bytes)
DATA_tiles_AAF2:
	defb 009h,069h,004h,0f4h,082h,0f2h,0c4h,074h,0c9h,0e9h,002h,002h,000h,000h,000h,000h	; aaf2  .i.....t........
	defb 004h,007h,000h,004h,003h,003h,007h,006h,004h,007h,000h,004h,003h,003h,007h,006h	; ab02  ................
	defb 020h,0e0h,000h,020h,0c0h,0c0h,0e0h,060h,020h,0e0h,000h,020h,0c0h,0c0h,0e0h,060h	; ab12   .. ...` .. ...`
	defb 0c0h,0e0h,0c0h,0e1h,0c0h,0f2h,0c0h,0f4h,040h,07eh,049h,07fh,047h,0feh,047h,0fdh	; ab22  ........@~I.G.G.
	defb 000h,003h,000h,0e0h,000h,010h,000h,00ah,000h,00eh,0e0h,0efh,0f2h,0bfh,0ffh,06fh	; ab32  ...............o
	defb 000h,0c0h,000h,007h,000h,008h,000h,050h,000h,070h,007h,0f7h,04fh,0fdh,0ffh,0f6h	; ab42  .......P.p..O...
	defb 003h,007h,003h,087h,003h,04fh,003h,02fh,002h,07eh,092h,0feh,0e2h,07fh,0e2h,0bfh	; ab52  .....O./.~......
	defb 000h,0f8h,098h,0ffh,07fh,0f7h,03fh,0e0h,07fh,0f1h,08eh,0feh,000h,0f8h,000h,0e0h	; ab62  ......?.........

; ----------------------------------------------------------------------
; DATOS tiles_AB72: los dibujos de 4 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (64 bytes)
;   0xab72..0xabb2  (64 bytes)
DATA_tiles_AB72:
	defb 047h,003h,08fh,087h,01fh,01fh,03fh,03fh,0feh,0ffh,0f8h,0ffh,0f0h,0ffh,0c1h,0ffh	; ab72  G.....??........
	defb 0e2h,0c0h,0f1h,0e1h,0f8h,0f8h,0fch,0fch,07fh,0ffh,01fh,0ffh,00fh,0ffh,083h,0ffh	; ab82  ................
	defb 0fch,0fch,0feh,0fch,0ffh,0fch,0ffh,0feh,07fh,0ffh,01fh,0ffh,00fh,0ffh,083h,0ffh	; ab92  ................
	defb 003h,001h,007h,003h,00fh,003h,0ffh,007h,0feh,0ffh,0f8h,0ffh,0f0h,0ffh,0c1h,0ffh	; aba2  ................

; ----------------------------------------------------------------------
; DATOS tiles_ABB2: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xabb2..0xabd2  (32 bytes)
DATA_tiles_ABB2:
	defb 0e0h,07fh,0c0h,07fh,080h,0ffh,080h,0ffh,087h,0ffh,0dch,0fch,0eeh,0eeh,0c6h,0c6h	; abb2  ................
	defb 00bh,0fbh,008h,0f8h,009h,0f9h,00bh,0fbh,009h,0f9h,00ah,0fah,00ch,0fch,004h,0fch	; abc2  ................

; ----------------------------------------------------------------------
; DATOS tiles_ABD2: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xabd2..0xabf2  (32 bytes)
DATA_tiles_ABD2:
	defb 0ffh,003h,0feh,003h,0feh,003h,0fch,007h,0fch,007h,0fch,007h,0feh,007h,0feh,003h	; abd2  ................
	defb 0ffh,003h,0ffh,001h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0feh,007h,0fah,00bh	; abe2  ................

; ----------------------------------------------------------------------
; DATOS tiles_ABF2: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (16 bytes)
;   0xabf2..0xac02  (16 bytes)
DATA_tiles_ABF2:
	defb 003h,002h,007h,004h,007h,004h,007h,004h,00fh,008h,00fh,008h,00fh,008h,01fh,010h	; abf2  ................

; ----------------------------------------------------------------------
; DATOS tiles_AC02: los dibujos de 5 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (80 bytes)
;   0xac02..0xac52  (80 bytes)
DATA_tiles_AC02:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,07eh	; ac02  ...............~
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,08fh,08fh,003h,003h,001h	; ac12  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac22  ................
	defb 0fch,0ffh,0f8h,0ffh,0f0h,0ffh,0dch,0cfh,0f6h,0f3h,0fbh,0f9h,0fbh,0f9h,0fdh,0bdh	; ac32  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f9h,0f8h	; ac42  ................

; ----------------------------------------------------------------------
; DATOS tiles_AC52: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xac52..0xac72  (32 bytes)
DATA_tiles_AC52:
	defb 07fh,0ffh,0bfh,07fh,03fh,0cfh,08eh,0f1h,0e0h,0ffh,0ffh,03fh,03eh,0c1h,000h,0ffh	; ac52  ....?......?>...
	defb 0feh,0feh,0fah,0f6h,0f2h,0ceh,08fh,07fh,03fh,0ffh,0feh,0f9h,090h,06fh,003h,0ffh	; ac62  ........?....o..

; ----------------------------------------------------------------------
; DATOS tiles_AC72: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (16 bytes)
;   0xac72..0xac82  (16 bytes)
DATA_tiles_AC72:
	defb 00fh,005h,0e7h,0e0h,0ffh,0f0h,03fh,030h,00fh,001h,07fh,003h,01dh,007h,00dh,007h	; ac72  ......?0........

; ----------------------------------------------------------------------
; DATOS tiles_AC82: los dibujos de 5 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (80 bytes)
;   0xac82..0xacd2  (80 bytes)
DATA_tiles_AC82:
	defb 0feh,0b7h,03eh,02fh,03eh,02fh,07fh,03fh,07fh,03fh,0f7h,07fh,0f7h,07fh,0f6h,07fh	; ac82  ..>/>/.?.?......
	defb 0dfh,0f0h,0f3h,020h,001h,001h,007h,007h,01fh,00dh,0ffh,015h,0ffh,030h,0ffh,03fh	; ac92  ... .........0.?
	defb 0ffh,01bh,0dfh,001h,083h,080h,0e0h,0e0h,0f9h,0b0h,0ffh,0a9h,0ffh,00dh,0ffh,0fch	; aca2  ................
	defb 03fh,0ech,03eh,0f4h,07ch,0f4h,07eh,0fch,0deh,0fch,0dfh,0feh,0dfh,0feh,0efh,0feh	; acb2  ?.>.|.~.........
	defb 038h,038h,03fh,03fh,03fh,03fh,098h,01fh,0c7h,087h,0e1h,0c0h,070h,0e0h,07ch,0f0h	; acc2  88????......p.|.

; ----------------------------------------------------------------------
; DATOS tiles_ACD2: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xacd2..0xacf2  (32 bytes)
DATA_tiles_ACD2:
	defb 0e3h,0c2h,0e1h,0c1h,0e1h,0e1h,0b1h,0e0h,0b8h,0f8h,09fh,0fch,0c7h,0ffh,040h,0ffh	; acd2  ..............@.
	defb 080h,080h,0ffh,0ffh,0ffh,0ffh,0bfh,0ffh,056h,0ffh,0a9h,0ffh,0d0h,0ffh,0a0h,0ffh	; ace2  ........V.......

; ----------------------------------------------------------------------
; DATOS tiles_ACF2: los dibujos de 8 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (128 bytes)
;   0xacf2..0xad72  (128 bytes)
DATA_tiles_ACF2:
	defb 006h,0ffh,009h,0f9h,00dh,0f9h,00ch,0f8h,004h,0fch,007h,0fdh,007h,0fdh,037h,0fdh	; acf2  ..............7.
	defb 018h,0f0h,018h,0f0h,018h,0f0h,018h,0f0h,00bh,0f9h,00bh,0f9h,005h,0fch,006h,0feh	; ad02  ................
	defb 000h,000h,038h,038h,045h,045h,083h,082h,093h,092h,0b9h,081h,02ch,000h,000h,000h	; ad12  ..88EE......,...
	defb 009h,009h,08bh,089h,04bh,049h,037h,037h,0b9h,031h,098h,018h,0cch,088h,0c7h,084h	; ad22  ....KI77.1......
	defb 0cch,0cfh,0dch,0cfh,098h,08fh,0beh,09fh,0b9h,019h,0f3h,0f1h,036h,023h,01ch,017h	; ad32  ............6#..
	defb 080h,0ffh,080h,0ffh,0c0h,0ffh,0c0h,07fh,0c0h,07fh,0c0h,07fh,0c0h,0ffh,0b8h,0ffh	; ad42  ................
	defb 080h,0ffh,040h,07fh,020h,03fh,020h,03fh,010h,01fh,010h,01fh,008h,00fh,008h,00fh	; ad52  ..@. ? ?........
	defb 004h,007h,084h,087h,004h,007h,014h,017h,074h,067h,034h,027h,0e4h,0c7h,0ceh,00fh	; ad62  ........tg4'....

; ----------------------------------------------------------------------
; DATOS tiles_AD72: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xad72..0xad92  (32 bytes)
DATA_tiles_AD72:
	defb 0bbh,0fbh,0ech,0fch,0f7h,0ffh,0fch,0fbh,0ffh,0ffh,07fh,0ffh,0ffh,0ffh,0dfh,0ffh	; ad72  ................
	defb 0ddh,0dfh,037h,03fh,0efh,0ffh,03fh,0dfh,0ffh,0ffh,0feh,0ffh,0ffh,0ffh,0fbh,0ffh	; ad82  ..7?..?.........

; ----------------------------------------------------------------------
; DATOS tiles_AD92: los dibujos de 18 tiles de una entrada de la imagen A635
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); se solapan
;   2 bloques: (tiles_AEE2 AEE2-AF42); lo leen p00:56FC (432 bytes)
;   0xad92..0xaf42  (432 bytes)
DATA_tiles_AD92:
	defb 0ffh,0f0h,01fh,0ffh,0f0h,03fh,0bfh,0e0h,07fh,0bfh,0e0h,07fh,0bfh,0a0h,03fh,0bfh,0a0h,03fh,03fh,020h,03fh,03fh,020h,03fh	; ad92  .....?........?..?? ?? ?
	defb 0e6h,027h,0e3h,0ech,06fh,0e7h,0c8h,06fh,0efh,0d9h,0dfh,0cfh,093h,09bh,09fh,0b6h,0b7h,09fh,0a4h,0afh,0bfh,0a4h,0a7h,0bfh	; adaa  .'..o..o................
	defb 067h,0ech,0cfh,037h,0f6h,0e7h,01bh,0feh,0f7h,09bh,0fbh,0f3h,0c9h,0d9h,0f9h,06dh,0edh,0f9h,025h,0f5h,0fdh,025h,0e5h,0fdh	; adc2  g..7...........m..%..%..
	defb 026h,027h,03fh,023h,023h,03fh,070h,0e0h,0afh,078h,0e4h,0a7h,07ch,073h,013h,07eh,0f1h,091h,0ffh,0f8h,0f8h,00fh,0fdh,0fdh	; adda  &'?##?p..x..|s.~........
	defb 064h,0e4h,0fch,0c4h,0c4h,0fch,00ch,004h,0f4h,01eh,026h,0e4h,03eh,0ceh,0c8h,07eh,08eh,088h,0fch,01ch,010h,0ffh,0bfh,0a0h	; adf2  d.........&.>..~........
	defb 0f9h,08dh,0fdh,0f1h,099h,0f9h,0e1h,0b1h,0f1h,0e7h,0a6h,0e3h,0c7h,0e6h,0e3h,08fh,0ceh,0c3h,08fh,08eh,083h,09fh,09eh,083h	; ae0a  ........................
	defb 0f1h,01fh,0ffh,0fbh,01eh,0ffh,0f7h,01dh,0ffh,0f7h,017h,0f2h,0f7h,01fh,0f8h,0f7h,01fh,0f8h,0f7h,017h,0f0h,0fbh,00bh,0f8h	; ae22  ........................
	defb 0f1h,0ffh,0ffh,0fbh,00eh,0feh,0ffh,086h,0feh,0ffh,0ech,03ch,0feh,0fdh,01dh,0feh,0f9h,019h,0feh,0f9h,019h,0feh,0f9h,019h	; ae3a  ...........<............
	defb 0f8h,00ch,0fch,0f8h,008h,0f8h,0f9h,009h,0f8h,0f9h,009h,0f8h,0f9h,009h,0f8h,0f9h,009h,0f8h,0f8h,008h,0f8h,0fch,004h,0fch	; ae52  ........................
	defb 01fh,030h,03fh,01fh,010h,01fh,09fh,090h,01fh,09fh,090h,01fh,09fh,090h,01fh,09fh,090h,01fh,01fh,010h,01fh,03fh,020h,03fh	; ae6a  .0?..................? ?
	defb 0e6h,027h,0e3h,0ech,06fh,0e7h,0c9h,06fh,0efh,0dbh,0dfh,0cfh,097h,09eh,09eh,0bfh,0bch,09ch,0adh,0bah,0bah,0a7h,0bbh,0bbh	; ae82  .'..o..o................
	defb 067h,0ech,0cfh,037h,0f6h,0e7h,09bh,0feh,0f7h,0dbh,0fbh,0f3h,0e9h,079h,079h,0fdh,03dh,039h,0b5h,05dh,05dh,0ddh,0e5h,0e5h	; ae9a  g..7.........yy.=9.]]...
	defb 06ch,0f4h,0f4h,08ch,0f4h,0f4h,00eh,0f6h,0f4h,01eh,0e6h,0e4h,03eh,0ceh,0c8h,07eh,08eh,088h,0fch,01ch,010h,0fch,0bch,0a0h	; aeb2  l...........>..~........
	defb 026h,03fh,03fh,031h,02fh,02fh,079h,0e6h,0a6h,078h,0e7h,0a7h,07ch,073h,013h,07eh,0f1h,091h,03fh,0b8h,088h,03fh,0bdh,005h	; aeca  &??1//y..x..|s.~..?..?..
	defb 0fch,006h,0fch,0fch,00ch,0fch,0f9h,00dh,0f8h,0f9h,009h,0f8h,0fbh,00bh,0f8h,0fbh,00bh,0f8h,0f9h,009h,0f8h,0f9h,00dh,0f8h	; aee2  ........................
	defb 07fh,07fh,001h,0ffh,0feh,002h,0ffh,0feh,002h,0ffh,0feh,006h,0feh,0fdh,005h,0feh,0ffh,01fh,0f2h,0fbh,033h,0efh,0efh,021h	; aefa  ....................3..!
	defb 0fch,004h,0fch,0fch,006h,0fch,0feh,006h,0feh,0feh,007h,0feh,0fdh,005h,0fdh,0fdh,007h,0fch,0feh,002h,0feh,0feh,002h,0feh	; af12  ........................
	defb 0efh,0efh,021h,0ffh,0ffh,001h,0ffh,0ffh,001h,07eh,0ffh,003h,09eh,0dfh,087h,0fch,0ffh,0ffh,0feh,0f1h,071h,0ffh,0f8h,008h	; af2a  ..!......~..........q...

; ----------------------------------------------------------------------
; DATOS tiles_AF42: los dibujos de 16 tiles de una entrada de la imagen A635
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (384 bytes)
;   0xaf42..0xb0c2  (384 bytes)
DATA_tiles_AF42:
	defb 0ffh,0a3h,063h,0ffh,0a7h,067h,0ffh,0afh,06fh,0feh,0c4h,044h,0fch,0c0h,040h,0f8h,0c0h,0c0h,0f8h,0c0h,0c0h,0f8h,0e0h,0e0h	; af42  ..c..g..o..D..@.........
	defb 0f9h,0efh,02fh,0f9h,0efh,06fh,0e9h,0efh,07fh,0f9h,0ffh,07fh,0ffh,0f7h,07fh,0ffh,0fbh,0fch,0dfh,0dfh,0feh,0d7h,097h,0bfh	; af5a  ../..o..................
	defb 09fh,0f7h,0f4h,097h,0f3h,0fah,09fh,0fbh,0fah,09fh,0ffh,0feh,0ffh,0efh,0feh,0ffh,09fh,07eh,0ffh,0ffh,07fh,0d7h,0d3h,0fbh	; af72  .................~......
	defb 0dbh,0d9h,0fdh,0fdh,0fch,0feh,0fdh,0fch,0feh,0feh,07eh,07fh,0eeh,02eh,02fh,0e5h,0a5h,0a7h,0e5h,0e5h,0e7h,06dh,0e4h,0e6h	; af8a  ..........~.../......m..
	defb 004h,0ffh,0fch,004h,0ffh,0fch,004h,0feh,0fch,009h,0f8h,0f8h,0f0h,0f0h,0f0h,006h,006h,006h,00bh,009h,009h,009h,009h,009h	; afa2  ........................
	defb 00fh,00fh,00eh,089h,009h,009h,087h,001h,001h,08fh,007h,006h,03fh,01fh,01ch,0f3h,03fh,032h,0c3h,0ffh,0c2h,007h,0ffh,004h	; afba  ............?...?2......
	defb 0d9h,0fbh,05dh,0d0h,0f0h,0dfh,0c3h,0c3h,0ffh,08fh,08fh,0ffh,03fh,03fh,0ffh,0ffh,0fch,0fch,0ffh,0f0h,0d0h,0ffh,0f0h,090h	; afd2  ..].........??..........
	defb 0fdh,0ffh,000h,0f1h,0ffh,000h,0f1h,0ffh,001h,0fbh,0ffh,00bh,0ffh,0ffh,00fh,0fdh,0f7h,017h,0f9h,0ffh,01fh,0f9h,0efh,02fh	; afea  ......................./
	defb 0efh,0ffh,000h,08fh,0ffh,000h,08fh,0ffh,080h,0dfh,07fh,040h,07fh,07fh,0f0h,0dfh,0ffh,0f8h,09fh,0ffh,0f8h,09fh,0f7h,0f4h	; b002  ...........@............
	defb 0dfh,0d0h,0f0h,0f3h,020h,020h,001h,001h,001h,007h,006h,006h,01fh,00ch,00ch,0ffh,01fh,01fh,0f0h,03fh,03fh,068h,03fh,03fh	; b01a  ....  .............??h??
	defb 0a3h,023h,07fh,0a7h,027h,07fh,04fh,04fh,0ffh,0efh,0eeh,0feh,0f7h,0f4h,0f4h,067h,065h,0e5h,067h,067h,0e7h,0f6h,0e7h,0e7h	; b032  .#..'.OO.......ge.gg....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bfh,0bfh,0ffh,0bfh,0ffh,0bfh,0dfh,0ffh,0dfh,060h,078h,0e7h	; b04a  .....................`x.
	defb 0ffh,0ffh,0ffh,0feh,0ffh,0feh,0fch,0ffh,0fch,0feh,0ffh,0feh,0fah,0ffh,0fah,0f2h,0ffh,0f2h,047h,07fh,0c7h,0fbh,0ffh,0fbh	; b062  ..................G.....
	defb 007h,007h,0ffh,07fh,07fh,0fah,0ffh,0ffh,0e2h,0ffh,0eeh,095h,0ffh,0feh,0ddh,0ffh,069h,06fh,016h,016h,016h,0c0h,000h,000h	; b07a  ................io......
	defb 038h,0ffh,0f8h,0c0h,0ffh,0c3h,000h,0ffh,01fh,003h,0ffh,07fh,004h,0fch,0fch,018h,0fbh,0fbh,0e2h,0f4h,0f6h,00ah,024h,02eh	; b092  8.....................$.
	defb 01ch,0ffh,01fh,003h,0ffh,0c3h,000h,0ffh,0f8h,0c0h,0ffh,0feh,060h,07fh,03fh,038h,03fh,01fh,04fh,04fh,007h,021h,021h,000h	; b0aa  ............`.?8?.OO.!!.

; ----------------------------------------------------------------------
; DATOS tiles_B0C2: los dibujos de 11 tiles de una entrada de la imagen A635
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (264 bytes)
;   0xb0c2..0xb1ca  (264 bytes)
DATA_tiles_B0C2:
	defb 0ceh,04fh,0ceh,0e3h,043h,0c2h,0f3h,023h,0e2h,0f9h,011h,0f1h,0f8h,008h,0f8h,0fch,008h,0f8h,0feh,004h,0fch,0ffh,003h,0ffh	; b0c2  .O..C..#................
	defb 0ffh,07fh,07fh,06fh,07fh,063h,0ffh,07fh,07fh,07fh,07fh,07fh,0feh,0ffh,0feh,0fch,0ffh,0fch,0ffh,0bfh,0bfh,0ffh,0beh,0bfh	; b0da  ...o.c..................
	defb 0abh,0fbh,0afh,09ah,0fbh,09fh,0bah,0fbh,0bfh,0fdh,0fdh,0fdh,0cfh,04ch,0fch,0c4h,044h,0fch,0ech,028h,0f8h,0ech,028h,0f8h	; b0f2  .............L..D..(..(.
	defb 0ffh,0e0h,060h,070h,0c0h,040h,0e0h,087h,087h,0c0h,08fh,08fh,0c3h,01ch,01fh,0c7h,01bh,01fh,0c7h,01bh,01fh,0c3h,01ch,01fh	; b10a  ..`p.@..................
	defb 0ffh,01fh,019h,07fh,00fh,009h,03fh,007h,005h,01fh,087h,087h,01fh,003h,003h,09fh,003h,083h,09fh,003h,083h,01fh,003h,003h	; b122  ......?.................
	defb 0f0h,0ffh,0f0h,090h,0ffh,090h,039h,0ffh,031h,0bbh,0feh,03ah,0ffh,0fch,0fch,0fdh,03ch,0fch,0ceh,07ch,0cch,0ffh,07fh,0dfh	; b13a  ......9.1..:....<..|....
	defb 07eh,0ffh,03eh,07eh,0ffh,03eh,03ch,0ffh,01ch,09ch,0ffh,08ch,0c8h,07fh,048h,061h,03fh,021h,021h,03fh,021h,0f3h,0dfh,0d3h	; b152  ~.>~.><.......Ha?!!?!...
	defb 003h,0ffh,001h,021h,0ffh,021h,07bh,0ffh,07bh,0ffh,08fh,08fh,0ebh,083h,083h,0c3h,002h,002h,0feh,0feh,0ffh,00ch,0fch,0ffh	; b16a  ...!.!{.{...............
	defb 0abh,0fbh,0afh,09ah,0fbh,09fh,0bah,0fbh,0bfh,0feh,07fh,0ffh,0ffh,00dh,0fdh,0fch,004h,0fch,0fch,008h,0f8h,0fch,008h,0f8h	; b182  ........................
	defb 004h,0fch,0ffh,004h,0fch,0ffh,084h,0fch,0feh,005h,0fch,0fch,00ah,0f8h,0f8h,0f1h,0f0h,0f0h,001h,001h,001h,001h,001h,001h	; b19a  ........................
	defb 030h,0ffh,030h,010h,0ffh,010h,039h,0ffh,031h,0bbh,0feh,03ah,0ffh,0fch,0fch,0fdh,03ch,03ch,0ceh,07ch,04ch,0ffh,07fh,05fh	; b1b2  0.0...9.1..:....<<.|L.._

; ----------------------------------------------------------------------
; DATOS tiles_B1CA: los dibujos de 8 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (192 bytes)
;   0xb1ca..0xb28a  (192 bytes)
DATA_tiles_B1CA:
	defb 007h,00bh,00fh,007h,007h,087h,09fh,09fh,0dfh,0ffh,0ffh,0ffh,04fh,0cfh,0ffh,033h,0f3h,0ffh,078h,0f8h,0fbh,0ddh,0fch,0ddh	; b1ca  ............O..3..x.....
	defb 0c8h,0c0h,0f8h,0e8h,0e0h,0f9h,0f1h,0f1h,0ffh,0feh,0feh,0feh,0f0h,0f0h,0fch,0c7h,0c7h,0f7h,01fh,01fh,0deh,0bbh,03fh,0bbh	; b1e2  ......................?.
	defb 004h,008h,00ch,008h,000h,088h,004h,000h,044h,000h,000h,004h,00eh,00eh,03fh,0e3h,0e3h,0efh,0f8h,0f8h,07bh,0ddh,0fch,0ddh	; b1fa  ........D.....?.....{...
	defb 035h,0ffh,0fdh,082h,0ffh,082h,01ch,0ffh,09ch,063h,0ffh,0e3h,004h,0fch,08ch,018h,0fbh,0fbh,0e2h,0f4h,0f6h,08ah,064h,0eeh	; b212  5........c............d.
	defb 0ach,0ffh,0bfh,041h,0ffh,041h,038h,0ffh,038h,0c6h,0ffh,0c7h,020h,03fh,078h,018h,01fh,03fh,007h,007h,04fh,000h,000h,021h	; b22a  ...A.A8.8... ?x..?..O..!
	defb 008h,000h,038h,008h,000h,039h,010h,000h,032h,000h,000h,060h,070h,070h,0fch,0c7h,0c7h,0f7h,01fh,01fh,0deh,0bbh,03fh,0bbh	; b242  ..8..9..2..`pp........?.
	defb 06dh,02fh,0eeh,06fh,02fh,0eeh,06fh,02fh,0edh,07fh,04fh,0cfh,067h,05fh,0dfh,0f3h,0cch,0cch,0fch,0c0h,0c0h,0f8h,0e0h,0e0h	; b25a  m/.o/.o/..O.g_..........
	defb 0ffh,07fh,0c0h,07fh,03fh,0e0h,03fh,03fh,0a0h,07fh,07fh,060h,0ffh,0ffh,0c0h,0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,000h	; b272  ....?.??...`............

; ----------------------------------------------------------------------
; DATOS tiles_B28A: los dibujos de 6 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (144 bytes)
;   0xb28a..0xb31a  (144 bytes)
DATA_tiles_B28A:
	defb 0ffh,01bh,01bh,0dfh,001h,001h,0c3h,0c0h,0c0h,0f0h,070h,070h,0ffh,019h,019h,0ffh,0fdh,0fdh,08fh,0ffh,0ffh,01fh,0ech,0fch	; b28a  ..........pp............
	defb 0ffh,0d0h,0f0h,0f3h,020h,020h,003h,003h,003h,00fh,00eh,00eh,0dfh,018h,018h,0ffh,07fh,07fh,0f1h,07fh,07fh,0f8h,037h,03fh	; b2a2  ....  ................7?
	defb 00fh,0f4h,0fch,0feh,0f8h,0f8h,098h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,083h,001h,001h,041h,000h,000h	; b2ba  .....................A..
	defb 0f0h,02fh,03fh,07fh,01fh,01fh,019h,000h,000h,000h,000h,000h,040h,000h,000h,040h,000h,000h,0e1h,080h,080h,0c2h,000h,000h	; b2d2  ./?.........@..@........
	defb 007h,007h,007h,00ch,00fh,00fh,00fh,00fh,00fh,08fh,00fh,00fh,0cbh,08fh,08ch,0e4h,0c7h,0c7h,0f3h,0e3h,0e3h,0f9h,0f0h,0f0h	; b2ea  ........................
	defb 0e0h,0e0h,0e0h,030h,0f0h,0f0h,0f0h,0f0h,0f0h,0f1h,0f0h,0f0h,0d3h,0f1h,031h,027h,0e3h,0e3h,0ceh,0c7h,0c7h,09eh,00fh,00fh	; b302  ...0..........1'........

; ----------------------------------------------------------------------
; DATOS tiles_B31A: los dibujos de 3 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (72 bytes)
;   0xb31a..0xb362  (72 bytes)
DATA_tiles_B31A:
	defb 0ffh,000h,0ffh,0ffh,00fh,0ffh,0f0h,03fh,0f0h,0c0h,0ffh,0c0h,000h,0ffh,000h,000h,0ffh,040h,003h,0ffh,083h,006h,0feh,007h	; b31a  .......?.........@......
	defb 0ffh,000h,0ffh,0ffh,0f0h,0ffh,00fh,0fch,00fh,003h,0ffh,003h,000h,0ffh,000h,000h,0ffh,000h,0c0h,0ffh,0c1h,060h,07fh,0e0h	; b332  .....................`..
	defb 0f9h,0e1h,0e1h,0f6h,0e6h,0e6h,0ffh,06fh,0efh,0edh,02dh,0edh,0e4h,020h,0e0h,0e0h,0e0h,0e0h,071h,0e0h,0e0h,073h,0f1h,0f1h	; b34a  .......o..-.. ....q..s..

; ----------------------------------------------------------------------
; DATOS tiles_B362: los dibujos de 1 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (24 bytes)
;   0xb362..0xb37a  (24 bytes)
DATA_tiles_B362:
	defb 000h,007h,0f8h,000h,000h,0ffh,048h,048h,0b7h,06ch,06ch,093h,024h,024h,0dbh,0d3h,000h,02ch,00fh,000h,010h,004h,000h,00bh	; b362  ......HH.ll.$$...,......

; ----------------------------------------------------------------------
; DATOS tiles_B37A: los dibujos de 16 tiles de una entrada de la imagen A635
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (384 bytes)
;   0xb37a..0xb4fa  (384 bytes)
DATA_tiles_B37A:
	defb 0c5h,005h,007h,00dh,005h,007h,08dh,08dh,08fh,08dh,08dh,08fh,01fh,00fh,00fh,01fh,017h,01fh,03fh,039h,03fh,077h,076h,07fh	; b37a  ..................?9?wv.
	defb 0e1h,040h,040h,0f3h,041h,041h,0ffh,023h,023h,0ffh,03fh,03fh,077h,03eh,027h,06fh,07eh,047h,06fh,07ch,04fh,0efh,0fch,0cfh	; b392  .@@.AA.##.??w>'o~Go|O...
	defb 0fdh,0edh,0edh,03ch,0f4h,034h,0cfh,0ffh,01fh,0f4h,0ffh,001h,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0ffh,0feh,0feh,07fh,07eh,0feh	; b3aa  ...<.4................~.
	defb 08ch,0f8h,0f8h,078h,070h,070h,080h,080h,080h,07eh,0feh,07eh,0e1h,0ffh,005h,0ffh,0ffh,080h,0ffh,07fh,07eh,0ffh,007h,007h	; b3c2  ...xpp...~.~........~...
	defb 031h,01fh,01fh,01eh,00eh,00eh,000h,000h,000h,040h,000h,000h,0fch,0fch,0fch,08fh,0ffh,003h,0fch,0ffh,000h,0ffh,0ffh,0fch	; b3da  1........@..............
	defb 0feh,0b6h,0b7h,03eh,02eh,02fh,03eh,02eh,02fh,07fh,03fh,03fh,0ffh,03fh,03fh,0ffh,0ffh,0ffh,087h,0ffh,007h,0fah,0ffh,000h	; b3f2  ...>./>./.??.??.........
	defb 0ffh,040h,07fh,0ffh,040h,07fh,07fh,020h,0bfh,07fh,020h,0bfh,07fh,020h,0bfh,0ffh,0f0h,0ffh,0ffh,0f8h,0ffh,01fh,0fch,00fh	; b40a  .@..@.. .. .. ..........
	defb 03fh,03eh,0feh,0beh,0beh,0feh,0ffh,0ffh,0ffh,067h,067h,0ffh,083h,083h,0ffh,0f3h,0f3h,07fh,059h,0c9h,04fh,0f8h,0f8h,0ffh	; b422  ?>.......gg.......Y.O...
	defb 03ch,038h,038h,03fh,03fh,03fh,03fh,03fh,03fh,098h,018h,01fh,0c7h,087h,087h,0e1h,0c0h,0c0h,0f0h,0e0h,0e0h,0fch,0f0h,0f0h	; b43a  <88??????...............
	defb 07fh,03fh,03fh,0ffh,0fch,0fch,0fch,0fch,0fch,019h,018h,0f8h,0e3h,0e1h,0e1h,087h,003h,003h,00fh,007h,007h,03fh,00fh,00fh	; b452  .??..................?..
	defb 0ffh,0ffh,0f8h,0efh,06fh,07fh,0efh,0efh,0ffh,0cfh,0cfh,0ffh,0cfh,0cfh,0ffh,0cbh,0cbh,0ffh,097h,097h,0ffh,097h,097h,0ffh	; b46a  ....o...................
	defb 0ffh,0ffh,01fh,0e1h,0e1h,0e1h,0c0h,0c0h,0c0h,0b8h,080h,080h,0e0h,080h,080h,0c0h,080h,080h,0f8h,080h,080h,0e0h,080h,080h	; b482  ........................
	defb 0ffh,0ffh,0ffh,07fh,07fh,0ffh,01fh,01fh,0ffh,007h,007h,0ffh,040h,040h,0ffh,070h,070h,0ffh,08ch,08ch,0ffh,080h,080h,0ffh	; b49a  ............@@.pp.......
	defb 0ffh,0ffh,0ffh,0feh,0feh,0ffh,0f8h,0f8h,0ffh,0e0h,0e0h,0ffh,001h,001h,0ffh,000h,000h,0ffh,000h,000h,0ffh,001h,001h,0ffh	; b4b2  ........................
	defb 02fh,02fh,0ffh,06fh,06fh,0ffh,04fh,04fh,0ffh,09eh,09eh,0feh,01eh,01eh,0feh,036h,036h,0feh,063h,063h,0ffh,0d9h,0c1h,0e7h	; b4ca  //.oo.OO.......66.cc....
	defb 078h,008h,00fh,03eh,006h,007h,04fh,003h,003h,00fh,001h,001h,013h,001h,001h,003h,001h,001h,087h,001h,001h,0ceh,003h,002h	; b4e2  x..>..O.................

; ----------------------------------------------------------------------
; DATOS tiles_B4FA: los dibujos de 7 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (168 bytes)
;   0xb4fa..0xb5a2  (168 bytes)
DATA_tiles_B4FA:
	defb 0bdh,0bdh,0ffh,03fh,03fh,0ffh,0cfh,0cfh,0ffh,0cdh,0ddh,0efh,08dh,0bdh,0cfh,08dh,0efh,09dh,00dh,0efh,01dh,02dh,0edh,01fh	; b4fa  ...??................-..
	defb 07fh,0c0h,07fh,07fh,0c0h,07fh,07fh,0c0h,07fh,07fh,0e1h,03fh,03fh,0e3h,03eh,03eh,0f7h,01ch,09ch,0dfh,0b8h,098h,098h,0f7h	; b512  ...........??.>>........
	defb 0ffh,000h,0ffh,0ffh,00fh,0ffh,0ffh,07fh,0f0h,0f0h,0ffh,080h,080h,0ffh,000h,000h,0e0h,01fh,000h,000h,0ffh,000h,000h,0ffh	; b52a  ........................
	defb 029h,029h,0ffh,029h,029h,0ffh,00dh,00dh,0ffh,0c4h,044h,0ffh,0f4h,074h,0ffh,0feh,0feh,0ffh,07fh,0e7h,0e7h,07fh,0f1h,0f1h	; b542  )).)).....D..t..........
	defb 0cch,0cch,0ffh,0cch,0cch,0ffh,0cch,0cch,0ffh,088h,088h,0ffh,001h,001h,0ffh,03fh,03eh,0feh,0feh,0e0h,0e0h,000h,000h,000h	; b55a  ...............?>.......
	defb 0cch,0cch,0ffh,0c8h,0c8h,0ffh,083h,083h,0ffh,03fh,03fh,0ffh,0ffh,0efh,0efh,0ffh,007h,007h,03dh,007h,007h,01dh,007h,007h	; b572  .........??.......=.....
	defb 02fh,0efh,01fh,05ch,0dch,03ch,050h,0d0h,030h,020h,020h,0e0h,04ch,044h,0c4h,0d8h,0c8h,0c8h,0f3h,0f1h,0f1h,0a6h,0a2h,0a2h	; b58a  /..\.<P.0  .LD..........

; ----------------------------------------------------------------------
; DATOS tiles_B5A2: los dibujos de 7 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (112 bytes)
;   0xb5a2..0xb612  (112 bytes)
DATA_tiles_B5A2:
	defb 034h,0efh,068h,0efh,048h,0dfh,0d0h,0dfh,0d0h,0bfh,0b0h,0bfh,09fh,03fh,03fh,07fh	; b5a2  4.h.H........??.
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,0c0h,0ffh,0fch,0ffh	; b5b2  ................
	defb 003h,0fbh,003h,0ffh,001h,0ffh,00dh,0ffh,00fh,0ffh,0c7h,0ffh,03fh,0ffh,01fh,0ffh	; b5c2  ............?...
	defb 066h,0e6h,086h,086h,024h,02ch,06dh,0ffh,06dh,0ffh,069h,07fh,069h,0ffh,069h,0ffh	; b5d2  f...$,m.m.i.i.i.
	defb 01fh,01fh,001h,0c0h,088h,0fdh,0cch,0ffh,0cch,0ffh,0cch,0ffh,0cch,0ffh,0cch,0ffh	; b5e2  ................
	defb 0ffh,0ffh,0ffh,0ffh,01fh,01fh,001h,0e1h,080h,0ffh,0c8h,0ffh,0cch,0ffh,0cch,0ffh	; b5f2  ................
	defb 07ch,0feh,0feh,0feh,0feh,0feh,0feh,0feh,06eh,0feh,02eh,0b7h,0ach,0f7h,0a4h,0ffh	; b602  |.......n.......

; ----------------------------------------------------------------------
; DATOS tiles_B612: los dibujos de 20 tiles de una entrada de la imagen A635
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (480 bytes)
;   0xb612..0xb7f2  (480 bytes)
DATA_tiles_B612:
	defb 0ffh,0c0h,0ffh,0ffh,080h,0ffh,0ffh,000h,0ffh,0ffh,01eh,0ffh,0f9h,0ffh,0f7h,0feh,0ffh,0e1h,0bfh,0ffh,0fch,0efh,0ffh,01eh	; b612  ........................
	defb 0fbh,04fh,0fbh,0bbh,0efh,0fbh,0bfh,0efh,0fbh,0bfh,0e7h,0fdh,0bdh,0e7h,0ffh,0fdh,0e7h,0ffh,07dh,0c7h,0ffh,07eh,0c3h,0ffh	; b62a  .O................}..~..
	defb 0b5h,0ffh,0ffh,09fh,0ffh,0ffh,0e6h,0ffh,0dbh,0feh,07fh,0e5h,0ffh,0ffh,0feh,05fh,0ffh,0dfh,0a3h,0ffh,0c3h,0f0h,0ffh,0c0h	; b642  ..............._........
	defb 0adh,0ffh,0ffh,0f9h,0ffh,0ffh,067h,0ffh,0dbh,07fh,0feh,0a7h,0ffh,0ffh,07fh,0fah,0ffh,0fbh,0c5h,0ffh,0c3h,00fh,0ffh,003h	; b65a  ......g.................
	defb 0dfh,0f0h,0dfh,0dfh,0f0h,0dfh,0ffh,0f0h,0dfh,0ffh,0e0h,0bfh,0bfh,0e0h,0ffh,0bfh,0e0h,0ffh,0bfh,0e0h,0ffh,07fh,0e0h,0ffh	; b672  ........................
	defb 0ffh,010h,0ffh,0efh,038h,0ffh,0efh,038h,0ffh,0efh,038h,0ffh,0efh,038h,0ffh,0ffh,018h,0ffh,0ffh,01dh,0f7h,0f7h,01dh,0ffh	; b68a  ....8..8..8..8..........
	defb 07fh,0c1h,0ffh,0ffh,0c6h,0ffh,0f9h,0cfh,0ffh,0f3h,0deh,07fh,067h,0ffh,0ffh,0ffh,0ffh,0ffh,03dh,0ffh,0dfh,037h,0ffh,0f8h	; b6a2  ............g.....=..7..
	defb 0ffh,01dh,0ffh,0ffh,01fh,0ffh,0f6h,01fh,0ffh,0f3h,03fh,0ffh,0d9h,07fh,0ffh,0cfh,07fh,0fdh,0e7h,07fh,0ffh,0ffh,03fh,0f4h	; b6ba  ..........?...........?.
	defb 0fdh,007h,0ffh,0fdh,007h,0ffh,0feh,003h,0ffh,0ffh,079h,0ffh,09fh,0ffh,0efh,07fh,0ffh,087h,0fdh,0ffh,03fh,0f7h,0ffh,078h	; b6d2  ..........y.........?..x
	defb 07fh,0ffh,0ffh,0ffh,0ffh,0f7h,0ddh,0ffh,0ffh,0cfh,0ffh,0ffh,0f6h,0ffh,0ffh,05eh,0ffh,0ddh,0a3h,0ffh,0c2h,0f8h,0ffh,0c0h	; b6ea  ...............^........
	defb 0feh,0ffh,0ffh,0ffh,0ffh,0efh,0bbh,0ffh,0ffh,0f3h,0ffh,0ffh,06fh,0ffh,0ffh,07ah,0ffh,0bbh,0c5h,0ffh,043h,00fh,0ffh,003h	; b702  ............o..z....C...
	defb 0bfh,0e0h,0ffh,0bfh,0e0h,0ffh,07fh,0c0h,0ffh,0ffh,09eh,0ffh,0f9h,0ffh,0f7h,0feh,0ffh,0e1h,0bfh,0ffh,0fch,0efh,0ffh,01eh	; b71a  ........................
	defb 0efh,0ffh,040h,064h,0ffh,043h,06bh,0ffh,044h,06fh,0ffh,040h,06fh,0ffh,040h,06fh,0ffh,040h,067h,0ffh,046h,0ffh,0ffh,0cfh	; b732  ..@d.Ck.Do.@o.@o.@g.F...
	defb 052h,0ffh,002h,0aah,0ffh,002h,056h,0ffh,002h,0aah,0ffh,002h,0f6h,0ffh,002h,0feh,0ffh,002h,0feh,0ffh,062h,0ffh,0ffh,0f3h	; b74a  R.....V.............b...
	defb 0ffh,07fh,0cfh,0fbh,07fh,0dbh,0e7h,03fh,0e7h,0ffh,0ffh,0ffh,0f7h,0ffh,0f3h,077h,0ffh,070h,03bh,0ffh,070h,03bh,0ffh,038h	; b762  .......?.......w.p..p..8
	defb 0ffh,0ffh,080h,07fh,0ffh,0f0h,08fh,0ffh,0ffh,0f0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,03fh,0ffh,0ffh,007h	; b77a  ....................?...
	defb 0ffh,0ffh,001h,0feh,0ffh,00fh,0f1h,0ffh,0ffh,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0ffh,0ffh,0e0h	; b792  ........................
	defb 0ffh,0ffh,0f3h,0ffh,0feh,0f3h,0ffh,0fch,0e7h,0ffh,0fch,0c7h,0ffh,0fch,087h,0d7h,0fch,007h,0afh,0f8h,00fh,05fh,0f8h,00fh	; b7aa  ....................._..
	defb 0efh,0ffh,000h,0f3h,0ffh,003h,0f9h,0ffh,001h,0bfh,0ffh,000h,05fh,0ffh,080h,0b5h,0ffh,0c0h,0d3h,0ffh,0ech,0ffh,0ffh,0ffh	; b7c2  ............_...........
	defb 0f6h,0ffh,000h,0cdh,0ffh,0c0h,09ch,0ffh,080h,0f8h,0ffh,000h,0e3h,0ffh,000h,04fh,0ffh,001h,0ffh,0ffh,003h,0ffh,0ffh,0ffh	; b7da  ...............O........

; ----------------------------------------------------------------------
; DATOS tiles_B7F2: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (48 bytes)
;   0xb7f2..0xb822  (48 bytes)
DATA_tiles_B7F2:
	defb 070h,0ffh,0ffh,0f0h,0ffh,0ffh,0f0h,0ffh,0dfh,0d4h,0ffh,0ffh,0d5h,0ffh,07fh,05fh,0ffh,0f5h,077h,0ffh,0d7h,05fh,0f8h,0d8h	; b7f2  p.............._..w.._..
	defb 01fh,0fch,0e7h,01fh,0fch,0e7h,01fh,0feh,0e3h,00fh,0feh,0f3h,08fh,0feh,07bh,01fh,0ffh,0f9h,0cfh,0ffh,0bdh,0ffh,07fh,065h	; b80a  ..............{........e

; ----------------------------------------------------------------------
; DATOS tiles_B822: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (48 bytes)
;   0xb822..0xb852  (48 bytes)
DATA_tiles_B822:
	defb 0e0h,086h,086h,0e0h,080h,080h,0f8h,0c0h,0c0h,07fh,0e0h,060h,03fh,0f8h,038h,07fh,0ffh,067h,0ffh,0ffh,0dfh,069h,0ffh,0a9h	; b822  ...........`?.8..g...i..
	defb 03fh,007h,005h,03fh,007h,007h,0feh,00eh,00bh,0feh,01eh,017h,0fch,07ch,07fh,0f8h,0f8h,0ffh,0f0h,0f0h,0ffh,0f0h,0f0h,0ffh	; b83a  ?..?.........|..........

; ----------------------------------------------------------------------
; DATOS tiles_B852: los dibujos de 4 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (96 bytes)
;   0xb852..0xb8b2  (96 bytes)
DATA_tiles_B852:
	defb 0ffh,00bh,0fbh,0ffh,00bh,0fbh,0ffh,00bh,0fbh,0ffh,00bh,0fbh,0ffh,00fh,0fbh,0ffh,00fh,0fbh,0ffh,00fh,0fbh,0ffh,00fh,0fdh	; b852  ........................
	defb 0bbh,0ffh,0fbh,0ech,0ffh,0fch,0f7h,0ffh,0ffh,0fch,0ffh,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bfh,0bfh,0ffh,0dfh,0dfh	; b86a  ........................
	defb 0ddh,0ffh,0dfh,037h,0ffh,03fh,0efh,0ffh,0ffh,03fh,0ffh,0dfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fdh,0fdh,0ffh,0fbh,0fbh	; b882  ...7.?...?..............
	defb 0ffh,0d0h,0dfh,0ffh,0d0h,0dfh,0ffh,0d0h,0dfh,0ffh,0d0h,0dfh,0ffh,0f0h,0dfh,0ffh,0f0h,0dfh,0ffh,0f0h,0dfh,0ffh,0f0h,0bfh	; b89a  ........................

; ----------------------------------------------------------------------
; DATOS tiles_B8B2: los dibujos de 3 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (72 bytes)
;   0xb8b2..0xb8fa  (72 bytes)
DATA_tiles_B8B2:
	defb 0ffh,00eh,0fch,0ffh,00ch,0f8h,0feh,01ch,0f9h,0feh,018h,0f1h,0fch,018h,0f3h,0fch,038h,0f3h,0fch,030h,0e3h,0f8h,030h,0e7h	; b8b2  ................8..0..0.
	defb 081h,001h,07fh,002h,003h,0feh,002h,003h,0feh,004h,007h,0fdh,044h,047h,0fdh,048h,04fh,0fbh,0c8h,0cfh,0fbh,0c8h,0cfh,0fbh	; b8ca  ............DG.HO.......
	defb 087h,080h,0f8h,043h,0c0h,07ch,041h,0c0h,07eh,020h,0e0h,0bfh,022h,0e2h,0bfh,012h,0f2h,09fh,013h,0f3h,0dfh,013h,0f3h,0dfh	; b8e2  ...C.|A.~ .."...........

; ----------------------------------------------------------------------
; DATOS tiles_B8FA: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (48 bytes)
;   0xb8fa..0xb92a  (48 bytes)
DATA_tiles_B8FA:
	defb 0a4h,0a4h,0a4h,059h,058h,0d8h,07bh,0f9h,039h,0f6h,0f6h,076h,0ceh,0cah,0fah,08bh,0e9h,099h,005h,0c4h,03ch,006h,006h,0feh	; b8fa  ...YX.{.9..v........<...
	defb 03fh,0f0h,07fh,01fh,0f0h,03fh,01fh,0f8h,03fh,00fh,078h,09fh,00fh,038h,0dfh,00fh,03ch,0dfh,00fh,01ch,0e7h,00fh,01ch,0e7h	; b912  ?....?..?.x..8..<.......

; ----------------------------------------------------------------------
; DATOS tiles_B92A: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:56FC (48 bytes)
;   0xb92a..0xb95a  (48 bytes)
DATA_tiles_B92A:
	defb 0f8h,030h,0e7h,0e8h,030h,0f7h,0f9h,021h,0e7h,0f9h,031h,0e7h,0f9h,031h,0f7h,0fdh,031h,0f3h,0f9h,019h,0f7h,0fdh,019h,0fbh	; b92a  .0..0..!..1..1..1.......
	defb 090h,09fh,0f3h,090h,09fh,0f3h,090h,09fh,0f3h,090h,09fh,0f3h,090h,09fh,0f3h,090h,09fh,0f1h,090h,09fh,0f1h,088h,08fh,0f8h	; b942  ........................

; ----------------------------------------------------------------------
; DATOS tiles_B95A: los dibujos de 2 tiles de una entrada de la imagen A635 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:56FC (32 bytes)
;   0xb95a..0xb97a  (32 bytes)
DATA_tiles_B95A:
	defb 003h,0feh,001h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,001h,0ffh	; b95a  ................
	defb 003h,0ffh,003h,0ffh,002h,0feh,003h,0ffh,003h,0ffh,003h,0ffh,003h,0ffh,003h,0feh	; b96a  ................

; ----------------------------------------------------------------------
; DATOS rle_B97A: datos a la VRAM en RLE (p00:4E2D): 0 acaba, n < 0x80 repite
;   el byte de detras, 0x80 y una direccion nueva, 0x81-0xFF copian n & 0x7F
;   bytes; lo leen p00:5705 (228 bytes)
;   0xb97a..0xba5e  (228 bytes)
DATA_rle_B97A:
	defb 009h,000h,002h,060h,00dh,000h,002h,018h,006h,000h,08bh,01ch,02ah,04ah,051h,091h	; b97a  ...`........*JQ.
	defb 091h,082h,082h,042h,024h,018h,016h,000h,089h,014h,034h,02eh,06eh,06eh,07ch,07ch	; b98a  ...B$.....4.nn||
	defb 03ch,018h,01bh,000h,089h,034h,007h,043h,025h,08fh,015h,00fh,064h,008h,008h,000h	; b99a  <....4.C%...d...
	defb 086h,080h,0f0h,0f8h,0f0h,0f0h,080h,004h,000h,096h,0a8h,077h,03fh,05fh,0bfh,0ffh	; b9aa  ...........w?_..
	defb 037h,05fh,02fh,08fh,007h,05fh,01fh,04fh,03fh,0b4h,000h,020h,090h,0fdh,0fch,0feh	; b9ba  7_/.._.O?.. ....
	defb 006h,0ffh,084h,0fch,0fah,084h,020h,004h,000h,089h,00fh,03fh,07ch,078h,078h,038h	; b9ca  ...... ....?|xx8
	defb 038h,01ch,003h,007h,000h,08bh,080h,0e0h,030h,018h,018h,01ch,01ch,03eh,0feh,0fch	; b9da  8.......0....>..
	defb 070h,007h,000h,081h,003h,004h,007h,081h,003h,00ah,000h,081h,0c0h,004h,0e0h,081h	; b9ea  p...............
	defb 0c0h,007h,000h,083h,00fh,030h,040h,003h,080h,002h,040h,085h,020h,01ch,013h,008h	; b9fa  .....0@...@. ...
	defb 08eh,003h,000h,08dh,080h,060h,010h,008h,004h,004h,002h,002h,001h,001h,002h,08ch	; ba0a  .....`..........
	defb 070h,00bh,000h,002h,001h,006h,000h,088h,010h,030h,030h,060h,060h,0c0h,0c0h,080h	; ba1a  p........00``...
	defb 00dh,000h,003h,001h,002h,002h,002h,005h,08eh,086h,000h,000h,010h,028h,048h,048h	; ba2a  .............(HH
	defb 090h,090h,020h,020h,040h,080h,080h,007h,000h,082h,00eh,01fh,003h,03fh,002h,01fh	; ba3a  ..  @........?..
	defb 084h,00fh,007h,003h,001h,005h,000h,082h,038h,0fch,004h,0feh,086h,0fch,0f8h,0f0h	; ba4a  ........8.......
	defb 0e0h,0c0h,080h,000h	; ba5a

; ----------------------------------------------------------------------
; DATOS rle_BA5E: datos a la VRAM en RLE (p00:4E2D): 0 acaba, n < 0x80 repite
;   el byte de detras, 0x80 y una direccion nueva, 0x81-0xFF copian n & 0x7F
;   bytes; lo leen p00:57FB (1186 bytes)
;   0xba5e..0xbf00  (1186 bytes)
DATA_rle_BA5E:
	defb 009h,000h,002h,060h,00dh,000h,002h,018h,006h,000h,08bh,01ch,02ah,04ah,051h,091h	; ba5e  ...`........*JQ.
	defb 091h,082h,082h,042h,024h,018h,016h,000h,089h,014h,034h,02eh,06eh,06eh,07ch,07ch	; ba6e  ...B$.....4.nn||
	defb 03ch,018h,01bh,000h,089h,034h,007h,043h,025h,08fh,015h,00fh,064h,008h,008h,000h	; ba7e  <....4.C%...d...
	defb 086h,080h,0f0h,0f8h,0f0h,0f0h,080h,004h,000h,0a0h,0a8h,077h,03fh,05fh,0bfh,0ffh	; ba8e  ...........w?_..
	defb 036h,05fh,02fh,08fh,006h,05fh,01fh,04fh,03fh,0b4h,000h,040h,0b0h,0fdh,07ch,0dfh	; ba9e  6_/.._.O?..@..|.
	defb 0abh,0c5h,0a0h,0c5h,0afh,0ffh,0fch,0fah,084h,020h,004h,000h,089h,00fh,03fh,07ch	; baae  ......... ....?|
	defb 078h,078h,038h,038h,01ch,003h,007h,000h,08bh,080h,0e0h,030h,018h,018h,01ch,01ch	; babe  xx88.......0....
	defb 03eh,0feh,0fch,070h,007h,000h,081h,003h,004h,007h,081h,003h,00ah,000h,081h,0c0h	; bace  >..p............
	defb 004h,0e0h,081h,0c0h,007h,000h,083h,00fh,030h,040h,003h,080h,002h,040h,085h,020h	; bade  ........0@...@.
	defb 01ch,013h,008h,08eh,003h,000h,08dh,080h,060h,010h,008h,004h,004h,002h,002h,001h	; baee  ........`.......
	defb 001h,002h,08ch,070h,00bh,000h,002h,001h,006h,000h,088h,010h,030h,030h,060h,060h	; bafe  ...p........00``
	defb 0c0h,0c0h,080h,00dh,000h,003h,001h,002h,002h,002h,005h,08eh,086h,000h,000h,010h	; bb0e  ................
	defb 028h,048h,048h,090h,090h,020h,020h,040h,080h,080h,004h,000h,08ch,003h,006h,01eh	; bb1e  (HH..  @........
	defb 013h,047h,04ch,061h,033h,033h,019h,01eh,00ch,006h,000h,088h,0c0h,080h,080h,0f8h	; bb2e  .GLa33..........
	defb 0e0h,020h,0e0h,0c0h,00bh,000h,002h,001h,00dh,000h,003h,0c0h,00eh,000h,081h,001h	; bb3e  . ..............
	defb 003h,000h,081h,001h,009h,000h,087h,080h,020h,054h,03ah,05fh,03ah,050h,00bh,000h	; bb4e  ........ T:_:P..
	defb 087h,00fh,03fh,078h,070h,078h,03fh,00fh,009h,000h,087h,080h,0e0h,0f0h,070h,0f0h	; bb5e  ..?xpx?.......p.
	defb 0e0h,080h,007h,000h,089h,00fh,03fh,07ch,0f0h,0f0h,0fch,07fh,03fh,00fh,007h,000h	; bb6e  ......?|....?...
	defb 089h,0f0h,0fch,03eh,00fh,00fh,03fh,0feh,0fch,0f0h,007h,000h,083h,004h,000h,040h	; bb7e  ...>..?........@
	defb 003h,080h,083h,040h,030h,007h,007h,000h,083h,020h,000h,002h,003h,001h,083h,002h	; bb8e  ...@0.... ......
	defb 00ch,0e0h,007h,000h,08bh,018h,024h,034h,014h,01ah,00ah,00ch,018h,010h,010h,008h	; bb9e  ......$4........
	defb 011h,000h,002h,010h,08bh,030h,018h,018h,004h,014h,014h,028h,028h,030h,030h,010h	; bbae  .....0.....((00.
	defb 003h,008h,012h,000h,084h,018h,026h,041h,040h,004h,080h,002h,040h,082h,020h,011h	; bbbe  ......&A@...@. .
	defb 004h,000h,084h,038h,044h,084h,042h,003h,022h,084h,042h,044h,078h,080h,007h,000h	; bbce  ...8D.B.".BDx...
	defb 08ah,008h,002h,000h,040h,061h,070h,020h,030h,018h,00eh,006h,000h,087h,040h,030h	; bbde  ....@ap 0.....@0
	defb 098h,010h,080h,0a0h,0a0h,008h,000h,08ah,018h,036h,03dh,07fh,03fh,01eh,00fh,01fh	; bbee  .........6=.?...
	defb 00fh,007h,006h,000h,002h,038h,087h,08ch,044h,0cch,05ch,01ch,018h,080h,006h,000h	; bbfe  .....8..D.\.....
	defb 084h,036h,03eh,01ch,008h,01bh,000h,086h,036h,049h,041h,022h,014h,008h,025h,000h	; bc0e  .6>.....6IA"..%.
	defb 084h,004h,007h,00fh,00fh,00eh,000h,08ah,0c0h,000h,00eh,00fh,007h,007h,00fh,00eh	; bc1e  ................
	defb 00eh,007h,003h,000h,084h,003h,00fh,00eh,008h,003h,000h,002h,080h,01ah,000h,081h	; bc2e  ................
	defb 003h,00dh,000h,088h,020h,0e0h,0f0h,0f0h,000h,000h,001h,001h,00ch,000h,08bh,070h	; bc3e  .... ..........p
	defb 0f0h,0e0h,0e0h,0f0h,070h,070h,0e0h,0e0h,0f0h,070h,003h,038h,081h,010h,004h,000h	; bc4e  ....pp...p.8....
	defb 002h,018h,002h,000h,002h,006h,003h,000h,002h,030h,00ch,000h,002h,006h,004h,000h	; bc5e  .........0......
	defb 002h,0c0h,003h,000h,002h,001h,002h,000h,002h,0c0h,006h,000h,002h,006h,002h,000h	; bc6e  ................
	defb 002h,080h,002h,003h,002h,000h,002h,060h,004h,000h,081h,033h,003h,07fh,083h,03fh	; bc7e  .......`...3...?
	defb 01eh,00ch,00ah,000h,003h,080h,00bh,000h,082h,033h,04ch,003h,080h,084h,040h,021h	; bc8e  .........3L...@!
	defb 012h,00ch,008h,000h,081h,080h,003h,040h,081h,080h,00ah,000h,089h,040h,021h,000h	; bc9e  .......@.....@!.
	defb 000h,080h,000h,000h,021h,040h,007h,000h,081h,080h,003h,000h,081h,040h,003h,000h	; bcae  ....!@.......@..
	defb 081h,080h,013h,000h,081h,004h,003h,00fh,00eh,000h,08ah,0e0h,080h,00fh,007h,007h	; bcbe  ................
	defb 003h,003h,007h,00fh,00eh,003h,000h,083h,002h,00eh,00ch,005h,000h,003h,080h,018h	; bcce  ................
	defb 000h,082h,007h,001h,00ch,000h,084h,020h,0f0h,0f0h,0e0h,003h,000h,003h,001h,003h	; bcde  ....... ........
	defb 000h,002h,001h,005h,000h,08fh,0f0h,0e0h,0e0h,0c0h,0c0h,0e0h,0f0h,070h,0f0h,0e0h	; bcee  .............p..
	defb 0e0h,0f0h,078h,018h,010h,00dh,000h,084h,004h,00fh,00fh,007h,00eh,000h,002h,0c0h	; bcfe  ..x.............
	defb 091h,007h,00fh,00eh,00eh,007h,007h,003h,007h,008h,000h,000h,002h,00fh,006h,00ch	; bd0e  ................
	defb 004h,080h,004h,000h,003h,080h,016h,000h,002h,003h,00ch,000h,086h,030h,0f0h,0f0h	; bd1e  .............0..
	defb 0e0h,001h,001h,003h,000h,003h,001h,008h,000h,09eh,0e0h,0f0h,0f0h,070h,0e0h,0e0h	; bd2e  .............p..
	defb 0c0h,0e0h,0f0h,078h,038h,070h,070h,038h,010h,000h,003h,004h,019h,021h,06ch,0b8h	; bd3e  ...x8pp8.....!l.
	defb 0b3h,09eh,0dch,04ch,026h,021h,012h,00ch,003h,000h,08bh,080h,0c0h,020h,040h,078h	; bd4e  ...L&!....... @x
	defb 004h,018h,0d0h,010h,020h,0c0h,004h,000h,08ah,010h,000h,010h,008h,008h,018h,028h	; bd5e  .... ..........(
	defb 028h,010h,010h,018h,000h,002h,001h,081h,01fh,005h,03fh,082h,03eh,01ch,004h,000h	; bd6e  (.........?.>...
	defb 082h,003h,0e7h,004h,0ffh,083h,0fch,0e0h,080h,008h,000h,088h,0b0h,0f8h,0f8h,0feh	; bd7e  ................
	defb 0ffh,01fh,007h,001h,00eh,000h,002h,080h,00eh,000h,002h,001h,008h,000h,088h,00dh	; bd8e  ................
	defb 01fh,01fh,07fh,0ffh,0f8h,0e0h,080h,007h,000h,082h,0c0h,0e7h,004h,0ffh,083h,03fh	; bd9e  ...............?
	defb 007h,001h,009h,000h,002h,080h,081h,0f8h,005h,0fch,082h,07ch,038h,005h,000h,085h	; bdae  ...........|8...
	defb 001h,003h,003h,007h,01fh,004h,03fh,082h,03eh,01ch,004h,000h,083h,006h,08fh,0dfh	; bdbe  ......?.>.......
	defb 003h,0ffh,083h,0fch,0e0h,080h,007h,000h,089h,020h,070h,0f0h,0fch,0feh,0feh,01fh	; bdce  ......... p.....
	defb 007h,001h,00eh,000h,002h,080h,00eh,000h,002h,001h,007h,000h,089h,004h,00eh,00fh	; bdde  ................
	defb 03fh,07fh,07fh,0f8h,0e0h,080h,007h,000h,083h,060h,0f1h,0fbh,003h,0ffh,083h,03fh	; bdee  ?........`.....?
	defb 007h,001h,008h,000h,085h,080h,0c0h,0c0h,0e0h,0f8h,004h,0fch,082h,07ch,038h,006h	; bdfe  .............|8.
	defb 000h,081h,003h,003h,007h,081h,03fh,003h,07fh,083h,03fh,03eh,01ch,004h,000h,082h	; be0e  ......?...?>....
	defb 01ch,0beh,004h,0ffh,083h,0f8h,0e0h,080h,007h,000h,088h,060h,0f0h,0f4h,0feh,0feh	; be1e  ...........`....
	defb 0ffh,00fh,001h,00eh,000h,002h,080h,00eh,000h,002h,001h,008h,000h,088h,006h,00fh	; be2e  ................
	defb 02fh,07fh,07fh,0ffh,0f0h,080h,008h,000h,082h,038h,07dh,004h,0ffh,083h,01fh,007h	; be3e  /........8}.....
	defb 001h,008h,000h,081h,0c0h,003h,0e0h,081h,0fch,003h,0feh,083h,0fch,07ch,038h,007h	; be4e  .............|8.
	defb 000h,081h,00eh,004h,01fh,003h,03fh,082h,03eh,01ch,004h,000h,083h,030h,079h,07fh	; be5e  ......?.>....0y.
	defb 003h,0ffh,083h,0feh,0f0h,0c0h,007h,000h,087h,0c0h,0e0h,0ech,0feh,0ffh,0ffh,003h	; be6e  ................
	defb 00eh,000h,002h,080h,02eh,000h,002h,001h,009h,000h,087h,003h,007h,037h,07fh,0ffh	; be7e  .............7..
	defb 0ffh,0c0h,009h,000h,083h,00ch,09eh,0feh,003h,0ffh,083h,07fh,00fh,003h,009h,000h	; be8e  ................
	defb 081h,070h,004h,0f8h,003h,0fch,08bh,07ch,038h,000h,000h,09eh,09fh,03fh,00fh,03fh	; be9e  .p.....|8....?.?
	defb 07fh,001h,00ah,000h,088h,0c0h,0f0h,0f8h,0fch,0feh,0feh,01fh,003h,008h,000h,088h	; beae  ................
	defb 003h,00fh,01fh,03fh,07fh,07fh,0f8h,0c0h,007h,000h,087h,079h,0f9h,0fch,0f0h,0fch	; bebe  ...?.......y....
	defb 0feh,080h,010h,000h,082h,010h,020h,005h,000h,081h,001h,006h,000h,081h,010h,004h	; bece  ...... .........
	defb 008h,084h,010h,020h,040h,080h,005h,000h,085h,001h,002h,004h,008h,008h,003h,010h	; bede  ... @...........
	defb 081h,00ch,006h,000h,081h,080h,00dh,000h,002h,020h,084h,0f8h,070h,070h,088h,01ah	; beee  ......... ..pp..
	defb 000h,000h	; befe

; ----------------------------------------------------------------------
; DATOS resto_BF00: lo apuntan con el banco puesto p02:90AA (0xBF00), p02:90E1
;   (0xBF00), p02:90EE (0xBF00), p02:9100 (0xBF00), p02:9149 (0xBF48); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:90AA, p02:90E1, p02:90EE, p02:9100, p02:9149 (242 bytes)
;   0xbf00..0xbff2  (242 bytes)
DATA_resto_BF00:
	defb 004h,0bfh,026h,0bfh,006h,020h,000h,000h,001h,001h,002h,002h,003h,003h,00ah,009h	; bf00  ..&.. ..........
	defb 008h,00bh,00ah,009h,008h,00ch,00ah,009h,008h,00dh,00ah,009h,008h,00eh,00ah,009h	; bf10  ................
	defb 008h,00fh,00ah,009h,008h,010h,006h,020h,004h,004h,005h,005h,006h,006h,007h,007h	; bf20  ....... ........
	defb 00ah,009h,008h,00eh,00ah,009h,008h,00fh,00ah,009h,008h,010h,00ah,009h,008h,00bh	; bf30  ................
	defb 00ah,009h,008h,00ch,00ah,009h,008h,00dh,06ah,0bfh,072h,0bfh,07ah,0bfh,082h,0bfh	; bf40  ........j.r.z...
	defb 08ah,0bfh,092h,0bfh,09ah,0bfh,0a2h,0bfh,0aah,0bfh,0b2h,0bfh,0bah,0bfh,0c2h,0bfh	; bf50  ................
	defb 0cah,0bfh,0d2h,0bfh,0dah,0bfh,0e2h,0bfh,0eah,0bfh,024h,000h,004h,008h,00fh,004h	; bf60  ..........$.....
	defb 007h,00eh,028h,00ch,010h,000h,00fh,004h,007h,000h,02ch,014h,018h,000h,00fh,004h	; bf70  ..(.......,.....
	defb 007h,000h,030h,01ch,020h,000h,00fh,004h,007h,000h,034h,000h,004h,008h,009h,004h	; bf80  ..0. .....4.....
	defb 007h,00eh,038h,03ch,00ch,010h,009h,00fh,004h,007h,040h,044h,014h,018h,009h,00fh	; bf90  ..8<......@D....
	defb 004h,007h,048h,04ch,01ch,020h,009h,00fh,004h,007h,050h,054h,058h,05ch,004h,007h	; bfa0  ..HL. ....PTX\..
	defb 00eh,00fh,060h,064h,068h,06ch,004h,007h,00eh,00fh,070h,074h,078h,07ch,004h,007h	; bfb0  ..`dhl....ptx|..
	defb 00eh,00fh,080h,084h,088h,08ch,004h,007h,009h,00eh,090h,094h,098h,09ch,004h,007h	; bfc0  ................
	defb 00eh,00fh,0a0h,0a4h,0a8h,0ach,004h,007h,00eh,00fh,0b0h,0b4h,0b8h,0bch,004h,007h	; bfd0  ................
	defb 00eh,00fh,0c0h,0c4h,0c8h,0cch,004h,007h,00eh,00fh,0d0h,0d4h,0d8h,0dch,004h,007h	; bfe0  ................
	defb 00eh,00fh	; bff0

; ----------------------------------------------------------------------
; DATOS relleno_ff: 14 bytes a 0xFF hasta el final del banco: relleno; lo leen
;   nadie (14 bytes)
;   0xbff2..0xc000  (14 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff2  ..............
