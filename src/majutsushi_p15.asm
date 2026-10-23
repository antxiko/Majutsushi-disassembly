; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa00c  (12 bytes)
; ======================================================================


copia_estilos_rivales:		; copia a 0xC040 la tabla de estilos de los ocho rivales
	ld hl,0a00ch		;a000   ; copia la tabla de 0xA00C (64 bytes) a 0xC040: los siete contadores de estilo de cada uno de los ocho rivales
	ld de,0c040h		;a003   ; apunta a la tabla de estilo de los ocho rivales (8 bytes cada uno)
	ld bc,00040h		;a006
	ldir		;a009
	ret			;a00b

; ----------------------------------------------------------------------
; DATOS resto_A00C: lo apuntan con el banco puesto p15:A000 (0xA00C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p15:A000 (64 bytes)
;   0xa00c..0xa04c  (64 bytes)
DATA_resto_A00C:
	defb 023h,016h,034h,00eh,036h,033h,03fh,000h,010h,03fh,004h,034h,02ch,002h,005h,000h	; a00c  #.4.63?..?.4,...
	defb 03fh,001h,02ah,013h,00bh,024h,01eh,000h,005h,023h,012h,02ch,01fh,013h,02fh,000h	; a01c  ?.*..$...#.,../.
	defb 01eh,024h,000h,002h,021h,002h,022h,000h,023h,01fh,021h,026h,029h,010h,015h,000h	; a02c  .$..!.".#.!&)...
	defb 032h,008h,023h,03fh,014h,002h,034h,000h,003h,034h,033h,015h,01eh,035h,001h,000h	; a03c  2.#?..4..43..5..

; ======================================================================
; CODIGO 0xa04c..0xa19c  (336 bytes)
; ======================================================================


estilos_a_manos:		; pone a cada rival elegido su estilo en +0x90 de su mano
	ld b,003h		;a04c   ; copia los 8 bytes de estilo de cada uno de los tres rivales elegidos (0xC031-0xC033) de 0xC040 + 8 x (rival - 1) a 0xD490, 0xD890 y 0xDC90 (+0x90 de su mano)
	ld de,0d490h		;a04e
	ld hl,0c031h		;a051   ; apunta a el personaje que juega de rival 1
L_A054:
	push bc			;a054   ; copia el estilo de cada rival elegido: 8 bytes de 0xC040 + 8 x (rival - 1)
	push hl			;a055
	push de			;a056
	ld a,(hl)			;a057
	dec a			;a058
	add a,a			;a059
	add a,a			;a05a
	add a,a			;a05b
	ld hl,0c040h		;a05c   ; apunta a la tabla de estilo de los ocho rivales (8 bytes cada uno)
	call 0405ch		;a05f   ; toma la direccion de la tabla de estilos
	ld bc,00008h		;a062
	ldir		;a065   ; los copia a +0x90 de la mano del rival
	pop de			;a067
	pop hl			;a068
	inc l			;a069   ; siguiente rival (0xC031 + 1) y siguiente mano (+0x400)
	inc d			;a06a
	inc d			;a06b
	inc d			;a06c
	inc d			;a06d
	pop bc			;a06e
	djnz L_A054		;a06f
	ret			;a071
L_A072:
	ld hl,0c510h		;a072   ; pone a cero 0xC510 (13 bytes)
	ld de,0c511h		;a075
	ld bc,0000ch		;a078
	ld (hl),000h		;a07b
	ldir		;a07d
	ret			;a07f
prepara_ia:		; prepara la partida de los tres rivales de la maquina
	ld hl,0d400h		;a080   ; PREPARA LA PARTIDA DE LOS TRES RIVALES: por cada mano (0xD400, 0xD800, 0xDC00) recorre cuatro pasos (0xA0A3, 0xA0B5, 0xA108, 0xA14C)
	ld (0cc80h),hl		;a083
	ld b,003h		;a086
L_A088:
	push bc			;a088
	call L_A0A3		;a089   ; pone a cero los campos +0x70 a +0x7F de la mano
	call L_A0B5		;a08c   ; cuenta cuantas fichas de cada palo (0x00, 0x10, 0x20) hay en la mano (0xCC90), y elige el palo que lleva +0x72: el primero que tiene al menos 9 - (+0x93 >> 4)
	call L_A108		;a08f   ; toma +0x92: la manera de pedir
	call L_A14C		;a092   ; toma +0x91 y +0x94: la manera de llamar
	ld hl,(0cc80h)		;a095
	ld bc,00400h		;a098
	add hl,bc			;a09b
	ld (0cc80h),hl		;a09c
	pop bc			;a09f
	djnz L_A088		;a0a0
	ret			;a0a2
L_A0A3:
	ld hl,(0cc80h)		;a0a3   ; pone a cero los campos +0x70 a +0x7F de la mano
	ld de,00070h		;a0a6
	add hl,de			;a0a9
	ld d,h			;a0aa
	ld e,l			;a0ab
	inc de			;a0ac
	ld bc,0000fh		;a0ad
	ld (hl),000h		;a0b0
	ldir		;a0b2
	ret			;a0b4
L_A0B5:
	ld hl,0cc90h		;a0b5   ; cuenta cuantas fichas de cada palo (0x00, 0x10, 0x20) hay en la mano (0xCC90), y elige el palo que lleva +0x72: el primero que tiene al menos 9 - (+0x93 >> 4)
	ld bc,00300h		;a0b8
L_A0BB:
	ld de,(0cc80h)		;a0bb   ; cuenta las fichas de cada palo de la mano en 0xCC90
	push bc			;a0bf
	call L_A0F9		;a0c0   ; cuenta las fichas de la mano (13) cuyo palo (bits 4-5) es C
	pop bc			;a0c3
	inc hl			;a0c4
	ld a,c			;a0c5   ; siguiente palo (+0x10)
	add a,010h		;a0c6
	ld c,a			;a0c8
	djnz L_A0BB		;a0c9
	ld de,(0cc80h)		;a0cb
	ld hl,00093h		;a0cf   ; el limite: 9 - el nibble alto de +0x93
	add hl,de			;a0d2
	ld a,(hl)			;a0d3
	rrca			;a0d4
	rrca			;a0d5
	rrca			;a0d6
	rrca			;a0d7
	and 00fh		;a0d8
	ld d,a			;a0da
	ld a,009h		;a0db
	sub d			;a0dd
	ld d,a			;a0de
	ld hl,0cc90h		;a0df
	ld bc,00301h		;a0e2
L_A0E5:
	ld a,(hl)			;a0e5   ; busca el primer palo que lo alcanza
	cp d			;a0e6
	jr nc,L_A0ED		;a0e7
	inc c			;a0e9   ; el palo siguiente
	inc hl			;a0ea
	djnz L_A0E5		;a0eb
L_A0ED:
	ld a,c			;a0ed   ; guarda el palo elegido en +0x72
	and 003h		;a0ee
	ld hl,(0cc80h)		;a0f0
	ld de,00072h		;a0f3
	add hl,de			;a0f6
	ld (hl),a			;a0f7
	ret			;a0f8
L_A0F9:
	ld (hl),000h		;a0f9   ; cuenta las fichas de la mano (13) cuyo palo (bits 4-5) es C
	ld b,00dh		;a0fb
L_A0FD:
	ld a,(de)			;a0fd
	and 030h		;a0fe
	cp c			;a100
	jr nz,L_A104		;a101
	inc (hl)			;a103
L_A104:
	inc de			;a104
	djnz L_A0FD		;a105
	ret			;a107
L_A108:
	ld hl,(0cc80h)		;a108   ; toma +0x92: la manera de pedir
	ld de,00092h		;a10b
	add hl,de			;a10e
	ld a,(hl)			;a10f
	rrca			;a110
	rrca			;a111
	rrca			;a112
	rrca			;a113
	and 00fh		;a114
	ld bc,00001h		;a116
	jr z,L_A124		;a119
	dec a			;a11b
	jr z,L_A12F		;a11c
	dec a			;a11e
	jr z,L_A13E		;a11f
	ld bc,00100h		;a121   ; con 3 o mas pone (1, 0)
L_A124:
	ld hl,(0cc80h)		;a124   ; guarda el par en +0x73 y +0x74
	ld de,00073h		;a127
	add hl,de			;a12a
	ld (hl),b			;a12b
	inc hl			;a12c
	ld (hl),c			;a12d
	ret			;a12e
L_A12F:
	ld a,(0c003h)		;a12f   ; lee el contador de cuadros
	and 003h		;a132
	ld bc,00001h		;a134
	jr z,L_A124		;a137
	ld bc,00000h		;a139
	jr L_A124		;a13c
L_A13E:
	ld a,(0c003h)		;a13e   ; lee el contador de cuadros
	rra			;a141
	ld bc,00100h		;a142
	jr c,L_A124		;a145
	ld bc,00000h		;a147
	jr L_A124		;a14a
L_A14C:
	ld hl,(0cc80h)		;a14c   ; toma +0x91 y +0x94: la manera de llamar
	ld de,00091h		;a14f
	add hl,de			;a152
	ld a,(hl)			;a153   ; +0x91: el nibble alto es la tendencia a llamar
	rrca			;a154
	rrca			;a155
	rrca			;a156
	rrca			;a157
	and 00fh		;a158   ; solo los cuatro bits altos
	ld b,a			;a15a
	ld hl,(0cc80h)		;a15b
	ld de,00094h		;a15e
	add hl,de			;a161
	ld a,(hl)			;a162   ; +0x94: el nibble alto
	rrca			;a163
	rrca			;a164
	rrca			;a165
	rrca			;a166
	and 00fh		;a167   ; con cero no hace nada
	ret z			;a169
	dec a			;a16a   ; con 1 va a 0xA17B
	jr z,L_A17B		;a16b
	dec a			;a16d   ; con 2 va a 0xA186
	jr z,L_A186		;a16e
	ld c,001h		;a170   ; con valores altos siempre llama
L_A172:
	ld hl,(0cc80h)		;a172
	ld de,00075h		;a175
	add hl,de			;a178
	ld (hl),c			;a179
	ret			;a17a
L_A17B:
	ld a,(0c003h)		;a17b   ; lee el contador de cuadros
	and 003h		;a17e
	ret nz			;a180
	ld a,b			;a181
	rra			;a182
	ret c			;a183
	jr L_A172		;a184
L_A186:
	ld a,(0c003h)		;a186   ; lee el contador de cuadros
	rra			;a189
	ret nc			;a18a
	ld a,b			;a18b
	and a			;a18c
	ret z			;a18d
	jr L_A172		;a18e
opciones_por_defecto:		; pone las diez opciones de reglas por defecto
	ld hl,0a19ch		;a190   ; copia las diez opciones de reglas por defecto de 0xA19C a 0xC020
	ld de,0c020h		;a193   ; apunta a la regla 'comer 断幺' (tanyao con la mano abierta; de serie si)
	ld bc,0000ah		;a196
	ldir		;a199
	ret			;a19b

; ----------------------------------------------------------------------
; DATOS resto_A19C: lo apuntan con el banco puesto p15:A190 (0xA19C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p15:A190 (10 bytes)
;   0xa19c..0xa1a6  (10 bytes)
DATA_resto_A19C:
	defb 001h,000h,001h,001h,000h,000h,000h,000h,001h,001h	; a19c  ..........

; ======================================================================
; CODIGO 0xa1a6..0xa306  (352 bytes)
; ======================================================================


calcula_fu:		; calcula los fu de la mano
	ld de,0c241h		;a1a6   ; CALCULA LOS FU DE LA MANO en 0xC241: empieza en 0x30 (siete parejas) y, si no lo es, en 0x20
	ld a,030h		;a1a9
	ld (de),a			;a1ab
	ld a,(0cd99h)		;a1ac   ; lee 1 si la mano es de siete parejas
	and a			;a1af
	ret nz			;a1b0
	ld a,020h		;a1b1
	ld (de),a			;a1b3
	ld hl,(0cd5ch)		;a1b4   ; si la mano es cerrada (+0x40 a cero) y gana por ron (0xC0B1 = 2) suma 10 (0xA299 con C = 0x10)
	ld bc,00040h		;a1b7
	add hl,bc			;a1ba
	ld a,(hl)			;a1bb
	and a			;a1bc
	jr nz,L_A1C9		;a1bd
	ld a,(0c0b1h)		;a1bf   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	cp 002h		;a1c2
	ld c,010h		;a1c4
	call z,L_A299		;a1c6   ; suma C al valor (BCD) de DE
L_A1C9:
	ld a,(0cd0eh)		;a1c9
	and a			;a1cc
	jr nz,L_A1D8		;a1cd
	ld a,(0c0b1h)		;a1cf   ; si gana por robo (0xC0B1 = 1) y no hay el aviso de 0xCD0E, suma 2
	dec a			;a1d2
	ld c,002h		;a1d3
	call z,L_A299		;a1d5   ; suma C al valor (BCD) de DE
L_A1D8:
	push de			;a1d8
	call 07035h		;a1d9   ; si la pareja (0xCD40) es de honor propio (0x7035 los pone en 0xCD90), suma 2
	pop de			;a1dc
	ld a,(0cd40h)		;a1dd   ; lee la pareja de la mano
	ld hl,0cd90h		;a1e0   ; apunta a los honores que cuentan de yaku (5)
	ld b,005h		;a1e3
L_A1E5:
	cp (hl)			;a1e5
	jr z,L_A1ED		;a1e6
	inc hl			;a1e8
	djnz L_A1E5		;a1e9
	jr L_A1F2		;a1eb
L_A1ED:
	ld c,002h		;a1ed
	call L_A299		;a1ef   ; suma C al valor (BCD) de DE
L_A1F2:
	ld hl,0cd48h		;a1f2   ; suma los fu de los grupos de tripletes (0xCD48 por 0xA22E) y de kan (0xCD4C por 0xA25C)
	call L_A22E		;a1f5   ; fu de cada triplete: 2 por triplete de numeros de 2 a 8, doble por honor o extremo; doble si es cerrado
	ld hl,0cd4ch		;a1f8   ; apunta a los kan de la mano
	call L_A25C		;a1fb   ; fu de cada kan: 8, doble por honor o extremo, doble si es cerrado
	ld a,(0c209h)		;a1fe   ; si la ficha de espera es la pareja o una espera de un hueco (0xA209-0xA22A): suma 2 con 0xA297
	ld c,a			;a201
	ld a,(0cd40h)		;a202   ; lee la pareja de la mano
	cp c			;a205
	jp z,L_A297		;a206
	ld b,004h		;a209
	ld hl,0cd44h		;a20b   ; apunta a las escaleras de la mano (4)
L_A20E:
	ld a,(hl)			;a20e   ; espera igual que la pareja: si la ficha es de numero 7 sirve
	cp c			;a20f
	jr nz,L_A219		;a210
	and 00fh		;a212
	cp 007h		;a214
	jp z,L_A297		;a216
L_A219:
	ld a,(hl)			;a219   ; espera por un hueco: la siguiente
	inc a			;a21a
	cp c			;a21b
	jp z,L_A297		;a21c
	inc a			;a21f
	cp c			;a220
	jr nz,L_A22A		;a221
	and 00fh		;a223   ; si es del borde de numero 3 sirve
	cp 003h		;a225
	jp z,L_A297		;a227
L_A22A:
	inc hl			;a22a
	djnz L_A20E		;a22b
	ret			;a22d
L_A22E:
	ld b,004h		;a22e   ; fu de cada triplete: 2 por triplete de numeros de 2 a 8, doble por honor o extremo; doble si es cerrado
L_A230:
	ld c,002h		;a230
	ld a,(hl)			;a232
	and 03fh		;a233
	jr z,L_A258		;a235
	call L_A29E		;a237   ; mira si la ficha A es de numero entre 2 y 8 (acarreo si no lo es)
	jr c,L_A240		;a23a
	ld a,c			;a23c
	add a,a			;a23d
	daa			;a23e
	ld c,a			;a23f
L_A240:
	ld a,(hl)			;a240
	and 0c0h		;a241
	jr nz,L_A255		;a243
	ld a,(0c209h)		;a245   ; lee la ficha robada o tirada
	cp (hl)			;a248
	jr nz,L_A251		;a249
	ld a,(0c0b1h)		;a24b   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;a24e
	jr nz,L_A255		;a24f
L_A251:
	ld a,c			;a251
	add a,a			;a252
	daa			;a253
	ld c,a			;a254
L_A255:
	call L_A299		;a255   ; suma C al valor (BCD) de DE
L_A258:
	inc hl			;a258
	djnz L_A230		;a259
	ret			;a25b
L_A25C:
	ld b,004h		;a25c   ; fu de cada kan: 8, doble por honor o extremo, doble si es cerrado
L_A25E:
	ld c,008h		;a25e
	ld a,(hl)			;a260
	and 03fh		;a261
	jr z,L_A293		;a263
	call L_A29E		;a265   ; mira si la ficha A es de numero entre 2 y 8 (acarreo si no lo es)
	jr c,L_A26E		;a268
	ld a,c			;a26a
	add a,c			;a26b
	daa			;a26c
	ld c,a			;a26d
L_A26E:
	push hl			;a26e   ; guarda el kan y mira si la ficha esta en la lista de descartes
	push bc			;a26f
	ld a,(hl)			;a270
	ex af,af'			;a271
	ld hl,(0cd5ch)		;a272   ; +0x41 de la mano
	ld bc,00041h		;a275
	add hl,bc			;a278
	ld a,(hl)			;a279
	and a			;a27a
	jr z,L_A286		;a27b
	ld b,a			;a27d
	inc hl			;a27e
	ex af,af'			;a27f   ; busca la ficha entre los descartes
L_A280:
	cp (hl)			;a280
	jr z,L_A28A		;a281
	inc hl			;a283
	djnz L_A280		;a284
L_A286:
	pop bc			;a286
	pop hl			;a287
	jr L_A290		;a288
L_A28A:
	pop bc			;a28a   ; si esta, el kan vale el doble
	pop hl			;a28b
	ld a,c			;a28c
	add a,a			;a28d
	daa			;a28e
	ld c,a			;a28f
L_A290:
	call L_A299		;a290   ; suma C al valor (BCD) de DE
L_A293:
	inc hl			;a293
	djnz L_A25E		;a294
	ret			;a296
L_A297:
	ld c,002h		;a297   ; suma 2 fu
L_A299:
	ld a,(de)			;a299   ; suma C al valor (BCD) de DE
	add a,c			;a29a
	daa			;a29b
	ld (de),a			;a29c
	ret			;a29d
L_A29E:
	cp 031h		;a29e   ; mira si la ficha A es de numero entre 2 y 8 (acarreo si no lo es)
	ret nc			;a2a0
	and 00fh		;a2a1
	sub 002h		;a2a3
	cp 007h		;a2a5
	ret			;a2a7
baraja:		; baraja el muro de 136 fichas en 0xC100
	ld b,088h		;a2a8   ; BARAJA EL MURO: rellena 0xC100 con las 136 fichas (0x88) en orden al azar
	ld hl,0c100h		;a2aa   ; apunta a el muro: 136 fichas (0x88)
L_A2AD:
	push bc			;a2ad
	push hl			;a2ae
	call ficha_al_azar		;a2af   ; ficha_al_azar: saca una ficha al azar de las que quedan
	pop hl			;a2b2
	ld (hl),a			;a2b3
	ld a,013h		;a2b4
	call 0405ch		;a2b6   ; suma_a_hl: HL = HL + A
	ld l,a			;a2b9
	cp 088h		;a2ba
	jr c,L_A2C0		;a2bc
	sub 088h		;a2be
L_A2C0:
	ld l,a			;a2c0
	pop bc			;a2c1
	djnz L_A2AD		;a2c2
	ret			;a2c4
ficha_al_azar:		; saca una ficha al azar de las que quedan
	call 065b2h		;a2c5   ; saca una ficha al azar (0xC190 = cuantas veces ha salido cada una, 4 como mucho): 1-9, 0x11-0x19, 0x21-0x29 y 0x31-0x37
L_A2C8:
	sub 021h		;a2c8
	jr c,L_A2CE		;a2ca
	jr L_A2C8		;a2cc
L_A2CE:
	add a,021h		;a2ce
	ld b,a			;a2d0
	ld hl,0c190h		;a2d1   ; apunta a cuantas veces ha salido cada ficha al barajar
	call 0405ch		;a2d4   ; suma_a_hl: HL = HL + A
L_A2D7:
	ld a,(hl)			;a2d7
	cp 004h		;a2d8
	jr c,L_A2F3		;a2da
	inc hl			;a2dc
	inc hl			;a2dd
	inc hl			;a2de
	inc b			;a2df
	inc b			;a2e0
	inc b			;a2e1
	ld a,b			;a2e2
	cp 022h		;a2e3
	jr c,L_A2D7		;a2e5
	ld a,b			;a2e7
	sub 022h		;a2e8
	ld b,a			;a2ea
	ld hl,0c190h		;a2eb   ; apunta a cuantas veces ha salido cada ficha al barajar
	call 0405ch		;a2ee   ; suma_a_hl: HL = HL + A
	jr L_A2D7		;a2f1
L_A2F3:
	inc (hl)			;a2f3   ; cuenta una ficha mas de ese numero
	ld a,b			;a2f4
	inc a			;a2f5
	cp 00ah		;a2f6   ; pasa el numero a su codigo: 1-9
	ret c			;a2f8
	add a,007h		;a2f9   ; 10-18: palo 1
	cp 01ah		;a2fb
	ret c			;a2fd
	add a,007h		;a2fe   ; 19-27: palo 2
	cp 02ah		;a300
	ret c			;a302
	add a,007h		;a303   ; 28-34: honores desde 0x31
	ret			;a305

; ----------------------------------------------------------------------
; DATOS resto_A306: lo apuntan con el banco puesto p01:7BA4 (0xA306), p01:7DF4
;   (0xA306), p01:7BD2 (0xA35C), p01:7E03 (0xA35C), p01:7CB8 (0xA589),
;   p01:7CC7 (0xA5D7); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:7BA4, p01:7DF4, p01:7BD2, p01:7E03, p01:7CB8,
;   p01:7CC7 (1946 bytes)
;   0xa306..0xaaa0  (1946 bytes)
DATA_resto_A306:
	defb 007h,000h,00eh,000h,01ch,000h,038h,000h,070h,000h,0e0h,000h,0c0h,001h,00fh,000h	; a306  ......8.p.......
	defb 01eh,000h,03ch,000h,078h,000h,0f0h,000h,0e0h,001h,01fh,000h,03eh,000h,07ch,000h	; a316  ..<.x.......>.|.
	defb 0f8h,000h,0f0h,001h,03fh,000h,07eh,000h,0fch,000h,0f8h,001h,07fh,000h,0feh,000h	; a326  ....?.~.........
	defb 0fch,001h,0ffh,000h,0feh,001h,0ffh,001h,077h,000h,0e7h,000h,0c7h,001h,0eeh,000h	; a336  ........w.......
	defb 0ceh,001h,0dch,001h,0efh,001h,0f7h,000h,0e7h,001h,0eeh,001h,0deh,001h,0cfh,001h	; a346  ................
	defb 0efh,000h,0f7h,001h,0dfh,001h,0b2h,0a3h,0b7h,0a3h,0bch,0a3h,0c1h,0a3h,0c6h,0a3h	; a356  ................
	defb 0cbh,0a3h,0d0h,0a3h,0d5h,0a3h,0deh,0a3h,0e7h,0a3h,0f0h,0a3h,0f9h,0a3h,002h,0a4h	; a366  ................
	defb 00bh,0a4h,018h,0a4h,025h,0a4h,032h,0a4h,03fh,0a4h,04ch,0a4h,059h,0a4h,066h,0a4h	; a376  ....%.2.?.L.Y.f.
	defb 073h,0a4h,080h,0a4h,091h,0a4h,0a2h,0a4h,0b3h,0a4h,0cch,0a4h,0e5h,0a4h,00ah,0a5h	; a386  s...............
	defb 00fh,0a5h,014h,0a5h,019h,0a5h,01eh,0a5h,023h,0a5h,028h,0a5h,039h,0a5h,042h,0a5h	; a396  ........#.(.9.B.
	defb 04bh,0a5h,054h,0a5h,05dh,0a5h,066h,0a5h,06fh,0a5h,07ch,0a5h,001h,001h,000h,000h	; a3a6  K.T.].f.o.|.....
	defb 000h,001h,002h,000h,000h,000h,001h,003h,000h,000h,000h,001h,004h,000h,000h,000h	; a3b6  ................
	defb 001h,005h,000h,000h,000h,001h,006h,000h,000h,000h,001h,007h,000h,000h,000h,002h	; a3c6  ................
	defb 001h,000h,000h,000h,002h,000h,000h,000h,002h,002h,000h,000h,000h,003h,000h,000h	; a3d6  ................
	defb 000h,002h,003h,000h,000h,000h,004h,000h,000h,000h,002h,004h,000h,000h,000h,005h	; a3e6  ................
	defb 000h,000h,000h,002h,005h,000h,000h,000h,006h,000h,000h,000h,002h,006h,000h,000h	; a3f6  ................
	defb 000h,007h,000h,000h,000h,003h,001h,000h,000h,000h,002h,000h,000h,000h,003h,000h	; a406  ................
	defb 000h,000h,003h,002h,000h,000h,000h,003h,000h,000h,000h,004h,000h,000h,000h,003h	; a416  ................
	defb 003h,000h,000h,000h,004h,000h,000h,000h,005h,000h,000h,000h,003h,004h,000h,000h	; a426  ................
	defb 000h,005h,000h,000h,000h,006h,000h,000h,000h,003h,005h,000h,000h,000h,006h,000h	; a436  ................
	defb 000h,000h,007h,000h,000h,000h,003h,001h,004h,000h,000h,002h,000h,000h,000h,003h	; a446  ................
	defb 000h,000h,000h,003h,002h,005h,000h,000h,003h,000h,000h,000h,004h,000h,000h,000h	; a456  ................
	defb 003h,003h,006h,000h,000h,004h,000h,000h,000h,005h,000h,000h,000h,003h,004h,007h	; a466  ................
	defb 000h,000h,005h,000h,000h,000h,006h,000h,000h,000h,004h,001h,004h,000h,000h,001h	; a476  ................
	defb 005h,000h,000h,002h,005h,000h,000h,003h,000h,000h,000h,004h,002h,005h,000h,000h	; a486  ................
	defb 002h,006h,000h,000h,003h,006h,000h,000h,004h,000h,000h,000h,004h,003h,006h,000h	; a496  ................
	defb 000h,003h,007h,000h,000h,004h,007h,000h,000h,005h,000h,000h,000h,006h,001h,004h	; a4a6  ................
	defb 000h,000h,001h,005h,000h,000h,001h,006h,000h,000h,002h,005h,000h,000h,002h,006h	; a4b6  ................
	defb 000h,000h,003h,006h,000h,000h,006h,002h,005h,000h,000h,002h,006h,000h,000h,002h	; a4c6  ................
	defb 007h,000h,000h,003h,006h,000h,000h,003h,007h,000h,000h,004h,007h,000h,000h,009h	; a4d6  ................
	defb 001h,004h,007h,000h,001h,005h,000h,000h,001h,006h,000h,000h,001h,007h,000h,000h	; a4e6  ................
	defb 002h,005h,000h,000h,002h,006h,000h,000h,002h,007h,000h,000h,003h,006h,000h,000h	; a4f6  ................
	defb 003h,007h,000h,000h,001h,001h,005h,000h,000h,001h,001h,006h,000h,000h,001h,001h	; a506  ................
	defb 007h,000h,000h,001h,002h,006h,000h,000h,001h,002h,007h,000h,000h,001h,003h,007h	; a516  ................
	defb 000h,000h,004h,001h,006h,000h,000h,001h,007h,000h,000h,002h,006h,000h,000h,002h	; a526  ................
	defb 007h,000h,000h,002h,001h,005h,000h,000h,001h,006h,000h,000h,002h,001h,006h,000h	; a536  ................
	defb 000h,001h,007h,000h,000h,002h,002h,006h,000h,000h,002h,007h,000h,000h,002h,002h	; a546  ................
	defb 007h,000h,000h,003h,007h,000h,000h,002h,001h,007h,000h,000h,002h,007h,000h,000h	; a556  ................
	defb 002h,001h,006h,000h,000h,002h,006h,000h,000h,003h,001h,005h,000h,000h,001h,006h	; a566  ................
	defb 000h,000h,001h,007h,000h,000h,003h,001h,007h,000h,000h,002h,007h,000h,000h,003h	; a576  ................
	defb 007h,000h,000h,000h,010h,000h,011h,010h,011h,011h,011h,000h,020h,000h,021h,010h	; a586  ............ .!.
	defb 021h,011h,021h,000h,022h,010h,022h,011h,022h,020h,022h,000h,030h,000h,031h,010h	; a596  !.!."."." ".0.1.
	defb 031h,011h,031h,000h,032h,010h,032h,011h,032h,020h,032h,000h,033h,010h,033h,020h	; a5a6  1.1.2.2.2 2.3.3
	defb 033h,000h,040h,000h,041h,010h,041h,000h,042h,010h,042h,000h,043h,000h,044h,000h	; a5b6  3.@.A.A.B.B.C.D.
	defb 060h,000h,061h,010h,061h,000h,062h,000h,063h,000h,090h,000h,091h,000h,092h,000h	; a5c6  `.a.a.b.c.......
	defb 093h,025h,0a6h,02ah,0a6h,02fh,0a6h,034h,0a6h,039h,0a6h,042h,0a6h,04bh,0a6h,054h	; a5d6  .%.*./.4.9.B.K.T
	defb 0a6h,05dh,0a6h,06eh,0a6h,07fh,0a6h,090h,0a6h,0b1h,0a6h,0beh,0a6h,0cbh,0a6h,0d8h	; a5e6  .].n............
	defb 0a6h,0e5h,0a6h,0feh,0a6h,017h,0a7h,030h,0a7h,061h,0a7h,086h,0a7h,0abh,0a7h,0f4h	; a5f6  .......0.a......
	defb 0a7h,005h,0a8h,016h,0a8h,027h,0a8h,048h,0a8h,069h,0a8h,09ah,0a8h,0dbh,0a8h,0f4h	; a606  .....'.H.i......
	defb 0a8h,00dh,0a9h,026h,0a9h,057h,0a9h,0a0h,0a9h,0c5h,0a9h,0eah,0a9h,033h,0aah,001h	; a616  ...&.W.......3..
	defb 001h,000h,000h,000h,001h,001h,001h,000h,000h,001h,001h,001h,001h,000h,001h,001h	; a626  ................
	defb 001h,001h,001h,002h,001h,000h,000h,000h,002h,000h,000h,000h,002h,001h,001h,000h	; a636  ................
	defb 000h,002h,001h,000h,000h,002h,001h,001h,001h,000h,002h,001h,001h,000h,002h,001h	; a646  ................
	defb 001h,001h,001h,002h,001h,001h,001h,004h,001h,001h,000h,000h,001h,002h,000h,000h	; a656  ................
	defb 002h,001h,000h,000h,002h,002h,000h,000h,004h,001h,001h,001h,000h,001h,002h,001h	; a666  ................
	defb 000h,002h,001h,001h,000h,002h,002h,001h,000h,004h,001h,001h,001h,001h,001h,002h	; a676  ................
	defb 001h,001h,002h,001h,001h,001h,002h,002h,001h,001h,008h,001h,001h,001h,000h,001h	; a686  ................
	defb 001h,002h,000h,001h,002h,001h,000h,001h,002h,002h,000h,002h,001h,001h,000h,002h	; a696  ................
	defb 001h,002h,000h,002h,002h,001h,000h,002h,002h,002h,000h,003h,001h,000h,000h,000h	; a6a6  ................
	defb 002h,000h,000h,000h,003h,000h,000h,000h,003h,001h,001h,000h,000h,002h,001h,000h	; a6b6  ................
	defb 000h,003h,001h,000h,000h,003h,001h,001h,001h,000h,002h,001h,001h,000h,003h,001h	; a6c6  ................
	defb 001h,000h,003h,001h,001h,001h,001h,002h,001h,001h,001h,003h,001h,001h,001h,006h	; a6d6  ................
	defb 001h,001h,000h,000h,001h,002h,000h,000h,002h,001h,000h,000h,002h,002h,000h,000h	; a6e6  ................
	defb 003h,001h,000h,000h,003h,002h,000h,000h,006h,001h,001h,001h,000h,001h,002h,001h	; a6f6  ................
	defb 000h,002h,001h,001h,000h,002h,002h,001h,000h,003h,001h,001h,000h,003h,002h,001h	; a706  ................
	defb 000h,006h,001h,001h,001h,001h,001h,002h,001h,001h,002h,001h,001h,001h,002h,002h	; a716  ................
	defb 001h,001h,003h,001h,001h,001h,003h,002h,001h,001h,00ch,001h,001h,001h,000h,001h	; a726  ................
	defb 001h,002h,000h,001h,002h,001h,000h,001h,002h,002h,000h,002h,001h,001h,000h,002h	; a736  ................
	defb 001h,002h,000h,002h,002h,001h,000h,002h,002h,002h,000h,003h,001h,001h,000h,003h	; a746  ................
	defb 001h,002h,000h,003h,002h,001h,000h,003h,002h,002h,000h,009h,001h,001h,000h,000h	; a756  ................
	defb 001h,002h,000h,000h,001h,003h,000h,000h,002h,001h,000h,000h,002h,002h,000h,000h	; a766  ................
	defb 002h,003h,000h,000h,003h,001h,000h,000h,003h,002h,000h,000h,003h,003h,000h,000h	; a776  ................
	defb 009h,001h,001h,001h,000h,001h,002h,001h,000h,001h,003h,001h,000h,002h,001h,001h	; a786  ................
	defb 000h,002h,002h,001h,000h,002h,003h,001h,000h,003h,001h,001h,000h,003h,002h,001h	; a796  ................
	defb 000h,003h,003h,001h,000h,012h,001h,001h,001h,000h,001h,001h,002h,000h,001h,002h	; a7a6  ................
	defb 001h,000h,001h,002h,002h,000h,001h,003h,001h,000h,001h,003h,002h,000h,002h,001h	; a7b6  ................
	defb 001h,000h,002h,001h,002h,000h,002h,002h,001h,000h,002h,002h,002h,000h,002h,003h	; a7c6  ................
	defb 001h,000h,002h,003h,002h,000h,003h,001h,001h,000h,003h,001h,002h,000h,003h,002h	; a7d6  ................
	defb 001h,000h,003h,002h,002h,000h,003h,003h,001h,000h,003h,003h,002h,000h,004h,001h	; a7e6  ................
	defb 000h,000h,000h,002h,000h,000h,000h,003h,000h,000h,000h,004h,000h,000h,000h,004h	; a7f6  ................
	defb 001h,001h,000h,000h,002h,001h,000h,000h,003h,001h,000h,000h,004h,001h,000h,000h	; a806  ................
	defb 004h,001h,001h,001h,000h,002h,001h,001h,000h,003h,001h,001h,000h,004h,001h,001h	; a816  ................
	defb 000h,008h,001h,001h,000h,000h,001h,002h,000h,000h,002h,001h,000h,000h,002h,002h	; a826  ................
	defb 000h,000h,003h,001h,000h,000h,003h,002h,000h,000h,004h,001h,000h,000h,004h,002h	; a836  ................
	defb 000h,000h,008h,001h,001h,001h,000h,001h,002h,001h,000h,002h,001h,001h,000h,002h	; a846  ................
	defb 002h,001h,000h,003h,001h,001h,000h,003h,002h,001h,000h,004h,001h,001h,000h,004h	; a856  ................
	defb 002h,001h,000h,00ch,001h,001h,000h,000h,001h,002h,000h,000h,001h,003h,000h,000h	; a866  ................
	defb 002h,001h,000h,000h,002h,002h,000h,000h,002h,003h,000h,000h,003h,001h,000h,000h	; a876  ................
	defb 003h,002h,000h,000h,003h,003h,000h,000h,004h,001h,000h,000h,004h,002h,000h,000h	; a886  ................
	defb 004h,003h,000h,000h,010h,001h,001h,000h,000h,001h,002h,000h,000h,001h,003h,000h	; a896  ................
	defb 000h,001h,004h,000h,000h,002h,001h,000h,000h,002h,002h,000h,000h,002h,003h,000h	; a8a6  ................
	defb 000h,002h,004h,000h,000h,003h,001h,000h,000h,003h,002h,000h,000h,003h,003h,000h	; a8b6  ................
	defb 000h,003h,004h,000h,000h,004h,001h,000h,000h,004h,002h,000h,000h,004h,003h,000h	; a8c6  ................
	defb 000h,004h,004h,000h,000h,006h,001h,000h,000h,000h,002h,000h,000h,000h,003h,000h	; a8d6  ................
	defb 000h,000h,004h,000h,000h,000h,005h,000h,000h,000h,006h,000h,000h,000h,008h,001h	; a8e6  ................
	defb 001h,000h,000h,002h,001h,000h,000h,003h,001h,000h,000h,004h,001h,000h,000h,005h	; a8f6  ................
	defb 001h,000h,000h,006h,001h,000h,000h,008h,001h,001h,001h,000h,002h,001h,001h,000h	; a906  ................
	defb 003h,001h,001h,000h,004h,001h,001h,000h,005h,001h,001h,000h,006h,001h,001h,000h	; a916  ................
	defb 00ch,001h,001h,000h,000h,001h,002h,000h,000h,002h,001h,000h,000h,002h,002h,000h	; a926  ................
	defb 000h,003h,001h,000h,000h,003h,002h,000h,000h,004h,001h,000h,000h,004h,002h,000h	; a936  ................
	defb 000h,005h,001h,000h,000h,005h,002h,000h,000h,006h,001h,000h,000h,006h,002h,000h	; a946  ................
	defb 000h,012h,001h,001h,000h,000h,001h,002h,000h,000h,001h,003h,000h,000h,002h,001h	; a956  ................
	defb 000h,000h,002h,002h,000h,000h,002h,003h,000h,000h,003h,001h,000h,000h,003h,002h	; a966  ................
	defb 000h,000h,003h,003h,000h,000h,004h,001h,000h,000h,004h,002h,000h,000h,004h,003h	; a976  ................
	defb 000h,000h,005h,001h,000h,000h,005h,002h,000h,000h,005h,003h,000h,000h,006h,001h	; a986  ................
	defb 000h,000h,006h,002h,000h,000h,006h,003h,000h,000h,009h,001h,000h,000h,000h,002h	; a996  ................
	defb 000h,000h,000h,003h,000h,000h,000h,004h,000h,000h,000h,005h,000h,000h,000h,006h	; a9a6  ................
	defb 000h,000h,000h,007h,000h,000h,000h,008h,000h,000h,000h,009h,000h,000h,000h,009h	; a9b6  ................
	defb 001h,001h,000h,000h,002h,001h,000h,000h,003h,001h,000h,000h,004h,001h,000h,000h	; a9c6  ................
	defb 005h,001h,000h,000h,006h,001h,000h,000h,007h,001h,000h,000h,008h,001h,000h,000h	; a9d6  ................
	defb 009h,001h,000h,000h,012h,001h,001h,000h,000h,001h,002h,000h,000h,002h,001h,000h	; a9e6  ................
	defb 000h,002h,002h,000h,000h,003h,001h,000h,000h,003h,002h,000h,000h,004h,001h,000h	; a9f6  ................
	defb 000h,004h,002h,000h,000h,005h,001h,000h,000h,005h,002h,000h,000h,006h,001h,000h	; aa06  ................
	defb 000h,006h,002h,000h,000h,007h,001h,000h,000h,007h,002h,000h,000h,008h,001h,000h	; aa16  ................
	defb 000h,008h,002h,000h,000h,009h,001h,000h,000h,009h,002h,000h,000h,01bh,001h,001h	; aa26  ................
	defb 000h,000h,001h,002h,000h,000h,001h,003h,000h,000h,002h,001h,000h,000h,002h,002h	; aa36  ................
	defb 000h,000h,002h,003h,000h,000h,003h,001h,000h,000h,003h,002h,000h,000h,003h,003h	; aa46  ................
	defb 000h,000h,004h,001h,000h,000h,004h,002h,000h,000h,004h,003h,000h,000h,005h,001h	; aa56  ................
	defb 000h,000h,005h,002h,000h,000h,005h,003h,000h,000h,006h,001h,000h,000h,006h,002h	; aa66  ................
	defb 000h,000h,006h,003h,000h,000h,007h,001h,000h,000h,007h,002h,000h,000h,007h,003h	; aa76  ................
	defb 000h,000h,008h,001h,000h,000h,008h,002h,000h,000h,008h,003h,000h,000h,009h,001h	; aa86  ................
	defb 000h,000h,009h,002h,000h,000h,009h,003h,000h,000h	; aa96  ..........

; ----------------------------------------------------------------------
; DATOS bloques_AAA0: lista de tiles (p00:58C5): X, Y y bloques (bit 7: n
;   tiles seguidos; si no, un tile repetido n veces), 0xFF acaba; lo leen
;   p00:5816 (747 bytes)
;   0xaaa0..0xad8b  (747 bytes)
DATA_bloques_AAA0:
	defb 000h,000h,004h,001h,090h,00ah,00bh,00ah,00bh,00ah,00bh,00ah,00bh,00ah,00bh,00ah	; aaa0  ................
	defb 00bh,00ah,00bh,00ah,00bh,010h,001h,090h,008h,009h,008h,009h,008h,009h,008h,009h	; aab0  ................
	defb 008h,009h,008h,009h,008h,009h,008h,009h,010h,001h,090h,00ch,00dh,00ch,00dh,00ch	; aac0  ................
	defb 00dh,00ch,00dh,00ch,00dh,00ch,00dh,00ch,00dh,00ch,00dh,00ch,001h,085h,004h,003h	; aad0  ................
	defb 0fbh,003h,003h,003h,0fbh,010h,003h,003h,0fbh,091h,003h,003h,0fbh,003h,005h,002h	; aae0  ................
	defb 00eh,00fh,00eh,00fh,010h,035h,000h,027h,010h,020h,02ah,00ch,000h,0f1h,027h,010h	; aaf0  .....5.'. *...'.
	defb 020h,00eh,00fh,010h,020h,002h,0fah,011h,012h,011h,013h,014h,036h,000h,030h,015h	; ab00   ... .......6.0.
	defb 016h,02ch,037h,038h,000h,000h,037h,038h,037h,038h,000h,000h,037h,038h,030h,015h	; ab10  .,78..7878..780.
	defb 016h,017h,025h,026h,016h,0fah,002h,018h,019h,01ah,01bh,022h,000h,03bh,023h,024h	; ab20  ..%&......."..#$
	defb 01ch,01dh,01bh,022h,000h,000h,02bh,01dh,01bh,01dh,021h,01ah,01bh,01dh,021h,018h	; ab30  ..."..+...!...!.
	defb 01ch,02ah,000h,000h,02bh,002h,002h,015h,01eh,011h,012h,028h,000h,03ch,072h,07dh	; ab40  .*..+......(.<r}
	defb 041h,0a0h,071h,040h,037h,038h,030h,0b0h,0b1h,0b2h,0b3h,041h,0b4h,017h,0b5h,0b6h	; ab50  A.q@780....A....
	defb 0b7h,028h,037h,038h,02dh,002h,002h,039h,029h,018h,019h,07ah,068h,067h,099h,005h	; ab60  .(78-..9)..zhg..
	defb 065h,098h,0afh,06fh,019h,0b8h,065h,0b9h,0bah,055h,056h,0bbh,0bch,065h,0bdh,018h	; ab70  e..o..e..UV..e..
	defb 01ch,022h,000h,002h,002h,000h,030h,015h,070h,042h,004h,065h,0cbh,043h,044h,045h	; ab80  ."....0.pB.e.CDE
	defb 043h,066h,069h,01eh,0beh,065h,0bfh,0c0h,055h,057h,0c1h,0c2h,065h,058h,0c3h,01eh	; ab90  Cfi..e..UW..eX..
	defb 028h,000h,002h,0fah,03bh,021h,018h,01ch,046h,073h,074h,075h,076h,077h,078h,079h	; aba0  (....!..Fstuvwxy
	defb 06ah,000h,03bh,021h,046h,065h,0c5h,0c6h,059h,057h,0c7h,0c8h,065h,0c9h,018h,019h	; abb0  j..!Fe..YW..e...
	defb 018h,035h,0fah,0fah,03ah,013h,014h,016h,046h,047h,014h,07bh,07ch,016h,014h,046h	; abc0  .5..:...FG.{|..F
	defb 06bh,037h,03ah,012h,0cah,0cbh,0cch,0cdh,005h,065h,0bdh,0ceh,014h,01eh,015h,036h	; abd0  k7:......e.....6
	defb 0fah,0fah,01fh,01ch,01fh,01ch,046h,049h,07eh,07fh,04ah,080h,081h,046h,04bh,082h	; abe0  ......FI~.J..FK.
	defb 01dh,021h,0cfh,0d0h,0d1h,05bh,065h,05ch,05dh,0d2h,0d3h,0d4h,01dh,021h,01ah,023h	; abf0  .!...[e\]....!.#
	defb 0fah,002h,014h,01eh,015h,083h,055h,04ch,04dh,065h,065h,085h,086h,065h,065h,049h	; ac00  ......ULMee..eeI
	defb 017h,072h,0d5h,05eh,065h,05fh,060h,0d6h,003h,065h,09ah,0d7h,017h,012h,011h,013h	; ac10  .r.^e_`..e......
	defb 002h,002h,01dh,021h,01ah,087h,065h,049h,088h,04eh,04fh,089h,08ah,065h,065h,08bh	; ac20  ...!..eI.NO..ee.
	defb 01dh,0d8h,0d9h,065h,061h,003h,065h,0ceh,062h,0dah,0dbh,0dch,02ah,03dh,039h,01bh	; ac30  ...ea.e.b...*=9.
	defb 002h,002h,02eh,012h,011h,08ch,065h,049h,08dh,065h,065h,08eh,08fh,065h,065h,090h	; ac40  ......eI.ee..ee.
	defb 011h,013h,0ddh,065h,0deh,0dfh,0e0h,065h,0e1h,0e2h,0edh,0e4h,028h,037h,038h,025h	; ac50  ...e...e....(78%
	defb 002h,0fah,03bh,021h,01ah,091h,065h,049h,092h,065h,050h,093h,065h,065h,051h,052h	; ac60  ...!..eI.eP.eeQR
	defb 094h,01ch,0e5h,065h,063h,064h,064h,065h,062h,0dah,0e6h,0e7h,018h,01ch,01fh,035h	; ac70  ...ecddeb......5
	defb 0fah,0fah,03ch,012h,011h,095h,004h,065h,0edh,053h,096h,065h,065h,097h,054h,098h	; ac80  ..<....e.S.ee.T.
	defb 016h,0ddh,065h,0e8h,0e9h,0eah,065h,0ebh,0ech,0edh,0e4h,015h,034h,026h,036h,0fah	; ac90  ..e...e.....4&6.
	defb 0fah,02fh,03dh,039h,06dh,065h,049h,09ah,055h,049h,09bh,09ch,055h,09dh,09eh,09fh	; aca0  ./=9meI.UI..U...
	defb 01ch,0e5h,065h,0eeh,0efh,043h,065h,062h,0f0h,0f1h,0f2h,018h,035h,000h,000h,0fah	; acb0  ..e..Ceb....5...
	defb 002h,028h,037h,038h,06ch,065h,0a1h,0a2h,055h,049h,013h,0a3h,055h,0a4h,0a5h,0a6h	; acc0  .(78le..UI..U...
	defb 01eh,0f3h,065h,0f4h,0f5h,0f6h,065h,0ebh,0f7h,0edh,0e4h,015h,03fh,038h,000h,002h	; acd0  ..e...e.....?8..
	defb 002h,018h,01ch,01fh,0a7h,0a8h,0a9h,0aah,0abh,0ach,01ch,0aah,0aeh,06eh,000h,03bh	; ace0  .............n..
	defb 021h,0f8h,0f9h,0e3h,0c4h,084h,003h,0adh,0d7h,0f1h,0f2h,018h,01ch,01fh,035h,002h	; acf0  !.............5.
	defb 002h,026h,01eh,015h,01eh,015h,034h,026h,01eh,015h,01eh,015h,016h,02ch,000h,03ch	; ad00  .&....4&.....,.<
	defb 012h,011h,025h,026h,01eh,011h,013h,014h,01eh,011h,012h,015h,016h,014h,03fh,002h	; ad10  ..%&..........?.
	defb 002h,03bh,021h,018h,019h,031h,000h,03bh,021h,01ah,021h,01ah,01bh,01dh,023h,02fh	; ad20  ..!..1..!.!...#/
	defb 03dh,039h,000h,000h,03dh,039h,02bh,01fh,03eh,039h,029h,018h,01ch,01dh,01bh,002h	; ad30  =9..=9+.>9).....
	defb 0fah,03ch,012h,015h,01eh,028h,037h,03ah,012h,011h,012h,011h,012h,011h,025h,032h	; ad40  .<...(7:......%2
	defb 006h,000h,098h,02dh,026h,036h,000h,030h,015h,01eh,011h,013h,0fah,002h,000h,03dh	; ad50  ...-&6.0.......=
	defb 039h,03dh,039h,02bh,01fh,019h,018h,019h,018h,03eh,039h,009h,000h,08eh,03bh,023h	; ad60  9=9+.....>9....#
	defb 033h,021h,01ah,021h,018h,01ch,002h,006h,003h,0fbh,003h,003h,003h,0fbh,010h,003h	; ad70  3!.!............
	defb 003h,0fbh,085h,003h,003h,0fbh,003h,007h,020h,001h,0ffh	; ad80  ........ ..

; ----------------------------------------------------------------------
; DATOS relleno_ff: 117 bytes a 0xFF entre dos bloques, que no lee nadie:
;   relleno; lo leen nadie (117 bytes)
;   0xad8b..0xae00  (117 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad8b  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad9b  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adab  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adbb  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adcb  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; addb  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adeb  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh	; adfb

; ----------------------------------------------------------------------
; DATOS voz_0x17: la voz digital 0x17 (con el banco 15 en 0xA000, p12:6059):
;   la marca del final es 0xAF
;   0xae00..0xb6e2  (2274 bytes)
DATA_voz_0x17:
	defb 0afh,03dh,0f2h,0ffh,01fh,0f2h,01fh,02fh,002h,0ffh,001h,0e2h,0feh,01fh,012h,0f0h	; ae00  .=...../........
	defb 000h,0e1h,0ffh,001h,021h,0ffh,02eh,013h,00eh,0e1h,0feh,000h,0e0h,031h,0eeh,001h	; ae10  ....!........1..
	defb 0f2h,00eh,0e1h,020h,0feh,022h,002h,00eh,0e1h,0feh,002h,010h,012h,01eh,001h,0ffh	; ae20  ... ."..........
	defb 002h,00eh,010h,0f0h,000h,010h,012h,0f0h,0eeh,010h,00eh,000h,011h,0feh,010h,012h	; ae30  ................
	defb 010h,010h,012h,00fh,00eh,0f0h,00eh,0f1h,0f2h,000h,010h,000h,020h,0f0h,0ffh,0f0h	; ae40  ............ ...
	defb 0ffh,0e0h,010h,011h,01fh,011h,011h,0ffh,000h,0ffh,00fh,0f1h,010h,000h,000h,000h	; ae50  ................
	defb 01fh,000h,010h,00fh,000h,000h,010h,0f0h,010h,000h,000h,001h,000h,00fh,000h,000h	; ae60  ................
	defb 000h,000h,011h,001h,00fh,00fh,000h,0f0h,000h,00fh,000h,010h,011h,001h,001h,0f0h	; ae70  ................
	defb 0ffh,001h,000h,0ffh,0f0h,001h,010h,0f0h,0f0h,0f0h,010h,010h,000h,000h,0f0h,000h	; ae80  ................
	defb 001h,0f0h,00fh,011h,001h,0f0h,001h,010h,000h,0ffh,0f0h,000h,00fh,0f0h,011h,011h	; ae90  ................
	defb 000h,0f0h,001h,010h,020h,011h,011h,012h,001h,010h,021h,010h,00eh,0efh,0efh,0ffh	; aea0  .... .....!.....
	defb 0edh,0ddh,0ddh,0ddh,0cch,0bch,0d0h,044h,054h,054h,044h,044h,032h,0ech,0cch,0cch	; aeb0  .......DTTDD2...
	defb 0d0h,033h,044h,044h,043h,020h,0edh,0dch,0ddh,0efh,0f0h,000h,012h,022h,022h,0fdh	; aec0  .3DDC ......."".
	defb 0dch,0cbh,0bah,0ach,023h,043h,056h,056h,044h,053h,02dh,0bbh,0bbh,0bch,024h,055h	; aed0  ....#CVVDS-...$U
	defb 055h,043h,01fh,00eh,0edh,0cch,0cch,0c2h,034h,044h,033h,033h,02eh,0edh,0dch,0dch	; aee0  UC......4D33....
	defb 0ddh,0ddh,0bbh,0aah,0d3h,043h,056h,065h,053h,0eeh,0dfh,00dh,0cbh,0bch,0c1h,045h	; aef0  .....CVeS......E
	defb 056h,055h,03ch,0bbh,0bch,0d0h,023h,032h,022h,023h,033h,043h,01eh,0edh,0dch,0deh	; af00  VU<...#2"#3C....
	defb 0e0h,0feh,0dbh,0bah,0abh,033h,044h,066h,065h,05ch,0cbh,0cdh,0deh,0dch,0cch,0c3h	; af10  .....3Dfe\......
	defb 045h,056h,055h,0ebh,0bbh,0bch,0e4h,045h,030h,0dch,0efh,034h,044h,040h,0dch,0cch	; af20  EVU....E0..4D@..
	defb 0cdh,0ddh,0cbh,0aah,0bfh,034h,036h,066h,066h,0dbh,0abh,0bbh,0c0h,034h,020h,023h	; af30  .....46ff....4 #
	defb 045h,055h,054h,0dch,0bbh,0bbh,0e3h,045h,053h,03eh,0ddh,0f0h,034h,021h,0edh,0cch	; af40  EUT....ES>..4!..
	defb 0cbh,0aah,0ach,033h,043h,066h,066h,053h,0ebh,0bbh,0ach,0cch,003h,034h,054h,055h	; af50  ...3CffS.....4TU
	defb 045h,030h,0dch,0bch,0cch,0e1h,034h,034h,033h,032h,022h,02fh,0fdh,0dch,0bbh,0aah	; af60  E0....4432"/....
	defb 0ach,034h,034h,066h,075h,050h,0bah,0bah,0bch,0c1h,043h,044h,044h,055h,054h,044h	; af70  .44fuP....CDDUTD
	defb 0cch,0bbh,0bdh,0d2h,044h,054h,043h,01fh,000h,0eeh,0dch,0bbh,0a9h,0b3h,043h,044h	; af80  ....DTC.......CD
	defb 067h,066h,04bh,0abh,0aah,0beh,044h,044h,043h,034h,044h,055h,044h,01ch,0bbh,0cbh	; af90  gfK...DDC4DUD...
	defb 0d3h,034h,054h,044h,021h,0edh,0cch,0bah,0aah,0bdh,033h,045h,067h,065h,03ch,0bah	; afa0  .4TD!.....3Ege<.
	defb 0aah,0cch,034h,045h,044h,042h,034h,044h,053h,02eh,0cch,0cch,0cdh,024h,034h,044h	; afb0  ..4EDB4DS....$4D
	defb 031h,0dbh,0bah,0aah,0bdh,024h,036h,066h,065h,04ch,0bah,0bbh,0bdh,023h,044h,044h	; afc0  1....$6feL...#DD
	defb 022h,034h,045h,044h,04fh,0ddh,0cch,0ddh,0e1h,023h,042h,0ech,0bah,0aah,0bdh,033h	; afd0  "4EDO....#B....3
	defb 046h,066h,065h,02ch,0bah,0abh,0cfh,034h,054h,044h,033h,043h,044h,043h,03eh,0deh	; afe0  Ffe,...4TD3CDC>.
	defb 0ddh,0deh,0f2h,022h,01dh,0bbh,0aah,0ach,033h,045h,066h,066h,03dh,0bbh,0abh,0bch	; aff0  ..."....3Eff=...
	defb 033h,045h,034h,032h,033h,034h,053h,044h,031h,0edh,0cch,0ddh,0ddh,0cbh,0bah,0abh	; b000  3E4234SD1.......
	defb 0d2h,044h,066h,066h,053h,0cbh,0bah,0bbh,0beh,034h,054h,054h,034h,034h,043h,044h	; b010  .DffS....4TT44CD
	defb 032h,02eh,0ddh,0cch,0dch,0bbh,0bah,0bbh,0b3h,035h,065h,066h,052h,0ech,0bbh,0bbh	; b020  2........5efR...
	defb 0cch,003h,034h,034h,044h,044h,054h,044h,032h,01eh,0ddh,0cch,0cbh,0bah,0aah,0b3h	; b030  ..44DDTD2.......
	defb 043h,056h,065h,064h,03fh,0cbh,0bch,0bch,0efh,001h,033h,034h,044h,055h,044h,044h	; b040  CVed?.....34DUDD
	defb 00eh,0ddh,0cch,0bbh,0abh,0aah,0c3h,034h,056h,056h,054h,041h,0cch,0cch,0cch,0ddh	; b050  .......4VVTA....
	defb 0dfh,002h,034h,045h,055h,044h,043h,00dh,0cch,0bbh,0aah,0bah,0c1h,035h,055h,055h	; b060  ..4EUDC......5UU
	defb 054h,02eh,0efh,0feh,00fh,0edh,0deh,001h,034h,044h,053h,043h,0ffh,0ech,0cbh,0bbh	; b070  T.......4DSC....
	defb 0bbh,0e0h,013h,032h,033h,022h,030h,023h,033h,043h,022h,0ffh,0e1h,023h,034h,033h	; b080  ...23"0#3C"..#43
	defb 032h,021h,0fch,0cch,0cch,0c1h,00eh,0eeh,0dch,0ddh,0cdh,02fh,034h,034h,043h,022h	; b090  2!........./44C"
	defb 020h,012h,034h,044h,033h,042h,023h,0ech,0cdh,0cbh,0ddh,0cdh,0ddh,0cdh,0dch,0d2h	; b0a0   .4D3B#.........
	defb 002h,043h,034h,042h,021h,001h,033h,044h,044h,044h,032h,02dh,0cch,0cch,0beh,0edh	; b0b0  .C4B!.3DDD2-....
	defb 0ddh,0cch,0cch,0ceh,012h,024h,044h,043h,032h,000h,012h,034h,044h,044h,043h,02fh	; b0c0  .....$DC2..4DDC/
	defb 0dch,0cch,0cch,0ddh,0cdh,0dch,0cdh,0cch,0f2h,003h,043h,034h,033h,023h,033h,034h	; b0d0  ..........C43#34
	defb 044h,044h,044h,00ch,0cch,0cch,0cdh,0dch,0ddh,0cch,0cdh,0cdh,002h,034h,043h,033h	; b0e0  DDD..........4C3
	defb 022h,012h,033h,044h,045h,044h,040h,0dch,0cch,0cch,0cdh,0dch,0dch,0cch,0dch,0d0h	; b0f0  ".3DED@.........
	defb 013h,033h,034h,033h,033h,033h,034h,044h,054h,042h,0dch,0cch,0cch,0ddh,0cdh,0dch	; b100  .343334DTB......
	defb 0cch,0cdh,0deh,0f3h,033h,043h,033h,033h,033h,044h,044h,054h,031h,0cdh,0cch,0cdh	; b110  ....3C333DDT1...
	defb 0cdh,0cdh,0cch,0dch,0cdh,0efh,013h,034h,034h,023h,032h,034h,044h,045h,042h,0fdh	; b120  .......44#24DEB.
	defb 0dch,0cch,0dch,0dch,0dch,0cdh,0cdh,0deh,0e2h,033h,034h,033h,033h,033h,044h,045h	; b130  .........34333DE
	defb 043h,00dh,0dch,0cdh,0dch,0dch,0dch,0dch,0dch,0ddh,0e1h,033h,034h,043h,033h,033h	; b140  C..........34C33
	defb 044h,045h,032h,0eeh,0dch,0cdh,0dch,0cch,0cdh,0ddh,0ddh,0edh,012h,023h,033h,043h	; b150  DE2..........#3C
	defb 034h,044h,044h,044h,00dh,0ddh,0dch,0edh,0cdh,0cch,0cdh,0cdh,0deh,0e0h,032h,033h	; b160  4DDD..........23
	defb 043h,033h,043h,044h,054h,030h,0deh,0dch,0ddh,0cch,0cch,0dch,0ddh,0ddh,0efh,023h	; b170  C3CDT0.........#
	defb 033h,034h,033h,043h,044h,044h,033h,0edh,0ddh,0ddh,0cch,0cdh,0cch,0ddh,0deh,0efh	; b180  343CDD3.........
	defb 002h,033h,034h,033h,044h,034h,044h,031h,0eeh,0ddh,0ddh,0dch,0cch,0cdh,0cdh,0dfh	; b190  .343D4D1........
	defb 0f0h,023h,033h,033h,034h,043h,044h,043h,020h,0ddh,0ddh,0ddh,0cdh,0cch,0dch,0ddh	; b1a0  .#334CDC .......
	defb 0e0h,002h,033h,023h,034h,034h,034h,044h,032h,0eeh,0ddh,0ddh,0dch,0dch,0cch,0ddh	; b1b0  ..3#444D2.......
	defb 0deh,0f1h,023h,033h,033h,034h,034h,044h,043h,01eh,0ddh,0ddh,0ddh,0cch,0dch,0cdh	; b1c0  ..#3344DC.......
	defb 0ceh,0e0h,022h,033h,034h,034h,034h,044h,042h,02fh,0fdh,0ddh,0ddh,0cch,0cdh,0cdh	; b1d0  .."3444DB/......
	defb 0cdh,000h,022h,032h,033h,034h,034h,044h,043h,03fh,0fdh,0ddh,0ddh,0cdh,0dch,0cch	; b1e0  .."2344DC?......
	defb 0ddh,0dfh,013h,032h,033h,034h,043h,044h,043h,02fh,0fdh,0ddh,0ddh,0cdh,0cch,0dch	; b1f0  ...234CDC/......
	defb 0ddh,0f0h,022h,033h,033h,034h,043h,044h,042h,02eh,0edh,0ddh,0dch,0dch,0dch,0dch	; b200  .."334CDB.......
	defb 0deh,0eeh,022h,033h,034h,044h,034h,044h,032h,00fh,0edh,0ddh,0cdh,0cch,0cch,0ddh	; b210  .."34D4D2.......
	defb 0deh,011h,022h,033h,034h,044h,044h,043h,022h,0fdh,0edh,0ddh,0cch,0dch,0cch,0ddh	; b220  .."34DDC".......
	defb 0dfh,012h,023h,033h,044h,044h,044h,033h,020h,0eeh,0ddh,0dch,0dch,0cch,0cdh,0ddh	; b230  ..#3DDD3 .......
	defb 0f1h,012h,023h,034h,043h,044h,044h,033h,0feh,0edh,0ddh,0cdh,0cch,0dch,0dch,0deh	; b240  ..#4CDD3........
	defb 0f1h,022h,034h,034h,044h,044h,034h,022h,0feh,0ddh,0dch,0dch,0cch,0dch,0ddh,0eeh	; b250  ."44DD4"........
	defb 002h,022h,033h,044h,044h,044h,033h,030h,0eeh,0ddh,0dch,0cdh,0cch,0dch,0ddh,0efh	; b260  ."3DDD30........
	defb 012h,023h,034h,034h,044h,044h,033h,01fh,0eeh,0ddh,0dch,0cdh,0cch,0ddh,0ddh,0d1h	; b270  .#44DD3.........
	defb 012h,023h,034h,034h,044h,044h,032h,01eh,0edh,0ddh,0dch,0dch,0cdh,0cdh,0deh,0efh	; b280  .#44DD2.........
	defb 022h,023h,034h,034h,044h,044h,032h,00fh,0edh,0ddh,0dch,0dch,0cdh,0ddh,0ddh,0efh	; b290  "#44DD2.........
	defb 002h,033h,034h,034h,044h,043h,032h,00eh,0eeh,0ddh,0cdh,0cdh,0cdh,0ddh,0deh,0f0h	; b2a0  .344DC2.........
	defb 012h,023h,034h,044h,034h,033h,031h,00eh,0edh,0ddh,0cdh,0dch,0ddh,0ddh,0efh,0f0h	; b2b0  .#4D431.........
	defb 022h,033h,034h,034h,043h,033h,020h,0feh,0ddh,0ddh,0dch,0ddh,0ddh,0deh,0efh,001h	; b2c0  "344C3 .........
	defb 012h,033h,043h,043h,043h,031h,01fh,0feh,0ddh,0ddh,0ddh,0ceh,0ddh,0efh,0e0h,0f1h	; b2d0  .3CCC1..........
	defb 022h,033h,043h,043h,033h,022h,00fh,0eeh,0edh,0ddh,0ddh,0ddh,0deh,0efh,0ffh,010h	; b2e0  "3CC3"..........
	defb 022h,033h,034h,033h,032h,021h,00fh,0eeh,0edh,0edh,0deh,0deh,0eeh,0eeh,00fh,000h	; b2f0  "3432!..........
	defb 022h,032h,033h,033h,032h,020h,00fh,0feh,0feh,0edh,0edh,0eeh,0dfh,0ffh,0f0h,001h	; b300  "2332 ..........
	defb 012h,032h,033h,022h,022h,001h,00fh,00eh,0feh,0eeh,0eeh,0dfh,0ffh,0ffh,00fh,010h	; b310  .23""...........
	defb 022h,023h,022h,022h,020h,010h,0f0h,0ffh,0eeh,0eeh,0eeh,0eeh,0ffh,000h,001h,011h	; b320  "#"" ...........
	defb 022h,022h,022h,022h,001h,000h,00fh,0ffh,0eeh,0eeh,0dfh,0efh,0f1h,000h,011h,001h	; b330  """"............
	defb 022h,022h,022h,021h,001h,000h,0ffh,0ffh,0eeh,0eeh,0eeh,0efh,000h,001h,000h,011h	; b340  """!............
	defb 022h,022h,022h,021h,010h,010h,0f0h,0feh,0feh,0eeh,0deh,0deh,0ddh,0deh,013h,044h	; b350  """!...........D
	defb 044h,045h,044h,03eh,0cch,0bbh,0bbh,0cdh,000h,010h,0eeh,0d0h,013h,045h,055h,065h	; b360  DED>.........EUe
	defb 055h,03dh,0cdh,0bbh,0aah,0aah,0a2h,034h,034h,065h,065h,055h,02dh,0cch,0cdh,0d3h	; b370  U=.....44eeU-...
	defb 044h,054h,042h,0cbh,0aah,0aah,0b2h,034h,066h,065h,054h,00ch,0bbh,0bch,0dfh,023h	; b380  DTB....4feT....#
	defb 044h,045h,055h,054h,03dh,0bbh,0aah,09ah,034h,034h,056h,066h,065h,0cbh,0bah,0bbh	; b390  DEUT=...44Vfe...
	defb 0cfh,044h,056h,055h,055h,0fch,0bah,0aah,0aah,0d3h,044h,066h,066h,054h,0dbh,0bah	; b3a0  .DVUU.....DffT..
	defb 0bbh,0bdh,024h,045h,056h,056h,05dh,0dch,0cah,0a9h,0abh,013h,043h,067h,066h,054h	; b3b0  ..$EVV].....CgfT
	defb 0bbh,0a9h,0bbh,0bdh,044h,056h,056h,066h,04dh,0cdh,0dbh,0a9h,09bh,034h,034h,046h	; b3c0  ....DVVfM....44F
	defb 077h,052h,0dch,0aah,09ah,0bch,034h,045h,066h,066h,063h,0dch,0ddh,0cah,099h,0bdh	; b3d0  wR....4Effc.....
	defb 033h,043h,067h,076h,0dch,0dch,09ah,09bh,0d3h,034h,045h,066h,067h,04dh,0cch,0ddh	; b3e0  3Cgv.....4EfgM..
	defb 0cbh,0a9h,09ch,024h,034h,047h,076h,05fh,0dch,0b9h,09ah,0c2h,034h,034h,066h,066h	; b3f0  ...$4Gv_....44ff
	defb 065h,01dh,0cdh,0cdh,0bbh,099h,0bch,024h,034h,057h,076h,04dh,0dch,0a9h,09bh,0d3h	; b400  e......$4WvM....
	defb 034h,035h,056h,066h,066h,0dch,0cdh,0cdh,0dbh,0bah,09ah,0bdh,034h,035h,077h,064h	; b410  45Vff.......45wd
	defb 0fdh,0cah,099h,0bdh,033h,045h,055h,056h,055h,065h,041h,0dch,0cdh,0cch,0bbh,0aah	; b420  ....3EUVUeA.....
	defb 09bh,033h,043h,057h,076h,05dh,0dbh,0a9h,0aah,0c0h,033h,056h,055h,054h,045h,054h	; b430  .3CWv]....3VUTET
	defb 043h,0efh,0d0h,020h,0dch,0bah,099h,003h,043h,045h,077h,064h,0fdh,0b9h,09ah,0b3h	; b440  C.. ....CEwd....
	defb 043h,056h,055h,054h,021h,033h,034h,042h,033h,033h,034h,01dh,0cbh,0a9h,09dh,024h	; b450  CVUT!34B334....$
	defb 034h,057h,076h,040h,0dah,0a9h,0aah,034h,045h,065h,044h,042h,034h,045h,044h,001h	; b460  4Wv@...4EeDB4ED.
	defb 0ddh,0d3h,044h,032h,0cbh,0a9h,09dh,034h,034h,057h,076h,04eh,0dah,09ah,093h,034h	; b470  ..D2...44WvN...4
	defb 046h,055h,055h,031h,012h,0deh,01dh,0d3h,043h,045h,044h,044h,0edh,0dbh,0aah,09ah	; b480  FUU1....CEDD....
	defb 0c3h,043h,047h,077h,0ddh,0cbh,0a9h,0aah,0c2h,045h,055h,055h,045h,045h,04dh,02ch	; b490  .CGw.....EUUEEM,
	defb 0bbh,0cch,0e4h,054h,055h,055h,00dh,0ddh,0bah,0a9h,0ach,024h,034h,067h,075h,04dh	; b4a0  ...TUU.....$4guM
	defb 0dah,0a9h,0aah,034h,035h,055h,056h,055h,064h,0ebh,0bah,0aah,0c2h,056h,066h,064h	; b4b0  ...45UVUd....Vfd
	defb 0dch,0bch,0d0h,01eh,0cbh,0a9h,0abh,023h,044h,047h,076h,05eh,0dah,09ah,092h,043h	; b4c0  .......#DGv^...C
	defb 045h,066h,055h,053h,035h,0ddh,0dah,0aah,0abh,014h,056h,077h,04eh,0dbh,0aah,0bch	; b4d0  EfUS5.....VwN...
	defb 055h,064h,02bh,0b9h,09bh,0d3h,043h,047h,076h,052h,0dah,099h,0a3h,043h,046h,066h	; b4e0  Ud+...CGvR...CFf
	defb 05dh,041h,0d5h,053h,04ch,0aah,09ah,0d3h,043h,067h,075h,03dh,0cah,09ah,0a5h,066h	; b4f0  ]A.SL...Cgu=...f
	defb 066h,041h,0dch,0aah,09ah,0b2h,034h,036h,077h,06dh,0cbh,09ah,0abh,0beh,034h,055h	; b500  fA....46wm....4U
	defb 055h,066h,055h,050h,0bbh,0a9h,0aah,0e3h,045h,066h,076h,040h,0bah,0aah,0abh,045h	; b510  UfUP....Efv@...E
	defb 066h,064h,03ch,0cbh,0cch,0ddh,0cbh,0a9h,0c3h,034h,034h,077h,065h,02dh,0a9h,0a9h	; b520  fd<......44we-..
	defb 013h,043h,056h,076h,055h,0bbh,0cbh,0bbh,0bbh,0cbh,0edh,035h,046h,065h,054h,0cbh	; b530  .CVvU......5FeT.
	defb 0abh,0abh,0d2h,045h,065h,055h,02ch,0cch,0bch,0ddh,024h,022h,0fbh,0abh,0abh,0f3h	; b540  ...EeU,...$"....
	defb 034h,067h,066h,05bh,0aah,0aah,0adh,035h,065h,065h,050h,04dh,0cdh,0cch,0cbh,0cch	; b550  4gf[...5eePM....
	defb 0b2h,0e4h,055h,055h,054h,0cbh,0bah,0abh,0beh,045h,066h,065h,05dh,0bah,0bbh,0bch	; b560  ..UUT....Efe]...
	defb 024h,055h,050h,0edh,0cch,0cdh,0e0h,001h,002h,022h,0fbh,0cbh,0bbh,0e3h,056h,056h	; b570  $UP......"....VV
	defb 064h,00bh,0bbh,0abh,0c0h,045h,055h,054h,03fh,0ech,0cch,0bdh,0c0h,00eh,034h,024h	; b580  d....EUT?.....4$
	defb 033h,032h,02dh,0cdh,0cbh,0cch,0c0h,034h,055h,055h,042h,0cch,0bbh,0bdh,0e2h,044h	; b590  32-....4UUB....D
	defb 044h,040h,0dch,0cdh,0ceh,013h,034h,032h,0edh,0dch,0eeh,013h,044h,02dh,0cbh,0bch	; b5a0  D@....42....D-..
	defb 0c2h,045h,056h,054h,03ch,0bbh,0bbh,0b1h,044h,055h,053h,03eh,0cch,0cch,0deh,001h	; b5b0  .EVT<...DUS>....
	defb 022h,00eh,0eeh,0dfh,022h,034h,034h,031h,0edh,0ech,0ddh,0ddh,002h,033h,032h,00fh	; b5c0  "..."441.....32.
	defb 0edh,0deh,0dfh,012h,022h,021h,0eeh,0feh,002h,022h,020h,0ddh,0dch,0d2h,033h,045h	; b5d0  ...."!..." ...3E
	defb 043h,02eh,0cch,0dch,0c0h,013h,044h,034h,03eh,0edh,0cch,0deh,0f2h,033h,032h,01fh	; b5e0  C.....D4>....32.
	defb 0feh,0dfh,0f0h,0e1h,0edh,0efh,0e2h,033h,044h,043h,0feh,0dch,0cch,0cdh,003h,034h	; b5f0  .......3DC.....4
	defb 043h,020h,0ddh,0ddh,0deh,012h,022h,022h,00fh,0efh,000h,0f0h,0ffh,0eeh,0f1h,012h	; b600  C ....""........
	defb 032h,032h,010h,0ffh,0ffh,002h,012h,010h,01eh,0efh,0efh,0f1h,022h,021h,000h,0feh	; b610  22.........."!..
	defb 0deh,0dfh,0f0h,002h,022h,022h,010h,00fh,0feh,0eeh,0ffh,000h,012h,011h,021h,000h	; b620  ....""........!.
	defb 0ffh,0efh,0efh,001h,002h,021h,010h,01fh,000h,000h,011h,0f1h,0f0h,00fh,000h,010h	; b630  .....!..........
	defb 000h,000h,000h,0f1h,000h,001h,010h,01fh,0f0h,0ffh,0ffh,0f0h,001h,001h,020h,000h	; b640  .............. .
	defb 0ffh,0feh,0ffh,001h,001h,01fh,0feh,0feh,011h,023h,033h,022h,00eh,0ddh,0ddh,0d0h	; b650  .........#3"....
	defb 023h,033h,033h,02fh,0eeh,0ddh,0feh,000h,012h,011h,011h,00fh,0f0h,0ffh,0ffh,0ffh	; b660  #33/............
	defb 0f0h,001h,012h,012h,000h,00fh,0feh,0ffh,000h,002h,021h,021h,000h,0ffh,0feh,00fh	; b670  ..........!!....
	defb 010h,010h,010h,000h,000h,000h,0f0h,001h,000h,000h,0f0h,00fh,000h,001h,001h,001h	; b680  ................
	defb 000h,000h,0f0h,000h,0f0h,001h,000h,000h,00fh,000h,000h,0f1h,00fh,000h,000h,00fh	; b690  ................
	defb 000h,000h,0f0h,001h,011h,011h,020h,010h,0ffh,0feh,0ffh,0f0h,011h,021h,010h,010h	; b6a0  ...... ......!..
	defb 0ffh,0ffh,0ffh,0f0h,011h,012h,011h,01fh,00eh,0ffh,0ffh,000h,001h,001h,021h,020h	; b6b0  ..............!
	defb 0feh,0edh,0ddh,0f2h,023h,033h,041h,0ffh,0ddh,0ddh,0efh,022h,023h,022h,021h,0feh	; b6c0  ....#3A...."#"!.
	defb 0feh,0efh,00fh,000h,001h,000h,011h,011h,001h,00fh,0ffh,0eeh,0ffh,001h,022h,021h	; b6d0  .............."!
	defb 010h,0afh	; b6e0

; ----------------------------------------------------------------------
; DATOS voz_0x18: la voz digital 0x18 (la marca del final es 0xAF)
;   0xb6e2..0xc000  (2334 bytes)
DATA_voz_0x18:
	defb 0afh,0c2h,056h,03ch,0aah,0abh,046h,066h,05fh,0cch,0bch,0dch,0d4h,0ffh,03dh,0f3h	; b6e2  ..V<..Ff_.....=.
	defb 033h,02eh,0cbh,0bfh,044h,056h,05eh,0cbh,0bbh,0bch,045h,066h,053h,0bah,09ah,0cdh	; b6f2  3...DV^...EfS...
	defb 066h,066h,05eh,0bah,0aah,045h,055h,066h,0fbh,0aah,0bch,0e5h,066h,03bh,0bah,03ch	; b702  ff^..EUf....f..<
	defb 0ddh,0e5h,055h,045h,0cbh,0ddh,0bch,0cfh,035h,066h,05ah,0aah,0bch,056h,065h,0bch	; b712  ..UE....5fZ..Ve.
	defb 0bch,0cch,0c3h,0c3h,055h,04fh,055h,04ah,0a9h,0a6h,076h,076h,0a9h,0a9h,0e5h,057h	; b722  ....UOUJ..vv...W
	defb 065h,0bah,0abh,0b5h,054h,03bh,035h,045h,0b3h,06ch,09ah,0d5h,057h,064h,0bah,09ah	; b732  e...T.5E.l..Wd..
	defb 0d6h,066h,05dh,0abh,0deh,004h,05dh,01bh,0d5h,05bh,046h,0fah,0ach,035h,055h,05ch	; b742  .f]...]..[F..5U\
	defb 0bbh,03bh,0e4h,05ch,054h,0bbh,0cfh,052h,0b6h,052h,0bah,0a4h,056h,065h,0bbh,0bch	; b752  ...\T..R.R..Ve..
	defb 0a3h,0c4h,066h,04ch,0cbh,0abh,0ddh,056h,045h,0b0h,053h,0bah,0b1h,0cdh,066h,07bh	; b762  ..fL...VE.S...f{
	defb 0abh,0aah,0b4h,056h,066h,0bbh,0bah,0ach,045h,056h,065h,0cbh,094h,0b4h,04dh,046h	; b772  ...Vf...EVe...MF
	defb 06fh,0bch,0cch,0aah,036h,044h,075h,0dah,09ah,0a6h,066h,075h,0bah,09ah,056h,05dh	; b782  o...6Du...fu..V]
	defb 0b5h,050h,0d3h,0cbh,0d3h,0fbh,0d6h,023h,044h,0abh,0ddh,05ch,056h,05bh,0aah,045h	; b792  .P.....#D..\V[.E
	defb 044h,06bh,0beh,0b3h,055h,02bh,0cdh,0bch,055h,035h,0bbh,0e6h,0ach,0d3h,063h,04ah	; b7a2  Dk..U+..U5....cJ
	defb 0c5h,014h,04ah,03bh,053h,065h,0cbh,0bbh,0b1h,006h,04dh,05bh,03bh,0bch,0d6h,053h	; b7b2  ..J.Se....M[...S
	defb 06ah,0ach,0c4h,066h,04ah,0abh,0d5h,064h,05bh,0abh,0a6h,054h,0e4h,0cdh,034h,0d5h	; b7c2  j..fJ..d[..T..4.
	defb 03ah,0e4h,01bh,034h,055h,034h,0bah,0b5h,004h,044h,0cch,023h,03ch,0beh,053h,0c4h	; b7d2  :..4U4...D.#<.S.
	defb 051h,0bch,035h,04ah,0c3h,045h,021h,0c4h,013h,0aeh,0cch,035h,056h,04ah,0bbh,0cbh	; b7e2  Q.5J.E!....5VJ..
	defb 042h,076h,04bh,09bh,04ch,04bh,06fh,055h,054h,0abh,0aah,015h,066h,06ch,0a4h,0abh	; b7f2  BvK.LKoUT...fl..
	defb 03bh,0b2h,066h,07bh,03ah,0aah,0a2h,063h,066h,062h,0abh,09bh,05ch,045h,056h,063h	; b802  ..f{:..cfb..\EVc
	defb 0b9h,01bh,0aeh,066h,046h,064h,0bah,09ah,0f5h,066h,066h,0bbh,0aah,0bah,044h,076h	; b812  ...fFd...ff...Dv
	defb 0b5h,0cch,0abh,0dch,03ch,056h,064h,03bh,0a9h,062h,05bh,066h,0bch,0cbh,05bh,0cch	; b822  ....<Vd..b[f..[.
	defb 044h,0edh,05eh,06ch,03bh,01bh,0abh,047h,03ch,0d5h,0dch,0b3h,0b2h,0c0h,06bh,014h	; b832  D.^l...G<.....k.
	defb 04ch,0dch,01bh,0bfh,046h,064h,05dh,0a9h,0a4h,066h,065h,0ebh,0ach,052h,0bch,0b3h	; b842  L...Fd]..fe..R..
	defb 046h,0b6h,005h,0a9h,023h,06eh,063h,0e5h,04ah,00ah,0bdh,06dh,056h,0fch,0a5h,0a3h	; b852  F...#nc.J..mV...
	defb 060h,0bbh,0b6h,043h,06bh,0bbh,0b5h,0b4h,055h,0fch,0d5h,0bbh,0b6h,05bh,0eah,065h	; b862  `..Ck...U....[.e
	defb 0cdh,0b5h,0b6h,0bah,05bh,0b6h,046h,06eh,093h,0aah,056h,065h,053h,0bbh,0ach,0cbh	; b872  ....[.Fn..VeS...
	defb 056h,0d5h,05dh,05bh,0aah,0bdh,0c6h,076h,0cbh,03ah,02ah,090h,047h,057h,05dh,0a9h	; b882  V.][...v.:*.GW].
	defb 0bah,024h,063h,074h,05ah,0aah,0bdh,0b5h,047h,025h,03ch,0bdh,0aah,0a5h,066h,057h	; b892  .$ctZ...G%<...fW
	defb 0bch,0aah,0aah,0b6h,076h,06ah,0bah,0abh,0e5h,065h,05bh,05bh,05bh,0cdh,03bh,0a3h	; b8a2  ....vj...e[[[...
	defb 06ch,066h,02ah,0bah,0ceh,006h,056h,0b4h,0dah,0a4h,016h,05ch,05bh,05ah,0b3h,064h	; b8b2  lf*...V....\[Z.d
	defb 0dah,04bh,035h,035h,069h,0cch,034h,0d6h,04ch,04ah,0ceh,053h,0d4h,04eh,0bah,056h	; b8c2  .K55i.4.LJ.S.N.V
	defb 055h,0bah,0ebh,0c6h,06dh,0c5h,091h,045h,0b5h,024h,04ch,0b4h,0dch,03ch,055h,04ch	; b8d2  U...m..E.$L..<UL
	defb 0adh,056h,0fah,040h,0b4h,055h,0cbh,0cch,0d4h,0b5h,064h,0bbh,0b0h,0edh,035h,046h	; b8e2  .V.@.U....d...5F
	defb 0bah,033h,0dbh,045h,0d6h,03ch,0bbh,0b4h,035h,0c4h,032h,0d5h,0bah,02eh,0c7h,0a4h	; b8f2  .3.E.<..5.2.....
	defb 06bh,05ah,0cfh,0aeh,056h,045h,04ah,04dh,0ach,0b6h,0b6h,0f6h,04ch,0b9h,0dch,055h	; b902  kZ..VEJM....L..U
	defb 065h,06ch,0bbh,0bbh,0cch,0ech,066h,060h,0bbh,0abh,0abh,064h,067h,04bh,0aah,0bah	; b912  el....f`...dgK..
	defb 0b4h,066h,066h,059h,0bah,0b2h,0d5h,076h,0cbh,02ch,09dh,0fdh,046h,0e5h,045h,0dah	; b922  .ffY...v.,..F.E.
	defb 04ah,0b2h,0a6h,066h,064h,0bah,09ch,0b6h,057h,043h,0ach,0ach,05bh,055h,0b6h,0e5h	; b932  J..fd...WC..[U..
	defb 09dh,062h,03bh,0cch,0b6h,06ch,055h,0aah,0aeh,066h,046h,0bch,0aah,0c6h,056h,0a5h	; b942  .b...lU..fF...V.
	defb 0adh,03bh,065h,0cfh,0dbh,0c4h,046h,0bbh,0bch,046h,0f5h,0beh,0bdh,04bh,052h,0b6h	; b952  ..e...F..F...KR.
	defb 0c3h,05ah,0dbh,025h,05dh,0b5h,05ch,0abh,065h,02ah,0c2h,055h,045h,0dah,0cah,0d5h	; b962  .Z.%].\.e*.UE...
	defb 055h,02ch,053h,0cch,0dbh,0cbh,065h,05dh,04ah,03bh,06bh,0cch,035h,0c4h,056h,0bah	; b972  U,S...e]J.k.5.V.
	defb 0bbh,0b1h,055h,065h,04bh,0cbh,0a2h,0b5h,065h,0d3h,0bch,0f5h,0a5h,0dch,044h,04eh	; b982  ..UeK...e.....DN
	defb 06bh,0a4h,0a2h,0e5h,06bh,06eh,0d3h,0ach,00ch,0bdh,064h,065h,0bbh,00bh,0a1h,0b5h	; b992  k...kn....de....
	defb 066h,033h,0cah,0cah,0bbh,075h,016h,0c2h,0dah,0cch,00bh,0b6h,066h,0b5h,0cah,0abh	; b9a2  f3...u......f...
	defb 035h,064h,05dh,0cch,0aah,055h,06ch,05bh,0b4h,02fh,045h,0a0h,0dbh,0c7h,0b4h,0b5h	; b9b2  5d]..Ul[./E.....
	defb 0ebh,0bbh,045h,046h,0b3h,0abh,04bh,06ch,0c6h,0cfh,0bbh,064h,04bh,023h,0bah,04ch	; b9c2  ..EF..Kl...dK#.L
	defb 076h,0cah,0cbh,0bdh,024h,064h,03ah,04ah,05ch,06ah,06bh,05bh,0bbh,066h,0ech,00ah	; b9d2  v...$d:J\jk[.f..
	defb 0c3h,044h,05ch,051h,0cah,04ah,052h,06ch,026h,0aah,0b5h,056h,05ch,0bah,02bh,064h	; b9e2  .D\Q.JRl&..V\.+d
	defb 03eh,032h,03ah,05ch,0b5h,0d3h,0deh,053h,05ch,0ach,03ch,06bh,06dh,0d6h,0bah,06ah	; b9f2  >2:\...S\.<km..j
	defb 0b5h,0dbh,0c7h,0b5h,03dh,0a1h,0ach,0e5h,065h,0c6h,0abh,03ah,05bh,064h,0b5h,0e3h	; ba02  ....=...e..:[d..
	defb 04ch,02ah,0b5h,0b4h,056h,045h,0dah,0abh,0b5h,065h,026h,0cah,0cch,0a6h,0b6h,0a5h	; ba12  L*..VE...e&.....
	defb 065h,03ah,0bdh,0b3h,0b7h,0b6h,0cbh,02bh,0bbh,045h,0b7h,0a4h,02bh,0cdh,0b3h,03ch	; ba22  e:.....+.E..+..<
	defb 065h,0dch,0cbh,0bbh,065h,045h,0ddh,0aeh,054h,0bfh,0a6h,05ch,06bh,0cah,04bh,0b6h	; ba32  e...eE..T..\k.K.
	defb 0c6h,056h,0abh,0aah,062h,0f5h,065h,03ah,04ah,00bh,0d3h,045h,044h,0c1h,051h,0abh	; ba42  .V..b.e:J..ED.Q.
	defb 0b3h,0f6h,056h,05ch,0aah,096h,026h,055h,045h,0cbh,0a4h,0abh,0f5h,065h,06bh,0bbh	; ba52  ..V\..&UE....ek.
	defb 0cbh,0b6h,05bh,06bh,05bh,04dh,0b6h,095h,054h,0d5h,04fh,04ah,0b3h,04ch,04bh,055h	; ba62  ..[k[M..T.OJ.LKU
	defb 05bh,05ch,0a5h,0a5h,04bh,063h,024h,0ach,06ah,061h,0cbh,0c5h,0b5h,05bh,04ch,0b4h	; ba72  [\..Kc$.ja...[L.
	defb 0b5h,053h,0cfh,0b2h,05bh,06ch,0cbh,043h,0dah,065h,04eh,0d5h,094h,0bfh,066h,0b5h	; ba82  .S..[l.C.eN...f.
	defb 0eah,04bh,04bh,06ch,04bh,06bh,03ch,04dh,0fch,03bh,0c5h,056h,0bdh,0cch,0fah,045h	; ba92  .KKlKk<M...V...E
	defb 0b5h,045h,0b4h,04bh,0bch,0c4h,054h,035h,0cch,05bh,04bh,0dbh,0d5h,056h,0cch,01ah	; baa2  .E.K..T5.[K..V..
	defb 0a6h,0a4h,056h,06dh,0bah,0b4h,0d1h,02bh,065h,034h,04ah,04ah,0a6h,044h,06ch,00bh	; bab2  ..Vm...+e4JJ.Dl.
	defb 04ch,0a2h,0b5h,06dh,04eh,00fh,0deh,05ah,0d5h,0a6h,0c6h,0dch,033h,0abh,052h,053h	; bac2  L..mN..Z....3.RS
	defb 06ch,0bah,0c3h,0c2h,065h,0a6h,0b6h,0a4h,0b6h,0aah,0b5h,064h,055h,0bbh,0b1h,0aeh	; bad2  l...e......dU...
	defb 066h,055h,0abh,0cbh,0c3h,04ch,056h,04bh,02fh,093h,062h,046h,02ah,04ah,052h,05ch	; bae2  fU...LVK/.bF*JR\
	defb 0cch,053h,0c4h,0fch,03eh,0b4h,04dh,03bh,05dh,05dh,04dh,0c5h,0a3h,0b4h,0d6h,042h	; baf2  .S..>.M.]]M....B
	defb 04ah,04bh,05bh,005h,05ah,0c6h,0a6h,0adh,04ch,035h,0d4h,013h,05ah,06ah,04bh,0b6h	; bb02  JK[.Z...L5..ZjK.
	defb 046h,0a0h,0d6h,0ach,0cah,065h,0c5h,0bch,06bh,0dch,00bh,0b6h,05ch,06eh,00ah,0cbh	; bb12  F....e..k...\n..
	defb 03ch,056h,0c5h,05bh,0bah,0b5h,04dh,035h,05bh,05ah,033h,0c5h,0cdh,046h,0a5h,0dbh	; bb22  <V.[..M5[Z3..F..
	defb 05bh,0c0h,05dh,05ch,05ah,05bh,0cdh,055h,0b4h,03bh,0b5h,036h,01bh,0dbh,0cbh,054h	; bb32  [.]\Z[.U...6...T
	defb 0b6h,030h,01bh,04fh,0cch,05bh,06ah,05dh,0deh,040h,04ah,06bh,0d5h,0b6h,03ch,04bh	; bb42  .0.O.[j].@Jk..<K
	defb 0bbh,00ch,046h,054h,0bfh,0cdh,00bh,059h,056h,055h,05bh,05ah,0ach,0b4h,065h,066h	; bb52  ..FT...YVU[Z..ef
	defb 0ach,0bah,0b1h,05ch,065h,0d5h,0c0h,0bbh,0a3h,042h,064h,0f4h,032h,0abh,0cah,053h	; bb62  ...\e....Bd.2..S
	defb 075h,04bh,0bch,0bch,0b6h,0e2h,045h,0b5h,0c2h,0cah,03bh,05ch,056h,05bh,0beh,0a4h	; bb72  uK....E....\V[..
	defb 0d4h,034h,055h,0bdh,04bh,03bh,043h,0b4h,036h,0bdh,002h,0b0h,0b5h,0d5h,0ddh,02bh	; bb82  .4U.K.C.6......+
	defb 06bh,05ch,0b5h,0cbh,015h,0d2h,063h,0bbh,0c1h,0b3h,0d4h,064h,02bh,0bbh,0c4h,03dh	; bb92  k\....c....d+..=
	defb 042h,0b6h,045h,0dch,0cah,0a4h,056h,0b6h,05ch,0cch,0a1h,04bh,035h,053h,04bh,04bh	; bba2  B.E...V.\..K5SKK
	defb 02ch,0fch,04ch,045h,045h,0b5h,0cbh,0abh,04bh,067h,0feh,0cah,0cah,04eh,054h,035h	; bbb2  ,.LEE...Kg...NT5
	defb 052h,0bch,0abh,045h,025h,035h,05bh,0cdh,049h,043h,056h,0b6h,05bh,0fah,0bbh,0b6h	; bbc2  R..E%5[.ICV.[...
	defb 046h,0b6h,0cbh,0b5h,0cah,0c4h,052h,054h,06ah,05bh,0bah,0b6h,046h,036h,0bah,0bch	; bbd2  F.....RTj[..F6..
	defb 0b3h,0b6h,06bh,06bh,0eah,03ch,0cch,0b6h,055h,054h,0bch,0ach,0cch,066h,024h,0dbh	; bbe2  ..kk.<..UT...f$.
	defb 0a4h,0a6h,0d1h,050h,01ch,05fh,0c4h,0cch,0c2h,05ch,045h,0c4h,0cbh,0beh,06ah,06dh	; bbf2  ...P._...\E...jm
	defb 04ch,0c0h,0b3h,042h,0b4h,0b6h,0b5h,024h,0bbh,044h,0fch,045h,0b4h,0f3h,0d4h,0b5h	; bc02  L..B...$.D.E....
	defb 0bdh,05ch,0bdh,06ah,04bh,045h,04dh,00dh,0b3h,035h,044h,0cdh,0bbh,06ch,0b5h,041h	; bc12  .\.jKEM..5D..l.A
	defb 05bh,0e3h,0a5h,0d4h,0a6h,04ch,05ch,0c3h,0b4h,024h,0a5h,043h,05bh,01dh,01bh,05ch	; bc22  [....L\..$.C[..\
	defb 0d5h,03fh,033h,0b4h,0a4h,04bh,055h,04bh,05bh,0b3h,0c3h,05ch,05ch,01dh,035h,02bh	; bc32  .?3..KUK[..\\.5+
	defb 0c3h,03bh,034h,02dh,045h,0b3h,0cbh,0c2h,045h,04dh,0d5h,0bbh,02bh,06bh,054h,05ah	; bc42  ..4-E...EM..+kTZ
	defb 043h,0cch,025h,01ah,036h,0bch,054h,0cch,0b2h,0ech,0d6h,013h,013h,0cbh,0c5h,04ch	; bc52  C.%.6.T........L
	defb 0d5h,0b3h,0c6h,06ah,0cbh,0dah,055h,045h,0e4h,0cah,0a5h,040h,065h,04ch,0c1h,0a0h	; bc62  ...j..UE...@eL..
	defb 0c5h,04dh,04dh,05bh,053h,0bch,0d0h,0c4h,0d5h,035h,0bch,02ch,03bh,05bh,05eh,043h	; bc72  .MM[S....5.,.[^C
	defb 0d4h,0b4h,0ech,0c4h,0b6h,0d4h,05dh,0adh,02ah,06ch,052h,05bh,05ch,0a3h,034h,0ddh	; bc82  ......].*lR[\.4.
	defb 045h,06ah,05ah,0d2h,0cdh,05ch,055h,02ch,0fch,0a4h,04fh,022h,0f5h,0b4h,06dh,0a2h	; bc92  EjZ..\U,..O"..m.
	defb 0ech,0dch,055h,0d5h,04ch,0bbh,03ah,055h,055h,0d2h,03ah,0fch,0fch,013h,063h,021h	; bca2  ..U.L.:UU.:...c!
	defb 04bh,0bbh,0edh,035h,045h,04ch,03ah,04bh,04ch,045h,015h,0cch,0dbh,0c5h,0beh,045h	; bcb2  K..5EL:KLE.....E
	defb 0c5h,0d5h,0dch,0d0h,0cah,053h,046h,0b4h,01dh,0dbh,0bch,06ch,040h,06bh,0bbh,042h	; bcc2  .....SF....l@k.B
	defb 0b3h,015h,0b5h,055h,0cbh,030h,0abh,055h,045h,0d4h,0cah,05ch,0cfh,055h,0a4h,041h	; bcd2  ...U.0.UE..\.U.A
	defb 03bh,06ch,0bch,0ebh,044h,066h,0cch,0bah,0bbh,056h,044h,044h,0bbh,04bh,0bch,05dh	; bce2  .l..Df...VDD.K.]
	defb 05ch,064h,0cbh,0beh,0bdh,055h,034h,05eh,0cbh,0c2h,0cch,054h,034h,0d3h,0cdh,0bdh	; bcf2  \d...U4^...T4...
	defb 0d5h,0c4h,0b6h,032h,0ddh,0cch,0cbh,06bh,05ch,06ch,0b4h,0a6h,0b4h,0ceh,044h,04eh	; bd02  ...2...k\l....DN
	defb 0ddh,0cbh,02ch,054h,034h,0edh,0eeh,0cch,014h,034h,0c5h,02ah,044h,0c5h,012h,0dbh	; bd12  ..,T4....4.*D...
	defb 0b5h,04fh,004h,0fch,0c3h,00dh,004h,05bh,0c4h,05fh,0c2h,03bh,0d1h,042h,032h,05dh	; bd22  .O.....[._...B2]
	defb 0bch,0ceh,0c4h,051h,033h,0d3h,0a4h,0edh,043h,053h,0c2h,04bh,0c0h,03dh,044h,0d3h	; bd32  ...Q3...CS.K.=D.
	defb 0d2h,03eh,0dch,0cch,05bh,054h,025h,0bch,0c1h,0c1h,05dh,05ch,04eh,0cdh,05bh,0d1h	; bd42  .>..[T%...]\N.[.
	defb 0b5h,035h,0e4h,0bbh,0c1h,023h,053h,00ch,05dh,0bch,021h,03dh,045h,0c3h,0e4h,0bch	; bd52  .5...#S.].!=E...
	defb 0d3h,00ch,045h,033h,0dch,0bbh,054h,03ch,052h,0dch,04fh,0ech,03dh,01ch,05dh,034h	; bd62  ..E3..T<R.O.=.]4
	defb 03fh,0bbh,0e4h,0d4h,054h,02eh,0cch,0b0h,0c5h,0c5h,05bh,04ch,0e1h,0b4h,043h,0cch	; bd72  ?...T.....[L..C.
	defb 034h,052h,0fch,0bch,04bh,054h,05fh,00bh,01bh,0c5h,0d2h,025h,0b5h,03bh,05bh,02dh	; bd82  4R..KT_....%..[-
	defb 0deh,014h,05dh,03ch,02bh,02dh,02eh,034h,023h,02ch,0dch,004h,0b4h,025h,03dh,03dh	; bd92  ..]<+-.4#,...%==
	defb 0ebh,02fh,03fh,033h,024h,0b5h,0bdh,04dh,01ch,04ch,05ch,052h,0cch,03bh,0d2h,005h	; bda2  ./?3$..M.L\R....
	defb 041h,0e3h,0cch,0e0h,04bh,044h,04eh,0c5h,0b5h,0a2h,02ch,054h,01dh,05bh,04bh,02ch	; bdb2  A...KDN...,T.[K,
	defb 04bh,055h,0c4h,0e2h,03bh,0b1h,033h,05ch,034h,0ebh,030h,0b5h,0c1h,032h,0e4h,04dh	; bdc2  KU....3\4.0..2.M
	defb 02eh,0b2h,0b3h,050h,044h,04ah,04ch,0c4h,044h,05ch,0b1h,0d3h,04eh,0ebh,034h,0c3h	; bdd2  ...PDJL.D\..N.4.
	defb 0d5h,014h,0dbh,0cch,0e4h,054h,004h,0eah,044h,0f3h,003h,0c1h,0c5h,00dh,0e0h,02ch	; bde2  .....T..D......,
	defb 0cdh,044h,034h,04ch,0b3h,0b5h,0c4h,04ch,042h,05bh,0c2h,0b5h,0b4h,0d4h,0d4h,03dh	; bdf2  .D4L...LB[.....=
	defb 0ddh,0edh,0feh,051h,043h,0fbh,02dh,0c4h,0d3h,0f4h,021h,03eh,0b3h,0c3h,0c2h,05eh	; be02  ...QC.-...!>...^
	defb 04eh,0dch,04ch,0d3h,0f2h,025h,0c4h,0c4h,0cch,03ch,02eh,014h,05fh,0b4h,0cbh,032h	; be12  N.L..%...<.._..2
	defb 0e5h,0c4h,02ch,0fch,05dh,00ch,02eh,0d5h,0d2h,03fh,02bh,04ch,03ch,05ch,040h,00bh	; be22  ..,.]....?+L<\@.
	defb 05dh,0b5h,0fch,0e4h,0d5h,0c4h,03ch,0b3h,0eeh,032h,044h,0c4h,04bh,0cdh,0c1h,05ch	; be32  ].....<..2D.K..\
	defb 053h,0ceh,03bh,0ddh,014h,05ch,024h,0ddh,04ch,04bh,0edh,03ch,055h,0e4h,0cbh,0fch	; be42  S....\$.LK.<U...
	defb 0c3h,044h,044h,0ddh,0cbh,04ch,04eh,040h,040h,012h,0ech,02ch,0c2h,004h,044h,05ch	; be52  .DD..LN@@..,..D\
	defb 0cbh,0cdh,0d4h,045h,04bh,012h,0bdh,014h,0d2h,033h,03dh,04dh,00ch,0d2h,0dch,035h	; be62  ...EK....3=M...5
	defb 04dh,04ch,0cbh,031h,0d4h,04eh,04ch,05ch,0ceh,0c5h,0b2h,034h,021h,004h,0cch,0d2h	; be72  ML.1.NL\...4!...
	defb 0edh,035h,03dh,0dch,01ch,0d3h,0d4h,04eh,03eh,0f3h,0fch,0edh,0c4h,045h,0efh,0c2h	; be82  .5=....N>....E..
	defb 00bh,023h,023h,03fh,0c4h,0c3h,0d0h,0e0h,0e2h,0e4h,014h,0dch,04bh,04dh,0d4h,034h	; be92  .##?........KM.4
	defb 0d3h,0b3h,0feh,0feh,043h,01fh,0d2h,02bh,042h,0c3h,0d5h,0c3h,0d4h,0ddh,0c5h,0ceh	; bea2  ....C..+B.......
	defb 03dh,05bh,033h,0ech,033h,0c4h,0d1h,021h,0c4h,01ch,032h,0d3h,0cdh,05ch,0d5h,0e1h	; beb2  =[3.3..!..2..\..
	defb 0cfh,0c4h,0ddh,05ch,024h,0e0h,0dch,02eh,0d2h,04eh,024h,0c2h,0ech,03dh,020h,04eh	; bec2  ...\$....N$..= N
	defb 024h,0ceh,0cdh,033h,020h,0f3h,0e4h,00eh,0dch,001h,0c4h,0c5h,034h,0cch,01ch,0dfh	; bed2  $..3 .......4...
	defb 043h,040h,04bh,00dh,001h,031h,0e3h,0c3h,03fh,01ch,04ch,0eeh,0e3h,033h,04fh,0cfh	; bee2  C@K..1..?.L..3O.
	defb 0d0h,0c4h,035h,0b3h,0efh,0edh,041h,00eh,0edh,0feh,034h,01dh,031h,0bfh,04ch,043h	; bef2  ..5...A...4.1.LC
	defb 04eh,0dch,021h,0c3h,042h,02dh,0e2h,0c3h,04dh,02ch,0e0h,030h,031h,011h,0c3h,0c1h	; bf02  N.!.B-..M,.01...
	defb 02eh,014h,002h,0edh,03dh,0fdh,03dh,04dh,014h,0e2h,0c3h,0ceh,021h,00fh,041h,0d3h	; bf12  ....=.=M....!.A.
	defb 02ch,0edh,0d4h,0d4h,023h,0e1h,0ddh,0edh,023h,023h,04ch,01fh,0c3h,0dfh,0e5h,0c0h	; bf22  ,...#...##L.....
	defb 02fh,02fh,01ch,0ech,042h,0f4h,033h,0dfh,0ceh,0eeh,033h,0d4h,031h,01ch,01ch,0e3h	; bf32  //..B.3...3.1...
	defb 003h,0d3h,01fh,03eh,0e1h,0c0h,03dh,033h,033h,0d0h,0fch,0c2h,032h,034h,03eh,0cdh	; bf42  ...>..=33...24>.
	defb 0edh,03dh,040h,0e3h,0e3h,0c4h,00eh,0d1h,0fdh,01dh,05dh,03dh,03ch,0efh,0e3h,014h	; bf52  .=@.......]=<...
	defb 0d2h,0c0h,0d3h,02ch,04eh,0d1h,04fh,032h,0c3h,0fch,0dfh,025h,0e2h,02eh,0cch,0e2h	; bf62  ...,N.O2...%....
	defb 033h,033h,0cfh,012h,0dfh,04dh,0ddh,033h,02eh,04dh,01dh,0dfh,0d2h,024h,03eh,0feh	; bf72  33...M.3.M...$>.
	defb 0ceh,032h,01dh,041h,0ddh,032h,00ch,0f3h,0deh,034h,000h,02eh,0ddh,0e1h,0f1h,042h	; bf82  .2.A.2...4.....B
	defb 02dh,0f0h,0ddh,0e3h,021h,03eh,01fh,0efh,0d2h,0d4h,0c4h,0f2h,02eh,03eh,0ddh,022h	; bf92  -...!>.......>."
	defb 0e3h,0e2h,020h,00fh,0c1h,0d4h,0d1h,04fh,0efh,02dh,0fdh,02fh,034h,0d3h,0ech,03eh	; bfa2  .. ....O.-./4..>
	defb 0e3h,01eh,010h,03dh,021h,0deh,01eh,022h,0e2h,02eh,0e1h,02ch,030h,032h,00fh,00dh	; bfb2  ...=!.."...,02..
	defb 0f3h,0c3h,030h,03eh,0e0h,0edh,013h,01fh,01dh,03eh,0e3h,0eeh,013h,0e0h,02eh,02dh	; bfc2  ..0>.....>.....-
	defb 02dh,04ch,022h,02eh,010h,03dh,0c2h,0f1h,040h,0fdh,02eh,020h,0d0h,030h,001h,0f2h	; bfd2  -L"..=..@.. .0..
	defb 0e1h,0f1h,0d0h,0e0h,04fh,002h,000h,0dch,0f2h,014h,0f2h,03dh,0deh,0edh,031h,03fh	; bfe2  ....O......=..1?
	defb 030h,0e1h,0e0h,02dh,0eeh,0f3h,033h,03eh,0dch,0dfh,013h,040h,023h,0afh	; bff2  0..-..3>...@#.
