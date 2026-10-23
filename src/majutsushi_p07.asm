; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 07 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS dibujos_6000: los dibujos de la mesa (p00:5A2E): 20 tiles de 1 bit por
;   punto; se solapan 2 bloques: (dibujos_6008 6008-6058); lo leen p00:5A2E,
;   p00:5A5F (160 bytes)
;   0x6000..0x60a0  (160 bytes)
DATA_dibujos_6000:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 6000  ........
	defb 000h,01ch,022h,063h,063h,063h,022h,01ch	; 6008  .."ccc".
	defb 000h,018h,038h,018h,018h,018h,018h,07eh	; 6010  ..8....~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh	; 6018  .>c..<p.
	defb 000h,03eh,063h,003h,00eh,003h,063h,03eh	; 6020  .>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h	; 6028  ...6ff..
	defb 000h,07fh,060h,07eh,063h,003h,063h,03eh	; 6030  ..`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh	; 6038  .>c`~cc>
	defb 000h,07fh,063h,006h,00ch,018h,018h,018h	; 6040  ..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh	; 6048  .>cc>cc>
	defb 000h,03eh,063h,063h,03fh,003h,063h,03eh	; 6050  .>cc?.c>
	defb 000h,01ch,036h,063h,063h,07fh,063h,063h	; 6058  ..6cc.cc
	defb 000h,07eh,063h,063h,07eh,063h,063h,07eh	; 6060  .~cc~cc~
	defb 000h,03eh,063h,060h,060h,060h,063h,03eh	; 6068  .>c```c>
	defb 000h,07ch,066h,063h,063h,063h,066h,07ch	; 6070  .|fcccf|
	defb 000h,07fh,060h,060h,07eh,060h,060h,07fh	; 6078  ..``~``.
	defb 000h,07fh,060h,060h,07eh,060h,060h,060h	; 6080  ..``~```
	defb 000h,03eh,063h,060h,067h,063h,063h,03fh	; 6088  .>c`gcc?
	defb 000h,063h,063h,063h,07fh,063h,063h,063h	; 6090  .ccc.ccc
	defb 000h,03ch,018h,018h,018h,018h,018h,03ch	; 6098  .<.....<

; ----------------------------------------------------------------------
; DATOS dibujos_60A0: los dibujos de la mesa (p00:5A3A): 20 tiles de 1 bit por
;   punto; se solapan 3 bloques: (dibujos_6130 6130-6138) (dibujos_6138
;   6138-6388); lo leen p00:5A3A, p00:5A53, p00:5A6B (744 bytes)
;   0x60a0..0x6388  (744 bytes)
DATA_dibujos_60A0:
	defb 000h,01fh,006h,006h,006h,006h,066h,03ch	; 60a0  ......f<
	defb 000h,063h,066h,06ch,078h,07ch,06eh,067h	; 60a8  .cflx|ng
	defb 000h,060h,060h,060h,060h,060h,060h,07fh	; 60b0  .``````.
	defb 000h,063h,077h,07fh,07fh,06bh,063h,063h	; 60b8  .cw..kcc
	defb 000h,063h,073h,07bh,07fh,06fh,067h,063h	; 60c0  .cs{.ogc
	defb 000h,03eh,063h,063h,063h,063h,063h,03eh	; 60c8  .>ccccc>
	defb 000h,07eh,063h,063h,063h,07eh,060h,060h	; 60d0  .~ccc~``
	defb 000h,03eh,063h,063h,063h,06fh,066h,03dh	; 60d8  .>cccof=
	defb 000h,07eh,063h,063h,062h,07ch,066h,063h	; 60e0  .~ccb|fc
	defb 000h,03eh,063h,060h,03eh,003h,063h,03eh	; 60e8  .>c`>.c>
	defb 000h,07eh,018h,018h,018h,018h,018h,018h	; 60f0  .~......
	defb 000h,063h,063h,063h,063h,063h,063h,03eh	; 60f8  .cccccc>
	defb 000h,063h,063h,063h,063h,036h,01ch,008h	; 6100  .cccc6..
	defb 000h,063h,063h,06bh,06bh,07fh,077h,022h	; 6108  .cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h	; 6110  .cv<..7c
	defb 000h,066h,066h,07eh,03ch,018h,018h,018h	; 6118  .ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh	; 6120  .....8p.
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch	; 6128  <B....B<
	defb 000h,000h,000h,000h,07eh,000h,000h,000h	; 6130  ....~...
	defb 001h,001h,03fh,001h,019h,031h,061h,001h	; 6138  ..?..1a.
	defb 086h,089h,0feh,080h,098h,08ch,086h,080h	; 6140  ........
	defb 000h,01eh,003h,000h,000h,000h,001h,00fh	; 6148  ........
	defb 000h,000h,006h,006h,00ch,038h,0e0h,000h	; 6150  .....8..
	defb 000h,01fh,001h,03fh,001h,001h,007h,01ch	; 6158  ...?....
	defb 078h,0c0h,080h,0fch,080h,080h,000h,000h	; 6160  x.......
	defb 000h,000h,000h,000h,03fh,000h,000h,000h	; 6168  ....?...
	defb 000h,000h,000h,000h,0feh,000h,000h,000h	; 6170  ........
	defb 001h,001h,03fh,003h,003h,003h,006h,01ch	; 6178  ..?.....
	defb 080h,080h,0fch,00ch,00ch,00ch,00ch,038h	; 6180  .......8
	defb 000h,01fh,018h,018h,018h,018h,01fh,018h	; 6188  ........
	defb 000h,0fch,00ch,00ch,00ch,00ch,0fch,00ch	; 6190  ........
	defb 000h,018h,018h,018h,018h,000h,000h,007h	; 6198  ........
	defb 000h,018h,018h,018h,018h,030h,0e0h,080h	; 61a0  .....0..
	defb 000h,033h,019h,019h,000h,000h,000h,007h	; 61a8  .3......
	defb 000h,00ch,08ch,08ch,00ch,018h,070h,0c0h	; 61b0  ......p.
	defb 000h,03fh,006h,006h,07fh,006h,006h,003h	; 61b8  .?......
	defb 000h,0f8h,000h,000h,0fch,000h,000h,0f8h	; 61c0  ........
	defb 003h,003h,006h,01dh,000h,000h,000h,00fh	; 61c8  ........
	defb 000h,0fch,00ch,0cch,078h,03ch,0e0h,080h	; 61d0  ....x<..
	defb 000h,000h,07fh,000h,003h,01eh,070h,000h	; 61d8  ......p.
	defb 060h,060h,0feh,0e0h,0e0h,060h,060h,0e0h	; 61e0  ``...``.
	defb 000h,00ch,00ch,00ch,018h,030h,060h,000h	; 61e8  .....0`.
	defb 006h,069h,03eh,018h,00ch,006h,006h,000h	; 61f0  .i>.....
	defb 000h,000h,000h,001h,007h,01ch,000h,000h	; 61f8  ........
	defb 00eh,01ch,070h,0e0h,060h,060h,060h,060h	; 6200  ..p.````
	defb 000h,000h,03fh,000h,000h,000h,000h,00fh	; 6208  ..?.....
	defb 006h,009h,0feh,018h,018h,030h,0e0h,080h	; 6210  .....0..
	defb 003h,003h,006h,01ch,000h,000h,000h,00fh	; 6218  ........
	defb 000h,0fch,00ch,00ch,018h,030h,0e0h,080h	; 6220  .....0..
	defb 000h,01fh,000h,000h,001h,007h,01ch,070h	; 6228  .......p
	defb 01bh,0fbh,030h,060h,0c0h,060h,038h,00ch	; 6230  ..0`.`8.
	defb 000h,00fh,000h,000h,000h,003h,00eh,038h	; 6238  .......8
	defb 000h,0f8h,018h,030h,0e0h,0b0h,01ch,006h	; 6240  ...0....
	defb 000h,01fh,000h,000h,000h,000h,000h,01fh	; 6248  ........
	defb 000h,0f8h,018h,018h,018h,018h,018h,0f8h	; 6250  ........
	defb 000h,03fh,000h,001h,001h,001h,003h,00eh	; 6258  .?......
	defb 000h,0fch,00ch,098h,0f0h,080h,000h,000h	; 6260  ........
	defb 000h,01ch,006h,000h,01eh,000h,000h,01fh	; 6268  ........
	defb 000h,000h,00ch,00ch,00ch,018h,070h,0c0h	; 6270  ......p.
	defb 000h,01fh,000h,000h,000h,000h,000h,01fh	; 6278  ........
	defb 036h,0f8h,018h,018h,018h,018h,018h,0f8h	; 6280  6.......
	defb 000h,00fh,019h,030h,060h,000h,000h,000h	; 6288  ...0`...
	defb 018h,024h,098h,0c0h,060h,030h,018h,00ch	; 6290  .$..`0..
	defb 001h,001h,01fh,001h,03fh,000h,000h,000h	; 6298  ....?...
	defb 0b6h,09bh,0fch,080h,0feh,0c0h,0c0h,0c0h	; 62a0  ........
	defb 000h,01fh,000h,000h,000h,000h,001h,007h	; 62a8  ........
	defb 000h,0fch,00ch,00ch,018h,070h,0c0h,000h	; 62b0  .....p..
	defb 000h,03fh,000h,07fh,001h,001h,007h,01ch	; 62b8  .?......
	defb 036h,0f6h,000h,0f8h,080h,080h,000h,000h	; 62c0  6.......
	defb 000h,000h,000h,000h,001h,007h,01ch,000h	; 62c8  ........
	defb 000h,000h,030h,060h,0c0h,0c0h,0c0h,0c0h	; 62d0  ..0`....
	defb 000h,01fh,000h,03fh,000h,000h,003h,00eh	; 62d8  ...?....
	defb 000h,0f8h,000h,0fch,0c0h,0c0h,080h,000h	; 62e0  ........
	defb 000h,000h,03fh,000h,000h,000h,003h,00eh	; 62e8  ..?.....
	defb 0c0h,0c0h,0feh,0c0h,0c0h,0c0h,080h,000h	; 62f0  ........
	defb 000h,000h,01bh,01bh,009h,000h,000h,007h	; 62f8  ........
	defb 000h,000h,018h,018h,018h,030h,0e0h,080h	; 6300  .....0..
	defb 000h,000h,006h,007h,03eh,003h,003h,003h	; 6308  ....>...
	defb 000h,000h,000h,0f8h,018h,030h,060h,000h	; 6310  .....0`.
	defb 000h,01fh,001h,001h,001h,001h,001h,03fh	; 6318  .......?
	defb 000h,0f8h,080h,080h,080h,080h,080h,0fch	; 6320  ........
	defb 001h,001h,03fh,030h,030h,000h,000h,007h	; 6328  ..?00...
	defb 09bh,09bh,0fch,00ch,00ch,018h,070h,0c0h	; 6330  ......p.
	defb 000h,000h,000h,00fh,001h,001h,001h,00fh	; 6338  ........
	defb 000h,000h,000h,0f0h,080h,080h,080h,0f0h	; 6340  ........
	defb 000h,000h,000h,000h,000h,000h,001h,01fh	; 6348  ........
	defb 000h,030h,030h,030h,030h,060h,0c0h,000h	; 6350  .0000`..
	defb 000h,001h,001h,003h,006h,00ch,018h,03fh	; 6358  .......?
	defb 000h,080h,080h,000h,018h,00ch,006h,0feh	; 6360  ........
	defb 001h,07fh,003h,007h,00dh,039h,067h,001h	; 6368  .....9g.
	defb 080h,0ffh,0e0h,0b0h,098h,08eh,0f3h,080h	; 6370  ........
	defb 000h,018h,03eh,01bh,018h,03dh,033h,000h	; 6378  ..>..=3.
	defb 0feh,0feh,0feh,0ffh,0feh,0ffh,0d9h,037h	; 6380  .......7

; ----------------------------------------------------------------------
; DATOS paleta_6388: una paleta de 8 colores que se copia a 0xE800 (p00:5A6E);
;   lo leen p00:5A6E (8 bytes)
;   0x6388..0x6390  (8 bytes)
DATA_paleta_6388:
	defb 000h,004h,007h,009h,00eh,00fh,000h,000h	; 6388  ........

; ----------------------------------------------------------------------
; DATOS paleta_6390: una paleta de 8 colores que se copia a 0xE800 (p00:5A8C);
;   lo leen p00:5A8C (8 bytes)
;   0x6390..0x6398  (8 bytes)
DATA_paleta_6390:
	defb 000h,004h,007h,00eh,00fh,000h,000h,000h	; 6390  ........

; ----------------------------------------------------------------------
; DATOS dibujos_6398: los dibujos de la mesa (p00:5A86): 8 tiles de 3 bits por
;   punto; lo leen p00:5A86 (192 bytes)
;   0x6398..0x6458  (192 bytes)
DATA_dibujos_6398:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0feh,0fch,0feh,0fdh,0fbh,0ffh,0f8h,0f7h,0ffh,0f0h	; 6398  ........................
	defb 0ffh,0ffh,0ffh,0c3h,0ffh,0c3h,081h,0c7h,0b9h,003h,08dh,071h,007h,019h,0e1h,00fh,033h,0c3h,01fh,067h,087h,0bfh,0cfh,00fh	; 63b0  ...........q....3..g....
	defb 0e3h,0f3h,0ech,0c0h,0e3h,0dch,081h,0c6h,0b8h,003h,08ch,070h,007h,099h,061h,08fh,073h,003h,0ffh,087h,087h,0ffh,0ffh,0ffh	; 63c8  ...........p..a.s.......
	defb 07fh,09fh,01fh,0ffh,03fh,03fh,0ffh,07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 63e0  ....??..................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0feh,0fch,0feh,0fdh,0fbh,0fch,0fbh,0f0h,0f8h,0f7h	; 63f8  ........................
	defb 0ffh,0ffh,0ffh,0c3h,0ffh,0c3h,081h,0c7h,0b9h,003h,08dh,071h,0c7h,019h,0e1h,03fh,003h,0f3h,01fh,067h,087h,0ffh,00fh,0cfh	; 6410  ...........q...?...g....
	defb 0ech,0f1h,0eeh,0c3h,0e0h,0dfh,0b1h,0c6h,0b8h,00fh,080h,07ch,007h,099h,061h,08fh,073h,003h,0ffh,087h,087h,0ffh,0ffh,0ffh	; 6428  ...........|..a.s.......
	defb 07fh,09fh,01fh,0ffh,03fh,03fh,0ffh,07fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6440  ....??..................

; ----------------------------------------------------------------------
; DATOS dibujos_6458: los dibujos de la mesa (p00:5AA3): 8 tiles de 3 bits por
;   punto; lo leen p00:5AA3 (192 bytes)
;   0x6458..0x6518  (192 bytes)
DATA_dibujos_6458:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0ffh,0cfh,0cfh,0f0h,098h,09fh,0e0h,0b3h,0bch,0c0h,0a6h,0b8h,0c1h	; 6458  ........................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,0ffh,0ffh,0ffh,000h,000h,0ffh,000h,0ffh,000h,000h,000h,000h,0ffh	; 6470  ........................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,007h,007h,0ffh,0e3h,0f3h,00fh,009h,0f1h,007h,085h,079h,003h,045h,039h,083h	; 6488  ...................y.E9.
	defb 0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h	; 64a0  ........................
	defb 0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h,0a5h,0b9h,0c3h	; 64b8  ........................
	defb 0a2h,0bch,0c1h,0a0h,0bfh,0c0h,080h,09fh,0e0h,0cfh,0c0h,0f0h,0e0h,0e0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 64d0  ........................
	defb 000h,000h,0ffh,0ffh,0ffh,000h,000h,0ffh,000h,0ffh,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 64e8  ........................
	defb 065h,079h,083h,0cdh,0f1h,003h,019h,0e1h,007h,0f3h,003h,00fh,007h,007h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6500  ey......................

; ----------------------------------------------------------------------
; DATOS paletas_6518: las 30 palabras que apuntan a las paletas de la imagen
;   65E8 (p00:5911: palabra A de la tabla); lo leen p00:5694 (60 bytes)
;   0x6518..0x6554  (60 bytes)
DATA_paletas_6518:
	defw 06554h,06556h,06558h,0655ch,06560h,06564h,06568h,0656ch	; 6518
	defw 06570h,06574h,06578h,0657ch,06580h,06584h,06588h,0658ch	; 6528
	defw 06590h,06594h,06598h,0659ch,065a0h,065a4h,065a8h,065b0h	; 6538
	defw 065b8h,065c0h,065c8h,065d0h,065d8h,065e0h	; 6548

; ----------------------------------------------------------------------
; DATOS paleta_6554: la paleta 0 de la imagen 65E8: 2 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (2 bytes)
;   0x6554..0x6556  (2 bytes)
DATA_paleta_6554:
	defb 00bh,00fh	; 6554

; ----------------------------------------------------------------------
; DATOS paleta_6556: la paleta 1 de la imagen 65E8: 2 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (2 bytes)
;   0x6556..0x6558  (2 bytes)
DATA_paleta_6556:
	defb 006h,00eh	; 6556

; ----------------------------------------------------------------------
; DATOS paleta_6558: la paleta 2 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6558..0x655c  (4 bytes)
DATA_paleta_6558:
	defb 002h,00bh,00ch,00fh	; 6558

; ----------------------------------------------------------------------
; DATOS paleta_655C: la paleta 3 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x655c..0x6560  (4 bytes)
DATA_paleta_655C:
	defb 001h,002h,00eh,00fh	; 655c

; ----------------------------------------------------------------------
; DATOS paleta_6560: la paleta 4 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6560..0x6564  (4 bytes)
DATA_paleta_6560:
	defb 001h,002h,00ch,00fh	; 6560

; ----------------------------------------------------------------------
; DATOS paleta_6564: la paleta 5 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6564..0x6568  (4 bytes)
DATA_paleta_6564:
	defb 001h,002h,00bh,00fh	; 6564

; ----------------------------------------------------------------------
; DATOS paleta_6568: la paleta 6 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6568..0x656c  (4 bytes)
DATA_paleta_6568:
	defb 009h,00bh,00eh,00fh	; 6568

; ----------------------------------------------------------------------
; DATOS paleta_656C: la paleta 7 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x656c..0x6570  (4 bytes)
DATA_paleta_656C:
	defb 005h,009h,00ah,00fh	; 656c

; ----------------------------------------------------------------------
; DATOS paleta_6570: la paleta 8 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6570..0x6574  (4 bytes)
DATA_paleta_6570:
	defb 00bh,00dh,00eh,00fh	; 6570

; ----------------------------------------------------------------------
; DATOS paleta_6574: la paleta 9 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6574..0x6578  (4 bytes)
DATA_paleta_6574:
	defb 003h,006h,00bh,00fh	; 6574

; ----------------------------------------------------------------------
; DATOS paleta_6578: la paleta 10 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6578..0x657c  (4 bytes)
DATA_paleta_6578:
	defb 003h,006h,00eh,00fh	; 6578

; ----------------------------------------------------------------------
; DATOS paleta_657C: la paleta 11 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x657c..0x6580  (4 bytes)
DATA_paleta_657C:
	defb 006h,00bh,00eh,00fh	; 657c

; ----------------------------------------------------------------------
; DATOS paleta_6580: la paleta 12 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6580..0x6584  (4 bytes)
DATA_paleta_6580:
	defb 009h,00bh,00ch,00fh	; 6580

; ----------------------------------------------------------------------
; DATOS paleta_6584: la paleta 13 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6584..0x6588  (4 bytes)
DATA_paleta_6584:
	defb 005h,00ah,00bh,00fh	; 6584

; ----------------------------------------------------------------------
; DATOS paleta_6588: la paleta 14 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6588..0x658c  (4 bytes)
DATA_paleta_6588:
	defb 004h,006h,00eh,00fh	; 6588

; ----------------------------------------------------------------------
; DATOS paleta_658C: la paleta 15 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x658c..0x6590  (4 bytes)
DATA_paleta_658C:
	defb 006h,008h,00eh,00fh	; 658c

; ----------------------------------------------------------------------
; DATOS paleta_6590: la paleta 16 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6590..0x6594  (4 bytes)
DATA_paleta_6590:
	defb 006h,008h,00eh,00fh	; 6590

; ----------------------------------------------------------------------
; DATOS paleta_6594: la paleta 17 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6594..0x6598  (4 bytes)
DATA_paleta_6594:
	defb 004h,00bh,00eh,00fh	; 6594

; ----------------------------------------------------------------------
; DATOS paleta_6598: la paleta 18 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x6598..0x659c  (4 bytes)
DATA_paleta_6598:
	defb 003h,00bh,00dh,00fh	; 6598

; ----------------------------------------------------------------------
; DATOS paleta_659C: la paleta 19 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x659c..0x65a0  (4 bytes)
DATA_paleta_659C:
	defb 004h,007h,008h,00fh	; 659c

; ----------------------------------------------------------------------
; DATOS paleta_65A0: la paleta 20 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x65a0..0x65a4  (4 bytes)
DATA_paleta_65A0:
	defb 001h,002h,008h,00fh	; 65a0

; ----------------------------------------------------------------------
; DATOS paleta_65A4: la paleta 21 de la imagen 65E8: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (4 bytes)
;   0x65a4..0x65a8  (4 bytes)
DATA_paleta_65A4:
	defb 004h,008h,00bh,00fh	; 65a4

; ----------------------------------------------------------------------
; DATOS paleta_65A8: la paleta 22 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65a8..0x65b0  (8 bytes)
DATA_paleta_65A8:
	defb 001h,002h,006h,00ah,00bh,00ch,00eh,00fh	; 65a8  ........

; ----------------------------------------------------------------------
; DATOS paleta_65B0: la paleta 23 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65b0..0x65b8  (8 bytes)
DATA_paleta_65B0:
	defb 001h,002h,009h,00bh,00dh,00ch,00eh,00fh	; 65b0  ........

; ----------------------------------------------------------------------
; DATOS paleta_65B8: la paleta 24 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65b8..0x65c0  (8 bytes)
DATA_paleta_65B8:
	defb 001h,002h,003h,006h,009h,00bh,00eh,00fh	; 65b8  ........

; ----------------------------------------------------------------------
; DATOS paleta_65C0: la paleta 25 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65c0..0x65c8  (8 bytes)
DATA_paleta_65C0:
	defb 001h,002h,004h,006h,007h,008h,00eh,00fh	; 65c0  ........

; ----------------------------------------------------------------------
; DATOS paleta_65C8: la paleta 26 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65c8..0x65d0  (8 bytes)
DATA_paleta_65C8:
	defb 001h,002h,006h,008h,00bh,00dh,00eh,00fh	; 65c8  ........

; ----------------------------------------------------------------------
; DATOS paleta_65D0: la paleta 27 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65d0..0x65d8  (8 bytes)
DATA_paleta_65D0:
	defb 003h,004h,001h,008h,00bh,007h,00eh,00fh	; 65d0  ........

; ----------------------------------------------------------------------
; DATOS paleta_65D8: la paleta 28 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65d8..0x65e0  (8 bytes)
DATA_paleta_65D8:
	defb 001h,002h,004h,008h,00bh,00ch,00eh,00fh	; 65d8  ........

; ----------------------------------------------------------------------
; DATOS paleta_65E0: la paleta 29 de la imagen 65E8: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:5694 (8 bytes)
;   0x65e0..0x65e8  (8 bytes)
DATA_paleta_65E0:
	defb 005h,009h,00ah,00bh,00eh,00fh,001h,00ch	; 65e0  ........

; ----------------------------------------------------------------------
; DATOS imagen_65E8: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:5694 (247 bytes)
;   0x65e8..0x66df  (247 bytes)
DATA_imagen_65E8:
	defb 000h,000h,001h,011h,0dfh,066h	; 65e8
	defb 001h,000h,012h,003h,04fh,067h	; 65ee
	defb 000h,001h,015h,001h,067h,067h	; 65f4
	defb 002h,002h,016h,007h,06fh,067h	; 65fa
	defb 002h,003h,01dh,007h,0dfh,067h	; 6600
	defb 002h,004h,024h,007h,04fh,068h	; 6606
	defb 002h,005h,02bh,002h,0bfh,068h	; 660c
	defb 002h,006h,02dh,002h,0dfh,068h	; 6612
	defb 002h,007h,02fh,004h,0ffh,068h	; 6618
	defb 003h,007h,033h,002h,01fh,069h	; 661e
	defb 002h,008h,035h,002h,03fh,069h	; 6624
	defb 002h,009h,037h,012h,05fh,069h	; 662a
	defb 002h,00ah,049h,00ch,07fh,06ah	; 6630
	defb 002h,00bh,055h,008h,03fh,06bh	; 6636
	defb 003h,00bh,05dh,003h,08fh,06bh	; 663c
	defb 002h,00ch,060h,00bh,0bfh,06bh	; 6642
	defb 003h,00ch,06bh,003h,03fh,06ch	; 6648
	defb 002h,00dh,06eh,007h,06fh,06ch	; 664e
	defb 003h,00dh,075h,002h,0bfh,06ch	; 6654
	defb 002h,00eh,077h,001h,0dfh,06ch	; 665a
	defb 003h,00eh,078h,001h,0dfh,06ch	; 6660
	defb 002h,00fh,079h,005h,0efh,06ch	; 6666
	defb 003h,00fh,07eh,001h,02fh,06dh	; 666c
	defb 002h,010h,07fh,002h,03fh,06dh	; 6672
	defb 002h,011h,081h,001h,05fh,06dh	; 6678
	defb 003h,011h,082h,001h,05fh,06dh	; 667e
	defb 002h,012h,083h,001h,06fh,06dh	; 6684
	defb 002h,013h,084h,006h,07fh,06dh	; 668a
	defb 002h,014h,08ah,001h,0dfh,06dh	; 6690
	defb 002h,015h,08bh,003h,0efh,06dh	; 6696
	defb 004h,016h,08eh,00bh,01fh,06eh	; 669c
	defb 004h,017h,099h,015h,027h,06fh	; 66a2
	defb 004h,018h,0aeh,017h,01fh,071h	; 66a8
	defb 005h,018h,0c5h,002h,017h,073h	; 66ae
	defb 004h,019h,0c7h,004h,047h,073h	; 66b4
	defb 004h,01ah,0cbh,00ch,0a7h,073h	; 66ba
	defb 004h,01bh,0d7h,015h,0c7h,074h	; 66c0
	defb 005h,01bh,0ech,001h,0a7h,076h	; 66c6
	defb 004h,01ch,0edh,007h,0bfh,076h	; 66cc
	defb 004h,01dh,0f4h,009h,067h,077h	; 66d2
	defb 005h,01dh,0fdh,002h,00fh,078h	; 66d8
	defb 0ffh	; 66de

; ----------------------------------------------------------------------
; DATOS tiles_66DF: los dibujos de 17 tiles de una entrada de la imagen 65E8
;   de p00:5911: 8 por tile, tiles de 1 bits por punto (p00:5949); se solapan
;   2 bloques: (tiles_674F 674F-6767); lo leen p00:5694 (136 bytes)
;   0x66df..0x6767  (136 bytes)
DATA_tiles_66DF:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 66df  ........
	defb 000h,000h,080h,080h,080h,080h,080h,000h	; 66e7  ........
	defb 000h,000h,000h,000h,000h,001h,001h,003h	; 66ef  ........
	defb 080h,080h,000h,000h,000h,000h,000h,080h	; 66f7  ........
	defb 000h,000h,000h,000h,000h,001h,001h,001h	; 66ff  ........
	defb 000h,000h,000h,000h,000h,000h,000h,033h	; 6707  .......3
	defb 080h,080h,080h,000h,000h,000h,000h,000h	; 670f  ........
	defb 000h,000h,000h,080h,080h,080h,080h,080h	; 6717  ........
	defb 080h,000h,000h,000h,000h,000h,000h,080h	; 671f  ........
	defb 080h,080h,080h,080h,080h,080h,080h,080h	; 6727  ........
	defb 000h,000h,000h,000h,000h,000h,001h,001h	; 672f  ........
	defb 001h,001h,001h,001h,001h,001h,001h,000h	; 6737  ........
	defb 001h,001h,001h,001h,001h,000h,000h,000h	; 673f  ........
	defb 080h,080h,080h,080h,080h,080h,080h,000h	; 6747  ........
	defb 001h,001h,001h,001h,001h,001h,001h,001h	; 674f  ........
	defb 000h,000h,001h,001h,001h,001h,001h,001h	; 6757  ........
	defb 001h,001h,000h,000h,000h,000h,000h,000h	; 675f  ........

; ----------------------------------------------------------------------
; DATOS tiles_6767: los dibujos de 1 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 8 por tile, tiles de 1 bits por punto (p00:5949); lo leen
;   p00:5694 (8 bytes)
;   0x6767..0x676f  (8 bytes)
DATA_tiles_6767:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6767  ........

; ----------------------------------------------------------------------
; DATOS tiles_676F: los dibujos de 7 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (112 bytes)
;   0x676f..0x67df  (112 bytes)
DATA_tiles_676F:
	defb 0ffh,000h,0ffh,000h,0ffh,003h,0fch,004h,0f8h,009h,0f1h,013h,0f3h,017h,0e6h,027h	; 676f  ...............'
	defb 0ffh,03eh,0c1h,0c3h,000h,03fh,006h,0ffh,00bh,0ffh,001h,0ffh,000h,0ffh,000h,0ffh	; 677f  .>...?..........
	defb 0ffh,07ch,083h,0c3h,000h,0fch,060h,0ffh,0d0h,0ffh,081h,0ffh,000h,0ffh,000h,0feh	; 678f  .|....`.........
	defb 0ffh,000h,0ffh,000h,0ffh,0c0h,03fh,020h,01fh,090h,08fh,0c8h,0cfh,0e8h,0e7h,0e4h	; 679f  ......? ........
	defb 0ffh,001h,0ffh,003h,0feh,002h,0feh,002h,0feh,007h,0fdh,005h,0fdh,007h,0ffh,003h	; 67af  ................
	defb 0ffh,080h,0ffh,080h,0ffh,0c0h,07fh,040h,07fh,040h,07fh,040h,0ffh,0c0h,0ffh,080h	; 67bf  .......@.@.@....
	defb 07fh,040h,07fh,040h,03fh,0a0h,03fh,0a0h,03fh,0a0h,03fh,0e0h,07fh,0e0h,07fh,0c0h	; 67cf  .@.@?.?.?.?.....

; ----------------------------------------------------------------------
; DATOS tiles_67DF: los dibujos de 7 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (112 bytes)
;   0x67df..0x684f  (112 bytes)
DATA_tiles_67DF:
	defb 09ch,078h,048h,000h,000h,000h,000h,000h,000h,000h,000h,000h,083h,001h,001h,000h	; 67df  .xH.............
	defb 039h,01eh,01ah,000h,000h,000h,000h,000h,040h,000h,040h,000h,0e1h,080h,0c0h,000h	; 67ef  9.......@.@.....
	defb 000h,000h,000h,000h,0f0h,0e0h,019h,010h,0c3h,001h,087h,003h,00eh,007h,03eh,00fh	; 67ff  ..............>.
	defb 0e0h,0e0h,0a0h,0e0h,080h,0c0h,080h,0c0h,000h,080h,080h,000h,000h,000h,000h,000h	; 680f  ................
	defb 000h,000h,000h,000h,010h,010h,01fh,00fh,00fh,000h,006h,006h,000h,000h,0c0h,000h	; 681f  ................
	defb 005h,005h,083h,083h,082h,083h,080h,081h,081h,000h,080h,000h,080h,000h,000h,000h	; 682f  ................
	defb 080h,000h,0c0h,080h,000h,000h,083h,082h,07eh,07ch,080h,000h,070h,060h,060h,000h	; 683f  ........~|..p``.

; ----------------------------------------------------------------------
; DATOS tiles_684F: los dibujos de 7 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (112 bytes)
;   0x684f..0x68bf  (112 bytes)
DATA_tiles_684F:
	defb 0a3h,07fh,0a7h,07fh,04fh,0ffh,0efh,0feh,0f7h,0f4h,067h,0e4h,067h,0e5h,0f7h,0e5h	; 684f  ....O.....g.g...
	defb 0dbh,0fdh,0fdh,0feh,0fdh,0feh,0feh,07fh,0eeh,02fh,0e5h,027h,0e5h,0a7h,0edh,0a6h	; 685f  ........./.'....
	defb 0feh,0b7h,03eh,02fh,03eh,02fh,07fh,03fh,07fh,03fh,0f7h,07fh,0f7h,07fh,0f6h,07fh	; 686f  ..>/>/.?.?......
	defb 000h,000h,000h,000h,00fh,007h,098h,008h,0c3h,080h,0e1h,0c0h,0f0h,0e0h,0fch,0f0h	; 687f  ................
	defb 000h,000h,038h,038h,044h,044h,083h,083h,091h,091h,038h,000h,02ch,000h,080h,080h	; 688f  ..88DD....8.,...
	defb 000h,000h,001h,001h,001h,000h,000h,000h,0c1h,0c1h,0e3h,0c3h,046h,007h,01fh,01fh	; 689f  ............F...
	defb 0f3h,0ffh,0ech,0fch,093h,0f2h,079h,0f1h,0cch,0c8h,0e7h,0c4h,033h,0e3h,07eh,0f3h	; 68af  ......y.....3.~.

; ----------------------------------------------------------------------
; DATOS tiles_68BF: los dibujos de 2 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (32 bytes)
;   0x68bf..0x68df  (32 bytes)
DATA_tiles_68BF:
	defb 05eh,0ceh,05ch,0cch,05ch,0c4h,05ch,0c4h,04eh,0c4h,04fh,0c6h,02fh,0e2h,027h,0e3h	; 68bf  ^.\.\.\.N.O./.'.
	defb 07eh,073h,03ah,033h,03ah,023h,032h,023h,032h,023h,072h,043h,074h,047h,0e4h,087h	; 68cf  ~s:3:#2#2#rCtG..

; ----------------------------------------------------------------------
; DATOS tiles_68DF: los dibujos de 2 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (32 bytes)
;   0x68df..0x68ff  (32 bytes)
DATA_tiles_68DF:
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,080h,0ffh,080h,0ffh,080h,07fh,0c0h,07fh,040h	; 68df  ...............@
	defb 07fh,0c0h,0ffh,040h,0ffh,040h,07fh,040h,07fh,040h,0ffh,0c0h,0ffh,080h,0ffh,000h	; 68ef  ...@.@.@.@......

; ----------------------------------------------------------------------
; DATOS tiles_68FF: los dibujos de 4 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); se solapan 2
;   bloques: (tiles_691F 691F-693F); lo leen p00:5694 (64 bytes)
;   0x68ff..0x693f  (64 bytes)
DATA_tiles_68FF:
	defb 006h,0efh,003h,0c7h,031h,0f3h,04ch,0cch,003h,043h,000h,008h,003h,087h,000h,0c3h	; 68ff  ....1.L..C......
	defb 060h,0f3h,0c0h,0e3h,08ch,0cfh,032h,033h,0c0h,0c2h,000h,010h,0c0h,0e1h,000h,0c3h	; 690f  `.....23........
	defb 0c0h,0e9h,0e0h,0f8h,0f8h,0fch,0ffh,0ffh,0ffh,07fh,0ffh,01fh,0ffh,00fh,0ffh,083h	; 691f  ................
	defb 000h,003h,000h,0e0h,000h,010h,000h,00ah,000h,00eh,0e0h,0efh,0f2h,0bfh,0ffh,06fh	; 692f  ...............o

; ----------------------------------------------------------------------
; DATOS tiles_693F: los dibujos de 2 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (32 bytes)
;   0x693f..0x695f  (32 bytes)
DATA_tiles_693F:
	defb 007h,005h,007h,005h,006h,004h,00eh,008h,00ch,008h,01ch,010h,01eh,010h,01ch,010h	; 693f  ................
	defb 01eh,010h,01dh,011h,00ah,00ah,004h,005h,005h,007h,00bh,00fh,00bh,00fh,00bh,00fh	; 694f  ................

; ----------------------------------------------------------------------
; DATOS tiles_695F: los dibujos de 18 tiles de una entrada de la imagen 65E8
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (288 bytes)
;   0x695f..0x6a7f  (288 bytes)
DATA_tiles_695F:
	defb 000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,003h,0feh,006h,0fch,018h,0f8h,023h,0e3h	; 695f  ..............#.
	defb 003h,0ffh,03ch,0fch,0f0h,0c0h,0c1h,001h,03fh,03fh,03fh,03fh,07fh,07fh,0ffh,0ffh	; 696f  ..<.....????....
	defb 09ch,0ffh,063h,063h,011h,001h,0c0h,0c0h,0f6h,0f6h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 697f  ..cc............
	defb 000h,0ffh,000h,0ffh,0e0h,0ffh,0b0h,01fh,018h,00fh,01ch,007h,08ch,087h,086h,083h	; 698f  ................
	defb 047h,0c7h,067h,0c7h,08fh,08fh,09fh,09fh,0bfh,0bfh,0bfh,03fh,07fh,07fh,079h,078h	; 699f  G.g........?..yx
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,07eh	; 69af  ...............~
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,08fh,08fh,003h,003h,001h	; 69bf  ................
	defb 002h,003h,0c5h,0c1h,0e7h,0e1h,0e3h,0e1h,0f1h,0f1h,0f4h,0f0h,0f3h,0f1h,0f9h,0f9h	; 69cf  ................
	defb 002h,0feh,003h,0feh,003h,0feh,001h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 69df  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0e7h,0e7h,0c7h,0dfh,0dfh,0fdh,0f1h,0f7h,0e7h,0efh,0efh	; 69ef  ................
	defb 0fdh,0fdh,0eeh,0efh,0f6h,0f7h,0f4h,0f7h,0fch,0ffh,0c0h,0ffh,0a0h,0bfh,0a0h,0bfh	; 69ff  ................
	defb 0a0h,0bfh,0a0h,0bfh,0a0h,0bfh,060h,03fh,0a0h,03fh,0c0h,0ffh,080h,0ffh,080h,0ffh	; 6a0f  ......`?.?......
	defb 000h,0ffh,000h,0ffh,001h,0ffh,003h,0feh,007h,0fch,006h,0fch,00eh,0f8h,00dh,0f8h	; 6a1f  ................
	defb 000h,0ffh,000h,0ffh,080h,0ffh,0c0h,07fh,060h,03fh,060h,03fh,030h,01fh,030h,01fh	; 6a2f  ........`?`?0.0.
	defb 018h,00fh,018h,00fh,00ch,007h,00ch,007h,004h,007h,006h,003h,066h,003h,0f6h,0c3h	; 6a3f  ............f...
	defb 0afh,003h,056h,003h,0ach,007h,054h,007h,0ach,007h,054h,007h,0a8h,00fh,058h,00fh	; 6a4f  ..V...T...T...X.
	defb 0b8h,01fh,078h,03fh,0e8h,06fh,0c8h,04fh,0c8h,0cfh,0f0h,0ffh,0f0h,0ffh,0e0h,0ffh	; 6a5f  ..x?.o.O........
	defb 036h,0e6h,038h,0f0h,018h,0f8h,00fh,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 6a6f  6.8.............

; ----------------------------------------------------------------------
; DATOS tiles_6A7F: los dibujos de 12 tiles de una entrada de la imagen 65E8
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (192 bytes)
;   0x6a7f..0x6b3f  (192 bytes)
DATA_tiles_6A7F:
	defb 0ffh,0ffh,0ffh,0ffh,0feh,0feh,0ffh,0feh,0ffh,0fch,0e7h,0e4h,007h,000h,006h,001h	; 6a7f  ................
	defb 0ffh,0ffh,0ffh,0ffh,07fh,07fh,0ffh,07fh,07fh,03fh,0a7h,027h,050h,010h,030h,010h	; 6a8f  .........?.'P.0.
	defb 0efh,040h,064h,043h,06bh,044h,06fh,040h,06fh,040h,06fh,040h,067h,040h,0efh,0c0h	; 6a9f  .@dCkDo@o@o@g@..
	defb 0c6h,001h,06eh,081h,0adh,043h,0efh,007h,0ffh,00fh,0efh,00fh,0ebh,003h,0d6h,000h	; 6aaf  ..n..C..........
	defb 050h,010h,028h,008h,098h,088h,0e8h,0e8h,0f0h,0f0h,0f1h,0f0h,0c2h,0c0h,001h,000h	; 6abf  P.(.............
	defb 052h,002h,0aah,002h,056h,002h,0aah,002h,0c6h,032h,0e6h,012h,0eeh,002h,057h,003h	; 6acf  R...V....2....W.
	defb 0ffh,0c7h,0bfh,0bfh,0fch,0ffh,0f7h,078h,0dfh,0e3h,0f4h,084h,0e0h,000h,0f4h,000h	; 6adf  .......x........
	defb 0f8h,0e0h,0fdh,0f8h,0feh,03ch,0ffh,00eh,0ffh,0c3h,02fh,021h,007h,000h,02dh,000h	; 6aef  .....<..../!..-.
	defb 0eah,000h,0f5h,000h,0feh,000h,0bfh,000h,05fh,080h,0b5h,0c0h,0d3h,0ech,0ffh,0ffh	; 6aff  ........_.......
	defb 056h,000h,0adh,000h,07ch,000h,0f8h,000h,0e3h,000h,04fh,001h,0ffh,003h,0ffh,0ffh	; 6b0f  V...|.....O.....
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,03fh,000h,0fbh,004h,0ffh,0ffh,0ffh,0ffh	; 6b1f  ........?.......
	defb 0fah,000h,0f4h,000h,0e0h,000h,080h,000h,090h,000h,02eh,0c0h,0ffh,0ffh,0ffh,0ffh	; 6b2f  ................

; ----------------------------------------------------------------------
; DATOS tiles_6B3F: los dibujos de 8 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); se solapan 2
;   bloques: (tiles_6B8F 6B8F-6BBF); lo leen p00:5694 (128 bytes)
;   0x6b3f..0x6bbf  (128 bytes)
DATA_tiles_6B3F:
	defb 007h,0e4h,007h,0e4h,003h,0e2h,003h,0f2h,00bh,07ah,019h,0b9h,00dh,0bdh,005h,085h	; 6b3f  .........z......
	defb 0ffh,000h,0ffh,01fh,0ffh,07fh,0c7h,0c7h,003h,03bh,002h,0feh,003h,0ffh,003h,0ffh	; 6b4f  ................
	defb 0ffh,000h,0ffh,0f8h,0ffh,0feh,013h,093h,0f0h,0f0h,0d0h,0dah,030h,03bh,0f0h,0fbh	; 6b5f  ............0...
	defb 002h,0feh,00eh,0feh,01bh,0fbh,033h,0f7h,023h,0efh,043h,0dfh,043h,0dfh,041h,0ebh	; 6b6f  ......3.#.C.C.A.
	defb 070h,0ffh,0e0h,0efh,0c0h,0dfh,080h,0bfh,000h,07fh,000h,0ffh,068h,0ffh,068h,0ffh	; 6b7f  p...........h.h.
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,003h,0fch,004h,0f8h,009h,0f0h,013h	; 6b8f  ................
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0feh,007h,0fch,00fh,0f8h,00eh	; 6b9f  ................
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,078h,08fh,0efh,007h,087h,03dh,03fh,070h,078h	; 6baf  .......x....=?px

; ----------------------------------------------------------------------
; DATOS tiles_6BBF: los dibujos de 11 tiles de una entrada de la imagen 65E8
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); se solapan
;   2 bloques: (tiles_6C3F 6C3F-6C6F); lo leen p00:5694 (176 bytes)
;   0x6bbf..0x6c6f  (176 bytes)
DATA_tiles_6BBF:
	defb 0ffh,0ffh,02fh,06fh,017h,037h,00bh,03bh,009h,01dh,004h,01eh,004h,01fh,004h,03fh	; 6bbf  ../o.7.........?
	defb 0ffh,000h,0ffh,007h,0ffh,038h,0f8h,0c0h,0c0h,000h,000h,000h,0c0h,0c0h,020h,0e3h	; 6bcf  .....8........ .
	defb 0c0h,040h,0e0h,020h,0e0h,020h,0f0h,039h,0edh,04fh,0e7h,047h,0d0h,053h,0d1h,093h	; 6bdf  .@. . .9.O.G.S..
	defb 020h,0f7h,023h,0ffh,047h,0fch,0ach,0f8h,0f9h,0f1h,0f9h,0e9h,0f9h,0d9h,0d9h,099h	; 6bef   .#.G...........
	defb 0dbh,0bfh,0dfh,09eh,08eh,0bbh,08ah,0bbh,09ah,0b3h,092h,0f7h,093h,0ffh,097h,0ffh	; 6bff  ................
	defb 048h,07ch,0e8h,0beh,09ch,09fh,0cch,0efh,0e6h,07fh,0ffh,03fh,0ffh,01fh,0ffh,07fh	; 6c0f  H|.........?....
	defb 0e3h,0f1h,0f0h,0feh,0e8h,0efh,0f4h,0f7h,0fah,0fbh,079h,0fdh,079h,0fdh,072h,0ffh	; 6c1f  ..........y.y.r.
	defb 0ffh,080h,0ffh,040h,07fh,020h,03fh,090h,01fh,090h,01fh,0c8h,00fh,0c8h,00fh,0f8h	; 6c2f  ...@. ?.........
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0feh,002h,0fch,004h	; 6c3f  ................
	defb 0fch,004h,0f8h,008h,0f8h,01dh,0e8h,02fh,0c8h,04fh,0cch,0dfh,084h,09fh,086h,08fh	; 6c4f  ......./.O......
	defb 043h,063h,043h,063h,041h,069h,020h,0b4h,030h,07eh,018h,0bfh,00eh,0ffh,007h,0ffh	; 6c5f  CcCcAi .0~......

; ----------------------------------------------------------------------
; DATOS tiles_6C6F: los dibujos de 7 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); se solapan 2
;   bloques: (tiles_6CBF 6CBF-6CDF); lo leen p00:5694 (112 bytes)
;   0x6c6f..0x6cdf  (112 bytes)
DATA_tiles_6C6F:
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,002h,0feh,004h,0fch,00ch,0f8h	; 6c6f  ................
	defb 0ffh,043h,0fbh,040h,0f0h,0e0h,070h,0e0h,030h,0e0h,038h,0f0h,01ch,0f8h,01fh,0f4h	; 6c7f  .C.@..p.0.8.....
	defb 01fh,0ffh,0ffh,0f6h,03eh,002h,05ch,004h,018h,008h,010h,010h,034h,010h,0fch,08ch	; 6c8f  ....>.\.....4...
	defb 0f8h,0ffh,0ffh,06fh,07ch,040h,07ah,020h,078h,010h,02ch,008h,02eh,00ch,0ffh,031h	; 6c9f  ...o|@z x.,....1
	defb 0ffh,0c2h,0dfh,002h,00fh,007h,00eh,007h,00ch,007h,01ch,00fh,078h,01fh,0f8h,02fh	; 6caf  ............x../
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,002h,0ffh,005h,0fdh	; 6cbf  ................
	defb 005h,0fdh,004h,0fch,002h,0feh,003h,0feh,003h,0feh,003h,0feh,003h,0feh,001h,0ffh	; 6ccf  ................

; ----------------------------------------------------------------------
; DATOS tiles_6CDF: los dibujos de 1 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (16 bytes)
;   0x6cdf..0x6cef  (16 bytes)
DATA_tiles_6CDF:
	defb 0bbh,0fbh,0ech,0fch,0f7h,0ffh,07ch,0fbh,0ffh,0ffh,0dfh,0ffh,0b5h,0ffh,09fh,0ffh	; 6cdf  ......|.........

; ----------------------------------------------------------------------
; DATOS tiles_6CEF: los dibujos de 5 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); se solapan 2
;   bloques: (tiles_6D2F 6D2F-6D3F); lo leen p00:5694 (80 bytes)
;   0x6cef..0x6d3f  (80 bytes)
DATA_tiles_6CEF:
	defb 001h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,008h,0fbh	; 6cef  ................
	defb 080h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,020h,0efh	; 6cff  .............. .
	defb 007h,007h,000h,040h,000h,0f0h,000h,0f8h,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 6d0f  ...@............
	defb 0e0h,0e0h,000h,002h,000h,00fh,000h,01fh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 6d1f  ................
	defb 0f0h,097h,0f0h,097h,0f0h,097h,0f0h,097h,0f0h,093h,0f0h,091h,0f0h,091h,0f8h,088h	; 6d2f  ................

; ----------------------------------------------------------------------
; DATOS tiles_6D3F: los dibujos de 2 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (32 bytes)
;   0x6d3f..0x6d5f  (32 bytes)
DATA_tiles_6D3F:
	defb 0ffh,001h,0feh,002h,0feh,002h,0fch,005h,0fch,045h,0f8h,04bh,0f8h,0cbh,0f8h,0cbh	; 6d3f  .........E.K....
	defb 0ffh,080h,07fh,040h,07fh,040h,03fh,0a0h,03fh,0a2h,01fh,092h,01fh,0d3h,01fh,0d3h	; 6d4f  ...@.@?.?.......

; ----------------------------------------------------------------------
; DATOS tiles_6D5F: los dibujos de 1 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (16 bytes)
;   0x6d5f..0x6d6f  (16 bytes)
DATA_tiles_6D5F:
	defb 0ffh,001h,0ffh,001h,0ffh,001h,0ffh,001h,0ffh,003h,0feh,003h,0feh,007h,0fch,006h	; 6d5f  ................

; ----------------------------------------------------------------------
; DATOS tiles_6D6F: los dibujos de 1 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (16 bytes)
;   0x6d6f..0x6d7f  (16 bytes)
DATA_tiles_6D6F:
	defb 0feh,06eh,0b4h,0fch,084h,0fch,0ffh,0cfh,0ffh,079h,0ffh,000h,0ffh,000h,0ffh,000h	; 6d6f  .n.......y......

; ----------------------------------------------------------------------
; DATOS tiles_6D7F: los dibujos de 6 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (96 bytes)
;   0x6d7f..0x6ddf  (96 bytes)
DATA_tiles_6D7F:
	defb 0fdh,0ffh,0dfh,0ffh,0cfh,0ffh,0cdh,0efh,08dh,0cfh,08dh,09dh,00dh,01dh,02dh,01fh	; 6d7f  ..............-.
	defb 0ffh,0ffh,0ffh,0ffh,0fch,0ffh,0f8h,0fch,0b1h,0f9h,063h,0fbh,0c7h,0f7h,09fh,0ffh	; 6d8f  ..........c.....
	defb 034h,0f4h,064h,0e5h,048h,0c9h,0c8h,0cbh,0e8h,0bfh,0a8h,0bfh,0a8h,03fh,02ch,07fh	; 6d9f  4.d.H........?,.
	defb 087h,083h,0c9h,0c8h,0cch,0cch,0cch,0cch,0cch,0cch,0cch,0ech,0cch,0feh,004h,0feh	; 6daf  ................
	defb 083h,0fbh,0e3h,07fh,079h,01fh,09fh,08fh,0c7h,0c7h,0cbh,0cbh,0c9h,0c9h,0cdh,0cch	; 6dbf  ....y...........
	defb 0fch,07eh,07eh,03eh,03eh,07eh,03eh,06eh,02eh,07eh,02eh,0f7h,0ach,0f7h,0e4h,0ffh	; 6dcf  .~~>>~>n.~......

; ----------------------------------------------------------------------
; DATOS tiles_6DDF: los dibujos de 1 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (16 bytes)
;   0x6ddf..0x6def  (16 bytes)
DATA_tiles_6DDF:
	defb 001h,000h,087h,083h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0ffh,079h,0ffh	; 6ddf  ..............y.

; ----------------------------------------------------------------------
; DATOS tiles_6DEF: los dibujos de 3 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:5694 (48 bytes)
;   0x6def..0x6e1f  (48 bytes)
DATA_tiles_6DEF:
	defb 002h,0feh,002h,0feh,002h,0feh,003h,0feh,003h,0feh,003h,0feh,003h,0feh,001h,0ffh	; 6def  ................
	defb 001h,0ffh,001h,0ffh,001h,0ffh,003h,0feh,003h,0feh,003h,0feh,003h,0feh,003h,0feh	; 6dff  ................
	defb 003h,0feh,001h,0ffh,001h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,001h,0ffh,001h,0ffh	; 6e0f  ................

; ----------------------------------------------------------------------
; DATOS tiles_6E1F: los dibujos de 11 tiles de una entrada de la imagen 65E8
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:5694 (264 bytes)
;   0x6e1f..0x6f27  (264 bytes)
DATA_tiles_6E1F:
	defb 0ffh,0d0h,0f0h,0f3h,020h,020h,001h,001h,001h,007h,006h,006h,01fh,00ch,00ch,0ffh,01fh,01fh,0fdh,03fh,03dh,07ch,037h,03eh	; 6e1f  ....  .............?=|7>
	defb 0fdh,0edh,0edh,07ch,0f4h,074h,03ch,0f4h,074h,09eh,0fch,03ch,09eh,0fch,09ch,0cfh,0feh,09eh,0efh,0feh,0ceh,0e7h,07eh,0eeh	; 6e37  ...|.t<.t..<..........~.
	defb 073h,07fh,0c3h,03fh,03fh,0e3h,03fh,03fh,0e1h,019h,01fh,0f1h,01fh,01fh,0f0h,03fh,03fh,0f8h,03eh,02fh,0e8h,03fh,02fh,0ech	; 6e4f  s..??.??.......??.>/.?/.
	defb 0f7h,03eh,0e6h,0f3h,0bfh,0e3h,0fbh,0ffh,0f3h,0fbh,07fh,0f3h,0fdh,08fh,0f9h,0fdh,0ffh,079h,05eh,0cfh,04ch,0feh,0ffh,0fch	; 6e67  .>...............y^.L...
	defb 0ffh,06eh,07fh,0ffh,0dfh,0ffh,0e1h,0ffh,0f1h,0c4h,0ffh,0e0h,09eh,0ffh,0c4h,03eh,0ffh,08eh,077h,0f3h,013h,0fch,0e4h,024h	; 6e7f  .n.............>..w....$
	defb 07fh,00bh,00eh,03fh,007h,006h,04fh,003h,003h,00fh,001h,001h,013h,001h,001h,003h,001h,001h,087h,001h,001h,0ceh,003h,002h	; 6e97  ...?..O.................
	defb 00fh,00fh,0ffh,010h,01fh,0f6h,027h,03fh,0e0h,07fh,07fh,0c7h,07fh,07fh,0cfh,06fh,07eh,0cfh,07fh,07fh,0c7h,07dh,07dh,0c7h	; 6eaf  ......'?.......o~....}}.
	defb 07fh,0ffh,07fh,0bfh,0ffh,03fh,0ffh,0ffh,01fh,0efh,0ffh,08fh,0f3h,07fh,0c3h,0fch,01fh,0f0h,0ffh,08fh,0f8h,0ffh,087h,0ffh	; 6ec7  .....?..................
	defb 0fdh,0ffh,0feh,0f9h,0ffh,0f8h,0f3h,0ffh,0f1h,0e7h,0feh,0f3h,08fh,0fch,0c7h,03fh,0f8h,00fh,0ffh,0f0h,03fh,0ffh,0c1h,0ffh	; 6edf  ...............?....?...
	defb 0feh,0e8h,068h,0f3h,090h,0f0h,0f8h,020h,0e0h,0cch,040h,0c0h,0c0h,040h,0c0h,0e0h,040h,0c0h,0f0h,0c0h,0c0h,0b8h,0e0h,0a0h	; 6ef7  ..h.... ..@..@..@.......
	defb 0ffh,01bh,01bh,0dfh,001h,001h,083h,080h,080h,0e0h,060h,060h,0f9h,010h,010h,0ffh,0f9h,0f9h,0bfh,0fch,0bch,03eh,0ech,07ch	; 6f0f  ..........``.........>.|

; ----------------------------------------------------------------------
; DATOS tiles_6F27: los dibujos de 21 tiles de una entrada de la imagen 65E8
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:5694 (504 bytes)
;   0x6f27..0x711f  (504 bytes)
DATA_tiles_6F27:
	defb 0ffh,0f7h,0feh,063h,07fh,063h,031h,03fh,031h,0f8h,03fh,038h,0fch,0f7h,0fch,0eeh,0d1h,0eeh,0c6h,039h,0c6h,007h,0f9h,007h	; 6f27  ...c.c1?1.?8.......9....
	defb 0ffh,0ffh,000h,0ffh,0ffh,0f8h,0f7h,0ffh,00fh,006h,0ffh,001h,000h,0ffh,000h,040h,0bfh,040h,0e3h,01fh,0e3h,0fch,01fh,0ffh	; 6f3f  ...............@.@......
	defb 0ffh,0ffh,000h,0ffh,0ffh,001h,0feh,0ffh,003h,0fch,0ffh,0ceh,0f8h,0ffh,034h,07fh,0f0h,01fh,0ffh,0f8h,0ffh,0ffh,0fdh,01fh	; 6f57  ..............4.........
	defb 0e8h,0ffh,0f4h,069h,0ffh,089h,019h,0ffh,019h,099h,0ffh,099h,099h,0ffh,099h,09bh,0fdh,09bh,0bfh,0d9h,0bfh,0bfh,0d0h,0bfh	; 6f6f  ...i....................
	defb 097h,0ffh,09fh,0dfh,0afh,0dbh,0dfh,0afh,0d9h,0f9h,08fh,0f9h,0ffh,08bh,0feh,0feh,08bh,0feh,0feh,08bh,0feh,0ffh,01ah,0ffh	; 6f87  ........................
	defb 0bfh,0ffh,0e0h,0ffh,0ffh,0a0h,0bfh,0ffh,0a0h,0ffh,0bfh,0e0h,0ffh,03fh,0e0h,0ffh,03fh,0e0h,0ffh,0bfh,0e0h,0ffh,0ffh,0c0h	; 6f9f  .............?..?.......
	defb 0ffh,0dfh,07fh,0ffh,0ffh,07dh,0fbh,0bfh,0f9h,0f9h,0bfh,0fbh,0d9h,0bfh,0dbh,09dh,0f3h,09dh,0ddh,0b3h,0ddh,0dch,0fbh,05ch	; 6fb7  .....}.................\
	defb 0f3h,0fch,083h,0c0h,0ffh,000h,000h,0ffh,08ch,080h,0ffh,080h,080h,0ffh,080h,000h,0ffh,000h,000h,0ffh,000h,080h,0ffh,080h	; 6fcf  ........................
	defb 0c7h,005h,007h,00fh,005h,007h,08fh,08dh,08fh,00fh,00dh,00fh,01fh,00fh,00fh,01fh,01fh,017h,03fh,03fh,039h,077h,07fh,076h	; 6fe7  ..................??9w.v
	defb 0ddh,0fbh,05dh,0dfh,0f0h,0dfh,0ffh,0c3h,0ffh,0ffh,08fh,0ffh,0ffh,03fh,0ffh,0ffh,0fch,0fch,0ffh,0f3h,0d3h,0ffh,0f7h,097h	; 6fff  ..]..........?..........
	defb 0f0h,0e0h,0e0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0bfh,0ffh,07fh,0dfh,07fh,03fh,0e6h,03fh	; 7017  .....................?.?
	defb 0ffh,007h,0ffh,0ffh,07fh,0fah,0ffh,0ffh,0e2h,0eeh,0eeh,095h,0feh,0feh,0ddh,079h,069h,06fh,0b6h,096h,096h,0c0h,0c0h,0c0h	; 702f  ...............yio......
	defb 0ffh,0fah,0ffh,0ffh,0fch,0ffh,0ffh,0feh,05fh,0dfh,0deh,06fh,0ffh,0f7h,0b7h,0ffh,04bh,04bh,04fh,007h,007h,03fh,033h,032h	; 7047  ........_..o....KKO..?32
	defb 0f8h,0e0h,0e0h,0d8h,0f0h,070h,07ch,0f0h,050h,0fch,070h,0d0h,0dch,070h,0d0h,0deh,078h,0d8h,0ffh,0fch,0fch,0ffh,0ffh,0ffh	; 705f  .....p|.P.p..p..x.......
	defb 0ffh,0ffh,000h,0ffh,0ffh,0c0h,0ffh,0ffh,0a0h,09fh,0ffh,0b0h,09fh,0ffh,08dh,0cfh,0ffh,043h,0c7h,0ffh,040h,0c0h,0ffh,040h	; 7077  .................C..@..@
	defb 0ffh,0e6h,02fh,0ffh,0ech,06fh,0ffh,0ech,07fh,0ffh,0feh,07fh,0f7h,0f7h,07fh,0fbh,0fbh,0fch,0ffh,0dfh,0feh,0ffh,097h,0bfh	; 708f  ../..o..................
	defb 0ffh,000h,0ffh,0ffh,020h,0ffh,0ffh,040h,0dfh,0ffh,0c9h,0ffh,0ffh,0a9h,0bbh,07fh,07bh,0fbh,0feh,0fah,02bh,0ffh,0ffh,0feh	; 70a7  .... ..@........{...+...
	defb 0ffh,000h,0ffh,0ffh,008h,0efh,0ffh,008h,0efh,0ffh,00ch,0efh,0ffh,01fh,0ffh,0f9h,099h,0deh,0ffh,0bfh,0e0h,0ffh,0bfh,0bfh	; 70bf  ........................
	defb 0ffh,067h,074h,0ffh,073h,07ah,0ffh,07bh,0fah,0ffh,0ffh,0feh,0efh,0efh,0feh,09fh,09fh,07eh,0ffh,0ffh,07fh,0ffh,0d3h,0fbh	; 70d7  .gt.sz.{.........~......
	defb 0ffh,0ffh,0e0h,0ffh,0dfh,0f0h,0ffh,08fh,0f8h,0ffh,08fh,0f8h,0ffh,0c7h,0fch,07fh,0c7h,0fch,07fh,0cfh,0fch,0ffh,0dbh,0fah	; 70ef  ........................
	defb 0c0h,0c0h,0c0h,07fh,07fh,07fh,07fh,03fh,07fh,0ffh,0f1h,0ffh,0ffh,0ffh,0ffh,0d4h,07fh,0d4h,0ach,0ffh,0ach,0d7h,07ch,0d7h	; 7107  .......?..............|.

; ----------------------------------------------------------------------
; DATOS tiles_711F: los dibujos de 23 tiles de una entrada de la imagen 65E8
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); se solapan
;   2 bloques: (tiles_7317 7317-7347); lo leen p00:5694 (552 bytes)
;   0x711f..0x7347  (552 bytes)
DATA_tiles_711F:
	defb 00ch,0fch,00ch,01ch,0f8h,018h,078h,0e0h,060h,0e8h,080h,080h,0b1h,081h,081h,0ebh,0c3h,0c3h,0feh,072h,0f3h,0bfh,0bfh,0ffh	; 711f  ......x.`..........r....
	defb 07eh,01fh,01eh,03ch,03fh,03ch,0f9h,0ffh,0f9h,0ffh,0cfh,0ffh,0ffh,0e0h,0ffh,0ffh,0f8h,0ffh,09fh,09ch,0ffh,007h,006h,0ffh	; 7137  ~..<?<..................
	defb 003h,0ffh,001h,021h,0ffh,021h,07bh,0ffh,07bh,0ffh,08fh,08fh,0ebh,083h,083h,0c3h,002h,002h,0feh,07eh,07fh,08ch,0fch,0ffh	; 714f  ...!.!{.{..........~....
	defb 0abh,0fbh,0afh,09ah,0fbh,09fh,0bah,0fbh,0bfh,0ffh,07dh,0fdh,0ffh,00ch,0fch,0fch,004h,0fch,0fch,008h,0f8h,0fch,008h,0f8h	; 7167  ..........}.............
	defb 03fh,0edh,0edh,07eh,0f3h,0f3h,05eh,0f3h,0d3h,01fh,0f7h,0f7h,0f7h,0f1h,0f1h,0e1h,020h,020h,038h,010h,010h,000h,000h,000h	; 717f  ?..~..^.........  8.....
	defb 01ch,0fch,0ffh,014h,0fch,0f7h,004h,0fch,0feh,009h,0f8h,0f8h,0f2h,0f0h,0f0h,001h,000h,000h,001h,001h,001h,001h,001h,001h	; 7197  ........................
	defb 030h,0ffh,030h,010h,0ffh,010h,039h,0ffh,031h,0bbh,0feh,03ah,0ffh,0fch,0fch,0fdh,03ch,0fch,0ceh,07ch,0cch,0ffh,07fh,0dfh	; 71af  0.0...9.1..:....<..|....
	defb 07eh,0ffh,03eh,07eh,0ffh,03eh,03ch,0ffh,01ch,09ch,0ffh,08ch,0c8h,07fh,048h,061h,03fh,021h,021h,03fh,021h,0f3h,0deh,0d2h	; 71c7  ~.>~.><.......Ha?!!?!...
	defb 0ffh,07fh,07fh,06fh,07fh,063h,0ffh,07fh,07fh,07fh,07fh,07fh,0feh,0ffh,0feh,0fch,0ffh,0fch,0ffh,0b7h,0b7h,0feh,02fh,02eh	; 71df  ...o.c................/.
	defb 0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,030h,0ffh,0dfh,0fch,0cfh,077h,0feh,0f3h,0bbh,0ffh,0f9h,0bbh,0ffh,0f9h,0fdh,0ffh,0bdh	; 71f7  .......0....w...........
	defb 0ffh,0feh,0ffh,0ffh,0ffh,001h,0d3h,0ffh,000h,0ech,0ffh,010h,0fah,0ffh,000h,0fch,0ffh,000h,0fah,0ffh,000h,0fch,0ffh,000h	; 720f  ........................
	defb 0cfh,07fh,0d7h,0d7h,0ffh,0c7h,077h,0ffh,0c7h,077h,0ffh,0c7h,073h,0ffh,0c3h,0f0h,0ffh,040h,06ah,0ffh,040h,0f5h,0ffh,040h	; 7227  ......w..w..s....@j.@..@
	defb 0f3h,0feh,0e3h,0f3h,0ffh,0e3h,0e6h,0ffh,0e3h,0e3h,0ffh,0e2h,0c3h,0ffh,0c2h,002h,0ffh,002h,003h,0ffh,002h,0a2h,0ffh,002h	; 723f  ........................
	defb 0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,0efh,01fh,0efh,0d0h,030h,0dfh,0ffh,03fh,0ffh,0ech,03fh,0fch,0eeh,03fh,0feh	; 7257  .............0..?..?..?.
	defb 03fh,0ffh,038h,07fh,0ffh,07ch,0f6h,0dfh,0f7h,0fah,09fh,0f3h,0fbh,01fh,0f3h,0ffh,00fh,0ffh,0ffh,00fh,0ffh,0ffh,007h,0ffh	; 726f  ?.8..|..................
	defb 0f2h,01fh,0f9h,0fah,01fh,0f1h,0e5h,03fh,0f2h,0f5h,03fh,0e2h,0f3h,03fh,0e0h,0e0h,07fh,0c1h,0e1h,07fh,0c6h,0e7h,07fh,0cbh	; 7287  .......?..?..?..........
	defb 0ffh,07fh,0c7h,0f8h,07fh,0d8h,0e7h,03fh,0e7h,0ffh,0ffh,0fch,0f7h,0ffh,0f0h,077h,0ffh,070h,03bh,0ffh,070h,03bh,0ffh,038h	; 729f  .......?.......w.p..p..8
	defb 0ffh,07fh,0ffh,08fh,0ffh,0f0h,043h,0ffh,080h,09fh,0ffh,000h,04fh,0ffh,030h,0bfh,0ffh,040h,0ffh,0ffh,000h,07fh,0ffh,080h	; 72b7  ......C.....O.0..@......
	defb 0efh,0ffh,019h,0efh,0ffh,019h,0f7h,0ffh,0c9h,0ffh,07fh,063h,07fh,0bfh,0b7h,03dh,01fh,01fh,0bdh,09fh,09fh,03fh,01fh,01fh	; 72cf  ...........c...=.....?..
	defb 07fh,03fh,021h,0ffh,07fh,043h,0dfh,0feh,0a3h,0bfh,0feh,047h,07fh,0fch,09fh,0ffh,0f8h,07fh,0ffh,0f0h,0ffh,0dfh,0f0h,0dfh	; 72e7  .?!..C.....G............
	defb 068h,0ffh,0ffh,05bh,0ffh,0e4h,027h,0ffh,0dfh,08fh,0fch,07ch,0dch,0fbh,03bh,0f9h,0f6h,0b7h,0fah,0f4h,0f7h,079h,0f3h,0f3h	; 72ff  h..[..'....|.........y..
	defb 0fbh,00fh,0fbh,0ffh,00fh,0fbh,0ffh,00fh,0fdh,0fdh,007h,0ffh,0fdh,007h,0ffh,0feh,007h,0ffh,0ffh,003h,0ffh,0ffh,001h,0ffh	; 7317  ........................
	defb 0e6h,0ffh,0dbh,0feh,07fh,0e5h,0ffh,07fh,0feh,0ffh,0ffh,0cfh,0f7h,0ffh,0ffh,05dh,0ffh,0dfh,0a3h,0ffh,0c3h,0f8h,0ffh,0c0h	; 732f  ...............]........

; ----------------------------------------------------------------------
; DATOS tiles_7347: los dibujos de 4 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:5694 (96 bytes)
;   0x7347..0x73a7  (96 bytes)
DATA_tiles_7347:
	defb 0e0h,0ffh,0ffh,0e7h,0ffh,0f8h,0efh,0ffh,0b3h,0ffh,0ffh,0a7h,0feh,0ffh,0afh,0fch,0ffh,09fh,0ffh,0feh,08dh,0ffh,0feh,0ddh	; 7347  ........................
	defb 0d5h,0ffh,06bh,0ddh,0ffh,063h,0edh,0ffh,0f3h,0f5h,0ffh,0fbh,0f3h,0ffh,03fh,0fbh,03fh,0dfh,0ffh,03fh,0dfh,0deh,03fh,0ffh	; 735f  ..k..c........?.?..?..?.
	defb 0bfh,0ffh,07fh,0eeh,0feh,0dfh,07dh,0fdh,08fh,0bah,0feh,0cbh,07ch,0fch,08fh,0feh,0ffh,066h,0fbh,0ffh,0ffh,0d4h,0ffh,0d7h	; 7377  ......}.....|....f......
	defb 0fch,0f8h,0f8h,07fh,07ch,0fch,0b7h,0bfh,0f7h,05fh,0ffh,05eh,03eh,0ffh,039h,07fh,0ffh,064h,0ffh,0ffh,0dfh,069h,0ffh,0a9h	; 738f  ....|...._.^>.9..d...i..

; ----------------------------------------------------------------------
; DATOS tiles_73A7: los dibujos de 12 tiles de una entrada de la imagen 65E8
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:5694 (288 bytes)
;   0x73a7..0x74c7  (288 bytes)
DATA_tiles_73A7:
	defb 06dh,02fh,0eeh,06fh,02fh,0eeh,06fh,02fh,0edh,07fh,04fh,0cfh,07fh,047h,0c7h,0ffh,0c0h,0c0h,0fch,0c0h,0c0h,0f8h,0e0h,0e0h	; 73a7  m/.o/.o/..O..G..........
	defb 07fh,07ah,07bh,056h,07ah,07bh,0f7h,07bh,05bh,0f2h,07ah,07bh,0e6h,036h,037h,046h,006h,007h,067h,047h,047h,0e7h,087h,087h	; 73bf  .z{Vz{.{[.z{.67F..gGG...
	defb 008h,0ffh,0fbh,004h,0ffh,0f7h,000h,0ffh,0ffh,003h,0ffh,0ffh,004h,0fch,0fch,018h,0fbh,0fbh,0e2h,0f4h,0f6h,08ah,064h,0eeh	; 73d7  ......................d.
	defb 020h,0ffh,0efh,010h,0ffh,0dfh,000h,0ffh,0ffh,0c0h,0ffh,0ffh,020h,03fh,07fh,018h,01fh,03fh,007h,007h,04fh,000h,000h,021h	; 73ef   ........... ?...?..O..!
	defb 004h,008h,00ch,008h,000h,088h,084h,080h,0c4h,078h,078h,07ch,00eh,00eh,03fh,0e3h,0e3h,0efh,0f8h,0f8h,07bh,09dh,0fch,09dh	; 7407  .........xx|..?.....{...
	defb 008h,000h,038h,008h,000h,039h,011h,001h,033h,01eh,01eh,07eh,070h,070h,0fch,0c7h,0c7h,0f7h,01fh,01fh,0deh,0b9h,03fh,0b9h	; 741f  ..8..9..3..~pp........?.
	defb 018h,010h,0f0h,018h,010h,0f0h,018h,010h,0f0h,019h,011h,0f1h,00fh,00ah,0fbh,01dh,01fh,0fdh,0f3h,0f3h,0f3h,099h,0f9h,099h	; 7437  ........................
	defb 074h,0fch,0cfh,03ch,0fch,0e7h,01ah,0feh,0f7h,01eh,0feh,0f3h,00fh,0ffh,0f9h,00fh,0ffh,0f9h,007h,0ffh,0fdh,007h,0ffh,0f5h	; 744f  t..<....................
	defb 007h,0ffh,0f4h,007h,0ffh,0f4h,007h,0ffh,0f4h,007h,0ffh,0e4h,00fh,0ffh,0c8h,00fh,0ffh,088h,01fh,0ffh,010h,0bfh,0ffh,0a0h	; 7467  ........................
	defb 0e0h,0ffh,03fh,0e0h,0ffh,02fh,060h,0ffh,0afh,060h,0ffh,0a7h,0f0h,0ffh,013h,070h,0ffh,093h,078h,0ffh,088h,0fdh,0ffh,005h	; 747f  ..?../`..`.....p..x.....
	defb 0feh,0ffh,0feh,07bh,07fh,0ffh,054h,07fh,0ffh,077h,07fh,0f7h,03bh,03fh,0fbh,01ch,01fh,0fch,00fh,00fh,0ffh,00bh,00fh,0fbh	; 7497  ...{..T..w...?..........
	defb 030h,03fh,0f3h,03ah,03fh,0fbh,072h,07fh,0f3h,074h,07fh,0d7h,074h,07fh,0d7h,0f4h,0ffh,0ffh,0e0h,0ffh,0bfh,0e0h,0ffh,0bfh	; 74af  0?.:?.r..t..t...........

; ----------------------------------------------------------------------
; DATOS tiles_74C7: los dibujos de 21 tiles de una entrada de la imagen 65E8
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); se solapan
;   2 bloques: (tiles_76A7 76A7-76BF); lo leen p00:5694 (504 bytes)
;   0x74c7..0x76bf  (504 bytes)
DATA_tiles_74C7:
	defb 0c0h,040h,07fh,0c0h,040h,07fh,0c0h,040h,07fh,0e1h,021h,07fh,0e3h,022h,03fh,0f7h,014h,03eh,0ffh,0bfh,09fh,0ffh,0feh,09eh	; 74c7  .@..@..@..!.."?..>......
	defb 000h,000h,0ffh,00fh,00fh,0ffh,07fh,070h,0ffh,0ffh,080h,0f0h,0ffh,000h,080h,0ffh,01fh,000h,0ffh,0ffh,0e0h,0ffh,01fh,03ch	; 74df  .......p...............<
	defb 000h,000h,0ffh,0f0h,0f0h,0ffh,0fch,00ch,0ffh,0ffh,003h,00fh,0ffh,000h,003h,0ffh,001h,000h,0ffh,0a3h,001h,0ffh,0f7h,003h	; 74f7  ........................
	defb 000h,000h,0ffh,000h,000h,0ffh,003h,003h,0ffh,007h,004h,0fdh,09fh,098h,0fch,0ffh,0e0h,0e0h,0ffh,0c3h,081h,0ffh,043h,042h	; 750f  ......................CB
	defb 078h,058h,0efh,0f8h,098h,0cfh,0f8h,018h,08fh,0f0h,030h,01fh,0f0h,030h,01fh,0e0h,0e0h,03fh,0e0h,0e0h,03fh,0c0h,0c0h,07fh	; 7527  xX........0..0...?..?...
	defb 0ffh,06fh,04ch,0ffh,0ffh,07dh,0feh,0feh,03bh,0feh,0feh,087h,0ffh,0fdh,0fbh,0ffh,0fdh,0b9h,0ffh,0fdh,0ddh,0ffh,0feh,0fdh	; 753f  .oL..}..................
	defb 0ffh,01fh,02dh,0ffh,03eh,059h,0ffh,03eh,05ah,0ffh,0ffh,035h,0ffh,0fdh,03dh,0feh,0fah,0fbh,0fch,0fch,0ffh,0f0h,0f0h,0ffh	; 7557  ..-.>Y.>Z..5..=.........
	defb 000h,000h,0ffh,001h,001h,0ffh,003h,002h,0ffh,007h,004h,0feh,00fh,009h,0fch,00fh,00bh,0f8h,01fh,013h,0f8h,01fh,017h,0f0h	; 756f  ........................
	defb 07fh,07fh,0ffh,0ffh,087h,0ffh,0ffh,005h,087h,0ffh,07bh,01dh,0ffh,0ffh,03bh,0ffh,0f7h,07bh,0ffh,0ffh,076h,0ffh,0ffh,0f6h	; 7587  ..........{......{..v...
	defb 0f0h,0d0h,0bfh,0ffh,09fh,03fh,0ffh,03eh,079h,0ffh,078h,0e0h,0ffh,0e0h,0c0h,0ffh,08fh,080h,0ffh,03fh,000h,0ffh,0ffh,000h	; 759f  .....?.>y.x........?....
	defb 000h,000h,0ffh,080h,080h,0ffh,0e0h,060h,0ffh,0f0h,010h,07fh,0f8h,008h,01fh,0fch,004h,00fh,0fch,084h,00fh,0feh,0c2h,007h	; 75b7  .......`................
	defb 07eh,0fdh,041h,03eh,07dh,0a1h,03eh,079h,0a1h,07ch,0fbh,063h,0fch,0fbh,0c3h,0feh,0f9h,001h,0ffh,0f0h,000h,0ffh,0f8h,000h	; 75cf  ~.A>}.>y.|.c............
	defb 0feh,01fh,0c2h,0fch,01eh,045h,0bch,05eh,045h,0feh,01fh,046h,07fh,09fh,083h,0ffh,01fh,001h,0ffh,03fh,000h,0ffh,07fh,000h	; 75e7  .....E.^E..F.......?....
	defb 000h,000h,0ffh,0f0h,0f0h,0ffh,0feh,01eh,01fh,0ffh,003h,003h,0ffh,0f8h,000h,0ffh,0ffh,000h,0ffh,0ffh,01eh,0e1h,0ffh,07fh	; 75ff  ........................
	defb 000h,000h,0ffh,000h,000h,0ffh,000h,000h,0ffh,080h,080h,0ffh,0c0h,0c0h,0ffh,0e0h,020h,03fh,0f0h,0d0h,01fh,0e8h,0f8h,09fh	; 7617  ................ ?......
	defb 03eh,027h,0e3h,03ch,02fh,0e7h,058h,06fh,0efh,078h,05fh,0cfh,0f0h,09fh,09fh,0f0h,0bfh,09fh,0e0h,0bfh,0bfh,0e0h,0bfh,0bfh	; 762f  >'.</.Xo.x_.............
	defb 00fh,00ch,0feh,00fh,008h,0fch,01fh,019h,0fch,01fh,011h,0f8h,01fh,013h,0f8h,03fh,033h,0f8h,03fh,023h,0f0h,03fh,027h,0f0h	; 7647  ...............?3.?#.?'.
	defb 0b0h,070h,07fh,0d0h,030h,03fh,0d8h,038h,03fh,0e8h,098h,01fh,0e8h,0d8h,01fh,0ech,0dch,01fh,0fch,0e4h,00fh,0fch,0e4h,00fh	; 765f  .p..0?.8?...............
	defb 000h,000h,0ffh,000h,000h,0ffh,000h,000h,0ffh,001h,001h,0ffh,003h,003h,0ffh,005h,006h,0feh,00bh,00ch,0fch,017h,01bh,0f9h	; 7677  ........................
	defb 000h,000h,0ffh,00fh,00fh,0ffh,07fh,078h,0f8h,0ffh,0c0h,0c0h,0ffh,00fh,000h,0ffh,07fh,000h,0ffh,0ffh,078h,087h,0ffh,0feh	; 768f  .......x............x...
	defb 03fh,027h,0f0h,02fh,037h,0f0h,03fh,027h,0e1h,03fh,027h,0f1h,03fh,037h,0f1h,03fh,033h,0f1h,01fh,017h,0f9h,01fh,01bh,0f9h	; 76a7  ?'./7.?'.?'.?7.?3.......

; ----------------------------------------------------------------------
; DATOS tiles_76BF: los dibujos de 7 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:5694 (168 bytes)
;   0x76bf..0x7767  (168 bytes)
DATA_tiles_76BF:
	defb 0ffh,0ffh,0bfh,0ffh,0ffh,0bfh,0ffh,0fah,07fh,0ffh,0f6h,07fh,0ffh,0fbh,0fbh,0ffh,0edh,0edh,0feh,0feh,0feh,0f7h,0f3h,0f3h	; 76bf  ........................
	defb 0ffh,0ffh,0f8h,0ffh,0ffh,0ffh,0ffh,0b7h,0ffh,0ffh,093h,0ffh,0ffh,0dbh,0ffh,0ffh,02ch,02ch,01fh,001h,001h,003h,002h,002h	; 76d7  ................,,......
	defb 0cdh,0ffh,00dh,0f5h,0ffh,005h,0fbh,0ffh,0c1h,0ffh,0ffh,0f8h,0ffh,09fh,09eh,0ffh,077h,077h,0ffh,0fbh,0fbh,03fh,00dh,00dh	; 76ef  ................ww...?..
	defb 0ffh,0e7h,0e7h,0fah,0efh,0efh,07bh,066h,0e7h,02bh,02fh,0efh,025h,023h,0e3h,0e0h,0e0h,0e0h,071h,0e0h,0e0h,073h,0f1h,0f1h	; 7707  ......{f.+/.%#....q..s..
	defb 0ffh,0f5h,0f5h,07fh,0f8h,0f8h,06fh,0d8h,0f8h,07fh,0e8h,0f8h,03fh,0f1h,0f1h,07fh,003h,003h,01dh,007h,007h,00dh,007h,007h	; 771f  ......o.....?...........
	defb 0f3h,0f1h,071h,0f1h,0f0h,070h,0f8h,0f0h,070h,0f8h,0f8h,078h,0f8h,0f8h,078h,0ech,0e8h,0f8h,004h,004h,0fch,002h,002h,0feh	; 7737  ..q..p..p..x..x.........
	defb 00dh,007h,005h,00fh,007h,005h,00fh,007h,005h,00fh,007h,005h,01fh,007h,005h,03fh,00fh,00fh,07fh,01fh,01fh,0ffh,03fh,03fh	; 774f  ...............?......??

; ----------------------------------------------------------------------
; DATOS tiles_7767: los dibujos de 9 tiles de una entrada de la imagen 65E8 de
;   p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); se solapan 2
;   bloques: (tiles_780F 780F-783F); lo leen p00:5694 (216 bytes)
;   0x7767..0x783f  (216 bytes)
DATA_tiles_7767:
	defb 0ffh,0ffh,000h,0ffh,0f0h,00fh,0f0h,0c0h,030h,0c0h,000h,0c0h,000h,000h,000h,003h,008h,043h,007h,008h,085h,003h,004h,002h	; 7767  ........0........C......
	defb 0ffh,0ffh,000h,0ffh,00fh,0f0h,00fh,003h,00ch,003h,000h,003h,000h,020h,000h,0c0h,030h,0c0h,0e0h,010h,0a1h,040h,020h,0c0h	; 777f  ............. ..0....@ .
	defb 0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,0ffh,000h,0ffh,07fh,080h,07fh,03fh,040h,03fh,01fh,020h,01fh,02fh,090h	; 7797  ................?@?. ./.
	defb 0f8h,0f0h,008h,0f0h,0e8h,014h,0f0h,0e0h,010h,0e0h,0c0h,020h,0e0h,0c0h,020h,0e0h,0c0h,020h,0e0h,0c0h,020h,0c0h,0a0h,040h	; 77af  ........... .. .. .. ..@
	defb 000h,00bh,000h,003h,008h,003h,007h,008h,005h,003h,004h,002h,000h,00bh,000h,003h,00ch,003h,007h,008h,005h,003h,004h,002h	; 77c7  ........................
	defb 000h,0d0h,000h,0c0h,030h,0c0h,0e0h,010h,0a0h,040h,020h,0c0h,000h,0d0h,000h,0c0h,030h,0c0h,0e0h,010h,0a0h,040h,020h,0c0h	; 77df  ....0....@ .....0....@ .
	defb 01fh,00fh,0d0h,00fh,007h,008h,00fh,007h,028h,007h,003h,004h,007h,003h,024h,007h,003h,004h,007h,003h,004h,003h,005h,002h	; 77f7  ........(.....$.........
	defb 0c0h,020h,0c0h,0c0h,021h,0c0h,0c0h,032h,0c0h,0c0h,034h,0c0h,040h,03eh,040h,049h,036h,049h,047h,0b8h,046h,047h,0b9h,046h	; 780f  . ..!..2..4.@>@I6IG.FG.F
	defb 0f1h,0eeh,011h,0f9h,0f6h,009h,0f9h,0f6h,009h,0fch,0fbh,004h,0fch,01bh,0e4h,0feh,001h,03eh,0feh,001h,076h,0ffh,080h,0e7h	; 7827  .................>..v...

; ----------------------------------------------------------------------
; DATOS mapa_783F: un mapa de 24 x 6 tiles (p00:56AC); lo leen p00:569D (144
;   bytes)
;   0x783f..0x78cf  (144 bytes)
DATA_mapa_783F:
	defb 001h,016h,017h,018h,019h,001h,001h,0a7h,061h,09ah,09bh,002h,001h,05ah,056h,057h,05dh,001h,001h,06eh,0f4h,0f5h,0f6h,001h	; 783f  ........a....ZVW]..n....
	defb 001h,0a8h,0a9h,0aah,0abh,001h,001h,062h,063h,09ch,09dh,02dh,001h,0d6h,058h,059h,055h,001h,073h,0f7h,0f8h,0f9h,0fah,075h	; 7857  .......bc..-..XYU.s....u
	defb 01ah,024h,098h,08eh,025h,01bh,001h,064h,0a2h,0a4h,0a5h,09eh,001h,0c7h,0c8h,0c2h,0c0h,001h,074h,0fbh,032h,034h,0fdh,076h	; 786f  .$..%..d..........t.24.v
	defb 094h,08fh,01dh,01eh,026h,01ch,003h,09fh,0cbh,020h,0cch,004h,001h,0d5h,0c9h,0cah,0c1h,001h,011h,06fh,070h,071h,072h,014h	; 7887  ....&.... .........opqr.
	defb 090h,091h,027h,01fh,092h,0ach,035h,065h,0a6h,021h,0a1h,02eh,001h,0c3h,077h,078h,0c5h,001h,068h,0fch,02fh,030h,0feh,06bh	; 789f  ..'...5e.!....wx..h./0.k
	defb 02bh,093h,095h,096h,097h,02ch,036h,0a0h,060h,0a3h,066h,067h,05bh,05ch,0c4h,0c6h,05fh,05eh,069h,06ah,031h,033h,06dh,06ch	; 78b7  +....,6.`.fg[\.._^ij13ml

; ----------------------------------------------------------------------
; DATOS mapa_78CF: un mapa de 24 x 6 tiles (p00:56AC); lo leen p00:56A6 (144
;   bytes)
;   0x78cf..0x795f  (144 bytes)
DATA_mapa_78CF:
	defb 001h,037h,038h,039h,03ah,001h,08ch,0d7h,0d8h,0d9h,0dah,0dbh,001h,0e9h,0eah,0e4h,0e5h,001h,001h,043h,0bfh,0b8h,044h,001h	; 78cf  .789:..............C..D.
	defb 003h,03bh,03ch,03dh,03eh,0b7h,08dh,086h,087h,088h,0dch,009h,001h,0e6h,079h,07ah,0d2h,001h,001h,0bdh,053h,054h,045h,001h	; 78e7  ..<=>.........yz....STE.
	defb 03fh,0b4h,0b5h,0b0h,040h,041h,08bh,0edh,0eeh,0efh,089h,00ah,00fh,0d4h,0cdh,0ceh,0d3h,012h,010h,0b9h,049h,04ah,0bah,013h	; 78ff  ?...@A..............IJ..
	defb 001h,0b1h,0b2h,0b3h,0b6h,042h,00bh,0f0h,022h,0f1h,084h,001h,081h,0e3h,0cfh,0d0h,0e2h,082h,00ch,04bh,04ch,04dh,04eh,00eh	; 7917  .....B.."..........KLMN.
	defb 006h,0d1h,028h,029h,0afh,007h,00dh,0f2h,023h,0f3h,0ddh,007h,0e7h,07fh,07bh,07ch,080h,0e8h,0bbh,0beh,04fh,050h,046h,001h	; 792f  ..()....#.....{|....OPF.
	defb 083h,0aeh,0adh,02ah,099h,002h,0deh,0dfh,08ah,085h,0e0h,0e1h,0ebh,07dh,015h,015h,07eh,0ech,048h,0bch,051h,052h,047h,001h	; 7947  ...*.........}..~.H.QRG.

; ----------------------------------------------------------------------
; DATOS paletas_795F: las 5 palabras que apuntan a las paletas de la imagen
;   7987 (p00:5911: palabra A de la tabla); se solapan 3 bloques:
;   (paletas_795F 795F-796B) (paletas_795F 795F-796D); lo leen p00:57D6 (14
;   bytes)
;   0x795f..0x796d  (14 bytes)
DATA_paletas_795F:
	defw 0796dh,07975h,07979h,0797bh,0797dh,0797fh,07983h	; 795f

; ----------------------------------------------------------------------
; DATOS paleta_796D: la paleta 0 de la imagen 7987: 8 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (8 bytes)
;   0x796d..0x7975  (8 bytes)
DATA_paleta_796D:
	defb 00ah,00bh,00ch,00dh,00fh,000h,000h,000h	; 796d  ........

; ----------------------------------------------------------------------
; DATOS paleta_7975: la paleta 1 de la imagen 7987: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (4 bytes)
;   0x7975..0x7979  (4 bytes)
DATA_paleta_7975:
	defb 00bh,00ch,00dh,00fh	; 7975

; ----------------------------------------------------------------------
; DATOS paleta_7979: la paleta 2 de la imagen 7987: 2 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (2 bytes)
;   0x7979..0x797b  (2 bytes)
DATA_paleta_7979:
	defb 000h,00ah	; 7979

; ----------------------------------------------------------------------
; DATOS paleta_797B: la paleta 3 de la imagen 7987: 2 bytes de colores que se
;   copian a 0xE800 (p00:592F) (ninguna entrada de la lista la pide: su tamano
;   es hasta la siguiente); lo leen p00:57D6 (2 bytes)
;   0x797b..0x797d  (2 bytes)
DATA_paleta_797B:
	defb 000h,008h	; 797b

; ----------------------------------------------------------------------
; DATOS paleta_797D: la paleta 4 de la imagen 7987: 2 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (2 bytes)
;   0x797d..0x797f  (2 bytes)
DATA_paleta_797D:
	defb 000h,00fh	; 797d

; ----------------------------------------------------------------------
; DATOS paleta_797F: la paleta 5 de la imagen 79A0: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (4 bytes)
;   0x797f..0x7983  (4 bytes)
DATA_paleta_797F:
	defb 004h,00eh,008h,00fh	; 797f

; ----------------------------------------------------------------------
; DATOS paleta_7983: la paleta 6 de la imagen 79B3: 4 bytes de colores que se
;   copian a 0xE800 (p00:592F); lo leen p00:57D6 (4 bytes)
;   0x7983..0x7987  (4 bytes)
DATA_paleta_7983:
	defb 000h,00ah,00bh,00dh	; 7983

; ----------------------------------------------------------------------
; DATOS imagen_7987: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:57D6 (25 bytes)
;   0x7987..0x79a0  (25 bytes)
DATA_imagen_7987:
	defb 004h,000h,001h,016h,0d9h,079h	; 7987
	defb 002h,001h,017h,006h,0e9h,07bh	; 798d
	defb 000h,002h,01dh,001h,049h,07ch	; 7993
	defb 000h,004h,000h,001h,049h,07ch	; 7999
	defb 0ffh	; 799f

; ----------------------------------------------------------------------
; DATOS imagen_79A0: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:57D6 (19 bytes)
;   0x79a0..0x79b3  (19 bytes)
DATA_imagen_79A0:
	defb 000h,003h,01eh,001h,049h,07ch	; 79a0
	defb 000h,004h,01fh,001h,049h,07ch	; 79a6
	defb 002h,005h,020h,008h,051h,07ch	; 79ac
	defb 0ffh	; 79b2

; ----------------------------------------------------------------------
; DATOS imagen_79B3: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:57D6 (25 bytes)
;   0x79b3..0x79cc  (25 bytes)
DATA_imagen_79B3:
	defb 000h,004h,01fh,001h,049h,07ch	; 79b3
	defb 004h,000h,028h,017h,0d1h,07ch	; 79b9
	defb 002h,006h,03fh,002h,0f9h,07eh	; 79bf
	defb 002h,005h,04bh,008h,0b9h,07fh	; 79c5
	defb 0ffh	; 79cb

; ----------------------------------------------------------------------
; DATOS imagen_79CC: lista de la imagen de p00:5911: entradas de 6 bytes
;   (formato, numero de paleta, tile destino, cuantos tiles, puntero a sus
;   dibujos) y 0xFF; lo leen p00:57D6 (13 bytes)
;   0x79cc..0x79d9  (13 bytes)
DATA_imagen_79CC:
	defb 000h,004h,01fh,001h,049h,07ch	; 79cc
	defb 002h,005h,041h,00ah,019h,07fh	; 79d2
	defb 0ffh	; 79d8

; ----------------------------------------------------------------------
; DATOS tiles_79D9: los dibujos de 22 tiles de una entrada de la imagen 7987
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:57D6 (528 bytes)
;   0x79d9..0x7be9  (528 bytes)
DATA_tiles_79D9:
	defb 000h,000h,000h,001h,000h,000h,001h,000h,002h,000h,001h,002h,000h,001h,00eh,00fh,007h,010h,00fh,011h,020h,009h,016h,020h	; 79d9  .................... ..
	defb 000h,000h,000h,080h,000h,000h,080h,000h,000h,080h,000h,000h,000h,000h,0f0h,0f0h,070h,008h,0f8h,018h,004h,098h,068h,004h	; 79f1  ................p.....h.
	defb 00dh,016h,020h,007h,018h,020h,000h,00fh,010h,000h,000h,00fh,000h,001h,006h,001h,000h,002h,000h,000h,003h,000h,000h,001h	; 7a09  .. .. ..................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,003h,000h,007h,004h,000h,00eh,001h,000h,006h,00ah,011h	; 7a21  ........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,0ffh	; 7a39  ........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,0c0h,000h,0e0h,020h,000h,070h,090h,000h,030h,050h,080h	; 7a51  ................ .p..0P.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,005h,000h,0fbh,0fdh,000h,0fbh,005h,000h,000h,0ffh,000h,000h,000h,0ffh	; 7a69  ........................
	defb 006h,00ah,011h,006h,00ah,011h,00eh,002h,011h,03eh,01ah,001h,01eh,020h,041h,004h,018h,063h,030h,010h,00fh,038h,058h,007h	; 7a81  .........>... A..c0..8X.
	defb 030h,050h,080h,030h,050h,080h,030h,050h,080h,03fh,04fh,080h,03fh,040h,080h,000h,03fh,0c0h,001h,000h,0feh,001h,002h,0fch	; 7a99  0P.0P.0P.?O.?@..?.......
	defb 006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,0feh,0e2h,001h,0feh,000h,001h,000h,0fch,003h,080h,080h,07fh,0c0h,0c0h,03fh	; 7ab1  .......................?
	defb 030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h	; 7ac9  0P.0P.0P.0P.0P.0P.0P.0P.
	defb 018h,060h,087h,000h,030h,0cfh,01ch,00ch,063h,01eh,026h,001h,00eh,032h,041h,006h,00ah,071h,006h,00ah,011h,006h,00ah,011h	; 7ae1  .`..0...c.&..2A..q......
	defb 000h,003h,0fch,000h,001h,0feh,03fh,03fh,0c0h,07fh,040h,080h,070h,00fh,080h,020h,050h,08fh,020h,050h,080h,030h,040h,080h	; 7af9  ......??..@.p.. P. P.0@.
	defb 0c0h,000h,03fh,000h,080h,07fh,0fch,0fch,003h,0feh,002h,001h,00eh,0f2h,001h,006h,00ah,0f1h,006h,00ah,011h,006h,00ah,011h	; 7b11  ..?.....................
	defb 006h,00ah,011h,007h,009h,010h,003h,004h,018h,000h,003h,00ch,000h,000h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7b29  ........................
	defb 000h,000h,0ffh,0ffh,0ffh,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7b41  ........................
	defb 030h,040h,080h,0f0h,010h,000h,0e0h,020h,000h,040h,080h,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7b59  0@..... .@..............
	defb 030h,050h,080h,0f0h,010h,000h,0e0h,000h,000h,000h,0c0h,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7b71  0P......................
	defb 006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h	; 7b89  ........................
	defb 030h,050h,080h,030h,050h,080h,030h,050h,080h,03ch,04ch,080h,03ch,040h,080h,000h,038h,0c0h,00ch,004h,0f0h,00eh,016h,0e0h	; 7ba1  0P.0P.0P.<L.<@..8.......
	defb 006h,018h,0e0h,000h,00ch,0f0h,038h,038h,0c4h,07ch,044h,080h,064h,018h,080h,020h,050h,088h,030h,040h,080h,030h,040h,080h	; 7bb9  ......88.|D.d.. P.0@.0@.
	defb 0d8h,068h,004h,078h,080h,004h,000h,0f0h,008h,000h,000h,0f0h,000h,080h,040h,080h,000h,000h,000h,080h,000h,000h,000h,000h	; 7bd1  .h.x..........@.........

; ----------------------------------------------------------------------
; DATOS tiles_7BE9: los dibujos de 6 tiles de una entrada de la imagen 7987 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:57D6 (96 bytes)
;   0x7be9..0x7c49  (96 bytes)
DATA_tiles_7BE9:
	defb 000h,0ffh,000h,000h,03fh,000h,03fh,03fh,0bfh,03fh,0bfh,03fh,03fh,0bfh,03fh,0bfh	; 7be9  ....?.??.?.??.?.
	defb 000h,0ffh,000h,000h,0ffh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bf9  ................
	defb 000h,0ffh,000h,000h,0fch,000h,0fch,0fch,0fch,0fch,0ffh,0fdh,0ffh,0feh,0ffh,0feh	; 7c09  ................
	defb 03fh,0bfh,03fh,03fh,0bfh,0bfh,0bfh,03fh,000h,03fh,000h,000h,0ffh,000h,0ffh,0ffh	; 7c19  ?.??...?.?......
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,0ffh,000h,000h,0ffh,000h,0ffh,0ffh	; 7c29  ................
	defb 0ffh,0feh,0ffh,0feh,0ffh,0fdh,0ffh,0fch,000h,0fch,000h,000h,0ffh,000h,0ffh,0ffh	; 7c39  ................

; ----------------------------------------------------------------------
; DATOS tiles_7C49: los dibujos de 1 tiles de una entrada de la imagen 7987 de
;   p00:5911: 8 por tile, tiles de 1 bits por punto (p00:5949); lo leen
;   p00:57D6 (8 bytes)
;   0x7c49..0x7c51  (8 bytes)
DATA_tiles_7C49:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c49  ........

; ----------------------------------------------------------------------
; DATOS tiles_7C51: los dibujos de 8 tiles de una entrada de la imagen 79A0 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:57D6 (128 bytes)
;   0x7c51..0x7cd1  (128 bytes)
DATA_tiles_7C51:
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,003h,0fch,003h,0f8h,002h,0f8h	; 7c51  ................
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,0ffh,000h,000h,000h,0ffh,0ffh	; 7c61  ................
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,0c0h,03fh,060h,01fh,020h,01fh	; 7c71  ...........?`. .
	defb 003h,0f9h,003h,0f9h,003h,0f9h,003h,0f9h,003h,0f9h,003h,0f9h,003h,0f9h,003h,0f9h	; 7c81  ................
	defb 0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,09fh	; 7c91  ................
	defb 003h,0f8h,001h,0f8h,000h,0fch,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 7ca1  ................
	defb 0ffh,0ffh,0ffh,000h,000h,000h,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 7cb1  ................
	defb 060h,01fh,0e0h,01fh,000h,03fh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh	; 7cc1  `....?..........

; ----------------------------------------------------------------------
; DATOS tiles_7CD1: los dibujos de 23 tiles de una entrada de la imagen 79B3
;   de p00:5911: 24 por tile, tiles de 3 bits por punto (p00:5949); lo leen
;   p00:57D6 (552 bytes)
;   0x7cd1..0x7ef9  (552 bytes)
DATA_tiles_7CD1:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,003h,000h,007h,004h,000h,00eh,001h,000h,006h,00ah,011h	; 7cd1  ........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,0ffh	; 7ce9  ........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,0c0h,000h,0e0h,020h,000h,070h,090h,000h,030h,050h,080h	; 7d01  ................ .p..0P.
	defb 006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h,006h,00ah,011h	; 7d19  ........................
	defb 030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h,030h,050h,080h	; 7d31  0P.0P.0P.0P.0P.0P.0P.0P.
	defb 006h,00ah,011h,007h,009h,010h,003h,004h,018h,000h,003h,00ch,000h,000h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7d49  ........................
	defb 000h,000h,0ffh,0ffh,0ffh,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7d61  ........................
	defb 030h,050h,080h,0f0h,010h,000h,0e0h,000h,000h,000h,0c0h,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7d79  0P......................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,01fh,00fh,000h,00fh,010h,020h,00fh,010h,020h,00fh,010h,020h	; 7d91  ................. .. ..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,083h,083h,000h,087h,084h,000h,08eh,081h,000h,086h,088h,011h	; 7da9  ........................
	defb 00fh,010h,020h,000h,01fh,020h,000h,000h,03fh,000h,000h,000h,003h,003h,000h,007h,004h,000h,00eh,001h,000h,006h,00ah,011h	; 7dc1  .. .. ..?...............
	defb 086h,088h,011h,086h,00ah,011h,006h,00ah,011h,006h,00ah,011h,0feh,0c2h,001h,0fch,004h,003h,008h,0f0h,007h,000h,000h,0ffh	; 7dd9  ........................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0c3h,0c1h,000h,0e1h,022h,004h,071h,092h,004h,031h,052h,084h	; 7df1  ................".q..1R.
	defb 031h,052h,084h,030h,053h,084h,030h,050h,087h,030h,050h,080h,03fh,04fh,080h,01fh,020h,0c0h,000h,01fh,0e0h,000h,000h,0ffh	; 7e09  1R.0S.0P.0P.?O.. .......
	defb 0f0h,010h,000h,010h,0e0h,000h,000h,000h,0e0h,000h,000h,000h,0c0h,0c0h,000h,0e0h,020h,000h,070h,090h,000h,030h,050h,080h	; 7e21  ................ .p..0P.
	defb 006h,00ah,011h,007h,009h,010h,003h,004h,018h,000h,003h,00ch,000h,000h,007h,000h,000h,000h,000h,000h,000h,01fh,00fh,000h	; 7e39  ........................
	defb 000h,000h,0ffh,0f8h,0f8h,007h,0fch,004h,003h,006h,0fah,001h,006h,00ah,0f1h,006h,00ah,011h,006h,00ah,011h,086h,08ah,011h	; 7e51  ........................
	defb 00fh,010h,020h,00fh,010h,020h,00fh,010h,020h,00fh,010h,020h,000h,01fh,020h,000h,000h,03fh,000h,000h,000h,000h,000h,000h	; 7e69  .. .. .. .. .. ..?......
	defb 086h,08ah,011h,087h,089h,010h,083h,084h,018h,080h,083h,00ch,080h,000h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7e81  ........................
	defb 000h,000h,0ffh,01fh,01fh,0e0h,03fh,000h,0c0h,030h,04fh,080h,030h,040h,08fh,030h,040h,080h,030h,050h,080h,033h,051h,080h	; 7e99  ......?..0O.0@.0@.0P.3Q.
	defb 030h,050h,080h,0f0h,010h,000h,0e0h,000h,000h,000h,0c0h,000h,000h,000h,080h,000h,000h,000h,000h,000h,000h,0f0h,0f0h,000h	; 7eb1  0P......................
	defb 031h,052h,084h,0f1h,012h,004h,0e1h,002h,004h,001h,0c2h,004h,000h,003h,084h,000h,000h,007h,000h,000h,000h,000h,000h,000h	; 7ec9  1R......................
	defb 0f0h,010h,000h,0f0h,010h,000h,0f0h,010h,000h,0f0h,010h,000h,010h,0e0h,000h,000h,000h,0e0h,000h,000h,000h,000h,000h,000h	; 7ee1  ........................

; ----------------------------------------------------------------------
; DATOS tiles_7EF9: los dibujos de 2 tiles de una entrada de la imagen 79B3 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:57D6 (32 bytes)
;   0x7ef9..0x7f19  (32 bytes)
DATA_tiles_7EF9:
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h	; 7ef9  ................
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,0f0h,01fh,0f0h,01fh,0f0h,01fh,0f0h	; 7f09  ................

; ----------------------------------------------------------------------
; DATOS tiles_7F19: los dibujos de 10 tiles de una entrada de la imagen 79CC
;   de p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949); lo leen
;   p00:57D6 (160 bytes)
;   0x7f19..0x7fb9  (160 bytes)
DATA_tiles_7F19:
	defb 0efh,0e7h,0efh,0e7h,0efh,0e7h,0efh,0e7h,0efh,0e7h,0efh,0e7h,0efh,0e7h,0efh,0e7h	; 7f19  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f29  ................
	defb 0efh,0e7h,0efh,0e7h,0efh,0e7h,0ffh,000h,008h,000h,0efh,0e7h,0efh,0e7h,0efh,0e7h	; 7f39  ................
	defb 003h,0f9h,003h,0f9h,003h,0f9h,003h,0f8h,002h,0f8h,003h,0f9h,003h,0f9h,003h,0f9h	; 7f49  ................
	defb 0a0h,09fh,0a0h,09fh,0a0h,09fh,0a0h,01fh,020h,01fh,0a0h,09fh,0a0h,09fh,0a0h,09fh	; 7f59  ........ .......
	defb 000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0ffh,0ffh,000h,000h,000h,0efh,0e7h	; 7f69  ................
	defb 0efh,0e7h,0efh,0e7h,0efh,0e7h,0ffh,000h,000h,000h,000h,0ffh,000h,0ffh,000h,0ffh	; 7f79  ................
	defb 003h,0f9h,003h,0f9h,003h,0f8h,001h,0f8h,000h,0fch,000h,0ffh,000h,0ffh,000h,0ffh	; 7f89  ................
	defb 0a0h,09fh,0a0h,09fh,060h,01fh,0e0h,01fh,000h,03fh,000h,0ffh,000h,0ffh,000h,0ffh	; 7f99  ....`....?......
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,0ffh,000h,0ffh,000h,0ffh	; 7fa9  ................

; ----------------------------------------------------------------------
; DATOS tiles_7FB9: los dibujos de 8 tiles de una entrada de la imagen 79B3 de
;   p00:5911: 16 por tile, tiles de 2 bits por punto (p00:5949) (sigue en el
;   banco 8, en 0x8000); lo leen p00:57D6 (71 bytes)
;   0x7fb9..0x8000  (71 bytes)
DATA_tiles_7FB9:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0fbh,0f8h,0fah,0f8h	; 7fb9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,0ffh,0ffh	; 7fc9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,03fh,07fh,01fh,03fh,01fh	; 7fd9  ...........?..?.
	defb 0fbh,0f9h,0fbh,0f9h,0fbh,0f9h,0fbh,0f9h,0fbh,0f9h,0fbh,0f9h,0fbh,0f9h,0fbh,0f9h	; 7fe9  ................
	defb 0bfh,09fh,0bfh,09fh,0bfh,09fh,0bfh	; 7ff9
