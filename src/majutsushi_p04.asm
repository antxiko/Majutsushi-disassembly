; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 04 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa0f1  (241 bytes)
; ======================================================================


L_A000:
	ld a,(0c0b1h)		;a000   ; yaku 0x20 (limite, 0x81): cuatro tripletes cerrados (suuankou) con la espera distinta de la pareja; medido con tools/prueba_yaku.py
	cp 002h		;a003
	ret z			;a005
	call 06fd7h		;a006   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a009
	call 06fdch		;a00a   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a00d
	cp 004h		;a00e
	ret nz			;a010
	ld hl,0cd95h		;a011   ; apunta a los grupos de la mano (4)
	ld b,004h		;a014
L_A016:
	ld a,(hl)			;a016
	and 0c0h		;a017
	ret nz			;a019
	inc hl			;a01a
	djnz L_A016		;a01b
	ld a,(0c209h)		;a01d   ; lee la ficha robada o tirada
	ld b,a			;a020
	ld a,(0cd40h)		;a021   ; lee la pareja de la mano
	cp b			;a024
	ret z			;a025
	ld c,020h		;a026
	call anota_yaku		;a028   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a02b
L_A02C:
	call 06fd7h		;a02c   ; yaku 0x22 (limite): los tres dragones en tripletes (daisangen)
	ld e,a			;a02f
	call 06fdch		;a030   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a033
	cp 003h		;a034
	ret c			;a036
	ld c,035h		;a037
	call L_A04D		;a039   ; busca en los cuatro grupos de 0xCD95 el codigo C: Z si esta
	ret nz			;a03c
	inc c			;a03d
	call L_A04D		;a03e   ; busca en los cuatro grupos de 0xCD95 el codigo C: Z si esta
	ret nz			;a041
	inc c			;a042
	call L_A04D		;a043   ; busca en los cuatro grupos de 0xCD95 el codigo C: Z si esta
	ret nz			;a046
	ld c,022h		;a047
	call anota_yaku		;a049   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a04c
L_A04D:
	ld hl,0cd95h		;a04d   ; busca en los cuatro grupos de 0xCD95 el codigo C: Z si esta
	ld b,004h		;a050
L_A052:
	ld a,(hl)			;a052   ; busca el codigo C entre los cuatro grupos de 0xCD95 (sin los bits 6-7)
	and 03fh		;a053
	cp c			;a055
	ret z			;a056
	inc hl			;a057
	djnz L_A052		;a058
	or 001h		;a05a   ; no esta: pone NZ
	ret			;a05c
L_A05D:
	ld a,(0cd40h)		;a05d   ; yaku 0x23 (limite): pareja de viento y tres tripletes de viento (shousuushii)
	sub 031h		;a060
	cp 004h		;a062
	ret nc			;a064
	call 06fd7h		;a065   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a068
	call 06fdch		;a069   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a06c
	cp 003h		;a06d
	ret c			;a06f
	ld a,(0cd40h)		;a070   ; lee la pareja de la mano
	ld d,a			;a073
	ld bc,00431h		;a074
L_A077:
	ld a,c			;a077
	cp d			;a078
	jr z,L_A081		;a079
	push bc			;a07b
	call L_A04D		;a07c   ; busca en los cuatro grupos de 0xCD95 el codigo C: Z si esta
	pop bc			;a07f
	ret nz			;a080
L_A081:
	inc c			;a081
	djnz L_A077		;a082
	ld c,023h		;a084
	call anota_yaku		;a086   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a089
L_A08A:
	ld a,(0cd40h)		;a08a   ; yaku 0x24 (limite): todo honores (tsuuiisou)
	cp 031h		;a08d
	ret c			;a08f
	call 06fd7h		;a090   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a093
	call 06fdch		;a094   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a097
	cp 004h		;a098
	ret c			;a09a
	ld hl,0cd95h		;a09b   ; apunta a los grupos de la mano (4)
	ld b,004h		;a09e
L_A0A0:
	ld a,(hl)			;a0a0   ; todos los grupos deben ser de honor (a partir de 0x31)
	and 03fh		;a0a1
	cp 031h		;a0a3
	ret c			;a0a5
	inc hl			;a0a6
	djnz L_A0A0		;a0a7
	ld c,024h		;a0a9   ; lo son: yaku 0x24
anota_yaku:		; anota el yaku C con valor B en 0xC2E0
	ld b,081h		;a0ab   ; ANOTA UN YAKU: C = su codigo y B = su valor (0x81 y 0x82 son limites) en la primera casilla libre de 0xC2E0; 0xCD00 = 1 si es limite
	jr L_A0B1		;a0ad
L_A0AF:
	ld b,082h		;a0af
L_A0B1:
	ld hl,0c2e0h		;a0b1   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
L_A0B4:
	ld a,(hl)			;a0b4   ; busca la primera casilla libre de la lista de yaku
	and a			;a0b5
	jr z,L_A0BC		;a0b6
	inc hl			;a0b8
	inc hl			;a0b9
	jr L_A0B4		;a0ba
L_A0BC:
	ld (hl),c			;a0bc
	inc hl			;a0bd
	ld (hl),b			;a0be
	ld a,001h		;a0bf
	ld (0cd00h),a		;a0c1   ; guarda 1 si la mano es de limite
	ret			;a0c4
L_A0C5:
	ld a,(0cd40h)		;a0c5   ; yaku 0x25 (limite): todo terminales 1 y 9 (chinroutou)
	cp 031h		;a0c8
	ret nc			;a0ca
	call 06fd7h		;a0cb   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a0ce
	call 06fdch		;a0cf   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a0d2
	cp 004h		;a0d3
	ret c			;a0d5
	ld hl,0cd95h		;a0d6   ; apunta a los grupos de la mano (4)
	ld b,004h		;a0d9
L_A0DB:
	ld a,(hl)			;a0db   ; cada grupo debe ser de numero 1 o 9: si no, no hay yaku
	and 03fh		;a0dc
	cp 031h		;a0de
	ret nc			;a0e0
	and 00fh		;a0e1
	sub 002h		;a0e3   ; resta 2 y compara con 7: los numeros de 2 a 8 lo anulan
	cp 007h		;a0e5
	ret c			;a0e7
	inc hl			;a0e8
	djnz L_A0DB		;a0e9
	ld c,025h		;a0eb   ; todos cumplen: yaku 0x25
	call anota_yaku		;a0ed   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a0f0

; ----------------------------------------------------------------------
; DATOS terminales: siete bytes: 6 y los seis numeros 1 y 9 de cada palo
;   (0x01, 0x09, 0x11, 0x19, 0x21, 0x29): ninguna instruccion trazada los
;   apunta (p04:A0F8 empieza justo detras y usa 0xA151); no se ha medido que
;   los lea nadie
;   0xa0f1..0xa0f8  (7 bytes)
DATA_terminales:
	defb 006h,001h,009h,011h,019h,021h,029h	; a0f1

; ======================================================================
; CODIGO 0xa0f8..0xa151  (89 bytes)
; ======================================================================


L_A0F8:
	xor a			;a0f8   ; yaku 0x26 (limite): todo verde (ryuuiisou): bambu 2, 3, 4, 6, 8 y el dragon verde (lista 0xA151)
	ld (0cc80h),a		;a0f9
	ld hl,0a151h		;a0fc
	ld a,(0cd40h)		;a0ff   ; lee la pareja de la mano
	ld b,006h		;a102
L_A104:
	cp (hl)			;a104
	jr z,L_A10B		;a105
	inc hl			;a107
	djnz L_A104		;a108
	ret			;a10a
L_A10B:
	cp 036h		;a10b
	jr nz,L_A114		;a10d
	ld a,001h		;a10f
	ld (0cc80h),a		;a111
L_A114:
	ld hl,0cd44h		;a114   ; apunta a las escaleras de la mano (4)
	ld b,004h		;a117
L_A119:
	ld a,(hl)			;a119   ; las parejas del jugador deben ser de dragon verde (0x22) o no tener
	and 03fh		;a11a
	jr z,L_A124		;a11c
	cp 022h		;a11e
	ret nz			;a120
	inc hl			;a121
	djnz L_A119		;a122
L_A124:
	ld de,0cd95h		;a124   ; apunta a los grupos de la mano (4)
	ld b,004h		;a127
L_A129:
	ld a,(de)			;a129
	and 03fh		;a12a
	jr z,L_A13B		;a12c
	ld hl,0a151h		;a12e
	ld c,006h		;a131
L_A133:
	cp (hl)			;a133   ; busca la ficha en la lista de las seis verdes
	jr z,L_A13B		;a134
	inc hl			;a136
	dec c			;a137
	jr nz,L_A133		;a138
	ret			;a13a
L_A13B:
	cp 036h		;a13b
	jr nz,L_A144		;a13d
	ld a,001h		;a13f
	ld (0cc80h),a		;a141
L_A144:
	inc de			;a144
	djnz L_A129		;a145
	ld a,(0cc80h)		;a147
	and a			;a14a
	ld c,026h		;a14b
	call nz,anota_yaku		;a14d   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a150

; ----------------------------------------------------------------------
; DATOS resto_A151: lo apuntan con el banco puesto p04:A0FC (0xA151), p04:A12E
;   (0xA151); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p04:A0FC, p04:A12E (6 bytes)
;   0xa151..0xa157  (6 bytes)
DATA_resto_A151:
	defb 022h,023h,024h,026h,028h,036h	; a151

; ======================================================================
; CODIGO 0xa157..0xa789  (1586 bytes)
; ======================================================================


L_A157:
	ld hl,(0cd5ch)		;a157   ; yaku 0x27 (limite): las nueve puertas (chuuren poutou)
	ld de,00040h		;a15a
	add hl,de			;a15d
	ld a,(hl)			;a15e
	and a			;a15f
	ret nz			;a160
	ld hl,0cd20h		;a161   ; apunta a las fichas distintas de la mano
	ld b,009h		;a164
	ld d,001h		;a166
L_A168:
	ld a,(hl)			;a168   ; recorre los nueve numeros del palo comprobando que hay al menos uno de cada
	and 00fh		;a169
	cp d			;a16b
	ret nz			;a16c
	inc hl			;a16d
	inc d			;a16e
	djnz L_A168		;a16f
	ld a,(0cd30h)		;a171   ; comprueba que el 1 y el 9 tienen tres
	cp 003h		;a174
	ret c			;a176
	ld a,(0cd38h)		;a177
	cp 003h		;a17a
	ret c			;a17c
	ld a,(0c209h)		;a17d   ; mira la ficha de espera: si es 1 o 9 espera con tres y si no con dos
	and 00fh		;a180
	dec a			;a182
	ld b,a			;a183
	dec a			;a184
	sub 007h		;a185
	ld d,002h		;a187
	jr c,L_A18D		;a189
	ld d,004h		;a18b
L_A18D:
	ld a,b			;a18d
	ld hl,0cd30h		;a18e   ; apunta a cuantas hay de cada una
	call 0405ch		;a191   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a194
	cp d			;a195
	ret z			;a196
	ld c,027h		;a197
	call anota_yaku		;a199   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a19c
L_A19D:
	ld hl,(0cd5ch)		;a19d   ; yaku 0x28 (limite): los trece huerfanos (kokushi musou)
	ld de,00040h		;a1a0
	add hl,de			;a1a3
	ld a,(hl)			;a1a4
	and a			;a1a5
	ret nz			;a1a6
	call 07064h		;a1a7   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	ret nz			;a1aa
	call L_A1B5		;a1ab   ; busca la ficha 0xC209 en 0xCD20 y deja Z si su cuenta (0xCD30) es 1
	ret nz			;a1ae
	ld c,028h		;a1af
	call anota_yaku		;a1b1   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a1b4
L_A1B5:
	ld hl,0cd20h		;a1b5   ; busca la ficha 0xC209 en 0xCD20 y deja Z si su cuenta (0xCD30) es 1
	ld de,0cd30h		;a1b8   ; apunta a cuantas hay de cada una
	ld a,(0c209h)		;a1bb   ; lee la ficha robada o tirada
L_A1BE:
	cp (hl)			;a1be
	jr z,L_A1C5		;a1bf
	inc de			;a1c1
	inc hl			;a1c2
	jr L_A1BE		;a1c3
L_A1C5:
	ld a,(de)			;a1c5
	dec a			;a1c6
	ret			;a1c7
L_A1C8:
	ld a,(0c0b1h)		;a1c8   ; yaku 0x29 (limite): el que reparte gana con su primera ficha (tenhou)
	dec a			;a1cb
	ret nz			;a1cc
	ld a,(0c1c1h)		;a1cd   ; lee cuantas fichas se han robado del muro
	cp 034h		;a1d0
	ret nz			;a1d2
	ld c,029h		;a1d3
	call anota_yaku		;a1d5   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a1d8
L_A1D9:
	ld a,(0c0b1h)		;a1d9   ; yaku 0x2A (limite): un jugador que no reparte gana en su primer robo (chiihou)
	dec a			;a1dc
	ret nz			;a1dd
	ld a,(0c1c1h)		;a1de   ; lee cuantas fichas se han robado del muro
	sub 035h		;a1e1
	cp 003h		;a1e3
	ret nc			;a1e5
	call 07144h		;a1e6   ; mira_manos_con_grupos: 0xCD01 = 1 si algun jugador ha bajado grupos
	ld a,(0cd01h)		;a1e9   ; lee 1 si algun jugador ha bajado grupos
	and a			;a1ec
	ret nz			;a1ed
	ld c,02ah		;a1ee
	call anota_yaku		;a1f0   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a1f3
L_A1F4:
	ld a,(0c0b1h)		;a1f4   ; yaku 0x2B (limite): gana por ron antes de haber tirado nada (renhou); medido con prueba_yaku
	cp 002h		;a1f7
	ret nz			;a1f9
	ld hl,(0cd5ch)		;a1fa   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,0000fh		;a1fd
	add hl,de			;a200
	ld a,(hl)			;a201
	and a			;a202
	ret nz			;a203
	call 07144h		;a204   ; mira_manos_con_grupos: 0xCD01 = 1 si algun jugador ha bajado grupos
	ld a,(0cd01h)		;a207   ; lee 1 si algun jugador ha bajado grupos
	and a			;a20a
	ret nz			;a20b
	ld c,02bh		;a20c
	call anota_yaku		;a20e   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a211
L_A212:
	ld a,(0c025h)		;a212   ; yaku 0x2C (limite, con la opcion 0xC025): cuatro tripletes de numeros seguidos
	and a			;a215
	ret z			;a216
	call 06fd7h		;a217   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a21a
	call 06fdch		;a21b   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a21e
	cp 004h		;a21f
	ret c			;a221
	ld hl,0cd95h		;a222   ; apunta a los grupos de la mano (4)
	ld de,0cc80h		;a225
	ld b,004h		;a228
L_A22A:
	ld a,(hl)			;a22a   ; copia las cuatro fichas de cuatro grupos de numeros a 0xCC80
	and 03fh		;a22b
	cp 031h		;a22d
	ret nc			;a22f
	ld (de),a			;a230
	inc de			;a231
	inc hl			;a232
	djnz L_A22A		;a233
	ld hl,0cc80h		;a235   ; las ordena
	ld a,004h		;a238
	call 07322h		;a23a
	ld hl,0cc80h		;a23d
	ld b,003h		;a240   ; mira que sean consecutivas (diferencia -1)
L_A242:
	ld a,(hl)			;a242
	inc hl			;a243
	sub (hl)			;a244
	inc a			;a245
	ret nz			;a246
	djnz L_A242		;a247
	ld c,02ch		;a249
	call anota_yaku		;a24b   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a24e
L_A24F:
	ld a,(0c026h)		;a24f   ; yaku 0x2D (limite, con la opcion 0xC026): siete parejas seguidas del mismo palo (2 a 8 o 1 a 7)
	and a			;a252
	ret z			;a253
	ld hl,(0cd5ch)		;a254   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a257
	add hl,de			;a25a
	ld a,(hl)			;a25b
	and a			;a25c
	ret nz			;a25d
	ld hl,0cd30h		;a25e   ; apunta a cuantas hay de cada una
	ld b,007h		;a261
L_A263:
	ld a,(hl)			;a263
	cp 002h		;a264
	ret nz			;a266
	inc hl			;a267
	djnz L_A263		;a268
	ld hl,0cd20h		;a26a   ; apunta a las fichas distintas de la mano
	ld b,007h		;a26d
	ld d,002h		;a26f
L_A271:
	ld a,(hl)			;a271
	and 00fh		;a272
	cp d			;a274
	ret nz			;a275
	inc hl			;a276
	inc d			;a277
	djnz L_A271		;a278
	ld c,02dh		;a27a
	call anota_yaku		;a27c   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	ret			;a27f
L_A280:
	call 06fd7h		;a280   ; yaku 0x30 (doble limite, 0x82): cuatro tripletes cerrados con espera de pareja (suuankou tanki); medido
	ld e,a			;a283
	call 06fdch		;a284   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a287
	cp 004h		;a288
	ret nz			;a28a
	ld hl,0cd95h		;a28b   ; apunta a los grupos de la mano (4)
	ld b,004h		;a28e
L_A290:
	ld a,(hl)			;a290
	and 0c0h		;a291
	ret nz			;a293
	inc hl			;a294
	djnz L_A290		;a295
	ld a,(0c209h)		;a297   ; lee la ficha robada o tirada
	ld b,a			;a29a
	ld a,(0cd40h)		;a29b   ; lee la pareja de la mano
	cp b			;a29e
	ret nz			;a29f
	ld c,030h		;a2a0
	call L_A0AF		;a2a2
	ret			;a2a5
L_A2A6:
	ld hl,(0cd5ch)		;a2a6   ; yaku 0x31 (doble limite): los trece huerfanos con espera de trece fichas
	ld de,00040h		;a2a9
	add hl,de			;a2ac
	ld a,(hl)			;a2ad
	and a			;a2ae
	ret nz			;a2af
	call 07064h		;a2b0   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	ret nz			;a2b3
	call L_A1B5		;a2b4   ; busca la ficha 0xC209 en 0xCD20 y deja Z si su cuenta (0xCD30) es 1
	ret z			;a2b7
	ld c,031h		;a2b8
	call L_A0AF		;a2ba
	ret			;a2bd
L_A2BE:
	call 06fd7h		;a2be   ; yaku 0x32 (doble limite): cuatro tripletes de viento (daisuushii)
	ld e,a			;a2c1
	call 06fdch		;a2c2   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a2c5
	cp 004h		;a2c6
	ret nz			;a2c8
	ld hl,0cd95h		;a2c9   ; apunta a los grupos de la mano (4)
	ld b,004h		;a2cc
L_A2CE:
	ld a,(hl)			;a2ce   ; mira que los cuatro grupos sean de viento (0x31-0x34)
	and 03fh		;a2cf
	sub 031h		;a2d1
	cp 004h		;a2d3
	ret nc			;a2d5
	inc hl			;a2d6
	djnz L_A2CE		;a2d7
	ld c,032h		;a2d9   ; yaku 0x32
	call L_A0AF		;a2db
	ret			;a2de
L_A2DF:
	ld hl,(0cd5ch)		;a2df   ; yaku 0x33 (doble limite): las nueve puertas con espera de nueve fichas
	ld de,00040h		;a2e2
	add hl,de			;a2e5
	ld a,(hl)			;a2e6
	and a			;a2e7
	ret nz			;a2e8
	ld hl,0cd20h		;a2e9   ; apunta a las fichas distintas de la mano
	ld b,009h		;a2ec
	ld d,001h		;a2ee
L_A2F0:
	ld a,(hl)			;a2f0   ; las nueve puertas dobles: cuenta de cada numero
	and 00fh		;a2f1
	cp d			;a2f3
	ret nz			;a2f4
	inc hl			;a2f5
	inc d			;a2f6
	djnz L_A2F0		;a2f7
	ld a,(0cd30h)		;a2f9   ; el 1 y el 9 con tres cada uno
	cp 003h		;a2fc
	ret c			;a2fe
	ld a,(0cd38h)		;a2ff
	cp 003h		;a302
	ret c			;a304
	ld a,(0c209h)		;a305   ; la ficha extra: si es 1 o 9 espera con tres y si no con dos
	and 00fh		;a308
	dec a			;a30a
	ld b,a			;a30b
	dec a			;a30c
	sub 007h		;a30d
	ld d,002h		;a30f
	jr c,L_A315		;a311
	ld d,004h		;a313
L_A315:
	ld a,b			;a315
	ld hl,0cd30h		;a316   ; apunta a cuantas hay de cada una
	call 0405ch		;a319   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a31c
	cp d			;a31d
	ret nz			;a31e
	ld c,033h		;a31f
	call L_A0AF		;a321
	ret			;a324
L_A325:
	ld a,(0cda1h)		;a325   ; yaku 0x01 (valor 1): riichi (+0x34 puesto y +0x35 sin poner)
	and a			;a328
	ret nz			;a329
	ld a,(0cd9bh)		;a32a
	and a			;a32d
	ret nz			;a32e
	ld hl,(0cd5ch)		;a32f   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00034h		;a332
	add hl,de			;a335
	ld a,(hl)			;a336
	and a			;a337
	ret z			;a338
	inc hl			;a339
	ld a,(hl)			;a33a
	and a			;a33b
	ret nz			;a33c
	ld b,001h		;a33d
	ld c,001h		;a33f
anota_yaku_valor:		; anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ld hl,0c2e0h		;a341   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
L_A344:
	ld a,(hl)			;a344   ; busca la primera casilla libre de la lista de yaku
	and a			;a345
	jr z,L_A34C		;a346
	inc hl			;a348
	inc hl			;a349
	jr L_A344		;a34a
L_A34C:
	ld (hl),c			;a34c
	inc hl			;a34d
	ld (hl),b			;a34e
	ret			;a34f
L_A350:
	ld a,(0cda1h)		;a350   ; yaku 0x02 (valor 2): riichi con ippatsu (gana a los 5 robos o menos)
	and a			;a353
	ret nz			;a354
	xor a			;a355
	ld (0cd9bh),a		;a356
	ld hl,(0cd5ch)		;a359   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00034h		;a35c
	add hl,de			;a35f
	ld a,(hl)			;a360
	and a			;a361
	ret z			;a362
	ld hl,(0cd5ch)		;a363   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00071h		;a366
	add hl,de			;a369
	ld a,(0c1c1h)		;a36a   ; lee cuantas fichas se han robado del muro
	sub (hl)			;a36d
	cp 005h		;a36e
	ret nc			;a370
	ld a,001h		;a371
	ld (0cd9bh),a		;a373
	ld b,002h		;a376
	ld c,002h		;a378
	call anota_yaku_valor		;a37a   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a37d
L_A37E:
	xor a			;a37e   ; yaku 0x1D (valor 3): doble riichi con ippatsu
	ld (0cda1h),a		;a37f
	ld (0cd9ch),a		;a382
	ld hl,(0cd5ch)		;a385   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00035h		;a388
	add hl,de			;a38b
	ld a,(hl)			;a38c
	and a			;a38d
	ret z			;a38e
	ld hl,(0cd5ch)		;a38f   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00071h		;a392
	add hl,de			;a395
	ld a,(0c1c1h)		;a396   ; lee cuantas fichas se han robado del muro
	sub (hl)			;a399
	cp 005h		;a39a
	ret nc			;a39c
	ld a,001h		;a39d
	ld (0cda1h),a		;a39f
	ld (0cd9ch),a		;a3a2
	ld b,003h		;a3a5
	ld c,01dh		;a3a7
	call anota_yaku_valor		;a3a9   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a3ac
L_A3AD:
	ld a,(0cd99h)		;a3ad   ; pinfu: sin siete parejas; cuenta de las manos
	and a			;a3b0
	ret nz			;a3b1
	xor a			;a3b2
	ld (0cd0eh),a		;a3b3
	ld a,(0c021h)		;a3b6   ; si la opcion 0xC021 es cero mira la bandera de 0xCD0F
	and a			;a3b9
	jr nz,L_A3C1		;a3ba
	ld a,(0cd0fh)		;a3bc
	and a			;a3bf
	ret nz			;a3c0
L_A3C1:
	ld hl,(0cd5ch)		;a3c1   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a3c4
	add hl,de			;a3c7
	ld a,(hl)			;a3c8
	and a			;a3c9
	ret nz			;a3ca
	call 06fc6h		;a3cb   ; cuenta_escaleras: cuenta las escaleras de la lista 0xCD44
	cp 004h		;a3ce
	ret c			;a3d0
	call 07035h		;a3d1   ; pon_vientos_propios: pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	ld hl,0cd90h		;a3d4   ; apunta a los honores que cuentan de yaku (5)
	ld a,(0cd40h)		;a3d7   ; lee la pareja de la mano
	ld b,005h		;a3da
L_A3DC:
	cp (hl)			;a3dc
	ret z			;a3dd
	inc hl			;a3de
	djnz L_A3DC		;a3df
	ld a,(0c209h)		;a3e1   ; lee la ficha robada o tirada
	ld d,a			;a3e4
	ld b,004h		;a3e5
	ld hl,0cd44h		;a3e7   ; apunta a las escaleras de la mano (4)
L_A3EA:
	ld a,(hl)			;a3ea   ; la espera no es por el centro: mira cada escalera
	cp d			;a3eb
	jr nz,L_A3F4		;a3ec
	and 00fh		;a3ee
	cp 007h		;a3f0
	jr nz,L_A404		;a3f2
L_A3F4:
	ld a,(hl)			;a3f4   ; si la ficha esta al extremo de la escalera hay espera por dos lados
	inc a			;a3f5
	inc a			;a3f6
	cp d			;a3f7
	jr nz,L_A400		;a3f8
	and 00fh		;a3fa
	cp 003h		;a3fc
	jr nz,L_A404		;a3fe
L_A400:
	inc hl			;a400
	djnz L_A3EA		;a401
	ret			;a403
L_A404:
	ld a,001h		;a404
	ld (0cd0eh),a		;a406
	ld b,001h		;a409
	ld c,003h		;a40b
	call anota_yaku_valor		;a40d   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a410
L_A411:
	xor a			;a411   ; yaku 0x04 (valor 1): robo con la mano cerrada (menzen tsumo); medido
	ld (0cd0fh),a		;a412
	ld a,(0c0b1h)		;a415   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;a418
	ret nz			;a419
	ld hl,(0cd5ch)		;a41a   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a41d
	add hl,de			;a420
	ld a,(hl)			;a421
	and a			;a422
	ret nz			;a423
	ld a,001h		;a424
	ld (0cd0fh),a		;a426
	ld b,001h		;a429
	ld c,004h		;a42b
	call anota_yaku_valor		;a42d   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a430
L_A431:
	ld a,(0c020h)		;a431   ; yaku 0x05 (valor 1): todo numeros de 2 a 8 (tanyao); medido
	and a			;a434
	jr nz,L_A441		;a435
	ld hl,(0cd5ch)		;a437   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a43a
	add hl,de			;a43d
	ld a,(hl)			;a43e
	and a			;a43f
	ret nz			;a440
L_A441:
	ld hl,0cd20h		;a441   ; apunta a las fichas distintas de la mano
L_A444:
	ld a,(hl)			;a444   ; recorre las fichas buscando un numero de 2 a 8
	and a			;a445
	jr z,L_A457		;a446
	and 03fh		;a448
	cp 031h		;a44a
	ret nc			;a44c   ; los honores no valen
	and 00fh		;a44d
	sub 002h		;a44f
	cp 007h		;a451
	ret nc			;a453
	inc hl			;a454   ; siguiente ficha
	jr L_A444		;a455
L_A457:
	ld b,001h		;a457
	ld c,005h		;a459
	call anota_yaku_valor		;a45b   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a45e
L_A45F:
	ld a,(0cd99h)		;a45f   ; yaku 0x06 (valor 1): dos escaleras iguales (iipeikou); medido
	and a			;a462
	ret nz			;a463
	ld a,(0cd9eh)		;a464
	and a			;a467
	ret nz			;a468
	ld hl,(0cd5ch)		;a469   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a46c
	add hl,de			;a46f
	ld a,(hl)			;a470
	and a			;a471
	ret nz			;a472
	ld hl,0cd44h		;a473   ; apunta a las escaleras de la mano (4)
	ld b,003h		;a476
L_A478:
	ld a,(hl)			;a478   ; busca dos escaleras iguales seguidas
	and a			;a479
	ret z			;a47a
	inc hl			;a47b
	cp (hl)			;a47c
	jr z,L_A482		;a47d
	djnz L_A478		;a47f
	ret			;a481
L_A482:
	ld b,001h		;a482
	ld c,006h		;a484
	call anota_yaku_valor		;a486   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a489
L_A48A:
	ld a,(0cd99h)		;a48a   ; yaku 0x07: tripletes de honor que cuentan (yakuhai): su valor es cuantos; medido
	and a			;a48d
	ret nz			;a48e
	call 07035h		;a48f   ; pon_vientos_propios: pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	call L_A49F		;a492
	ex af,af'			;a495
	and a			;a496
	ret z			;a497
	ld b,a			;a498
	ld c,007h		;a499
	call anota_yaku_valor		;a49b   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a49e
L_A49F:
	ld de,0cd95h		;a49f   ; apunta a los grupos de la mano (4)
	ld b,004h		;a4a2
	ex af,af'			;a4a4
	xor a			;a4a5
	ex af,af'			;a4a6
L_A4A7:
	ld a,(de)			;a4a7
	and 03fh		;a4a8
	ret z			;a4aa
	ld hl,0cd90h		;a4ab   ; apunta a los honores que cuentan de yaku (5)
	ld c,005h		;a4ae
L_A4B0:
	cp (hl)			;a4b0
	jr nz,L_A4B6		;a4b1
	ex af,af'			;a4b3
	inc a			;a4b4
	ex af,af'			;a4b5
L_A4B6:
	inc hl			;a4b6   ; siguiente casilla
	dec c			;a4b7
	jr nz,L_A4B0		;a4b8
	inc de			;a4ba
	djnz L_A4A7		;a4bb
	ret			;a4bd
L_A4BE:
	ld a,(0c0b1h)		;a4be   ; yaku 0x08 (valor 1): ganar con la ficha de despues de un kan (rinshan kaihou)
	dec a			;a4c1
	ret nz			;a4c2
	ld a,(0cd0ch)		;a4c3   ; lee 1 si se gana con la ficha de un kan
	and a			;a4c6
	ret z			;a4c7
	ld b,001h		;a4c8
	ld c,008h		;a4ca
	call anota_yaku_valor		;a4cc   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a4cf
L_A4D0:
	ld a,(0c0b1h)		;a4d0   ; yaku 0x09 (valor 1): robar la ultima ficha del muro (haitei)
	dec a			;a4d3
	ret nz			;a4d4
	ld c,009h		;a4d5
L_A4D7:
	ld a,(0c1c1h)		;a4d7   ; lee cuantas fichas se han robado del muro
	ld hl,0c210h		;a4da   ; apunta a las fichas sacadas del final del muro (por kan)
	add a,(hl)			;a4dd
	cp 079h		;a4de
	ret nz			;a4e0
	ld b,001h		;a4e1
	call anota_yaku_valor		;a4e3   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a4e6
L_A4E7:
	ld a,(0c0b1h)		;a4e7   ; yaku 0x0A (valor 1): ganar con la ultima ficha tirada (houtei)
	cp 002h		;a4ea
	ret nz			;a4ec
	ld c,00ah		;a4ed
	call L_A4D7		;a4ef
	ret			;a4f2
L_A4F3:
	ld a,(0c0b1h)		;a4f3   ; yaku 0x0B (valor 1): ganar con la ficha de un kan de otro (chankan)
	cp 002h		;a4f6
	ret nz			;a4f8
	ld a,(0cd0dh)		;a4f9   ; lee 1 si se gana con la ficha del kan de otro
	and a			;a4fc
	ret z			;a4fd
	ld b,001h		;a4fe
	ld c,00bh		;a500
	call anota_yaku_valor		;a502   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a505
L_A506:
	ld a,(0cda1h)		;a506   ; yaku 0x0C (valor 2): doble riichi
	and a			;a509
	ret nz			;a50a
	xor a			;a50b
	ld (0cd9ch),a		;a50c
	ld hl,(0cd5ch)		;a50f   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00035h		;a512
	add hl,de			;a515
	ld a,(hl)			;a516
	and a			;a517
	ret z			;a518
	ld a,001h		;a519
	ld (0cd9ch),a		;a51b
	ld b,002h		;a51e
	ld c,00ch		;a520
	call anota_yaku_valor		;a522   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a525
L_A526:
	ld a,(0cd99h)		;a526   ; yaku 0x0E (valor 2): cuatro tripletes (toitoi)
	and a			;a529
	ret nz			;a52a
	call 06fd7h		;a52b   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a52e
	call 06fdch		;a52f   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a532
	cp 004h		;a533
	ret c			;a535
	ld b,002h		;a536
	ld c,00eh		;a538
	call anota_yaku_valor		;a53a   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a53d
L_A53E:
	xor a			;a53e   ; yaku 0x0F (valor 2): dos pares de escaleras iguales (ryanpeikou)
	ld (0cd9eh),a		;a53f
	ld hl,(0cd5ch)		;a542   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a545
	add hl,de			;a548
	ld a,(hl)			;a549
	and a			;a54a
	ret nz			;a54b
	call L_A55D		;a54c   ; Z si las cuatro escaleras de 0xCD44 forman dos pares iguales
	ret nz			;a54f
	ld b,002h		;a550
	ld c,00fh		;a552
	call anota_yaku_valor		;a554   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ld a,001h		;a557
	ld (0cd9eh),a		;a559
	ret			;a55c
L_A55D:
	call 06fc6h		;a55d   ; Z si las cuatro escaleras de 0xCD44 forman dos pares iguales
	cp 004h		;a560
	ret nz			;a562
	ld hl,0cd44h		;a563   ; apunta a las escaleras de la mano (4)
	ld a,(hl)			;a566
	inc hl			;a567
	cp (hl)			;a568
	ret nz			;a569
	inc hl			;a56a
	ld a,(hl)			;a56b
	inc hl			;a56c
	cp (hl)			;a56d
	ret			;a56e
L_A56F:
	ld a,(0cd99h)		;a56f   ; yaku 0x10: escalera 123-456-789 de un palo (ittsu); medido, valor 2 cerrada y 1 abierta
	and a			;a572
	ret nz			;a573
	call 06fc6h		;a574   ; cuenta_escaleras: cuenta las escaleras de la lista 0xCD44
	cp 003h		;a577
	ret c			;a579
	ld hl,0cd44h		;a57a   ; apunta a las escaleras de la mano (4)
	ld b,004h		;a57d
L_A57F:
	ld a,(hl)			;a57f
	and 00fh		;a580
	dec a			;a582
	jr nz,L_A58E		;a583
	push bc			;a585
	push hl			;a586
	call L_A5A6		;a587   ; mira si hay en la lista de escaleras las que empiezan en +3 y +6 de la primera
	pop hl			;a58a
	pop bc			;a58b
	jr z,L_A592		;a58c
L_A58E:
	inc hl			;a58e
	djnz L_A57F		;a58f
	ret			;a591
L_A592:
	ld c,010h		;a592
L_A594:
	ld hl,(0cd5ch)		;a594   ; anota el yaku C con valor 2 si la mano es cerrada (+0x40 a cero) y 1 si no
	ld de,00040h		;a597
	add hl,de			;a59a
	ld a,(hl)			;a59b
	and a			;a59c
	ld b,002h		;a59d
	jr z,L_A5A2		;a59f
	dec b			;a5a1
L_A5A2:
	call anota_yaku_valor		;a5a2   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a5a5
L_A5A6:
	ld a,(hl)			;a5a6   ; mira si hay en la lista de escaleras las que empiezan en +3 y +6 de la primera
	and 03fh		;a5a7
	add a,003h		;a5a9
	ld d,a			;a5ab
	add a,003h		;a5ac
	ld e,a			;a5ae
	call L_A5B4		;a5af
	ret nz			;a5b2
	ld d,e			;a5b3
L_A5B4:
	ld hl,0cd44h		;a5b4   ; apunta a las escaleras de la mano (4)
	ld b,004h		;a5b7
L_A5B9:
	ld a,(hl)			;a5b9   ; busca la ficha D entre las escaleras
	and 03fh		;a5ba
	cp d			;a5bc
	ret z			;a5bd
	inc hl			;a5be
	djnz L_A5B9		;a5bf
	or 001h		;a5c1
	ret			;a5c3
L_A5C4:
	ld a,(0cd99h)		;a5c4   ; yaku 0x11: la misma escalera en los tres palos (sanshoku doujun); medido
	and a			;a5c7
	ret nz			;a5c8
	call 06fc6h		;a5c9   ; cuenta_escaleras: cuenta las escaleras de la lista 0xCD44
	cp 003h		;a5cc
	ret c			;a5ce
	ld hl,0cd44h		;a5cf   ; apunta a las escaleras de la mano (4)
	jr nz,L_A5DA		;a5d2
	ld a,(hl)			;a5d4
	and 00fh		;a5d5
	ld e,a			;a5d7
	jr L_A5F3		;a5d8
L_A5DA:
	ld a,(hl)			;a5da   ; mira si el numero se repite en tres de las escaleras
	and 00fh		;a5db
	ld e,a			;a5dd
	inc hl			;a5de
	ld a,(hl)			;a5df
	and 00fh		;a5e0
	cp e			;a5e2
	jr z,L_A5F3		;a5e3
	inc hl			;a5e5   ; segundo numero
	ld a,(hl)			;a5e6
	and 00fh		;a5e7
	cp e			;a5e9
	jr z,L_A5F3		;a5ea
	ld e,a			;a5ec   ; tercero
	dec hl			;a5ed
	ld a,(hl)			;a5ee
	and 00fh		;a5ef
	cp e			;a5f1
	ret nz			;a5f2
L_A5F3:
	call L_A5FD		;a5f3   ; cuenta en cuantos palos (0x10 de diferencia) esta la escalera de numero E en 0xCD44
	ret c			;a5f6
	ld c,011h		;a5f7
	call L_A594		;a5f9   ; anota el yaku C con valor 2 si la mano es cerrada (+0x40 a cero) y 1 si no
	ret			;a5fc
L_A5FD:
	ld d,000h		;a5fd   ; cuenta en cuantos palos (0x10 de diferencia) esta la escalera de numero E en 0xCD44
	ld b,003h		;a5ff
L_A601:
	ld hl,0cd44h		;a601   ; apunta a las escaleras de la mano (4)
	ld c,004h		;a604
L_A606:
	ld a,(hl)			;a606   ; busca el numero E en las escaleras
	and 03fh		;a607
	cp e			;a609
	jr z,L_A612		;a60a
	inc hl			;a60c
	dec c			;a60d
	jr nz,L_A606		;a60e
	jr L_A619		;a610
L_A612:
	inc d			;a612
	ld a,e			;a613
	add a,010h		;a614
	ld e,a			;a616
	djnz L_A601		;a617
L_A619:
	ld a,d			;a619
	cp 003h		;a61a
	ret			;a61c
L_A61D:
	ld a,(0cd99h)		;a61d   ; yaku 0x12: todos los grupos con un 1, un 9 o un honor (chanta); medido
	and a			;a620
	ret nz			;a621
	ld a,(0cd9fh)		;a622
	and a			;a625
	ret nz			;a626
	ld a,(0cd40h)		;a627   ; lee la pareja de la mano
	call L_A65B		;a62a   ; pone el acarreo si la ficha es de honor o 1 o 9; Z/NZ para 2-8
	ret c			;a62d
	ld hl,0cd95h		;a62e   ; apunta a los grupos de la mano (4)
	ld b,004h		;a631
L_A633:
	ld a,(hl)			;a633
	and 03fh		;a634
	jr z,L_A640		;a636
	call L_A65B		;a638   ; pone el acarreo si la ficha es de honor o 1 o 9; Z/NZ para 2-8
	ret c			;a63b
	inc hl			;a63c
	djnz L_A633		;a63d
	ret			;a63f
L_A640:
	ld hl,0cd44h		;a640   ; apunta a las escaleras de la mano (4)
	ld b,004h		;a643
L_A645:
	ld a,(hl)			;a645   ; mira que las escaleras de 0xCD44 empiecen por 1 o por 7
	and 03fh		;a646
	jr z,L_A655		;a648
	and 00fh		;a64a
	cp 007h		;a64c
	jr z,L_A652		;a64e
	dec a			;a650
	ret nz			;a651
L_A652:
	inc hl			;a652
	djnz L_A645		;a653
L_A655:
	ld c,012h		;a655
	call L_A594		;a657   ; anota el yaku C con valor 2 si la mano es cerrada (+0x40 a cero) y 1 si no
	ret			;a65a
L_A65B:
	cp 031h		;a65b   ; pone el acarreo si la ficha es de honor o 1 o 9; Z/NZ para 2-8
	ret nc			;a65d
L_A65E:
	and 00fh		;a65e
	sub 002h		;a660
	cp 007h		;a662
	ret			;a664
L_A665:
	ld a,(0cd99h)		;a665   ; yaku 0x13 (valor 2): tres tripletes cerrados (sanankou); medido
	and a			;a668
	ret nz			;a669
	call 06fd7h		;a66a   ; cuenta_tripletes: cuenta los tripletes de la lista 0xCD48
	ld e,a			;a66d
	call 06fdch		;a66e   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a671
	cp 003h		;a672
	ret c			;a674
	ld hl,0cd95h		;a675   ; apunta a los grupos de la mano (4)
	call L_A687		;a678
	ld a,d			;a67b
	cp 003h		;a67c
	ret c			;a67e
	ld b,002h		;a67f
	ld c,013h		;a681
	call anota_yaku_valor		;a683   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a686
L_A687:
	ld b,004h		;a687
	ld d,000h		;a689
	ld a,(0c209h)		;a68b   ; lee la ficha robada o tirada
	ld e,a			;a68e
L_A68F:
	ld a,(hl)			;a68f   ; cuenta los tripletes cerrados: sin los bits 6-7 y distintos de la ficha de ron
	and a			;a690
	jr z,L_A6A4		;a691
	and 0c0h		;a693
	jr nz,L_A6A4		;a695
	ld a,(hl)			;a697
	and 03fh		;a698
	cp e			;a69a
	jr nz,L_A6A3		;a69b
	ld a,(0c0b1h)		;a69d   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;a6a0
	jr nz,L_A6A4		;a6a1
L_A6A3:
	inc d			;a6a3
L_A6A4:
	inc hl			;a6a4
	djnz L_A68F		;a6a5
	ret			;a6a7
L_A6A8:
	ld a,(0cd99h)		;a6a8   ; yaku 0x14 (valor 2): tres kan (sankantsu)
	and a			;a6ab
	ret nz			;a6ac
	call 06fdch		;a6ad   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	cp 003h		;a6b0
	ret c			;a6b2
	ld b,002h		;a6b3
	ld c,014h		;a6b5
	call anota_yaku_valor		;a6b7   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a6ba
L_A6BB:
	ld a,(0cd99h)		;a6bb   ; yaku 0x15 (valor 2): tres tripletes de numeros seguidos (sanrenkou)
	and a			;a6be
	ret nz			;a6bf
	call L_A732		;a6c0   ; cuenta cuantos grupos de 0xCD95 son de numero (menos de 0x31) y deja sus valores en 0xCC80
	ret c			;a6c3
	push af			;a6c4
	ld hl,0cc80h		;a6c5
	ld a,004h		;a6c8
	call 07322h		;a6ca
	pop bc			;a6cd
	dec b			;a6ce
	ld hl,0cc80h		;a6cf
	ld d,000h		;a6d2
L_A6D4:
	ld a,(hl)			;a6d4   ; compara cada ficha con la siguiente: iguales menos uno
	inc hl			;a6d5
	sub (hl)			;a6d6
	inc a			;a6d7
	jr nz,L_A6E0		;a6d8
	inc d			;a6da
	ld a,d			;a6db
	cp 002h		;a6dc
	jr z,L_A6E3		;a6de
L_A6E0:
	djnz L_A6D4		;a6e0
	ret			;a6e2
L_A6E3:
	ld b,002h		;a6e3
	ld c,015h		;a6e5
	call anota_yaku_valor		;a6e7   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a6ea
L_A6EB:
	ld a,(0cd99h)		;a6eb   ; yaku 0x16 (valor 2): tres tripletes del mismo numero en tres palos (sanshoku doukou)
	and a			;a6ee
	ret nz			;a6ef
	call L_A732		;a6f0   ; cuenta cuantos grupos de 0xCD95 son de numero (menos de 0x31) y deja sus valores en 0xCC80
	ret c			;a6f3
	push af			;a6f4
	ld hl,0cc80h		;a6f5
	ld a,004h		;a6f8
	call 07322h		;a6fa
	ld hl,0cc90h		;a6fd
	ld de,0cc91h		;a700
	ld bc,0000fh		;a703
	ld (hl),000h		;a706
	ldir		;a708
	pop bc			;a70a
	ld de,0cc80h		;a70b
L_A70E:
	ld a,(de)			;a70e
	and 00fh		;a70f
	ld hl,0cc8fh		;a711
	call 0405ch		;a714   ; suma_a_hl: HL = HL + A
	inc (hl)			;a717
	inc de			;a718
	djnz L_A70E		;a719
	ld hl,0cc90h		;a71b
	ld bc,00901h		;a71e
L_A721:
	ld a,(hl)			;a721   ; mira si algun numero tiene tres tripletes
	cp 003h		;a722
	jr z,L_A72A		;a724
	inc hl			;a726
	djnz L_A721		;a727
	ret			;a729
L_A72A:
	ld b,002h		;a72a
	ld c,016h		;a72c
	call anota_yaku_valor		;a72e   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a731
L_A732:
	ld hl,0cd95h		;a732   ; cuenta cuantos grupos de 0xCD95 son de numero (menos de 0x31) y deja sus valores en 0xCC80
	ld de,0cc80h		;a735
	ld bc,00400h		;a738
L_A73B:
	ld a,(hl)			;a73b   ; recoge los grupos de numero
	and 03fh		;a73c
	jr z,L_A747		;a73e
	cp 031h		;a740
	jr nc,L_A747		;a742
	inc c			;a744
	jr L_A749		;a745
L_A747:
	ld a,0ffh		;a747
L_A749:
	ld (de),a			;a749   ; los guarda y cuenta los de numero
	inc de			;a74a
	inc hl			;a74b
	djnz L_A73B		;a74c
	ld a,c			;a74e
	cp 003h		;a74f
	ret			;a751
L_A752:
	ld a,(0cd99h)		;a752   ; yaku 0x17 (valor 2): dos dragones en tripletes y el tercero de pareja (shousangen)
	and a			;a755
	ret nz			;a756
	ld a,(0cd40h)		;a757   ; lee la pareja de la mano
	sub 035h		;a75a
	cp 003h		;a75c
	ret nc			;a75e
	ld hl,0a789h		;a75f
	call 0405ch		;a762   ; suma_a_hl: HL = HL + A
	ld d,(hl)			;a765
	inc hl			;a766
	ld e,(hl)			;a767
	call L_A779		;a768
	ret nz			;a76b
	ld d,e			;a76c
	call L_A779		;a76d
	ret nz			;a770
	ld b,002h		;a771
	ld c,017h		;a773
	call anota_yaku_valor		;a775   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a778
L_A779:
	ld hl,0cd95h		;a779   ; apunta a los grupos de la mano (4)
	ld b,004h		;a77c
L_A77E:
	ld a,(hl)			;a77e   ; busca la ficha D entre los grupos
	and 03fh		;a77f
	cp d			;a781
	ret z			;a782
	inc hl			;a783
	djnz L_A77E		;a784
	or 001h		;a786
	ret			;a788

; ----------------------------------------------------------------------
; DATOS resto_A789: lo apuntan con el banco puesto p04:A75F (0xA789); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:A75F (6 bytes)
;   0xa789..0xa78f  (6 bytes)
DATA_resto_A789:
	defb 036h,037h,035h,037h,035h,036h	; a789

; ======================================================================
; CODIGO 0xa78f..0xa93c  (429 bytes)
; ======================================================================


L_A78F:
	call 06fd7h		;a78f   ; yaku 0x18 (valor 2): todo terminales y honores (honroutou)
	ld e,a			;a792
	call 06fdch		;a793   ; cuenta_kan: cuenta los kan de la lista 0xCD4C
	add a,e			;a796
	cp 004h		;a797
	ret c			;a799
	ld a,(0cd40h)		;a79a   ; lee la pareja de la mano
	call L_A65B		;a79d   ; pone el acarreo si la ficha es de honor o 1 o 9; Z/NZ para 2-8
	ret c			;a7a0
	ld hl,0cd95h		;a7a1   ; apunta a los grupos de la mano (4)
	ld b,004h		;a7a4
L_A7A6:
	ld a,(hl)			;a7a6
	and 03fh		;a7a7
	call L_A65B		;a7a9   ; pone el acarreo si la ficha es de honor o 1 o 9; Z/NZ para 2-8
	ret c			;a7ac
	inc hl			;a7ad
	djnz L_A7A6		;a7ae
	ld b,002h		;a7b0
	ld c,018h		;a7b2
	call anota_yaku_valor		;a7b4   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a7b7
L_A7B8:
	ld a,(0cd0bh)		;a7b8   ; yaku 0x19: un solo palo con honores (honitsu); medido, valor 3 cerrada y 2 abierta
	and a			;a7bb
	ret nz			;a7bc
	ld hl,0cd20h		;a7bd   ; apunta a las fichas distintas de la mano
	ld a,(hl)			;a7c0
	and 030h		;a7c1
	ld e,a			;a7c3
	inc hl			;a7c4
L_A7C5:
	ld a,(hl)			;a7c5
	and a			;a7c6
	jr z,L_A7D0		;a7c7
	call L_A810		;a7c9   ; pone el acarreo si la ficha es de honor o no del palo E
	ret c			;a7cc
	inc hl			;a7cd
	jr L_A7C5		;a7ce
L_A7D0:
	ld a,(0cd20h)		;a7d0   ; lee las fichas distintas de la mano
	and 030h		;a7d3
	ld e,a			;a7d5
	ld a,(0cd40h)		;a7d6   ; lee la pareja de la mano
	call L_A810		;a7d9   ; pone el acarreo si la ficha es de honor o no del palo E
	ret c			;a7dc
	ld hl,0cd44h		;a7dd   ; apunta a las escaleras de la mano (4)
	call L_A801		;a7e0
	ret c			;a7e3
	push de			;a7e4
	pop de			;a7e5
	ld hl,0cd95h		;a7e6   ; apunta a los grupos de la mano (4)
	call L_A801		;a7e9
	ret c			;a7ec
	ld c,019h		;a7ed
L_A7EF:
	ld hl,(0cd5ch)		;a7ef   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a7f2
	add hl,de			;a7f5
	ld a,(hl)			;a7f6
	and a			;a7f7
	ld b,003h		;a7f8
	jr z,L_A7FD		;a7fa
	dec b			;a7fc
L_A7FD:
	call anota_yaku_valor		;a7fd   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a800
L_A801:
	ld b,004h		;a801
L_A803:
	ld a,(hl)			;a803
	and a			;a804
	jr z,L_A80E		;a805
	call L_A810		;a807   ; pone el acarreo si la ficha es de honor o no del palo E
	ret c			;a80a
	inc hl			;a80b
	djnz L_A803		;a80c
L_A80E:
	or a			;a80e
	ret			;a80f
L_A810:
	and 03fh		;a810   ; pone el acarreo si la ficha es de honor o no del palo E
	cp 031h		;a812
	ret nc			;a814
	and 030h		;a815
	cp e			;a817
	jr nz,L_A81C		;a818
	or a			;a81a
	ret			;a81b
L_A81C:
	scf			;a81c
	ret			;a81d
L_A81E:
	xor a			;a81e   ; yaku 0x1A: todos los grupos con un 1 o un 9, sin honores (junchan); medido
	ld (0cd9fh),a		;a81f
	ld a,(0cd99h)		;a822   ; lee 1 si la mano es de siete parejas
	and a			;a825
	ret nz			;a826
	ld a,(0cd40h)		;a827   ; lee la pareja de la mano
	cp 031h		;a82a
	ret nc			;a82c
	call L_A65E		;a82d
	ret c			;a830
	ld hl,0cd44h		;a831   ; apunta a las escaleras de la mano (4)
	ld b,004h		;a834
L_A836:
	ld a,(hl)			;a836   ; mira que las escaleras sean de un palo
	and a			;a837
	jr z,L_A845		;a838
	and 00fh		;a83a
	cp 007h		;a83c
	jr z,L_A842		;a83e
	dec a			;a840
	ret nz			;a841
L_A842:
	inc hl			;a842
	djnz L_A836		;a843
L_A845:
	ld hl,0cd95h		;a845   ; apunta a los grupos de la mano (4)
	ld b,004h		;a848
L_A84A:
	ld a,(hl)			;a84a   ; mira que los grupos sean de un palo
	and a			;a84b
	jr z,L_A859		;a84c
	cp 031h		;a84e
	ret nc			;a850
	call L_A65E		;a851
	ret c			;a854
	inc hl			;a855
	djnz L_A84A		;a856
	ret			;a858
L_A859:
	ld a,001h		;a859
	ld (0cd9fh),a		;a85b
	ld c,01ah		;a85e
	call L_A7EF		;a860
	ret			;a863
L_A864:
	xor a			;a864   ; yaku 0x1B: un solo palo sin honores (chinitsu), valor 6 cerrada y 5 abierta
	ld (0cd0bh),a		;a865
	call L_A885		;a868   ; mira si todas las fichas de 0xCD20 son del mismo palo (Z)
	ret nz			;a86b
	ld a,001h		;a86c
	ld (0cd0bh),a		;a86e
	ld hl,(0cd5ch)		;a871   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;a874
	add hl,de			;a877
	ld a,(hl)			;a878
	and a			;a879
	ld b,006h		;a87a
	jr z,L_A87F		;a87c
	dec b			;a87e
L_A87F:
	ld c,01bh		;a87f
	call anota_yaku_valor		;a881   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a884
L_A885:
	ld hl,0cd20h		;a885   ; mira si todas las fichas de 0xCD20 son del mismo palo (Z)
	ld a,(hl)			;a888
	and 030h		;a889
	ld e,a			;a88b
	inc hl			;a88c
L_A88D:
	ld a,(hl)			;a88d   ; mira que todos los grupos sean del palo E
	and a			;a88e
	ret z			;a88f
	and 030h		;a890
	cp e			;a892
	ret nz			;a893
	inc hl			;a894
	jr L_A88D		;a895
L_A897:
	call L_A904		;a897   ; yaku 0x1C: los dora (fichas que dan puntos extra), valor = cuantos; medido
	ld hl,0cd50h		;a89a
	call L_A8C6		;a89d   ; cuenta tambien los indicadores de debajo (urados)
	ld hl,(0cd5ch)		;a8a0   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00034h		;a8a3
	add hl,de			;a8a6
	ld a,(hl)			;a8a7
	and a			;a8a8
	jr z,L_A8B5		;a8a9
	push bc			;a8ab
	ld hl,0cd54h		;a8ac
	call L_A8BE		;a8af   ; cuenta cuantas fichas de la mano coinciden con los indicadores de dora (0xC027 = solo el de arriba)
	pop af			;a8b2
	add a,b			;a8b3
	ld b,a			;a8b4
L_A8B5:
	ld a,b			;a8b5
	and a			;a8b6
	ret z			;a8b7
	ld c,01ch		;a8b8
	call anota_yaku_valor		;a8ba   ; anota_yaku_valor: anota el yaku C con valor B en la primera casilla libre de 0xC2E0
	ret			;a8bd
L_A8BE:
	ld a,(0c027h)		;a8be   ; cuenta cuantas fichas de la mano coinciden con los indicadores de dora (0xC027 = solo el de arriba)
	and a			;a8c1
	ld b,001h		;a8c2
	jr z,L_A8CB		;a8c4
L_A8C6:
	ld a,(0c210h)		;a8c6   ; cuenta tambien los indicadores de debajo (urados)
	inc a			;a8c9
	ld b,a			;a8ca
L_A8CB:
	ex af,af'			;a8cb
	xor a			;a8cc
	ex af,af'			;a8cd
	ld c,000h		;a8ce
L_A8D0:
	push bc			;a8d0
	ld de,0c621h		;a8d1   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld b,00eh		;a8d4
L_A8D6:
	ld a,(de)			;a8d6   ; cuenta cuantas fichas de la mano son iguales a un indicador de dora
	and 03fh		;a8d7
	cp (hl)			;a8d9
	jr nz,L_A8E9		;a8da
	ex af,af'			;a8dc   ; cuenta la coincidencia
	inc a			;a8dd
	ex af,af'			;a8de
	ld a,(de)			;a8df
	rlca			;a8e0
	rlca			;a8e1
	and 003h		;a8e2
	cp 003h		;a8e4
	jr nz,L_A8E9		;a8e6
	inc c			;a8e8   ; y si es de grupo (bits 6-7 = 3) suma uno a C
L_A8E9:
	inc de			;a8e9   ; siguiente indicador y suma los dora de las fichas de grupo
	djnz L_A8D6		;a8ea
	inc hl			;a8ec   ; siguiente indicador
	ld a,c			;a8ed
	pop bc			;a8ee
	ld c,a			;a8ef
	djnz L_A8D0		;a8f0
	call L_A8F9		;a8f2   ; suma los de tripletes y kan (0xA8F9)
	ex af,af'			;a8f5
	add a,c			;a8f6
	ld b,a			;a8f7
	ret			;a8f8
L_A8F9:
	ld a,c			;a8f9
	and a			;a8fa
	ret z			;a8fb
	ld c,001h		;a8fc
L_A8FE:
	sub 003h		;a8fe
	ret z			;a900
	inc c			;a901
	jr L_A8FE		;a902
L_A904:
	ld hl,0cd50h		;a904   ; convierte los indicadores 0xC182, 0xC183 en las fichas que valen (el siguiente numero, o la tabla 0xA93C para los honores)
	ld de,0c182h		;a907
	call L_A910		;a90a
	ld de,0c183h		;a90d
L_A910:
	ld b,004h		;a910
L_A912:
	push bc			;a912   ; convierte un indicador: el numero siguiente (de 9 pasa a 1)
	ld a,(de)			;a913
	cp 031h		;a914
	jr nc,L_A928		;a916
	and 0f0h		;a918
	ld b,a			;a91a
	ld a,(de)			;a91b
	and 00fh		;a91c
	inc a			;a91e   ; suma uno al numero
	cp 00ah		;a91f
	jr c,L_A925		;a921
	ld a,001h		;a923   ; con 10 vuelve a 1
L_A925:
	or b			;a925
	jr L_A934		;a926
L_A928:
	and 00fh		;a928
	dec a			;a92a
	push hl			;a92b
	ld hl,0a93ch		;a92c
	call 0405ch		;a92f   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a932
	pop hl			;a933
L_A934:
	ld (hl),a			;a934   ; guarda y sigue con el indicador siguiente
	inc hl			;a935
	dec de			;a936
	dec de			;a937
	pop bc			;a938
	djnz L_A912		;a939
	ret			;a93b

; ----------------------------------------------------------------------
; DATOS resto_A93C: lo apuntan con el banco puesto p04:A92C (0xA93C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:A92C (7 bytes)
;   0xa93c..0xa943  (7 bytes)
DATA_resto_A93C:
	defb 032h,033h,034h,031h,036h,037h,035h	; a93c

; ======================================================================
; CODIGO 0xa943..0xab66  (547 bytes)
; ======================================================================


puntua_mano:		; puntua la mano ganadora y paga
	call L_ADE9		;a943   ; MUESTRA LA PUNTUACION DE LA MANO GANADORA: borra los pagos (0xADE9), mira quien paga (0xAB91) y, si el primer yaku es el 0x35, la muestra especial (0xAE13, 0xAE27)
	call L_AB91		;a946   ; mira si el que gana es el que reparte (0xC0B7): 0xC23D = 0 si lo es, 1 si no
	ld a,(0c2e0h)		;a949   ; lee la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	cp 035h		;a94c
	jr z,L_A971		;a94e
	call L_A978		;a950   ; escribe la lista de yaku (0xA978), y si 0xCD00 = 0 (mano normal) calcula los puntos (0xAB6E, 0xA9E7, 0xAA51) y paga (0xACB4)
	ld a,(0cd00h)		;a953   ; lee 1 si la mano es de limite
	and a			;a956
	jp nz,L_A967		;a957
	call L_AB6E		;a95a   ; calcula 0xC23C: el limite (5 = yakuman si han >= 0x15; 4 si >= 0x12 (3 si >= 0x10, 2 si >= 8, 1 si 7))
	call L_A9E7		;a95d   ; escribe los puntos de la mano normal: lineas de texto (0x663B, 0x5AB8): fu, han y total
	call L_AA51		;a960   ; BUSCA EN LA TABLA DE PUNTOS: segun han (0xC237), fu (0xC236), reparto (0xC0B1: robo o ron) y si es el que reparte (0xC23D) mira en las tablas 0xAF5D y 0xB049 los puntos
	call reparte_puntos		;a963   ; reparte_puntos: reparte los puntos de la mano ganadora
	ret			;a966
L_A967:
	call L_AA2F		;a967   ; mano especial (0xCD00 = 1): 0xAA2F, 0xAAAC y paga
	call L_AAAC		;a96a   ; puntos de la mano especial: tablas 0xB07D, y suma los honba (0xC239)
	call reparte_puntos		;a96d   ; reparte_puntos: reparte los puntos de la mano ganadora
	ret			;a970
L_A971:
	call L_AE13		;a971   ; muestra el yaku especial 0x35 (nombre de la tabla 0x6664) y la linea del limite
	call L_AE27		;a974   ; paga el limite especial (0xC238 = 3): reparte lo de la tabla 0xB07D entre los otros
	ret			;a977
L_A978:
	ld a,002h		;a978   ; escribe uno a uno los yaku de 0xC2E0: cada uno con su nombre (tabla 0x6664) y sus han; va sumando los han en 0xC237 (BCD)
	ld (0c237h),a		;a97a   ; guarda los han de la mano (BCD)
	ld b,020h		;a97d
	ld hl,0c2e0h		;a97f   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
L_A982:
	push bc			;a982
	push hl			;a983
	ld a,(hl)			;a984
	and a			;a985
	jr z,L_A99D		;a986
	call L_A9A0		;a988   ; escribe el nombre del yaku A en la linea que toca (0x4F: 0xAB4F) con la tabla de textos 0x6664
	pop hl			;a98b
	push hl			;a98c
	inc hl			;a98d
	ld a,(hl)			;a98e
	call L_A9B4		;a98f   ; escribe el valor del yaku (han): con 0xCD00 = 0 los dibuja con 0x5ABF (dos tiles); si no, los suma a 0xC237 sin dibujar
	ld hl,0c232h		;a992   ; apunta a la linea de la lista de yaku que se escribe
	inc (hl)			;a995
	pop hl			;a996
	inc hl			;a997
	inc hl			;a998
	pop bc			;a999
	djnz L_A982		;a99a
	ret			;a99c
L_A99D:
	pop hl			;a99d
	pop bc			;a99e
	ret			;a99f
L_A9A0:
	push af			;a9a0   ; escribe el nombre del yaku A en la linea que toca (0x4F: 0xAB4F) con la tabla de textos 0x6664
	call L_AB4F		;a9a1   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	ld e,a			;a9a4
	ld d,030h		;a9a5
	pop af			;a9a7
	push de			;a9a8
	ld hl,06664h		;a9a9
	call 04d07h		;a9ac   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop de			;a9af
	call 05ab1h		;a9b0
	ret			;a9b3
L_A9B4:
	ld b,a			;a9b4   ; escribe el valor del yaku (han): con 0xCD00 = 0 los dibuja con 0x5ABF (dos tiles); si no, los suma a 0xC237 sin dibujar
	ld a,(0cd00h)		;a9b5   ; lee 1 si la mano es de limite
	and a			;a9b8
	jr nz,L_A9DA		;a9b9
	ld a,b			;a9bb
	add a,00ah		;a9bc
	push af			;a9be
	ld a,b			;a9bf
	ld hl,0c237h		;a9c0   ; apunta a los han de la mano (BCD)
	add a,(hl)			;a9c3
	daa			;a9c4
	ld (hl),a			;a9c5
	call L_AB4F		;a9c6   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	ld e,a			;a9c9
	ld d,0b0h		;a9ca
	pop af			;a9cc
	push de			;a9cd
	call 05abfh		;a9ce
	pop de			;a9d1
	ld d,0c0h		;a9d2
	ld a,072h		;a9d4
	call 05abfh		;a9d6
	ret			;a9d9
L_A9DA:
	ld a,b			;a9da
	and 003h		;a9db
	ld (0c238h),a		;a9dd   ; guarda el limite de la mano especial
	ld hl,0c237h		;a9e0   ; apunta a los han de la mano (BCD)
	add a,(hl)			;a9e3
	daa			;a9e4
	ld (hl),a			;a9e5
	ret			;a9e6
L_A9E7:
	ld a,(0c23ch)		;a9e7   ; escribe los puntos de la mano normal: lineas de texto (0x663B, 0x5AB8): fu, han y total
	and a			;a9ea
	jp nz,L_AA47		;a9eb
	call L_AB4F		;a9ee   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	ld e,a			;a9f1
	push de			;a9f2
	ld d,048h		;a9f3
	ld hl,0663bh		;a9f5
	ld c,009h		;a9f8
	call 05ab8h		;a9fa
	ld a,(0c236h)		;a9fd   ; lee los fu de la mano (nivel)
	add a,002h		;aa00
	pop de			;aa02
	push de			;aa03
	ld d,038h		;aa04
	call 05abfh		;aa06
	ld a,00ah		;aa09
	pop de			;aa0b
	push de			;aa0c
	ld d,040h		;aa0d
	call 05abfh		;aa0f
	ld a,(0c237h)		;aa12   ; lee los han de la mano (BCD)
	dec a			;aa15
	dec a			;aa16
	and 00fh		;aa17
	add a,00ah		;aa19
	pop de			;aa1b
	ld d,068h		;aa1c
	call 05abfh		;aa1e
L_AA21:
	call L_AB4F		;aa21   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
L_AA24:
	ld e,a			;aa24   ; dibuja la linea de la lista de yaku y vuelve
	ld d,0c0h		;aa25
	ld a,091h		;aa27
	ld c,009h		;aa29
	call 05ac6h		;aa2b
	ret			;aa2e
L_AA2F:
	ld a,(0c238h)		;aa2f   ; escribe el limite de la mano especial (mangan, haneman, baiman, sanbaiman, yakuman: tabla 0x6640 segun 0xC238)
	dec a			;aa32
	ld hl,06640h		;aa33
	call 04d07h		;aa36   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
L_AA39:
	push hl			;aa39
	call L_AB4F		;aa3a   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	ld e,a			;aa3d
	ld d,038h		;aa3e
	pop hl			;aa40
	call 05ab1h		;aa41
	jp L_AA21		;aa44
L_AA47:
	dec a			;aa47
	ld hl,0664eh		;aa48
	call 04d07h		;aa4b   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	jp L_AA39		;aa4e
L_AA51:
	ld a,(0c23ch)		;aa51   ; BUSCA EN LA TABLA DE PUNTOS: segun han (0xC237), fu (0xC236), reparto (0xC0B1: robo o ron) y si es el que reparte (0xC23D) mira en las tablas 0xAF5D y 0xB049 los puntos
	and a			;aa54
	jr nz,L_AA91		;aa55
	ld a,(0c23dh)		;aa57   ; lee 0 si gana el que reparte, 1 si no
	ld hl,0af5dh		;aa5a
	call 04d07h		;aa5d   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b1h)		;aa60   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;aa63
	call 04d07h		;aa64   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c237h)		;aa67   ; lee los han de la mano (BCD)
	dec a			;aa6a
	dec a			;aa6b
	dec a			;aa6c
	call 04d07h		;aa6d   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c236h)		;aa70   ; lee los fu de la mano (nivel)
	add a,a			;aa73
	call 0405ch		;aa74   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;aa77
	rlca			;aa78
	jp c,L_AA86		;aa79
L_AA7C:
	ld a,(hl)			;aa7c
L_AA7D:
	ld (0c23bh),a		;aa7d   ; guarda lo que paga cada jugador (alto)
	inc hl			;aa80
	ld a,(hl)			;aa81
	ld (0c23ah),a		;aa82   ; guarda lo que paga cada jugador (bajo)
	ret			;aa85
L_AA86:
	ld a,001h		;aa86
	ld (0c23ch),a		;aa88   ; guarda la clase de limite (mangan, haneman...)
	ld a,(hl)			;aa8b
	and 07fh		;aa8c
	jp L_AA7D		;aa8e
L_AA91:
	ld a,(0c23dh)		;aa91   ; la mano es un limite (0xC23C): tablas 0xB049 + 0xC23D
	ld hl,0b049h		;aa94
	call 04d07h		;aa97   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b1h)		;aa9a   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;aa9d
	call 04d07h		;aa9e   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c23ch)		;aaa1   ; lee la clase de limite (mangan, haneman...)
	dec a			;aaa4
	add a,a			;aaa5
	call 0405ch		;aaa6   ; suma_a_hl: HL = HL + A
	jp L_AA7C		;aaa9
L_AAAC:
	ld a,(0c23dh)		;aaac   ; puntos de la mano especial: tablas 0xB07D, y suma los honba (0xC239)
	ld hl,0b07dh		;aaaf
	call 04d07h		;aab2   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b1h)		;aab5   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;aab8
	call 04d07h		;aab9   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c238h)		;aabc   ; lee el limite de la mano especial
	dec a			;aabf
	add a,a			;aac0
	call 0405ch		;aac1   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;aac4
	ld d,a			;aac5
	ld (0c23bh),a		;aac6   ; guarda lo que paga cada jugador (alto)
	inc hl			;aac9
	ld a,(hl)			;aaca
	ld e,a			;aacb
	ld (0c23ah),a		;aacc   ; guarda lo que paga cada jugador (bajo)
	ld a,(0c238h)		;aacf   ; lee el limite de la mano especial
	cp 003h		;aad2
	jp z,L_AAEF		;aad4
	ld a,(0c237h)		;aad7   ; lee los han de la mano (BCD)
	dec a			;aada
	dec a			;aadb
	dec a			;aadc
	and a			;aadd
	jr z,L_AAEF		;aade
	ld b,a			;aae0
	ld c,000h		;aae1
L_AAE3:
	push bc			;aae3   ; reparte el pago entre B jugadores
	push de			;aae4
	ld hl,0c239h		;aae5
	call 04a20h		;aae8
	pop de			;aaeb
	pop bc			;aaec
	djnz L_AAE3		;aaed
L_AAEF:
	ret			;aaef
dibuja_pago:		; dibuja el pago de la mano
	call L_AC43		;aaf0   ; DIBUJA EL PAGO: paga los honba, la riichi (0xC0B4) y los puntos de la mano
	call L_AC13		;aaf3   ; el ganador cobra los honba de los otros tres
	call L_ABBC		;aaf6   ; paga las barras de honba (0xC0B5 x 100): ellos pagan 100 por honba al ganador (0x4A20)
	call L_AB4F		;aaf9   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	ld e,a			;aafc
	ld d,088h		;aafd
	ld c,000h		;aaff
	ld a,(0c240h)		;ab01
	rrca			;ab04
	rrca			;ab05
	rrca			;ab06
	rrca			;ab07
	call L_AB2E		;ab08   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	ld a,(0c240h)		;ab0b
	call L_AB2E		;ab0e   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	ld a,(0c23fh)		;ab11
	rrca			;ab14
	rrca			;ab15
	rrca			;ab16
	rrca			;ab17
	call L_AB2E		;ab18   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	ld a,d			;ab1b
	add a,008h		;ab1c
	ld d,a			;ab1e
	ld a,(0c23fh)		;ab1f
	call L_AB2E		;ab22   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	xor a			;ab25
	call L_AB2E		;ab26   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	xor a			;ab29
	call L_AB2E		;ab2a   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	ret			;ab2d
L_AB2E:
	and 00fh		;ab2e   ; dibuja una cifra del pago en DE (ceros por la izquierda, en blanco mientras C = 0)
	jr z,L_AB34		;ab30
	ld c,0ffh		;ab32
L_AB34:
	and c			;ab34
	jr z,L_AB41		;ab35
L_AB37:
	push de			;ab37   ; dibuja un numero del pago
	push bc			;ab38
	call 05abfh		;ab39
	pop bc			;ab3c
	pop de			;ab3d
	jp L_AB4A		;ab3e
L_AB41:
	ld a,c			;ab41
	and a			;ab42
	jr z,L_AB4A		;ab43
	add a,00bh		;ab45
	jp L_AB37		;ab47
L_AB4A:
	ld a,d			;ab4a
	add a,008h		;ab4b
	ld d,a			;ab4d
	ret			;ab4e
L_AB4F:
	ld a,(0c248h)		;ab4f   ; devuelve en A la posicion de linea de la lista de yaku (de 0xC248 y 0xC232)
	dec a			;ab52
	ld hl,0ab66h		;ab53
	call 0405ch		;ab56   ; suma_a_hl: HL = HL + A
	push hl			;ab59
	ld a,(0c232h)		;ab5a   ; lee la linea de la lista de yaku que se escribe
	ld b,a			;ab5d
	rrca			;ab5e
	rrca			;ab5f
	rrca			;ab60
	rrca			;ab61
	add a,b			;ab62
	pop hl			;ab63
	add a,(hl)			;ab64
	ret			;ab65

; ----------------------------------------------------------------------
; DATOS resto_AB66: lo apuntan con el banco puesto p04:AB53 (0xAB66); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:AB53 (8 bytes)
;   0xab66..0xab6e  (8 bytes)
DATA_resto_AB66:
	defb 058h,04fh,047h,03eh,036h,02dh,025h,01ch	; ab66  XOG>6-%.

; ======================================================================
; CODIGO 0xab6e..0xade1  (627 bytes)
; ======================================================================


L_AB6E:
	ld b,005h		;ab6e   ; calcula 0xC23C: el limite (5 = yakuman si han >= 0x15; 4 si >= 0x12 (3 si >= 0x10, 2 si >= 8, 1 si 7))
	ld a,(0c237h)		;ab70   ; lee los han de la mano (BCD)
	cp 015h		;ab73
	jr nc,L_AB8C		;ab75
	dec b			;ab77
	cp 012h		;ab78
	jr nc,L_AB8C		;ab7a
	dec b			;ab7c
	cp 010h		;ab7d
	jr nc,L_AB8C		;ab7f
	dec b			;ab81
	cp 008h		;ab82
	jr nc,L_AB8C		;ab84
	dec b			;ab86
	cp 007h		;ab87
	jr z,L_AB8C		;ab89
	dec b			;ab8b
L_AB8C:
	ld a,b			;ab8c
	ld (0c23ch),a		;ab8d   ; guarda la clase de limite (mangan, haneman...)
	ret			;ab90
L_AB91:
	ld a,(0c0b1h)		;ab91   ; mira si el que gana es el que reparte (0xC0B7): 0xC23D = 0 si lo es, 1 si no
	dec a			;ab94
	and a			;ab95
	jr z,L_ABAA		;ab96
	ld b,000h		;ab98
	ld a,(0c20dh)		;ab9a   ; lee el jugador que responde a la ficha tirada
	ld hl,0c0b7h		;ab9d   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;aba0
	jr z,L_ABA5		;aba1
	ld b,001h		;aba3
L_ABA5:
	ld a,b			;aba5
	ld (0c23dh),a		;aba6   ; guarda 0 si gana el que reparte, 1 si no
	ret			;aba9
L_ABAA:
	ld b,000h		;abaa
	ld a,(0c207h)		;abac   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0c0b7h		;abaf   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;abb2
	jr z,L_ABB7		;abb3
	ld b,001h		;abb5
L_ABB7:
	ld a,b			;abb7
	ld (0c23dh),a		;abb8   ; guarda 0 si gana el que reparte, 1 si no
	ret			;abbb
L_ABBC:
	ld a,(0c0b5h)		;abbc   ; paga las barras de honba (0xC0B5 x 100): ellos pagan 100 por honba al ganador (0x4A20)
	and a			;abbf
	ret z			;abc0
	ld a,(0c0b1h)		;abc1   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;abc4
	and a			;abc5
	jp z,L_ABE8		;abc6
	ld a,(0c207h)		;abc9   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0ade1h		;abcc
	call 04d07h		;abcf   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b5h)		;abd2   ; lee las barras de honba (BCD)
	call L_AC8A		;abd5   ; convierte el numero BCD de A a binario (decenas x 10 + unidades)
	ld b,a			;abd8
L_ABD9:
	push bc			;abd9   ; cada uno de los otros jugadores paga los honba al ganador
	push hl			;abda
	ld c,001h		;abdb
	ld de,00003h		;abdd
	call 04a20h		;abe0
	pop hl			;abe3
	pop bc			;abe4
	djnz L_ABD9		;abe5
	ret			;abe7
L_ABE8:
	ld b,004h		;abe8
L_ABEA:
	push bc			;abea
	ld a,b			;abeb
	dec a			;abec
	ld hl,0c207h		;abed   ; apunta a el jugador al que le toca (0 = el humano)
	cp (hl)			;abf0
	jp z,L_AC0F		;abf1
	ld hl,0ade1h		;abf4
	call 04d07h		;abf7   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b5h)		;abfa   ; lee las barras de honba (BCD)
	call L_AC8A		;abfd   ; convierte el numero BCD de A a binario (decenas x 10 + unidades)
	ld b,a			;ac00
L_AC01:
	push bc			;ac01   ; el ganador cobra los honba de cada otro
	push hl			;ac02
	ld c,001h		;ac03
	ld de,00001h		;ac05
	call 04a20h		;ac08
	pop hl			;ac0b
	pop bc			;ac0c
	djnz L_AC01		;ac0d
L_AC0F:
	pop bc			;ac0f
	djnz L_ABEA		;ac10
	ret			;ac12
L_AC13:
	ld a,(0c0b5h)		;ac13   ; el ganador cobra los honba de los otros tres
	and a			;ac16
	ret z			;ac17
	ld a,(0c0b1h)		;ac18   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;ac1b
	jr z,L_AC24		;ac1c
	ld a,(0c20dh)		;ac1e   ; lee el jugador que responde a la ficha tirada
	jp L_AC27		;ac21
L_AC24:
	ld a,(0c207h)		;ac24   ; lee el jugador al que le toca (0 = el humano)
L_AC27:
	ld hl,0ade1h		;ac27
	call 04d07h		;ac2a   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b5h)		;ac2d   ; lee las barras de honba (BCD)
	call L_AC8A		;ac30   ; convierte el numero BCD de A a binario (decenas x 10 + unidades)
	ld b,a			;ac33
L_AC34:
	push bc			;ac34   ; cobra de cada uno las barras de honba
	push hl			;ac35
	ld c,000h		;ac36
	ld de,00003h		;ac38
	call 04a20h		;ac3b
	pop hl			;ac3e
	pop bc			;ac3f
	djnz L_AC34		;ac40
	ret			;ac42
L_AC43:
	ld a,(0c0b4h)		;ac43   ; el ganador cobra las barras de riichi (0xC0B4): suma a su cuenta 1000 por barra
	and a			;ac46
	ret z			;ac47
	ld a,(0c0b1h)		;ac48   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;ac4b
	jr z,L_AC61		;ac4c
	ld hl,0d000h		;ac4e
	call 099f6h		;ac51   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld de,00034h		;ac54
	add hl,de			;ac57
	ld a,(hl)			;ac58
	and a			;ac59
	ret z			;ac5a
	ld a,(0c20dh)		;ac5b   ; lee el jugador que responde a la ficha tirada
	jp L_AC6E		;ac5e
L_AC61:
	ld hl,(0c0deh)		;ac61   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00034h		;ac64
	add hl,de			;ac67
	ld a,(hl)			;ac68
	and a			;ac69
	ret z			;ac6a
	ld a,(0c207h)		;ac6b   ; lee el jugador al que le toca (0 = el humano)
L_AC6E:
	ld hl,0ade1h		;ac6e
	call 04d07h		;ac71   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c0b4h)		;ac74   ; lee las barras de riichi sobre la mesa (BCD)
	call L_AC8A		;ac77   ; convierte el numero BCD de A a binario (decenas x 10 + unidades)
	ld b,a			;ac7a
L_AC7B:
	push bc			;ac7b   ; cobra las barras de riichi
	push hl			;ac7c
	ld c,000h		;ac7d
	ld de,00010h		;ac7f
	call 04a20h		;ac82
	pop hl			;ac85
	pop bc			;ac86
	djnz L_AC7B		;ac87
	ret			;ac89
L_AC8A:
	push af			;ac8a   ; convierte el numero BCD de A a binario (decenas x 10 + unidades)
	and 0f0h		;ac8b
	rrca			;ac8d
	rrca			;ac8e
	rrca			;ac8f
	rrca			;ac90
	ld b,a			;ac91
	ld c,00ah		;ac92
	call 08b6fh		;ac94   ; multiplica_b_c: A = B x C
	ld b,a			;ac97
	pop af			;ac98
	and 00fh		;ac99
	add a,b			;ac9b
	ret			;ac9c
L_AC9D:
	ld a,(0c23bh)		;ac9d   ; reparte los puntos entre los pagadores: repite B veces (0xC23B, 0xC23A)
	ld d,a			;aca0
	ld a,(0c23ah)		;aca1   ; lee lo que paga cada jugador (bajo)
	ld e,a			;aca4
	ld c,000h		;aca5
L_ACA7:
	push bc			;aca7   ; paga a los otros dos
	push de			;aca8
	ld hl,0c23eh		;aca9
	call 04a20h		;acac
	pop de			;acaf
	pop bc			;acb0
	djnz L_ACA7		;acb1
	ret			;acb3
reparte_puntos:		; reparte los puntos de la mano ganadora
	ld a,(0c0b1h)		;acb4   ; REPARTE LOS PUNTOS DE LA MANO: si es robo (0xC0B1 = 1) paga cada uno la parte que le toca y el que reparte el doble; si es ron paga solo el que tiro (0xC207 o 0xC20D)
	dec a			;acb7
	and a			;acb8
	jr z,L_ACF3		;acb9
	ld a,(0c207h)		;acbb   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0ade1h		;acbe
	call 04d07h		;acc1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;acc4
	ld (hl),a			;acc6
	inc hl			;acc7
	ld a,(0c23ah)		;acc8   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;accb
	inc hl			;accc
	ld a,(0c23bh)		;accd   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;acd0
	ld a,(0c20dh)		;acd1   ; lee el jugador que responde a la ficha tirada
	ld hl,0ade1h		;acd4
	call 04d07h		;acd7   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;acda
	ld (hl),a			;acdb
	ld (0c23eh),a		;acdc
	inc hl			;acdf
	ld a,(0c23ah)		;ace0   ; lee lo que paga cada jugador (bajo)
	ld (0c23fh),a		;ace3
	ld (hl),a			;ace6
	inc hl			;ace7
	ld a,(0c23bh)		;ace8   ; lee lo que paga cada jugador (alto)
	ld (0c240h),a		;aceb
	ld (hl),a			;acee
	call dibuja_pago		;acef   ; dibuja_pago: dibuja el pago de la mano
	ret			;acf2
L_ACF3:
	ld a,(0c23dh)		;acf3   ; lee 0 si gana el que reparte, 1 si no
	and a			;acf6
	jp z,L_ADA2		;acf7
	ld b,004h		;acfa
L_ACFC:
	push bc			;acfc
	ld a,b			;acfd
	dec a			;acfe
	ld hl,0c0b7h		;acff   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;ad02
	jr z,L_AD1E		;ad03
	ld hl,0c207h		;ad05   ; apunta a el jugador al que le toca (0 = el humano)
	cp (hl)			;ad08
	jr z,L_AD1E		;ad09
	ld hl,0ade1h		;ad0b
	call 04d07h		;ad0e   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;ad11
	ld (hl),a			;ad13
	inc hl			;ad14
	ld a,(0c23ah)		;ad15   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;ad18
	inc hl			;ad19
	ld a,(0c23bh)		;ad1a   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;ad1d
L_AD1E:
	pop bc			;ad1e
	djnz L_ACFC		;ad1f
	ld b,002h		;ad21
	call L_AC9D		;ad23   ; reparte los puntos entre los pagadores: repite B veces (0xC23B, 0xC23A)
	ld a,(0c23ch)		;ad26   ; lee la clase de limite (mangan, haneman...)
	and a			;ad29
	jr nz,L_AD8F		;ad2a
	ld a,(0cd00h)		;ad2c   ; lee 1 si la mano es de limite
	and a			;ad2f
	jr nz,L_AD8F		;ad30
	ld a,(0c237h)		;ad32   ; lee los han de la mano (BCD)
	dec a			;ad35
	dec a			;ad36
	dec a			;ad37
	ld hl,0b0a1h		;ad38
	call 04d07h		;ad3b   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c236h)		;ad3e   ; lee los fu de la mano (nivel)
	add a,a			;ad41
	call 0405ch		;ad42   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;ad45
	and 07fh		;ad46
	ld (0c23bh),a		;ad48   ; guarda lo que paga cada jugador (alto)
	inc hl			;ad4b
	ld a,(hl)			;ad4c
	ld (0c23ah),a		;ad4d   ; guarda lo que paga cada jugador (bajo)
L_AD50:
	ld a,(0c23ah)		;ad50   ; lee lo que paga cada jugador (bajo)
	ld e,a			;ad53
	ld a,(0c23bh)		;ad54   ; lee lo que paga cada jugador (alto)
	ld d,a			;ad57
	ld c,000h		;ad58
	ld hl,0c23eh		;ad5a
	call 04a20h		;ad5d
	ld a,(0c0b7h)		;ad60   ; lee el jugador que reparte (0-3)
	ld hl,0ade1h		;ad63
	call 04d07h		;ad66   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;ad69
	ld (hl),a			;ad6b
	inc hl			;ad6c
	ld a,(0c23ah)		;ad6d   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;ad70
	inc hl			;ad71
	ld a,(0c23bh)		;ad72   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;ad75
	ld a,(0c207h)		;ad76   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0ade1h		;ad79
	call 04d07h		;ad7c   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;ad7f
	ld (hl),a			;ad80
	inc hl			;ad81
	ld a,(0c23fh)		;ad82
	ld (hl),a			;ad85
	inc hl			;ad86
	ld a,(0c240h)		;ad87
	ld (hl),a			;ad8a
	call dibuja_pago		;ad8b   ; dibuja_pago: dibuja el pago de la mano
	ret			;ad8e
L_AD8F:
	ld a,(0c23ah)		;ad8f   ; lee lo que paga cada jugador (bajo)
	ld e,a			;ad92
	ld a,(0c23bh)		;ad93   ; lee lo que paga cada jugador (alto)
	ld d,a			;ad96
	ld c,000h		;ad97
	ld hl,0c239h		;ad99
	call 04a20h		;ad9c
	jp L_AD50		;ad9f
L_ADA2:
	ld b,004h		;ada2   ; reparte la mano que gana el que reparte: cada uno de los otros tres paga lo mismo (0xC23A, 0xC23B)
L_ADA4:
	push bc			;ada4
	ld a,b			;ada5
	dec a			;ada6
	ld hl,0c0b7h		;ada7   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;adaa
	jr z,L_ADC0		;adab
	ld hl,0ade1h		;adad
	call 04d07h		;adb0   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;adb3
	ld (hl),a			;adb5
	inc hl			;adb6
	ld a,(0c23ah)		;adb7   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;adba
	inc hl			;adbb
	ld a,(0c23bh)		;adbc   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;adbf
L_ADC0:
	pop bc			;adc0
	djnz L_ADA4		;adc1
	ld b,003h		;adc3
	call L_AC9D		;adc5   ; reparte los puntos entre los pagadores: repite B veces (0xC23B, 0xC23A)
	ld a,(0c0b7h)		;adc8   ; lee el jugador que reparte (0-3)
	ld hl,0ade1h		;adcb
	call 04d07h		;adce   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;add1
	ld (hl),a			;add2
	inc hl			;add3
	ld a,(0c23fh)		;add4
	ld (hl),a			;add7
	inc hl			;add8
	ld a,(0c240h)		;add9
	ld (hl),a			;addc
	call dibuja_pago		;addd   ; dibuja_pago: dibuja el pago de la mano
	ret			;ade0

; ----------------------------------------------------------------------
; DATOS resto_ADE1: lo apuntan con el banco puesto p04:ABCC (0xADE1), p04:ABF4
;   (0xADE1), p04:AC27 (0xADE1), p04:AC6E (0xADE1), p04:ACBE (0xADE1),
;   p04:ACD4 (0xADE1); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p04:ABCC, p04:ABF4, p04:AC27, p04:AC6E, p04:ACBE,
;   p04:ACD4 (8 bytes)
;   0xade1..0xade9  (8 bytes)
DATA_resto_ADE1:
	defb 08ch,0c2h,08fh,0c2h,092h,0c2h,095h,0c2h	; ade1  ........

; ======================================================================
; CODIGO 0xade9..0xaf5d  (372 bytes)
; ======================================================================


L_ADE9:
	ld b,004h		;ade9   ; borra los cuatro marcadores de pagos (0xADE1 + 3 x jugador) y 0xC239, 0xC23A, 0xC23B, 0xC23E-0xC240
	xor a			;adeb
L_ADEC:
	push bc			;adec
	push af			;aded
	ld hl,0ade1h		;adee
	call 04d07h		;adf1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;adf4
	ld (hl),a			;adf5
	inc hl			;adf6
	ld (hl),a			;adf7
	inc hl			;adf8
	ld (hl),a			;adf9
	pop af			;adfa
	inc a			;adfb
	pop bc			;adfc
	djnz L_ADEC		;adfd
	xor a			;adff
	ld (0c239h),a		;ae00
	ld (0c23ah),a		;ae03   ; guarda lo que paga cada jugador (bajo)
	ld (0c23bh),a		;ae06   ; guarda lo que paga cada jugador (alto)
	ld (0c23eh),a		;ae09
	ld (0c23fh),a		;ae0c
	ld (0c240h),a		;ae0f
	ret			;ae12
L_AE13:
	ld a,035h		;ae13   ; muestra el yaku especial 0x35 (nombre de la tabla 0x6664) y la linea del limite
	ld hl,06664h		;ae15
	call 04d07h		;ae18   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld de,03060h		;ae1b
	call 05ab1h		;ae1e
	ld a,060h		;ae21
	call L_AA24		;ae23   ; dibuja la linea de la lista de yaku y vuelve
	ret			;ae26
L_AE27:
	ld a,003h		;ae27   ; paga el limite especial (0xC238 = 3): reparte lo de la tabla 0xB07D entre los otros
	ld (0c238h),a		;ae29   ; guarda el limite de la mano especial
	call L_AAAC		;ae2c   ; puntos de la mano especial: tablas 0xB07D, y suma los honba (0xC239)
	ld a,(0c23dh)		;ae2f   ; lee 0 si gana el que reparte, 1 si no
	and a			;ae32
	jp z,L_AEBA		;ae33
	ld b,004h		;ae36
L_AE38:
	push bc			;ae38
	ld a,b			;ae39
	dec a			;ae3a
	ld hl,0c0b7h		;ae3b   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;ae3e
	jr z,L_AE53		;ae3f
	ld hl,0ade1h		;ae41
	call 04d07h		;ae44   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;ae47
	ld (hl),a			;ae48
	inc hl			;ae49
	ld a,(0c23ah)		;ae4a   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;ae4d
	inc hl			;ae4e
	ld a,(0c23bh)		;ae4f   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;ae52
L_AE53:
	pop bc			;ae53
	djnz L_AE38		;ae54
	ld b,002h		;ae56
	call L_AC9D		;ae58   ; reparte los puntos entre los pagadores: repite B veces (0xC23B, 0xC23A)
	ld a,(0c23ah)		;ae5b   ; lee lo que paga cada jugador (bajo)
	ld e,a			;ae5e
	ld a,(0c23bh)		;ae5f   ; lee lo que paga cada jugador (alto)
	ld d,a			;ae62
	ld c,000h		;ae63
	ld hl,0c239h		;ae65
	call 04a20h		;ae68
	ld a,(0c23ah)		;ae6b   ; lee lo que paga cada jugador (bajo)
	ld e,a			;ae6e
	ld a,(0c23bh)		;ae6f   ; lee lo que paga cada jugador (alto)
	ld d,a			;ae72
	ld c,000h		;ae73
	ld hl,0c23eh		;ae75
	call 04a20h		;ae78
	ld a,(0c0b7h)		;ae7b   ; lee el jugador que reparte (0-3)
	ld hl,0ade1h		;ae7e
	call 04d07h		;ae81   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,000h		;ae84
	ld (hl),a			;ae86
	inc hl			;ae87
	ld a,(0c23ah)		;ae88   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;ae8b
	inc hl			;ae8c
	ld a,(0c23bh)		;ae8d   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;ae90
	ld a,(0c0b1h)		;ae91   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;ae94
	and a			;ae95
	jr z,L_AE9E		;ae96
	ld a,(0c20dh)		;ae98   ; lee el jugador que responde a la ficha tirada
	jp L_AEA1		;ae9b
L_AE9E:
	ld a,(0c207h)		;ae9e   ; lee el jugador al que le toca (0 = el humano)
L_AEA1:
	ld hl,0ade1h		;aea1
	call 04d07h		;aea4   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;aea7
	ld (hl),a			;aea9
	inc hl			;aeaa
	ld a,(0c23fh)		;aeab
	ld (hl),a			;aeae
	inc hl			;aeaf
	ld a,(0c240h)		;aeb0
	ld (hl),a			;aeb3
	ld a,060h		;aeb4
	call L_AF08		;aeb6   ; dibuja el numero del pago (C23F, C240) en la linea E: cinco cifras y dos ceros
	ret			;aeb9
L_AEBA:
	ld b,004h		;aeba   ; reparte la mano que gana el que no reparte con robo: los otros dos pagan lo mismo y el que reparte paga el doble (0xAC9D)
L_AEBC:
	push bc			;aebc
	ld a,b			;aebd
	dec a			;aebe
	ld hl,0c0b7h		;aebf   ; apunta a el jugador que reparte (0-3)
	cp (hl)			;aec2
	jr z,L_AED7		;aec3
	ld hl,0ade1h		;aec5
	call 04d07h		;aec8   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	xor a			;aecb
	ld (hl),a			;aecc
	inc hl			;aecd
	ld a,(0c23ah)		;aece   ; lee lo que paga cada jugador (bajo)
	ld (hl),a			;aed1
	inc hl			;aed2
	ld a,(0c23bh)		;aed3   ; lee lo que paga cada jugador (alto)
	ld (hl),a			;aed6
L_AED7:
	pop bc			;aed7
	djnz L_AEBC		;aed8
	ld b,003h		;aeda
	call L_AC9D		;aedc   ; reparte los puntos entre los pagadores: repite B veces (0xC23B, 0xC23A)
	ld a,(0c0b1h)		;aedf   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;aee2
	and a			;aee3
	jr z,L_AEEC		;aee4
	ld a,(0c20dh)		;aee6   ; lee el jugador que responde a la ficha tirada
	jp L_AEEF		;aee9
L_AEEC:
	ld a,(0c207h)		;aeec   ; lee el jugador al que le toca (0 = el humano)
L_AEEF:
	ld hl,0ade1h		;aeef
	call 04d07h		;aef2   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,001h		;aef5
	ld (hl),a			;aef7
	inc hl			;aef8
	ld a,(0c23fh)		;aef9
	ld (hl),a			;aefc
	inc hl			;aefd
	ld a,(0c240h)		;aefe
	ld (hl),a			;af01
	ld a,060h		;af02
	call L_AF08		;af04   ; dibuja el numero del pago (C23F, C240) en la linea E: cinco cifras y dos ceros
	ret			;af07
L_AF08:
	ld e,a			;af08   ; dibuja el numero del pago (C23F, C240) en la linea E: cinco cifras y dos ceros
	ld d,088h		;af09
	ld c,000h		;af0b
	ld a,(0c240h)		;af0d
	rrca			;af10
	rrca			;af11
	rrca			;af12
	rrca			;af13
	call L_AF3A		;af14   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	ld a,(0c240h)		;af17
	call L_AF3A		;af1a   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	ld a,(0c23fh)		;af1d
	rrca			;af20
	rrca			;af21
	rrca			;af22
	rrca			;af23
	call L_AF3A		;af24   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	ld a,d			;af27
	add a,008h		;af28
	ld d,a			;af2a
	ld a,(0c23fh)		;af2b
	call L_AF3A		;af2e   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	xor a			;af31
	call L_AF3A		;af32   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	xor a			;af35
	call L_AF3A		;af36   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	ret			;af39
L_AF3A:
	and 00fh		;af3a   ; dibuja una cifra del pago con ceros en blanco (0x5AC6)
	jr z,L_AF40		;af3c
	ld c,0ffh		;af3e
L_AF40:
	and c			;af40
	jr z,L_AF4F		;af41
L_AF43:
	push de			;af43   ; dibuja una cifra del pago
	push bc			;af44
	ld c,009h		;af45
	call 05ac6h		;af47
	pop bc			;af4a
	pop de			;af4b
	jp L_AF58		;af4c
L_AF4F:
	ld a,c			;af4f
	and a			;af50
	jr z,L_AF58		;af51
	add a,00bh		;af53
	jp L_AF43		;af55
L_AF58:
	ld a,d			;af58
	add a,008h		;af59
	ld d,a			;af5b
	ret			;af5c

; ----------------------------------------------------------------------
; DATOS resto_AF5D: lo apuntan con el banco puesto p04:AA5A (0xAF5D), p00:41E6
;   (0xB000), p00:421C (0xB000), p00:4240 (0xB000), p00:4252 (0xB000),
;   p04:AA94 (0xB049); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p04:AA5A, p00:41E6, p00:421C, p00:4240, p00:4252,
;   p04:AA94 (380 bytes)
;   0xaf5d..0xb0d9  (380 bytes)
DATA_resto_AF5D:
	defb 061h,0afh,0d5h,0afh,065h,0afh,09dh,0afh,06dh,0afh,079h,0afh,085h,0afh,091h,0afh	; af5d  a...e...m.y.....
	defb 000h,004h,000h,005h,000h,007h,000h,008h,000h,010h,000h,012h,000h,007h,000h,010h	; af6d  ................
	defb 000h,013h,000h,016h,000h,020h,000h,023h,000h,013h,000h,020h,000h,026h,000h,032h	; af7d  ..... .#... .&.2
	defb 000h,039h,080h,040h,000h,026h,000h,039h,080h,040h,080h,040h,080h,040h,080h,040h	; af8d  .9.@.&.9.@.@.@.@
	defb 0a5h,0afh,0b1h,0afh,0bdh,0afh,0c9h,0afh,000h,010h,000h,015h,000h,020h,000h,024h	; af9d  ............. .$
	defb 000h,029h,000h,034h,000h,020h,000h,029h,000h,039h,000h,048h,000h,058h,000h,068h	; afad  .).4. .).9.H.X.h
	defb 000h,039h,000h,058h,000h,077h,000h,096h,001h,016h,081h,020h,000h,077h,001h,016h	; afbd  .9.X.w..... .w..
	defb 081h,020h,081h,020h,081h,020h,081h,020h,0d9h,0afh,011h,0b0h,0e1h,0afh,0edh,0afh	; afcd  . . . . ........
	defb 0f9h,0afh,005h,0b0h,000h,002h,000h,003h,000h,004h,000h,004h,000h,005h,000h,006h	; afdd  ................
	defb 000h,004h,000h,005h,000h,007h,000h,008h,000h,010h,000h,012h,000h,007h,000h,010h	; afed  ................
	defb 000h,013h,000h,016h,000h,020h,080h,020h,000h,013h,000h,020h,080h,020h,080h,020h	; affd  ..... . ... . .
	defb 080h,020h,080h,020h,019h,0b0h,025h,0b0h,031h,0b0h,03dh,0b0h,000h,007h,000h,010h	; b00d  . . ..%.1.=.....
	defb 000h,013h,000h,016h,000h,020h,000h,023h,000h,013h,000h,020h,000h,026h,000h,032h	; b01d  ..... .#... .&.2
	defb 000h,039h,000h,045h,000h,026h,000h,039h,000h,052h,000h,064h,000h,077h,080h,080h	; b02d  .9.E.&.9.R.d.w..
	defb 000h,052h,000h,077h,080h,080h,080h,080h,080h,080h,080h,080h,04dh,0b0h,065h,0b0h	; b03d  .R.w........M.e.
	defb 051h,0b0h,05bh,0b0h,000h,040h,000h,060h,000h,080h,001h,020h,001h,060h,001h,020h	; b04d  Q.[..@.`... .`.
	defb 001h,080h,002h,040h,003h,060h,004h,080h,069h,0b0h,073h,0b0h,000h,020h,000h,030h	; b05d  ...@.`..i.s.. .0
	defb 000h,040h,000h,060h,000h,080h,000h,080h,001h,020h,001h,060h,002h,040h,003h,020h	; b06d  .@.`..... .`.@.
	defb 081h,0b0h,091h,0b0h,085h,0b0h,08bh,0b0h,001h,060h,001h,060h,000h,040h,004h,080h	; b07d  .........`.`.@..
	defb 004h,080h,000h,040h,095h,0b0h,09bh,0b0h,000h,080h,000h,080h,000h,020h,003h,020h	; b08d  ...@......... .
	defb 003h,020h,000h,020h,0a9h,0b0h,0b5h,0b0h,0c1h,0b0h,0cdh,0b0h,000h,004h,000h,005h	; b09d  . . ............
	defb 000h,007h,000h,008h,000h,010h,000h,012h,000h,007h,000h,010h,000h,013h,000h,016h	; b0ad  ................
	defb 000h,020h,000h,023h,000h,013h,000h,020h,000h,026h,000h,032h,000h,039h,000h,040h	; b0bd  . .#... .&.2.9.@
	defb 000h,026h,000h,039h,000h,040h,000h,040h,000h,040h,000h,040h	; b0cd  .&.9.@.@.@.@

; ======================================================================
; CODIGO 0xb0d9..0xb0e2  (9 bytes)
; ======================================================================


efecto_final_mano:		; el efecto de fondo del final de la mano
	call 059cdh		;b0d9   ; PANTALLA DEL FINAL DE LA MANO (EFECTO): copia los sprites y 0xC24D elige el paso por la tabla de 0xB0E0
	ld a,(0c24dh)		;b0dc
	call 04066h		;b0df   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B0E2: 5 destinos del despachador p00:4066 (call en p04:B0DF, el
;   indice en A): B0EC, B109, B11C, B134, B146; lo leen p04:B0DF (10 bytes)
;   0xb0e2..0xb0ec  (10 bytes)
DATA_tabla_B0E2:
	defw 0b0ech,0b109h,0b11ch,0b134h,0b146h	; b0e2

; ======================================================================
; CODIGO 0xb0ec..0xb241  (341 bytes)
; ======================================================================


L_B0EC:
	call L_B15E		;b0ec   ; primer paso: 0xB15E, carga una imagen de fondo (0x5810) y 0xC004 = 0x80
	call 05810h		;b0ef
	ld a,080h		;b0f2
	ld (0c004h),a		;b0f4   ; guarda el temporizador de espera entre pasos
	xor a			;b0f7
	ld hl,0c24eh		;b0f8
	ld de,0c24fh		;b0fb
	ld (hl),a			;b0fe
	ld bc,00008h		;b0ff
	ldir		;b102
	ld hl,0c24dh		;b104
	inc (hl)			;b107
	ret			;b108
L_B109:
	call L_B181		;b109   ; paso de fundido hacia dentro: sube los colores (0xB181) hasta que acaba (0xC248)
	ld a,(0c248h)		;b10c   ; lee cuantos yaku hay en la lista
	and a			;b10f
	ret nz			;b110
	call 05aaah		;b111   ; carga las imagenes (0x5AAA, 0x56DF) y pasa al paso siguiente
	call 056dfh		;b114   ; carga otra imagen de los bancos 10-11 (p00:56DF)
	ld hl,0c24dh		;b117
	inc (hl)			;b11a
	ret			;b11b
L_B11C:
	call L_B261		;b11c   ; paso de las estrellas: 0xB261 y, al acabar (0xC253), cuenta 0xC00A y pide el sonido 0x03 (0x41A3)
	ld a,(0c253h)		;b11f
	or a			;b122
	ret z			;b123
	ld hl,0c00ah		;b124
	dec (hl)			;b127
	ret nz			;b128
	call L_B150		;b129   ; copia la paleta de 0xB241 (32 bytes) a 0xC200 y la aplica
	call 041a3h		;b12c   ; pide_orden_81: pide la orden 0x81 del motor de sonido (ritmo)
	ld hl,0c24dh		;b12f
	inc (hl)			;b132
	ret			;b133
L_B134:
	call L_B188		;b134   ; paso de fundido hacia fuera (0xB188): al acabar pone 0xC00A = 0x20
	ld a,(0c248h)		;b137   ; lee cuantos yaku hay en la lista
	and a			;b13a
	ret nz			;b13b
	ld hl,0c24dh		;b13c
	inc (hl)			;b13f
	ld hl,0c00ah		;b140
	ld (hl),020h		;b143
	ret			;b145
L_B146:
	ld hl,0c00ah		;b146   ; espera 0xC00A cuadros y pone 0xC0B0 = 0
	dec (hl)			;b149
	ret nz			;b14a
	xor a			;b14b
	ld (0c0b0h),a		;b14c   ; guarda 1 cuando la partida esta lista
	ret			;b14f
L_B150:
	ld hl,0b241h		;b150   ; copia la paleta de 0xB241 (32 bytes) a 0xC200 y la aplica
	ld de,0c200h		;b153   ; apunta a contador de trabajo de las fichas de la mano
	ld bc,00020h		;b156
	ldir		;b159
	jp L_B170		;b15b
L_B15E:
	ld hl,0c200h		;b15e   ; pone 0xC200 (33 bytes) a cero, 0xC00A = 0x20 y empieza el fundido
	ld de,0c201h		;b161   ; apunta a la X de la ficha en la hoja de tiles
	ld (hl),000h		;b164
	ld bc,00020h		;b166
	ldir		;b169
	ld a,020h		;b16b
	ld (0c00ah),a		;b16d
L_B170:
	call L_B205		;b170   ; aplica la paleta, 0xC24A = 0xC249 = 0x0F (cuadros por paso) y 0xC248 = 1
	ld a,00fh		;b173
	ld (0c24ah),a		;b175   ; guarda el tiempo que queda de la cara que habla
	ld (0c249h),a		;b178
	ld a,001h		;b17b
	ld (0c248h),a		;b17d   ; guarda cuantos yaku hay en la lista
	ret			;b180
L_B181:
	call L_B18F		;b181   ; un paso de fundido hacia dentro de la paleta de 0xC200 hacia la de 0xB241: cada color sube un nivel de cada canal hasta llegar a su valor
	call L_B22C		;b184   ; pone 0xC248 a cero cuando la paleta ya es igual a la de destino (0xB241)
	ret			;b187
L_B188:
	call L_B1D6		;b188   ; cada 0x0F cuadros baja un nivel cada canal de los 16 colores de 0xC200 hacia cero
	call L_B21B		;b18b   ; pone 0xC248 a cero cuando los 32 bytes de la paleta ya valen cero
	ret			;b18e
L_B18F:
	ld hl,0c249h		;b18f   ; cada 0x0F cuadros sube de un nivel cada canal de los 16 colores: de rojo y verde (nibble alto y bajo) y de azul
	dec (hl)			;b192
	ret nz			;b193
	ld a,00fh		;b194
	ld (hl),a			;b196
	ld hl,0c200h		;b197   ; apunta a contador de trabajo de las fichas de la mano
	ld de,0b241h		;b19a
	ld b,010h		;b19d
L_B19F:
	ld a,(de)			;b19f   ; un paso de fundido: mira cada color de la paleta
	rra			;b1a0
	rra			;b1a1
	rra			;b1a2
	rra			;b1a3
	and 00fh		;b1a4   ; nivel de color de destino (byte alto del nibble)
	ld c,a			;b1a6
	ld a,(hl)			;b1a7
	rra			;b1a8
	rra			;b1a9
	rra			;b1aa
	rra			;b1ab
	and 00fh		;b1ac
	cp c			;b1ae   ; si ya es igual no lo toca
	jr z,L_B1B5		;b1af
	ld a,010h		;b1b1
	add a,(hl)			;b1b3
	ld (hl),a			;b1b4
L_B1B5:
	ld a,(de)			;b1b5   ; el nivel actual del color
	and 00fh		;b1b6
	ld c,a			;b1b8
	ld a,(hl)			;b1b9
	and 00fh		;b1ba
	cp c			;b1bc
	jp z,L_B1C1		;b1bd
	inc (hl)			;b1c0
L_B1C1:
	inc hl			;b1c1   ; siguiente color
	inc de			;b1c2
	ld a,(de)			;b1c3
	and 00fh		;b1c4
	ld c,a			;b1c6
	ld a,(hl)			;b1c7
	and 00fh		;b1c8
	cp c			;b1ca
	jr z,L_B1CE		;b1cb
	inc (hl)			;b1cd
L_B1CE:
	inc hl			;b1ce
	inc de			;b1cf
	djnz L_B19F		;b1d0
	call L_B205		;b1d2   ; escribe en el VDP los 16 colores de 0xC200 (4EB2)
	ret			;b1d5
L_B1D6:
	ld hl,0c249h		;b1d6   ; cada 0x0F cuadros baja un nivel cada canal de los 16 colores de 0xC200 hacia cero
	dec (hl)			;b1d9
	ret nz			;b1da
	ld a,00fh		;b1db
	ld (hl),a			;b1dd
	ld hl,0c200h		;b1de   ; apunta a contador de trabajo de las fichas de la mano
	ld b,010h		;b1e1
L_B1E3:
	ld a,(hl)			;b1e3   ; un paso de fundido a negro: baja el nivel
	rra			;b1e4
	rra			;b1e5
	rra			;b1e6
	rra			;b1e7
	and 00fh		;b1e8
	jr z,L_B1F0		;b1ea
	ld a,(hl)			;b1ec
	sub 010h		;b1ed
	ld (hl),a			;b1ef
L_B1F0:
	ld a,(hl)			;b1f0
	and 00fh		;b1f1
	jp z,L_B1F7		;b1f3
	dec (hl)			;b1f6
L_B1F7:
	inc hl			;b1f7
	ld a,(hl)			;b1f8
	and 00fh		;b1f9
	jr z,L_B1FE		;b1fb
	dec (hl)			;b1fd
L_B1FE:
	inc hl			;b1fe
	djnz L_B1E3		;b1ff
	call L_B205		;b201   ; escribe en el VDP los 16 colores de 0xC200 (4EB2)
	ret			;b204
L_B205:
	ld hl,0c200h		;b205   ; escribe en el VDP los 16 colores de 0xC200 (4EB2)
	xor a			;b208
L_B209:
	push af			;b209   ; aplica los 16 colores
	ld d,(hl)			;b20a
	inc hl			;b20b
	ld e,(hl)			;b20c
	inc hl			;b20d
	push hl			;b20e
	call 04eb2h		;b20f   ; pon_color: escribe el color D,E en la paleta A
	pop hl			;b212
	pop af			;b213
	inc a			;b214
	cp 010h		;b215
	ret z			;b217
	jp L_B209		;b218
L_B21B:
	ld b,020h		;b21b   ; pone 0xC248 a cero cuando los 32 bytes de la paleta ya valen cero
	ld hl,0c200h		;b21d   ; apunta a contador de trabajo de las fichas de la mano
L_B220:
	ld a,(hl)			;b220
	and a			;b221
	ret nz			;b222
	inc hl			;b223
	djnz L_B220		;b224
	ld hl,0c248h		;b226   ; apunta a cuantos yaku hay en la lista
	ld (hl),000h		;b229
	ret			;b22b
L_B22C:
	ld b,020h		;b22c   ; pone 0xC248 a cero cuando la paleta ya es igual a la de destino (0xB241)
	ld de,0b241h		;b22e
	ld hl,0c200h		;b231   ; apunta a contador de trabajo de las fichas de la mano
L_B234:
	ld a,(de)			;b234
	cp (hl)			;b235
	ret nz			;b236
	inc hl			;b237
	inc de			;b238
	djnz L_B234		;b239
	ld hl,0c248h		;b23b   ; apunta a cuantos yaku hay en la lista
	ld (hl),000h		;b23e
	ret			;b240

; ----------------------------------------------------------------------
; DATOS resto_B241: lo apuntan con el banco puesto p04:B150 (0xB241), p04:B19A
;   (0xB241), p04:B22E (0xB241); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p04:B150, p04:B19A, p04:B22E (32 bytes)
;   0xb241..0xb261  (32 bytes)
DATA_resto_B241:
	defb 000h,000h,064h,005h,062h,003h,034h,003h,047h,004h,023h,005h,045h,004h,057h,006h	; b241  ..d.b.4.G.#.E.W.
	defb 007h,002h,050h,000h,012h,004h,040h,004h,042h,002h,073h,007h,077h,007h,000h,000h	; b251  ..P...@.B.s.w...

; ======================================================================
; CODIGO 0xb261..0xb292  (49 bytes)
; ======================================================================


L_B261:
	call L_B283		;b261   ; anima las estrellas: 0xB283 y, al pasar de 8 pasos (0xC24E), 0xC253 = 1
	ld a,(0c24eh)		;b264
	cp 008h		;b267
	ret c			;b269
	ld a,001h		;b26a
	ld (0c253h),a		;b26c
	ret			;b26f
L_B270:
	ld hl,0c24fh		;b270   ; siguiente paso de la animacion: 0xC24F += 1 y 0xC250 = 0
	inc (hl)			;b273
	ld a,0ffh		;b274
	ld (0c250h),a		;b276
L_B279:
	ld hl,0c250h		;b279
	inc (hl)			;b27c
	ret			;b27d
L_B27E:
	call 0405ch		;b27e   ; A = byte A de la tabla HL
	ld a,(hl)			;b281
	ret			;b282
L_B283:
	ld a,(0c24eh)		;b283   ; un paso de las estrellas: 0xC24F elige por la tabla de 0xB292 el paso
	cp 008h		;b286
	ret nc			;b288
	ld a,(0c24fh)		;b289
	ld hl,0b292h		;b28c
	call 04066h		;b28f   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B292: 5 destinos del despachador p00:4066 (call en p04:B28F, el
;   indice en A): B29C, B29E, B40F, B479, B4A8; lo leen p04:B28F (10 bytes)
;   0xb292..0xb29c  (10 bytes)
DATA_tabla_B292:
	defw 0b29ch,0b29eh,0b40fh,0b479h,0b4a8h	; b292

; ======================================================================
; CODIGO 0xb29c..0xb2a7  (11 bytes)
; ======================================================================


L_B29C:
	jr $-44		;b29c
L_B29E:
	ld a,(0c250h)		;b29e   ; 0xC250 elige por la tabla de 0xB2A7: carga sprites (0xB323 a 0xCC00, 28 bytes) y colores (0xB33F a 0xCA00)
	ld hl,0b2a7h		;b2a1
	call 04066h		;b2a4   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B2A7: 3 destinos del despachador p00:4066 (call en p04:B2A4, el
;   indice en A): B2AD, B34F, B409; lo leen p04:B2A4 (6 bytes)
;   0xb2a7..0xb2ad  (6 bytes)
DATA_tabla_B2A7:
	defw 0b2adh,0b34fh,0b409h	; b2a7  -> L_B2AD L_B34F L_B409

; ======================================================================
; CODIGO 0xb2ad..0xb318  (107 bytes)
; ======================================================================


L_B2AD:
	call 04e9ch		;b2ad
	ld hl,0b323h		;b2b0
	ld de,0cc00h		;b2b3   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	ld bc,0001ch		;b2b6
	ldir		;b2b9
	ld hl,0b33fh		;b2bb
	ld de,0ca00h		;b2be   ; apunta a los colores de los sprites (4 bloques de 16)
L_B2C1:
	ld a,(hl)			;b2c1
	inc hl			;b2c2
	cp 0ffh		;b2c3
	jr z,L_B2CF		;b2c5
	ld b,010h		;b2c7
L_B2C9:
	ld (de),a			;b2c9
	inc de			;b2ca
	djnz L_B2C9		;b2cb
	jr L_B2C1		;b2cd
L_B2CF:
	call L_B307		;b2cf   ; pone los siete sprites de la estrella y dibuja los tiles 0x91 en 3 x 2 sitios (0xB301)
	ld de,0cc00h		;b2d2   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	ld b,007h		;b2d5
	call L_B310		;b2d7   ; recorre B sprites del bloque (de 4 en 4 bytes) poniendoles el numero A
	call 04ea7h		;b2da
	call L_B307		;b2dd   ; HL = tabla de la estrella del paso 0xC24E (0xB347)
	ld b,003h		;b2e0
	ld d,a			;b2e2
	ld e,000h		;b2e3
L_B2E5:
	push de			;b2e5   ; dibuja los tiles 0x91 de la estrella
	call L_B301		;b2e6
	ld a,008h		;b2e9   ; siguiente columna de tiles
	add a,d			;b2eb
	ld d,a			;b2ec
	call L_B301		;b2ed
	pop de			;b2f0
	ld a,008h		;b2f1
	add a,e			;b2f3
	ld e,a			;b2f4
	djnz L_B2E5		;b2f5
	xor a			;b2f7   ; pone a cero los contadores de la animacion
	ld (0c251h),a		;b2f8
	ld (0c256h),a		;b2fb
	jp L_B279		;b2fe
L_B301:
	ld a,091h		;b301
	call 05398h		;b303   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ret			;b306
L_B307:
	ld a,(0c24eh)		;b307   ; HL = tabla de la estrella del paso 0xC24E (0xB347)
	ld hl,0b347h		;b30a
	jp L_B27E		;b30d
L_B310:
	inc de			;b310   ; recorre B sprites del bloque (de 4 en 4 bytes) poniendoles el numero A
	ld (de),a			;b311
	inc de			;b312
	inc de			;b313
	inc de			;b314
	djnz L_B310		;b315
	ret			;b317

; ----------------------------------------------------------------------
; DATOS resto_B318: lo apuntan con el banco puesto p04:B2B0 (0xB323), p04:B2BB
;   (0xB33F), p04:B30A (0xB347); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p04:B2B0, p04:B2BB, p04:B30A (55 bytes)
;   0xb318..0xb34f  (55 bytes)
DATA_resto_B318:
	defb 07ch,012h,013h,07dh,012h,013h,013h,013h,010h,0f6h,0c9h,000h,020h,000h,0e0h,000h	; b318  |..}........ ...
	defb 020h,004h,0e0h,000h,020h,008h,0e0h,010h,020h,00ch,0e0h,010h,020h,010h,0e0h,010h	; b328   ... ... ... ...
	defb 020h,014h,0e0h,010h,020h,018h,0e0h,001h,00bh,00ch,001h,003h,00bh,00ch,0ffh,020h	; b338   ... ..........
	defb 030h,040h,050h,060h,070h,080h,090h	; b348

; ======================================================================
; CODIGO 0xb34f..0xb358  (9 bytes)
; ======================================================================


L_B34F:
	ld a,(0c251h)		;b34f   ; mueve las estrellas: 0xC251 elige por la tabla de 0xB358 y las desplaza por 0xB3F3
	ld hl,0b358h		;b352
	call 04066h		;b355   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B358: 3 destinos del despachador p00:4066 (call en p04:B355, el
;   indice en A): B35E, B366, B373; lo leen p04:B355 (6 bytes)
;   0xb358..0xb35e  (6 bytes)
DATA_tabla_B358:
	defw 0b35eh,0b366h,0b373h	; b358  -> L_B35E L_B366 L_B373

; ======================================================================
; CODIGO 0xb35e..0xb3a2  (68 bytes)
; ======================================================================


L_B35E:
	call L_B379		;b35e   ; lee el siguiente movimiento de la lista 0xB3A2 + 0xC24E: cuadros y desplazamiento X e Y
	ld hl,0c251h		;b361
	inc (hl)			;b364
	ret			;b365
L_B366:
	call L_B3F3		;b366   ; mueve los siete sprites 0xC252 veces: a cada uno le suma (0xC254, 0xC255)
	ld hl,0c252h		;b369
	dec (hl)			;b36c
	ret nz			;b36d
	xor a			;b36e
	ld (0c251h),a		;b36f
	ret			;b372
L_B373:
	call 04e83h		;b373   ; pone los sprites fuera de pantalla (0x4E83) y siguiente paso
	jp L_B279		;b376
L_B379:
	ld a,(0c24eh)		;b379   ; lee el siguiente movimiento de la lista 0xB3A2 + 0xC24E: cuadros y desplazamiento X e Y
	ld hl,0b3a2h		;b37c
	call 04d07h		;b37f   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c256h)		;b382
	ld b,a			;b385
	add a,a			;b386
	add a,b			;b387
	call L_B27E		;b388   ; A = byte A de la tabla HL
	cp 0ffh		;b38b
	jp z,L_B373		;b38d
	ld (0c252h),a		;b390
	inc hl			;b393
	ld a,(hl)			;b394
	ld (0c254h),a		;b395
	inc hl			;b398
	ld a,(hl)			;b399
	ld (0c255h),a		;b39a
	ld hl,0c256h		;b39d
	inc (hl)			;b3a0
	ret			;b3a1

; ----------------------------------------------------------------------
; DATOS resto_B3A2: lo apuntan con el banco puesto p04:B37C (0xB3A2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:B37C (81 bytes)
;   0xb3a2..0xb3f3  (81 bytes)
DATA_resto_B3A2:
	defb 0b2h,0b3h,0bch,0b3h,0c3h,0b3h,0cah,0b3h,0d1h,0b3h,0d8h,0b3h,0e2h,0b3h,0e9h,0b3h	; b3a2  ................
	defb 004h,0fch,000h,024h,000h,004h,008h,004h,000h,0ffh,01ch,000h,004h,008h,004h,000h	; b3b2  ...$............
	defb 0ffh,024h,000h,004h,00eh,004h,000h,0ffh,01ah,000h,004h,012h,004h,000h,0ffh,020h	; b3c2  .$.............
	defb 000h,004h,018h,004h,000h,0ffh,00ch,0fch,000h,012h,000h,004h,00eh,004h,000h,0ffh	; b3d2  ................
	defb 018h,000h,004h,014h,004h,000h,0ffh,014h,004h,000h,00ah,000h,004h,012h,0fch,000h	; b3e2  ................
	defb 0ffh	; b3f2

; ======================================================================
; CODIGO 0xb3f3..0xb418  (37 bytes)
; ======================================================================


L_B3F3:
	ld hl,0cc00h		;b3f3   ; suma el desplazamiento (0xC254, 0xC255) a los siete sprites de 0xCC00
	ld b,007h		;b3f6
L_B3F8:
	ld a,(0c255h)		;b3f8   ; mueve cada sprite de la estrella
	add a,(hl)			;b3fb   ; suma el desplazamiento Y
	ld (hl),a			;b3fc
	inc hl			;b3fd
	ld a,(0c254h)		;b3fe
	add a,(hl)			;b401   ; suma el desplazamiento X
	ld (hl),a			;b402
	inc hl			;b403
	inc hl			;b404
	inc hl			;b405
	djnz L_B3F8		;b406
	ret			;b408
L_B409:
	call 04e83h		;b409   ; quita_sprites: pone todos los sprites fuera de pantalla
	jp L_B270		;b40c
L_B40F:
	ld a,(0c250h)		;b40f   ; 0xC250 elige por la tabla de 0xB418 un paso del dibujo del marco (copia un cuadro de 48 x 48 de 0xB44C en 0xB43C)
	ld hl,0b418h		;b412
	call 04066h		;b415   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B418: 3 destinos del despachador p00:4066 (call en p04:B415, el
;   indice en A): B41E, B45C, B476; lo leen p04:B415 (6 bytes)
;   0xb418..0xb41e  (6 bytes)
DATA_tabla_B418:
	defw 0b41eh,0b45ch,0b476h	; b418  -> L_B41E L_B45C L_B476

; ======================================================================
; CODIGO 0xb41e..0xb43c  (30 bytes)
; ======================================================================


L_B41E:
	ld a,(0c24eh)		;b41e
	push af			;b421
	ld hl,0b43ch		;b422
	call 04d07h		;b425   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;b428
	ld d,h			;b429
	ld e,l			;b42a
	ld hl,0b44ch		;b42b
	call 04d07h		;b42e   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld bc,03030h		;b431
	ld a,001h		;b434
	call 05024h		;b436   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	jp L_B279		;b439

; ----------------------------------------------------------------------
; DATOS resto_B43C: lo apuntan con el banco puesto p04:B422 (0xB43C), p04:B45F
;   (0xB43C), p04:B42B (0xB44C); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p04:B422, p04:B45F, p04:B42B (32 bytes)
;   0xb43c..0xb45c  (32 bytes)
DATA_resto_B43C:
	defb 090h,020h,070h,040h,090h,068h,068h,088h,080h,0b0h,048h,068h,060h,0c0h,028h,088h	; b43c  . p@.hh...Hh`.(.
	defb 070h,030h,070h,000h,070h,090h,040h,090h,040h,000h,040h,060h,070h,060h,040h,030h	; b44c  p0p.p.@.@.@`p`@0

; ======================================================================
; CODIGO 0xb45c..0xb535  (217 bytes)
; ======================================================================


L_B45C:
	ld a,(0c24eh)		;b45c   ; pone un marco de 8 x 8 tiles (0xB4B9) alrededor del cuadro
	ld hl,0b43ch		;b45f
	call 04d07h		;b462   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,h			;b465
	sub 008h		;b466
	ld d,a			;b468
	ld a,l			;b469
	sub 008h		;b46a
	ld e,a			;b46c
	ld hl,00808h		;b46d
	call L_B4B9		;b470   ; dibuja un marco de tiles 0x14..0x1B con esquinas (para la ventana con borde de dibujo)
	jp L_B279		;b473
L_B476:
	jp L_B270		;b476
L_B479:
	ld a,(0c24eh)		;b479   ; prepara el texto que acompana: si es la 0xC24E = 0 borra el rectangulo (0xB493); lista de tiles de 0xB535
	or a			;b47c
	push af			;b47d
	call z,L_B493		;b47e   ; rectangulo de la ventana (0x142C) borrado y ventana nueva de 10 x 8
	pop af			;b481
	ld hl,0b535h		;b482
	call 04d07h		;b485   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call 05363h		;b488   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	ld a,0b4h		;b48b
	ld (0c252h),a		;b48d
	jp L_B270		;b490
L_B493:
	ld hl,0142ch		;b493   ; rectangulo de la ventana (0x142C) borrado y ventana nueva de 10 x 8
	ld bc,04838h		;b496
	xor a			;b499
	ld d,000h		;b49a
	call 04fe5h		;b49c   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,01028h		;b49f
	ld hl,00a08h		;b4a2
	jp 09d1ch		;b4a5   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
L_B4A8:
	ld hl,0c252h		;b4a8   ; espera 0xC252 cuadros, borra el rectangulo (0xB528) y pasa a la siguiente estrella
	dec (hl)			;b4ab
	ret nz			;b4ac
	call L_B528		;b4ad   ; rellena de ceros el rectangulo 0x1830 de 64 x 48 (borra la ventana)
	ld hl,0c24eh		;b4b0
	inc (hl)			;b4b3
	xor a			;b4b4
	ld (0c24fh),a		;b4b5
	ret			;b4b8
L_B4B9:
	ld a,014h		;b4b9   ; dibuja un marco de tiles 0x14..0x1B con esquinas (para la ventana con borde de dibujo)
	call 05398h		;b4bb   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,h			;b4be
	dec a			;b4bf
	dec a			;b4c0
	ld b,a			;b4c1
L_B4C2:
	push bc			;b4c2
	ld a,d			;b4c3
	add a,008h		;b4c4
	ld d,a			;b4c6
	push de			;b4c7
	ld a,018h		;b4c8
	call 05398h		;b4ca   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;b4cd
	pop bc			;b4ce
	djnz L_B4C2		;b4cf
	ld a,d			;b4d1
	add a,008h		;b4d2
	ld d,a			;b4d4
	ld a,015h		;b4d5
	call 05398h		;b4d7   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,l			;b4da
	dec a			;b4db
	dec a			;b4dc
	ld b,a			;b4dd
L_B4DE:
	push bc			;b4de
	ld a,e			;b4df
	add a,008h		;b4e0
	ld e,a			;b4e2
	push de			;b4e3
	ld a,01ah		;b4e4
	call 05398h		;b4e6   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;b4e9
	pop bc			;b4ea
	djnz L_B4DE		;b4eb
	ld a,e			;b4ed
	add a,008h		;b4ee
	ld e,a			;b4f0
	ld a,016h		;b4f1
	call 05398h		;b4f3   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,h			;b4f6
	dec a			;b4f7
	dec a			;b4f8
	ld b,a			;b4f9
L_B4FA:
	push bc			;b4fa
	ld a,d			;b4fb
	sub 008h		;b4fc
	ld d,a			;b4fe
	push de			;b4ff
	ld a,01bh		;b500
	call 05398h		;b502   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;b505
	pop bc			;b506
	djnz L_B4FA		;b507
	ld a,d			;b509
	sub 008h		;b50a
	ld d,a			;b50c
	ld a,017h		;b50d
	call 05398h		;b50f   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,l			;b512
	dec a			;b513
	dec a			;b514
	ld b,a			;b515
L_B516:
	push bc			;b516   ; lado izquierdo del marco con el tile 0x19
	ld a,e			;b517
	sub 008h		;b518
	ld e,a			;b51a
	push de			;b51b
	ld a,088h		;b51c
	ld a,019h		;b51e
	call 05398h		;b520   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;b523
	pop bc			;b524
	djnz L_B516		;b525
	ret			;b527
L_B528:
	ld hl,01830h		;b528   ; rellena de ceros el rectangulo 0x1830 de 64 x 48 (borra la ventana)
	ld bc,04030h		;b52b
	xor a			;b52e
	ld d,000h		;b52f
	call 04fe5h		;b531   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;b534

; ----------------------------------------------------------------------
; DATOS resto_B535: lo apuntan con el banco puesto p04:B482 (0xB535); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:B482 (331 bytes)
;   0xb535..0xb680  (331 bytes)
DATA_resto_B535:
	defb 045h,0b5h,06ch,0b5h,092h,0b5h,0b8h,0b5h,0e0h,0b5h,005h,0b6h,02eh,0b6h,056h,0b6h	; b535  E.l...........V.
	defb 018h,030h,060h,060h,065h,061h,0feh,018h,040h,0aah,0abh,0ach,0adh,092h,093h,094h	; b545  .0``ea..@.......
	defb 095h,0feh,018h,048h,0aeh,0afh,0b0h,0b1h,096h,097h,098h,099h,0feh,018h,058h,0e1h	; b555  ...H..........X.
	defb 0e2h,0e3h,0e4h,0e5h,0e6h,0e0h,0ffh,018h,030h,074h,07eh,068h,061h,0feh,018h,040h	; b565  ........0t~ha..@
	defb 0cah,0cbh,0c4h,0c5h,092h,093h,094h,095h,0feh,018h,048h,0cch,0cdh,0c8h,0c9h,096h	; b575  ..........H.....
	defb 097h,098h,099h,0feh,018h,058h,0f9h,0fah,0fbh,0fch,0fdh,0d8h,0ffh,018h,030h,068h	; b585  .....X........0h
	defb 072h,06ch,0feh,018h,040h,033h,034h,035h,036h,092h,093h,094h,095h,0feh,018h,048h	; b595  rl..@3456......H
	defb 037h,038h,039h,03ah,096h,097h,098h,099h,0feh,018h,058h,01ch,01ch,01ch,01ch,01ch	; b5a5  789:......X.....
	defb 01ch,01dh,0ffh,018h,030h,07fh,080h,081h,082h,0feh,018h,040h,0c2h,0c3h,0c4h,0c5h	; b5b5  ....0......@....
	defb 092h,093h,094h,095h,0feh,018h,048h,0c6h,0c7h,0c8h,0c9h,096h,097h,098h,099h,0feh	; b5c5  ......H.........
	defb 018h,058h,0f4h,0f5h,0f0h,0f1h,0f6h,0f7h,0f8h,0e0h,0ffh,018h,030h,073h,068h,061h	; b5d5  .X..........0sha
	defb 0feh,018h,040h,0b2h,0b3h,0b4h,0b5h,092h,093h,094h,095h,0feh,018h,048h,0b6h,0b7h	; b5e5  ..@..........H..
	defb 0b8h,0b9h,096h,097h,098h,099h,0feh,018h,058h,0e7h,0e8h,0e9h,0eah,0ebh,0ech,0ffh	; b5f5  ........X.......
	defb 018h,030h,070h,07bh,07ch,062h,07dh,032h,0feh,018h,040h,09ah,09bh,09ch,09dh,092h	; b605  .0p{|b}2..@.....
	defb 093h,094h,095h,0feh,018h,048h,09eh,09fh,0a0h,0a1h,096h,097h,098h,099h,0feh,018h	; b615  .....H..........
	defb 058h,0d6h,0d7h,0d6h,0d7h,0d6h,0d7h,0d8h,0ffh,018h,030h,075h,061h,076h,061h,0feh	; b625  X.........0uava.
	defb 018h,040h,0a2h,0a3h,0a4h,0a5h,092h,093h,094h,095h,0feh,018h,048h,0a6h,0a7h,0a8h	; b635  .@..........H...
	defb 0a9h,096h,097h,098h,099h,0feh,018h,058h,0d9h,0dah,0dbh,0dch,0ddh,0deh,0dfh,0e0h	; b645  .......X........
	defb 0ffh,018h,030h,072h,077h,065h,078h,079h,032h,07ah,0feh,018h,040h,0bah,0bbh,0bch	; b655  ..0rwexy2z..@...
	defb 0bdh,092h,093h,094h,095h,0feh,018h,048h,0beh,0bfh,0c0h,0c1h,096h,097h,098h,099h	; b665  .......H........
	defb 0feh,018h,058h,0edh,0eeh,0efh,0f0h,0f1h,0f2h,0f3h,0ffh	; b675  ..X........

; ======================================================================
; CODIGO 0xb680..0xb6ea  (106 bytes)
; ======================================================================


L_B680:
	call 0405ch		;b680   ; A = el byte A de la tabla HL
	ld a,(hl)			;b683
	ret			;b684
L_B685:
	inc (ix+000h)		;b685   ; el objeto ix pasa al paso siguiente: (ix+0) += 1 y (ix+1) = 0
	ld a,0ffh		;b688
	ld (ix+001h),a		;b68a
L_B68D:
	inc (ix+001h)		;b68d   ; (ix+1) += 1: sigue en el mismo estado
	ret			;b690
L_B691:
	dec (ix+003h)		;b691   ; baja el temporizador (ix+3)
	ret			;b694
L_B695:
	xor a			;b695   ; inicia las caras de los rivales: pone a cero 0xC300, 0xC301 y 0xC25D (34 bytes), y pone los sprites fuera de pantalla
	ld (0c300h),a		;b696
	ld (0c301h),a		;b699
	ld hl,0c25dh		;b69c
	ld (hl),a			;b69f
	ld de,0c25eh		;b6a0
	ld bc,00021h		;b6a3
	ldir		;b6a6
	call 04e83h		;b6a8   ; quita_sprites: pone todos los sprites fuera de pantalla
	ret			;b6ab
anima_rivales:		; anima las caras de los tres rivales
	call L_BA72		;b6ac   ; ANIMACION DE LOS RIVALES: dibuja con 0xBA72 y para cada uno de los tres (B = 3, 2, 1) apunta ix a su objeto de 11 bytes en 0xC25D
	ld b,003h		;b6af
L_B6B1:
	push bc			;b6b1
	ld a,b			;b6b2
	ld hl,0b6eah		;b6b3
	call L_B680		;b6b6   ; A = el byte A de la tabla HL
	ld hl,0c25dh		;b6b9
	call 0405ch		;b6bc   ; suma_a_hl: HL = HL + A
	push hl			;b6bf
	pop ix		;b6c0
	ld a,004h		;b6c2   ; (ix+4) = 1 si el rival es quien ha ganado (0xC207), 0xC275 = su numero, 0xC276 = el personaje que es
	sub b			;b6c4
	ld (0c275h),a		;b6c5
	ld hl,0c030h		;b6c8   ; apunta a el personaje que se sienta en cada sitio (4 bytes)
	call 0405ch		;b6cb   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b6ce
	ld (0c276h),a		;b6cf
	xor a			;b6d2
	ld c,a			;b6d3
	ld a,(0c207h)		;b6d4   ; lee el jugador al que le toca (0 = el humano)
	ld b,a			;b6d7
	ld a,(0c275h)		;b6d8
	cp b			;b6db
	jr nz,L_B6DF		;b6dc
	inc c			;b6de
L_B6DF:
	ld a,c			;b6df
	ld (ix+004h),a		;b6e0
	call L_B78B		;b6e3   ; un paso de este rival: 0xC27F += 1, mueve su cara con 0xB87A, 0xBCF4, 0xBD5E, 0xBEF9 y 0xBA72; (ix+0) elige por la tabla de 0xB7A7
	pop bc			;b6e6
	djnz L_B6B1		;b6e7
	ret			;b6e9

; ----------------------------------------------------------------------
; DATOS resto_B6EA: lo apuntan con el banco puesto p04:B6B3 (0xB6EA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:B6B3 (4 bytes)
;   0xb6ea..0xb6ee  (4 bytes)
DATA_resto_B6EA:
	defb 000h,010h,008h,000h	; b6ea

; ======================================================================
; CODIGO 0xb6ee..0xb70e  (32 bytes)
; ======================================================================


L_B6EE:
	push hl			;b6ee   ; pone en (ix+3) el tiempo que dura el cuadro de esta cara (tabla 0xB70E o 0xB720)
	push af			;b6ef
	ld hl,0b70eh		;b6f0
	ld a,(ix+004h)		;b6f3
	or a			;b6f6
	jr z,L_B6FC		;b6f7
	ld hl,0b720h		;b6f9
L_B6FC:
	ld a,(0c276h)		;b6fc
	call 04d07h		;b6ff   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(ix+001h)		;b702
	call L_B680		;b705   ; A = el byte A de la tabla HL
	ld (ix+003h),a		;b708
	pop af			;b70b
	pop hl			;b70c
	ret			;b70d

; ----------------------------------------------------------------------
; DATOS resto_B70E: lo apuntan con el banco puesto p04:B6F0 (0xB70E), p04:B6F9
;   (0xB720); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p04:B6F0, p04:B6F9 (121 bytes)
;   0xb70e..0xb787  (121 bytes)
DATA_resto_B70E:
	defb 032h,0b7h,037h,0b7h,03ch,0b7h,041h,0b7h,046h,0b7h,04bh,0b7h,050h,0b7h,055h,0b7h	; b70e  2.7.<.A.F.K.P.U.
	defb 05ah,0b7h,032h,0b7h,05fh,0b7h,064h,0b7h,069h,0b7h,06eh,0b7h,073h,0b7h,078h,0b7h	; b71e  Z.2._.d.i.n.s.x.
	defb 07dh,0b7h,082h,0b7h,020h,020h,020h,020h,020h,010h,015h,015h,015h,015h,001h,020h	; b72e  }...     ......
	defb 010h,020h,020h,010h,008h,008h,008h,010h,006h,006h,00ah,00ch,010h,010h,007h,007h	; b73e  .  .............
	defb 007h,008h,004h,004h,004h,002h,002h,010h,010h,010h,010h,010h,002h,005h,002h,005h	; b74e  ................
	defb 001h,00ch,00ch,00ch,00ch,00ch,010h,020h,010h,020h,020h,008h,008h,008h,008h,020h	; b75e  ....... .  ....
	defb 010h,010h,010h,010h,010h,00dh,00dh,00dh,00dh,011h,008h,008h,008h,008h,008h,008h	; b76e  ................
	defb 010h,010h,010h,008h,00ch,007h,007h,007h,005h	; b77e  .........

; ======================================================================
; CODIGO 0xb787..0xb7a7  (32 bytes)
; ======================================================================


L_B787:
	dec (ix+003h)		;b787   ; baja el temporizador (ix+3)
	ret			;b78a
L_B78B:
	ld hl,0c27fh		;b78b   ; un paso de este rival: 0xC27F += 1, mueve su cara con 0xB87A, 0xBCF4, 0xBD5E, 0xBEF9 y 0xBA72; (ix+0) elige por la tabla de 0xB7A7
	inc (hl)			;b78e
	call L_B87A		;b78f   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	call L_BCF4		;b792   ; solo en los cuadros pares y si no es el humano
	call L_BD5E		;b795   ; gesto del personaje 1 (parpadeo): tabla 0xBD84
	call L_BEF9		;b798   ; gestos del personaje 8: 0xC300 elige el paso por la tabla de 0xBF15
	call L_BA72		;b79b   ; copia los colores de los sprites: a cada sprite de 0xCC00 le pone color 0 si su Y es 0xE0
	ld a,(ix+000h)		;b79e
	ld hl,0b7a7h		;b7a1
	call 04066h		;b7a4   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B7A7: 4 destinos del despachador p00:4066 (call en p04:B7A4, el
;   indice en A): B7AF, B7BA, B7F3, B838; lo leen p04:B7A4 (8 bytes)
;   0xb7a7..0xb7af  (8 bytes)
DATA_tabla_B7A7:
	defw 0b7afh,0b7bah,0b7f3h,0b838h	; b7a7  -> L_B7AF L_B7BA L_B7F3 L_B838

; ======================================================================
; CODIGO 0xb7af..0xb88e  (223 bytes)
; ======================================================================


L_B7AF:
	call 04e83h		;b7af   ; quita_sprites: pone todos los sprites fuera de pantalla
	ld a,020h		;b7b2
	ld (ix+003h),a		;b7b4
	jp L_B685		;b7b7
L_B7BA:
	call L_B787		;b7ba   ; espera el temporizador y luego dibuja el gesto de la cara (tablas 0xB896 y 0xB8A8, por personaje)
	ret nz			;b7bd
	call L_B87A		;b7be   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	ld hl,0b8a8h		;b7c1
	ld a,(ix+004h)		;b7c4
	or a			;b7c7
	jr z,L_B7CD		;b7c8
	ld hl,0b896h		;b7ca
L_B7CD:
	ld a,(0c276h)		;b7cd
	call 04d07h		;b7d0   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call L_B846		;b7d3   ; dibuja un dibujo de tiles de HL (X, Y, tiles... 0xFE = nueva linea, 0xFF = acaba) con la posicion de (ix+5, ix+6)
	ld (ix+007h),001h		;b7d6
	ld b,008h		;b7da
	call L_B7E5		;b7dc   ; si es el rival 1 del personaje 1 el gesto dura 2 (si no 8)
	ld (ix+003h),b		;b7df
	jp L_B685		;b7e2
L_B7E5:
	ld a,(ix+004h)		;b7e5   ; si es el rival 1 del personaje 1 el gesto dura 2 (si no 8)
	or a			;b7e8
	ret nz			;b7e9
	ld a,(0c276h)		;b7ea
	cp 001h		;b7ed
	ret nz			;b7ef
	ld b,002h		;b7f0
	ret			;b7f2
L_B7F3:
	call L_BE29		;b7f3   ; gesto de despues: acaba con el gesto de 0xBAB0 o 0xBAA7 y la boca (0xBAB9)
	call L_B787		;b7f6   ; baja el temporizador (ix+3)
	ret nz			;b7f9
	ld a,001h		;b7fa
	ld (0c27eh),a		;b7fc
	call L_B87A		;b7ff   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	ld hl,0bab0h		;b802
	ld a,(ix+004h)		;b805
	or a			;b808
	jr z,L_B82C		;b809
	ld hl,0baa7h		;b80b
L_B80E:
	ld a,(0c276h)		;b80e
	call L_B680		;b811   ; A = el byte A de la tabla HL
	or a			;b814
	jr z,L_B81E		;b815
	cp 011h		;b817
	jr nc,L_B81E		;b819
	call L_BAB9		;b81b   ; sonido y boca por el codigo del personaje: tabla 0xBABF
L_B81E:
	call L_B6EE		;b81e   ; pone en (ix+3) el tiempo que dura el cuadro de esta cara (tabla 0xB70E o 0xB720)
	ld a,(ix+001h)		;b821
	cp 004h		;b824
	jp c,L_B68D		;b826
	jp L_B685		;b829
L_B82C:
	ld a,(0c276h)		;b82c
	cp 007h		;b82f
	jr nz,L_B80E		;b831
	call L_BCC9		;b833   ; dibuja el gesto de la tabla 0xBCD6 segun el cuadro (ix+1)
	jr L_B81E		;b836
L_B838:
	call L_B787		;b838   ; espera y quita el gesto: vuelve al estado 0
	ret nz			;b83b
	call L_B6EE		;b83c   ; pone en (ix+3) el tiempo que dura el cuadro de esta cara (tabla 0xB70E o 0xB720)
	xor a			;b83f
	ld (ix+000h),a		;b840
	jp L_B685		;b843
L_B846:
	ld d,(hl)			;b846   ; dibuja un dibujo de tiles de HL (X, Y, tiles... 0xFE = nueva linea, 0xFF = acaba) con la posicion de (ix+5, ix+6)
	inc hl			;b847
	ld e,(hl)			;b848
	inc hl			;b849
	ld a,(ix+005h)		;b84a
	add a,d			;b84d
	ld d,a			;b84e
	ld a,(ix+006h)		;b84f
	add a,e			;b852
	ld e,a			;b853
L_B854:
	ld a,(hl)			;b854   ; siguiente tile de la lista de la cara
	inc hl			;b855
	cp 0feh		;b856
	jr z,L_B846		;b858
	cp 0ffh		;b85a
	jr z,L_B867		;b85c
	call L_B868		;b85e   ; pinta un tile (0x53DE) de 8 x 8 desde la pagina 1 a la pagina 0
	ld a,008h		;b861
	add a,d			;b863
	ld d,a			;b864
	jr L_B854		;b865
L_B867:
	ret			;b867
L_B868:
	push bc			;b868   ; pinta un tile (0x53DE) de 8 x 8 desde la pagina 1 a la pagina 0
	push hl			;b869
	push de			;b86a
	call 053deh		;b86b   ; origen_tile: HL = el origen en la hoja de tiles del tile A
	ld bc,00808h		;b86e
	ld a,001h		;b871
	call 05024h		;b873   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	pop de			;b876
	pop hl			;b877
	pop bc			;b878
	ret			;b879
L_B87A:
	ld a,(0c275h)		;b87a   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	add a,a			;b87d
	ld hl,0b88eh		;b87e
	call 0405ch		;b881   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b884
	ld (ix+005h),a		;b885
	inc hl			;b888
	ld a,(hl)			;b889
	ld (ix+006h),a		;b88a
	ret			;b88d

; ----------------------------------------------------------------------
; DATOS resto_B88E: lo apuntan con el banco puesto p04:B87E (0xB88E), p04:B7CA
;   (0xB896), p04:B7C1 (0xB8A8), p04:BCAC (0xBA5B); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p04:B87E, p04:B7CA,
;   p04:B7C1, p04:BCAC (484 bytes)
;   0xb88e..0xba72  (484 bytes)
DATA_resto_B88E:
	defb 000h,000h,0c0h,048h,068h,010h,010h,048h,0bah,0b8h,0c0h,0b8h,0feh,0b8h,089h,0b9h	; b88e  ...Hh..H........
	defb 0b6h,0b9h,01bh,0b9h,05bh,0b9h,006h,0bah,05bh,0bah,0bdh,0b8h,0efh,0b8h,00ch,0b9h	; b89e  ....[...[.......
	defb 099h,0b9h,0d8h,0b9h,03ch,0b9h,06bh,0b9h,034h,0bah,06fh,0bah,000h,000h,0ffh,000h	; b8ae  ....<.k.4.o.....
	defb 000h,0ffh,008h,000h,0a1h,0feh,020h,000h,0a2h,0feh,008h,008h,09bh,0feh,020h,008h	; b8be  ...... ....... .
	defb 09ch,0feh,008h,010h,0a4h,019h,0a3h,09dh,0feh,008h,018h,0d1h,0d2h,0d3h,0d4h,0d5h	; b8ce  ................
	defb 0feh,008h,020h,0d6h,0d7h,0d8h,0d9h,0dah,0feh,008h,028h,0deh,0dbh,0dch,0ddh,0d0h	; b8de  .. .......(.....
	defb 0ffh,010h,010h,0beh,0bfh,0feh,010h,018h,0c0h,0c1h,0feh,010h,020h,0c2h,0c3h,0ffh	; b8ee  ............ ...
	defb 010h,010h,0a0h,0a7h,0feh,010h,018h,09ah,01ch,0feh,018h,020h,01dh,0ffh,010h,018h	; b8fe  ........... ....
	defb 0bch,020h,0feh,018h,020h,011h,0cfh,0feh,018h,028h,0a5h,0a6h,0ffh,000h,008h,07ah	; b90e  . .. ....(.....z
	defb 0feh,000h,010h,0abh,0b5h,0feh,008h,018h,0adh,01fh,09eh,0feh,000h,020h,00ch,07bh	; b91e  ............. .{
	defb 07ch,07dh,07eh,00ch,0feh,000h,028h,00ch,05dh,079h,078h,09fh,00ch,0ffh,000h,000h	; b92e  |}~...(.]yx.....
	defb 001h,002h,003h,004h,005h,006h,0feh,000h,008h,007h,065h,061h,062h,063h,064h,0feh	; b93e  ..........eabcd.
	defb 000h,010h,008h,0b0h,0b1h,0b2h,0feh,008h,018h,0b3h,014h,0b4h,0ffh,008h,018h,0cbh	; b94e  ................
	defb 01eh,072h,0feh,020h,020h,0e5h,080h,0feh,020h,028h,0fch,081h,0ffh,008h,000h,0e0h	; b95e  .r.  ... (......
	defb 0e1h,0feh,008h,008h,066h,067h,068h,0feh,000h,010h,0cdh,069h,06ah,06bh,06ch,0feh	; b96e  ....fgh....ijkl.
	defb 000h,018h,0cch,0e2h,0e3h,0e4h,0feh,010h,020h,013h,0ffh,000h,020h,0ebh,0e7h,082h	; b97e  ........ ... ...
	defb 083h,0eah,0feh,000h,028h,0edh,0ech,0e8h,0e9h,0e6h,0ffh,018h,008h,04ah,04bh,0feh	; b98e  ....(........JK.
	defb 018h,010h,0aeh,0afh,0feh,018h,018h,0fah,0fbh,0feh,008h,020h,044h,045h,046h,047h	; b99e  ........... DEFG
	defb 0feh,008h,028h,0eeh,0efh,0f0h,0f1h,0ffh,010h,000h,0c9h,0cah,0feh,010h,008h,051h	; b9ae  ..(............Q
	defb 052h,0feh,008h,010h,053h,054h,055h,056h,0feh,008h,018h,032h,033h,034h,035h,0feh	; b9be  R...STUV...2345.
	defb 010h,020h,036h,037h,0feh,010h,028h,059h,058h,0ffh,008h,000h,024h,039h,021h,022h	; b9ce  . 67..(YX...$9!"
	defb 0feh,000h,008h,00ch,023h,057h,050h,025h,026h,0feh,000h,010h,00ch,027h,028h,029h	; b9de  ....#WP%&....'()
	defb 02ah,02bh,0feh,000h,018h,00ch,00ch,02ch,02dh,02eh,02fh,0feh,008h,020h,03ah,030h	; b9ee  *+.....,-./.. :0
	defb 031h,05ch,0feh,010h,028h,05ah,05bh,0ffh,008h,008h,085h,03bh,03ch,086h,00bh,0feh	; b9fe  1\..(Z[.....<...
	defb 000h,010h,03fh,087h,0a8h,0a9h,088h,089h,0feh,000h,018h,03dh,03eh,0b6h,0b7h,0bdh	; ba0e  ..?........=>...
	defb 060h,0feh,000h,020h,08ah,08bh,0feh,020h,020h,042h,084h,0feh,000h,028h,08ch,040h	; ba1e  `.. ...  B...(.@
	defb 0feh,020h,028h,041h,08dh,0ffh,008h,008h,08eh,048h,049h,08fh,0feh,008h,010h,091h	; ba2e  . (A.....HI.....
	defb 0b9h,0bah,090h,0feh,010h,018h,0b8h,0bbh,0feh,000h,020h,092h,093h,0feh,020h,020h	; ba3e  .......... ...
	defb 097h,096h,0feh,000h,028h,094h,095h,0feh,020h,028h,099h,098h,0ffh,008h,018h,0f2h	; ba4e  ....(... (......
	defb 0feh,020h,018h,0f3h,0feh,008h,020h,0f4h,0f5h,0f6h,0f7h,0feh,010h,028h,0f8h,0f9h	; ba5e  . .... ......(..
	defb 0ffh,000h,000h,0ffh	; ba6e

; ======================================================================
; CODIGO 0xba72..0xbaa2  (48 bytes)
; ======================================================================


L_BA72:
	ld hl,0cc00h		;ba72   ; copia los colores de los sprites: a cada sprite de 0xCC00 le pone color 0 si su Y es 0xE0
	ld de,0ca00h		;ba75   ; apunta a los colores de los sprites (4 bloques de 16)
	ld b,020h		;ba78
L_BA7A:
	inc hl			;ba7a   ; copia el color de cada sprite
	inc hl			;ba7b
	inc hl			;ba7c
	ld a,(hl)			;ba7d
	inc hl			;ba7e
	cp 0e0h		;ba7f
	jr nz,L_BA84		;ba81
	xor a			;ba83
L_BA84:
	push bc			;ba84
	ld b,010h		;ba85
L_BA87:
	ld (de),a			;ba87   ; rellena los 16 bytes de color
	inc de			;ba88
	djnz L_BA87		;ba89
	pop bc			;ba8b
	djnz L_BA7A		;ba8c
	ret			;ba8e
L_BA8F:
	push hl			;ba8f   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
	ld a,(0c275h)		;ba90
	ld hl,0baa2h		;ba93
	call L_B680		;ba96   ; A = el byte A de la tabla HL
	ld hl,0cc00h		;ba99   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	call 0405ch		;ba9c   ; suma_a_hl: HL = HL + A
	ex de,hl			;ba9f
	pop hl			;baa0
	ret			;baa1

; ----------------------------------------------------------------------
; DATOS resto_BAA2: lo apuntan con el banco puesto p04:BA93 (0xBAA2), p04:B80B
;   (0xBAA7), p04:B802 (0xBAB0); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p04:BA93, p04:B80B, p04:B802 (23 bytes)
;   0xbaa2..0xbab9  (23 bytes)
DATA_resto_BAA2:
	defb 000h,000h,020h,040h,060h,000h,001h,002h,003h,004h,005h,006h,007h,008h,000h,009h	; baa2  .. @`...........
	defb 00ah,00bh,00ch,00dh,00eh,00fh,010h	; bab2

; ======================================================================
; CODIGO 0xbab9..0xbabf  (6 bytes)
; ======================================================================


L_BAB9:
	ld hl,0babfh		;bab9   ; sonido y boca por el codigo del personaje: tabla 0xBABF
	call 04066h		;babc   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BABF: 18 destinos del despachador p00:4066 (call en p04:BABC, el
;   indice en A): BB3D, BB3A, BB3D, BB32, BB28, BAE8, BB3A, BB1B, BB3E, BB3A,
;   BB2D, BB3A, BB20, BAE3, BB3D, BB3D, BB3D, BB3D; lo leen p04:BABC (36
;   bytes)
;   0xbabf..0xbae3  (36 bytes)
DATA_tabla_BABF:
	defw 0bb3dh,0bb3ah,0bb3dh,0bb32h,0bb28h,0bae8h,0bb3ah,0bb1bh	; babf
	defw 0bb3eh,0bb3ah,0bb2dh,0bb3ah,0bb20h,0bae3h,0bb3dh,0bb3dh	; bacf
	defw 0bb3dh,0bb3dh	; badf  -> L_BB3D L_BB3D

; ======================================================================
; CODIGO 0xbae3..0xbb46  (99 bytes)
; ======================================================================


L_BAE3:
	ld hl,0bb7ch		;bae3   ; dibuja el cuadro de la cara de 0xBB7C (tabla de sprites): cada cuatro bytes (Y, X, patron, color) con la posicion de (ix+5, ix+6)
	jr L_BAEE		;bae6
L_BAE8:
	call L_BCB3		;bae8   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
	ld hl,0bb46h		;baeb
L_BAEE:
	ld a,(ix+001h)		;baee
	call 04d07h		;baf1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call L_BA8F		;baf4   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
L_BAF7:
	ld a,(hl)			;baf7   ; un sprite del cuadro de la cara: Y, X, patron y color
	inc hl			;baf8
	cp 0ffh		;baf9
	ret z			;bafb
	cp 0e0h		;bafc
	jr z,L_BB03		;bafe
	add a,(ix+006h)		;bb00
L_BB03:
	ld (de),a			;bb03   ; ajusta la X con la posicion de la cara
	inc de			;bb04
	ld a,(hl)			;bb05
	inc hl			;bb06
	cp 0e0h		;bb07
	jr z,L_BB0E		;bb09
	add a,(ix+005h)		;bb0b
L_BB0E:
	ld (de),a			;bb0e   ; copia el patron y el color
	inc de			;bb0f
	ld a,(hl)			;bb10
	inc hl			;bb11
	ld b,(hl)			;bb12   ; el patron y el color
	inc hl			;bb13
	ld (de),a			;bb14
	inc de			;bb15
	ld a,b			;bb16
	ld (de),a			;bb17
	inc de			;bb18
	jr L_BAF7		;bb19   ; sigue con el siguiente sprite
L_BB1B:
	ld hl,0bb95h		;bb1b
	jr L_BAEE		;bb1e
L_BB20:
	call L_BCB3		;bb20   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
	ld hl,0bbb9h		;bb23
	jr L_BAEE		;bb26
L_BB28:
	ld hl,0bbd5h		;bb28
	jr L_BAEE		;bb2b
L_BB2D:
	ld hl,0bc54h		;bb2d
	jr L_BAEE		;bb30
L_BB32:
	call L_BCB3		;bb32   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
	ld hl,0bc78h		;bb35
	jr L_BAEE		;bb38
L_BB3A:
	call L_BCB3		;bb3a   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
L_BB3D:
	ret			;bb3d
L_BB3E:
	call L_BCA5		;bb3e   ; si la cara lleva menos de 2 cuadros pone la cabeza de 0xBA5B
	ld hl,0bc87h		;bb41
	jr L_BAEE		;bb44

; ----------------------------------------------------------------------
; DATOS resto_BB46: lo apuntan con el banco puesto p04:BAEB (0xBB46), p04:BAE3
;   (0xBB7C), p04:BB1B (0xBB95), p04:BB23 (0xBBB9), p04:BB28 (0xBBD5),
;   p04:BEB0 (0xBC33); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p04:BAEB, p04:BAE3, p04:BB1B, p04:BB23, p04:BB28,
;   p04:BEB0 (351 bytes)
;   0xbb46..0xbca5  (351 bytes)
DATA_resto_BB46:
	defb 050h,0bbh,055h,0bbh,062h,0bbh,06fh,0bbh,050h,0bbh,00fh,010h,000h,00fh,0ffh,011h	; bb46  P.U.b.o.P.......
	defb 010h,000h,00fh,021h,00fh,004h,00fh,021h,00fh,008h,009h,0ffh,010h,00dh,000h,00fh	; bb56  ...!...!........
	defb 021h,00fh,004h,00fh,021h,00fh,008h,009h,0ffh,00eh,00fh,000h,00fh,0e0h,0e0h,0e0h	; bb66  !...!...........
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0ffh,033h,0bch,086h,0bbh,08bh,0bbh,090h,0bbh,033h,0bch	; bb76  ......3.......3.
	defb 017h,000h,040h,00eh,0ffh,00eh,000h,044h,00eh,0ffh,00eh,000h,0a4h,00eh,0ffh,09fh	; bb86  ..@....D........
	defb 0bbh,0ach,0bbh,09fh,0bbh,0ach,0bbh,09fh,0bbh,000h,028h,020h,00eh,000h,028h,024h	; bb96  ..........( ..($
	defb 00fh,0e0h,0e0h,0e0h,0e0h,0ffh,000h,028h,014h,00eh,000h,028h,018h,009h,000h,028h	; bba6  .......(...(...(
	defb 01ch,00fh,0ffh,0c3h,0bbh,0c3h,0bbh,0c8h,0bbh,033h,0bch,033h,0bch,010h,000h,00ch	; bbb6  .........3.3....
	defb 009h,0ffh,010h,000h,00ch,009h,010h,0f8h,010h,009h,010h,0f8h,030h,00dh,0ffh,0dfh	; bbc6  ............0...
	defb 0bbh,0e8h,0bbh,0f9h,0bbh,012h,0bch,033h,0bch,01dh,0fbh,028h,00dh,01dh,0fbh,0a0h	; bbd6  .......3...(....
	defb 00fh,0ffh,01dh,0fbh,028h,00dh,01dh,0fbh,0a0h,00fh,0fch,028h,028h,00dh,0fch,028h	; bbe6  ....(......((..(
	defb 0a0h,00fh,0ffh,01dh,0fbh,028h,00dh,01dh,0fbh,0a0h,00fh,0fch,028h,028h,00dh,0fch	; bbf6  .....(......((..
	defb 028h,0a0h,00fh,0fdh,0fdh,028h,00dh,0fdh,0fdh,0a0h,00fh,0ffh,01dh,0fbh,028h,00dh	; bc06  (....(........(.
	defb 01dh,0fbh,0a0h,00fh,0fch,028h,028h,00dh,0fch,028h,0a0h,00fh,0fdh,0fdh,028h,00dh	; bc16  .....((..(....(.
	defb 0fdh,0fdh,0a0h,00fh,018h,028h,028h,00dh,018h,028h,0a0h,00fh,0ffh,0e0h,0e0h,0e0h	; bc26  .....((..(......
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; bc36  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0ffh,05eh,0bch	; bc46  ..............^.
	defb 06bh,0bch,05eh,0bch,06bh,0bch,05eh,0bch,01fh,018h,048h,00fh,01fh,018h,04ch,002h	; bc56  k.^.k.^...H...L.
	defb 01fh,018h,050h,001h,0ffh,022h,018h,048h,00fh,022h,018h,04ch,002h,022h,018h,050h	; bc66  ..P..".H.".L.".P
	defb 001h,0ffh,033h,0bch,082h,0bch,033h,0bch,082h,0bch,033h,0bch,00fh,008h,02ch,009h	; bc76  ..3...3...3...,.
	defb 0ffh,091h,0bch,096h,0bch,09bh,0bch,0a0h,0bch,033h,0bch,016h,000h,034h,00eh,0ffh	; bc86  .........3...4..
	defb 013h,000h,034h,00eh,0ffh,00eh,000h,038h,00eh,0ffh,008h,000h,03ch,00eh,0ffh	; bc96  ..4....8....<..

; ======================================================================
; CODIGO 0xbca5..0xbcd6  (49 bytes)
; ======================================================================


L_BCA5:
	ld a,(ix+001h)		;bca5   ; si la cara lleva menos de 2 cuadros pone la cabeza de 0xBA5B
	cp 002h		;bca8
	jr nc,L_BCB9		;bcaa
	ld hl,0ba5bh		;bcac
	call L_B846		;bcaf   ; dibuja un dibujo de tiles de HL (X, Y, tiles... 0xFE = nueva linea, 0xFF = acaba) con la posicion de (ix+5, ix+6)
	ret			;bcb2
L_BCB3:
	ld a,(ix+001h)		;bcb3   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
	cp 004h		;bcb6
	ret c			;bcb8
L_BCB9:
	ld a,(ix+005h)		;bcb9
	ld d,a			;bcbc
	ld a,(ix+006h)		;bcbd
	ld e,a			;bcc0
	ld a,(0c276h)		;bcc1
	dec a			;bcc4
	call 0661dh		;bcc5   ; dibuja_cara: dibuja la cara de 48 x 48 del personaje A
	ret			;bcc8
L_BCC9:
	ld hl,0bcd6h		;bcc9   ; dibuja el gesto de la tabla 0xBCD6 segun el cuadro (ix+1)
	ld a,(ix+001h)		;bccc
	call 04d07h		;bccf   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call L_B846		;bcd2   ; dibuja un dibujo de tiles de HL (X, Y, tiles... 0xFE = nueva linea, 0xFF = acaba) con la posicion de (ix+5, ix+6)
	ret			;bcd5

; ----------------------------------------------------------------------
; DATOS resto_BCD6: lo apuntan con el banco puesto p04:BCC9 (0xBCD6); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BCC9 (30 bytes)
;   0xbcd6..0xbcf4  (30 bytes)
DATA_resto_BCD6:
	defb 0e0h,0bch,034h,0bah,0e0h,0bch,034h,0bah,0e0h,0bch,000h,020h,06dh,06eh,0feh,020h	; bcd6  ..4...4.... mn.
	defb 020h,06fh,0fdh,0feh,000h,028h,00dh,00eh,0feh,020h,028h,010h,00fh,0ffh	; bce6   o...(... (...

; ======================================================================
; CODIGO 0xbcf4..0xbd34  (64 bytes)
; ======================================================================


L_BCF4:
	ld a,(0c27fh)		;bcf4   ; solo en los cuadros pares y si no es el humano
	and 001h		;bcf7
	ret nz			;bcf9
	ld a,(ix+004h)		;bcfa   ; no si es el humano
	or a			;bcfd
	ret nz			;bcfe
	ld a,(0c276h)		;bcff
	cp 006h		;bd02   ; solo los personajes 6 y 3
	jr z,L_BD09		;bd04
	cp 003h		;bd06
	ret nz			;bd08
L_BD09:
	ld a,(ix+007h)		;bd09
	or a			;bd0c
	ret z			;bd0d
L_BD0E:
	ld hl,0bd34h		;bd0e   ; elige la lista de gestos segun el personaje (3, 1 u otro)
	ld a,(0c276h)		;bd11
	cp 003h		;bd14
	jr z,L_BD22		;bd16
	ld hl,0bd8dh		;bd18
	cp 001h		;bd1b
	jr z,L_BD22		;bd1d
	ld hl,0bdd9h		;bd1f
L_BD22:
	inc (ix+002h)		;bd22
	ld a,(ix+002h)		;bd25
	and 003h		;bd28
	call 04d07h		;bd2a   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call L_BA8F		;bd2d   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
	call L_BAF7		;bd30   ; un sprite del cuadro de la cara: Y, X, patron y color
	ret			;bd33

; ----------------------------------------------------------------------
; DATOS resto_BD34: lo apuntan con el banco puesto p04:BD0E (0xBD34); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BD0E (42 bytes)
;   0xbd34..0xbd5e  (42 bytes)
DATA_resto_BD34:
	defb 03ch,0bdh,04dh,0bdh,03ch,0bdh,04dh,0bdh,008h,0fch,070h,00eh,0fch,008h,06ch,00eh	; bd34  <.M.<.M...p...l.
	defb 0fch,018h,070h,00eh,008h,028h,06ch,00eh,0ffh,008h,0fch,06ch,00eh,0fch,008h,070h	; bd44  ..p..(l....l...p
	defb 00eh,0fch,018h,06ch,00eh,008h,028h,070h,00eh,0ffh	; bd54  ...l..(p..

; ======================================================================
; CODIGO 0xbd5e..0xbd84  (38 bytes)
; ======================================================================


L_BD5E:
	ld a,(0c27fh)		;bd5e   ; gesto del personaje 1 (parpadeo): tabla 0xBD84
	and 001h		;bd61
	ret nz			;bd63
	ld a,(ix+004h)		;bd64
	or a			;bd67
	ret nz			;bd68
	ld a,(0c276h)		;bd69
	cp 001h		;bd6c
	ret nz			;bd6e
	ld a,(ix+007h)		;bd6f
	or a			;bd72
	ret z			;bd73
	ld a,(0c27eh)		;bd74
	or a			;bd77
	jr nz,$-106		;bd78
	ld hl,0bd84h		;bd7a
	call L_BA8F		;bd7d   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
	call L_BAF7		;bd80   ; un sprite del cuadro de la cara: Y, X, patron y color
	ret			;bd83

; ----------------------------------------------------------------------
; DATOS resto_BD84: lo apuntan con el banco puesto p04:BD7A (0xBD84), p04:BD18
;   (0xBD8D), p04:BD1F (0xBDD9); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p04:BD7A, p04:BD18, p04:BD1F (161 bytes)
;   0xbd84..0xbe25  (161 bytes)
DATA_resto_BD84:
	defb 010h,000h,0ech,00eh,010h,020h,0f0h,00eh,0ffh,095h,0bdh,0a6h,0bdh,0b7h,0bdh,0c8h	; bd84  ..... ..........
	defb 0bdh,00fh,0f8h,0a8h,00eh,00fh,008h,0ach,00eh,00fh,018h,0b0h,00eh,00fh,028h,0b4h	; bd94  ..............(.
	defb 00eh,0ffh,00fh,0f8h,0b8h,00eh,00fh,008h,0bch,00eh,00fh,018h,0c0h,00eh,00fh,028h	; bda4  ...............(
	defb 0c4h,00eh,0ffh,00fh,0f8h,0c8h,00eh,00fh,008h,0cch,00eh,00fh,018h,0d0h,00eh,00fh	; bdb4  ................
	defb 028h,0d4h,00eh,0ffh,00fh,0f8h,0d8h,00eh,00fh,008h,0dch,00eh,00fh,018h,0e4h,00eh	; bdc4  (...............
	defb 00fh,028h,0e8h,00eh,0ffh,0e1h,0bdh,0f2h,0bdh,003h,0beh,014h,0beh,008h,0fch,0f8h	; bdd4  .(..............
	defb 00eh,0f8h,008h,0f4h,00eh,00dh,000h,0fch,00eh,0fbh,00ch,0fch,00eh,0ffh,0fdh,002h	; bde4  ................
	defb 0fch,00eh,00ah,006h,0fch,00eh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0ffh,008h	; bdf4  ................
	defb 0fch,0f8h,00eh,0f8h,008h,0f4h,00eh,006h,0feh,0fch,00eh,005h,00bh,0fch,00eh,0ffh	; be04  ................
	defb 00dh,0feh,0fch,00eh,0feh,011h,0fch,00eh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; be14  ................
	defb 0ffh	; be24

; ======================================================================
; CODIGO 0xbe25..0xbe47  (34 bytes)
; ======================================================================


L_BE25:
	dec (ix+003h)		;be25   ; baja el temporizador (ix+3)
	ret			;be28
L_BE29:
	ld a,(0c276h)		;be29   ; gestos del personaje 2: si (ix+4) es cero vuelve; cada dos cuadros elige un paso por la tabla de 0xBE47
	cp 002h		;be2c
	ret nz			;be2e
	ld a,(ix+004h)		;be2f
	or a			;be32
	ret z			;be33
	pop hl			;be34
	call L_B87A		;be35   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	ld a,(0c003h)		;be38   ; lee el contador de cuadros
	and 001h		;be3b
	ret z			;be3d
	ld a,(ix+001h)		;be3e
	ld hl,0be47h		;be41
	call 04066h		;be44   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BE47: 8 destinos del despachador p00:4066 (call en p04:BE44, el
;   indice en A): BE57, BE71, BE71, BE71, BE7F, BE97, BEAC, BEB8; lo leen
;   p04:BE44 (16 bytes)
;   0xbe47..0xbe57  (16 bytes)
DATA_tabla_BE47:
	defw 0be57h,0be71h,0be71h,0be71h,0be7fh,0be97h,0beach,0beb8h	; be47

; ======================================================================
; CODIGO 0xbe57..0xbe68  (17 bytes)
; ======================================================================


L_BE57:
	ld hl,0be68h		;be57
	ld a,003h		;be5a
L_BE5C:
	ld (ix+003h),a		;be5c
	call L_BA8F		;be5f   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
	call L_BAF7		;be62   ; un sprite del cuadro de la cara: Y, X, patron y color
	jp L_B68D		;be65

; ----------------------------------------------------------------------
; DATOS resto_BE68: lo apuntan con el banco puesto p04:BE57 (0xBE68); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BE57 (9 bytes)
;   0xbe68..0xbe71  (9 bytes)
DATA_resto_BE68:
	defb 013h,00ah,054h,009h,013h,00ah,058h,002h,0ffh	; be68  ..T...X..

; ======================================================================
; CODIGO 0xbe71..0xbe8e  (29 bytes)
; ======================================================================


L_BE71:
	call L_BEC6		;be71   ; mueve la cara de 0xBEE8 en dos sprites
	call L_BE25		;be74   ; baja el temporizador (ix+3)
	ret nz			;be77
	ld (ix+003h),003h		;be78
	jp L_B68D		;be7c
L_BE7F:
	call L_BEC6		;be7f   ; mueve la cara de 0xBEE8 en dos sprites
	call L_BE25		;be82   ; baja el temporizador (ix+3)
	ret nz			;be85
	ld hl,0be8eh		;be86
	ld a,002h		;be89
	jp L_BE5C		;be8b

; ----------------------------------------------------------------------
; DATOS resto_BE8E: lo apuntan con el banco puesto p04:BE86 (0xBE8E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BE86 (9 bytes)
;   0xbe8e..0xbe97  (9 bytes)
DATA_resto_BE8E:
	defb 0fbh,0f8h,074h,009h,0fbh,0f8h,078h,002h,0ffh	; be8e  ..t...x..

; ======================================================================
; CODIGO 0xbe97..0xbea3  (12 bytes)
; ======================================================================


L_BE97:
	call L_BE25		;be97   ; baja el temporizador (ix+3)
	ret nz			;be9a
	ld hl,0bea3h		;be9b
	ld a,003h		;be9e
	jp L_BE5C		;bea0

; ----------------------------------------------------------------------
; DATOS resto_BEA3: lo apuntan con el banco puesto p04:BE9B (0xBEA3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BE9B (9 bytes)
;   0xbea3..0xbeac  (9 bytes)
DATA_resto_BEA3:
	defb 0fbh,0f8h,07ch,00dh,0e0h,0e0h,0e0h,0e0h,0ffh	; bea3  ..|......

; ======================================================================
; CODIGO 0xbeac..0xbee8  (60 bytes)
; ======================================================================


L_BEAC:
	call L_BE25		;beac   ; baja el temporizador (ix+3)
	ret nz			;beaf
	ld hl,0bc33h		;beb0
	ld a,008h		;beb3
	jp L_BE5C		;beb5
L_BEB8:
	call L_BE25		;beb8   ; baja el temporizador (ix+3)
	ret nz			;bebb
	call L_BCB3		;bebc   ; si lleva 4 cuadros o mas pone la cara de 0x661D (el cuadro de personaje) en su sitio
	ld (ix+003h),005h		;bebf
	jp L_B685		;bec3
L_BEC6:
	call L_BA8F		;bec6   ; mueve la cara de 0xBEE8 en dos sprites
	ld a,(ix+001h)		;bec9
	add a,a			;becc
	ld hl,0bee8h		;becd
	call L_B680		;bed0   ; A = el byte A de la tabla HL
	ld b,a			;bed3
	inc hl			;bed4
	ld c,(hl)			;bed5
	push bc			;bed6
	pop hl			;bed7
	ex de,hl			;bed8
	ld b,002h		;bed9
L_BEDB:
	ld a,d			;bedb   ; suma el desplazamiento al sprite
	add a,(hl)			;bedc   ; suma a la Y
	ld (hl),a			;bedd
	inc hl			;bede
	ld a,e			;bedf   ; suma a la X
	add a,(hl)			;bee0
	ld (hl),a			;bee1
	inc hl			;bee2
	inc hl			;bee3
	inc hl			;bee4
	djnz L_BEDB		;bee5
	ret			;bee7

; ----------------------------------------------------------------------
; DATOS resto_BEE8: lo apuntan con el banco puesto p04:BECD (0xBEE8); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BECD (10 bytes)
;   0xbee8..0xbef2  (10 bytes)
DATA_resto_BEE8:
	defb 000h,000h,0ffh,0feh,0ffh,0ffh,0feh,0ffh,0fdh,0ffh	; bee8  ..........

; ======================================================================
; CODIGO 0xbef2..0xbf15  (35 bytes)
; ======================================================================


L_BEF2:
	push hl			;bef2   ; baja el contador 0xC301
	ld hl,0c301h		;bef3
	dec (hl)			;bef6
	pop hl			;bef7
	ret			;bef8
L_BEF9:
	ld a,(0c276h)		;bef9   ; gestos del personaje 8: 0xC300 elige el paso por la tabla de 0xBF15
	cp 008h		;befc
	ret nz			;befe
	ld a,(ix+004h)		;beff
	or a			;bf02
	ret nz			;bf03
	ld a,(ix+007h)		;bf04
	or a			;bf07
	ret z			;bf08
	call L_B87A		;bf09   ; pone en (ix+5, ix+6) la posicion de la cara de este rival (tabla 0xB88E)
	ld a,(0c300h)		;bf0c
	ld hl,0bf15h		;bf0f
	call 04066h		;bf12   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BF15: 5 destinos del despachador p00:4066 (call en p04:BF12, el
;   indice en A): BF1F, BF2A, BF2A, BF2A, BF30; lo leen p04:BF12 (10 bytes)
;   0xbf15..0xbf1f  (10 bytes)
DATA_tabla_BF15:
	defw 0bf1fh,0bf2ah,0bf2ah,0bf2ah,0bf30h	; bf15

; ======================================================================
; CODIGO 0xbf1f..0xbf46  (39 bytes)
; ======================================================================


L_BF1F:
	call L_BF39		;bf1f   ; pone 0xC301 con el tiempo del paso (tabla 0xBF46)
	call L_BF4B		;bf22   ; dibuja el gesto 0xC300 (tabla 0xBF5B)
	ld hl,0c300h		;bf25
	inc (hl)			;bf28
	ret			;bf29
L_BF2A:
	call L_BEF2		;bf2a   ; baja el contador 0xC301
	ret nz			;bf2d
	jr L_BF1F		;bf2e
L_BF30:
	call L_BEF2		;bf30   ; baja el contador 0xC301
	ret nz			;bf33
	xor a			;bf34
	ld (0c300h),a		;bf35
	ret			;bf38
L_BF39:
	ld a,(0c300h)		;bf39   ; pone 0xC301 con el tiempo del paso (tabla 0xBF46)
	ld hl,0bf46h		;bf3c
	call L_B680		;bf3f   ; A = el byte A de la tabla HL
	ld (0c301h),a		;bf42
	ret			;bf45

; ----------------------------------------------------------------------
; DATOS resto_BF46: lo apuntan con el banco puesto p04:BF3C (0xBF46); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BF3C (5 bytes)
;   0xbf46..0xbf4b  (5 bytes)
DATA_resto_BF46:
	defb 004h,004h,002h,002h,001h	; bf46

; ======================================================================
; CODIGO 0xbf4b..0xbf5b  (16 bytes)
; ======================================================================


L_BF4B:
	ld a,(0c300h)		;bf4b   ; dibuja el gesto 0xC300 (tabla 0xBF5B)
	ld hl,0bf5bh		;bf4e
	call 04d07h		;bf51   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	call L_BA8F		;bf54   ; DE = el sprite de la cara del personaje 0xC275 (tabla 0xBAA2)
	call L_BAF7		;bf57   ; un sprite del cuadro de la cara: Y, X, patron y color
	ret			;bf5a

; ----------------------------------------------------------------------
; DATOS resto_BF5B: lo apuntan con el banco puesto p04:BF4E (0xBF5B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p04:BF4E (60 bytes)
;   0xbf5b..0xbf97  (60 bytes)
DATA_resto_BF5B:
	defb 065h,0bfh,076h,0bfh,087h,0bfh,087h,0bfh,087h,0bfh,007h,008h,080h,00eh,007h,018h	; bf5b  e.v.............
	defb 088h,00eh,017h,008h,084h,00eh,017h,018h,08ch,00eh,0ffh,007h,008h,090h,00eh,007h	; bf6b  ................
	defb 018h,098h,00eh,017h,008h,094h,00eh,017h,018h,09ch,00eh,0ffh,007h,008h,05ch,00eh	; bf7b  ..............\.
	defb 007h,018h,064h,00eh,017h,008h,060h,00eh,017h,018h,068h,00eh	; bf8b  ..d...`...h.

; ----------------------------------------------------------------------
; DATOS relleno_ff: 105 bytes a 0xFF hasta el final del banco: relleno; lo
;   leen nadie (105 bytes)
;   0xbf97..0xc000  (105 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf97  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe7  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff7  .........
