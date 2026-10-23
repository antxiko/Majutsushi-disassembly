; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS partida_A000: los 2 ultimos bytes de la instruccion de p02:9FFF (CD 2E
;   9A), que empieza en el banco 2; lo leen p02:9FFF (2 bytes)
;   0xa000..0xa002  (2 bytes)
DATA_partida_A000:
	defb 02eh,09ah	; a000

; ======================================================================
; CODIGO 0xa002..0xa066  (100 bytes)
; ======================================================================


L_A002:
	ret nc			;a002
	ld a,(0c20dh)		;a003   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a006   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a009   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld hl,0c215h		;a00c   ; apunta a el paso de la respuesta
	inc (hl)			;a00f
	inc (hl)			;a010
	ret			;a011
L_A012:
	call 097e6h		;a012   ; pon de la maquina: hace el pon (0x97E6), recoge la mano del que llama y llama a 0x85E0 con C = 0x40
	ld a,(0c20dh)		;a015   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a018   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a01b   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld c,040h		;a01e
	call 085e0h		;a020   ; prueba_mano_con_ficha: prueba la mano del que responde con la ficha de 0xC209 o C
	ld hl,0c215h		;a023   ; apunta a el paso de la respuesta
	inc (hl)			;a026
	ret			;a027
L_A028:
	ld a,(0c207h)		;a028   ; el jugador descarta: cambia la ficha de la mano por la tirada 0xC209 con el bit 6 puesto (es de un grupo) y descarta (8D42)
	add a,a			;a02b
	add a,a			;a02c
	ld hl,0d000h		;a02d
	add a,h			;a030
	ld h,a			;a031
	ld a,(0c20ah)		;a032   ; lee la posicion de la ficha en la mano
	call 0405ch		;a035   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a038
	push af			;a039
	ld a,(0c209h)		;a03a   ; lee la ficha robada o tirada
	set 6,a		;a03d
	ld (hl),a			;a03f
	pop af			;a040
	ld (0c209h),a		;a041   ; guarda la ficha robada o tirada
	call 08d42h		;a044   ; descarta: descarta la ficha 0xC209 del jugador 0xC207
	call 08b3dh		;a047   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call 08cf5h		;a04a   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call 09cc7h		;a04d
L_A050:
	xor a			;a050   ; vuelve del turno: 0xC215 = 0, 0xC213 = 0, marca +0x40 y pasa al paso 3
	ld (0c215h),a		;a051   ; guarda el paso de la respuesta
	ld (0c213h),a		;a054   ; guarda la opcion elegida en el cuadro
	call L_A491		;a057   ; marca +0x40 de la mano del jugador 0xC207 a 1
	ld a,003h		;a05a
	ld (0c208h),a		;a05c   ; guarda el paso del turno
	ret			;a05f
L_A060:
	ld a,(0c215h)		;a060   ; el kan: 0xC215 elige el paso por la tabla de 0xA064
	call 04066h		;a063   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A066: 5 destinos del despachador p00:4066 (call en p03:A063, el
;   indice en A): A070, A078, A095, A0A8, A0C1; lo leen p03:A063 (10 bytes)
;   0xa066..0xa070  (10 bytes)
DATA_tabla_A066:
	defw 0a070h,0a078h,0a095h,0a0a8h,0a0c1h	; a066

; ======================================================================
; CODIGO 0xa070..0xa0f4  (132 bytes)
; ======================================================================


L_A070:
	call 09b3bh		;a070   ; pone 0x08 en 0xCA00 (32 bytes) y cuenta cuantas casillas libres hay en +0x69 (p02:9B3B)
	ld hl,0c215h		;a073   ; apunta a el paso de la respuesta
	inc (hl)			;a076
	ret			;a077
L_A078:
	call 09b5fh		;a078   ; el humano elige la ficha del kan con 0x9B5F y descarta
	ret nc			;a07b
	call L_A1C1		;a07c   ; dibuja el grupo bajado de un kan: coloca las fichas (0x991B, 0x99FE, 0xA1EC)
	ld a,(0c207h)		;a07f   ; lee el jugador al que le toca (0 = el humano)
	push af			;a082
	ld a,(0c20dh)		;a083   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a086   ; guarda el jugador al que le toca (0 = el humano)
	call 093ffh		;a089
	pop af			;a08c
	ld (0c207h),a		;a08d   ; guarda el jugador al que le toca (0 = el humano)
	ld hl,0c215h		;a090   ; apunta a el paso de la respuesta
	inc (hl)			;a093
	ret			;a094
L_A095:
	call 09a2eh		;a095   ; teclas de la eleccion de ficha cuando ya esta en espera (solo se puede tirar la ultima) (p02:9A2E)
	ret nc			;a098
	ld a,(0c20dh)		;a099   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a09c   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a09f   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld hl,0c215h		;a0a2   ; apunta a el paso de la respuesta
	inc (hl)			;a0a5
	inc (hl)			;a0a6
	ret			;a0a7
L_A0A8:
	call 08578h		;a0a8   ; kan de la maquina: 0x8578, luego 0xA1C1 y 0x85E0 con C = 0x80
	call L_A1C1		;a0ab   ; dibuja el grupo bajado de un kan: coloca las fichas (0x991B, 0x99FE, 0xA1EC)
	ld a,(0c20dh)		;a0ae   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a0b1   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a0b4   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld c,080h		;a0b7
	call 085e0h		;a0b9   ; prueba_mano_con_ficha: prueba la mano del que responde con la ficha de 0xC209 o C
	ld hl,0c215h		;a0bc   ; apunta a el paso de la respuesta
	inc (hl)			;a0bf
	ret			;a0c0
L_A0C1:
	ld hl,0d000h		;a0c1   ; el jugador descarta con el bit 7 puesto en la ficha
	ld a,(0c207h)		;a0c4   ; lee el jugador al que le toca (0 = el humano)
	call 099f9h		;a0c7   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(0c20ah)		;a0ca   ; lee la posicion de la ficha en la mano
	call 0405ch		;a0cd   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a0d0
	push af			;a0d1
	ld a,(0c209h)		;a0d2   ; lee la ficha robada o tirada
	set 7,a		;a0d5
	ld (hl),a			;a0d7
	pop af			;a0d8
	ld (0c209h),a		;a0d9   ; guarda la ficha robada o tirada
	call 08d42h		;a0dc   ; descarta: descarta la ficha 0xC209 del jugador 0xC207
	call 08b3dh		;a0df   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call 09af7h		;a0e2
	call 08cf5h		;a0e5   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call 09cc7h		;a0e8
	jp L_A050		;a0eb
L_A0EE:
	ld a,(0c215h)		;a0ee   ; el chi: 0xC215 elige el paso por la tabla de 0xA0F2
	call 04066h		;a0f1   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A0F4: 5 destinos del despachador p00:4066 (call en p03:A0F1, el
;   indice en A): A0FE, A146, A151, A17B, A190; lo leen p03:A0F1 (10 bytes)
;   0xa0f4..0xa0fe  (10 bytes)
DATA_tabla_A0F4:
	defw 0a0feh,0a146h,0a151h,0a17bh,0a190h	; a0f4

; ======================================================================
; CODIGO 0xa0fe..0xa4b2  (948 bytes)
; ======================================================================


L_A0FE:
	call coge_del_muro_atras		;a0fe   ; coge_del_muro_atras: coge la ficha del muro muerto y la pone en 0xC209
	ld a,(0c20dh)		;a101   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a104   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a107   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld a,002h		;a10a
	ld (0c208h),a		;a10c   ; guarda el paso del turno
	xor a			;a10f
	ld (0c215h),a		;a110   ; guarda el paso de la respuesta
	ret			;a113
coge_del_muro_atras:		; coge la ficha del muro muerto y la pone en 0xC209
	call 087e3h		;a114   ; coge la ficha del muro de atras (0x87E3, 0xC210 y 0x87), la pone en 0xC209 y la dibuja
	ld a,(0c210h)		;a117   ; lee las fichas sacadas del final del muro (por kan)
	ld c,a			;a11a
	dec c			;a11b
	ld a,087h		;a11c
	sub c			;a11e
	ld hl,0c100h		;a11f   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;a122   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a125
	ld (0c209h),a		;a126   ; guarda la ficha robada o tirada
	ld a,(0c207h)		;a129   ; lee el jugador al que le toca (0 = el humano)
	push af			;a12c
	ld a,(0c20dh)		;a12d   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a130   ; guarda el jugador al que le toca (0 = el humano)
	call 08c68h		;a133   ; dibuja_ficha_robada: dibuja la ficha 0xC209 en su sitio
	ld a,001h		;a136
	ld (0cd0ch),a		;a138   ; guarda 1 si se gana con la ficha de un kan
	call 093f1h		;a13b   ; pone el cursor de la mano en la ultima ficha (0xC20A = 0xC211 = 0xC200 + 1) (p02:93F1)
	call suma_kan		;a13e   ; suma_kan: suma uno a los kan del jugador 0xC207
	pop af			;a141
	ld (0c207h),a		;a142   ; guarda el jugador al que le toca (0 = el humano)
	ret			;a145
L_A146:
	call 0987eh		;a146   ; kan cerrado: 0x987E y 0xA114
	call coge_del_muro_atras		;a149   ; coge_del_muro_atras: coge la ficha del muro muerto y la pone en 0xC209
	ld hl,0c215h		;a14c   ; apunta a el paso de la respuesta
	inc (hl)			;a14f
	ret			;a150
L_A151:
	ld a,(0c20dh)		;a151   ; el kan cambia la mano: 0x68EF mira si gana; si es asi 0xC0B1 = 1 y suena el ron (0x4184)
	ld (0c207h),a		;a154   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a157   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	call 068efh		;a15a   ; prueba_ganar_robo: prueba si la mano gana por robo (B = 1)
	jr nc,L_A170		;a15d
	ld a,001h		;a15f
	ld (0c0b1h),a		;a161   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ld b,004h		;a164
	ld a,(0c20dh)		;a166   ; lee el jugador que responde a la ficha tirada
	call muestra_voz		;a169   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call 04184h		;a16c   ; voz_tsumo: dice TSUMO: la voz 0x16 con el tono del personaje de 0xC207
	ret			;a16f
L_A170:
	ld c,0c0h		;a170
	call 085e0h		;a172   ; prueba_mano_con_ficha: prueba la mano del que responde con la ficha de 0xC209 o C
	ld hl,0c215h		;a175   ; apunta a el paso de la respuesta
	inc (hl)			;a178
	inc (hl)			;a179
	ret			;a17a
L_A17B:
	call 09a2eh		;a17b   ; teclas de la eleccion de ficha cuando ya esta en espera (solo se puede tirar la ultima) (p02:9A2E)
	ret nc			;a17e
	ld a,(0c20dh)		;a17f   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a182   ; guarda el jugador al que le toca (0 = el humano)
	call 05e4dh		;a185   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	call 08c8eh		;a188   ; cambia de sitio la ficha 0xC209 con una de la mano (jugador de 0xC20D) (p02:8C8E)
	ld hl,0c215h		;a18b   ; apunta a el paso de la respuesta
	inc (hl)			;a18e
	ret			;a18f
L_A190:
	call 08d42h		;a190   ; descarta la ficha, ordena la mano y la dibuja, y comprueba si se acaba el muro (0xA1A2)
	call 08b3dh		;a193   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call 08cf5h		;a196   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call 09cc7h		;a199
	call L_A1A2		;a19c   ; si el muro de atras ha llegado a 4 fichas (0xC210), mira si hay cuatro kan (0xA771): si es asi 0xC0B1 = 1; si no, 0xC0B8 = 2
	jp L_A050		;a19f
L_A1A2:
	ld a,(0c210h)		;a1a2   ; si el muro de atras ha llegado a 4 fichas (0xC210), mira si hay cuatro kan (0xA771): si es asi 0xC0B1 = 1; si no, 0xC0B8 = 2
	cp 004h		;a1a5
	ret nz			;a1a7
	call L_A771		;a1a8   ; mira si algun jugador (D000 + 4 x n) tiene +0x46 igual a 4 (cuatro kan): acarreo
	jp nc,L_A1B7		;a1ab
	ld a,001h		;a1ae
	ld (0c0b1h),a		;a1b0   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ld (0cd9dh),a		;a1b3
	ret			;a1b6
L_A1B7:
	ld a,002h		;a1b7
	ld (0c0b8h),a		;a1b9   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	dec a			;a1bc
	ld (0c0e5h),a		;a1bd   ; guarda 1 si se anula por cuatro kan
	ret			;a1c0
L_A1C1:
	call 0991bh		;a1c1   ; dibuja el grupo bajado de un kan: coloca las fichas (0x991B, 0x99FE, 0xA1EC)
	call 099feh		;a1c4   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	call L_A1EC		;a1c7   ; pone las fichas del grupo de kan de cuatro fichas: las dos primeras de lado y las otras dos
	call 0998fh		;a1ca   ; dibuja la ficha de la mano del jugador siguiente, de lado, en el sitio del grupo (tabla 0x99CE) (p02:998F)
	ld hl,0d00eh		;a1cd
	call 099f6h		;a1d0   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	inc (hl)			;a1d3
	ld a,(0c207h)		;a1d4   ; lee el jugador al que le toca (0 = el humano)
	push af			;a1d7
	ld a,(0c20dh)		;a1d8   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a1db   ; guarda el jugador al que le toca (0 = el humano)
	call 08b3dh		;a1de   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call 09af7h		;a1e1
	call 08cf5h		;a1e4   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop af			;a1e7
	ld (0c207h),a		;a1e8   ; guarda el jugador al que le toca (0 = el humano)
	ret			;a1eb
L_A1EC:
	ld a,(0c213h)		;a1ec   ; pone las fichas del grupo de kan de cuatro fichas: las dos primeras de lado y las otras dos
	ld d,a			;a1ef
	call 087fah		;a1f0
	ld a,(0c207h)		;a1f3   ; lee el jugador al que le toca (0 = el humano)
	push af			;a1f6
	ld a,(0c20dh)		;a1f7   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;a1fa   ; guarda el jugador al que le toca (0 = el humano)
	call 08c7ch		;a1fd   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld hl,0d032h		;a200
	call 099f6h		;a203   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;a206
	ld (0c203h),a		;a207   ; guarda la X donde se dibuja la ficha
	inc hl			;a20a
	ld a,(hl)			;a20b
	ld (0c204h),a		;a20c   ; guarda la Y donde se dibuja la ficha
	call L_A27C		;a20f   ; HL = +0x67 de la mano del jugador 0xC20D
	ld a,(0c213h)		;a212   ; lee la opcion elegida en el cuadro
	call 04d07h		;a215   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;a218
	ld a,l			;a219
	push af			;a21a
	ld hl,0d000h		;a21b
	call 099f6h		;a21e   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a221
	call 0405ch		;a222   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a225
	call 08b8ch		;a226   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call 099feh		;a229   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	ld hl,0d032h		;a22c
	call 099f6h		;a22f   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;a232
	ld (0c203h),a		;a233   ; guarda la X donde se dibuja la ficha
	inc hl			;a236
	ld a,(hl)			;a237
	ld (0c204h),a		;a238   ; guarda la Y donde se dibuja la ficha
	pop hl			;a23b
	ld a,h			;a23c
	push af			;a23d
	ld hl,0d000h		;a23e
	call 099f6h		;a241   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a244
	call 0405ch		;a245   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a248
	call 08b8ch		;a249   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop af			;a24c
	ld (0c207h),a		;a24d   ; guarda el jugador al que le toca (0 = el humano)
	call L_A27C		;a250   ; HL = +0x67 de la mano del jugador 0xC20D
	ld a,(0c213h)		;a253   ; lee la opcion elegida en el cuadro
	call 04d07h		;a256   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;a259
	ld a,l			;a25a
	push af			;a25b
	ld hl,0d000h		;a25c
	call 099f6h		;a25f   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a262
	call 0405ch		;a263   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a266
	set 7,a		;a267
	ld (hl),a			;a269
	pop hl			;a26a
	ld a,h			;a26b
	push af			;a26c
	ld hl,0d000h		;a26d
	call 099f6h		;a270   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a273
	call 0405ch		;a274   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a277
	set 7,a		;a278
	ld (hl),a			;a27a
	ret			;a27b
L_A27C:
	ld a,(0c20dh)		;a27c   ; HL = +0x67 de la mano del jugador 0xC20D
	ld hl,0d000h		;a27f
	call 099f9h		;a282   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld de,00067h		;a285
	add hl,de			;a288
	ret			;a289
baja_grupo:		; dibuja el grupo que baja el jugador (chi, pon o kan)
	ld a,(0c207h)		;a28a   ; DIBUJA EL GRUPO QUE BAJA el jugador (chi, pon o kan): C0x21A + 0xC213 es la opcion; con el bit 6 es un grupo de +0x37
	ld (0c20dh),a		;a28d   ; guarda el jugador que responde a la ficha tirada
	call 08c7ch		;a290   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld hl,0c21ah		;a293   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c213h)		;a296   ; lee la opcion elegida en el cuadro
	call 0405ch		;a299   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a29c
	and 040h		;a29d
	jp nz,L_A3A5		;a29f
	call 0991bh		;a2a2   ; calcula en +0x32 de la mano el sitio donde cae el grupo bajado: +0x0E (grupos hechos) y tablas 0x993D por jugador (p02:991B)
	dec hl			;a2a5
	ld a,(hl)			;a2a6
	ld (0c203h),a		;a2a7   ; guarda la X donde se dibuja la ficha
	inc hl			;a2aa
	ld a,(hl)			;a2ab
	ld (0c204h),a		;a2ac   ; guarda la Y donde se dibuja la ficha
	ld a,038h		;a2af
	call 08b8ch		;a2b1   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call 099feh		;a2b4   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	call 099feh		;a2b7   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	dec hl			;a2ba
	ld a,(hl)			;a2bb
	ld (0c203h),a		;a2bc   ; guarda la X donde se dibuja la ficha
	inc hl			;a2bf
	ld a,(hl)			;a2c0
	ld (0c204h),a		;a2c1   ; guarda la Y donde se dibuja la ficha
	ld a,038h		;a2c4
	call 08b8ch		;a2c6   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call 0991bh		;a2c9   ; calcula en +0x32 de la mano el sitio donde cae el grupo bajado: +0x0E (grupos hechos) y tablas 0x993D por jugador (p02:991B)
	ld a,(0c207h)		;a2cc   ; lee el jugador al que le toca (0 = el humano)
	add a,a			;a2cf
	ld hl,0a4b2h		;a2d0
	call 0405ch		;a2d3   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a2d6
	ld d,a			;a2d7
	inc hl			;a2d8
	ld a,(hl)			;a2d9
	ld e,a			;a2da
	ld hl,0d032h		;a2db
	call 099f6h		;a2de   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;a2e1
	add a,d			;a2e2
	ld (0c203h),a		;a2e3   ; guarda la X donde se dibuja la ficha
	ld (hl),a			;a2e6
	inc hl			;a2e7
	ld a,(hl)			;a2e8
	add a,e			;a2e9
	ld (0c204h),a		;a2ea   ; guarda la Y donde se dibuja la ficha
	ld (hl),a			;a2ed
	ld hl,0c21ah		;a2ee   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c213h)		;a2f1   ; lee la opcion elegida en el cuadro
	call 0405ch		;a2f4   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a2f7
	cp 080h		;a2f8
	jr nc,L_A356		;a2fa
	ld a,(hl)			;a2fc
	push af			;a2fd
	call 05e54h		;a2fe   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	pop af			;a301
	call 0405ch		;a302   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a305
	push af			;a306
	call 087e7h		;a307
	pop af			;a30a
	push af			;a30b
	call 08b8ch		;a30c   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call 099feh		;a30f   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	dec hl			;a312
	ld a,(hl)			;a313
	ld (0c203h),a		;a314   ; guarda la X donde se dibuja la ficha
	inc hl			;a317
	ld a,(hl)			;a318
	ld (0c204h),a		;a319   ; guarda la Y donde se dibuja la ficha
	pop af			;a31c
	call 08b8ch		;a31d   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ld hl,0c21ah		;a320   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c213h)		;a323   ; lee la opcion elegida en el cuadro
	call 0405ch		;a326   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a329
	push af			;a32a
	ld hl,0d000h		;a32b
	call 099f6h		;a32e   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a331
	call 0405ch		;a332   ; suma_a_hl: HL = HL + A
	set 6,(hl)		;a335
	set 7,(hl)		;a337
	inc hl			;a339
	set 6,(hl)		;a33a
	set 7,(hl)		;a33c
	inc hl			;a33e
	set 6,(hl)		;a33f
	set 7,(hl)		;a341
	inc hl			;a343
	ld a,(0c209h)		;a344   ; lee la ficha robada o tirada
	ld (hl),a			;a347
	dec hl			;a348
	ld a,(hl)			;a349
	call L_A49F		;a34a   ; anade la ficha A (sin los bits 6-7) a la lista de +0x41 (cuenta en +0x40)
	ld hl,(0c0deh)		;a34d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;a350
	add hl,de			;a353
	inc (hl)			;a354
	ret			;a355
L_A356:
	ld a,(0c209h)		;a356   ; el grupo es de cuatro iguales con la ultima ficha tirada
	push af			;a359
	call 08b8ch		;a35a   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call 099feh		;a35d   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9) (p02:99FE)
	dec hl			;a360
	ld a,(hl)			;a361
	ld (0c203h),a		;a362   ; guarda la X donde se dibuja la ficha
	inc hl			;a365
	ld a,(hl)			;a366
	ld (0c204h),a		;a367   ; guarda la Y donde se dibuja la ficha
	pop af			;a36a
	push af			;a36b
	call 087e7h		;a36c
	pop af			;a36f
	call 08b8ch		;a370   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ld hl,0c21ah		;a373   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c213h)		;a376   ; lee la opcion elegida en el cuadro
	call 0405ch		;a379   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a37c
	and 03fh		;a37d
	push af			;a37f
	ld hl,0d000h		;a380
	call 099f6h		;a383   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	pop af			;a386
	call 0405ch		;a387   ; suma_a_hl: HL = HL + A
	set 6,(hl)		;a38a
	set 7,(hl)		;a38c
	inc hl			;a38e
	set 6,(hl)		;a38f
	set 7,(hl)		;a391
	inc hl			;a393
	set 6,(hl)		;a394
	set 7,(hl)		;a396
	ld a,(hl)			;a398
	call L_A49F		;a399   ; anade la ficha A (sin los bits 6-7) a la lista de +0x41 (cuenta en +0x40)
	ld hl,(0c0deh)		;a39c   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;a39f
	add hl,de			;a3a2
	inc (hl)			;a3a3
	ret			;a3a4
L_A3A5:
	ld a,(hl)			;a3a5   ; con el bit 6 puesto: el grupo es uno ya bajado al que se anade la cuarta (kan anadido)
	and 080h		;a3a6
	jp nz,L_A43B		;a3a8
	ld a,(hl)			;a3ab
	and 003h		;a3ac
	push af			;a3ae
	add a,a			;a3af
	push af			;a3b0
	ld hl,(0c0deh)		;a3b1   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00037h		;a3b4
	add hl,de			;a3b7
	pop af			;a3b8
	call 0405ch		;a3b9   ; suma_a_hl: HL = HL + A
	push hl			;a3bc
	inc hl			;a3bd
	ld a,(hl)			;a3be
	push af			;a3bf
	and 003h		;a3c0
	call 09922h		;a3c2
	ld b,003h		;a3c5
L_A3C7:
	push bc			;a3c7
	call 09965h		;a3c8   ; dibuja en el sitio de +0x32 la ficha 0xC209 boca arriba y corre el sitio al siguiente (0x99FE) (p02:9965)
	pop bc			;a3cb
	djnz L_A3C7		;a3cc
	pop af			;a3ce
	push af			;a3cf
	and 003h		;a3d0
	call 09922h		;a3d2
	pop af			;a3d5
	ld b,a			;a3d6
	ld a,(0c207h)		;a3d7   ; lee el jugador al que le toca (0 = el humano)
	push af			;a3da
	ld a,b			;a3db
	and 030h		;a3dc
	rrca			;a3de
	rrca			;a3df
	rrca			;a3e0
	rrca			;a3e1
	ld (0c207h),a		;a3e2   ; guarda el jugador al que le toca (0 = el humano)
	call 09992h		;a3e5
	pop af			;a3e8
	ld (0c207h),a		;a3e9   ; guarda el jugador al que le toca (0 = el humano)
	call 087e3h		;a3ec
	ld a,(0c209h)		;a3ef   ; lee la ficha robada o tirada
	set 6,a		;a3f2
	ld b,a			;a3f4
	call 05e54h		;a3f5   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
L_A3F8:
	ld a,(hl)			;a3f8
	cp b			;a3f9
	jr z,L_A400		;a3fa
	inc hl			;a3fc
	jp L_A3F8		;a3fd
L_A400:
	set 6,a		;a400   ; las tres fichas del grupo bajado con los bits 6 y 7 (grupo hecho)
	set 7,a		;a402
	ld (hl),a			;a404
	inc hl			;a405
	ld a,(hl)			;a406
	set 6,a		;a407
	set 7,a		;a409
	ld (hl),a			;a40b
	inc hl			;a40c
	ld a,(hl)			;a40d
	set 6,a		;a40e
	set 7,a		;a410
	ld (hl),a			;a412
	pop hl			;a413   ; quita un grupo de la lista de +0x37 (cuenta en +0x3F) y corre los siguientes
	pop af			;a414
	push hl			;a415
	ld b,a			;a416
	ld hl,(0c0deh)		;a417   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0003fh		;a41a
	add hl,de			;a41d
	dec (hl)			;a41e   ; baja la cuenta de grupos de la mano
	pop hl			;a41f
	ld a,003h		;a420
	sub b			;a422
	jr z,L_A431		;a423
	add a,a			;a425   ; desplaza los grupos que siguen hacia delante
	ld c,a			;a426
	xor a			;a427
	ld b,a			;a428
	ld d,h			;a429
	ld e,l			;a42a
	inc hl			;a42b
	inc hl			;a42c
	ldir		;a42d
	dec hl			;a42f
	dec hl			;a430
L_A431:
	xor a			;a431
	ld (hl),a			;a432
	inc hl			;a433
	ld (hl),a			;a434
	ld a,001h		;a435
	ld (0cd0dh),a		;a437   ; guarda 1 si se gana con la ficha del kan de otro
	ret			;a43a
L_A43B:
	push hl			;a43b   ; anade la ficha a un grupo que ya estaba
	call 087e3h		;a43c
	pop hl			;a43f
	ld a,(hl)			;a440
	and 00fh		;a441
	ld hl,(0c0deh)		;a443   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	call 0405ch		;a446   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a449
	ld b,a			;a44a
	ld a,(0c209h)		;a44b   ; lee la ficha robada o tirada
	ld (hl),a			;a44e
	ld a,b			;a44f
	ld (0c209h),a		;a450   ; guarda la ficha robada o tirada
	push bc			;a453
	xor a			;a454
	ld (0c200h),a		;a455   ; guarda contador de trabajo de las fichas de la mano
	ld a,0ffh		;a458
	ld (0c21ah),a		;a45a   ; guarda las opciones de chi y kan (3 bytes)
	ld (0c21bh),a		;a45d
	ld (0c21ch),a		;a460
	pop bc			;a463
	call 09deah		;a464   ; si en la lista de grupos de +0x37 hay un grupo de esa ficha (pon), lo anota en 0xC21A con el bit 6 (p02:9DEA)
	ld hl,0c21ah		;a467   ; apunta a las opciones de chi y kan (3 bytes)
	call L_A3A5		;a46a   ; con el bit 6 puesto: el grupo es uno ya bajado al que se anade la cuarta (kan anadido)
	ret			;a46d
declara_riichi:		; la maquina declara riichi: +0x34 = 0xFF y apuesta 1000
	ld hl,(0c0deh)		;a46e   ; la maquina ha elegido (esperar): pone +0x34 = 0xFF, suma 0x10 al marcador y suena
	ld de,00034h		;a471
	add hl,de			;a474
	ld a,0ffh		;a475
	ld (hl),a			;a477
	ld c,001h		;a478
	ld de,00010h		;a47a
	call 04a17h		;a47d   ; suma_puntos_actual: suma al marcador del jugador 0xC207 el importe C (signo) y DE (BCD)
	call 089e7h		;a480   ; suma 1 a 0xC0B4 en BCD (tope 99) y avisa por 0xA6A7 (p02:89E7)
	ld a,(0c207h)		;a483   ; lee el jugador al que le toca (0 = el humano)
	and a			;a486
	jr z,L_A48E		;a487
	ld b,005h		;a489
	call muestra_voz		;a48b   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
L_A48E:
	jp 04179h		;a48e   ; voz_riichi: dice RIICHI: la voz 0x15 con el tono del personaje de 0xC207
L_A491:
	ld hl,0d000h		;a491   ; marca +0x40 de la mano del jugador 0xC207 a 1
	call 099f6h		;a494   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld de,00040h		;a497
	add hl,de			;a49a
	ld a,001h		;a49b
	ld (hl),a			;a49d
	ret			;a49e
L_A49F:
	and 03fh		;a49f   ; anade la ficha A (sin los bits 6-7) a la lista de +0x41 (cuenta en +0x40)
	push af			;a4a1
	ld hl,(0c0deh)		;a4a2   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00041h		;a4a5
	add hl,de			;a4a8
	ld a,(hl)			;a4a9
	inc (hl)			;a4aa
	inc hl			;a4ab
	call 0405ch		;a4ac   ; suma_a_hl: HL = HL + A
	pop af			;a4af
	ld (hl),a			;a4b0
	ret			;a4b1

; ----------------------------------------------------------------------
; DATOS resto_A4B2: lo apuntan con el banco puesto p03:A2D0 (0xA4B2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A2D0 (8 bytes)
;   0xa4b2..0xa4ba  (8 bytes)
DATA_resto_A4B2:
	defb 006h,000h,000h,0fah,0fah,000h,000h,006h	; a4b2  ........

; ======================================================================
; CODIGO 0xa4ba..0xa5e6  (300 bytes)
; ======================================================================


L_A4BA:
	ld hl,0c242h		;a4ba   ; parpadeo del cuadro de la ficha: cada 0x20 cuadros alterna entre 0xA509 y 0xA4D0
	inc (hl)			;a4bd
	ld a,(hl)			;a4be
	and 01fh		;a4bf
	ret nz			;a4c1
	ld a,(0c243h)		;a4c2
	and a			;a4c5
	jp nz,L_A4CD		;a4c6
	call ficha_en_blanco		;a4c9   ; ficha_en_blanco: rellena el cuadro de la ficha con el color 0
	ret			;a4cc
L_A4CD:
	jp pone_ficha_normal		;a4cd   ; pone_ficha_normal: pone la ficha de la mano en su sitio normal
pone_ficha_normal:		; pone la ficha de la mano en su sitio normal
	call L_A561		;a4d0   ; pone el cuadro con la ficha de siempre
	xor a			;a4d3
	ld (0c243h),a		;a4d4
	ld a,(0c244h)		;a4d7
	ld (0c203h),a		;a4da   ; guarda la X donde se dibuja la ficha
	ld a,(0c245h)		;a4dd
	ld (0c204h),a		;a4e0   ; guarda la Y donde se dibuja la ficha
	ld a,(0c207h)		;a4e3   ; lee el jugador al que le toca (0 = el humano)
	push af			;a4e6
	ld hl,(0c0deh)		;a4e7   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00071h		;a4ea
	add hl,de			;a4ed
	ld a,(hl)			;a4ee
	ld hl,0c1c1h		;a4ef   ; apunta a cuantas fichas se han robado del muro
	cp (hl)			;a4f2
	jr nz,L_A4FE		;a4f3
	ld a,(0c207h)		;a4f5   ; lee el jugador al que le toca (0 = el humano)
	inc a			;a4f8
	and 003h		;a4f9
	ld (0c207h),a		;a4fb   ; guarda el jugador al que le toca (0 = el humano)
L_A4FE:
	ld a,(0c209h)		;a4fe   ; lee la ficha robada o tirada
	call 08b8ch		;a501   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop af			;a504
	ld (0c207h),a		;a505   ; guarda el jugador al que le toca (0 = el humano)
	ret			;a508
ficha_en_blanco:		; rellena el cuadro de la ficha con el color 0
	call L_A561		;a509   ; rellena el cuadro de la ficha con el color 0 (la ficha parpadea)
	ld a,001h		;a50c
	ld (0c243h),a		;a50e
	ld a,(0c205h)		;a511   ; lee el ancho de la ficha
	ld b,a			;a514
	ld a,(0c206h)		;a515   ; lee el alto de la ficha
	ld c,a			;a518
	ld a,(0c244h)		;a519
	ld h,a			;a51c
	ld a,(0c245h)		;a51d
	ld l,a			;a520
	ld d,000h		;a521
	ld a,000h		;a523
	jp 04fe5h		;a525   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
ficha_en_su_sitio:		; dibuja la ficha en su sitio
	call L_A561		;a528   ; pone la ficha en su sitio con 0x8BC3
	xor a			;a52b
	ld (0c243h),a		;a52c
	ld a,(0c244h)		;a52f
	ld (0c203h),a		;a532   ; guarda la X donde se dibuja la ficha
	ld a,(0c245h)		;a535
	ld (0c204h),a		;a538   ; guarda la Y donde se dibuja la ficha
	ld a,(0c207h)		;a53b   ; lee el jugador al que le toca (0 = el humano)
	push af			;a53e
	ld hl,(0c0deh)		;a53f   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00071h		;a542
	add hl,de			;a545
	ld a,(hl)			;a546
	ld hl,0c1c1h		;a547   ; apunta a cuantas fichas se han robado del muro
	cp (hl)			;a54a
	jr nz,L_A556		;a54b
	ld a,(0c207h)		;a54d   ; lee el jugador al que le toca (0 = el humano)
	inc a			;a550
	and 003h		;a551
	ld (0c207h),a		;a553   ; guarda el jugador al que le toca (0 = el humano)
L_A556:
	ld a,(0c209h)		;a556   ; lee la ficha robada o tirada
	call 08bc3h		;a559   ; dibuja_ficha_clara: dibuja la ficha A con los colores cambiados
	pop af			;a55c
	ld (0c207h),a		;a55d   ; guarda el jugador al que le toca (0 = el humano)
	ret			;a560
L_A561:
	ld hl,(0c0deh)		;a561   ; si la ficha de +0x71 es la de 0xC1C1, mueve el sitio de dibujo a la mano de al lado
	ld de,00071h		;a564
	add hl,de			;a567
	ld a,(hl)			;a568
	ld hl,0c1c1h		;a569   ; apunta a cuantas fichas se han robado del muro
	cp (hl)			;a56c
	ret nz			;a56d
	ld a,(0c207h)		;a56e   ; lee el jugador al que le toca (0 = el humano)
	push af			;a571
	inc a			;a572
	and 003h		;a573
	ld (0c207h),a		;a575   ; guarda el jugador al que le toca (0 = el humano)
	call 08c7ch		;a578   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	pop af			;a57b
	ld (0c207h),a		;a57c   ; guarda el jugador al que le toca (0 = el humano)
	ret			;a57f
muestra_puntuacion:		; muestra los yaku y los puntos de la mano ganadora
	xor a			;a580   ; MUESTRA LA PUNTUACION: cuenta cuantos han salido en 0xC2E0 (0xA594) y dibuja las ventanas
	ld (0c248h),a		;a581   ; guarda cuantos yaku hay en la lista
	ld (0c232h),a		;a584   ; guarda la linea de la lista de yaku que se escribe
	call L_A637		;a587   ; copia el rectangulo de la pantalla (0,0x14) a la pagina 1
	call L_A594		;a58a   ; cuenta cuantos yaku hay en la lista de 0xC2E0 (pares de dos bytes, 32 como mucho) en 0xC248
	call L_A5A8		;a58d   ; dibuja el rectangulo de la lista (alto segun cuantos, tablas 0xA5E6 y 0xA5EE)
	call L_A5F6		;a590   ; dibuja la ventana de los yaku con 0x9D1C
	ret			;a593
L_A594:
	ld b,020h		;a594   ; cuenta cuantos yaku hay en la lista de 0xC2E0 (pares de dos bytes, 32 como mucho) en 0xC248
	ld hl,0c2e0h		;a596   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
L_A599:
	ld a,(hl)			;a599
	and a			;a59a
	jr z,L_A5A7		;a59b
	push hl			;a59d
	ld hl,0c248h		;a59e   ; apunta a cuantos yaku hay en la lista
	inc (hl)			;a5a1
	pop hl			;a5a2
	inc hl			;a5a3
	inc hl			;a5a4
	djnz L_A599		;a5a5
L_A5A7:
	ret			;a5a7
L_A5A8:
	ld a,(0c2e0h)		;a5a8   ; dibuja el rectangulo de la lista (alto segun cuantos, tablas 0xA5E6 y 0xA5EE)
	cp 035h		;a5ab
	jr z,L_A5D5		;a5ad
	ld a,(0c248h)		;a5af   ; lee cuantos yaku hay en la lista
	dec a			;a5b2
	ld hl,0a5e6h		;a5b3
	call 0405ch		;a5b6   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a5b9
	ld l,a			;a5ba
	push hl			;a5bb
	ld a,(0c248h)		;a5bc   ; lee cuantos yaku hay en la lista
	dec a			;a5bf
	ld hl,0a5eeh		;a5c0
	call 0405ch		;a5c3   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a5c6
	ld c,a			;a5c7
	pop hl			;a5c8
	ld h,02ch		;a5c9
	ld b,0a8h		;a5cb
	ld a,0ffh		;a5cd
	ld d,000h		;a5cf
	call 04fe5h		;a5d1   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;a5d4
L_A5D5:
	call 0418fh		;a5d5   ; con el yaku 0x35 pide el sonido 0x17 (0x418F) y rellena su rectangulo
	ld hl,02c54h		;a5d8
	ld bc,0a828h		;a5db
	ld a,0ffh		;a5de
	ld d,000h		;a5e0
	call 04fe5h		;a5e2   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;a5e5

; ----------------------------------------------------------------------
; DATOS resto_A5E6: lo apuntan con el banco puesto p03:A5B3 (0xA5E6), p03:A5C0
;   (0xA5EE); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:A5B3, p03:A5C0 (16 bytes)
;   0xa5e6..0xa5f6  (16 bytes)
DATA_resto_A5E6:
	defb 050h,048h,040h,038h,030h,028h,020h,018h,030h,040h,050h,060h,070h,080h,090h,0a0h	; a5e6  PH@80( .0@P`p...

; ======================================================================
; CODIGO 0xa5f6..0xa627  (49 bytes)
; ======================================================================


L_A5F6:
	ld a,(0c2e0h)		;a5f6   ; dibuja la ventana de los yaku con 0x9D1C
	cp 035h		;a5f9
	jr z,L_A61D		;a5fb
	ld a,(0c248h)		;a5fd   ; lee cuantos yaku hay en la lista
	dec a			;a600
	ld hl,0a627h		;a601
	call 0405ch		;a604   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a607
	ld e,a			;a608
	ld a,(0c248h)		;a609   ; lee cuantos yaku hay en la lista
	dec a			;a60c
	ld hl,0a62fh		;a60d
	call 0405ch		;a610   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a613
	ld l,a			;a614
	ld d,028h		;a615
	ld h,016h		;a617
	call 09d1ch		;a619   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ret			;a61c
L_A61D:
	ld hl,01606h		;a61d
	ld de,02850h		;a620
	call 09d1ch		;a623   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ret			;a626

; ----------------------------------------------------------------------
; DATOS resto_A627: lo apuntan con el banco puesto p03:A601 (0xA627), p03:A60D
;   (0xA62F); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:A601, p03:A60D (16 bytes)
;   0xa627..0xa637  (16 bytes)
DATA_resto_A627:
	defb 04ch,044h,03ch,034h,02dh,024h,01ch,014h,007h,009h,00bh,00dh,00fh,011h,013h,015h	; a627  LD<4-$..........

; ======================================================================
; CODIGO 0xa637..0xa699  (98 bytes)
; ======================================================================


L_A637:
	ld hl,00014h		;a637   ; copia el rectangulo de la pantalla (0,0x14) a la pagina 1
	ld de,00000h		;a63a
	ld bc,000a8h		;a63d
	ld a,002h		;a640
	call 05024h		;a642   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ret			;a645
L_A646:
	ld hl,00000h		;a646   ; y lo devuelve
	ld de,00014h		;a649
	ld bc,000a8h		;a64c
	ld a,001h		;a64f
	call 05024h		;a651   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ret			;a654
dibuja_mesa_ronda:		; dibuja los datos de la ronda
	ld hl,0a699h		;a655   ; dibuja la mesa de la ronda: textos 0xA699, la esquina (0x584C), los numeros y los vientos de 0xC0B2, 0xC0B3, 0xC0B7
	call 05363h		;a658   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	call 0584ch		;a65b   ; pinta los cuatro tiles de una esquina del marco (p00:584C)
	call escribe_riichi_honba		;a65e   ; escribe_riichi_honba: escribe los numeros de 0xC0B4 y 0xC0B5
	ld a,(0c0b2h)		;a661   ; lee el viento de la ronda (0 este)
	add a,015h		;a664
	ld de,05078h		;a666
	call 05b23h		;a669
	ld a,(0c0b3h)		;a66c   ; lee el numero de la mano dentro del viento (0-3)
	add a,00bh		;a66f
	ld de,06078h		;a671
	call 05b23h		;a674
	ld a,02fh		;a677
	ld de,07078h		;a679
	call 05b23h		;a67c
	ld a,(0c0b7h)		;a67f   ; lee el jugador que reparte (0-3)
	sub 004h		;a682
	neg		;a684
	and 003h		;a686
	add a,015h		;a688
	ld de,09078h		;a68a
	call 05b23h		;a68d
	ld a,01bh		;a690
	ld de,0a078h		;a692
	call 05b23h		;a695
	ret			;a698

; ----------------------------------------------------------------------
; DATOS tiles_A699: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p03:A658 (14 bytes)
;   0xa699..0xa6a7  (14 bytes)
DATA_tiles_A699:
	defb 058h,054h,02eh,000h,000h,083h,000h,000h,02eh,000h,000h,083h,084h,0ffh	; a699  XT............

; ======================================================================
; CODIGO 0xa6a7..0xa735  (142 bytes)
; ======================================================================


escribe_riichi_honba:		; escribe los numeros de 0xC0B4 y 0xC0B5
	ld hl,0c0b4h		;a6a7   ; escribe los dos numeros de 0xC0B4 y 0xC0B5
	ld de,06054h		;a6aa
	ld b,001h		;a6ad
	call 04cc9h		;a6af   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c0b5h		;a6b2   ; apunta a las barras de honba (BCD)
	ld de,09054h		;a6b5
	ld b,001h		;a6b8
	call 04cc9h		;a6ba   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ret			;a6bd
muestra_voz:		; muestra la cara del que habla (A = pon, chi, kan, ron...)
	call 058a2h		;a6be   ; MUESTRA UNA VOZ: A = 1 pon, 2 chi, 3 kan, 4 ron y 5...: lleva el icono del personaje (0x58A2) y el cuadro de 64 x 64 de la tabla 0xA741
	push af			;a6c1
	call L_A7A1		;a6c2   ; pone ocho sprites del cuadro del personaje en 0xCC10 (4 filas de 2) con X, Y y numero
	pop af			;a6c5
	push af			;a6c6
	ld a,(0c24ah)		;a6c7   ; lee el tiempo que queda de la cara que habla
	and a			;a6ca
	jp z,L_A6D1		;a6cb
	call borra_cuadro_voz		;a6ce   ; borra_cuadro_voz: borra el cuadro de la cara que habla
L_A6D1:
	ld a,040h		;a6d1
	ld (0c24ah),a		;a6d3   ; guarda el tiempo que queda de la cara que habla
	pop af			;a6d6
	dec a			;a6d7
	ld (0c249h),a		;a6d8
	add a,a			;a6db
	push af			;a6dc
	ld hl,0a741h		;a6dd
	call 0405ch		;a6e0   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a6e3
	ld d,a			;a6e4
	inc hl			;a6e5
	ld a,(hl)			;a6e6
	ld l,a			;a6e7
	ld h,d			;a6e8
	push hl			;a6e9
	ld de,0a248h		;a6ea
	ld bc,04040h		;a6ed
	ld a,002h		;a6f0
	call 05024h		;a6f2   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	pop hl			;a6f5
	push hl			;a6f6
	ld a,h			;a6f7
	add a,004h		;a6f8
	ld h,a			;a6fa
	ld a,l			;a6fb
	add a,004h		;a6fc
	ld l,a			;a6fe
	ld bc,03838h		;a6ff
	ld d,000h		;a702
	ld a,0bbh		;a704
	call 04fe5h		;a706   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	pop de			;a709
	ld hl,00808h		;a70a
	call 09d1ch		;a70d   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	pop af			;a710
	push af			;a711
	ld hl,0a735h		;a712
	call 0405ch		;a715   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a718
	ld d,a			;a719
	inc hl			;a71a
	ld a,(hl)			;a71b
	ld l,a			;a71c
	ld h,d			;a71d
	pop af			;a71e
	push hl			;a71f
	ld hl,0a73bh		;a720
	call 0405ch		;a723   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a726
	ld d,a			;a727
	inc hl			;a728
	ld a,(hl)			;a729
	ld e,a			;a72a
	pop hl			;a72b
	ld bc,03030h		;a72c
	ld a,001h		;a72f
	call 05024h		;a731   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ret			;a734

; ----------------------------------------------------------------------
; DATOS resto_A735: lo apuntan con el banco puesto p03:A712 (0xA735), p03:A720
;   (0xA73B), p03:A6DD (0xA741), p03:A756 (0xA741); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p03:A712, p03:A720,
;   p03:A6DD, p03:A756 (18 bytes)
;   0xa735..0xa747  (18 bytes)
DATA_resto_A735:
	defb 070h,0d0h,0a0h,0d0h,0d0h,0d0h,088h,050h,068h,048h,048h,050h,080h,048h,060h,040h	; a735  p......PhHHP.H`@
	defb 040h,048h	; a745

; ======================================================================
; CODIGO 0xa747..0xa7ef  (168 bytes)
; ======================================================================


cuenta_atras_cuadro:		; cuenta atras del cuadro de la voz
	ld hl,0c24ah		;a747   ; cuenta atras del cuadro (0xC24A): al llegar a cero lo borra
	ld a,(hl)			;a74a
	and a			;a74b
	ret z			;a74c
	dec (hl)			;a74d
	ret nz			;a74e
borra_cuadro_voz:		; borra el cuadro de la cara que habla
	call L_A7F5		;a74f   ; borra el cuadro del personaje y los sprites
	ld a,(0c249h)		;a752
	add a,a			;a755
	ld hl,0a741h		;a756
	call 0405ch		;a759   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;a75c
	ld d,a			;a75d
	inc hl			;a75e
	ld a,(hl)			;a75f
	ld e,a			;a760
	ld hl,0a248h		;a761
	ld bc,04040h		;a764
	ld a,001h		;a767
	call 05024h		;a769   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	xor a			;a76c
	ld (0c24ah),a		;a76d   ; guarda el tiempo que queda de la cara que habla
	ret			;a770
L_A771:
	ld b,004h		;a771   ; mira si algun jugador (D000 + 4 x n) tiene +0x46 igual a 4 (cuatro kan): acarreo
	xor a			;a773
L_A774:
	push bc			;a774   ; recorre las cuatro manos
	push af			;a775
	ld hl,0d000h		;a776
	ld de,00046h		;a779
	add a,a			;a77c
	add a,a			;a77d
	add a,h			;a77e
	ld h,a			;a77f
	add hl,de			;a780
	ld a,(hl)			;a781   ; mira si algun +0x46 vale 4 (cuatro kan)
	cp 004h		;a782
	jr z,L_A78D		;a784
	pop af			;a786
	inc a			;a787
	pop bc			;a788   ; siguiente jugador
	djnz L_A774		;a789
	or a			;a78b
	ret			;a78c
L_A78D:
	pop af			;a78d
	pop bc			;a78e
	scf			;a78f
	ret			;a790
suma_kan:		; suma uno a los kan del jugador 0xC207
	ld a,(0c207h)		;a791   ; suma uno a +0x46 de la mano del jugador 0xC207 (cuenta de kan)
	ld hl,0d000h		;a794
	add a,a			;a797
	add a,a			;a798
	add a,h			;a799
	ld h,a			;a79a
	ld de,00046h		;a79b
	add hl,de			;a79e
	inc (hl)			;a79f
	ret			;a7a0
L_A7A1:
	ld hl,0a7edh		;a7a1   ; pone ocho sprites del cuadro del personaje en 0xCC10 (4 filas de 2) con X, Y y numero
	call 04d07h		;a7a4   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;a7a7
	ld b,002h		;a7a8
	ld hl,0cc10h		;a7aa
	ld c,0c0h		;a7ad
L_A7AF:
	push bc			;a7af
	push de			;a7b0
	ld b,004h		;a7b1
L_A7B3:
	call L_A7DB		;a7b3   ; pone dos sprites de la fila
	call L_A7DB		;a7b6   ; un sprite de cuatro bytes: Y, X, patron; despues el patron sube cuatro
	ld a,d			;a7b9
	add a,010h		;a7ba
	ld d,a			;a7bc
	djnz L_A7B3		;a7bd   ; sigue con la fila de abajo
	pop de			;a7bf
	ld a,e			;a7c0
	add a,010h		;a7c1
	ld e,a			;a7c3
	ld a,c			;a7c4
	pop bc			;a7c5
	ld c,a			;a7c6
	djnz L_A7AF		;a7c7
	ld hl,0ca40h		;a7c9   ; pone los colores de los sprites del cuadro (0xCA40)
	ld b,008h		;a7cc
L_A7CE:
	ld a,009h		;a7ce   ; alterna los dos colores de las ocho lineas
	call L_A7E7		;a7d0
	ld a,00fh		;a7d3
	call L_A7E7		;a7d5
	djnz L_A7CE		;a7d8
	ret			;a7da
L_A7DB:
	ld (hl),e			;a7db   ; un sprite de cuatro bytes: Y, X, patron; despues el patron sube cuatro
	inc hl			;a7dc
	ld (hl),d			;a7dd   ; la X del sprite
	inc hl			;a7de
	ld (hl),c			;a7df   ; el patron
	inc hl			;a7e0
	inc hl			;a7e1
	inc c			;a7e2   ; el siguiente patron (de cuatro en cuatro)
	inc c			;a7e3
	inc c			;a7e4
	inc c			;a7e5
	ret			;a7e6
L_A7E7:
	ld c,010h		;a7e7
L_A7E9:
	ld (hl),a			;a7e9
	inc hl			;a7ea
	dec c			;a7eb
	jr nz,L_A7E9		;a7ec
	ret			;a7ee

; ----------------------------------------------------------------------
; DATOS posiciones_cuadro: tres posiciones (Y, X) de la tabla de p03:A7A1
;   (0xA7ED + 2 x A) donde se dibuja el cuadro de la cara que habla: (0x78,
;   0x84), (0x70, 0x64) y (0x78, 0x44) (el primer byte es la Y del sprite y el
;   segundo la X)
;   0xa7ef..0xa7f5  (6 bytes)
DATA_posiciones_cuadro:
	defb 078h,084h	; a7ef
	defb 070h,064h	; a7f1
	defb 078h,044h	; a7f3

; ======================================================================
; CODIGO 0xa7f5..0xa809  (20 bytes)
; ======================================================================


L_A7F5:
	ld hl,0cc10h		;a7f5   ; pone los sprites de 0xCC10 fuera de pantalla
	ld de,0cc11h		;a7f8
	ld bc,0003fh		;a7fb
	ld (hl),0e0h		;a7fe
	ldir		;a800
	ret			;a802
L_A803:
	ld a,(0c02bh)		;a803   ; pantalla de las opciones: 0xC02B elige el paso por la tabla de 0xA807
	call 04066h		;a806   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A809: 4 destinos del despachador p00:4066 (call en p03:A806, el
;   indice en A): A811, A81C, A830, A8C9; lo leen p03:A806 (8 bytes)
;   0xa809..0xa811  (8 bytes)
DATA_tabla_A809:
	defw 0a811h,0a81ch,0a830h,0a8c9h	; a809  -> L_A811 L_A81C L_A830 L_A8C9

; ======================================================================
; CODIGO 0xa811..0xa96e  (349 bytes)
; ======================================================================


L_A811:
	call 04e76h		;a811   ; pantalla_off: apaga la pantalla
	call L_A8F6		;a814   ; pone el aspecto de los dos sprites del cursor de las opciones (0xCA00 con 9 y 0xCA10 con 2)
	ld hl,0c02bh		;a817   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;a81a
	ret			;a81b
L_A81C:
	call L_A930		;a81c   ; prepara la pantalla de opciones (0xA930 fondo y 0xA9CA diez marcas) y pone el registro 8 del VDP a 8
	call L_A9CA		;a81f   ; dibuja las diez marcas de las opciones: cada una 0x47 (activada) o 0x48 (no)
	call 04e69h		;a822   ; pantalla_on: enciende la pantalla
	ld bc,00807h		;a825
	call 00047h		;a828   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0c02bh		;a82b   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;a82e
	ret			;a82f
L_A830:
	ld a,(0c007h)		;a830   ; teclas de las opciones: boton, arriba, abajo, derecha, izquierda
	rra			;a833
	jr c,L_A85F		;a834
	rra			;a836   ; con el bit 1 (arriba) va a 0xA845
	jr c,L_A845		;a837
	rra			;a839
	jr c,L_A873		;a83a
	rra			;a83c   ; el bit 3 (derecha) a 0xA883
	jr c,L_A883		;a83d
	rra			;a83f   ; el bit 4 (el boton) a 0xA892
	jr c,L_A892		;a840
	jp L_A90A		;a842
L_A845:
	ld hl,0c02ch		;a845   ; abajo: la opcion sube de 5 en 5 con vuelta a 0 en la 0x0B, y la 5 salta a la 10
	inc (hl)			;a848
	ld a,(hl)			;a849
	cp 005h		;a84a
	jr z,L_A859		;a84c
	cp 00bh		;a84e
	jp nz,L_A907		;a850
	ld a,000h		;a853
	ld (hl),a			;a855
	jp L_A907		;a856
L_A859:
	ld a,00ah		;a859
	ld (hl),a			;a85b
	jp L_A907		;a85c
L_A85F:
	ld hl,0c02ch		;a85f   ; apunta a el paso o la opcion de la pantalla de menu
	ld a,(hl)			;a862
	sub 001h		;a863
	ld (hl),a			;a865
	jr c,L_A86D		;a866
	cp 004h		;a868
	jp nz,L_A907		;a86a
L_A86D:
	ld a,00ah		;a86d
	ld (hl),a			;a86f
	jp L_A907		;a870
L_A873:
	ld hl,0c02ch		;a873   ; apunta a el paso o la opcion de la pantalla de menu
	ld a,(hl)			;a876
	cp 005h		;a877
	jr c,L_A882		;a879
	ld a,(hl)			;a87b
	sub 005h		;a87c
	ld (hl),a			;a87e
	jp L_A907		;a87f
L_A882:
	ret			;a882
L_A883:
	ld hl,0c02ch		;a883   ; apunta a el paso o la opcion de la pantalla de menu
	ld a,(hl)			;a886
	cp 005h		;a887
	jr nc,L_A882		;a889
	ld a,005h		;a88b
	add a,(hl)			;a88d
	ld (hl),a			;a88e
	jp L_A907		;a88f
L_A892:
	ld hl,0c02ch		;a892   ; el boton: si no es la opcion de salir (10) cambia la opcion entre 0 y 1 en 0xC020 + opcion
	ld a,(hl)			;a895
	cp 00ah		;a896
	jr z,L_A8BC		;a898
	call L_A8DF		;a89a   ; borra el recuadro de la opcion elegida (16 x 16, posicion de la tabla 0xA9FF)
	ld a,(0c02ch)		;a89d   ; lee el paso o la opcion de la pantalla de menu
	ld hl,0c020h		;a8a0   ; apunta a la regla 'comer 断幺' (tanyao con la mano abierta; de serie si)
	add a,l			;a8a3
	ld l,a			;a8a4
	ld a,(hl)			;a8a5
	and a			;a8a6
	jr z,L_A8B2		;a8a7
	xor a			;a8a9
	ld (hl),a			;a8aa
	ld a,(0c02ch)		;a8ab   ; lee el paso o la opcion de la pantalla de menu
	call L_A9DF		;a8ae   ; dibuja la marca de la opcion A en su sitio de la tabla 0xA9FF
	ret			;a8b1
L_A8B2:
	ld a,001h		;a8b2
	ld (hl),a			;a8b4
	ld a,(0c02ch)		;a8b5   ; lee el paso o la opcion de la pantalla de menu
	call L_A9DF		;a8b8   ; dibuja la marca de la opcion A en su sitio de la tabla 0xA9FF
	ret			;a8bb
L_A8BC:
	call 0411bh		;a8bc   ; salir de las opciones: sonido 0x01 y 0xC02B += 1
	ld a,0e0h		;a8bf
	ld (0cc00h),a		;a8c1   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld hl,0c02bh		;a8c4   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;a8c7
	ret			;a8c8
L_A8C9:
	call 04e50h		;a8c9   ; acaba las opciones: 0xC02B = 0, 0xC02C = 0 y 0xC02A = 1
	xor a			;a8cc
	ld (0c02bh),a		;a8cd   ; guarda variable de los pasos de las pantallas de menu
	ld (0c02ch),a		;a8d0   ; guarda el paso o la opcion de la pantalla de menu
	ld bc,00f07h		;a8d3
	call 00047h		;a8d6   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,001h		;a8d9
	ld (0c02ah),a		;a8db   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;a8de
L_A8DF:
	ld a,(0c02ch)		;a8df   ; borra el recuadro de la opcion elegida (16 x 16, posicion de la tabla 0xA9FF)
	ld hl,0a9ffh		;a8e2
	call 04d07h		;a8e5   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld e,h			;a8e8
	ld d,l			;a8e9
	ex de,hl			;a8ea
	ld bc,01010h		;a8eb
	ld a,0ffh		;a8ee
	ld d,000h		;a8f0
	call 04fe5h		;a8f2   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;a8f5
L_A8F6:
	ld hl,0ca00h		;a8f6   ; pone el aspecto de los dos sprites del cursor de las opciones (0xCA00 con 9 y 0xCA10 con 2)
	ld a,009h		;a8f9
	call 04382h		;a8fb   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;a8fe
	ld a,002h		;a901
	call 04382h		;a903   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ret			;a906
L_A907:
	call 04116h		;a907   ; mueve el cursor de las opciones (suena el sonido 0x06) y coloca los sprites en la casilla de la tabla 0xA9FF
L_A90A:
	ld a,(0c02ch)		;a90a   ; lee el paso o la opcion de la pantalla de menu
	ld hl,0a9ffh		;a90d
	call 04d07h		;a910   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,h			;a913
	add a,004h		;a914
	ld (0cc00h),a		;a916   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;a919
	ld a,l			;a91c
	sub 008h		;a91d
	ld (0cc01h),a		;a91f
	ld (0cc05h),a		;a922
	ld a,038h		;a925
	ld (0cc02h),a		;a927
	ld a,03ch		;a92a
	ld (0cc06h),a		;a92c
	ret			;a92f
L_A930:
	ld hl,03c04h		;a930   ; dibuja el fondo de las opciones: dos rectangulos, dos ventanas y 16 textos de la tabla 0xA96E
	ld bc,08818h		;a933
	ld a,0ffh		;a936
	ld d,000h		;a938
	call 04fe5h		;a93a   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,00424h		;a93d
	ld bc,0f8a0h		;a940
	ld a,0ffh		;a943
	ld d,000h		;a945
	call 04fe5h		;a947   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,03800h		;a94a
	ld hl,01204h		;a94d
	call 09d1ch		;a950   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,00020h		;a953
	ld hl,02015h		;a956
	call 09d1ch		;a959   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,010h		;a95c
	ld hl,0a96eh		;a95e
L_A961:
	push bc			;a961
	ld d,(hl)			;a962
	inc hl			;a963
	ld e,(hl)			;a964
	inc hl			;a965
	call 05acdh		;a966   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	inc hl			;a969
	pop bc			;a96a
	djnz L_A961		;a96b
	ret			;a96d

; ----------------------------------------------------------------------
; DATOS resto_A96E: lo apuntan con el banco puesto p03:A95E (0xA96E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A95E (92 bytes)
;   0xa96e..0xa9ca  (92 bytes)
DATA_resto_A96E:
	defb 048h,008h,03eh,0ffh,060h,008h,046h,0ffh,078h,008h,03eh,0ffh,090h,008h,025h,0ffh	; a96e  H.>.`.F.x.>...%.
	defb 0a8h,008h,02eh,0ffh,030h,030h,020h,044h,028h,019h,0ffh,030h,048h,01eh,037h,034h	; a97e  ....00 D(..0H.74
	defb 03ch,0ffh,030h,060h,014h,00dh,032h,02dh,0ffh,030h,078h,038h,045h,036h,030h,0ffh	; a98e  <.0`..2-.0x8E60.
	defb 030h,090h,012h,03ah,027h,0ffh,0a0h,030h,00eh,03ah,035h,0ffh,0a0h,048h,029h,07ch	; a99e  0..:'..0.:5..H)|
	defb 03bh,0ffh,0a0h,060h,024h,042h,08bh,0ffh,0a0h,078h,074h,075h,03eh,09ch,041h,0ffh	; a9ae  ...`$B...xtu>.A.
	defb 0a0h,090h,00ch,072h,098h,099h,0ffh,070h,0a8h,022h,039h,0ffh	; a9be  ...r...p."9.

; ======================================================================
; CODIGO 0xa9ca..0xa9ff  (53 bytes)
; ======================================================================


L_A9CA:
	ld b,00ah		;a9ca   ; dibuja las diez marcas de las opciones: cada una 0x47 (activada) o 0x48 (no)
	ld hl,0c020h		;a9cc   ; apunta a la regla 'comer 断幺' (tanyao con la mano abierta; de serie si)
L_A9CF:
	push bc			;a9cf   ; dibuja la marca de cada una de las diez opciones
	push hl			;a9d0
	ld a,b			;a9d1
	sub 00ah		;a9d2   ; la opcion es 10 - B
	neg		;a9d4
	call L_A9DF		;a9d6   ; dibuja la marca de la opcion A en su sitio de la tabla 0xA9FF
	pop hl			;a9d9
	inc hl			;a9da
	pop bc			;a9db
	djnz L_A9CF		;a9dc
	ret			;a9de
L_A9DF:
	push af			;a9df   ; dibuja la marca de la opcion A en su sitio de la tabla 0xA9FF
	ld hl,0a9ffh		;a9e0
	call 04d07h		;a9e3   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld e,h			;a9e6
	ld d,l			;a9e7
	pop af			;a9e8
	push de			;a9e9
	ld hl,0c020h		;a9ea   ; apunta a la regla 'comer 断幺' (tanyao con la mano abierta; de serie si)
	add a,l			;a9ed
	ld l,a			;a9ee
	ld a,(hl)			;a9ef
	and a			;a9f0
	jr z,L_A9F8		;a9f1
	ld a,047h		;a9f3
	jp L_A9FA		;a9f5
L_A9F8:
	ld a,048h		;a9f8
L_A9FA:
	pop de			;a9fa
	call 05b23h		;a9fb
	ret			;a9fe

; ----------------------------------------------------------------------
; DATOS resto_A9FF: lo apuntan con el banco puesto p03:A8E2 (0xA9FF), p03:A90D
;   (0xA9FF), p03:A9E0 (0xA9FF); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p03:A8E2, p03:A90D, p03:A9E0 (22 bytes)
;   0xa9ff..0xaa15  (22 bytes)
DATA_resto_A9FF:
	defb 018h,030h,018h,048h,018h,060h,018h,078h,018h,090h,088h,030h,088h,048h,088h,060h	; a9ff  .0.H.`.x...0.H.`
	defb 088h,078h,088h,090h,070h,0a8h	; aa0f

; ======================================================================
; CODIGO 0xaa15..0xaa1b  (6 bytes)
; ======================================================================


L_AA15:
	ld a,(0c02ch)		;aa15   ; PANTALLA DE ELEGIR RIVALES: 0xC02C elige el paso por la tabla de 0xAA19
	call 04066h		;aa18   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AA1B: 6 destinos del despachador p00:4066 (call en p03:AA18, el
;   indice en A): AA27, AA54, AA5D, AA6D, AABA, AACD; lo leen p03:AA18 (12
;   bytes)
;   0xaa1b..0xaa27  (12 bytes)
DATA_tabla_AA1B:
	defw 0aa27h,0aa54h,0aa5dh,0aa6dh,0aabah,0aacdh	; aa1b

; ======================================================================
; CODIGO 0xaa27..0xac0c  (485 bytes)
; ======================================================================


L_AA27:
	ld bc,00a07h		;aa27
	call 00047h		;aa2a   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0ca00h		;aa2d   ; sprites del cursor (0xCA00 con 0x0E), guarda los tres rivales de 0xC031-3 en 0xC233-5 y los dibuja (0xAD6F, 0xAC97)
	ld a,00eh		;aa30
	call 04382h		;aa32   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld a,(0c031h)		;aa35   ; lee el personaje que juega de rival 1
	ld (0c233h),a		;aa38
	ld a,(0c032h)		;aa3b   ; lee el personaje que juega de rival 2
	ld (0c234h),a		;aa3e
	ld a,(0c033h)		;aa41   ; lee el personaje que juega de rival 3
	ld (0c235h),a		;aa44
	xor a			;aa47
	ld (0c207h),a		;aa48   ; guarda el jugador al que le toca (0 = el humano)
	call L_AD6F		;aa4b   ; suma uno (BCD, tope 99) al contador 0xC034 y al de cada uno de los tres rivales
	call L_AC97		;aa4e   ; dibuja los marcos de los tres rivales con 0x661D (sus caras) y enciende la pantalla
	jp L_B056		;aa51
L_AA54:
	call L_AB0A		;aa54   ; el jugador humano elige quien va a su derecha: dibuja las cuatro caras (0xAB0A) y baraja (0xAB36)
	call L_AB36		;aa57   ; baraja los cuatro vientos: toma de la tabla 0xAC57 una combinacion al azar (4 bytes) a 0xC21E
	jp L_B056		;aa5a
L_AA5D:
	call L_AB4C		;aa5d   ; espera la eleccion (0xAB4C) y pasa al jugador siguiente
	ret nc			;aa60
	ld hl,0c207h		;aa61   ; apunta a el jugador al que le toca (0 = el humano)
	inc (hl)			;aa64
	ld a,0e0h		;aa65
	ld (0cc00h),a		;aa67   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	jp L_B056		;aa6a
L_AA6D:
	call L_AC44		;aa6d   ; sortea quien se sienta en cada sitio (0xAC44) para los tres rivales
	ld hl,0c207h		;aa70   ; apunta a el jugador al que le toca (0 = el humano)
	inc (hl)			;aa73
	ld a,(hl)			;aa74
	cp 004h		;aa75
	jr nz,L_AA6D		;aa77
	ld a,(0c02fh)		;aa79   ; el sitio del humano queda en 0xC02F y pone los rivales en la tabla 0xC030 segun el orden de sentarse (0xC22A)
	ld (0c207h),a		;aa7c   ; guarda el jugador al que le toca (0 = el humano)
	ld a,001h		;aa7f
	ld (0c22eh),a		;aa81
	ld a,(0c22ah)		;aa84
	ld b,a			;aa87
L_AA88:
	ld hl,0c22ah		;aa88
	ld a,(0c22eh)		;aa8b
	call 0405ch		;aa8e   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;aa91
	sub b			;aa92
	and 003h		;aa93
	ld hl,0c030h		;aa95   ; apunta a el personaje que se sienta en cada sitio (4 bytes)
	call 0405ch		;aa98   ; suma_a_hl: HL = HL + A
	push hl			;aa9b
	ld a,(0c22eh)		;aa9c
	dec a			;aa9f
	ld hl,0c233h		;aaa0
	call 0405ch		;aaa3   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;aaa6
	pop hl			;aaa7
	ld (hl),a			;aaa8
	ld hl,0c22eh		;aaa9
	inc (hl)			;aaac
	ld a,(hl)			;aaad
	cp 004h		;aaae
	jr nz,L_AA88		;aab0
	ld a,080h		;aab2
	ld (0c004h),a		;aab4   ; guarda el temporizador de espera entre pasos
	jp L_B056		;aab7
L_AABA:
	ld hl,0c004h		;aaba   ; espera 0x80 cuadros y dibuja la pantalla con los cuatro sentados (0xAD03)
	dec (hl)			;aabd
	ret nz			;aabe
	call 04e50h		;aabf   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call L_AD03		;aac2   ; dibuja los rivales tras sentarse, con las caras de 0xC031-3
	ld a,080h		;aac5
	ld (0c004h),a		;aac7   ; guarda el temporizador de espera entre pasos
	jp L_B056		;aaca
L_AACD:
	ld hl,0c004h		;aacd   ; tras la espera, si hay un rival elegido lo busca (0xAAE2) y sale
	dec (hl)			;aad0
	ld a,(hl)			;aad1
	ret nz			;aad2
	ld a,(0c207h)		;aad3   ; lee el jugador al que le toca (0 = el humano)
	and a			;aad6
	jr z,L_AADC		;aad7
	call L_AAE2		;aad9   ; busca cual de los tres rivales de 0xC031 es el de 0xC233 + A y deja su numero en 0xC207
L_AADC:
	ld a,001h		;aadc
	ld (0c02ah),a		;aade   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;aae1
L_AAE2:
	dec a			;aae2   ; busca cual de los tres rivales de 0xC031 es el de 0xC233 + A y deja su numero en 0xC207
	ld hl,0c233h		;aae3
	call 0405ch		;aae6   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;aae9
	ld b,a			;aaea
	ld hl,0c031h		;aaeb   ; apunta a el personaje que juega de rival 1
	ld a,001h		;aaee
	ld (0c22eh),a		;aaf0
L_AAF3:
	ld a,(hl)			;aaf3   ; busca el rival de 0xC233 entre los de 0xC031
	cp b			;aaf4
	jp z,L_AB03		;aaf5
	inc hl			;aaf8
	ld a,(0c22eh)		;aaf9   ; cuenta cual es
	inc a			;aafc
	ld (0c22eh),a		;aafd
	jp L_AAF3		;ab00
L_AB03:
	ld a,(0c22eh)		;ab03
	ld (0c207h),a		;ab06   ; guarda el jugador al que le toca (0 = el humano)
	ret			;ab09
L_AB0A:
	ld b,004h		;ab0a   ; dibuja las cuatro fichas de viento del sorteo (la ficha 0x38 en cuatro sitios consecutivos, de 12 de ancho)
	ld a,068h		;ab0c
	ld (0c203h),a		;ab0e   ; guarda la X donde se dibuja la ficha
	ld a,078h		;ab11
	ld (0c204h),a		;ab13   ; guarda la Y donde se dibuja la ficha
L_AB16:
	ld a,00ch		;ab16
	ld (0c205h),a		;ab18   ; guarda el ancho de la ficha
	ld a,012h		;ab1b
	ld (0c206h),a		;ab1d   ; guarda el alto de la ficha
	xor a			;ab20
	ld (0c207h),a		;ab21   ; guarda el jugador al que le toca (0 = el humano)
	ld a,038h		;ab24
	push bc			;ab26
	call 08b86h		;ab27
	pop bc			;ab2a
	ld a,(0c203h)		;ab2b   ; lee la X donde se dibuja la ficha
	add a,00ch		;ab2e
	ld (0c203h),a		;ab30   ; guarda la X donde se dibuja la ficha
	djnz L_AB16		;ab33
	ret			;ab35
L_AB36:
	call 065b2h		;ab36   ; baraja los cuatro vientos: toma de la tabla 0xAC57 una combinacion al azar (4 bytes) a 0xC21E
	and 00fh		;ab39
	add a,a			;ab3b
	add a,a			;ab3c
	ld hl,0ac57h		;ab3d
	call 0405ch		;ab40   ; suma_a_hl: HL = HL + A
	ld de,0c21eh		;ab43
	ld bc,00004h		;ab46
	ldir		;ab49
	ret			;ab4b
L_AB4C:
	ld a,(0c007h)		;ab4c   ; teclas del sorteo (izquierda, derecha, boton)
	rra			;ab4f
	rra			;ab50
	rra			;ab51
	jr c,L_AB89		;ab52
	rra			;ab54
	jr c,L_AB98		;ab55
	rra			;ab57
	jp nc,L_ABAA		;ab58
	ld a,0e0h		;ab5b   ; el boton: toma la ficha de viento elegida (0xC21E + 0xC02B), la dibuja (0xABCB, 0xAC14) y, si es la 0x31, el humano se sienta aqui
	ld (0cc00h),a		;ab5d   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	call 0411bh		;ab60   ; pide_sonido_07: pide el sonido 0x07 (el del boton)
L_AB63:
	ld a,(0c02bh)		;ab63   ; lee variable de los pasos de las pantallas de menu
	ld hl,0c21eh		;ab66
	call 0405ch		;ab69   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;ab6c
	and a			;ab6d
	jr z,L_AB87		;ab6e
	push af			;ab70
	ld (0c02eh),a		;ab71
	call L_ABCB		;ab74   ; dibuja la ficha elegida (0xC02E) en el sitio de la tabla 0xAC0C y guarda en 0xC22A el viento que ha salido
	call L_AC14		;ab77   ; borra la ficha elegida del sorteo y espera
	pop af			;ab7a
	cp 031h		;ab7b
	jr nz,L_AB85		;ab7d
	ld a,(0c207h)		;ab7f   ; lee el jugador al que le toca (0 = el humano)
	ld (0c02fh),a		;ab82
L_AB85:
	scf			;ab85
	ret			;ab86
L_AB87:
	or a			;ab87
	ret			;ab88
L_AB89:
	ld a,(0c02bh)		;ab89   ; lee variable de los pasos de las pantallas de menu
	and a			;ab8c
	jr z,L_AB93		;ab8d
	dec a			;ab8f
	jp L_ABA4		;ab90
L_AB93:
	ld a,003h		;ab93
	jp L_ABA4		;ab95
L_AB98:
	ld a,(0c02bh)		;ab98   ; lee variable de los pasos de las pantallas de menu
	cp 003h		;ab9b
	jr z,L_ABA3		;ab9d
	inc a			;ab9f
	jp L_ABA4		;aba0
L_ABA3:
	xor a			;aba3
L_ABA4:
	ld (0c02bh),a		;aba4   ; guarda variable de los pasos de las pantallas de menu
	call 04116h		;aba7   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_ABAA:
	ld a,(0c02bh)		;abaa   ; pone el sprite del cursor sobre la ficha elegida (12 de ancho por ficha)
	ld b,a			;abad
	ld c,00ch		;abae
	call 08b6fh		;abb0   ; multiplica_b_c: A = B x C
	ld b,06ah		;abb3
	add a,b			;abb5
	ld (0cc01h),a		;abb6
	ld a,08ch		;abb9
	ld (0cc00h),a		;abbb   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld a,048h		;abbe
	ld (0cc02h),a		;abc0
	or a			;abc3
	ret			;abc4
L_ABC5:
	ld a,011h		;abc5
	call L_AFDB		;abc7   ; borra con 0 el rectangulo de la pantalla (212 filas)
	ret			;abca
L_ABCB:
	ld a,00ch		;abcb   ; dibuja la ficha elegida (0xC02E) en el sitio de la tabla 0xAC0C y guarda en 0xC22A el viento que ha salido
	ld (0c205h),a		;abcd   ; guarda el ancho de la ficha
	ld a,012h		;abd0
	ld (0c206h),a		;abd2   ; guarda el alto de la ficha
	ld a,(0c207h)		;abd5   ; lee el jugador al que le toca (0 = el humano)
	add a,a			;abd8
	ld hl,0ac0ch		;abd9
	call 0405ch		;abdc   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;abdf
	ld (0c203h),a		;abe0   ; guarda la X donde se dibuja la ficha
	inc hl			;abe3
	ld a,(hl)			;abe4
	ld (0c204h),a		;abe5   ; guarda la Y donde se dibuja la ficha
	ld hl,0c207h		;abe8   ; apunta a el jugador al que le toca (0 = el humano)
	ld a,(hl)			;abeb
	push af			;abec
	ld (hl),000h		;abed
	ld a,(0c02eh)		;abef
	push af			;abf2
	call 08b8ch		;abf3   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ld hl,0c22ah		;abf6
	ld a,(0c22eh)		;abf9
	call 0405ch		;abfc   ; suma_a_hl: HL = HL + A
	pop af			;abff
	sub 031h		;ac00
	ld (hl),a			;ac02
	ld hl,0c22eh		;ac03
	inc (hl)			;ac06
	pop af			;ac07
	ld (0c207h),a		;ac08   ; guarda el jugador al que le toca (0 = el humano)
	ret			;ac0b

; ----------------------------------------------------------------------
; DATOS resto_AC0C: lo apuntan con el banco puesto p03:ABD9 (0xAC0C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:ABD9 (8 bytes)
;   0xac0c..0xac14  (8 bytes)
DATA_resto_AC0C:
	defb 07ah,0a8h,03ah,050h,07ah,050h,0bah,050h	; ac0c  z.:PzP.P

; ======================================================================
; CODIGO 0xac14..0xac57  (67 bytes)
; ======================================================================


L_AC14:
	ld a,(0c02bh)		;ac14   ; borra la ficha elegida del sorteo y espera
	ld hl,0c21eh		;ac17
	call 0405ch		;ac1a   ; suma_a_hl: HL = HL + A
	xor a			;ac1d
	ld (hl),a			;ac1e
	ld a,(0c02bh)		;ac1f   ; lee variable de los pasos de las pantallas de menu
	ld b,a			;ac22
	ld c,00ch		;ac23
	call 08b6fh		;ac25   ; multiplica_b_c: A = B x C
	add a,068h		;ac28
	ld h,a			;ac2a
	ld l,078h		;ac2b
	ld bc,00c12h		;ac2d
	ld d,000h		;ac30
	ld a,0aah		;ac32
	call 04fe5h		;ac34   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld b,080h		;ac37
L_AC39:
	push bc			;ac39
	ld b,0ffh		;ac3a
L_AC3C:
	push bc			;ac3c   ; retardo del sorteo
	pop bc			;ac3d
	djnz L_AC3C		;ac3e
	pop bc			;ac40
	djnz L_AC39		;ac41
	ret			;ac43
L_AC44:
	call 065b2h		;ac44   ; elige una casilla del sorteo al azar (0xC02B = 0-3), repitiendo hasta que haya una libre
L_AC47:
	and 003h		;ac47
	ld (0c02bh),a		;ac49   ; guarda variable de los pasos de las pantallas de menu
	call L_AB63		;ac4c
	ret c			;ac4f
	ld a,(0c02bh)		;ac50   ; lee variable de los pasos de las pantallas de menu
	inc a			;ac53
	jp L_AC47		;ac54

; ----------------------------------------------------------------------
; DATOS resto_AC57: lo apuntan con el banco puesto p03:AB3D (0xAC57); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:AB3D (64 bytes)
;   0xac57..0xac97  (64 bytes)
DATA_resto_AC57:
	defb 031h,032h,033h,034h,031h,032h,034h,033h,031h,033h,032h,034h,031h,033h,034h,032h	; ac57  1234124313241342
	defb 032h,031h,033h,034h,032h,031h,034h,033h,032h,033h,031h,034h,032h,033h,034h,031h	; ac67  2134214323142341
	defb 033h,031h,032h,034h,033h,031h,034h,032h,033h,032h,031h,034h,033h,032h,034h,031h	; ac77  3124314232143241
	defb 034h,031h,032h,033h,034h,031h,033h,032h,034h,032h,031h,033h,034h,032h,033h,031h	; ac87  4123413242134231

; ======================================================================
; CODIGO 0xac97..0xacfd  (102 bytes)
; ======================================================================


L_AC97:
	call 04e76h		;ac97   ; dibuja los marcos de los tres rivales con 0x661D (sus caras) y enciende la pantalla
	ld hl,0240ch		;ac9a
	ld bc,03838h		;ac9d
	ld d,000h		;aca0
	ld a,0bbh		;aca2
	call 04fe5h		;aca4   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,02008h		;aca7
	ld hl,00808h		;acaa
	call 09d1ch		;acad   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,0640ch		;acb0
	ld bc,03838h		;acb3
	ld d,000h		;acb6
	ld a,0bbh		;acb8
	call 04fe5h		;acba   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06008h		;acbd
	ld hl,00808h		;acc0
	call 09d1ch		;acc3   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,0a40ch		;acc6
	ld bc,03838h		;acc9
	ld d,000h		;accc
	ld a,0bbh		;acce
	call 04fe5h		;acd0   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,0a008h		;acd3
	ld hl,00808h		;acd6
	call 09d1ch		;acd9   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,003h		;acdc
L_ACDE:
	push bc			;acde
	ld a,003h		;acdf
	sub b			;ace1
	push af			;ace2
	ld hl,0acfdh		;ace3
	call 04d07h		;ace6   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;ace9
	pop af			;acea
	ld hl,0c031h		;aceb   ; apunta a el personaje que juega de rival 1
	call 0405ch		;acee   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;acf1
	dec a			;acf2
	call 0661dh		;acf3   ; dibuja_cara: dibuja la cara de 48 x 48 del personaje A
	pop bc			;acf6
	djnz L_ACDE		;acf7
	call 04e69h		;acf9   ; pantalla_on: enciende la pantalla
	ret			;acfc

; ----------------------------------------------------------------------
; DATOS resto_ACFD: lo apuntan con el banco puesto p03:ACE3 (0xACFD); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:ACE3 (6 bytes)
;   0xacfd..0xad03  (6 bytes)
DATA_resto_ACFD:
	defb 010h,028h,010h,068h,010h,0a8h	; acfd

; ======================================================================
; CODIGO 0xad03..0xad69  (102 bytes)
; ======================================================================


L_AD03:
	call 04e76h		;ad03   ; dibuja los rivales tras sentarse, con las caras de 0xC031-3
	ld hl,0bc44h		;ad06
	ld bc,03838h		;ad09
	ld d,000h		;ad0c
	ld a,0bbh		;ad0e
	call 04fe5h		;ad10   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,0b840h		;ad13
	ld hl,00808h		;ad16
	call 09d1ch		;ad19   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,0640ch		;ad1c
	ld bc,03838h		;ad1f
	ld d,000h		;ad22
	ld a,0bbh		;ad24
	call 04fe5h		;ad26   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06008h		;ad29
	ld hl,00808h		;ad2c
	call 09d1ch		;ad2f   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,00c44h		;ad32
	ld bc,03838h		;ad35
	ld d,000h		;ad38
	ld a,0bbh		;ad3a
	call 04fe5h		;ad3c   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,00840h		;ad3f
	ld hl,00808h		;ad42
	call 09d1ch		;ad45   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,003h		;ad48
L_AD4A:
	push bc			;ad4a
	ld a,003h		;ad4b
	sub b			;ad4d
	push af			;ad4e
	ld hl,0ad69h		;ad4f
	call 04d07h		;ad52   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;ad55
	pop af			;ad56
	ld hl,0c031h		;ad57   ; apunta a el personaje que juega de rival 1
	call 0405ch		;ad5a   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;ad5d
	dec a			;ad5e
	call 0661dh		;ad5f   ; dibuja_cara: dibuja la cara de 48 x 48 del personaje A
	pop bc			;ad62
	djnz L_AD4A		;ad63
	call 04e69h		;ad65   ; pantalla_on: enciende la pantalla
	ret			;ad68

; ----------------------------------------------------------------------
; DATOS resto_AD69: lo apuntan con el banco puesto p03:AD4F (0xAD69); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:AD4F (6 bytes)
;   0xad69..0xad6f  (6 bytes)
DATA_resto_AD69:
	defb 048h,0c0h,010h,068h,048h,010h	; ad69

; ======================================================================
; CODIGO 0xad6f..0xada1  (50 bytes)
; ======================================================================


L_AD6F:
	ld hl,0c034h		;ad6f   ; suma uno (BCD, tope 99) al contador 0xC034 y al de cada uno de los tres rivales
	ld a,(hl)			;ad72
	cp 099h		;ad73
	jr nc,L_AD7B		;ad75
	add a,001h		;ad77
	daa			;ad79
	ld (hl),a			;ad7a
L_AD7B:
	ld hl,0c031h		;ad7b   ; apunta a el personaje que juega de rival 1
	ld b,003h		;ad7e
L_AD80:
	push bc			;ad80
	push hl			;ad81
	ld a,(hl)			;ad82
	call L_AD8C		;ad83   ; suma uno (BCD, tope 99) al contador del rival A
	pop hl			;ad86
	inc hl			;ad87
	pop bc			;ad88
	djnz L_AD80		;ad89
	ret			;ad8b
L_AD8C:
	ld hl,0c034h		;ad8c   ; suma uno (BCD, tope 99) al contador del rival A
	call 0405ch		;ad8f   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;ad92
	cp 099h		;ad93
	ret nc			;ad95
	add a,001h		;ad96
	daa			;ad98
	ld (hl),a			;ad99
	ret			;ad9a
L_AD9B:
	ld a,(0c02ch)		;ad9b   ; PANTALLA DE ELEGIR LOS TRES RIVALES: 0xC02C elige el paso por la tabla de 0xAD9F
	call 04066h		;ad9e   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_ADA1: 5 destinos del despachador p00:4066 (call en p03:AD9E, el
;   indice en A): ADAB, ADDD, ADE7, AE01, AE09; lo leen p03:AD9E (10 bytes)
;   0xada1..0xadab  (10 bytes)
DATA_tabla_ADA1:
	defw 0adabh,0adddh,0ade7h,0ae01h,0ae09h	; ada1

; ======================================================================
; CODIGO 0xadab..0xae99  (238 bytes)
; ======================================================================


L_ADAB:
	call 04e76h		;adab   ; prepara la pantalla (fondo 0x5806, 0x5828, 0x5A22 y los textos de 0xAEB9), sprites del cursor y 0xC221 = 0
	call 05806h		;adae
	call 05828h		;adb1
	call 05a22h		;adb4   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	ld hl,0aeb9h		;adb7
	call 05363h		;adba   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	call 04e69h		;adbd   ; pantalla_on: enciende la pantalla
	ld bc,00a07h		;adc0
	call 00047h		;adc3   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0ca00h		;adc6   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,009h		;adc9
	call 04382h		;adcb   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;adce
	ld a,002h		;add1
	call 04382h		;add3   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	xor a			;add6
	ld (0c221h),a		;add7
	jp L_B056		;adda
L_ADDD:
	call L_AE14		;addd   ; el humano elige a un rival con 0xAE14; cuando elige a los tres, 0xAEF4 y sigue
	ret nc			;ade0
	call L_AEF4		;ade1   ; muestra la cara del rival elegido a 48 de alto con un barrido (copia de 48 filas)
	jp L_B056		;ade4
L_ADE7:
	ld a,(0c02bh)		;ade7   ; lee variable de los pasos de las pantallas de menu
	cp 003h		;adea
	jr z,L_ADF6		;adec
	ld hl,0c02ch		;adee   ; apunta a el paso o la opcion de la pantalla de menu
	dec (hl)			;adf1
	call L_AE50		;adf2
	ret			;adf5
L_ADF6:
	ld a,0e0h		;adf6
	ld (0cc00h),a		;adf8   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;adfb
	jp L_B056		;adfe
L_AE01:
	ld a,080h		;ae01
	ld (0c004h),a		;ae03   ; guarda el temporizador de espera entre pasos
	jp L_B056		;ae06
L_AE09:
	ld hl,0c004h		;ae09   ; espera 0x80 cuadros y 0xC02A = 1
	dec (hl)			;ae0c
	ret nz			;ae0d
	ld a,001h		;ae0e
	ld (0c02ah),a		;ae10   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;ae13
L_AE14:
	ld a,(0c007h)		;ae14   ; teclas de la eleccion de rivales
	rra			;ae17   ; bit 0: arriba
	jr c,L_AE56		;ae18
	rra			;ae1a
	jr c,L_AE50		;ae1b
	rra			;ae1d
	jr c,L_AE5C		;ae1e
	rra			;ae20   ; bit 3: derecha
	jr c,L_AE62		;ae21
	rra			;ae23   ; bit 4: el boton
	jp c,L_AE68		;ae24
	jp L_AE2D		;ae27
L_AE2A:
	call 04116h		;ae2a   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_AE2D:
	ld a,(0c02dh)		;ae2d   ; pone los dos sprites del cursor en la casilla del rival elegido (tabla 0xAEA9)
	ld hl,0aea9h		;ae30
	call 04d07h		;ae33   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,l			;ae36
	ld (0cc01h),a		;ae37
	ld (0cc05h),a		;ae3a
	ld a,h			;ae3d
	ld (0cc00h),a		;ae3e   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;ae41
	ld a,038h		;ae44
	ld (0cc02h),a		;ae46
	ld a,03ch		;ae49
	ld (0cc06h),a		;ae4b
	or a			;ae4e
	ret			;ae4f
L_AE50:
	call L_AF4C		;ae50   ; mueve el cursor hacia abajo al siguiente rival que no se haya elegido ya
	jp L_AE2A		;ae53
L_AE56:
	call L_AF61		;ae56   ; hacia arriba al rival anterior libre
	jp L_AE2A		;ae59
L_AE5C:
	call L_AF76		;ae5c   ; izquierda: salta tres rivales
	jp L_AE2A		;ae5f
L_AE62:
	call L_AFA1		;ae62   ; derecha: salta tres rivales
	jp L_AE2A		;ae65
L_AE68:
	call L_AE85		;ae68   ; el boton: anota el rival en 0xC031 + 0xC02B, suma 1 a 0xC02B y marca (0xAF34)
	ld hl,0c02bh		;ae6b   ; apunta a variable de los pasos de las pantallas de menu
	ld a,(hl)			;ae6e
	push hl			;ae6f
	ld hl,0c031h		;ae70   ; apunta a el personaje que juega de rival 1
	call 0405ch		;ae73   ; suma_a_hl: HL = HL + A
	ld a,(0c02dh)		;ae76
	inc a			;ae79
	ld (hl),a			;ae7a
	pop hl			;ae7b
	inc (hl)			;ae7c
	call L_AF34		;ae7d   ; marca en 0xC221 el bit del rival elegido (tabla 0xAF44)
	call 0411bh		;ae80   ; pide_sonido_07: pide el sonido 0x07 (el del boton)
	scf			;ae83
	ret			;ae84
L_AE85:
	ld a,(0c02dh)		;ae85   ; tapa con el color 0xFF la cara del rival elegido (tabla 0xAE99)
	ld hl,0ae99h		;ae88
	call 04d07h		;ae8b   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld bc,03808h		;ae8e
	ld a,0ffh		;ae91
	ld d,000h		;ae93
	call 04fe5h		;ae95   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;ae98

; ----------------------------------------------------------------------
; DATOS resto_AE99: lo apuntan con el banco puesto p03:AE88 (0xAE99), p03:AE30
;   (0xAEA9); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:AE88, p03:AE30 (32 bytes)
;   0xae99..0xaeb9  (32 bytes)
DATA_resto_AE99:
	defb 078h,028h,090h,028h,0a8h,028h,078h,070h,090h,070h,0a8h,070h,078h,0b8h,090h,0b8h	; ae99  x(.(.(xp.p.px...
	defb 020h,078h,020h,090h,020h,0a8h,068h,078h,068h,090h,068h,0a8h,0b0h,078h,0b0h,090h	; aea9   x . .hxh.h..x..

; ----------------------------------------------------------------------
; DATOS tiles_AEB9: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p03:ADBA (59 bytes)
;   0xaeb9..0xaef4  (59 bytes)
DATA_tiles_AEB9:
	defb 028h,078h,073h,068h,061h,0feh,028h,090h,072h,077h,065h,078h,079h,063h,07ah,0feh	; aeb9  (xsha.(.rwexycz.
	defb 028h,0a8h,070h,07bh,07ch,062h,07dh,063h,0feh,070h,078h,07fh,080h,081h,082h,0feh	; aec9  (.p{|b}c.px.....
	defb 070h,090h,074h,07eh,068h,061h,0feh,070h,0a8h,060h,060h,065h,061h,0feh,0b8h,078h	; aed9  p.t~ha.p.``ea..x
	defb 075h,061h,076h,061h,0feh,0b8h,090h,068h,072h,06ch,0ffh	; aee9  uava...hrl.

; ======================================================================
; CODIGO 0xaef4..0xaf2e  (58 bytes)
; ======================================================================


L_AEF4:
	ld a,(0c02dh)		;aef4   ; muestra la cara del rival elegido a 48 de alto con un barrido (copia de 48 filas)
	ld hl,0662bh		;aef7
	call 04d07h		;aefa   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;aefd
	ld a,(0c02bh)		;aefe   ; lee variable de los pasos de las pantallas de menu
	dec a			;af01
	ld hl,0af2eh		;af02
	call 04d07h		;af05   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld d,l			;af08
	ld e,h			;af09
	pop hl			;af0a
	ld b,030h		;af0b
L_AF0D:
	push bc			;af0d
	push hl			;af0e
	push de			;af0f
	push hl			;af10
	ld bc,03001h		;af11
	ld a,001h		;af14
	call 05024h		;af16   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld b,008h		;af19
L_AF1B:
	push bc			;af1b
	ld b,0ffh		;af1c
L_AF1E:
	push bc			;af1e   ; retardo entre cuadros de la cara
	pop bc			;af1f
	djnz L_AF1E		;af20
	pop bc			;af22
	djnz L_AF1B		;af23
	pop hl			;af25   ; pasa a la fila siguiente de la cara (DE + 1) y a la columna (HL + 1)
	pop de			;af26
	inc de			;af27
	pop hl			;af28
	inc hl			;af29
	pop bc			;af2a
	djnz L_AF0D		;af2b
	ret			;af2d

; ----------------------------------------------------------------------
; DATOS resto_AF2E: lo apuntan con el banco puesto p03:AF02 (0xAF2E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:AF02 (6 bytes)
;   0xaf2e..0xaf34  (6 bytes)
DATA_resto_AF2E:
	defb 020h,018h,068h,018h,0b0h,018h	; af2e

; ======================================================================
; CODIGO 0xaf34..0xaf44  (16 bytes)
; ======================================================================


L_AF34:
	ld a,(0c02dh)		;af34   ; marca en 0xC221 el bit del rival elegido (tabla 0xAF44)
	ld hl,0af44h		;af37
	call 0405ch		;af3a   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;af3d
	ld hl,0c221h		;af3e
	or (hl)			;af41
	ld (hl),a			;af42
	ret			;af43

; ----------------------------------------------------------------------
; DATOS resto_AF44: lo apuntan con el banco puesto p03:AF37 (0xAF44), p03:AFCF
;   (0xAF44); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:AF37, p03:AFCF (8 bytes)
;   0xaf44..0xaf4c  (8 bytes)
DATA_resto_AF44:
	defb 001h,002h,004h,008h,010h,020h,040h,080h	; af44  ..... @.

; ======================================================================
; CODIGO 0xaf4c..0xafed  (161 bytes)
; ======================================================================


L_AF4C:
	ld hl,0c02dh		;af4c   ; mueve el cursor hacia abajo al siguiente rival que no se haya elegido ya
	ld a,(hl)			;af4f
	cp 007h		;af50
	jr z,L_AF5C		;af52
	inc (hl)			;af54
L_AF55:
	call L_AFCC		;af55   ; Z si el rival de 0xC02D ya esta elegido (comprueba su bit en 0xC221)
	ret z			;af58
	jp L_AF4C		;af59
L_AF5C:
	xor a			;af5c
	ld (hl),a			;af5d
	jp L_AF55		;af5e
L_AF61:
	ld hl,0c02dh		;af61   ; hacia arriba al rival anterior libre
	ld a,(hl)			;af64
	and a			;af65
	jr z,L_AF70		;af66
	dec (hl)			;af68
L_AF69:
	call L_AFCC		;af69   ; Z si el rival de 0xC02D ya esta elegido (comprueba su bit en 0xC221)
	ret z			;af6c
	jp L_AF61		;af6d
L_AF70:
	ld a,007h		;af70
	ld (hl),a			;af72
	jp L_AF69		;af73
L_AF76:
	ld hl,0c02dh		;af76   ; izquierda: salta tres rivales
	ld a,(hl)			;af79
	and a			;af7a
	jr z,L_AF8F		;af7b
	cp 001h		;af7d
	jr z,L_AF95		;af7f
	cp 002h		;af81
	jr z,L_AF9B		;af83
	sub 003h		;af85
	ld (hl),a			;af87
L_AF88:
	call L_AFCC		;af88   ; Z si el rival de 0xC02D ya esta elegido (comprueba su bit en 0xC221)
	ret z			;af8b
	jp L_AF76		;af8c
L_AF8F:
	ld a,006h		;af8f
	ld (hl),a			;af91
	jp L_AF88		;af92
L_AF95:
	ld a,007h		;af95
	ld (hl),a			;af97
	jp L_AF88		;af98
L_AF9B:
	ld a,005h		;af9b
	ld (hl),a			;af9d
	jp L_AF88		;af9e
L_AFA1:
	ld hl,0c02dh		;afa1   ; derecha: salta tres rivales
	ld a,(hl)			;afa4
	cp 006h		;afa5
	jr z,L_AFBB		;afa7
	cp 007h		;afa9
	jr z,L_AFC0		;afab
	cp 005h		;afad
	jr z,L_AFC6		;afaf
	add a,003h		;afb1
	ld (hl),a			;afb3
L_AFB4:
	call L_AFCC		;afb4   ; Z si el rival de 0xC02D ya esta elegido (comprueba su bit en 0xC221)
	ret z			;afb7
	jp L_AFA1		;afb8
L_AFBB:
	xor a			;afbb
	ld (hl),a			;afbc
	jp L_AFB4		;afbd
L_AFC0:
	ld a,001h		;afc0
	ld (hl),a			;afc2
	jp L_AFB4		;afc3
L_AFC6:
	ld a,002h		;afc6
	ld (hl),a			;afc8
	jp L_AFB4		;afc9
L_AFCC:
	ld a,(0c02dh)		;afcc   ; Z si el rival de 0xC02D ya esta elegido (comprueba su bit en 0xC221)
	ld hl,0af44h		;afcf
	call 0405ch		;afd2   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;afd5
	ld hl,0c221h		;afd6
	and (hl)			;afd9
	ret			;afda
L_AFDB:
	ld hl,00000h		;afdb   ; borra con 0 el rectangulo de la pantalla (212 filas)
	ld bc,000d4h		;afde
	ld d,000h		;afe1
	call 04fe5h		;afe3   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;afe6
L_AFE7:
	ld a,(0c02ch)		;afe7   ; PANTALLA DE LA TABLA DE RIVALES (7 contadores por rival): 0xC02C elige el paso
	call 04066h		;afea   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AFED: 4 destinos del despachador p00:4066 (call en p03:AFEA, el
;   indice en A): AFF5, B038, B03F, B04B; lo leen p03:AFEA (8 bytes)
;   0xafed..0xaff5  (8 bytes)
DATA_tabla_AFED:
	defw 0aff5h,0b038h,0b03fh,0b04bh	; afed  -> L_AFF5 L_B038 L_B03F L_B04B

; ======================================================================
; CODIGO 0xaff5..0xb118  (291 bytes)
; ======================================================================


L_AFF5:
	ld bc,00a07h		;aff5
	call 00047h		;aff8   ; BIOS WRTVDP - Writes data in the VDP-register
	call 04e76h		;affb   ; pantalla_off: apaga la pantalla
	ld b,060h		;affe   ; pone 0x04 en 0xCA20 (96 bytes: color de los sprites del cursor grande) y los dos del cursor (0xCA00 y 0xCA10)
	ld hl,0ca20h		;b000
	ld a,004h		;b003
L_B005:
	ld (hl),a			;b005
	inc hl			;b006
	djnz L_B005		;b007
	ld hl,0ca00h		;b009   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,009h		;b00c
	call 04382h		;b00e   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;b011
	ld a,002h		;b014
	call 04382h		;b016   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	call 057d3h		;b019   ; carga el fondo (0x57D3, 0x5834), los textos (0xB325), la imagen (0x5A22) y la lista 0xB118
	call 05834h		;b01c
	call L_B325		;b01f   ; escribe ocho textos de la tabla 0xB33B
	call 05a22h		;b022   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	ld hl,0b118h		;b025
	call 05363h		;b028   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	xor a			;b02b   ; dibuja los 7 rectangulos de las filas (0xB26F) y los valores (0xB28A)
	call L_B111		;b02c   ; pone la cara del rival A en su sitio (0x661D, posicion 0x0810)
	call L_B28A		;b02f   ; dibuja la barra de cada uno de los siete contadores del rival
	call 04e69h		;b032   ; pantalla_on: enciende la pantalla
	jp L_B056		;b035
L_B038:
	call L_B05B		;b038   ; teclas de la pantalla de la tabla: izquierda, derecha, arriba, abajo, botones
	ret nc			;b03b
	jp L_B056		;b03c
L_B03F:
	call L_B163		;b03f   ; teclas del cursor grande
	ret nc			;b042
	ld a,040h		;b043
	ld (0c004h),a		;b045   ; guarda el temporizador de espera entre pasos
	jp L_B056		;b048
L_B04B:
	ld hl,0c004h		;b04b   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;b04e
	ret nz			;b04f
	ld a,001h		;b050
	ld (0c02ah),a		;b052   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;b055
L_B056:
	ld hl,0c02ch		;b056   ; pasa al paso siguiente de la pantalla (0xC02C += 1)
	inc (hl)			;b059
	ret			;b05a
L_B05B:
	ld a,(0c007h)		;b05b   ; teclas de la pantalla de la tabla: izquierda, derecha, arriba, abajo, botones
	rrca			;b05e
	jr c,L_B0AB		;b05f
	rrca			;b061   ; bit 1: abajo
	jr c,L_B0CD		;b062
	rrca			;b064   ; bit 2: izquierda
	jp c,L_B0EC		;b065
	rrca			;b068
	jp c,L_B0F6		;b069
	rrca			;b06c
	jp c,L_B100		;b06d
	rrca			;b070   ; bit 5: la otra tecla
	jp c,L_B105		;b071
	jp L_B086		;b074
L_B077:
	ld (0c02dh),a		;b077   ; cambia de fila: redibuja la tabla de ese rival (0xB111, 0xB26F, 0xB28A) y suena
	call L_B111		;b07a   ; pone la cara del rival A en su sitio (0x661D, posicion 0x0810)
	call L_B26F		;b07d   ; dibuja siete rectangulos de 64 x 16 (posiciones de la tabla 0xB317)
	call L_B28A		;b080   ; dibuja la barra de cada uno de los siete contadores del rival
	call 04116h		;b083   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_B086:
	ld a,(0c02dh)		;b086   ; coloca los dos sprites del cursor en la fila de la tabla 0xB153
	add a,a			;b089
	ld hl,0b153h		;b08a
	call 0405ch		;b08d   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b090
	ld (0cc01h),a		;b091
	ld (0cc05h),a		;b094
	inc hl			;b097
	ld a,(hl)			;b098
	ld (0cc00h),a		;b099   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;b09c
	ld a,038h		;b09f
	ld (0cc02h),a		;b0a1
	ld a,03ch		;b0a4
	ld (0cc06h),a		;b0a6
	or a			;b0a9
	ret			;b0aa
L_B0AB:
	ld a,(0c02dh)		;b0ab   ; arriba: la fila baja una con vueltas entre 3 y 7
	sub 001h		;b0ae
	and 007h		;b0b0
	cp 007h		;b0b2
	jr z,L_B0BD		;b0b4
	cp 003h		;b0b6
	jr z,L_B0C5		;b0b8
	jp L_B077		;b0ba
L_B0BD:
	ld a,003h		;b0bd
	ld (0c02dh),a		;b0bf
	jp L_B077		;b0c2
L_B0C5:
	ld a,007h		;b0c5
	ld (0c02dh),a		;b0c7
	jp L_B077		;b0ca
L_B0CD:
	ld a,(0c02dh)		;b0cd   ; abajo: la fila sube una con vuelta a 4
	inc a			;b0d0
	and 007h		;b0d1
	and a			;b0d3
	jr z,L_B0DD		;b0d4
	cp 004h		;b0d6
	jr z,L_B0E5		;b0d8
	jp L_B077		;b0da
L_B0DD:
	ld a,004h		;b0dd
	ld (0c02dh),a		;b0df
	jp L_B077		;b0e2
L_B0E5:
	xor a			;b0e5
	ld (0c02dh),a		;b0e6
	jp L_B077		;b0e9
L_B0EC:
	ld a,(0c02dh)		;b0ec
	sub 004h		;b0ef
	and 007h		;b0f1
	jp L_B077		;b0f3
L_B0F6:
	ld a,(0c02dh)		;b0f6
	add a,004h		;b0f9
	and 007h		;b0fb
	jp L_B077		;b0fd
L_B100:
	call 0411bh		;b100   ; tecla de salir: suena el sonido 0x01 y acarreo
	scf			;b103
	ret			;b104
L_B105:
	ld a,040h		;b105   ; con el boton B pasa al paso 3 con 0x40 cuadros de espera
	ld (0c004h),a		;b107   ; guarda el temporizador de espera entre pasos
	ld a,003h		;b10a
	ld (0c02ch),a		;b10c   ; guarda el paso o la opcion de la pantalla de menu
	or a			;b10f
	ret			;b110
L_B111:
	ld de,00810h		;b111   ; pone la cara del rival A en su sitio (0x661D, posicion 0x0810)
	call 0661dh		;b114   ; dibuja_cara: dibuja la cara de 48 x 48 del personaje A
	ret			;b117

; ----------------------------------------------------------------------
; DATOS tiles_B118: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p03:B028 (59 bytes)
;   0xb118..0xb153  (59 bytes)
DATA_tiles_B118:
	defb 060h,00ch,073h,068h,061h,0feh,060h,01ch,072h,077h,065h,078h,079h,063h,07ah,0feh	; b118  `.sha.`.rwexycz.
	defb 060h,02ch,070h,07bh,07ch,062h,07dh,063h,0feh,060h,03ch,07fh,080h,081h,082h,0feh	; b128  `,p{|b}c.`<.....
	defb 0b0h,00ch,074h,07eh,068h,061h,0feh,0b0h,01ch,060h,060h,065h,061h,0feh,0b0h,02ch	; b138  ..t~ha...``ea..,
	defb 075h,061h,076h,061h,0feh,0b0h,03ch,068h,072h,06ch,0ffh	; b148  uava..<hrl.

; ----------------------------------------------------------------------
; DATOS resto_B153: lo apuntan con el banco puesto p03:B08A (0xB153); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:B08A (16 bytes)
;   0xb153..0xb163  (16 bytes)
DATA_resto_B153:
	defb 058h,00ch,058h,01ch,058h,02ch,058h,03ch,0a8h,00ch,0a8h,01ch,0a8h,02ch,0a8h,03ch	; b153  X.X.X,X<.....,.<

; ======================================================================
; CODIGO 0xb163..0xb317  (436 bytes)
; ======================================================================


L_B163:
	ld a,(0c007h)		;b163   ; teclas del cursor grande
	rrca			;b166   ; bit 0: arriba
	jp c,L_B1E8		;b167
	rrca			;b16a
	jp c,L_B20D		;b16b
	rrca			;b16e   ; bits 2 y 3: izquierda y derecha (0xB1DB)
	jp c,L_B1DB		;b16f
	rrca			;b172
	jp c,L_B1DB		;b173
	rrca			;b176   ; bit 4: el boton A
	jp c,L_B22F		;b177
	rrca			;b17a   ; bit 5: el boton B
	jp c,L_B23F		;b17b
	jp L_B184		;b17e
L_B181:
	call 04116h		;b181   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_B184:
	ld a,(0c02eh)		;b184   ; coloca los seis sprites del cursor: tres columnas de dos de 16 puntos
	ld hl,0b363h		;b187
	call 04d07h		;b18a   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,h			;b18d
	sub 001h		;b18e
	ld (0cc08h),a		;b190
	ld (0cc0ch),a		;b193
	ld (0cc10h),a		;b196
	add a,010h		;b199
	ld (0cc14h),a		;b19b
	ld (0cc18h),a		;b19e
	ld (0cc1ch),a		;b1a1
	ld a,l			;b1a4   ; la X de cada pareja
	ld (0cc09h),a		;b1a5
	ld (0cc15h),a		;b1a8
	add a,010h		;b1ab
	ld (0cc0dh),a		;b1ad
	ld (0cc19h),a		;b1b0
	add a,010h		;b1b3
	ld (0cc11h),a		;b1b5
	ld (0cc1dh),a		;b1b8
	ld a,020h		;b1bb   ; los tres patrones de cada sprite
	ld (0cc0ah),a		;b1bd
	add a,004h		;b1c0
	ld (0cc0eh),a		;b1c2
	add a,004h		;b1c5
	ld (0cc12h),a		;b1c7
	add a,004h		;b1ca
	ld (0cc16h),a		;b1cc
	add a,004h		;b1cf
	ld (0cc1ah),a		;b1d1
	add a,004h		;b1d4
	ld (0cc1eh),a		;b1d6
	or a			;b1d9
	ret			;b1da
L_B1DB:
	ld a,(0c02eh)		;b1db   ; cambia de columna sumando 4 modulo 8
	add a,004h		;b1de
	and 007h		;b1e0
	ld (0c02eh),a		;b1e2
	jp L_B181		;b1e5
L_B1E8:
	ld a,(0c02eh)		;b1e8   ; mueve a la izquierda dentro de cada mitad de la tabla
	sub 001h		;b1eb
	and 007h		;b1ed
	cp 007h		;b1ef
	jr z,L_B1FD		;b1f1
	cp 003h		;b1f3
	jr z,L_B205		;b1f5
	ld (0c02eh),a		;b1f7
	jp L_B181		;b1fa
L_B1FD:
	ld a,003h		;b1fd
	ld (0c02eh),a		;b1ff
	jp L_B181		;b202
L_B205:
	ld a,007h		;b205
	ld (0c02eh),a		;b207
	jp L_B181		;b20a
L_B20D:
	ld a,(0c02eh)		;b20d   ; mueve a la derecha dentro de cada mitad
	inc a			;b210
	and 007h		;b211
	and a			;b213
	jr z,L_B220		;b214
	cp 004h		;b216
	jr z,L_B228		;b218
	ld (0c02eh),a		;b21a
	jp L_B181		;b21d
L_B220:
	ld a,004h		;b220
	ld (0c02eh),a		;b222
	jp L_B181		;b225
L_B228:
	xor a			;b228
	ld (0c02eh),a		;b229
	jp L_B181		;b22c
L_B22F:
	ld a,(0c02eh)		;b22f   ; el boton A: si es la casilla 7 o 8, sale; si no, sube el contador de la casilla (0xB2A4)
	cp 007h		;b232
	jr z,L_B24F		;b234
	cp 008h		;b236
	jr z,L_B26A		;b238
	call L_B2A4		;b23a   ; sube un contador y lo redibuja: lee el valor (0xB2BC), lo sube (0xB30B) y repinta la barra
	or a			;b23d
	ret			;b23e
L_B23F:
	ld a,(0c02eh)		;b23f   ; el boton B: baja el contador de la casilla (0xB2AE)
	cp 007h		;b242
	jr z,L_B24F		;b244
	cp 008h		;b246
	jr z,L_B26A		;b248
	call L_B2AE		;b24a   ; baja un contador y lo redibuja
	or a			;b24d
	ret			;b24e
L_B24F:
	xor a			;b24f   ; sale con la casilla 7: pone a cero 0xC02E y 0xC02C y quita los sprites
	ld (0c02eh),a		;b250
	ld (0c02ch),a		;b253   ; guarda el paso o la opcion de la pantalla de menu
	ld a,0e0h		;b256
	ld (0cc08h),a		;b258
	ld (0cc0ch),a		;b25b
	ld (0cc10h),a		;b25e
	ld (0cc14h),a		;b261
	ld (0cc18h),a		;b264
	ld (0cc1ch),a		;b267
L_B26A:
	call 0411bh		;b26a   ; pide_sonido_07: pide el sonido 0x07 (el del boton)
	scf			;b26d
	ret			;b26e
L_B26F:
	ld b,007h		;b26f   ; dibuja siete rectangulos de 64 x 16 (posiciones de la tabla 0xB317)
	xor a			;b271
L_B272:
	push bc			;b272
	push af			;b273
	ld hl,0b317h		;b274
	call 04d07h		;b277   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld bc,04010h		;b27a
	ld a,0ffh		;b27d
	ld d,000h		;b27f
	call 04fe5h		;b281   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	pop af			;b284
	inc a			;b285
	pop bc			;b286
	djnz L_B272		;b287
	ret			;b289
L_B28A:
	ld b,007h		;b28a   ; dibuja la barra de cada uno de los siete contadores del rival
	ld a,000h		;b28c
L_B28E:
	push bc			;b28e
	push af			;b28f
	ld (0c02eh),a		;b290
	call L_B2BC		;b293   ; HL = 0xC040 + 8 x rival (0xC02D) + contador (0xC02E): lee su valor en A
	call L_B2D0		;b296   ; dibuja la barra del contador: ancho A, color 0x99, 16 de alto
	pop af			;b299
	inc a			;b29a
	pop bc			;b29b
	djnz L_B28E		;b29c
	ld a,000h		;b29e
	ld (0c02eh),a		;b2a0
	ret			;b2a3
L_B2A4:
	call L_B2BC		;b2a4   ; sube un contador y lo redibuja: lee el valor (0xB2BC), lo sube (0xB30B) y repinta la barra
	call L_B30B		;b2a7   ; sube el contador en HL si no ha llegado a 0x3F
	call L_B2D0		;b2aa   ; dibuja la barra del contador: ancho A, color 0x99, 16 de alto
	ret			;b2ad
L_B2AE:
	call L_B2BC		;b2ae   ; baja un contador y lo redibuja
	push hl			;b2b1
	push af			;b2b2
	call L_B2E6		;b2b3   ; pinta una marca en la barra (su sitio: A & 0x30 + A & 0x0F)
	pop af			;b2b6
	pop hl			;b2b7
	call L_B312		;b2b8   ; baja el contador en HL si no es cero
	ret			;b2bb
L_B2BC:
	ld a,(0c02dh)		;b2bc   ; HL = 0xC040 + 8 x rival (0xC02D) + contador (0xC02E): lee su valor en A
	rlca			;b2bf
	rlca			;b2c0
	rlca			;b2c1
	ld hl,0c040h		;b2c2   ; apunta a la tabla de estilo de los ocho rivales (8 bytes cada uno)
	call 0405ch		;b2c5   ; suma_a_hl: HL = HL + A
	ld a,(0c02eh)		;b2c8
	call 0405ch		;b2cb   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b2ce
	ret			;b2cf
L_B2D0:
	and a			;b2d0   ; dibuja la barra del contador: ancho A, color 0x99, 16 de alto
	ret z			;b2d1
	ld b,a			;b2d2
	ld a,(0c02eh)		;b2d3
	ld hl,0b317h		;b2d6
	call 04d07h		;b2d9   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld c,010h		;b2dc
	ld a,099h		;b2de
	ld d,000h		;b2e0
	call 04fe5h		;b2e2   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;b2e5
L_B2E6:
	and a			;b2e6   ; pinta una marca en la barra (su sitio: A & 0x30 + A & 0x0F)
	ret z			;b2e7
	push af			;b2e8
	and 030h		;b2e9
	ld b,a			;b2eb
	pop af			;b2ec
	and 00fh		;b2ed
	add a,b			;b2ef
	dec a			;b2f0
	ld b,a			;b2f1
	push bc			;b2f2
	ld a,(0c02eh)		;b2f3
	ld hl,0b317h		;b2f6
	call 04d07h		;b2f9   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop bc			;b2fc
	ld a,h			;b2fd
	add a,b			;b2fe
	ld h,a			;b2ff
	ld bc,00110h		;b300
	ld a,0ffh		;b303
	ld d,000h		;b305
	call 04fe5h		;b307   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;b30a
L_B30B:
	cp 03fh		;b30b   ; sube el contador en HL si no ha llegado a 0x3F
	ret z			;b30d
	ret nc			;b30e
	inc (hl)			;b30f
	ld a,(hl)			;b310
	ret			;b311
L_B312:
	and a			;b312   ; baja el contador en HL si no es cero
	ret z			;b313
	dec (hl)			;b314
	ld a,(hl)			;b315
	ret			;b316

; ----------------------------------------------------------------------
; DATOS resto_B317: lo apuntan con el banco puesto p03:B274 (0xB317), p03:B2D6
;   (0xB317), p03:B2F6 (0xB317); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p03:B274, p03:B2D6, p03:B2F6 (14 bytes)
;   0xb317..0xb325  (14 bytes)
DATA_resto_B317:
	defb 058h,038h,078h,038h,098h,038h,0b8h,038h,058h,0b8h,078h,0b8h,098h,0b8h	; b317  X8x8.8.8X.x...

; ======================================================================
; CODIGO 0xb325..0xb33b  (22 bytes)
; ======================================================================


L_B325:
	ld b,008h		;b325   ; escribe ocho textos de la tabla 0xB33B
	ld hl,0b33bh		;b327
	call L_B32E		;b32a
	ret			;b32d
L_B32E:
	push bc			;b32e
	ld d,(hl)			;b32f
	inc hl			;b330
	ld e,(hl)			;b331
	inc hl			;b332
	call 05acdh		;b333   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	inc hl			;b336
	pop bc			;b337
	djnz L_B32E		;b338
	ret			;b33a

; ----------------------------------------------------------------------
; DATOS resto_B33B: lo apuntan con el banco puesto p03:B327 (0xB33B), p03:B187
;   (0xB363); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:B327, p03:B187 (56 bytes)
;   0xb33b..0xb373  (56 bytes)
DATA_resto_B33B:
	defb 008h,058h,03dh,02bh,0ffh,008h,078h,085h,088h,0ffh,008h,098h,028h,019h,0ffh,008h	; b33b  .X=+..x.....(...
	defb 0b8h,05ch,00bh,0ffh,088h,058h,060h,073h,0ffh,088h,078h,054h,055h,0ffh,088h,098h	; b34b  .\...X`s..xTU...
	defb 07ah,089h,0ffh,0b0h,0b8h,022h,039h,0ffh,000h,050h,000h,070h,000h,090h,000h,0b0h	; b35b  z...."9..P.p....
	defb 080h,050h,080h,070h,080h,090h,0a8h,0b0h	; b36b  .P.p....

; ======================================================================
; CODIGO 0xb373..0xb379  (6 bytes)
; ======================================================================


L_B373:
	ld a,(0c02ch)		;b373   ; PANTALLA DE DOS OPCIONES (grabar, cargar): 0xC02C elige el paso por la tabla de 0xB377
	call 04066h		;b376   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B379: 2 destinos del despachador p00:4066 (call en p03:B376, el
;   indice en A): B37D, B3C2; lo leen p03:B376 (4 bytes)
;   0xb379..0xb37d  (4 bytes)
DATA_tabla_B379:
	defw 0b37dh,0b3c2h	; b379  -> L_B37D L_B3C2

; ======================================================================
; CODIGO 0xb37d..0xb3d7  (90 bytes)
; ======================================================================


L_B37D:
	ld bc,00a07h		;b37d
	call 00047h		;b380   ; BIOS WRTVDP - Writes data in the VDP-register
	call 04e76h		;b383   ; apaga, rellena una ventana y la marco, y escribe dos textos de la lista 0x59EA
	ld hl,0444ch		;b386
	ld bc,07038h		;b389
	ld a,0ffh		;b38c
	ld d,000h		;b38e
	call 04fe5h		;b390   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,00f08h		;b393
	ld de,04048h		;b396
	call 09d1ch		;b399   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,002h		;b39c
	ld hl,059eah		;b39e
	call L_B32E		;b3a1
	ld a,001h		;b3a4
	ld (0c211h),a		;b3a6   ; guarda el numero de opciones del cuadro
	ld (0c02bh),a		;b3a9   ; guarda variable de los pasos de las pantallas de menu
	call 04e69h		;b3ac   ; pantalla_on: enciende la pantalla
	ld hl,0ca00h		;b3af   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,009h		;b3b2
	call 04382h		;b3b4   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;b3b7
	ld a,002h		;b3ba
	call 04382h		;b3bc   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	jp L_B056		;b3bf
L_B3C2:
	call L_B51E		;b3c2   ; teclas de la pantalla de dos opciones (0xB51E): al elegir pone 0xC018 = opcion + 1
	ret nc			;b3c5
	call 04e50h		;b3c6   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	ld a,(0c02bh)		;b3c9   ; lee variable de los pasos de las pantallas de menu
	inc a			;b3cc
	ld (0c018h),a		;b3cd   ; guarda la opcion elegida en la pantalla de dos opciones (+1)
	ret			;b3d0
L_B3D1:
	ld a,(0c02ch)		;b3d1   ; PANTALLA DE CINCO OPCIONES: 0xC02C elige el paso por la tabla de 0xB3D5
	call 04066h		;b3d4   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B3D7: 2 destinos del despachador p00:4066 (call en p03:B3D4, el
;   indice en A): B3DB, B420; lo leen p03:B3D4 (4 bytes)
;   0xb3d7..0xb3db  (4 bytes)
DATA_tabla_B3D7:
	defw 0b3dbh,0b420h	; b3d7  -> L_B3DB L_B420

; ======================================================================
; CODIGO 0xb3db..0xb487  (172 bytes)
; ======================================================================


L_B3DB:
	ld bc,00a07h		;b3db
	call 00047h		;b3de   ; BIOS WRTVDP - Writes data in the VDP-register
	call 04e76h		;b3e1   ; apaga, rellena una ventana de 112 x 136 puntos y escribe cinco textos de la lista 0x59F5
	ld hl,04424h		;b3e4
	ld bc,07088h		;b3e7
	ld a,0ffh		;b3ea
	ld d,000h		;b3ec
	call 04fe5h		;b3ee   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,00f12h		;b3f1
	ld de,04020h		;b3f4
	call 09d1ch		;b3f7   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,005h		;b3fa
	ld hl,059f5h		;b3fc
	call L_B32E		;b3ff
	call 04e69h		;b402   ; pantalla_on: enciende la pantalla
	ld a,004h		;b405
	ld (0c211h),a		;b407   ; guarda el numero de opciones del cuadro
	ld (0c02bh),a		;b40a   ; guarda variable de los pasos de las pantallas de menu
	ld hl,0ca00h		;b40d   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,009h		;b410
	call 04382h		;b412   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;b415
	ld a,002h		;b418
	call 04382h		;b41a   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	jp L_B056		;b41d
L_B420:
	call L_B42F		;b420   ; teclas de la pantalla de cinco opciones (0xB42F): al elegir pone 0xC019 = opcion + 1
	ret nc			;b423
	call 04e50h		;b424   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	ld a,(0c02bh)		;b427   ; lee variable de los pasos de las pantallas de menu
	inc a			;b42a
	ld (0c019h),a		;b42b   ; guarda la opcion elegida en la pantalla de cinco opciones (+1)
	ret			;b42e
L_B42F:
	ld a,(0c007h)		;b42f   ; arriba y abajo mueven la opcion 0xC02B (0xC211 = la ultima), el boton elige
	rrca			;b432
	jr c,L_B442		;b433
	rrca			;b435
	jr c,L_B452		;b436
	rrca			;b438
	rrca			;b439
	rrca			;b43a
	jr nc,L_B463		;b43b
	call 0411bh		;b43d   ; pide_sonido_07: pide el sonido 0x07 (el del boton)
	scf			;b440
	ret			;b441
L_B442:
	ld hl,0c02bh		;b442   ; apunta a variable de los pasos de las pantallas de menu
	dec (hl)			;b445
	ld a,(hl)			;b446
	cp 0ffh		;b447
	jr nz,L_B460		;b449
	ld a,(0c211h)		;b44b   ; lee el numero de opciones del cuadro
	ld (hl),a			;b44e
	jp L_B460		;b44f
L_B452:
	ld a,(0c211h)		;b452   ; lee el numero de opciones del cuadro
	ld hl,0c02bh		;b455   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;b458
	cp (hl)			;b459
	jr nc,L_B460		;b45a
	xor a			;b45c
	ld (0c02bh),a		;b45d   ; guarda variable de los pasos de las pantallas de menu
L_B460:
	call 04116h		;b460   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_B463:
	ld a,(0c02bh)		;b463   ; coloca los dos sprites del cursor sobre la opcion (tabla 0xB487)
	ld hl,0b487h		;b466
	call 0405ch		;b469   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b46c
	ld (0cc00h),a		;b46d   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;b470
	ld a,038h		;b473
	ld (0cc02h),a		;b475
	ld a,03ch		;b478
	ld (0cc06h),a		;b47a
	ld a,04ch		;b47d
	ld (0cc01h),a		;b47f
	ld (0cc05h),a		;b482
	or a			;b485
	ret			;b486

; ----------------------------------------------------------------------
; DATOS resto_B487: lo apuntan con el banco puesto p03:B466 (0xB487); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:B466 (5 bytes)
;   0xb487..0xb48c  (5 bytes)
DATA_resto_B487:
	defb 034h,04ch,064h,07ch,094h	; b487

; ======================================================================
; CODIGO 0xb48c..0xb492  (6 bytes)
; ======================================================================


L_B48C:
	ld a,(0c02ch)		;b48c   ; PANTALLA DE GRABAR O CARGAR EN EL OTRO CARTUCHO: 0xC02C elige el paso
	call 04066h		;b48f   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B492: 3 destinos del despachador p00:4066 (call en p03:B48F, el
;   indice en A): B498, B4B5, B4CC; lo leen p03:B48F (6 bytes)
;   0xb492..0xb498  (6 bytes)
DATA_tabla_B492:
	defw 0b498h,0b4b5h,0b4cch	; b492  -> L_B498 L_B4B5 L_B4CC

; ======================================================================
; CODIGO 0xb498..0xb50a  (114 bytes)
; ======================================================================


L_B498:
	call 04e50h		;b498   ; carga la partida con 0x61FE; si 0xC0E8 dice que ha fallado escribe el mensaje de fallo (0xB4D7), si no el de acabado (0xB4E2)
	call 061feh		;b49b   ; carga_partida: carga la partida del otro cartucho
	ld a,(0c0e8h)		;b49e   ; lee 1 si ha fallado el cargar
	and a			;b4a1
	jr z,L_B4AA		;b4a2
	call L_B4D7		;b4a4   ; escribe el mensaje de 9 letras en 0xB50A
	jp L_B4AD		;b4a7
L_B4AA:
	call L_B4E2		;b4aa   ; escribe el mensaje de 14 letras en 0xB514
L_B4AD:
	ld a,080h		;b4ad
	ld (0c004h),a		;b4af   ; guarda el temporizador de espera entre pasos
	jp L_B056		;b4b2
L_B4B5:
	ld hl,0c004h		;b4b5   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;b4b8
	ret nz			;b4b9
	ld a,(0c0e8h)		;b4ba   ; lee 1 si ha fallado el cargar
	and a			;b4bd
	jr z,L_B4C6		;b4be
	ld a,002h		;b4c0
	ld (0c02ah),a		;b4c2   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;b4c5
L_B4C6:
	call 047bch		;b4c6
	jp L_B056		;b4c9
L_B4CC:
	ld a,(0c007h)		;b4cc   ; espera una tecla y pone 0xC02A = 1
	and a			;b4cf
	ret z			;b4d0
	ld a,001h		;b4d1
	ld (0c02ah),a		;b4d3   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;b4d6
L_B4D7:
	ld hl,0b50ah		;b4d7   ; escribe el mensaje de 9 letras en 0xB50A
	ld de,04060h		;b4da
	ld c,009h		;b4dd
	jp L_B4EA		;b4df
L_B4E2:
	ld hl,0b514h		;b4e2   ; escribe el mensaje de 14 letras en 0xB514
	ld de,04060h		;b4e5
	ld c,00eh		;b4e8
L_B4EA:
	push hl			;b4ea   ; dibuja la ventana con 0x9D1C y el texto de HL
	push de			;b4eb
	push bc			;b4ec
	ld hl,03454h		;b4ed
	ld bc,0a828h		;b4f0
	ld d,000h		;b4f3
	ld a,0ffh		;b4f5
	call 04fe5h		;b4f7   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,01606h		;b4fa
	ld de,03050h		;b4fd
	call 09d1ch		;b500   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	pop bc			;b503
	pop de			;b504
	pop hl			;b505
	call 05acfh		;b506
	ret			;b509

; ----------------------------------------------------------------------
; DATOS resto_B50A: lo apuntan con el banco puesto p03:B4D7 (0xB50A), p03:B4E2
;   (0xB514); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:B4D7, p03:B4E2 (20 bytes)
;   0xb50a..0xb51e  (20 bytes)
DATA_resto_B50A:
	defb 09ch,046h,08ah,0a7h,088h,0a4h,0a9h,0aah,0b9h,0ffh,09ch,046h,08ah,0a7h,088h,0a4h	; b50a  .F.........F....
	defb 045h,0a8h,0b9h,0ffh	; b51a

; ======================================================================
; CODIGO 0xb51e..0xb57e  (96 bytes)
; ======================================================================


L_B51E:
	ld a,(0c007h)		;b51e   ; teclas de una lista de opciones: arriba, abajo y el boton; 0xC02B es la opcion y 0xC211 la ultima
	rrca			;b521
	jr c,L_B537		;b522
	rrca			;b524
	jr c,L_B547		;b525
	rrca			;b527
	rrca			;b528
	rrca			;b529
	jr nc,L_B558		;b52a
	ld a,(0c02bh)		;b52c   ; lee variable de los pasos de las pantallas de menu
	and a			;b52f
	jr z,L_B535		;b530
	call 0411bh		;b532   ; pide_sonido_07: pide el sonido 0x07 (el del boton)
L_B535:
	scf			;b535
	ret			;b536
L_B537:
	ld hl,0c02bh		;b537   ; apunta a variable de los pasos de las pantallas de menu
	dec (hl)			;b53a
	ld a,(hl)			;b53b
	cp 0ffh		;b53c
	jr nz,L_B555		;b53e
	ld a,(0c211h)		;b540   ; lee el numero de opciones del cuadro
	ld (hl),a			;b543
	jp L_B555		;b544
L_B547:
	ld a,(0c211h)		;b547   ; lee el numero de opciones del cuadro
	ld hl,0c02bh		;b54a   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;b54d
	cp (hl)			;b54e
	jr nc,L_B555		;b54f
	xor a			;b551
	ld (0c02bh),a		;b552   ; guarda variable de los pasos de las pantallas de menu
L_B555:
	call 04116h		;b555   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_B558:
	ld a,04ch		;b558   ; coloca los sprites del cursor segun la tabla 0xB57E
	ld (0cc01h),a		;b55a
	ld (0cc05h),a		;b55d
	ld a,(0c02bh)		;b560   ; lee variable de los pasos de las pantallas de menu
	ld hl,0b57eh		;b563
	call 0405ch		;b566   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b569
	add a,002h		;b56a
	ld (0cc00h),a		;b56c   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;b56f
	ld a,038h		;b572
	ld (0cc02h),a		;b574
	ld a,03ch		;b577
	ld (0cc06h),a		;b579
	or a			;b57c
	ret			;b57d

; ----------------------------------------------------------------------
; DATOS resto_B57E: lo apuntan con el banco puesto p03:B563 (0xB57E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:B563 (2 bytes)
;   0xb57e..0xb580  (2 bytes)
DATA_resto_B57E:
	defb 058h,070h	; b57e

; ======================================================================
; CODIGO 0xb580..0xb5ce  (78 bytes)
; ======================================================================


L_B580:
	ld b,004h		;b580   ; cuenta cuantos jugadores tienen +0x81 (en espera al acabar la ronda) en 0xC22F
L_B582:
	ld a,004h		;b582   ; cuenta los jugadores en espera
	sub b			;b584
	ld hl,0d081h		;b585
	add a,a			;b588
	add a,a			;b589
	add a,h			;b58a
	ld h,a			;b58b
	ld a,(hl)			;b58c
	and a			;b58d
	jr nz,L_B593		;b58e
	djnz L_B582		;b590   ; uno menos
	ret			;b592
L_B593:
	push bc			;b593   ; uno mas en 0xC22F
	ld hl,0c22fh		;b594
	inc (hl)			;b597
	pop bc			;b598
	djnz L_B582		;b599
	ret			;b59b
paga_esperas:		; paga las esperas de una ronda sin ganador
	ld hl,0c0a0h		;b59c   ; PAGA LAS ESPERAS DE UNA RONDA SIN GANADOR: guarda los marcadores (0xC0A0 en 0xC280) y reparte segun cuantos estan en espera (0xC22F)
	ld de,0c280h		;b59f
	ld bc,0000ch		;b5a2
	ldir		;b5a5
	ld a,(0c207h)		;b5a7   ; lee el jugador al que le toca (0 = el humano)
	push af			;b5aa
	ld a,(0c22fh)		;b5ab
	and a			;b5ae
	jp z,L_B5C3		;b5af
	cp 004h		;b5b2
	jp z,L_B5C3		;b5b4
	dec a			;b5b7
	call L_B5D1		;b5b8   ; reparte los puntos entre los jugadores: los que estan en espera cobran y los otros pagan (tabla 0xB5CE)
	call 04b46h		;b5bb   ; dibuja_marcadores: dibuja los cuatro paneles de puntos de los jugadores
	pop af			;b5be
	ld (0c207h),a		;b5bf   ; guarda el jugador al que le toca (0 = el humano)
	ret			;b5c2
L_B5C3:
	call 05fcch		;b5c3   ; nadie o todos en espera: no se paga, solo se dibuja el marcador (0x5FCC, 0x4C33)
	call 04c33h		;b5c6
	pop af			;b5c9
	ld (0c207h),a		;b5ca   ; guarda el jugador al que le toca (0 = el humano)
	ret			;b5cd

; ----------------------------------------------------------------------
; DATOS resto_B5CE: lo apuntan con el banco puesto p03:B5D2 (0xB5CE), p03:B5E1
;   (0xB5CE); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:B5D2, p03:B5E1 (3 bytes)
;   0xb5ce..0xb5d1  (3 bytes)
DATA_resto_B5CE:
	defb 030h,015h,010h	; b5ce

; ======================================================================
; CODIGO 0xb5d1..0xb635  (100 bytes)
; ======================================================================


L_B5D1:
	push af			;b5d1   ; reparte los puntos entre los jugadores: los que estan en espera cobran y los otros pagan (tabla 0xB5CE)
	ld hl,0b5ceh		;b5d2
	call 0405ch		;b5d5   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b5d8
	ld (0c230h),a		;b5d9
	pop af			;b5dc
	ld b,a			;b5dd
	ld a,002h		;b5de
	sub b			;b5e0
	ld hl,0b5ceh		;b5e1
	call 0405ch		;b5e4   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b5e7
	ld (0c231h),a		;b5e8
	ld b,004h		;b5eb
L_B5ED:
	push bc			;b5ed
	ld a,004h		;b5ee
	sub b			;b5f0
	ld (0c207h),a		;b5f1   ; guarda el jugador al que le toca (0 = el humano)
	ld hl,0d081h		;b5f4
	add a,a			;b5f7
	add a,a			;b5f8
	add a,h			;b5f9
	ld h,a			;b5fa
	ld a,(hl)			;b5fb
	and a			;b5fc
	jr z,L_B613		;b5fd
	ld hl,0b635h		;b5ff
	ld a,(0c207h)		;b602   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;b605   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;b608
	xor a			;b609
	ld (hl),a			;b60a
	inc hl			;b60b
	ld a,(0c230h)		;b60c
	ld (hl),a			;b60f
	jp L_B625		;b610
L_B613:
	ld hl,0b635h		;b613
	ld a,(0c207h)		;b616   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;b619   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;b61c
	ld a,001h		;b61d
	ld (hl),a			;b61f
	inc hl			;b620
	ld a,(0c231h)		;b621
	ld (hl),a			;b624
L_B625:
	pop hl			;b625   ; apunta cuanto paga o cobra y lo suma con 0x4A17
	ld a,(hl)			;b626
	ld c,a			;b627
	inc hl			;b628
	ld a,(hl)			;b629
	ld e,a			;b62a
	inc hl			;b62b
	ld a,(hl)			;b62c
	ld d,a			;b62d
	call 04a17h		;b62e   ; suma el importe al marcador del jugador
	pop bc			;b631
	djnz L_B5ED		;b632
	ret			;b634

; ----------------------------------------------------------------------
; DATOS resto_B635: lo apuntan con el banco puesto p03:B5FF (0xB635), p03:B613
;   (0xB635), p00:5714 (0xB636); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p03:B5FF, p03:B613, p00:5714 (8 bytes)
;   0xb635..0xb63d  (8 bytes)
DATA_resto_B635:
	defb 08ch,0c2h,08fh,0c2h,092h,0c2h,095h,0c2h	; b635  ........	tabla de pagos de cada jugador (signo y cantidad)

; ======================================================================
; CODIGO 0xb63d..0xb7b5  (376 bytes)
; ======================================================================


fin_de_ronda:		; fin de la ronda: elige el aviso y quien reparte
	xor a			;b63d   ; FIN DE LA RONDA: mira por orden si hubo tsumo (0xC0C7), ron (0xC0C8), final por agotarse el muro (0xC0CF), cuatro kan (0xC0E5) o un yaku (0xC0E6); si no, 0xC0E4 = 1
	ld (0c0b8h),a		;b63e   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ld (0c0e4h),a		;b641
	ld hl,0c0c7h		;b644   ; apunta a 1 si la mano se anula por nueve fichas de punta y honor
	ld a,(hl)			;b647
	and a			;b648
	jp nz,L_B6F4		;b649
	inc hl			;b64c
	ld a,(hl)			;b64d
	and a			;b64e
	jp nz,L_B6BF		;b64f
	ld hl,0c0cfh		;b652   ; apunta a 1 si se anula por cuatro riichi
	ld a,(hl)			;b655
	and a			;b656
	jp nz,L_B734		;b657
	ld hl,0c0e5h		;b65a   ; apunta a 1 si se anula por cuatro kan
	ld a,(hl)			;b65d
	and a			;b65e
	jp nz,L_B724		;b65f
	ld hl,0c0e6h		;b662   ; apunta a 1 si se anula porque tres jugadores dicen ron
	ld a,(hl)			;b665
	and a			;b666
	jp nz,L_B74F		;b667
	ld a,001h		;b66a
	ld (0c0e4h),a		;b66c
	ld hl,06e5eh		;b66f   ; dibuja el rectangulo del texto de la ronda sin ganador y el aviso
	ld bc,02414h		;b672
	ld a,099h		;b675
	ld d,000h		;b677
	call 04fe5h		;b679   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06858h		;b67c
	ld hl,00604h		;b67f
	call 09d1ch		;b682   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,07060h		;b685
	ld hl,0b7b5h		;b688
	call 05acdh		;b68b   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call 06b4dh		;b68e   ; 0x6B4D: marca quien esta en espera; 0xB760 dibuja sus manos
	call L_B760		;b691   ; dibuja las manos de los tres rivales boca arriba (0xC214 = 1) los que estan en espera
	ld a,(0c0b7h)		;b694   ; lee el jugador que reparte (0-3)
	add a,a			;b697
	add a,a			;b698
	ld hl,0d081h		;b699
	add a,h			;b69c
	ld h,a			;b69d
	ld a,(hl)			;b69e
	and a			;b69f
	ret nz			;b6a0
	ld hl,0c0b2h		;b6a1   ; si el que reparte (0xC0B7) no esta en espera y es la primera vuelta (0xC0B2) pasa el turno de reparto: 0xC0B3 += 1 con vuelta a 0 en 4 y entonces 0xC0B2 += 1 (viento)
	ld a,(hl)			;b6a4
	and a			;b6a5
	ret nz			;b6a6
	inc hl			;b6a7
	inc (hl)			;b6a8
	ld a,(hl)			;b6a9
	cp 004h		;b6aa
	jr c,L_B6B6		;b6ac
	ld (hl),000h		;b6ae
	dec hl			;b6b0
	ld a,(hl)			;b6b1
	inc a			;b6b2
	and 003h		;b6b3
	ld (hl),a			;b6b5
L_B6B6:
	ld hl,0c0b7h		;b6b6   ; el que reparte pasa al siguiente (0xC0B7 + 1 modulo 4)
	ld a,(hl)			;b6b9
	inc a			;b6ba
	and 003h		;b6bb
	ld (hl),a			;b6bd
	ret			;b6be
L_B6BF:
	ld (hl),000h		;b6bf   ; fin por tsumo del humano o otro: dibuja el aviso y las manos
	call L_B79E		;b6c1   ; rectangulo de aviso de 68 x 20 con ventana
	ld de,06060h		;b6c4
	ld hl,0b7bfh		;b6c7
	call 05acdh		;b6ca   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
L_B6CD:
	call 08b3dh		;b6cd   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call 08cf5h		;b6d0   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call 09cc7h		;b6d3
	ld a,(0c207h)		;b6d6   ; lee el jugador al que le toca (0 = el humano)
	push af			;b6d9
	ld a,001h		;b6da
	ld (0c214h),a		;b6dc   ; guarda 1 si las manos se ven boca arriba
	ld (0c207h),a		;b6df   ; guarda el jugador al que le toca (0 = el humano)
	ld b,003h		;b6e2
L_B6E4:
	push bc			;b6e4
	call 08cf5h		;b6e5   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop bc			;b6e8
	ld hl,0c207h		;b6e9   ; apunta a el jugador al que le toca (0 = el humano)
	inc (hl)			;b6ec
	djnz L_B6E4		;b6ed
	pop af			;b6ef
	ld (0c207h),a		;b6f0   ; guarda el jugador al que le toca (0 = el humano)
	ret			;b6f3
L_B6F4:
	ld (hl),000h		;b6f4   ; fin por tsumo: rectangulo de texto y la mano del ganador boca arriba
	ld hl,04e5eh		;b6f6
	ld bc,06414h		;b6f9
	ld a,099h		;b6fc
	ld d,000h		;b6fe
	call 04fe5h		;b700   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,04858h		;b703
	ld hl,00e04h		;b706
	call 09d1ch		;b709   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,05060h		;b70c
	ld hl,0b7b8h		;b70f
	call 05acdh		;b712   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	ld a,001h		;b715
	ld (0c214h),a		;b717   ; guarda 1 si las manos se ven boca arriba
	call 08cf5h		;b71a   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	ld a,(0c209h)		;b71d   ; lee la ficha robada o tirada
	call 08b8ch		;b720   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ret			;b723
L_B724:
	ld (hl),000h		;b724   ; fin por cuatro kan: muestra el aviso (0xB7C9)
	call L_B787		;b726   ; rectangulo de aviso de 52 x 20 con ventana
	ld de,06860h		;b729
	ld hl,0b7c9h		;b72c
	call 05acdh		;b72f   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	jr L_B6CD		;b732
L_B734:
	ld (hl),000h		;b734   ; fin por ron: la ultima ficha y el aviso (0xB7C4)
	ld a,(0c207h)		;b736   ; lee el jugador al que le toca (0 = el humano)
	and a			;b739
	call nz,borra_cuadro_voz		;b73a   ; borra_cuadro_voz: borra el cuadro de la cara que habla
	call pone_ficha_normal		;b73d   ; pone_ficha_normal: pone la ficha de la mano en su sitio normal
	call L_B79E		;b740   ; rectangulo de aviso de 68 x 20 con ventana
	ld de,06060h		;b743
	ld hl,0b7c4h		;b746
	call 05acdh		;b749   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	jp L_B6CD		;b74c
L_B74F:
	ld (hl),000h		;b74f   ; fin por un yaku especial: muestra el aviso (0xB7CD)
	call L_B787		;b751   ; rectangulo de aviso de 52 x 20 con ventana
	ld de,06860h		;b754
	ld hl,0b7cdh		;b757
	call 05acdh		;b75a   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	jp L_B6CD		;b75d
L_B760:
	ld hl,0c207h		;b760   ; dibuja las manos de los tres rivales boca arriba (0xC214 = 1) los que estan en espera
	ld a,(hl)			;b763
	push af			;b764
	ld (hl),001h		;b765
	ld b,003h		;b767
L_B769:
	ld a,(hl)			;b769
	add a,a			;b76a
	add a,a			;b76b
	ld de,0d081h		;b76c
	add a,d			;b76f
	ld d,a			;b770
	ld a,(de)			;b771
	and a			;b772
	jr z,L_B781		;b773
	ld a,001h		;b775
	ld (0c214h),a		;b777   ; guarda 1 si las manos se ven boca arriba
	push hl			;b77a
	push bc			;b77b
	call 08cf5h		;b77c   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop bc			;b77f
	pop hl			;b780
L_B781:
	inc (hl)			;b781
	djnz L_B769		;b782
	pop af			;b784
	ld (hl),a			;b785
	ret			;b786
L_B787:
	ld hl,0665eh		;b787   ; rectangulo de aviso de 52 x 20 con ventana
	ld bc,03414h		;b78a
	ld a,099h		;b78d
	ld d,000h		;b78f
	call 04fe5h		;b791   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06058h		;b794
	ld hl,00804h		;b797
	call 09d1ch		;b79a   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ret			;b79d
L_B79E:
	ld hl,05e5eh		;b79e   ; rectangulo de aviso de 68 x 20 con ventana
	ld bc,04414h		;b7a1
	ld a,099h		;b7a4
	ld d,000h		;b7a6
	call 04fe5h		;b7a8   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,05858h		;b7ab
	ld hl,00a04h		;b7ae
	call 09d1ch		;b7b1   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ret			;b7b4

; ----------------------------------------------------------------------
; DATOS resto_B7B5: lo apuntan con el banco puesto p03:B688 (0xB7B5), p03:B70F
;   (0xB7B8), p03:B6C7 (0xB7BF), p03:B746 (0xB7C4), p03:B72C (0xB7C9),
;   p03:B757 (0xB7CD); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:B688, p03:B70F, p03:B6C7, p03:B746, p03:B72C,
;   p03:B757 (28 bytes)
;   0xb7b5..0xb7d1  (28 bytes)
DATA_resto_B7B5:
	defb 038h,02fh,0ffh,013h,023h,013h,031h,02ch,031h,0ffh,00eh,033h,03ah,02ah,0ffh,00eh	; b7b5  8/..#.1,1..3:*..
	defb 021h,03dh,02bh,0ffh,00eh,04ch,024h,0ffh,00dh,01bh,03ch,0ffh	; b7c5  !=+..L$...<.

; ======================================================================
; CODIGO 0xb7d1..0xb86e  (157 bytes)
; ======================================================================


L_B7D1:
	ld a,(0c1c1h)		;b7d1   ; mira si hay un caso de reparto especial: solo con 0xC1C1 entre 0x34 y 0x37 (primer ciclo) y si nadie lleva grupos (+0x0E a cero)
	sub 034h		;b7d4
	cp 004h		;b7d6
	ret nc			;b7d8
	ld hl,0d00eh		;b7d9
	ld de,00400h		;b7dc
	ld b,004h		;b7df
L_B7E1:
	ld a,(hl)			;b7e1
	and a			;b7e2
	ret nz			;b7e3
	add hl,de			;b7e4
	djnz L_B7E1		;b7e5
	ld hl,0c0d0h		;b7e7   ; quita las fichas repetidas de la mano que se toma para la cuenta (0xC0D0, 14 fichas)
	ld de,0c0d1h		;b7ea
	ld bc,0000dh		;b7ed
	ld (hl),000h		;b7f0
	ldir		;b7f2
	ld hl,0d000h		;b7f4   ; cuenta cuantas fichas distintas de punta (1, 9) o de honor tiene el jugador 0xC207 en su mano y la ficha 0xC209
	ld a,(0c207h)		;b7f7   ; lee el jugador al que le toca (0 = el humano)
	add a,a			;b7fa
	add a,a			;b7fb
	add a,h			;b7fc
	ld h,a			;b7fd
	push hl			;b7fe
	ld bc,00d00h		;b7ff
	ld de,0c0d0h		;b802
L_B805:
	call L_B87F		;b805   ; copia en DE la ficha de HL solo si es honor (>= 0x30) o numero 1 y 9
	inc hl			;b808
	djnz L_B805		;b809
	ld hl,0c209h		;b80b   ; apunta a la ficha robada o tirada
	call L_B87F		;b80e   ; copia en DE la ficha de HL solo si es honor (>= 0x30) o numero 1 y 9
	ld hl,0c0d0h		;b811
	ld c,000h		;b814
L_B816:
	push hl			;b816   ; mira cada ficha de la mano: si es de punta o de honor la anota y quita las iguales
	ld a,(hl)			;b817
	and a			;b818
	jr z,L_B82B		;b819
	ld (hl),000h		;b81b
	ld hl,0c0d0h		;b81d   ; recorre las 14 fichas de 0xC0D0
	ld b,00eh		;b820
L_B822:
	cp (hl)			;b822
	jr nz,L_B827		;b823
	ld (hl),000h		;b825
L_B827:
	inc hl			;b827
	djnz L_B822		;b828
	inc c			;b82a
L_B82B:
	ld hl,0c0d0h		;b82b
	ld b,00eh		;b82e
	xor a			;b830
L_B831:
	add a,(hl)			;b831   ; suma las que quedan
	inc hl			;b832
	djnz L_B831		;b833
	pop hl			;b835
	inc hl			;b836
	and a			;b837
	jr nz,L_B816		;b838
	ld hl,(0c0deh)		;b83a   ; compara con el limite del jugador
	ld de,00095h		;b83d
	add hl,de			;b840
	ld a,(hl)			;b841
	rrca			;b842
	rrca			;b843
	rrca			;b844
	rrca			;b845
	and 003h		;b846
	ld de,0b86eh		;b848
	call 04061h		;b84b   ; suma_a_de: DE = DE + A
	ld a,(de)			;b84e
	add a,a			;b84f
	sub 00bh		;b850
	neg		;b852
	ld b,a			;b854
	ld a,c			;b855
	cp b			;b856
	pop hl			;b857
	jr nc,$+26		;b858
L_B85A:
	ld a,c			;b85a
	cp 009h		;b85b
	ret c			;b85d
	ld a,001h		;b85e
	ld (0c0c7h),a		;b860   ; guarda 1 si la mano se anula por nueve fichas de punta y honor
	ld a,(0c207h)		;b863   ; lee el jugador al que le toca (0 = el humano)
	and a			;b866
	ret z			;b867
	ld a,002h		;b868
	ld (0c0b8h),a		;b86a   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ret			;b86d

; ----------------------------------------------------------------------
; DATOS resto_B86E: lo apuntan con el banco puesto p03:B848 (0xB86E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:B848 (4 bytes)
;   0xb86e..0xb872  (4 bytes)
DATA_resto_B86E:
	defb 000h,001h,001h,002h	; b86e

; ======================================================================
; CODIGO 0xb872..0xb93b  (201 bytes)
; ======================================================================


L_B872:
	ld a,l			;b872
	add a,080h		;b873
	ld l,a			;b875
	ld (hl),001h		;b876
	ld a,(0c207h)		;b878   ; lee el jugador al que le toca (0 = el humano)
	and a			;b87b
	ret nz			;b87c
	jr $-35		;b87d
L_B87F:
	ld a,(hl)			;b87f   ; copia en DE la ficha de HL solo si es honor (>= 0x30) o numero 1 y 9
	cp 030h		;b880
	jr nc,L_B88C		;b882
	and 00fh		;b884
	cp 009h		;b886
	jr z,L_B88C		;b888
	dec a			;b88a
	ret nz			;b88b
L_B88C:
	ld a,(hl)			;b88c
	ld (de),a			;b88d
	inc de			;b88e
	ret			;b88f
mira_cuatro_vientos:		; mira si los cuatro han tirado el mismo viento
	ld a,(0c1c1h)		;b890   ; en el primer cuarto de la ronda (0xC1C1 = 0x37) con +0x0E a cero en todas, mira si los cuatro jugadores han tirado el mismo viento (0xC0C9..): 0xC0C8 = 1 y 0xC0B8 = 2
	cp 037h		;b893
	ret nz			;b895
	ld hl,0d00eh		;b896
	ld de,00400h		;b899
	ld b,004h		;b89c
L_B89E:
	ld a,(hl)			;b89e   ; mira si algun jugador lleva grupos
	and a			;b89f
	ret nz			;b8a0
	add hl,de			;b8a1
	djnz L_B89E		;b8a2
	ld hl,0d010h		;b8a4   ; copia el primer descarte de cada jugador a 0xC0C9
	ld de,0c0c9h		;b8a7
	ld b,004h		;b8aa
L_B8AC:
	ld a,(hl)			;b8ac   ; solo si es un viento (0x31 a 0x34)
	sub 031h		;b8ad
	cp 004h		;b8af
	ld a,(hl)			;b8b1
	jr c,L_B8B5		;b8b2
	xor a			;b8b4
L_B8B5:
	ld (de),a			;b8b5   ; guarda y pasa al jugador siguiente
	inc de			;b8b6
	ld a,h			;b8b7
	add a,004h		;b8b8
	ld h,a			;b8ba
	djnz L_B8AC		;b8bb
	ld hl,0c0c9h		;b8bd   ; mira que los cuatro sean iguales
	ld b,003h		;b8c0
	ld a,(hl)			;b8c2
	and a			;b8c3
	ret z			;b8c4
L_B8C5:
	inc hl			;b8c5
	cp (hl)			;b8c6
	ret nz			;b8c7
	djnz L_B8C5		;b8c8
	ld a,001h		;b8ca
	ld (0c0c8h),a		;b8cc   ; guarda 1 si se anula por los cuatro vientos iguales
	inc a			;b8cf
	ld (0c0b8h),a		;b8d0   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ret			;b8d3
resultados_finales:		; pantalla de los resultados finales
	call L_AD03		;b8d4   ; PANTALLA DE RESULTADOS FINALES: pinta los jugadores (0xAD03) y sigue con 0xB8DB
	call L_B8DB		;b8d7   ; dibuja cuatro marcos de 40 x 24 (tabla 0xB93B), cada marco con su ventana; luego ordena (0xB9BA) y escribe los puntos (0xC24D, 0xC250, 0xC253, 0xC256)
	ret			;b8da
L_B8DB:
	call L_B943		;b8db   ; dibuja cuatro marcos de 40 x 24 (tabla 0xB93B), cada marco con su ventana; luego ordena (0xB9BA) y escribe los puntos (0xC24D, 0xC250, 0xC253, 0xC256)
	ld b,004h		;b8de
	xor a			;b8e0
L_B8E1:
	push bc			;b8e1
	push af			;b8e2
	ld hl,0b93bh		;b8e3
	call 04d07h		;b8e6   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;b8e9
	ld a,l			;b8ea
	add a,004h		;b8eb
	ld l,a			;b8ed
	ld a,h			;b8ee
	add a,004h		;b8ef
	ld h,a			;b8f1
	ld bc,02818h		;b8f2
	ld d,000h		;b8f5
	ld a,0ffh		;b8f7
	call 04fe5h		;b8f9   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	pop hl			;b8fc
	ex de,hl			;b8fd
	ld hl,00604h		;b8fe
	call 09d1ch		;b901   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	pop af			;b904
	inc a			;b905
	pop bc			;b906
	djnz L_B8E1		;b907
	call L_B9BA		;b909   ; ORDENA LOS JUGADORES POR PUNTOS: 0xB9D1 los lista, 0xBA18 elige el que gana, 0xB951 paga, 0xBAE3 y 0xBB28 pasan los puntos
	ld hl,0c24dh		;b90c
	ld de,078b0h		;b90f
	ld b,002h		;b912
	call 04c59h		;b914   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c250h		;b917
	ld de,0d088h		;b91a
	ld b,002h		;b91d
	call 04c59h		;b91f   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c253h		;b922
	ld de,07850h		;b925
	ld b,002h		;b928
	call 04c59h		;b92a   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c256h		;b92d
	ld de,02088h		;b930
	ld b,002h		;b933
	call 04c59h		;b935   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	jp L_BB68		;b938

; ----------------------------------------------------------------------
; DATOS resto_B93B: lo apuntan con el banco puesto p03:B8E3 (0xB93B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:B8E3 (8 bytes)
;   0xb93b..0xb943  (8 bytes)
DATA_resto_B93B:
	defb 0a4h,068h,07ch,0c0h,044h,068h,07ch,010h	; b93b  .h|.Dh|.

; ======================================================================
; CODIGO 0xb943..0xbba6  (611 bytes)
; ======================================================================


L_B943:
	ld hl,0c24bh		;b943   ; pone a cero 12 bytes de 0xC24B (los cuatro marcadores finales)
	ld de,0c24ch		;b946
	ld (hl),000h		;b949
	ld bc,0000bh		;b94b
	ldir		;b94e
	ret			;b950
L_B951:
	xor a			;b951   ; reparte los 3000 de ventaja a cada uno de los cuatro jugadores (0xC207 = 0 a 3)
	ld b,004h		;b952
L_B954:
	push bc			;b954
	push af			;b955
	ld (0c207h),a		;b956   ; guarda el jugador al que le toca (0 = el humano)
	call L_B96A		;b959   ; marcador final del jugador: tres bytes de 0xC0A0 + 3 x jugador
	ld c,001h		;b95c
	ld de,00300h		;b95e
	call 04a17h		;b961   ; suma_puntos_actual: suma al marcador del jugador 0xC207 el importe C (signo) y DE (BCD)
	pop af			;b964
	inc a			;b965
	pop bc			;b966
	djnz L_B954		;b967
	ret			;b969
L_B96A:
	ld a,(0c207h)		;b96a   ; marcador final del jugador: tres bytes de 0xC0A0 + 3 x jugador
	ld b,a			;b96d
	add a,a			;b96e
	add a,b			;b96f
	ld hl,0c0a0h		;b970
	call 0405ch		;b973   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b976   ; si el signo es cero (positivo)
	and a			;b977
	jr nz,L_B995		;b978
	inc hl			;b97a
	ld a,(hl)			;b97b   ; mira la parte baja
	and 00fh		;b97c
	and a			;b97e
	ret z			;b97f
	inc hl			;b980
	ld a,(hl)			;b981   ; y la alta, menor de 3 (menos de 30000)
	cp 003h		;b982
	jr nc,L_B98F		;b984
	dec hl			;b986
	ld a,(hl)			;b987
	and 0f0h		;b988
	ld (hl),a			;b98a
	dec hl			;b98b
	jp L_B9B2		;b98c
L_B98F:
	dec hl			;b98f
	ld a,(hl)			;b990
	and 0f0h		;b991
	ld (hl),a			;b993
	ret			;b994
L_B995:
	push hl			;b995   ; negativo: baja la parte media
	inc hl			;b996
	ld a,(hl)			;b997
	and 00fh		;b998
	and a			;b99a
	jp z,L_B9A2		;b99b
	ld a,(hl)			;b99e
	and 0f0h		;b99f
	ld (hl),a			;b9a1
L_B9A2:
	pop hl			;b9a2   ; si el marcador queda a cero lo deja a cero
	inc hl			;b9a3
	ld a,(hl)			;b9a4
	and a			;b9a5
	jr nz,L_B9B1		;b9a6   ; si el byte medio es distinto de cero se queda
	inc hl			;b9a8   ; mira el alto
	ld a,(hl)			;b9a9
	and a			;b9aa
	jr nz,L_B9B1		;b9ab
	dec hl			;b9ad   ; y si los dos son cero cambia el signo
	dec hl			;b9ae
	xor a			;b9af
	ld (hl),a			;b9b0
L_B9B1:
	ret			;b9b1
L_B9B2:
	ld c,000h		;b9b2
	ld de,00010h		;b9b4
	jp 04a17h		;b9b7   ; suma_puntos_actual: suma al marcador del jugador 0xC207 el importe C (signo) y DE (BCD)
L_B9BA:
	call L_B9D1		;b9ba   ; ORDENA LOS JUGADORES POR PUNTOS: 0xB9D1 los lista, 0xBA18 elige el que gana, 0xB951 paga, 0xBAE3 y 0xBB28 pasan los puntos
	call L_BA18		;b9bd   ; compara los marcadores de los jugadores de 0xC257 y deja en 0xC207 el mejor (empates por el siguiente byte)
	ld a,(0c207h)		;b9c0   ; lee el jugador al que le toca (0 = el humano)
	push af			;b9c3
	call L_B951		;b9c4   ; reparte los 3000 de ventaja a cada uno de los cuatro jugadores (0xC207 = 0 a 3)
	pop af			;b9c7
	ld (0c207h),a		;b9c8   ; guarda el jugador al que le toca (0 = el humano)
	call L_BAE3		;b9cb   ; copia el marcador de cada jugador al lugar de 0xC24B (3 bytes por jugador)
	jp L_BB28		;b9ce
L_B9D1:
	ld hl,0c257h		;b9d1   ; anota en 0xC257 los jugadores con 3 o mas de 0xC0A2 (hundred) a su cuenta
	ld de,0c258h		;b9d4
	ld (hl),0ffh		;b9d7
	ld bc,00005h		;b9d9
	ldir		;b9dc
	xor a			;b9de
	ld (0c200h),a		;b9df   ; guarda contador de trabajo de las fichas de la mano
	ld (0c207h),a		;b9e2   ; guarda el jugador al que le toca (0 = el humano)
	ld b,004h		;b9e5
L_B9E7:
	push bc			;b9e7
	ld a,(0c207h)		;b9e8   ; lee el jugador al que le toca (0 = el humano)
	ld b,a			;b9eb
	add a,a			;b9ec
	add a,b			;b9ed
	ld hl,0c0a0h		;b9ee
	call 0405ch		;b9f1   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;b9f4
	and a			;b9f5
	jr nz,L_BA10		;b9f6
	inc hl			;b9f8
	inc hl			;b9f9
	ld a,(hl)			;b9fa
	cp 003h		;b9fb
	jr c,L_BA10		;b9fd
	ld a,(0c200h)		;b9ff   ; lee contador de trabajo de las fichas de la mano
	ld hl,0c257h		;ba02
	call 0405ch		;ba05   ; suma_a_hl: HL = HL + A
	ld a,(0c207h)		;ba08   ; lee el jugador al que le toca (0 = el humano)
	ld (hl),a			;ba0b
	ld hl,0c200h		;ba0c   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;ba0f
L_BA10:
	ld hl,0c207h		;ba10   ; apunta a el jugador al que le toca (0 = el humano)
	inc (hl)			;ba13
	pop bc			;ba14
	djnz L_B9E7		;ba15
	ret			;ba17
L_BA18:
	ld a,(0c257h)		;ba18   ; compara los marcadores de los jugadores de 0xC257 y deja en 0xC207 el mejor (empates por el siguiente byte)
	call L_BAD0		;ba1b   ; A = el byte alto del marcador del jugador A
	ld b,a			;ba1e
	ld a,(0c258h)		;ba1f
	cp 0ffh		;ba22
	jr z,L_BA6F		;ba24
	call L_BAD0		;ba26   ; A = el byte alto del marcador del jugador A
	cp b			;ba29
	jr c,L_BA47		;ba2a
	jr z,L_BA84		;ba2c
L_BA2E:
	ld a,(0c258h)		;ba2e
	call L_BAD0		;ba31   ; A = el byte alto del marcador del jugador A
	ld b,a			;ba34
	ld a,(0c259h)		;ba35
	cp 0ffh		;ba38
	jr z,L_BA7D		;ba3a
	call L_BAD0		;ba3c   ; A = el byte alto del marcador del jugador A
	cp b			;ba3f
	jr c,L_BA7D		;ba40
	jr z,L_BA97		;ba42
	jp L_BA76		;ba44
L_BA47:
	ld a,(0c258h)		;ba47
	call L_BAD0		;ba4a   ; A = el byte alto del marcador del jugador A
	ld b,a			;ba4d
	ld a,(0c259h)		;ba4e
	cp 0ffh		;ba51
	jr z,L_BA6F		;ba53
	call L_BAD0		;ba55   ; A = el byte alto del marcador del jugador A
	cp b			;ba58
	jr c,L_BA6F		;ba59
	jr z,L_BAAA		;ba5b
L_BA5D:
	ld a,(0c259h)		;ba5d
	call L_BAD0		;ba60   ; A = el byte alto del marcador del jugador A
	ld b,a			;ba63
	ld a,(0c257h)		;ba64
	call L_BAD0		;ba67   ; A = el byte alto del marcador del jugador A
	cp b			;ba6a
	jr c,L_BA76		;ba6b
	jr z,L_BABD		;ba6d
L_BA6F:
	ld a,(0c257h)		;ba6f
	ld (0c207h),a		;ba72   ; guarda el jugador al que le toca (0 = el humano)
	ret			;ba75
L_BA76:
	ld a,(0c259h)		;ba76
	ld (0c207h),a		;ba79   ; guarda el jugador al que le toca (0 = el humano)
	ret			;ba7c
L_BA7D:
	ld a,(0c258h)		;ba7d
	ld (0c207h),a		;ba80   ; guarda el jugador al que le toca (0 = el humano)
	ret			;ba83
L_BA84:
	ld a,(0c257h)		;ba84
	call L_BAD6		;ba87   ; A = el byte bajo del marcador del jugador A
	ld b,a			;ba8a
	ld a,(0c258h)		;ba8b
	call L_BAD6		;ba8e   ; A = el byte bajo del marcador del jugador A
	cp b			;ba91
	jr c,L_BA47		;ba92
	jp L_BA2E		;ba94
L_BA97:
	ld a,(0c258h)		;ba97
	call L_BAD6		;ba9a   ; A = el byte bajo del marcador del jugador A
	ld b,a			;ba9d
	ld a,(0c259h)		;ba9e
	call L_BAD6		;baa1   ; A = el byte bajo del marcador del jugador A
	cp b			;baa4
	jr c,L_BA7D		;baa5
	jp L_BA76		;baa7
L_BAAA:
	ld a,(0c258h)		;baaa
	call L_BAD6		;baad   ; A = el byte bajo del marcador del jugador A
	ld b,a			;bab0
	ld a,(0c259h)		;bab1
	call L_BAD6		;bab4   ; A = el byte bajo del marcador del jugador A
	cp b			;bab7
	jr c,L_BA6F		;bab8
	jp L_BA5D		;baba
L_BABD:
	ld a,(0c259h)		;babd
	call L_BAD6		;bac0   ; A = el byte bajo del marcador del jugador A
	ld b,a			;bac3
	ld a,(0c257h)		;bac4
	call L_BAD6		;bac7   ; A = el byte bajo del marcador del jugador A
	cp b			;baca
	jr c,L_BA76		;bacb
	jp L_BA6F		;bacd
L_BAD0:
	ld hl,0c0a2h		;bad0   ; A = el byte alto del marcador del jugador A
	jp L_BAD9		;bad3
L_BAD6:
	ld hl,0c0a1h		;bad6   ; A = el byte bajo del marcador del jugador A
L_BAD9:
	push bc			;bad9
	ld b,a			;bada
	add a,a			;badb
	add a,b			;badc
	call 0405ch		;badd   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;bae0
	pop bc			;bae1
	ret			;bae2
L_BAE3:
	ld a,(0c207h)		;bae3   ; copia el marcador de cada jugador al lugar de 0xC24B (3 bytes por jugador)
	and a			;bae6
	jr z,L_BAF2		;bae7
	ld hl,0c0a0h		;bae9
	ld de,0c24bh		;baec
	call L_BB22		;baef
L_BAF2:
	ld a,(0c207h)		;baf2   ; lee el jugador al que le toca (0 = el humano)
	dec a			;baf5
	jr z,L_BB01		;baf6
	ld hl,0c0a3h		;baf8
	ld de,0c24eh		;bafb
	call L_BB22		;bafe
L_BB01:
	ld a,(0c207h)		;bb01   ; lee el jugador al que le toca (0 = el humano)
	cp 002h		;bb04
	jr z,L_BB11		;bb06
	ld hl,0c0a6h		;bb08
	ld de,0c251h		;bb0b
	call L_BB22		;bb0e
L_BB11:
	ld a,(0c207h)		;bb11   ; lee el jugador al que le toca (0 = el humano)
	cp 003h		;bb14
	jr z,L_BB21		;bb16
	ld hl,0c0a9h		;bb18
	ld de,0c254h		;bb1b
	call L_BB22		;bb1e
L_BB21:
	ret			;bb21
L_BB22:
	ld bc,00003h		;bb22
	ldir		;bb25
	ret			;bb27
L_BB28:
	xor a			;bb28   ; reparte el marcador del ganador entre los otros tres (4A20)
	ld b,004h		;bb29
L_BB2B:
	push bc			;bb2b
	push af			;bb2c
	ld hl,0c207h		;bb2d   ; apunta a el jugador al que le toca (0 = el humano)
	cp (hl)			;bb30
	jr z,L_BB53		;bb31
	ld b,a			;bb33
	add a,a			;bb34
	add a,b			;bb35
	ld hl,0c24bh		;bb36
	call 0405ch		;bb39   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;bb3c
	ld c,a			;bb3d
	inc hl			;bb3e
	ld a,(hl)			;bb3f
	ld e,a			;bb40
	inc hl			;bb41
	ld a,(hl)			;bb42
	ld d,a			;bb43
	ld a,(0c207h)		;bb44   ; lee el jugador al que le toca (0 = el humano)
	ld b,a			;bb47
	add a,a			;bb48
	add a,b			;bb49
	ld hl,0c24bh		;bb4a
	call 0405ch		;bb4d   ; suma_a_hl: HL = HL + A
	call 04a20h		;bb50
L_BB53:
	pop af			;bb53
	inc a			;bb54
	pop bc			;bb55
	djnz L_BB2B		;bb56
	ld a,(0c207h)		;bb58   ; lee el jugador al que le toca (0 = el humano)
	ld b,a			;bb5b
	add a,a			;bb5c
	add a,b			;bb5d
	ld hl,0c24bh		;bb5e
	call 0405ch		;bb61   ; suma_a_hl: HL = HL + A
	ld a,000h		;bb64
	ld (hl),a			;bb66
	ret			;bb67
L_BB68:
	ld hl,0c030h		;bb68   ; guarda los marcadores finales en la tabla de cada rival (0xC080 + 3 x rival)
	xor a			;bb6b
	ld (0c200h),a		;bb6c   ; guarda contador de trabajo de las fichas de la mano
	ld b,004h		;bb6f
L_BB71:
	push bc			;bb71
	push hl			;bb72
	ld a,(hl)			;bb73
	ld b,a			;bb74
	add a,a			;bb75
	add a,b			;bb76
	ld hl,0c080h		;bb77
	call 0405ch		;bb7a   ; suma_a_hl: HL = HL + A
	push hl			;bb7d
	ld a,(0c200h)		;bb7e   ; lee contador de trabajo de las fichas de la mano
	ld b,a			;bb81
	add a,a			;bb82
	add a,b			;bb83
	ld hl,0c24bh		;bb84
	call 0405ch		;bb87   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;bb8a
	ld c,a			;bb8b
	inc hl			;bb8c
	ld a,(hl)			;bb8d
	ld e,a			;bb8e
	inc hl			;bb8f
	ld a,(hl)			;bb90
	ld d,a			;bb91
	pop hl			;bb92
	call 04a20h		;bb93
	ld hl,0c200h		;bb96   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;bb99
	pop hl			;bb9a
	inc hl			;bb9b
	pop bc			;bb9c
	djnz L_BB71		;bb9d
	ret			;bb9f
L_BBA0:
	ld a,(0c02ch)		;bba0   ; PANTALLA DE GRABAR: si no hay otro cartucho (0xF0F5 = 0xFF) espera y sale; si no dibuja la ventana con la lista 0x5A17
	call 04066h		;bba3   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BBA6: 4 destinos del despachador p00:4066 (call en p03:BBA3, el
;   indice en A): BBAE, BBF8, BC0E, BC28; lo leen p03:BBA3 (8 bytes)
;   0xbba6..0xbbae  (8 bytes)
DATA_tabla_BBA6:
	defw 0bbaeh,0bbf8h,0bc0eh,0bc28h	; bba6  -> L_BBAE L_BBF8 L_BC0E L_BC28

; ======================================================================
; CODIGO 0xbbae..0xbc52  (164 bytes)
; ======================================================================


L_BBAE:
	ld a,(0f0f5h)		;bbae   ; lee la ranura del otro cartucho (la memoria de partidas)
	cp 0ffh		;bbb1
	jr nz,L_BBC0		;bbb3
	ld a,080h		;bbb5
	ld (0c004h),a		;bbb7   ; guarda el temporizador de espera entre pasos
	ld a,003h		;bbba
	ld (0c02ch),a		;bbbc   ; guarda el paso o la opcion de la pantalla de menu
	ret			;bbbf
L_BBC0:
	call 04e50h		;bbc0   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	ld bc,00a07h		;bbc3
	call 00047h		;bbc6   ; BIOS WRTVDP - Writes data in the VDP-register
	call 04e76h		;bbc9   ; pantalla_off: apaga la pantalla
	ld hl,0444ch		;bbcc
	ld bc,07038h		;bbcf
	ld a,0ffh		;bbd2
	ld d,000h		;bbd4
	call 04fe5h		;bbd6   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,00f08h		;bbd9
	ld de,04048h		;bbdc
	call 09d1ch		;bbdf   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld b,002h		;bbe2
	ld hl,05a17h		;bbe4
	call L_B32E		;bbe7
	ld a,001h		;bbea
	ld (0c211h),a		;bbec   ; guarda el numero de opciones del cuadro
	ld (0c02bh),a		;bbef   ; guarda variable de los pasos de las pantallas de menu
	call 04e69h		;bbf2   ; pantalla_on: enciende la pantalla
	jp L_B056		;bbf5
L_BBF8:
	call L_B51E		;bbf8   ; teclas de la pantalla de grabar (0xB51E)
	ret nc			;bbfb
	call 04e50h		;bbfc   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	ld hl,0c02bh		;bbff   ; apunta a variable de los pasos de las pantallas de menu
	dec (hl)			;bc02
	jr nz,L_BC0B		;bc03
	ld a,001h		;bc05
	ld (0c02ah),a		;bc07   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;bc0a
L_BC0B:
	jp L_B056		;bc0b
L_BC0E:
	call 061e6h		;bc0e   ; graba la partida (0x61E6) y escribe el mensaje de acabado (0xBC3A) o de fallo (0xBC46)
	ld a,(0c0e7h)		;bc11   ; lee 1 si ha fallado el grabar
	and a			;bc14
	jr z,L_BC1D		;bc15
	call L_BC3A		;bc17
	jp L_BC20		;bc1a
L_BC1D:
	call L_BC46		;bc1d
L_BC20:
	ld a,080h		;bc20
	ld (0c004h),a		;bc22   ; guarda el temporizador de espera entre pasos
	jp L_B056		;bc25
L_BC28:
	ld hl,0c004h		;bc28   ; espera 0x80 cuadros y pone 0xC02A a 1 o 2 segun haya fallado
	dec (hl)			;bc2b
	ret nz			;bc2c
	ld a,(0c0e7h)		;bc2d   ; lee 1 si ha fallado el grabar
	and a			;bc30
	ld a,001h		;bc31
	jr z,L_BC36		;bc33
	inc a			;bc35
L_BC36:
	ld (0c02ah),a		;bc36   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;bc39
L_BC3A:
	ld hl,0bc52h		;bc3a
	ld de,04060h		;bc3d
	ld c,009h		;bc40
	call L_B4EA		;bc42   ; dibuja la ventana con 0x9D1C y el texto de HL
	ret			;bc45
L_BC46:
	ld hl,0bc5ch		;bc46
	ld de,04060h		;bc49
	ld c,00eh		;bc4c
	call L_B4EA		;bc4e   ; dibuja la ventana con 0x9D1C y el texto de HL
	ret			;bc51

; ----------------------------------------------------------------------
; DATOS resto_BC52: lo apuntan con el banco puesto p03:BC3A (0xBC52), p03:BC46
;   (0xBC5C); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:BC3A, p03:BC46 (20 bytes)
;   0xbc52..0xbc66  (20 bytes)
DATA_resto_BC52:
	defb 0afh,046h,075h,0a7h,088h,0a4h,0a9h,0aah,0b9h,0ffh,0afh,046h,075h,0a7h,088h,0a4h	; bc52  .Fu........Fu...
	defb 045h,0a8h,0b9h,0ffh	; bc62

; ======================================================================
; CODIGO 0xbc66..0xbd33  (205 bytes)
; ======================================================================


L_BC66:
	ld hl,0bd33h		;bc66   ; PANTALLA DE LOS RESULTADOS POR RIVAL: dibuja la lista 0xBD33 y los nueve marcadores de 0xC082..0xC09A y las nueve cuentas de 0xC034..0xC03C
	call 05363h		;bc69   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	ld hl,0c082h		;bc6c
	ld de,08430h		;bc6f
	ld b,002h		;bc72
	call 04c59h		;bc74   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c085h		;bc77
	ld de,08440h		;bc7a
	ld b,002h		;bc7d
	call 04c59h		;bc7f   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c088h		;bc82
	ld de,08450h		;bc85
	ld b,002h		;bc88
	call 04c59h		;bc8a   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c08bh		;bc8d
	ld de,08460h		;bc90
	ld b,002h		;bc93
	call 04c59h		;bc95   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c08eh		;bc98
	ld de,08470h		;bc9b
	ld b,002h		;bc9e
	call 04c59h		;bca0   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c091h		;bca3
	ld de,08480h		;bca6
	ld b,002h		;bca9
	call 04c59h		;bcab   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c094h		;bcae
	ld de,08490h		;bcb1
	ld b,002h		;bcb4
	call 04c59h		;bcb6   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c097h		;bcb9
	ld de,084a0h		;bcbc
	ld b,002h		;bcbf
	call 04c59h		;bcc1   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c09ah		;bcc4
	ld de,084b0h		;bcc7
	ld b,002h		;bcca
	call 04c59h		;bccc   ; numero_con_signo: escribe el numero BCD de HL en DE con '-' si es negativo
	ld hl,0c034h		;bccf   ; apunta a el contador de partidas de la tabla de rivales
	ld de,0b430h		;bcd2
	ld b,001h		;bcd5
	call 04cc9h		;bcd7   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c035h		;bcda
	ld de,0b440h		;bcdd
	ld b,001h		;bce0
	call 04cc9h		;bce2   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c036h		;bce5
	ld de,0b450h		;bce8
	ld b,001h		;bceb
	call 04cc9h		;bced   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c037h		;bcf0
	ld de,0b460h		;bcf3
	ld b,001h		;bcf6
	call 04cc9h		;bcf8   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c038h		;bcfb
	ld de,0b470h		;bcfe
	ld b,001h		;bd01
	call 04cc9h		;bd03   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c039h		;bd06
	ld de,0b480h		;bd09
	ld b,001h		;bd0c
	call 04cc9h		;bd0e   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c03ah		;bd11
	ld de,0b490h		;bd14
	ld b,001h		;bd17
	call 04cc9h		;bd19   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c03bh		;bd1c
	ld de,0b4a0h		;bd1f
	ld b,001h		;bd22
	call 04cc9h		;bd24   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld hl,0c03ch		;bd27
	ld de,0b4b0h		;bd2a
	ld b,001h		;bd2d
	call 04cc9h		;bd2f   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ret			;bd32

; ----------------------------------------------------------------------
; DATOS tiles_BD33: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p03:BC69 (91 bytes)
;   0xbd33..0xbd8e  (91 bytes)
DATA_tiles_BD33:
	defb 040h,020h,024h,00bh,023h,00fh,0feh,078h,020h,029h,00dh,025h,028h,00fh,0feh,0a6h	; bd33  @ $.#..x ).%(...
	defb 020h,028h,025h,02bh,024h,00eh,0feh,030h,030h,026h,022h,00bh,02fh,00fh,028h,0feh	; bd43   (%+$..00&"./.(.
	defb 030h,040h,073h,068h,061h,0feh,030h,050h,072h,077h,065h,078h,079h,063h,07ah,0feh	; bd53  0@sha.0Prwexycz.
	defb 030h,060h,070h,07bh,07ch,062h,07dh,063h,0feh,030h,070h,07fh,080h,081h,082h,0feh	; bd63  0`p{|b}c.0p.....
	defb 030h,080h,074h,07eh,068h,061h,0feh,030h,090h,060h,060h,065h,061h,0feh,030h,0a0h	; bd73  0.t~ha.0.``ea.0.
	defb 075h,061h,076h,061h,0feh,030h,0b0h,068h,072h,06ch,0ffh	; bd83  uava.0.hrl.

; ======================================================================
; CODIGO 0xbd8e..0xbffe  (624 bytes)
; ======================================================================


adapta_estilo:		; adapta el estilo de los rivales a la mano ganadora
	ld hl,0d000h		;bd8e   ; ADAPTA EL ESTILO DE LA MAQUINA A LA MANO GANADORA: a la mano del jugador (humano o el que corresponda) le suma o resta (0xBFB4, 0xBFCA) en los siete contadores +0x90..+0x96 segun los yaku de 0xC2E0
	ld a,(0c0b1h)		;bd91   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;bd94
	ld a,(0c207h)		;bd95   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_BD9D		;bd98
	ld a,(0c20dh)		;bd9a   ; lee el jugador que responde a la ficha tirada
L_BD9D:
	add a,a			;bd9d
	add a,a			;bd9e
	add a,h			;bd9f
	ld h,a			;bda0
	ld (0cc80h),hl		;bda1
	ld de,00090h		;bda4
	ld a,002h		;bda7
	call sube_contador		;bda9   ; sube_contador: suma A al contador (con tope 0x3F)
	call L_BDC1		;bdac   ; con el yaku 0x01 en la lista: +0x90 sube 2
	call L_BDCF		;bdaf   ; si +0x40 es distinto de cero: +0x91 sube 4
	call L_BDE1		;bdb2   ; con el yaku 0x05: +0x92 sube 2; si no, con el 0x12: baja 6
	call L_BDFE		;bdb5   ; con el yaku 0x1B o 0x19: +0x93 sube 8
	call L_BE1B		;bdb8   ; con el yaku 0x0E o 0x0D: +0x94 sube 5
	call L_BE38		;bdbb   ; con el yaku 0x28 (el mas grande): +0x95 sube 0x20
	jp L_BE46		;bdbe
L_BDC1:
	ld b,001h		;bdc1   ; con el yaku 0x01 en la lista: +0x90 sube 2
	call L_BE55		;bdc3   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;bdc6
	ld de,00090h		;bdc7
	ld a,006h		;bdca
	jp sube_contador		;bdcc   ; sube_contador: suma A al contador (con tope 0x3F)
L_BDCF:
	ld hl,(0cc80h)		;bdcf   ; si +0x40 es distinto de cero: +0x91 sube 4
	ld de,00040h		;bdd2
	add hl,de			;bdd5
	ld a,(hl)			;bdd6
	and a			;bdd7
	ret z			;bdd8
	ld de,00091h		;bdd9
	ld a,004h		;bddc
	jp sube_contador		;bdde   ; sube_contador: suma A al contador (con tope 0x3F)
L_BDE1:
	ld b,005h		;bde1   ; con el yaku 0x05: +0x92 sube 2; si no, con el 0x12: baja 6
	call L_BE55		;bde3   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	jr nc,L_BDF0		;bde6
	ld de,00092h		;bde8
	ld a,002h		;bdeb
	jp sube_contador		;bded   ; sube_contador: suma A al contador (con tope 0x3F)
L_BDF0:
	ld b,012h		;bdf0
	call L_BE55		;bdf2   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;bdf5
	ld de,00092h		;bdf6
	ld a,006h		;bdf9
	jp baja_contador		;bdfb   ; baja_contador: resta A al contador
L_BDFE:
	ld b,01bh		;bdfe   ; con el yaku 0x1B o 0x19: +0x93 sube 8
	call L_BE55		;be00   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	jr nc,L_BE0D		;be03
	ld de,00093h		;be05
	ld a,008h		;be08
	jp sube_contador		;be0a   ; sube_contador: suma A al contador (con tope 0x3F)
L_BE0D:
	ld b,019h		;be0d
	call L_BE55		;be0f   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;be12
	ld de,00093h		;be13
	ld a,008h		;be16
	jp sube_contador		;be18   ; sube_contador: suma A al contador (con tope 0x3F)
L_BE1B:
	ld b,00eh		;be1b   ; con el yaku 0x0E o 0x0D: +0x94 sube 5
	call L_BE55		;be1d   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	jr nc,L_BE2A		;be20
	ld de,00094h		;be22
	ld a,005h		;be25
	jp sube_contador		;be27   ; sube_contador: suma A al contador (con tope 0x3F)
L_BE2A:
	ld b,00dh		;be2a
	call L_BE55		;be2c   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;be2f
	ld de,00094h		;be30
	ld a,005h		;be33
	jp sube_contador		;be35   ; sube_contador: suma A al contador (con tope 0x3F)
L_BE38:
	ld b,028h		;be38   ; con el yaku 0x28 (el mas grande): +0x95 sube 0x20
	call L_BE55		;be3a   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;be3d
	ld de,00095h		;be3e
	ld a,020h		;be41
	jp sube_contador		;be43   ; sube_contador: suma A al contador (con tope 0x3F)
L_BE46:
	ld de,00096h		;be46   ; +0x96 sube o baja segun quien haya ganado
	ld a,(0c0b1h)		;be49   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;be4c
	ld a,004h		;be4d
	jr z,L_BE52		;be4f
	add a,a			;be51
L_BE52:
	jp baja_contador		;be52   ; baja_contador: resta A al contador
L_BE55:
	ld hl,0c2e0h		;be55   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
L_BE58:
	ld a,(hl)			;be58   ; busca el yaku B en la lista de 0xC2E0
	or a			;be59
	ret z			;be5a
	cp b			;be5b
	jr z,L_BE62		;be5c
	inc hl			;be5e
	inc hl			;be5f
	jr L_BE58		;be60
L_BE62:
	scf			;be62
	ret			;be63
L_BE64:
	ld a,(0c0b1h)		;be64   ; igual para los demas jugadores cuando gana el humano: lo mismo con los otros tres (0xBE76)
	dec a			;be67
	jr z,L_BE88		;be68
	ld hl,0d000h		;be6a
	ld a,(0c207h)		;be6d   ; lee el jugador al que le toca (0 = el humano)
	and a			;be70
	ret z			;be71
	add a,a			;be72
	add a,a			;be73
	add a,h			;be74
	ld h,a			;be75
L_BE76:
	ld (0cc80h),hl		;be76   ; ajusta los siete contadores del jugador de 0xCC80
	call L_BE9F		;be79
	call L_BEAD		;be7c   ; si +0x40 (mano abierta) baja el contador +0x91
	call L_BEBF		;be7f
	call L_BEDC		;be82
	jp L_BEF9		;be85
L_BE88:
	ld hl,0d400h		;be88
	ld b,003h		;be8b
L_BE8D:
	push bc			;be8d   ; lo hace con los tres rivales
	call L_BE76		;be8e   ; ajusta los siete contadores del jugador de 0xCC80
	pop bc			;be91
	ld hl,(0cc80h)		;be92
	ld de,00400h		;be95
	add hl,de			;be98
	ld (0cc80h),hl		;be99
	djnz L_BE8D		;be9c
	ret			;be9e
L_BE9F:
	ld b,001h		;be9f
	call L_BE55		;bea1   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;bea4
	ld de,00090h		;bea5
	ld a,004h		;bea8
	jp L_BFC1		;beaa
L_BEAD:
	ld hl,(0cc80h)		;bead   ; si +0x40 (mano abierta) baja el contador +0x91
	ld de,00040h		;beb0
	add hl,de			;beb3
	ld a,(hl)			;beb4
	and a			;beb5
	ret z			;beb6
	ld de,00091h		;beb7
	ld a,00ch		;beba
	jp L_BFC1		;bebc
L_BEBF:
	ld b,01bh		;bebf
	call L_BE55		;bec1   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	jr nc,L_BECE		;bec4
	ld de,00093h		;bec6
	ld a,003h		;bec9
	jp L_BFC1		;becb
L_BECE:
	ld b,019h		;bece
	call L_BE55		;bed0   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;bed3
	ld de,00093h		;bed4
	ld a,003h		;bed7
	jp L_BFC1		;bed9
L_BEDC:
	ld b,00eh		;bedc
	call L_BE55		;bede   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	jr nc,L_BEEB		;bee1
	ld de,00094h		;bee3
	ld a,005h		;bee6
	jp sube_contador		;bee8   ; sube_contador: suma A al contador (con tope 0x3F)
L_BEEB:
	ld b,00dh		;beeb
	call L_BE55		;beed   ; busca el yaku B en la lista de 0xC2E0 (pares codigo y valor): acarreo si esta
	ret nc			;bef0
	ld de,00094h		;bef1
	ld a,005h		;bef4
	jp sube_contador		;bef6   ; sube_contador: suma A al contador (con tope 0x3F)
L_BEF9:
	ld de,00096h		;bef9
	ld a,(0c0b1h)		;befc   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;beff
	ld a,004h		;bf00
	jr z,L_BF06		;bf02
	add a,002h		;bf04
L_BF06:
	jp sube_contador		;bf06   ; sube_contador: suma A al contador (con tope 0x3F)
L_BF09:
	ld hl,0d400h		;bf09   ; ajusta el estilo de los tres rivales (+0x90..+0x96) segun lo que ha pasado en la ronda
	ld b,003h		;bf0c
L_BF0E:
	ld (0cc80h),hl		;bf0e   ; por cada rival ajusta con las seis reglas siguientes
	push bc			;bf11
	call L_BF32		;bf12
	call L_BF44		;bf15   ; si +0x40 sube +0x91
	call L_BF56		;bf18
	call L_BF68		;bf1b
	call L_BF7A		;bf1e   ; si +0x80 y un azar de 1 entre 4, baja +0x95
	call L_BF92		;bf21
	pop bc			;bf24
	ld hl,(0cc80h)		;bf25
	ld de,00400h		;bf28
	add hl,de			;bf2b
	ld (0cc80h),hl		;bf2c
	djnz L_BF0E		;bf2f
	ret			;bf31
L_BF32:
	ld hl,(0cc80h)		;bf32
	ld de,00034h		;bf35
	add hl,de			;bf38
	ld a,(hl)			;bf39
	and a			;bf3a
	ret z			;bf3b
	ld de,00090h		;bf3c
	ld a,002h		;bf3f
	jp baja_contador		;bf41   ; baja_contador: resta A al contador
L_BF44:
	ld hl,(0cc80h)		;bf44   ; si +0x40 sube +0x91
	ld de,00040h		;bf47
	add hl,de			;bf4a
	ld a,(hl)			;bf4b
	and a			;bf4c
	ret z			;bf4d
	ld de,00091h		;bf4e
	ld a,003h		;bf51
	jp L_BFC1		;bf53
L_BF56:
	ld hl,(0cc80h)		;bf56
	ld de,00072h		;bf59
	add hl,de			;bf5c
	ld a,(hl)			;bf5d
	and a			;bf5e
	ret z			;bf5f
	ld de,00093h		;bf60
	ld a,003h		;bf63
	jp baja_contador		;bf65   ; baja_contador: resta A al contador
L_BF68:
	ld hl,(0cc80h)		;bf68
	ld de,00070h		;bf6b
	add hl,de			;bf6e
	ld a,(hl)			;bf6f
	and a			;bf70
	ret z			;bf71
	ld de,00094h		;bf72
	ld a,002h		;bf75
	jp baja_contador		;bf77   ; baja_contador: resta A al contador
L_BF7A:
	ld hl,(0cc80h)		;bf7a   ; si +0x80 y un azar de 1 entre 4, baja +0x95
	ld de,00080h		;bf7d
	add hl,de			;bf80
	ld a,(hl)			;bf81
	and a			;bf82
	ret z			;bf83
	ld de,00095h		;bf84
	ld a,(0c003h)		;bf87   ; lee el contador de cuadros
	and 003h		;bf8a
	ret nz			;bf8c
	ld a,001h		;bf8d
	jp baja_contador		;bf8f   ; baja_contador: resta A al contador
L_BF92:
	ld de,00096h		;bf92
	ld a,002h		;bf95
	call baja_contador		;bf97   ; baja_contador: resta A al contador
	ld hl,(0cc80h)		;bf9a
	ld bc,00076h		;bf9d
	add hl,bc			;bfa0
	and a			;bfa1
	ret nz			;bfa2
	ld de,00096h		;bfa3
	ld a,002h		;bfa6
	jp baja_contador		;bfa8   ; baja_contador: resta A al contador
L_BFAB:
	ld b,a			;bfab
	ld a,(0c0b1h)		;bfac   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;bfaf
	jr nz,L_BFB3		;bfb0
	dec b			;bfb2
L_BFB3:
	ld a,b			;bfb3
sube_contador:		; suma A al contador (con tope 0x3F)
	ld hl,(0cc80h)		;bfb4   ; suma A al contador HL = 0xCC80 + DE, con tope 0x3F
	add hl,de			;bfb7
	add a,(hl)			;bfb8
	cp 040h		;bfb9
	jr c,L_BFBF		;bfbb
	ld a,03fh		;bfbd
L_BFBF:
	ld (hl),a			;bfbf
	ret			;bfc0
L_BFC1:
	ld b,a			;bfc1   ; resta A (menos uno si es el humano) al contador
	ld a,(0c0b1h)		;bfc2   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;bfc5
	jr nz,L_BFC9		;bfc6
	dec b			;bfc8
L_BFC9:
	ld a,b			;bfc9
baja_contador:		; resta A al contador
	ld hl,(0cc80h)		;bfca   ; resta A al contador (sin bajar de cero)
	add hl,de			;bfcd
	ld b,a			;bfce
	ld a,(hl)			;bfcf
	sub b			;bfd0
	jr nc,L_BFD4		;bfd1
	xor a			;bfd3
L_BFD4:
	ld (hl),a			;bfd4
	ret			;bfd5
copia_estilos:		; copia los estilos de los tres rivales a sus manos
	ld a,(0c031h)		;bfd6   ; AL EMPEZAR: copia a la mano de cada uno de los tres rivales (+0x90) sus siete contadores de estilo de la tabla 0xC040 (7 bytes por rival)
	ld hl,0d490h		;bfd9
	call L_BFEE		;bfdc
	ld a,(0c032h)		;bfdf   ; lee el personaje que juega de rival 2
	ld hl,0d890h		;bfe2
	call L_BFEE		;bfe5
	ld a,(0c033h)		;bfe8   ; lee el personaje que juega de rival 3
	ld hl,0dc90h		;bfeb
L_BFEE:
	dec a			;bfee
	add a,a			;bfef
	add a,a			;bff0
	add a,a			;bff1
	ld de,0c040h		;bff2   ; apunta a la tabla de estilo de los ocho rivales (8 bytes cada uno)
	call 04061h		;bff5   ; suma_a_de: DE = DE + A
	ld bc,00007h		;bff8
	ldir		;bffb
	ret			;bffd

; ----------------------------------------------------------------------
; DATOS relleno_ff: 2 bytes a 0xFF hasta el final del banco: relleno
;   0xbffe..0xc000  (2 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh	; bffe
