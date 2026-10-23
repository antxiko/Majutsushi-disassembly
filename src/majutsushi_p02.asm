; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS partida_8000: los 1 ultimos bytes de la instruccion de p01:7FFF (ED
;   B0), que empieza en el banco 1; lo leen p01:7FFF (1 bytes)
;   0x8000..0x8001  (1 bytes)
DATA_partida_8000:
	defb 0b0h	; 8000

; ======================================================================
; CODIGO 0x8001..0x8690  (1679 bytes)
; ======================================================================


L_8001:
	ld hl,0c631h		;8001   ; pasa los grupos de 0xC631 a la tabla de la mano (+0x1C0 cuenta, +0x200 de cuatro en cuatro) con el marcador 0x70
	ld de,0cc80h		;8004
	ld b,004h		;8007
L_8009:
	ld a,(hl)			;8009   ; copia en 0xCC80 con 0x70 de palo cada grupo que no es cero de 0xC631
	and a			;800a
	jr z,L_8011		;800b
	or 070h		;800d
	ld (de),a			;800f
	inc de			;8010
L_8011:
	inc hl			;8011
	djnz L_8009		;8012
	ld de,001c0h		;8014
	ld hl,(0c0deh)		;8017   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,de			;801a
	ld a,(hl)			;801b
	inc (hl)			;801c
	inc hl			;801d
	inc hl			;801e
	inc hl			;801f
	inc hl			;8020
	ld (hl),001h		;8021
	ld de,00200h		;8023
	ld hl,(0c0deh)		;8026   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,de			;8029
	add a,a			;802a
	add a,a			;802b
	call 0405ch		;802c   ; suma_a_hl: HL = HL + A
	ex de,hl			;802f
	ld hl,0cc80h		;8030
	ld bc,00004h		;8033
	ldir		;8036
	ret			;8038
prepara_descarte:		; elige la ficha que va a tirar la maquina
	ld hl,(0c0deh)		;8039   ; PREPARA EL DESCARTE de la maquina: mira las fichas sueltas de +0x1B0 y +0x1B1; elige con 0x8087 y 0x8100 la ficha que sobra (0xC209 = la tirada, C = la elegida) y acaba en 0x8066
	ld bc,001b0h		;803c
	add hl,bc			;803f
	ld a,(hl)			;8040
	and a			;8041
	jp z,L_8057		;8042
	ld b,(hl)			;8045
	inc hl			;8046
	ld c,(hl)			;8047
	ld a,b			;8048
	dec a			;8049
	jp z,posicion_de_la_elegida		;804a   ; posicion_de_la_elegida: busca en la mano la posicion de la ficha elegida (C) y la deja en 0xC20A
	call L_8087		;804d   ; elige la ficha que tirar entre las de la lista HL: busca primero entre las de otro palo (81E4) y entre las de honor (81A4)
	call L_8100		;8050   ; mira si la ficha C esta cerca de otras de la mano: entre las de +0x140, las de +0x150 (a menos de 3), las de la mano y las de +0x160
	call posicion_de_la_elegida		;8053   ; posicion_de_la_elegida: busca en la mano la posicion de la ficha elegida (C) y la deja en 0xC20A
	ret			;8056
L_8057:
	call L_820B		;8057   ; si no hay sueltas: 0x820B decide y elige por 0x8087/0x8100
	jr nz,posicion_de_la_elegida		;805a
	ld a,(hl)			;805c
	add a,a			;805d
	ld b,a			;805e
	inc hl			;805f
	call L_8087		;8060   ; elige la ficha que tirar entre las de la lista HL: busca primero entre las de otro palo (81E4) y entre las de honor (81A4)
	call L_8100		;8063   ; mira si la ficha C esta cerca de otras de la mano: entre las de +0x140, las de +0x150 (a menos de 3), las de la mano y las de +0x160
posicion_de_la_elegida:		; busca en la mano la posicion de la ficha elegida (C) y la deja en 0xC20A
	ld hl,(0c0deh)		;8066   ; busca en la mano la posicion de la ficha C elegida (entre las 13 menos 3 por cada grupo hecho) y la deja en 0xC20A
	ld de,0000eh		;8069
	add hl,de			;806c
	ld a,(hl)			;806d
	add a,a			;806e
	add a,(hl)			;806f
	ld b,a			;8070
	ld a,00dh		;8071
	sub b			;8073
	ld b,a			;8074
	ld a,c			;8075
	ld hl,(0c0deh)		;8076   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld d,000h		;8079
L_807B:
	cp (hl)			;807b
	jr z,L_8082		;807c
	inc hl			;807e
	inc d			;807f
	djnz L_807B		;8080
L_8082:
	ld a,d			;8082
	ld (0c20ah),a		;8083   ; guarda la posicion de la ficha en la mano
	ret			;8086
L_8087:
	push hl			;8087   ; elige la ficha que tirar entre las de la lista HL: busca primero entre las de otro palo (81E4) y entre las de honor (81A4)
	push bc			;8088
	call L_81E4		;8089   ; busca en la lista HL una ficha que no sea del palo de +0x72 ni honor
	pop bc			;808c
	pop hl			;808d
	ld c,a			;808e
	ret c			;808f
	ld d,h			;8090
	ld e,l			;8091
	push hl			;8092
	push de			;8093
	push bc			;8094
	call L_81A4		;8095   ; mira si hay fichas de honor o de viento entre las del palo y las compara con el viento (7035)
	pop bc			;8098
	pop de			;8099
	pop hl			;809a
	ld c,a			;809b
	ret c			;809c
L_809D:
	ld a,(hl)			;809d   ; recorre la mano buscando una ficha de numero 2 a 8
	and 00fh		;809e
	sub 002h		;80a0
	cp 007h		;80a2
	jr nc,L_80AA		;80a4
	inc hl			;80a6
	djnz L_809D		;80a7
	ex de,hl			;80a9   ; la encuentra o no: sigue con la otra lista
L_80AA:
	push hl			;80aa   ; mira el palo que lleva +0x72: si coincide con el de la ficha C, la guarda como elegida
	ld hl,(0c0deh)		;80ab   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00072h		;80ae
	add hl,de			;80b1
	ld a,(hl)			;80b2
	pop hl			;80b3
	ld d,a			;80b4
	and a			;80b5
	jr z,L_80FB		;80b6
	dec d			;80b8
	ld a,c			;80b9
	rrca			;80ba
	rrca			;80bb
	rrca			;80bc
	rrca			;80bd
	and 003h		;80be
	cp d			;80c0
	jr nz,L_80FB		;80c1
	ld hl,(0c0deh)		;80c3   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;80c6
	add hl,de			;80c9
	ld a,(hl)			;80ca
	and a			;80cb
	jr nz,L_80D9		;80cc
	ld hl,(0c0deh)		;80ce   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00093h		;80d1
	add hl,de			;80d4
	ld a,(hl)			;80d5
	cp 020h		;80d6
	ret c			;80d8
L_80D9:
	ld hl,(0c0deh)		;80d9   ; recorre la mano buscando la primera ficha que no sea honor ni del palo que lleva y que sea de 2 a 8
	ld b,00dh		;80dc
L_80DE:
	ld a,(hl)			;80de   ; busca una ficha de la mano sin los bits 6-7 que no sea del palo buscado
	and 0c0h		;80df
	jr nz,L_80F7		;80e1
	ld a,(hl)			;80e3   ; palo de la ficha (bits 4-5)
	rrca			;80e4
	rrca			;80e5
	rrca			;80e6
	rrca			;80e7
	and 003h		;80e8
	cp d			;80ea
	jr z,L_80F7		;80eb
	ld a,(hl)			;80ed   ; si ademas es de numero 2 a 8, es la elegida
	ld c,a			;80ee
	and 00fh		;80ef
	sub 002h		;80f1
	cp 007h		;80f3
	jr nc,L_80FB		;80f5
L_80F7:
	inc hl			;80f7
	djnz L_80DE		;80f8
	ret			;80fa
L_80FB:
	ld c,(hl)			;80fb   ; deja la ficha elegida en C y su direccion en 0xC64C
	ld (0c64ch),hl		;80fc
	ret			;80ff
L_8100:
	ld a,c			;8100   ; mira si la ficha C esta cerca de otras de la mano: entre las de +0x140, las de +0x150 (a menos de 3), las de la mano y las de +0x160
	cp 031h		;8101
	ret nc			;8103
	ld hl,(0c0deh)		;8104   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00140h		;8107
	add hl,de			;810a
	ld a,(hl)			;810b
	and a			;810c
	jr z,L_8126		;810d
	ld b,a			;810f
	inc hl			;8110
L_8111:
	ld a,(hl)			;8111   ; recorre los grupos de +0x140: la ficha C vale si es la anterior, la misma o dos mas
	dec a			;8112
	cp c			;8113
	jr z,L_817D		;8114
	inc a			;8116
	cp c			;8117
	jr z,L_817D		;8118
	inc a			;811a   ; o la siguiente de la siguiente
	inc a			;811b
	cp c			;811c
	jr z,L_817D		;811d
	inc a			;811f
	cp c			;8120
	jr z,L_817D		;8121
	inc hl			;8123
	djnz L_8111		;8124
L_8126:
	ld hl,(0c0deh)		;8126   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00150h		;8129
	add hl,de			;812c
	ld a,(hl)			;812d
	and a			;812e
	jr z,L_8140		;812f
	ld b,a			;8131
	inc hl			;8132
L_8133:
	ld a,(hl)			;8133
	sub c			;8134
	jr nc,L_8139		;8135
	neg		;8137
L_8139:
	cp 003h		;8139
	jr c,L_817D		;813b
	inc hl			;813d
	djnz L_8133		;813e
L_8140:
	ld hl,(0c0deh)		;8140   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld b,00eh		;8143
L_8145:
	ld a,b			;8145
	dec a			;8146
	jr nz,L_814C		;8147
	ld hl,0c209h		;8149   ; apunta a la ficha robada o tirada
L_814C:
	ld a,(hl)			;814c
	dec a			;814d
	cp c			;814e
	jr z,L_817D		;814f
	inc a			;8151
	inc a			;8152
	cp c			;8153
	jr z,L_817D		;8154
	inc hl			;8156
	djnz L_8145		;8157
	ld hl,(0c0deh)		;8159   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00160h		;815c
	add hl,de			;815f
	ld a,(hl)			;8160
	and a			;8161
	ret nz			;8162
	ld hl,(0c0deh)		;8163   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld b,00eh		;8166
	ld d,000h		;8168
L_816A:
	ld a,b			;816a
	dec a			;816b
	jr nz,L_8171		;816c
	ld hl,0c209h		;816e   ; apunta a la ficha robada o tirada
L_8171:
	ld a,(hl)			;8171
	cp c			;8172
	jr nz,L_8176		;8173
	inc d			;8175
L_8176:
	inc hl			;8176
	djnz L_816A		;8177
	ld a,d			;8179
	cp 002h		;817a
	ret nz			;817c
L_817D:
	ld hl,(0c64ch)		;817d   ; mira la ficha siguiente a la elegida; si no hay, la anterior
	inc hl			;8180
	ld a,(hl)			;8181
	and a			;8182
	jr nz,L_8187		;8183
	dec hl			;8185
	dec hl			;8186
L_8187:
	ld c,(hl)			;8187
	ret			;8188
fichas_de_grupos:		; A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	ld hl,(0c0deh)		;8189   ; A = fichas de grupos: suma +0x0E y las cuentas de +0x140, +0x150 y +0x160
	ld de,0000eh		;818c
	add hl,de			;818f
	ld a,(hl)			;8190
	ld hl,(0c0deh)		;8191   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00140h		;8194
	add hl,de			;8197
	add a,(hl)			;8198
	ld de,00010h		;8199
	add hl,de			;819c
	add a,(hl)			;819d
	ld de,00020h		;819e
	add hl,de			;81a1
	add a,(hl)			;81a2
	ret			;81a3
L_81A4:
	ld c,000h		;81a4   ; mira si hay fichas de honor o de viento entre las del palo y las compara con el viento (7035)
	ld de,0cc80h		;81a6
	push hl			;81a9
L_81AA:
	ld a,(hl)			;81aa   ; cuenta las fichas de honor (a partir de 0x31) y las copia a 0xCC80
	cp 031h		;81ab
	jr c,L_81B2		;81ad
	inc c			;81af
	ld (de),a			;81b0
	inc de			;81b1
L_81B2:
	inc hl			;81b2
	djnz L_81AA		;81b3
	pop hl			;81b5
	ld a,c			;81b6
	or a			;81b7
	ret z			;81b8
	ld a,(0c20dh)		;81b9   ; lee el jugador que responde a la ficha tirada
	push af			;81bc
	ld a,h			;81bd
	rrca			;81be
	rrca			;81bf
	and 003h		;81c0
	ld (0c20dh),a		;81c2   ; guarda el jugador que responde a la ficha tirada
	call 07035h		;81c5   ; pon_vientos_propios: pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	pop af			;81c8
	ld (0c20dh),a		;81c9   ; guarda el jugador que responde a la ficha tirada
	ld de,0cc80h		;81cc
	ld b,c			;81cf
L_81D0:
	ld hl,0cd90h		;81d0   ; apunta a los honores que cuentan de yaku (5)
	ld c,005h		;81d3
	ld a,(de)			;81d5
L_81D6:
	cp (hl)			;81d6   ; busca la ficha en los honores propios de 0xCD90
	jr z,L_81DF		;81d7
	inc hl			;81d9
	dec c			;81da
	jr nz,L_81D6		;81db
	scf			;81dd
	ret			;81de
L_81DF:
	inc de			;81df
	djnz L_81D0		;81e0
	scf			;81e2
	ret			;81e3
L_81E4:
	push hl			;81e4   ; busca en la lista HL una ficha que no sea del palo de +0x72 ni honor
	ld hl,(0c0deh)		;81e5   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00072h		;81e8
	add hl,de			;81eb
	ld a,(hl)			;81ec
	ld d,a			;81ed
	or a			;81ee
	pop hl			;81ef
	ret z			;81f0
	dec d			;81f1
L_81F2:
	ld a,(hl)			;81f2   ; busca una ficha que no es de honor ni del palo del jugador
	cp 031h		;81f3
	jr nc,L_8206		;81f5
	rrca			;81f7   ; palo de la ficha
	rrca			;81f8
	rrca			;81f9
	rrca			;81fa
	and 003h		;81fb
	cp d			;81fd
	jr z,L_8206		;81fe
	ld a,(hl)			;8200
	ld (0c64ch),hl		;8201
	scf			;8204
	ret			;8205
L_8206:
	inc hl			;8206
	djnz L_81F2		;8207
	or a			;8209
	ret			;820a
L_820B:
	ld hl,(0c0deh)		;820b   ; decide la ficha a tirar cuando no hay sueltas (con +0x160 vacio y 4 fichas de grupos): usa +0x150 (menos de 3), +0x1A0, +0x190, +0x180
	ld bc,00160h		;820e
	add hl,bc			;8211
	ld a,(hl)			;8212
	and a			;8213
	jr nz,L_825A		;8214
	call fichas_de_grupos		;8216   ; fichas_de_grupos: A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	cp 004h		;8219
	jr nz,L_825A		;821b
	ld hl,(0c0deh)		;821d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00150h		;8220
	add hl,bc			;8223
	ld a,(hl)			;8224
	and a			;8225
	ld b,a			;8226
	cp 003h		;8227
	jr nc,L_825A		;8229
	ld a,(0c20dh)		;822b   ; lee el jugador que responde a la ficha tirada
	push hl			;822e
	push bc			;822f
	push af			;8230
	ld a,h			;8231
	rrca			;8232
	rrca			;8233
	and 003h		;8234
	ld (0c20dh),a		;8236   ; guarda el jugador que responde a la ficha tirada
	call 07035h		;8239   ; pon_vientos_propios: pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	pop af			;823c
	pop bc			;823d
	pop de			;823e
	ld (0c20dh),a		;823f   ; guarda el jugador que responde a la ficha tirada
	inc de			;8242
L_8243:
	ld a,(de)			;8243
	ld hl,0cd90h		;8244   ; apunta a los honores que cuentan de yaku (5)
	ld c,005h		;8247
L_8249:
	cp (hl)			;8249   ; busca la ficha en la lista de honores propios (cinco)
	jr z,L_8257		;824a
	dec c			;824c
	jr nz,L_8249		;824d
	ex de,hl			;824f   ; la apunta como elegida (0xC64C)
	ld (0c64ch),hl		;8250
	ld c,(hl)			;8253
	or 001h		;8254
	ret			;8256
L_8257:
	inc de			;8257
	djnz L_8243		;8258
L_825A:
	ld bc,001a0h		;825a
	call L_8272		;825d   ; A = el primer byte de la lista HL + BC (para saber si esta vacia)
	jr nz,L_8270		;8260
	ld bc,00190h		;8262
	call L_8272		;8265   ; A = el primer byte de la lista HL + BC (para saber si esta vacia)
	jr nz,L_8270		;8268
	ld bc,00180h		;826a
	call L_8272		;826d   ; A = el primer byte de la lista HL + BC (para saber si esta vacia)
L_8270:
	xor a			;8270
	ret			;8271
L_8272:
	ld hl,(0c0deh)		;8272   ; A = el primer byte de la lista HL + BC (para saber si esta vacia)
	add hl,bc			;8275
	ld a,(hl)			;8276
	or a			;8277
	ret			;8278
respuesta_maquina:		; decide si la maquina responde a la ficha tirada (ron, kan, pon, chi)
	ld hl,0d060h		;8279   ; RESPUESTA A LA FICHA TIRADA: para el jugador de 0xC20D mira los bits de +0x60: bit 3 = ron (gana), 2 = kan, 0 = pon, 1 = chi
	call mano_del_que_responde		;827c   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;827f
	bit 3,a		;8280
	jp nz,L_8395		;8282
	ld hl,0d080h		;8285   ; si el jugador esta en espera (+0x80, +0x70, +0x75...) no hace caso
	call mano_del_que_responde		;8288   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;828b
	or a			;828c
	jr nz,L_82E6		;828d
	ld hl,0d070h		;828f
	call mano_del_que_responde		;8292   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8295
	or a			;8296
	jr nz,L_82E6		;8297
	ld a,(0c209h)		;8299   ; lee la ficha robada o tirada
	cp 031h		;829c
	jr nc,L_82C8		;829e
	call L_83A9		;82a0   ; comprueba si la ficha 0xC209 es del palo que lleva el jugador (+0x72) y si le interesa (+0x91)
	jr nz,L_82C8		;82a3
	ld hl,0d091h		;82a5
	call mano_del_que_responde		;82a8   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;82ab
	rrca			;82ac
	rrca			;82ad
	rrca			;82ae
	rrca			;82af
	and 00fh		;82b0
	jr z,L_82E6		;82b2
	cp 003h		;82b4
	jr nc,L_82C8		;82b6
	ld hl,0d040h		;82b8
	call mano_del_que_responde		;82bb   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;82be
	and a			;82bf
	jr nz,L_82C8		;82c0
	ld a,(0c003h)		;82c2   ; lee el contador de cuadros
	rra			;82c5
	jr c,L_82E6		;82c6
L_82C8:
	call conviene_llamar		;82c8   ; comprueba si le conviene (0x8441) y, si no, no responde
	jr c,L_82E6		;82cb
	ld hl,0d060h		;82cd
	call mano_del_que_responde		;82d0   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;82d3
	ld hl,0c213h		;82d4   ; apunta a la opcion elegida en el cuadro
	bit 2,a		;82d7
	jp nz,L_836C		;82d9
	bit 0,a		;82dc
	jr nz,L_832F		;82de
	bit 1,a		;82e0
	jr nz,L_82F4		;82e2
L_82E4:
	ld (hl),000h		;82e4
L_82E6:
	ld hl,0d060h		;82e6   ; quita de +0x60 el bit 0 y lo cambia por 0xCD9A
	call mano_del_que_responde		;82e9   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(0cd9ah)		;82ec
	xor (hl)			;82ef
	ld (hl),a			;82f0
	res 0,(hl)		;82f1
	ret			;82f3
L_82F4:
	push hl			;82f4   ; chi: lo hace si no esta en espera (+0x75), y la ficha (0xC209) no esta ya en su mano; pide el sonido del chi (0x4158, 0x12)
	ld hl,0d075h		;82f5
	call mano_del_que_responde		;82f8   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;82fb
	and a			;82fc
	pop hl			;82fd
	jr nz,L_82E4		;82fe
	push hl			;8300
	ld hl,0d000h		;8301
	call mano_del_que_responde		;8304   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld b,00dh		;8307
	ld a,(0c209h)		;8309   ; lee la ficha robada o tirada
L_830C:
	cp (hl)			;830c
	jr z,L_832C		;830d
	inc hl			;830f
	djnz L_830C		;8310
	pop hl			;8312
	ld (hl),002h		;8313
	ld a,003h		;8315
	ld (0c215h),a		;8317   ; guarda el paso de la respuesta
	call 0a528h		;831a   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	ld a,(0c20dh)		;831d   ; lee el jugador que responde a la ficha tirada
	ld b,001h		;8320
	call 0a6beh		;8322   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call L_89C8		;8325   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 04158h		;8328   ; voz_chi: dice CHI: la voz 0x12 con el tono del personaje de 0xC20D
	ret			;832b
L_832C:
	pop hl			;832c
	jr L_82E4		;832d
L_832F:
	ld a,(0c209h)		;832f   ; pon: 0xC215 = 1 y sonido del pon (0x414D, 0x11)
	cp 031h		;8332
	jr nc,L_8354		;8334
	push hl			;8336
	ld hl,0d072h		;8337
	call mano_del_que_responde		;833a   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;833d
	and a			;833e
	pop hl			;833f
	jr nz,L_8354		;8340
	push hl			;8342
	ld hl,0d075h		;8343
	call mano_del_que_responde		;8346   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8349
	and a			;834a
	pop hl			;834b
	jr nz,L_8354		;834c
	ld a,(0c003h)		;834e   ; lee el contador de cuadros
	rra			;8351
	jr c,L_82E4		;8352
L_8354:
	ld a,001h		;8354
	ld (hl),a			;8356
	ld (0c215h),a		;8357   ; guarda el paso de la respuesta
	call 0a528h		;835a   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	ld a,(0c20dh)		;835d   ; lee el jugador que responde a la ficha tirada
	ld b,000h		;8360
	call 0a6beh		;8362   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call L_89C8		;8365   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 0414dh		;8368   ; voz_pon: dice PON: la voz 0x11 con el tono del personaje de 0xC20D
	ret			;836b
L_836C:
	push hl			;836c   ; kan: pone +0x60 = 3 y 0xC215 = 1 y sonido del kan (0x4163, 0x13)
	ld hl,0d040h		;836d
	call mano_del_que_responde		;8370   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8373
	and a			;8374
	pop hl			;8375
	jp z,L_82E4		;8376
	ld (hl),003h		;8379
	ld a,001h		;837b
	ld (0c215h),a		;837d   ; guarda el paso de la respuesta
	call 0a528h		;8380   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	call L_9672		;8383   ; una ficha mas del muro sacada de la parte de atras (0xC210 += 1), con su dibujo
	ld a,(0c20dh)		;8386   ; lee el jugador que responde a la ficha tirada
	ld b,002h		;8389
	call 0a6beh		;838b   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call L_89C8		;838e   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 04163h		;8391   ; voz_kan: dice KAN: la voz 0x13 con el tono del personaje de 0xC20D
	ret			;8394
L_8395:
	ld a,002h		;8395   ; ron: 0xC0B1 = 2 y sonido del ron (0x416E, 0x14)
	ld (0c0b1h),a		;8397   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	call 0a528h		;839a   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	ld a,(0c20dh)		;839d   ; lee el jugador que responde a la ficha tirada
	ld b,003h		;83a0
	call 0a6beh		;83a2   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call 0416eh		;83a5   ; voz_ron: dice RON: la voz 0x14 con el tono del personaje de 0xC20D
	ret			;83a8
L_83A9:
	ld hl,0d072h		;83a9   ; comprueba si la ficha 0xC209 es del palo que lleva el jugador (+0x72) y si le interesa (+0x91)
	call mano_del_que_responde		;83ac   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;83af
	and a			;83b0
	jr z,L_83DD		;83b1
	dec a			;83b3
	ld b,a			;83b4
	ld a,(0c209h)		;83b5   ; lee la ficha robada o tirada
	cp 031h		;83b8
	jr nc,L_83DA		;83ba
	rrca			;83bc
	rrca			;83bd
	rrca			;83be
	rrca			;83bf
	and 003h		;83c0
	cp b			;83c2
	jr nz,L_83DD		;83c3
	ld hl,0d091h		;83c5
	call mano_del_que_responde		;83c8   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;83cb
	cp 030h		;83cc
	jr nc,L_83DA		;83ce
	cp 010h		;83d0
	jr c,L_83DD		;83d2
	ld a,(0c003h)		;83d4   ; lee el contador de cuadros
	rra			;83d7
	jr c,L_83DD		;83d8
L_83DA:
	or 001h		;83da
	ret			;83dc
L_83DD:
	xor a			;83dd
	ret			;83de
L_83DF:
	ld a,(0c209h)		;83df   ; mira si la ficha tirada es un honor o de viento (a partir de 0x31) y si es el viento de la ronda o el suyo
	cp 031h		;83e2
	ret c			;83e4
	push af			;83e5
	call 07035h		;83e6   ; pon_vientos_propios: pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	pop af			;83e9
	ld b,005h		;83ea
	ld hl,0cd90h		;83ec   ; apunta a los honores que cuentan de yaku (5)
L_83EF:
	cp (hl)			;83ef
	jr z,L_83F8		;83f0
	inc de			;83f2
	inc hl			;83f3
	djnz L_83EF		;83f4
L_83F6:
	scf			;83f6
	ret			;83f7
L_83F8:
	ld a,(0c0b7h)		;83f8   ; lee el jugador que reparte (0-3)
	ld b,a			;83fb
	ld a,(0c20dh)		;83fc   ; lee el jugador que responde a la ficha tirada
	cp b			;83ff
	jr z,L_843F		;8400
	ld a,(0c0b5h)		;8402   ; lee las barras de honba (BCD)
	sub 003h		;8405
	cp 002h		;8407
	jr c,L_843F		;8409
	ld hl,0d091h		;840b
	call mano_del_que_responde		;840e   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8411
	rrca			;8412
	rrca			;8413
	rrca			;8414
	rrca			;8415
	and 00fh		;8416
	jr z,L_83F6		;8418
	dec a			;841a
	jr nz,L_843F		;841b
	ld a,(0c0b2h)		;841d   ; lee el viento de la ronda (0 este)
	and a			;8420
	jr nz,L_843F		;8421
	ld hl,0d00fh		;8423
	ld a,(0c209h)		;8426   ; lee la ficha robada o tirada
	ld b,004h		;8429
L_842B:
	push hl			;842b
	ld c,(hl)			;842c
	inc hl			;842d
L_842E:
	cp (hl)			;842e   ; busca la ficha de 0xC209 entre los descartes de los otros jugadores
	jr z,L_843E		;842f
	inc hl			;8431
	dec c			;8432
	jr nz,L_842E		;8433
	pop hl			;8435
	ld de,00400h		;8436   ; pasa a la mano del jugador siguiente
	add hl,de			;8439
	djnz L_842B		;843a
	scf			;843c
	ret			;843d
L_843E:
	pop hl			;843e
L_843F:
	or a			;843f
	ret			;8440
conviene_llamar:		; decide si a la maquina le conviene llamar a la ficha tirada
	ld hl,(0c0deh)		;8441   ; decide si llama a la ficha tirada: usa 0x7284 con la mano de D000 y mira cada una de las condiciones (854D, 83DF, 84A4, 84F6)
	push hl			;8444
	ld hl,0d000h		;8445
	call mano_del_que_responde		;8448   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld (0c0deh),hl		;844b   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	call 07284h		;844e   ; prepara_mano_ia: prepara el analisis de la mano de la maquina
	ld hl,(0c0deh)		;8451   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld a,(hl)			;8454
	and a			;8455
	jr z,L_8463		;8456
	ld b,a			;8458
	inc hl			;8459
	ld a,(0c209h)		;845a   ; lee la ficha robada o tirada
L_845D:
	cp (hl)			;845d
	jr z,L_8478		;845e
	inc hl			;8460
	djnz L_845D		;8461
L_8463:
	ld a,(0c20ah)		;8463   ; lee la posicion de la ficha en la mano
	ld hl,(0c0deh)		;8466   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	call 0405ch		;8469   ; suma_a_hl: HL = HL + A
	ld a,(0c209h)		;846c   ; lee la ficha robada o tirada
	cp (hl)			;846f
	pop hl			;8470
	ld (0c0deh),hl		;8471   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	jr nz,L_847E		;8474
L_8476:
	scf			;8476
	ret			;8477
L_8478:
	pop hl			;8478
	ld (0c0deh),hl		;8479   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	or a			;847c
	ret			;847d
L_847E:
	call L_854D		;847e   ; mira si la ficha de 0xC209 esta en alguno de los cuatro grupos de +0x180 (de 0x10 en 0x10)
	ret c			;8481
	call L_83DF		;8482   ; mira si la ficha tirada es un honor o de viento (a partir de 0x31) y si es el viento de la ronda o el suyo
	ret nc			;8485
	call L_84A4		;8486   ; condiciones para llamar de la maquina segun el nivel (0xC020): solo con +0x73 puesto; sin fichas de numero bajo en +0x140 ni extremos en +0x150
	ret nc			;8489
	call L_84F6		;848a   ; otras condiciones: mira +0x40, +0x74 y las fichas de +0x140 y +0x150
	ret nc			;848d
	ld hl,0d040h		;848e
	call mano_del_que_responde		;8491   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8494
	and a			;8495
	jr z,L_8476		;8496
	ld hl,0d072h		;8498
	call mano_del_que_responde		;849b   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;849e
	or a			;849f
	jr z,L_8476		;84a0
	or a			;84a2
	ret			;84a3
L_84A4:
	ld a,(0c020h)		;84a4   ; condiciones para llamar de la maquina segun el nivel (0xC020): solo con +0x73 puesto; sin fichas de numero bajo en +0x140 ni extremos en +0x150
	and a			;84a7
	jr z,L_84B4		;84a8
	ld hl,0d073h		;84aa
	call mano_del_que_responde		;84ad   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;84b0
	or a			;84b1
	jr nz,L_84B6		;84b2
L_84B4:
	scf			;84b4
	ret			;84b5
L_84B6:
	ld hl,0d140h		;84b6
	call mano_del_que_responde		;84b9   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;84bc
	and a			;84bd
	jr z,L_84CE		;84be
	ld b,a			;84c0
	inc hl			;84c1
L_84C2:
	ld a,(hl)			;84c2   ; mira que ninguna ficha de +0x140 sea de numero menor de 7
	and 00fh		;84c3
	sub 002h		;84c5
	cp 005h		;84c7
	jr nc,L_84B4		;84c9
	inc hl			;84cb
	djnz L_84C2		;84cc
L_84CE:
	ld hl,0d150h		;84ce
	call mano_del_que_responde		;84d1   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;84d4
	and a			;84d5
	jr z,L_84E7		;84d6
	ld b,a			;84d8
	inc hl			;84d9
L_84DA:
	ld a,(hl)			;84da   ; mira que ninguna ficha de +0x150 sea 9 ni 1
	and 00fh		;84db
	cp 009h		;84dd
	jr z,L_84B4		;84df
	dec a			;84e1
	jr z,L_84B4		;84e2
	inc hl			;84e4
	djnz L_84DA		;84e5
L_84E7:
	ld a,(0c209h)		;84e7   ; lee la ficha robada o tirada
	cp 031h		;84ea
	jr nc,L_84B4		;84ec
	and 00fh		;84ee
	sub 003h		;84f0
	cp 005h		;84f2
	ccf			;84f4
	ret			;84f5
L_84F6:
	ld hl,0d040h		;84f6   ; otras condiciones: mira +0x40, +0x74 y las fichas de +0x140 y +0x150
	call mano_del_que_responde		;84f9   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;84fc
	and a			;84fd
	jr nz,L_850A		;84fe
	ld hl,0d074h		;8500
	call mano_del_que_responde		;8503   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8506
	or a			;8507
	jr nz,L_850C		;8508
L_850A:
	scf			;850a
	ret			;850b
L_850C:
	ld hl,0d140h		;850c
	call mano_del_que_responde		;850f   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;8512
	and a			;8513
	jr z,L_8524		;8514
	ld b,a			;8516
	inc hl			;8517
L_8518:
	ld a,(hl)			;8518   ; mira las fichas de +0x140: de numero 2 a 6 llama
	and 00fh		;8519
	sub 002h		;851b
	cp 005h		;851d
	jr c,L_850A		;851f
	inc hl			;8521
	djnz L_8518		;8522
L_8524:
	ld hl,0d150h		;8524   ; mira +0x150: si alguna es de numero 2 a 8 no llama
	call mano_del_que_responde		;8527   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(hl)			;852a
	and a			;852b
	jr z,L_854B		;852c
	ld b,a			;852e
	inc hl			;852f
	ld a,(hl)			;8530
	and 00fh		;8531
	sub 002h		;8533
	cp 007h		;8535
	jr c,L_850A		;8537
	inc hl			;8539
	djnz L_84DA		;853a
	ld a,(0c209h)		;853c   ; la ficha tirada: honor o numero 3 a 7 se acepta
	cp 031h		;853f
	jr nc,L_8563		;8541
	and 00fh		;8543
	sub 003h		;8545
	cp 005h		;8547
	jr c,L_8563		;8549
L_854B:
	scf			;854b
	ret			;854c
L_854D:
	ld hl,0d180h		;854d   ; mira si la ficha de 0xC209 esta en alguno de los cuatro grupos de +0x180 (de 0x10 en 0x10)
	call mano_del_que_responde		;8550   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld c,004h		;8553
L_8555:
	push hl			;8555
	call L_8565		;8556
	pop hl			;8559
	ret c			;855a
	ld a,010h		;855b
	call 0405ch		;855d   ; suma_a_hl: HL = HL + A
	dec c			;8560
	jr nz,L_8555		;8561
L_8563:
	or a			;8563
	ret			;8564
L_8565:
	ld a,(hl)			;8565
	or a			;8566
	ret z			;8567
	ld b,a			;8568
	add a,a			;8569
	inc hl			;856a
	ld a,(0c209h)		;856b   ; lee la ficha robada o tirada
L_856E:
	cp (hl)			;856e   ; busca la ficha en la lista
	jr z,L_8576		;856f
	inc hl			;8571
	djnz L_856E		;8572
	or a			;8574
	ret			;8575
L_8576:
	scf			;8576
	ret			;8577
L_8578:
	ld hl,0d067h		;8578   ; cuenta cuantas veces ha tirado y marca 0xC213
	call mano_del_que_responde		;857b   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	push hl			;857e
	call L_85C9		;857f   ; cuenta cuantas parejas hay en la lista hasta 0xFF
	pop hl			;8582
	ld a,c			;8583
	and a			;8584
	jr z,L_85C5		;8585
	push hl			;8587
	ld hl,0d141h		;8588
	call mano_del_que_responde		;858b   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld a,(0c209h)		;858e   ; lee la ficha robada o tirada
	ld d,a			;8591
L_8592:
	ld a,(hl)			;8592   ; busca la tirada entre los tres numeros de la escalera
	cp d			;8593
	jr z,L_85A1		;8594
	inc a			;8596
	cp d			;8597   ; si coincide con la siguiente tambien vale
	jr z,L_85A1		;8598
	inc a			;859a
	cp d			;859b
	jr z,L_85A1		;859c
	inc hl			;859e   ; sigue con la lista
	jr L_8592		;859f
L_85A1:
	ld b,003h		;85a1
	ld a,(hl)			;85a3
	ld hl,0cc80h		;85a4
L_85A7:
	cp d			;85a7
	jr z,L_85AC		;85a8
	ld (hl),a			;85aa
	inc de			;85ab
L_85AC:
	inc a			;85ac
	djnz L_85A7		;85ad
	pop hl			;85af
	ld b,c			;85b0
	ld c,000h		;85b1
L_85B3:
	ld e,(hl)			;85b3   ; compara cada pareja de la lista con la escalera de 0xCC80
	inc hl			;85b4
	ld d,(hl)			;85b5
	inc hl			;85b6
	push hl			;85b7
	ld hl,(0cc80h)		;85b8
	call 00020h		;85bb   ; BIOS DCOMPR - Compares HL with DE
	pop hl			;85be
	jr z,L_85C4		;85bf
	inc c			;85c1
	djnz L_85B3		;85c2
L_85C4:
	ld a,c			;85c4
L_85C5:
	ld (0c213h),a		;85c5   ; guarda la opcion elegida en el cuadro
	ret			;85c8
L_85C9:
	ld c,000h		;85c9   ; cuenta cuantas parejas hay en la lista hasta 0xFF
	inc hl			;85cb
	inc hl			;85cc
	ld a,(hl)			;85cd
	inc a			;85ce   ; 0xFF acaba la lista
	ret z			;85cf
	inc c			;85d0
	inc hl			;85d1
	inc hl			;85d2
	ld a,(hl)			;85d3   ; cuenta tambien la segunda pareja
	inc a			;85d4
	ret z			;85d5
	inc c			;85d6
	ret			;85d7
mano_del_que_responde:		; H += 4 x jugador de 0xC20D
	ld a,(0c20dh)		;85d8   ; H += 4 x jugador (0xC20D): la mano del jugador cuyo numero esta en 0xC20D
	add a,a			;85db
	add a,a			;85dc
	add a,h			;85dd
	ld h,a			;85de
	ret			;85df
prueba_mano_con_ficha:		; prueba la mano del que responde con la ficha de 0xC209 o C
	ld hl,(0c0deh)		;85e0   ; prueba la mano del jugador actual con la ficha 0xC209 o C: ejecuta 0x7284
	push hl			;85e3
	ld hl,0d000h		;85e4
	call mano_del_que_responde		;85e7   ; mano_del_que_responde: H += 4 x jugador de 0xC20D
	ld (0c0deh),hl		;85ea   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld a,(0c209h)		;85ed   ; lee la ficha robada o tirada
	push af			;85f0
	or c			;85f1
	ld (0c209h),a		;85f2   ; guarda la ficha robada o tirada
	call 07284h		;85f5   ; prepara_mano_ia: prepara el analisis de la mano de la maquina
	pop af			;85f8
	ld (0c209h),a		;85f9   ; guarda la ficha robada o tirada
	pop hl			;85fc
	ld (0c0deh),hl		;85fd   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ret			;8600
alguien_espera_esa:		; mira si la ficha tirada le sirve a alguien
	call busca_opciones_chi_kan		;8601   ; mira si la ficha tirada es una de las que le falta a algun jugador para ganar (busca entre las esperas 0xC21A..)
	ld hl,0c21ah		;8604   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c0c6h)		;8607
	ld c,a			;860a
	ld b,004h		;860b
L_860D:
	ld a,(hl)			;860d
	cp 0ffh		;860e
	jr z,L_863E		;8610
	ld de,(0c0deh)		;8612   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	rlca			;8616
	rlca			;8617
	and 003h		;8618
	dec a			;861a
	jr z,L_8629		;861b
	ld a,(hl)			;861d
	and 03fh		;861e
	call 04061h		;8620   ; suma_a_de: DE = DE + A
	ld a,(de)			;8623
	cp c			;8624
	jr z,L_8640		;8625
	jr L_863B		;8627
L_8629:
	ld a,(hl)			;8629   ; busca en la lista de +0x37 de la mano la ficha del que ha tirado
	and 03fh		;862a
	add a,a			;862c
	push hl			;862d
	ld hl,00037h		;862e
	add hl,de			;8631
	ex de,hl			;8632
	pop hl			;8633
	call 04061h		;8634   ; suma_a_de: DE = DE + A
	ld a,(de)			;8637
	cp c			;8638
	jr z,L_8640		;8639
L_863B:
	inc hl			;863b
	djnz L_860D		;863c
L_863E:
	or a			;863e
	ret			;863f
L_8640:
	ld a,b			;8640   ; hay ron: 0xC213 = el jugador, recoge la ficha del muro y da el sonido del ron
	sub 004h		;8641
	neg		;8643
	ld (0c213h),a		;8645   ; guarda la opcion elegida en el cuadro
	call L_9672		;8648   ; una ficha mas del muro sacada de la parte de atras (0xC210 += 1), con su dibujo
	call borra_hueco_ficha		;864b   ; borra_hueco_ficha: borra el rectangulo de la ficha robada de la mano
	ld a,(0c207h)		;864e   ; lee el jugador al que le toca (0 = el humano)
	ld (0c20dh),a		;8651   ; guarda el jugador que responde a la ficha tirada
	call 0a791h		;8654   ; suma_kan: suma uno a los kan del jugador 0xC207
	call L_98D4		;8657   ; prepara el cambio de mano (0x991B, 0xA28A), la ordena y la dibuja
	ld a,(0c210h)		;865a   ; lee las fichas sacadas del final del muro (por kan)
	ld c,a			;865d
	ld a,087h		;865e
	sub c			;8660
	ld hl,0c100h		;8661   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;8664   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8667
	ld (0c209h),a		;8668   ; guarda la ficha robada o tirada
	call dibuja_ficha_robada		;866b   ; dibuja_ficha_robada: dibuja la ficha 0xC209 en su sitio
	ld a,001h		;866e
	ld (0cd0ch),a		;8670   ; guarda 1 si se gana con la ficha de un kan
	ld a,(0c207h)		;8673   ; lee el jugador al que le toca (0 = el humano)
	ld b,002h		;8676
	call 0a6beh		;8678   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call 04163h		;867b   ; voz_kan: dice KAN: la voz 0x13 con el tono del personaje de 0xC20D
	scf			;867e
	ret			;867f
manera_de_jugar:		; despacha por la manera de jugar de la maquina (+0x96)
	ld hl,(0c0deh)		;8680   ; despacha por +0x96 (bits 3-5): la manera de jugar de este jugador
	ld de,00096h		;8683
	add hl,de			;8686
	ld a,(hl)			;8687
	rrca			;8688
	rrca			;8689
	rrca			;868a
	and 007h		;868b
	call 04066h		;868d   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8690: 8 destinos del despachador p00:4066 (call en p02:868D, el
;   indice en A): 86A0, 86A1, 86AF, 86BD, 86CB, 86D9, 86E1, 86E9; lo leen
;   p02:868D (16 bytes)
;   0x8690..0x86a0  (16 bytes)
DATA_tabla_8690:
	defw 086a0h,086a1h,086afh,086bdh,086cbh,086d9h,086e1h,086e9h	; 8690

; ======================================================================
; CODIGO 0x86a0..0x8960  (704 bytes)
; ======================================================================


L_86A0:
	ret			;86a0
L_86A1:
	call L_86F9		;86a1   ; manera 0: pone +0x76 a 1 si hace falta (0x86F9 y 8189 < 2)
	ret nc			;86a4
	call fichas_de_grupos		;86a5   ; fichas_de_grupos: A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	cp 002h		;86a8
	ret nc			;86aa
	call L_86ED		;86ab   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86ae
L_86AF:
	call L_8701		;86af   ; mira si 0xC1C1 esta entre 0x58 y 0x5B
	ret nc			;86b2
	call fichas_de_grupos		;86b3   ; fichas_de_grupos: A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	cp 002h		;86b6
	ret nc			;86b8
	call L_86ED		;86b9   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86bc
L_86BD:
	call L_86F9		;86bd   ; mira si 0xC1C1 esta entre 0x70 y 0x73
	ret nc			;86c0
	call fichas_de_grupos		;86c1   ; fichas_de_grupos: A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	cp 003h		;86c4
	ret nc			;86c6
	call L_86ED		;86c7   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86ca
L_86CB:
	call L_8701		;86cb   ; mira si 0xC1C1 esta entre 0x58 y 0x5B
	ret nc			;86ce
	call fichas_de_grupos		;86cf   ; fichas_de_grupos: A = fichas de los grupos hechos (+0x0E, +0x140, +0x150, +0x160)
	cp 003h		;86d2
	ret nc			;86d4
	call L_86ED		;86d5   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86d8
L_86D9:
	call L_86F9		;86d9   ; mira si 0xC1C1 esta entre 0x70 y 0x73
	ret nc			;86dc
	call L_86ED		;86dd   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86e0
L_86E1:
	call L_8709		;86e1   ; mira si 0xC1C1 esta entre 0x64 y 0x67
	ret nc			;86e4
	call L_86ED		;86e5   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ret			;86e8
L_86E9:
	call L_8701		;86e9   ; mira si 0xC1C1 esta entre 0x58 y 0x5B
	ret nc			;86ec
L_86ED:
	ld hl,(0c0deh)		;86ed   ; pone el bit 0 de +0x76 (la maquina ya ha decidido)
	ld de,00076h		;86f0
	add hl,de			;86f3
	ld a,(hl)			;86f4
	or 001h		;86f5
	ld (hl),a			;86f7
	ret			;86f8
L_86F9:
	ld a,(0c1c1h)		;86f9   ; mira si 0xC1C1 esta entre 0x70 y 0x73
	sub 070h		;86fc
	cp 004h		;86fe
	ret			;8700
L_8701:
	ld a,(0c1c1h)		;8701   ; mira si 0xC1C1 esta entre 0x58 y 0x5B
	sub 058h		;8704
	cp 004h		;8706
	ret			;8708
L_8709:
	ld a,(0c1c1h)		;8709   ; mira si 0xC1C1 esta entre 0x64 y 0x67
	sub 064h		;870c
	cp 004h		;870e
	ret			;8710
busca_ficha_util:		; busca una ficha que le sirva entre las listas de los demas
	ld hl,(0c0deh)		;8711   ; mira si +0x76 tiene algun bit puesto (alguien ha tirado una ficha de las que busca)
	ld de,00076h		;8714
	add hl,de			;8717
	ld a,(hl)			;8718
	and a			;8719
	ret z			;871a
	ld hl,0d00fh		;871b   ; con el bit 0 busca en la mano 0; con el 1, en la 1; con el 2, en la 2; si no, la 3
	rra			;871e
	jr c,L_8730		;871f
	ld hl,0d40fh		;8721
	rra			;8724
	jr c,L_8730		;8725
	ld hl,0d80fh		;8727
	rra			;872a
	jr c,L_8730		;872b
	ld hl,0dc0fh		;872d
L_8730:
	ld (0cc80h),hl		;8730
	ld bc,001b0h		;8733
	ld hl,(0c0deh)		;8736   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;8739
	ld b,(hl)			;873a
	inc hl			;873b
	call L_87B1		;873c   ; busca en la lista HL (B entradas) una ficha que este en la lista de DE (C)
	ret c			;873f
	ld bc,00160h		;8740
	call L_87A9		;8743
	ret c			;8746
	ld bc,00190h		;8747
	call L_87A9		;874a
	ret c			;874d
	ld bc,001a0h		;874e
	call L_87A9		;8751
	ret c			;8754
	ld bc,00180h		;8755
	call L_87A9		;8758
	ret c			;875b
	call L_8799		;875c   ; B = 13 - 3 veces los grupos de la mano
	ld hl,(0c0deh)		;875f   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	call L_87B1		;8762   ; busca en la lista HL (B entradas) una ficha que este en la lista de DE (C)
	ret c			;8765
	ld hl,(0cc80h)		;8766
	ld b,(hl)			;8769
	ld c,000h		;876a
	inc hl			;876c
	ld de,0ec00h		;876d
	ld a,(hl)			;8770
	cp 031h		;8771
	jr nc,L_878A		;8773
	and 00fh		;8775
	sub 004h		;8777
	cp 003h		;8779
	jr nc,L_878A		;877b
	inc c			;877d
	ld a,(hl)			;877e
	sub 003h		;877f
	ld (de),a			;8781
	inc hl			;8782
	add a,006h		;8783
	ld (de),a			;8785
	inc hl			;8786
	xor a			;8787
	ld (de),a			;8788
	dec hl			;8789
L_878A:
	inc hl			;878a
	djnz L_878A		;878b
	ld a,c			;878d
	or a			;878e
	ret z			;878f
	add a,a			;8790
	ld b,a			;8791
	ld hl,(0ec00h)		;8792
	call L_87B1		;8795   ; busca en la lista HL (B entradas) una ficha que este en la lista de DE (C)
	ret			;8798
L_8799:
	ld hl,(0c0deh)		;8799   ; B = 13 - 3 veces los grupos de la mano
	ld de,0000eh		;879c
	add hl,de			;879f
	ld a,(hl)			;87a0   ; +0x0E: los grupos hechos de la mano
	add a,a			;87a1
	add a,(hl)			;87a2
	ld b,a			;87a3
	ld a,00dh		;87a4
	sub d			;87a6   ; B = 13 - D (tambien se pisa lo calculado antes con 3 x grupos: el resultado bueno es el ultimo)
	ld b,a			;87a7
	ret			;87a8   ; vuelve con B
L_87A9:
	ld hl,(0c0deh)		;87a9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;87ac
	ld a,(hl)			;87ad
	add a,a			;87ae
	ld b,a			;87af
	inc hl			;87b0
L_87B1:
	ld de,(0cc80h)		;87b1   ; busca en la lista HL (B entradas) una ficha que este en la lista de DE (C)
	ld a,(de)			;87b5
	ld c,a			;87b6
	inc de			;87b7
L_87B8:
	push de			;87b8
	ld a,(hl)			;87b9
	ex de,hl			;87ba
L_87BB:
	cp (hl)			;87bb   ; busca en la lista la ficha A
	jr z,L_87C9		;87bc   ; si la encuentra va a 0x87C9
	inc hl			;87be
	dec c			;87bf
	jr nz,L_87BB		;87c0
	ex de,hl			;87c2
	pop de			;87c3
	inc hl			;87c4
	djnz L_87B8		;87c5   ; pasa al siguiente grupo
	or a			;87c7
	ret			;87c8
L_87C9:
	pop de			;87c9
	ld c,a			;87ca
	call posicion_de_la_elegida		;87cb   ; posicion_de_la_elegida: busca en la mano la posicion de la ficha elegida (C) y la deja en 0xC20A
	scf			;87ce
	ret			;87cf
L_87D0:
	ld a,001h		;87d0   ; cuenta en 0xC510 las fichas iguales o cercanas a la tirada (bit 0 igual, bit 1 siguiente, bit 2 con hueco)
L_87D2:
	exx			;87d2
	ld b,a			;87d3
	ld hl,0c510h		;87d4   ; apunta a cuentas de fichas cercanas a la tirada (13)
	exx			;87d7
	ld a,(0c209h)		;87d8   ; lee la ficha robada o tirada
	call L_8934		;87db   ; busca A en la tabla 0x8960 (13 entradas) y suma B a la cuenta de 0xC510 (hasta 4)
	ret			;87de
L_87DF:
	ld a,002h		;87df
	jr L_87D2		;87e1
L_87E3:
	ld a,004h		;87e3
	jr L_87D2		;87e5
L_87E7:
	ld b,a			;87e7
	ld a,(0c209h)		;87e8   ; lee la ficha robada o tirada
	push af			;87eb
	ld a,b			;87ec
	ld (0c209h),a		;87ed   ; guarda la ficha robada o tirada
	ld a,004h		;87f0
	call L_87D2		;87f2
	pop af			;87f5
	ld (0c209h),a		;87f6   ; guarda la ficha robada o tirada
	ret			;87f9
L_87FA:
	exx			;87fa
	ld b,001h		;87fb
	ld hl,0c510h		;87fd   ; apunta a cuentas de fichas cercanas a la tirada (13)
	exx			;8800
	ld a,(0c209h)		;8801   ; lee la ficha robada o tirada
	and 00fh		;8804
	ld bc,00207h		;8806
	cp b			;8809
	jr z,L_8816		;880a
	inc b			;880c
	cp b			;880d
	jr z,L_8816		;880e
	cp c			;8810
	jr z,L_8816		;8811
	inc c			;8813
	cp c			;8814
	ret nz			;8815
L_8816:
	ld a,(0c20dh)		;8816   ; lee el jugador que responde a la ficha tirada
	add a,a			;8819
	add a,a			;881a
	ld hl,0d000h		;881b
	add a,h			;881e
	ld h,a			;881f
	push hl			;8820
	ld bc,00067h		;8821
	add hl,bc			;8824
	ld a,d			;8825
	add a,a			;8826
	call 0405ch		;8827   ; suma_a_hl: HL = HL + A
	ld d,(hl)			;882a
	inc hl			;882b
	ld e,(hl)			;882c
	pop hl			;882d
	ld a,d			;882e
	push hl			;882f
	call 0405ch		;8830   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8833
	pop hl			;8834
	and 00fh		;8835
	cp 009h		;8837
	jr z,L_884B		;8839
	dec a			;883b
	jr z,L_884B		;883c
	ld a,e			;883e
	call 0405ch		;883f   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8842
	and 00fh		;8843
	cp 009h		;8845
	jr z,L_8850		;8847
	dec a			;8849
	ret nz			;884a
L_884B:
	ld a,d			;884b
	call L_8934		;884c   ; busca A en la tabla 0x8960 (13 entradas) y suma B a la cuenta de 0xC510 (hasta 4)
	ret			;884f
L_8850:
	ld a,e			;8850
	call L_8934		;8851   ; busca A en la tabla 0x8960 (13 entradas) y suma B a la cuenta de 0xC510 (hasta 4)
	ret			;8854
L_8855:
	ld hl,0c510h		;8855   ; si en 0xC510 hay alguna ficha con 4 o mas, pone +0x80 a 0
	ld b,00dh		;8858
L_885A:
	ld a,(hl)			;885a   ; mira si alguna cuenta de 0xC510 es de 4 o mas
	cp 004h		;885b
	jr nc,L_8863		;885d
	inc hl			;885f
	djnz L_885A		;8860
	ret			;8862
L_8863:
	ld hl,(0c0deh)		;8863   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld l,080h		;8866
	ld (hl),000h		;8868
	ret			;886a
piensa_si_sigue:		; decide si vale la pena seguir con esa mano
	call L_8952		;886b   ; PIENSA SI VALE LA PENA seguir: cuenta cuantas fichas de cada tipo hay en 0xC500 y cuantas tiene la mano
	call L_88F9		;886e
	ld a,d			;8871
	cp 002h		;8872
	jr nc,L_88C5		;8874
	call L_88E6		;8876
	ld a,c			;8879
	cp 002h		;887a
	jr nc,L_88CB		;887c
	ld hl,(0c0deh)		;887e   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld a,l			;8881
	add a,081h		;8882
	ld l,a			;8884
	ld (hl),001h		;8885
	inc hl			;8887
	ex de,hl			;8888
	ld a,c			;8889
	and a			;888a
	jr z,L_88A5		;888b
	ld hl,0c500h		;888d   ; apunta a cuentas de trabajo de la maquina (13)
	ld c,000h		;8890
L_8892:
	ld a,(hl)			;8892   ; cuenta las fichas hasta un cero
	and a			;8893
	jr z,L_889A		;8894
	inc c			;8896
	inc hl			;8897
	jr L_8892		;8898
L_889A:
	ld a,c			;889a
	ld hl,08960h		;889b
	call 0405ch		;889e   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;88a1
	ld (de),a			;88a2
	jr L_88CB		;88a3
L_88A5:
	ld hl,08960h		;88a5
	ld bc,0000dh		;88a8
	ldir		;88ab
	jr L_88CB		;88ad
L_88AF:
	ld a,b			;88af
	ld hl,08960h		;88b0
	call 0405ch		;88b3   ; suma_a_hl: HL = HL + A
	ld c,(hl)			;88b6
	ld hl,(0c0deh)		;88b7   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld b,00eh		;88ba
L_88BC:
	ld a,(hl)			;88bc   ; busca la ficha C en la mano
	cp c			;88bd
	jr z,L_88C4		;88be
	inc hl			;88c0
	djnz L_88BC		;88c1
	ret			;88c3
L_88C4:
	ld e,b			;88c4
L_88C5:
	ld a,e			;88c5
	sub 00eh		;88c6
	neg		;88c8
	ret			;88ca
L_88CB:
	call L_88F5		;88cb
	ld a,d			;88ce
	and a			;88cf
	jr nz,L_88C5		;88d0
	ld hl,0c500h		;88d2   ; apunta a cuentas de trabajo de la maquina (13)
	ld b,000h		;88d5
L_88D7:
	ld a,(hl)			;88d7   ; busca la primera cuenta mayor o igual que 2
	cp 002h		;88d8
	jr nc,L_88AF		;88da
	inc hl			;88dc
	inc b			;88dd
	jr L_88D7		;88de
L_88E0:
	ld a,001h		;88e0
	ld (0c0b1h),a		;88e2   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ret			;88e5
L_88E6:
	ld hl,0c500h		;88e6   ; apunta a cuentas de trabajo de la maquina (13)
	ld bc,00d00h		;88e9
L_88EC:
	ld a,(hl)			;88ec
	and a			;88ed
	jr nz,L_88F1		;88ee
	inc c			;88f0
L_88F1:
	inc hl			;88f1
	djnz L_88EC		;88f2
	ret			;88f4
L_88F5:
	ld c,001h		;88f5
	jr L_88FB		;88f7
L_88F9:
	ld c,000h		;88f9
L_88FB:
	ld hl,(0c0deh)		;88fb   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00001h		;88fe
	ld b,00eh		;8901
L_8903:
	ld a,(hl)			;8903   ; recorre la mano: las fichas de numero 2 a 8 se apuntan como sueltas
	cp 031h		;8904
	jr nc,L_8915		;8906
	and 00fh		;8908
	cp 009h		;890a   ; mira que no sea un 9
	jr z,L_8915		;890c
	dec a			;890e   ; ni un 1
	jr z,L_8915		;890f
	ld e,b			;8911
	inc d			;8912
	jr L_8920		;8913
L_8915:
	push hl			;8915   ; las de punta o de honor se pasan a la cuenta
	push de			;8916
	push bc			;8917
	ld a,c			;8918
	and a			;8919
	call z,L_892C		;891a
	pop bc			;891d
	pop de			;891e
	pop hl			;891f
L_8920:
	inc hl			;8920
	ld a,b			;8921
	cp 002h		;8922
	jr nz,L_8929		;8924
	ld hl,0c209h		;8926   ; apunta a la ficha robada o tirada
L_8929:
	djnz L_8903		;8929
	ret			;892b
L_892C:
	exx			;892c
	ld hl,0c500h		;892d   ; apunta a cuentas de trabajo de la maquina (13)
	ld b,001h		;8930
	exx			;8932
	ld a,(hl)			;8933
L_8934:
	ld bc,00d00h		;8934   ; busca A en la tabla 0x8960 (13 entradas) y suma B a la cuenta de 0xC510 (hasta 4)
	ld hl,08960h		;8937
L_893A:
	cp (hl)			;893a   ; busca la ficha en la tabla de 13
	jr z,L_8942		;893b
	inc hl			;893d
	inc c			;893e
	djnz L_893A		;893f
	ret			;8941
L_8942:
	ld a,c			;8942
	exx			;8943
	call 0405ch		;8944   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8947
	add a,b			;8948
	cp 005h		;8949
	jr c,L_894F		;894b
	ld a,004h		;894d
L_894F:
	ld (hl),a			;894f
	exx			;8950
	ret			;8951
L_8952:
	ld hl,0c500h		;8952   ; pone a cero 0xC500 (13 bytes)
	ld de,0c501h		;8955
	ld bc,0000ch		;8958
	ld (hl),000h		;895b
	ldir		;895d
	ret			;895f

; ----------------------------------------------------------------------
; DATOS resto_8960: lo apuntan con el banco puesto p02:889B (0x8960), p02:88A5
;   (0x8960), p02:88B0 (0x8960), p02:8937 (0x8960); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p02:889B, p02:88A5,
;   p02:88B0, p02:8937 (13 bytes)
;   0x8960..0x896d  (13 bytes)
DATA_resto_8960:
	defb 001h,009h,011h,019h,021h,029h,031h,032h,033h,034h,035h,036h,037h	; 8960  ....!)1234567

; ======================================================================
; CODIGO 0x896d..0x8a78  (267 bytes)
; ======================================================================


L_896D:
	call 069d3h		;896d   ; mira si quedan menos de 4 fichas (0x69D3); si el bit 5 de +0x60 no esta, vuelve
	ld hl,(0c0deh)		;8970   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00060h		;8973
	add hl,bc			;8976
	ld a,(hl)			;8977
	and 020h		;8978
	ret z			;897a
	ld a,(0c029h)		;897b   ; lee la regla de dos han como minimo (二翻縛り; de serie si)
	and a			;897e
	jr z,L_8988		;897f
	ld a,(0c0b5h)		;8981   ; lee las barras de honba (BCD)
	cp 003h		;8984
	jr nc,L_899D		;8986
L_8988:
	ld hl,(0c0deh)		;8988   ; segun el nibble alto de +0x90 elige la manera de actuar
	ld bc,00090h		;898b
	add hl,bc			;898e
	ld a,(hl)			;898f
	rrca			;8990   ; el nibble alto de +0x90 es la manera
	rrca			;8991
	rrca			;8992
	rrca			;8993
	and 00fh		;8994
	ret z			;8996
	dec a			;8997   ; con 1 va a 0x89D6
	jr z,L_89D6		;8998
	dec a			;899a   ; con 2 va a 0x89DF
	jr z,L_89DF		;899b
L_899D:
	push de			;899d   ; descarta la ficha de DE: 0x8A20 y 0x89A9, y luego 0xA46E
	call anota_quien_tiro		;899e   ; anota_quien_tiro: anota en +0x76 de los otros quien ha tirado
	call L_89A9		;89a1   ; guarda en +0x71 el numero de ficha robada (0xC1C1) y pone +0x35 = 1 si no tiene espera
	pop hl			;89a4
	call 0a46eh		;89a5   ; declara_riichi: la maquina declara riichi: +0x34 = 0xFF y apuesta 1000
	ret			;89a8
L_89A9:
	ld hl,(0c0deh)		;89a9   ; guarda en +0x71 el numero de ficha robada (0xC1C1) y pone +0x35 = 1 si no tiene espera
	ld bc,00071h		;89ac
	add hl,bc			;89af
	ld a,(0c1c1h)		;89b0   ; lee cuantas fichas se han robado del muro
	ld (hl),a			;89b3
	ld hl,(0c0deh)		;89b4   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,0000fh		;89b7
	add hl,bc			;89ba
	ld a,(hl)			;89bb
	and a			;89bc
	ret nz			;89bd
	ld hl,(0c0deh)		;89be   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00035h		;89c1
	add hl,bc			;89c4
	ld (hl),001h		;89c5
	ret			;89c7
L_89C8:
	xor a			;89c8   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	ld (0d071h),a		;89c9
	ld (0d471h),a		;89cc
	ld (0d871h),a		;89cf
	ld (0dc71h),a		;89d2
	ret			;89d5
L_89D6:
	ld a,(0c003h)		;89d6   ; lee el contador de cuadros
	and 003h		;89d9
	jr nz,L_89F6		;89db
	jr L_899D		;89dd
L_89DF:
	ld a,(0c003h)		;89df   ; lee el contador de cuadros
	rra			;89e2
	jr nc,L_89F6		;89e3
	jr L_899D		;89e5
L_89E7:
	ld hl,0c0b4h		;89e7   ; suma 1 a 0xC0B4 en BCD (tope 99) y avisa por 0xA6A7
	ld a,(hl)			;89ea
	cp 099h		;89eb
	ret nc			;89ed
	add a,001h		;89ee
	daa			;89f0
	ld (hl),a			;89f1
	call 0a6a7h		;89f2   ; escribe_riichi_honba: escribe los numeros de 0xC0B4 y 0xC0B5
	ret			;89f5
L_89F6:
	ld h,d			;89f6   ; sube un marcador de +0x36 de la mano
	ld l,e			;89f7
	ld bc,00036h		;89f8
	add hl,bc			;89fb
	ld a,(hl)			;89fc
	and a			;89fd
	jr nz,L_8A03		;89fe
	ld (hl),003h		;8a00
	ret			;8a02
L_8A03:
	dec (hl)			;8a03
	ld a,(hl)			;8a04
	ret nz			;8a05
	jr L_899D		;8a06
L_8A08:
	ld hl,0d034h		;8a08   ; mira las cuatro manos: si alguna tiene +0x34 a cero no pasa nada; si todas lo tienen, pone 0xC0CF = 1 y 0xC0B8 = 2 (fin de la ronda)
	ld b,004h		;8a0b
L_8A0D:
	ld a,(hl)			;8a0d
	and a			;8a0e
	ret z			;8a0f
	ld de,00400h		;8a10
	add hl,de			;8a13
	djnz L_8A0D		;8a14
	ld a,001h		;8a16
	ld (0c0cfh),a		;8a18   ; guarda 1 si se anula por cuatro riichi
	inc a			;8a1b
	ld (0c0b8h),a		;8a1c   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ret			;8a1f
anota_quien_tiro:		; anota en +0x76 de los otros quien ha tirado
	ld hl,0d000h		;8a20   ; por cada jugador que no es el que ha tirado y juega con maneras 5 a 7 (+0x96), anota en +0x76 el turno de quien ha tirado
	ld bc,00400h		;8a23
L_8A26:
	ld (0cc80h),hl		;8a26   ; por cada jugador mira su manera de jugar (+0x96)
	ld a,(0c0dfh)		;8a29
	rrca			;8a2c
	rrca			;8a2d
	and 003h		;8a2e
	cp c			;8a30
	jr z,L_8A47		;8a31
	push bc			;8a33
	ld hl,(0cc80h)		;8a34
	ld de,00096h		;8a37
	add hl,de			;8a3a
	ld a,(hl)			;8a3b
	rrca			;8a3c
	rrca			;8a3d
	rrca			;8a3e
	and 007h		;8a3f
	cp 005h		;8a41
	call nc,L_8A52		;8a43   ; pone en +0x76 el bit del jugador que ha tirado (1 << jugador + 1)
	pop bc			;8a46
L_8A47:
	inc c			;8a47   ; pasa a la mano siguiente
	ld hl,(0cc80h)		;8a48
	ld de,00400h		;8a4b
	add hl,de			;8a4e
	djnz L_8A26		;8a4f
	ret			;8a51
L_8A52:
	ld a,(0c0dfh)		;8a52   ; pone en +0x76 el bit del jugador que ha tirado (1 << jugador + 1)
	rrca			;8a55
	rrca			;8a56
	and 003h		;8a57
	ld b,a			;8a59
	inc b			;8a5a
	xor a			;8a5b
	scf			;8a5c
L_8A5D:
	rla			;8a5d   ; pone el bit del jugador en +0x76
	djnz L_8A5D		;8a5e
	ld hl,(0cc80h)		;8a60   ; la mano del que ha tirado
	ld de,00076h		;8a63
	add hl,de			;8a66
	or (hl)			;8a67   ; junta el bit a lo que ya habia
	ld hl,(0cc80h)		;8a68
	ld de,00076h		;8a6b
	add hl,de			;8a6e
	ld (hl),a			;8a6f
	ret			;8a70
L_8A71:
	ld a,(0c1c2h)		;8a71   ; reparto de la mano: 0xC1C2 elige el paso por la tabla de 0x8A75
	dec a			;8a74
	call 04066h		;8a75   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8A78: 5 destinos del despachador p00:4066 (call en p02:8A75, el
;   indice en A): 8A82, 8AAD, 8B10, 8B18, 8B2D; lo leen p02:8A75 (10 bytes)
;   0x8a78..0x8a82  (10 bytes)
DATA_tabla_8A78:
	defw 08a82h,08aadh,08b10h,08b18h,08b2dh	; 8a78

; ======================================================================
; CODIGO 0x8a82..0x8e50  (974 bytes)
; ======================================================================


empieza_reparto:		; prepara el reparto y baraja
	ld hl,0c100h		;8a82   ; borra 0xC100 (192 bytes: el muro) y pone el banco 15; baraja con 0xA2A8
	ld de,0c101h		;8a85
	ld bc,000bfh		;8a88
	ld (hl),000h		;8a8b
	ldir		;8a8d
	call 0424bh		;8a8f   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	call 0a2a8h		;8a92   ; baraja: baraja el muro de 136 fichas en 0xC100
	call 04207h		;8a95   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	xor a			;8a98
	ld (0c1c1h),a		;8a99   ; guarda cuantas fichas se han robado del muro
	ld (0c1c4h),a		;8a9c   ; guarda cuantas fichas se han repartido
	ld hl,0c1c2h		;8a9f   ; apunta a el paso del reparto
	inc (hl)			;8aa2
	call L_9680		;8aa3
	ld a,(0c0b7h)		;8aa6   ; lee el jugador que reparte (0-3)
	ld (0c207h),a		;8aa9   ; guarda el jugador al que le toca (0 = el humano)
	ret			;8aac
L_8AAD:
	ld hl,0c1c4h		;8aad   ; reparto: cada jugador coge 4 fichas del muro (0xC100 + 0xC1C1) hasta 12 y despues 1; guarda 0xC1C4 y sigue con 0x8CF5
	ld a,(hl)			;8ab0
	cp 010h		;8ab1
	jr nc,L_8B0A		;8ab3
	inc (hl)			;8ab5
	cp 00ch		;8ab6
	jr nc,L_8ABE		;8ab8
	ld a,004h		;8aba
	jr L_8AC0		;8abc
L_8ABE:
	ld a,001h		;8abe
L_8AC0:
	ld (0c1c5h),a		;8ac0
	ld a,(0c207h)		;8ac3   ; lee el jugador al que le toca (0 = el humano)
	add a,a			;8ac6
	add a,a			;8ac7
	ld h,a			;8ac8
	ld l,000h		;8ac9
	ld de,0d000h		;8acb
	add hl,de			;8ace
	ld a,(0c1c4h)		;8acf   ; lee cuantas fichas se han repartido
	dec a			;8ad2
	and 0fch		;8ad3
	call 0405ch		;8ad5   ; suma_a_hl: HL = HL + A
	ex de,hl			;8ad8
	ld hl,0c100h		;8ad9   ; apunta a el muro: 136 fichas (0x88)
	ld a,(0c1c1h)		;8adc   ; lee cuantas fichas se han robado del muro
	call 0405ch		;8adf   ; suma_a_hl: HL = HL + A
	ld a,(0c1c5h)		;8ae2
	ld b,000h		;8ae5
	ld c,a			;8ae7
	ldir		;8ae8
	call dibuja_mano		;8aea   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call 04120h		;8aed   ; pide_sonido_08: pide el sonido 0x08
	ld hl,0c207h		;8af0   ; apunta a el jugador al que le toca (0 = el humano)
	ld a,(hl)			;8af3
	inc a			;8af4
	and 003h		;8af5
	ld (hl),a			;8af7
	ld hl,0c1c1h		;8af8   ; apunta a cuantas fichas se han robado del muro
	ld a,(0c1c5h)		;8afb
	add a,(hl)			;8afe
	ld (hl),a			;8aff
	ld a,01eh		;8b00
L_8B02:
	ld hl,0c1c2h		;8b02   ; apunta a el paso del reparto
	inc (hl)			;8b05
	inc hl			;8b06
	ld (hl),01eh		;8b07
	ret			;8b09
L_8B0A:
	ld hl,0c1c2h		;8b0a   ; fin del reparto: 0xC1C2 += 2
	inc (hl)			;8b0d
	inc (hl)			;8b0e
	ret			;8b0f
L_8B10:
	ld hl,0c1c3h		;8b10   ; espera: cuenta atras de 0xC1C3
	dec (hl)			;8b13
	ret nz			;8b14
	dec hl			;8b15
	dec (hl)			;8b16
	ret			;8b17
L_8B18:
	ld b,004h		;8b18   ; ordena la mano de cada uno de los cuatro jugadores y la dibuja
L_8B1A:
	ld a,b			;8b1a
	dec a			;8b1b
	ld (0c207h),a		;8b1c   ; guarda el jugador al que le toca (0 = el humano)
	push bc			;8b1f
	call ordena_mano_actual		;8b20   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call dibuja_mano		;8b23   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop bc			;8b26
	djnz L_8B1A		;8b27
	ld a,078h		;8b29
	jr L_8B02		;8b2b
L_8B2D:
	ld hl,0c1c3h		;8b2d   ; apunta a el temporizador del reparto
	dec (hl)			;8b30
	ret z			;8b31
	ld a,(0c0b7h)		;8b32   ; lee el jugador que reparte (0-3)
	ld (0c207h),a		;8b35   ; guarda el jugador al que le toca (0 = el humano)
	xor a			;8b38
	ld (0c1c2h),a		;8b39   ; guarda el paso del reparto
	ret			;8b3c
ordena_mano_actual:		; ordena las 13 fichas de la mano del jugador actual
	xor a			;8b3d   ; ordena de menor a mayor las 13 fichas de la mano del jugador actual (burbuja)
	ld (0c200h),a		;8b3e   ; guarda contador de trabajo de las fichas de la mano
L_8B41:
	ld b,006h		;8b41
	ld a,(0c200h)		;8b43   ; lee contador de trabajo de las fichas de la mano
	and 001h		;8b46
	push af			;8b48
	call 05e54h		;8b49   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	pop af			;8b4c
	add a,l			;8b4d
	ld l,a			;8b4e
L_8B4F:
	ld a,(hl)			;8b4f   ; un paso de la ordenacion de la mano
	inc l			;8b50
	cp (hl)			;8b51
	jr c,L_8B5B		;8b52
	jr z,L_8B5B		;8b54
	ld c,(hl)			;8b56
	ld (hl),a			;8b57
	dec l			;8b58
	ld (hl),c			;8b59
	inc l			;8b5a
L_8B5B:
	inc l			;8b5b
	djnz L_8B4F		;8b5c
	ld a,(0c200h)		;8b5e   ; lee contador de trabajo de las fichas de la mano
	inc a			;8b61
	ld (0c200h),a		;8b62   ; guarda contador de trabajo de las fichas de la mano
	ld c,00dh		;8b65
	cp c			;8b67
	jr nz,L_8B41		;8b68
	xor a			;8b6a
	ld (0c200h),a		;8b6b   ; guarda contador de trabajo de las fichas de la mano
	ret			;8b6e
multiplica_b_c:		; A = B x C
	ld a,b			;8b6f   ; A = B x C (multiplica por sumas)
	and a			;8b70
	jr z,L_8B77		;8b71
	xor a			;8b73
L_8B74:
	add a,c			;8b74
	djnz L_8B74		;8b75
L_8B77:
	ret			;8b77
dibuja_ficha:		; dibuja la ficha A del jugador 0xC207
	push af			;8b78   ; dibuja la ficha A del jugador 0xC207: pone la direccion de su imagen segun el palo y el numero (tabla 0x8E81, 0xC205 de ancho)
	ld a,(0c207h)		;8b79   ; lee el jugador al que le toca (0 = el humano)
	and a			;8b7c
	jr z,L_8B8B		;8b7d
	ld a,(0c214h)		;8b7f   ; lee 1 si las manos se ven boca arriba
	and a			;8b82
	jr nz,L_8B8B		;8b83
	pop af			;8b85
L_8B86:
	ld a,038h		;8b86
	jp dibuja_ficha_2		;8b88   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
L_8B8B:
	pop af			;8b8b
dibuja_ficha_2:		; dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	push af			;8b8c   ; igual que 0x8B78 sin cambiar la ficha por la de reverso
	and 030h		;8b8d
	rrca			;8b8f
	rrca			;8b90
	rrca			;8b91
	rrca			;8b92
	push af			;8b93
	ld hl,08e81h		;8b94
	ld a,(0c207h)		;8b97   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8b9a   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;8b9d
	call 04d07h		;8b9e   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;8ba1
	push hl			;8ba2
	and 00fh		;8ba3
	dec a			;8ba5
	ld b,a			;8ba6
	ld a,(0c205h)		;8ba7   ; lee el ancho de la ficha
	ld c,a			;8baa
	call multiplica_b_c		;8bab   ; multiplica_b_c: A = B x C
	pop hl			;8bae
	add a,l			;8baf
	ld (0c201h),a		;8bb0   ; guarda la X de la ficha en la hoja de tiles
	ld a,h			;8bb3
	ld (0c202h),a		;8bb4   ; guarda la Y de la ficha en la hoja de tiles
	ld a,(0c0e0h)		;8bb7
	and a			;8bba
	jp z,L_8C3C		;8bbb
	ld d,004h		;8bbe   ; dibuja la ficha con 0xC0E0 puesto: la imagen se copia a RAM y se cambian los colores de 0x0E y 0x07 por D
	jp L_8BF3		;8bc0
dibuja_ficha_clara:		; dibuja la ficha A con los colores cambiados
	push af			;8bc3
	and 030h		;8bc4
	rrca			;8bc6
	rrca			;8bc7
	rrca			;8bc8
	rrca			;8bc9
	push af			;8bca
	ld hl,08e81h		;8bcb
	ld a,(0c207h)		;8bce   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8bd1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;8bd4
	call 04d07h		;8bd5   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;8bd8
	push hl			;8bd9
	and 00fh		;8bda
	dec a			;8bdc
	ld b,a			;8bdd
	ld a,(0c205h)		;8bde   ; lee el ancho de la ficha
	ld c,a			;8be1
	call multiplica_b_c		;8be2   ; multiplica_b_c: A = B x C
	pop hl			;8be5
	add a,l			;8be6
	ld (0c201h),a		;8be7   ; guarda la X de la ficha en la hoja de tiles
	ld a,h			;8bea
	ld (0c202h),a		;8beb   ; guarda la Y de la ficha en la hoja de tiles
	jp L_8BF1		;8bee
L_8BF1:
	ld d,005h		;8bf1
L_8BF3:
	push de			;8bf3
	ld a,(0c201h)		;8bf4   ; lee la X de la ficha en la hoja de tiles
	ld h,a			;8bf7
	ld a,(0c202h)		;8bf8   ; lee la Y de la ficha en la hoja de tiles
	ld l,a			;8bfb
	ld a,(0c205h)		;8bfc   ; lee el ancho de la ficha
	ld b,a			;8bff
	ld a,(0c206h)		;8c00   ; lee el alto de la ficha
	ld c,a			;8c03
	ld de,0e800h		;8c04
	ld a,010h		;8c07
	call 050e1h		;8c09   ; vdp_lmcm: LMCM: lee un rectangulo de la VRAM a DE
	pop de			;8c0c
	ld bc,00240h		;8c0d
	ld hl,0e800h		;8c10
L_8C13:
	ld a,(hl)			;8c13
	cp 00eh		;8c14
	jr nz,L_8C19		;8c16
	ld (hl),d			;8c18
L_8C19:
	cp 007h		;8c19
	jr nz,L_8C1E		;8c1b
	ld (hl),d			;8c1d
L_8C1E:
	inc hl			;8c1e
	dec bc			;8c1f
	ld a,b			;8c20
	or c			;8c21
	jr nz,L_8C13		;8c22
	ld a,(0c203h)		;8c24   ; lee la X donde se dibuja la ficha
	ld d,a			;8c27
	ld a,(0c204h)		;8c28   ; lee la Y donde se dibuja la ficha
	ld e,a			;8c2b
	ld a,(0c205h)		;8c2c   ; lee el ancho de la ficha
	ld b,a			;8c2f
	ld a,(0c206h)		;8c30   ; lee el alto de la ficha
	ld c,a			;8c33
	ld hl,0e800h		;8c34
	ld a,008h		;8c37
	jp 05074h		;8c39   ; vdp_lmmc: LMMC: manda al VDP un rectangulo con puntos de HL
L_8C3C:
	ld a,028h		;8c3c   ; ficha normal: copia con HMMM del hueco de la hoja a su sitio
	push af			;8c3e
	ld a,(0c201h)		;8c3f   ; lee la X de la ficha en la hoja de tiles
	ld h,a			;8c42
	ld a,(0c202h)		;8c43   ; lee la Y de la ficha en la hoja de tiles
	ld l,a			;8c46
	ld a,(0c203h)		;8c47   ; lee la X donde se dibuja la ficha
	ld d,a			;8c4a
	ld a,(0c204h)		;8c4b   ; lee la Y donde se dibuja la ficha
	ld e,a			;8c4e
	ld a,(0c205h)		;8c4f   ; lee el ancho de la ficha
	ld b,a			;8c52
	ld a,(0c206h)		;8c53   ; lee el alto de la ficha
	ld c,a			;8c56
	pop af			;8c57
	jp 05151h		;8c58   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)
roba_ficha_dibuja:		; pone la ficha del muro en 0xC209 y la dibuja
	ld hl,0c100h		;8c5b   ; pone en 0xC209 la ficha del muro y la dibuja
	ld a,(0c1c1h)		;8c5e   ; lee cuantas fichas se han robado del muro
	call 0405ch		;8c61   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8c64
	ld (0c209h),a		;8c65   ; guarda la ficha robada o tirada
dibuja_ficha_robada:		; dibuja la ficha 0xC209 en su sitio
	call sitio_de_la_ficha		;8c68   ; pone en 0xC203/0xC204 el sitio de la ficha 0xC200 de la mano y la dibuja (8C7C da el tamano)
	ld a,l			;8c6b
	ld (0c203h),a		;8c6c   ; guarda la X donde se dibuja la ficha
	ld a,h			;8c6f
	ld (0c204h),a		;8c70   ; guarda la Y donde se dibuja la ficha
	call tamano_ficha		;8c73   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c209h)		;8c76   ; lee la ficha robada o tirada
	jp dibuja_ficha		;8c79   ; dibuja_ficha: dibuja la ficha A del jugador 0xC207
tamano_ficha:		; 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c207h)		;8c7c   ; tamano de la ficha del jugador 0xC207: 0xC205 de ancho, 0xC206 de alto (tabla 0x8EB1)
	ld hl,08eb1h		;8c7f
	call 04d07h		;8c82   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,l			;8c85
	ld (0c205h),a		;8c86   ; guarda el ancho de la ficha
	ld a,h			;8c89
	ld (0c206h),a		;8c8a   ; guarda el alto de la ficha
	ret			;8c8d
L_8C8E:
	ld a,(0c207h)		;8c8e   ; cambia de sitio la ficha 0xC209 con una de la mano (jugador de 0xC20D)
	push af			;8c91
	ld a,(0c20dh)		;8c92   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;8c95   ; guarda el jugador al que le toca (0 = el humano)
	call L_96C7		;8c98   ; cuenta las fichas de la mano que valen (sin los bits 6-7): deja 0xC200 = la ultima
	pop af			;8c9b
	ld (0c207h),a		;8c9c   ; guarda el jugador al que le toca (0 = el humano)
	jp L_8CA5		;8c9f
L_8CA2:
	call L_96C7		;8ca2   ; pone en la mano la ficha de 0xC209 en lugar de la de la posicion 0xC20A
L_8CA5:
	ld hl,0c200h		;8ca5   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;8ca8
	ld a,(0c20ah)		;8ca9   ; lee la posicion de la ficha en la mano
	cp (hl)			;8cac
	jr z,L_8CC2		;8cad
	call 05e54h		;8caf   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	ld a,(0c20ah)		;8cb2   ; lee la posicion de la ficha en la mano
	call 0405ch		;8cb5   ; suma_a_hl: HL = HL + A
	ld a,(0c209h)		;8cb8   ; lee la ficha robada o tirada
	push af			;8cbb
	ld a,(hl)			;8cbc
	ld (0c209h),a		;8cbd   ; guarda la ficha robada o tirada
	pop af			;8cc0
	ld (hl),a			;8cc1
L_8CC2:
	ret			;8cc2
sitio_de_la_ficha:		; calcula el sitio de la ficha 0xC200 + 1 de la mano
	call L_96C7		;8cc3   ; calcula el sitio (X en L, Y en H) de la ficha 0xC200 + 1 de la mano del jugador (tablas 0x8EB9 y 0x8EA9)
	ld a,(0c200h)		;8cc6   ; lee contador de trabajo de las fichas de la mano
	inc a			;8cc9
L_8CCA:
	push af			;8cca
	ld a,(0c207h)		;8ccb   ; lee el jugador al que le toca (0 = el humano)
	ld hl,08eb9h		;8cce
	call 04d07h		;8cd1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;8cd4
	push af			;8cd5
	push hl			;8cd6
	ld b,a			;8cd7
	ld c,l			;8cd8
	call multiplica_b_c		;8cd9   ; multiplica_b_c: A = B x C
	ld e,a			;8cdc
	pop hl			;8cdd
	pop af			;8cde
	ld b,a			;8cdf
	ld c,h			;8ce0
	call multiplica_b_c		;8ce1   ; multiplica_b_c: A = B x C
	ld d,a			;8ce4
	ld a,(0c207h)		;8ce5   ; lee el jugador al que le toca (0 = el humano)
	ld hl,08ea9h		;8ce8
	call 04d07h		;8ceb   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,l			;8cee
	add a,e			;8cef
	ld l,a			;8cf0
	ld a,h			;8cf1
	add a,d			;8cf2
	ld h,a			;8cf3
	ret			;8cf4
dibuja_mano:		; dibuja las 13 fichas de la mano del jugador 0xC207
	xor a			;8cf5   ; dibuja las 13 fichas de la mano del jugador 0xC207; acaba al llegar a una ficha vacia o con los bits 6-7 puestos
	ld (0c200h),a		;8cf6   ; guarda contador de trabajo de las fichas de la mano
	ld a,(0c207h)		;8cf9   ; lee el jugador al que le toca (0 = el humano)
	ld hl,08ea9h		;8cfc
	call 04d07h		;8cff   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,l			;8d02
	ld (0c203h),a		;8d03   ; guarda la X donde se dibuja la ficha
	ld a,h			;8d06
	ld (0c204h),a		;8d07   ; guarda la Y donde se dibuja la ficha
	call tamano_ficha		;8d0a   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
L_8D0D:
	call 05e54h		;8d0d   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	ld a,(0c200h)		;8d10   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;8d13   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8d16
	and a			;8d17
	ret z			;8d18
	and 0c0h		;8d19
	ret nz			;8d1b
	ld a,(hl)			;8d1c
	call dibuja_ficha		;8d1d   ; dibuja_ficha: dibuja la ficha A del jugador 0xC207
	ld hl,08eb9h		;8d20
	ld a,(0c207h)		;8d23   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8d26   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c203h)		;8d29   ; lee la X donde se dibuja la ficha
	add a,l			;8d2c
	ld (0c203h),a		;8d2d   ; guarda la X donde se dibuja la ficha
	ld a,(0c204h)		;8d30   ; lee la Y donde se dibuja la ficha
	add a,h			;8d33
	ld (0c204h),a		;8d34   ; guarda la Y donde se dibuja la ficha
	ld hl,0c200h		;8d37   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;8d3a
	ld a,(hl)			;8d3b
	cp 00dh		;8d3c
	ret z			;8d3e
	jp L_8D0D		;8d3f
descarta:		; descarta la ficha 0xC209 del jugador 0xC207
	xor a			;8d42   ; DESCARTA la ficha 0xC209 del jugador 0xC207: sonido 0x0C y calcula su sitio en la mesa de descartes (0xD030, 0xC244, 0xC245)
	ld (0cd0dh),a		;8d43   ; guarda 1 si se gana con la ficha del kan de otro
	ld (0cd0ch),a		;8d46   ; guarda 1 si se gana con la ficha de un kan
	call 0410ch		;8d49   ; pide_sonido_04: pide el sonido 0x04
	ld hl,0d030h		;8d4c
	ld a,(0c207h)		;8d4f   ; lee el jugador al que le toca (0 = el humano)
	call hl_mano_de_a		;8d52   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(hl)			;8d55
	ld (0c203h),a		;8d56   ; guarda la X donde se dibuja la ficha
	ld (0c244h),a		;8d59
	inc l			;8d5c
	ld a,(hl)			;8d5d
	ld (0c204h),a		;8d5e   ; guarda la Y donde se dibuja la ficha
	ld (0c245h),a		;8d61
	ld hl,0d034h		;8d64   ; si el sitio vale 0xFF ya no cabe en la fila y baja a otra (0x8EC1)
	ld a,(0c207h)		;8d67   ; lee el jugador al que le toca (0 = el humano)
	call hl_mano_de_a		;8d6a   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(hl)			;8d6d
	cp 0ffh		;8d6e
	jr nz,L_8DD7		;8d70
	push hl			;8d72
	ld a,(0c207h)		;8d73   ; lee el jugador al que le toca (0 = el humano)
	ld hl,08ec1h		;8d76
	call 04d07h		;8d79   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c203h)		;8d7c   ; lee la X donde se dibuja la ficha
	ld d,a			;8d7f
	ld a,(0c204h)		;8d80   ; lee la Y donde se dibuja la ficha
	ld e,a			;8d83
	ld a,l			;8d84
	add a,d			;8d85
	ld (0c203h),a		;8d86   ; guarda la X donde se dibuja la ficha
	ld (0c244h),a		;8d89
	inc hl			;8d8c
	ld a,h			;8d8d
	add a,e			;8d8e
	ld (0c204h),a		;8d8f   ; guarda la Y donde se dibuja la ficha
	ld (0c245h),a		;8d92
	ld hl,0c207h		;8d95   ; dibuja la ficha en su sitio y avanza la posicion segun el jugador (tabla 0x8EC9)
	ld a,(hl)			;8d98
	push af			;8d99
	inc a			;8d9a
	and 003h		;8d9b
	ld (hl),a			;8d9d
	call tamano_ficha		;8d9e   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c209h)		;8da1   ; lee la ficha robada o tirada
	call dibuja_ficha_2		;8da4   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop af			;8da7
	ld (0c207h),a		;8da8   ; guarda el jugador al que le toca (0 = el humano)
	ld hl,08ec9h		;8dab
	ld a,(0c207h)		;8dae   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8db1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;8db4
	ld hl,0d030h		;8db5
	ld a,(0c207h)		;8db8   ; lee el jugador al que le toca (0 = el humano)
	call hl_mano_de_a		;8dbb   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(hl)			;8dbe
	add a,e			;8dbf
	ld (hl),a			;8dc0
	inc l			;8dc1
	ld a,(hl)			;8dc2
	add a,d			;8dc3
	ld (hl),a			;8dc4
	pop hl			;8dc5
	ld a,001h		;8dc6
	ld (hl),a			;8dc8
	ld hl,(0c0deh)		;8dc9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00071h		;8dcc
	add hl,de			;8dcf
	ld a,(0c1c1h)		;8dd0   ; lee cuantas fichas se han robado del muro
	ld (hl),a			;8dd3
	jp L_8DE0		;8dd4
L_8DD7:
	call tamano_ficha		;8dd7   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c209h)		;8dda   ; lee la ficha robada o tirada
	call dibuja_ficha_2		;8ddd   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
L_8DE0:
	ld hl,08eb9h		;8de0   ; la posicion del siguiente descarte sube segun el jugador (0x8EB9 suma, 0x8E50 guarda)
	ld a,(0c207h)		;8de3   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8de6   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;8de9
	ld hl,08e50h		;8dea
	ld a,(0c207h)		;8ded   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;8df0   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(hl)			;8df3
	add a,e			;8df4
	ld (hl),a			;8df5
	inc hl			;8df6
	ld a,(hl)			;8df7
	add a,d			;8df8
	ld (hl),a			;8df9
	ld a,(0c207h)		;8dfa   ; mete la ficha en la lista de descartes de la mano (+0x0F cuenta, +0x10 lista)
	ld hl,0d00fh		;8dfd
	call hl_mano_de_a		;8e00   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(hl)			;8e03
	push hl			;8e04
	push af			;8e05
	ld a,(0c207h)		;8e06   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0d010h		;8e09
	call hl_mano_de_a		;8e0c   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	pop af			;8e0f
	call 0405ch		;8e10   ; suma_a_hl: HL = HL + A
	ld a,(0c209h)		;8e13   ; lee la ficha robada o tirada
	ld (hl),a			;8e16
	pop hl			;8e17
	ld a,(hl)			;8e18
	inc a			;8e19
	ld (hl),a			;8e1a
	call 0b890h		;8e1b   ; ajusta (0xB890) y cuenta los descartes: 0x87D0 y 0x8A08
	call L_87D0		;8e1e   ; cuenta en 0xC510 las fichas iguales o cercanas a la tirada (bit 0 igual, bit 1 siguiente, bit 2 con hueco)
	call L_8A08		;8e21   ; mira las cuatro manos: si alguna tiene +0x34 a cero no pasa nada; si todas lo tienen, pone 0xC0CF = 1 y 0xC0B8 = 2 (fin de la ronda)
	ld a,(0c207h)		;8e24   ; si lleva 10 descartes, cambia el sitio de los siguientes (tabla 0x8E58)
	ld hl,0d00fh		;8e27
	call hl_mano_de_a		;8e2a   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	ld a,(hl)			;8e2d
	cp 00ah		;8e2e
	ret nz			;8e30
	ld a,(0c207h)		;8e31   ; lee el jugador al que le toca (0 = el humano)
	ld hl,0d030h		;8e34
	call hl_mano_de_a		;8e37   ; hl_mano_de_a: H += 4 x A (la mano del jugador A)
	push hl			;8e3a
	ld a,(0c207h)		;8e3b   ; lee el jugador al que le toca (0 = el humano)
	ld hl,08e58h		;8e3e
	call 04d07h		;8e41   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(hl)			;8e44
	ld d,a			;8e45
	inc hl			;8e46
	ld a,(hl)			;8e47
	ld e,a			;8e48
	pop hl			;8e49
	ld a,d			;8e4a
	ld (hl),a			;8e4b
	inc l			;8e4c
	ld a,e			;8e4d
	ld (hl),a			;8e4e
	ret			;8e4f

; ----------------------------------------------------------------------
; DATOS resto_8E50: lo apuntan con el banco puesto p02:8DEA (0x8E50), p02:8E3E
;   (0x8E58); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8DEA, p02:8E3E (24 bytes)
;   0x8e50..0x8e68  (24 bytes)
DATA_resto_8E50:
	defb 030h,0d0h,030h,0d4h,030h,0d8h,030h,0dch,060h,08eh,062h,08eh,064h,08eh,066h,08eh	; 8e50  0.0.0.0.`.b.d.f.
	defb 043h,0a4h,0d4h,096h,0b1h,01ah,01bh,02eh	; 8e60  C.......

; ======================================================================
; CODIGO 0x8e68..0x8e81  (25 bytes)
; ======================================================================


posicion_descartes:		; pone la posicion inicial de los descartes de los cuatro
	ld hl,09143h		;8e68   ; pone la posicion inicial de los descartes de los cuatro jugadores (0xD030, 0xD430, 0xD830, 0xDC30)
	ld (0d030h),hl		;8e6b
	ld hl,096c1h		;8e6e
	ld (0d430h),hl		;8e71
	ld hl,02db1h		;8e74
	ld (0d830h),hl		;8e77
	ld hl,02e2eh		;8e7a
	ld (0dc30h),hl		;8e7d
	ret			;8e80

; ----------------------------------------------------------------------
; DATOS resto_8E81: lo apuntan con el banco puesto p02:8B94 (0x8E81), p02:8BCB
;   (0x8E81), p02:8CE8 (0x8EA9), p02:8CFC (0x8EA9), p02:8C7F (0x8EB1),
;   p02:8CCE (0x8EB9); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8B94, p02:8BCB, p02:8CE8, p02:8CFC, p02:8C7F,
;   p02:8CCE (88 bytes)
;   0x8e81..0x8ed9  (88 bytes)
DATA_resto_8E81:
	defb 089h,08eh,091h,08eh,099h,08eh,0a1h,08eh,000h,000h,06ch,000h,000h,012h,06ch,012h	; 8e81  ..........l...l.
	defb 000h,048h,000h,054h,000h,060h,000h,06ch,000h,024h,06ch,024h,000h,036h,06ch,036h	; 8e91  .H.T.`.l.$l$.6l6
	defb 000h,078h,000h,084h,000h,090h,000h,09ch,020h,0beh,0eah,0c4h,0d4h,000h,004h,000h	; 8ea1  .x...... .......
	defb 00ch,012h,012h,00ch,00ch,012h,012h,00ch,00ch,000h,000h,0f4h,0f4h,000h,000h,00ch	; 8eb1  ................
	defb 000h,006h,006h,0fah,0fah,000h,000h,000h,006h,000h,000h,0fah,0fah,000h,000h,006h	; 8ec1  ................
	defb 00eh,0d0h,00eh,0d4h,00eh,0d8h,00eh,0dch	; 8ed1  ........

; ======================================================================
; CODIGO 0x8ed9..0x8edf  (6 bytes)
; ======================================================================


L_8ED9:
	ld a,(0c02ch)		;8ed9   ; estado de la pantalla de la ronda inicial (0xC02C): elige por la tabla de 0x8EDD
	call 04066h		;8edc   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8EDF: 8 destinos del despachador p00:4066 (call en p02:8EDC, el
;   indice en A): 8EEF, 8F0B, 8F13, 8F32, 8F4B, 8F56, 8F75, 8F94; lo leen
;   p02:8EDC (16 bytes)
;   0x8edf..0x8eef  (16 bytes)
DATA_tabla_8EDF:
	defw 08eefh,08f0bh,08f13h,08f32h,08f4bh,08f56h,08f75h,08f94h	; 8edf

; ======================================================================
; CODIGO 0x8eef..0x8fd3  (228 bytes)
; ======================================================================


L_8EEF:
	call 0599ah		;8eef   ; carga el fondo del banco 5 y 6 (0x599A) y pinta dos rectangulos con 0x909D (jugadores 0 y 1)
L_8EF2:
	call 04258h		;8ef2   ; bancos_11: pone el 11 (y sus copias en 0xF0F1-3)
	ld b,000h		;8ef5
	ld a,000h		;8ef7
	call L_909D		;8ef9   ; prepara el dado B (0 o 1): su posicion y su movimiento en la tabla 0x9125 (de 8 bytes cada uno)
	ld b,001h		;8efc
	ld a,001h		;8efe
	call L_909D		;8f00   ; prepara el dado B (0 o 1): su posicion y su movimiento en la tabla 0x9125 (de 8 bytes cada uno)
	call 04207h		;8f03   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld hl,0c02ch		;8f06   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f09
	ret			;8f0a
L_8F0B:
	call 04111h		;8f0b   ; suena el sonido 0x05 y pasa al paso siguiente
	ld hl,0c02ch		;8f0e   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f11
	ret			;8f12
L_8F13:
	call 04258h		;8f13   ; anima el dado 1 (0x90C7) hasta que la fase llega a 0x48
	call L_90C7		;8f16   ; mueve los dos dados: avanza el cuadro de la animacion de cada uno (0x9129, 0x911C)
	call 04207h		;8f19   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld a,(0c246h)		;8f1c   ; lee el dado que se mueve
	ld hl,09125h		;8f1f
	call 04d07h		;8f22   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld de,00005h		;8f25
	add hl,de			;8f28
	ld a,(hl)			;8f29
	cp 048h		;8f2a
	ret nc			;8f2c
	ld hl,0c02ch		;8f2d   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f30
	ret			;8f31
L_8F32:
	call 04258h		;8f32   ; tira los dados: 0x904A, y pinta el cuadro del jugador que empieza (0x8F9F y 0x8FE3)
	call L_904A		;8f35   ; TIRA LOS DOS DADOS: 0xC02B = suma de dos numeros al azar (0xC003 + 0x65B2) segun la tabla 0x908D; 0xC246 = 0 y despues 1
	call 04207h		;8f38   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call L_8F9F		;8f3b   ; pinta el cuadro con el viento del jugador que empieza (coordenadas 0x8FDB y 0x8FD3)
	call L_8FE3		;8f3e   ; pone en 0xC207 el jugador que empieza: 0xC02B + el actual, modulo 4
	ld a,080h		;8f41
	ld (0c004h),a		;8f43   ; guarda el temporizador de espera entre pasos
	ld hl,0c02ch		;8f46   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f49
	ret			;8f4a
L_8F4B:
	ld hl,0c004h		;8f4b   ; espera 0x80 cuadros (0xC004)
	dec (hl)			;8f4e
	ret nz			;8f4f
	call L_8EF2		;8f50
	jp 04111h		;8f53   ; pide_sonido_05: pide el sonido 0x05
L_8F56:
	call 04258h		;8f56   ; anima el dado 2
	call L_90C7		;8f59   ; mueve los dos dados: avanza el cuadro de la animacion de cada uno (0x9129, 0x911C)
	call 04207h		;8f5c   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld a,(0c246h)		;8f5f   ; lee el dado que se mueve
	ld hl,09125h		;8f62
	call 04d07h		;8f65   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld de,00005h		;8f68
	add hl,de			;8f6b
	ld a,(hl)			;8f6c
	cp 048h		;8f6d
	ret nc			;8f6f
	ld hl,0c02ch		;8f70   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f73
	ret			;8f74
L_8F75:
	call L_900A		;8f75   ; pone el jugador que empieza y quita el cuadro de 0x900A
	call 04258h		;8f78   ; bancos_11: pone el 11 (y sus copias en 0xF0F1-3)
	call L_904A		;8f7b   ; TIRA LOS DOS DADOS: 0xC02B = suma de dos numeros al azar (0xC003 + 0x65B2) segun la tabla 0x908D; 0xC246 = 0 y despues 1
	call 04207h		;8f7e   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call L_8F9F		;8f81   ; pinta el cuadro con el viento del jugador que empieza (coordenadas 0x8FDB y 0x8FD3)
	call L_9024		;8f84   ; pone 0xC0B6 = el jugador que empieza y pinta el texto de la ronda (A = 0x15)
	call 041a3h		;8f87   ; pide_orden_81: pide la orden 0x81 del motor de sonido (ritmo)
	ld a,080h		;8f8a
	ld (0c004h),a		;8f8c   ; guarda el temporizador de espera entre pasos
	ld hl,0c02ch		;8f8f   ; apunta a el paso o la opcion de la pantalla de menu
	inc (hl)			;8f92
	ret			;8f93
L_8F94:
	ld hl,0c004h		;8f94   ; acaba: 0xC02A = 1
	dec (hl)			;8f97
	ret nz			;8f98
	ld a,001h		;8f99
	ld (0c02ah),a		;8f9b   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;8f9e
L_8F9F:
	ld a,(0c02bh)		;8f9f   ; pinta el cuadro con el viento del jugador que empieza (coordenadas 0x8FDB y 0x8FD3)
	ld hl,0c207h		;8fa2   ; apunta a el jugador al que le toca (0 = el humano)
	add a,(hl)			;8fa5
	and 003h		;8fa6
	add a,a			;8fa8
	push af			;8fa9
	ld hl,08fdbh		;8faa
	call 0405ch		;8fad   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8fb0
	ld d,a			;8fb1
	inc hl			;8fb2
	ld a,(hl)			;8fb3
	ld e,a			;8fb4
	ex de,hl			;8fb5
	ld bc,02818h		;8fb6
	ld d,000h		;8fb9
	ld a,099h		;8fbb
	call 04fe5h		;8fbd   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	pop af			;8fc0
	ld hl,08fd3h		;8fc1
	call 0405ch		;8fc4   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8fc7
	ld d,a			;8fc8
	inc hl			;8fc9
	ld a,(hl)			;8fca
	ld e,a			;8fcb
	ld hl,00604h		;8fcc
	call ventana		;8fcf   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ret			;8fd2

; ----------------------------------------------------------------------
; DATOS resto_8FD3: lo apuntan con el banco puesto p02:8FC1 (0x8FD3), p02:900E
;   (0x8FD3), p02:8FAA (0x8FDB); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p02:8FC1, p02:900E, p02:8FAA (16 bytes)
;   0x8fd3..0x8fe3  (16 bytes)
DATA_resto_8FD3:
	defb 068h,0a0h,0c0h,080h,068h,048h,010h,080h,06ch,0a4h,0c4h,084h,06ch,04ch,014h,084h	; 8fd3  h...hH..l...lL..

; ======================================================================
; CODIGO 0x8fe3..0x8fff  (28 bytes)
; ======================================================================


L_8FE3:
	ld a,(0c02bh)		;8fe3   ; pone en 0xC207 el jugador que empieza: 0xC02B + el actual, modulo 4
	ld hl,0c207h		;8fe6   ; apunta a el jugador al que le toca (0 = el humano)
	add a,(hl)			;8fe9
	and 003h		;8fea
	ld (hl),a			;8fec
	add a,a			;8fed
	ld hl,09002h		;8fee
	call 0405ch		;8ff1   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;8ff4
	ld d,a			;8ff5
	inc hl			;8ff6
	ld a,(hl)			;8ff7
	ld e,a			;8ff8
	ld hl,08fffh		;8ff9
	jp 05acdh		;8ffc   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E

; ----------------------------------------------------------------------
; DATOS resto_8FFF: lo apuntan con el banco puesto p02:8FF9 (0x8FFF), p00:4026
;   (0x9000), p00:4093 (0x9000), p00:41E2 (0x9000), p00:4216 (0x9000),
;   p00:4239 (0x9000); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8FF9, p00:4026, p00:4093, p00:41E2, p00:4216,
;   p00:4239 (11 bytes)
;   0x8fff..0x900a  (11 bytes)
DATA_resto_8FFF:
	defb 094h,015h,0ffh,070h,0a8h,0c8h,088h,070h,050h,018h,088h	; 8fff  ...p...pP..

; ======================================================================
; CODIGO 0x900a..0x9042  (56 bytes)
; ======================================================================


L_900A:
	ld a,(0c207h)		;900a   ; borra el cuadro del jugador 0xC207
	add a,a			;900d
	ld hl,08fd3h		;900e
	call 0405ch		;9011   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9014
	ld d,a			;9015
	inc hl			;9016
	ld a,(hl)			;9017
	ld e,a			;9018
	ex de,hl			;9019
	ld bc,03020h		;901a
	ld d,000h		;901d
	ld a,000h		;901f
	jp 04fe5h		;9021   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
L_9024:
	ld a,(0c02bh)		;9024   ; pone 0xC0B6 = el jugador que empieza y pinta el texto de la ronda (A = 0x15)
	ld hl,0c207h		;9027   ; apunta a el jugador al que le toca (0 = el humano)
	add a,(hl)			;902a
	and 003h		;902b
	ld (hl),a			;902d
	ld (0c0b6h),a		;902e   ; guarda quien reparte en la primera mano
	add a,a			;9031
	ld hl,09042h		;9032
	call 0405ch		;9035   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9038
	ld d,a			;9039
	inc hl			;903a
	ld a,(hl)			;903b
	ld e,a			;903c
	ld a,015h		;903d
	jp 05b23h		;903f

; ----------------------------------------------------------------------
; DATOS resto_9042: lo apuntan con el banco puesto p02:9032 (0x9042); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9032 (8 bytes)
;   0x9042..0x904a  (8 bytes)
DATA_resto_9042:
	defb 078h,0a8h,0d0h,088h,078h,050h,020h,088h	; 9042  x...xP .

; ======================================================================
; CODIGO 0x904a..0x908d  (67 bytes)
; ======================================================================


L_904A:
	xor a			;904a   ; TIRA LOS DOS DADOS: 0xC02B = suma de dos numeros al azar (0xC003 + 0x65B2) segun la tabla 0x908D; 0xC246 = 0 y despues 1
	ld (0c02bh),a		;904b   ; guarda variable de los pasos de las pantallas de menu
	call 065b2h		;904e   ; azar: numero al azar en A
	ld hl,0c003h		;9051   ; apunta a el contador de cuadros
	add a,(hl)			;9054
	push af			;9055
	and 00fh		;9056
	ld hl,0908dh		;9058
	call 0405ch		;905b   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;905e
	push af			;905f
	sub 00bh		;9060
	ld hl,0c02bh		;9062   ; apunta a variable de los pasos de las pantallas de menu
	ld (hl),a			;9065
	xor a			;9066
	ld (0c246h),a		;9067   ; guarda el dado que se mueve
	pop af			;906a
	call L_9149		;906b   ; dibuja el dado: A = su cara (tabla 0xBF48, 5 bytes por cara): pone 4 sprites (0xCC00, 16 bytes por dado) y 4 filas de colores de 16 bytes (0xCA00..)
	pop af			;906e
	rrca			;906f
	rrca			;9070
	rrca			;9071
	rrca			;9072
	and 00fh		;9073
	ld hl,0908dh		;9075
	call 0405ch		;9078   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;907b
	push af			;907c
	sub 00ah		;907d
	ld hl,0c02bh		;907f   ; apunta a variable de los pasos de las pantallas de menu
	add a,(hl)			;9082
	ld (hl),a			;9083
	ld a,001h		;9084
	ld (0c246h),a		;9086   ; guarda el dado que se mueve
	pop af			;9089
	jp L_9149		;908a

; ----------------------------------------------------------------------
; DATOS resto_908D: lo apuntan con el banco puesto p02:9058 (0x908D), p02:9075
;   (0x908D); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:9058, p02:9075 (16 bytes)
;   0x908d..0x909d  (16 bytes)
DATA_resto_908D:
	defb 00bh,00dh,00fh,00ch,010h,00ch,00eh,00eh,010h,00ch,00eh,00bh,00dh,00dh,00fh,00bh	; 908d  ................

; ======================================================================
; CODIGO 0x909d..0x9125  (136 bytes)
; ======================================================================


L_909D:
	ld hl,09125h		;909d   ; prepara el dado B (0 o 1): su posicion y su movimiento en la tabla 0x9125 (de 8 bytes cada uno)
	call 04d07h		;90a0   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;90a3
	ld de,00003h		;90a4
	add hl,de			;90a7
	ld a,b			;90a8
	ld (hl),a			;90a9
	ld hl,0bf00h		;90aa
	call 04d07h		;90ad   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(hl)			;90b0
	ld d,a			;90b1
	inc hl			;90b2
	inc hl			;90b3
	ld a,(hl)			;90b4
	pop hl			;90b5
	push hl			;90b6
	ld (hl),a			;90b7
	inc hl			;90b8
	ld a,d			;90b9
	ld (hl),a			;90ba
	inc hl			;90bb
	xor a			;90bc
	ld (hl),a			;90bd
	pop hl			;90be
	ld de,00005h		;90bf
	add hl,de			;90c2
	ld a,0d0h		;90c3
	ld (hl),a			;90c5
	ret			;90c6
L_90C7:
	ld b,002h		;90c7   ; mueve los dos dados: avanza el cuadro de la animacion de cada uno (0x9129, 0x911C)
	xor a			;90c9
L_90CA:
	push bc			;90ca
	push af			;90cb
	ld (0c246h),a		;90cc   ; guarda el dado que se mueve
	call L_9129		;90cf   ; baja en uno el contador de cuadros del dado (campo 5 de su fila)
	call L_911C		;90d2   ; HL = fila del dado 0xC246 en la tabla 0x9125 (8 bytes por dado)
	inc hl			;90d5
	dec (hl)			;90d6
	ld a,(hl)			;90d7
	and a			;90d8
	jp nz,L_9113		;90d9
	push hl			;90dc
	inc hl			;90dd
	inc (hl)			;90de
	inc hl			;90df
	ld a,(hl)			;90e0
	ld hl,0bf00h		;90e1
	call 04d07h		;90e4   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(hl)			;90e7
	pop hl			;90e8
	ld (hl),a			;90e9
	inc hl			;90ea
	push hl			;90eb
	inc hl			;90ec
	ld a,(hl)			;90ed
	ld hl,0bf00h		;90ee
	call 04d07h		;90f1   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	inc hl			;90f4
	ld a,(hl)			;90f5
	pop hl			;90f6
	cp (hl)			;90f7
	jr nz,L_90FC		;90f8
	xor a			;90fa
	ld (hl),a			;90fb
L_90FC:
	ld a,(hl)			;90fc
	push af			;90fd
	inc hl			;90fe
	ld a,(hl)			;90ff
	ld hl,0bf00h		;9100
	call 04d07h		;9103   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	inc hl			;9106
	inc hl			;9107
	pop af			;9108
	call 0405ch		;9109   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;910c
	push af			;910d
	call L_911C		;910e   ; HL = fila del dado 0xC246 en la tabla 0x9125 (8 bytes por dado)
	pop af			;9111
	ld (hl),a			;9112
L_9113:
	call L_913B		;9113   ; lee el cuadro del dado (campo 0 de su fila) y sigue en 0x9149
	pop af			;9116
	inc a			;9117
	pop bc			;9118
	djnz L_90CA		;9119
	ret			;911b
L_911C:
	ld a,(0c246h)		;911c   ; HL = fila del dado 0xC246 en la tabla 0x9125 (8 bytes por dado)
	ld hl,09125h		;911f
	jp 04d07h		;9122   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL

; ----------------------------------------------------------------------
; DATOS resto_9125: lo apuntan con el banco puesto p02:8F1F (0x9125), p02:8F62
;   (0x9125), p02:909D (0x9125), p02:911F (0x9125), p02:912C (0x9125),
;   p02:913E (0x9125); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8F1F, p02:8F62, p02:909D, p02:911F, p02:912C,
;   p02:913E (4 bytes)
;   0x9125..0x9129  (4 bytes)
DATA_resto_9125:
	defb 0a0h,0c2h,0b0h,0c2h	; 9125

; ======================================================================
; CODIGO 0x9129..0x9225  (252 bytes)
; ======================================================================


L_9129:
	ld a,(0c246h)		;9129   ; baja en uno el contador de cuadros del dado (campo 5 de su fila)
	ld hl,09125h		;912c
	call 04d07h		;912f   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld de,00005h		;9132
	add hl,de			;9135
	ld a,(hl)			;9136
	sub 001h		;9137
	ld (hl),a			;9139
	ret			;913a
L_913B:
	ld a,(0c246h)		;913b   ; lee el cuadro del dado (campo 0 de su fila) y sigue en 0x9149
	ld hl,09125h		;913e
	call 04d07h		;9141   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld de,00000h		;9144
	add hl,de			;9147
	ld a,(hl)			;9148
L_9149:
	ld hl,0bf48h		;9149   ; dibuja el dado: A = su cara (tabla 0xBF48, 5 bytes por cara): pone 4 sprites (0xCC00, 16 bytes por dado) y 4 filas de colores de 16 bytes (0xCA00..)
	call 04d07h		;914c   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	push hl			;914f
	ld a,(0c246h)		;9150   ; lee el dado que se mueve
	and 001h		;9153
	rlca			;9155
	rlca			;9156
	rlca			;9157
	rlca			;9158
	ld d,000h		;9159
	ld e,a			;915b
	ld ix,0cc00h		;915c   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	add ix,de		;9160
	pop hl			;9162
	ld a,(hl)			;9163
	ld (ix+002h),a		;9164
	inc hl			;9167
	ld a,(hl)			;9168
	ld (ix+006h),a		;9169
	inc hl			;916c
	ld a,(hl)			;916d
	ld (ix+00ah),a		;916e
	inc hl			;9171
	ld a,(hl)			;9172
	ld (ix+00eh),a		;9173
	inc hl			;9176
	ld a,(hl)			;9177
	push hl			;9178
	push af			;9179
	ld b,010h		;917a
	ld a,(0c246h)		;917c   ; lee el dado que se mueve
	and 001h		;917f
	rrca			;9181
	rrca			;9182
	ld hl,0ca00h		;9183   ; apunta a los colores de los sprites (4 bloques de 16)
	call 0405ch		;9186   ; suma_a_hl: HL = HL + A
	pop af			;9189
L_918A:
	ld (hl),a			;918a
	inc hl			;918b
	djnz L_918A		;918c
	pop hl			;918e
	inc hl			;918f
	ld a,(hl)			;9190
	push hl			;9191
	push af			;9192
	ld b,010h		;9193
	ld a,(0c246h)		;9195   ; lee el dado que se mueve
	rrca			;9198
	rrca			;9199
	ld hl,0ca10h		;919a
	call 0405ch		;919d   ; suma_a_hl: HL = HL + A
	pop af			;91a0
L_91A1:
	ld (hl),a			;91a1
	inc hl			;91a2
	djnz L_91A1		;91a3
	pop hl			;91a5
	inc hl			;91a6
	ld a,(hl)			;91a7
	push hl			;91a8
	push af			;91a9
	ld b,010h		;91aa
	ld a,(0c246h)		;91ac   ; lee el dado que se mueve
	rrca			;91af
	rrca			;91b0
	ld hl,0ca20h		;91b1
	call 0405ch		;91b4   ; suma_a_hl: HL = HL + A
	pop af			;91b7
L_91B8:
	ld (hl),a			;91b8
	inc hl			;91b9
	djnz L_91B8		;91ba
	pop hl			;91bc
	inc hl			;91bd
	ld a,(hl)			;91be
	push af			;91bf
	ld b,010h		;91c0
	ld a,(0c246h)		;91c2   ; lee el dado que se mueve
	rrca			;91c5
	rrca			;91c6
	ld hl,0ca30h		;91c7
	call 0405ch		;91ca   ; suma_a_hl: HL = HL + A
	pop af			;91cd
L_91CE:
	ld (hl),a			;91ce   ; rellena de color los dieciseis bytes y pone el nivel del dado
	inc hl			;91cf
	djnz L_91CE		;91d0
	call L_911C		;91d2   ; pone la Y y la X de los cuatro sprites del dado a 0x90 y 0x60
	ld de,00005h		;91d5
	add hl,de			;91d8
	ld a,(hl)			;91d9
	push af			;91da
	ld a,(0c246h)		;91db   ; lee el dado que se mueve
	and 001h		;91de
	rlca			;91e0
	rlca			;91e1
	rlca			;91e2
	rlca			;91e3
	ld d,000h		;91e4
	ld e,a			;91e6
	ld ix,0cc00h		;91e7   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	add ix,de		;91eb
	pop af			;91ed
	ld (ix+000h),a		;91ee
	ld (ix+004h),a		;91f1
	ld (ix+008h),a		;91f4
	ld (ix+00ch),a		;91f7
	ld a,090h		;91fa
	ld (0cc01h),a		;91fc
	ld (0cc05h),a		;91ff
	ld (0cc09h),a		;9202
	ld (0cc0dh),a		;9205
	ld a,060h		;9208
	ld (0cc11h),a		;920a
	ld (0cc15h),a		;920d
	ld (0cc19h),a		;9210
	ld (0cc1dh),a		;9213
	ret			;9216
turno_jugador:		; un paso del turno del jugador 0xC207
	call 0a747h		;9217   ; TURNO DE UN JUGADOR: 0xA747 y, si 0xC24A es cero, 0xC208 elige el paso por la tabla de 0x9222
	ld a,(0c24ah)		;921a   ; lee el tiempo que queda de la cara que habla
	and a			;921d
	ret nz			;921e
	ld a,(0c208h)		;921f   ; lee el paso del turno
	call 04066h		;9222   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9225: 10 destinos del despachador p00:4066 (call en p02:9222, el
;   indice en A): 9239, 926D, 9290, 92E5, 9304, 9348, 9354, 9382, 9386, 93BD;
;   lo leen p02:9222 (20 bytes)
;   0x9225..0x9239  (20 bytes)
DATA_tabla_9225:
	defw 09239h,0926dh,09290h,092e5h,09304h,09348h,09354h,09382h	; 9225
	defw 09386h,093bdh	; 9235  -> L_9386 L_93BD

; ======================================================================
; CODIGO 0x9239..0x9412  (473 bytes)
; ======================================================================


L_9239:
	call roba_ficha_dibuja		;9239   ; el jugador roba una ficha del muro (8C5B) y la anade (0xB7D1)
	call 0b7d1h		;923c   ; mira si hay un caso de reparto especial: solo con 0xC1C1 entre 0x34 y 0x37 (primer ciclo) y si nadie lleva grupos (+0x0E a cero) (p03:B7D1)
	ld hl,0c208h		;923f   ; apunta a el paso del turno
	ld a,(0c0c7h)		;9242   ; si 0xC0C7 esta a 1, avanza el paso (el jugador ya ha robado)
	and a			;9245
	jr z,L_9261		;9246
	inc (hl)			;9248
	ld a,(0c207h)		;9249   ; lee el jugador al que le toca (0 = el humano)
	and a			;924c
	jr nz,L_927A		;924d
	call L_9CCD		;924f   ; es el humano: 0x9CCD, y deja 0xC0C7 = 0, 0xC213 = 0, 0xC20D = 0, 0xC219 = 1
	xor a			;9252
	ld (0c0c7h),a		;9253   ; guarda 1 si la mano se anula por nueve fichas de punta y honor
	ld (0c213h),a		;9256   ; guarda la opcion elegida en el cuadro
	ld (0c20dh),a		;9259   ; guarda el jugador que responde a la ficha tirada
	inc a			;925c
	ld (0c219h),a		;925d   ; guarda la ultima opcion del cuadro
	ret			;9260
L_9261:
	inc (hl)			;9261
	inc (hl)			;9262
L_9263:
	ld a,(0c207h)		;9263   ; lee el jugador al que le toca (0 = el humano)
	and a			;9266
	jr nz,L_926C		;9267
	call L_93F1		;9269   ; pone el cursor de la mano en la ultima ficha (0xC20A = 0xC211 = 0xC200 + 1)
L_926C:
	ret			;926c
L_926D:
	call L_9A9D		;926d   ; pregunta al humano que ficha tirar (0x9A9D), y pasa por 0x9CFC
	ret nc			;9270
	call L_9CFC		;9271   ; cierra el cuadro de respuesta: devuelve el fondo de la pagina 1
	ld a,(0c213h)		;9274   ; lee la opcion elegida en el cuadro
	and a			;9277
	jr z,L_9289		;9278
L_927A:
	ld a,0e0h		;927a   ; el humano ha ganado: 0xC0C7 = 1 y 0xC0B8 = 2 (fin de la ronda)
	ld (0cc00h),a		;927c   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld a,001h		;927f
	ld (0c0c7h),a		;9281   ; guarda 1 si la mano se anula por nueve fichas de punta y honor
	inc a			;9284
	ld (0c0b8h),a		;9285   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ret			;9288
L_9289:
	ld hl,0c208h		;9289   ; apunta a el paso del turno
	inc (hl)			;928c
	jp L_9263		;928d
L_9290:
	ld a,(0c207h)		;9290   ; el jugador decide tirar: humano por 0x940C, maquina por 0x71CD (y 0x8601 si la ficha le sirve a alguien)
	and a			;9293
	jr nz,L_929C		;9294
	call elige_ficha_humano		;9296   ; elige_ficha_humano: el humano elige la ficha que tira
	jr c,L_92CB		;9299
	ret			;929b
L_929C:
	call 069b8h		;929c   ; prueba si la mano gana (0x69B8) con el bit 4 de +0x60: si es asi, 0xC0B1 = 1 y suena el tsumo (0x4184)
	ld hl,(0c0deh)		;929f   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00060h		;92a2
	add hl,bc			;92a5
	ld a,(hl)			;92a6
	and 010h		;92a7
	jr z,L_92BD		;92a9
	ld a,001h		;92ab
	ld (0c0b1h),a		;92ad   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ld b,004h		;92b0
	ld a,(0c207h)		;92b2   ; lee el jugador al que le toca (0 = el humano)
	call 0a6beh		;92b5   ; muestra_voz: muestra la cara del que habla (A = pon, chi, kan, ron...)
	call 04184h		;92b8   ; voz_tsumo: dice TSUMO: la voz 0x16 con el tono del personaje de 0xC207
	jr L_92CB		;92bb
L_92BD:
	call 071cdh		;92bd   ; turno de un jugador de la maquina: el campo +0x34 de su mano decide si esta en espera (p01:71CD)
	ld a,(0c0c6h)		;92c0
	and a			;92c3
	jr z,L_92CB		;92c4
	call alguien_espera_esa		;92c6   ; alguien_espera_esa: mira si la ficha tirada le sirve a alguien
	jr c,L_929C		;92c9
L_92CB:
	ld a,(0c0b1h)		;92cb   ; si 0xC0B1 = 0 tira la ficha (0x9C93, 0x8CA2, 0x8D42) y pasa al paso siguiente; si no, al paso 7
	and a			;92ce
	jr z,L_92D7		;92cf
	ld a,007h		;92d1
	ld (0c208h),a		;92d3   ; guarda el paso del turno
	ret			;92d6
L_92D7:
	call tapa_ficha_tirada		;92d7   ; tapa_ficha_tirada: tapa en la mano la ficha que se tira
	call L_8CA2		;92da   ; pone en la mano la ficha de 0xC209 en lugar de la de la posicion 0xC20A
	call descarta		;92dd   ; descarta: descarta la ficha 0xC209 del jugador 0xC207
	ld hl,0c208h		;92e0   ; apunta a el paso del turno
	inc (hl)			;92e3
	ret			;92e4
L_92E5:
	ld a,0e0h		;92e5   ; la ficha tirada: la mano se ordena y se dibuja, 0x9CC7, 0x67BF (analiza los otros jugadores) y espera 0x2D cuadros
	ld (0cc00h),a		;92e7   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	call ordena_mano_actual		;92ea   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call dibuja_mano		;92ed   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	call L_9CC7		;92f0
	call 0a1a2h		;92f3   ; si el muro de atras ha llegado a 4 fichas (0xC210), mira si hay cuatro kan (0xA771): si es asi 0xC0B1 = 1; si no, 0xC0B8 = 2 (p03:A1A2)
L_92F6:
	call 067bfh		;92f6   ; analiza_otros: analiza las manos de los otros tres jugadores
L_92F9:
	ld a,02dh		;92f9
	ld (0c004h),a		;92fb   ; guarda el temporizador de espera entre pasos
	ld a,008h		;92fe
	ld (0c208h),a		;9300   ; guarda el paso del turno
	ret			;9303
L_9304:
	ld a,(0c20dh)		;9304   ; respuestas a la ficha tirada: el humano (0x96ED) o la maquina (0x8279)
	and a			;9307
	jr nz,L_9310		;9308
	call respuestas_humano		;930a   ; respuestas_humano: las respuestas del humano a la ficha tirada
	ret nc			;930d
	jr L_9325		;930e
L_9310:
	call respuesta_maquina		;9310   ; respuesta_maquina: decide si la maquina responde a la ficha tirada (ron, kan, pon, chi)
	ld a,(0c213h)		;9313   ; lee la opcion elegida en el cuadro
	and a			;9316
	jr nz,L_9325		;9317
	ld a,(0c0b1h)		;9319   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	and a			;931c
	jr nz,L_9325		;931d
	ld hl,0c208h		;931f   ; apunta a el paso del turno
	dec (hl)			;9322
	jr L_92F9		;9323
L_9325:
	ld hl,0c208h		;9325   ; 0xC216 = la respuesta; si hay una, 0xC20D se convierte en el jugador actual
	ld a,(0c213h)		;9328   ; lee la opcion elegida en el cuadro
	ld (0c216h),a		;932b   ; guarda la respuesta: 1 pon, 2 chi, 3 kan
	and a			;932e
	jr z,L_9345		;932f
	inc (hl)			;9331
	ld a,(0c207h)		;9332   ; lee el jugador al que le toca (0 = el humano)
	push af			;9335
	ld a,(0c20dh)		;9336   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;9339   ; guarda el jugador al que le toca (0 = el humano)
	and a			;933c
	call z,L_93FF		;933d
	pop af			;9340
	ld (0c207h),a		;9341   ; guarda el jugador al que le toca (0 = el humano)
	ret			;9344
L_9345:
	inc (hl)			;9345   ; sin respuesta: salta dos pasos
	inc (hl)			;9346
	ret			;9347
L_9348:
	call respuesta_ronda		;9348   ; tira las fichas bajadas (0x9FE5)
	ld a,(0c208h)		;934b   ; lee el paso del turno
	cp 003h		;934e
	jp z,L_92F6		;9350
	ret			;9353
siguiente_jugador:		; pasa el turno al jugador siguiente
	ld hl,0c207h		;9354   ; pasa el turno al jugador siguiente: 0xC207 += 1, y 0xC1C1 += 1 (el muro avanza); si ya no quedan fichas, 0xC0B8 = 1 (ronda acabada)
	ld a,(hl)			;9357
	inc a			;9358
	and 003h		;9359
	ld (hl),a			;935b
	call 05e4dh		;935c   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	xor a			;935f
	ld (0c208h),a		;9360   ; guarda el paso del turno
	ld hl,0c1c1h		;9363   ; apunta a cuantas fichas se han robado del muro
	inc (hl)			;9366
	ld b,(hl)			;9367
	ld a,(0c210h)		;9368   ; lee las fichas sacadas del final del muro (por kan)
	add a,b			;936b
	cp 07ah		;936c
	ret nz			;936e
	ld a,001h		;936f
	ld (0c0b8h),a		;9371   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
borra_temporales:		; borra 0xC200-0xC3FF
	ld hl,0c200h		;9374   ; borra 0xC200..0xC3FF (512 bytes)
	ld de,0c201h		;9377   ; apunta a la X de la ficha en la hoja de tiles
	ld (hl),000h		;937a
	ld bc,001ffh		;937c
	ldir		;937f
	ret			;9381
L_9382:
	call borra_temporales		;9382   ; borra_temporales: borra 0xC200-0xC3FF
	ret			;9385
L_9386:
	call 06beeh		;9386   ; comprueba si algun jugador (0x6BEE, 0x6C15, 0x6C1B, 0x6C21) ha dicho algo; si no, 0xC20D = 0
	jr nz,L_93A6		;9389
	call 06c15h		;938b
	jr nz,L_93A6		;938e
	call 06c1bh		;9390
	jr nz,L_93A6		;9393
	call 06c21h		;9395
	jr nz,L_93A6		;9398
	xor a			;939a
	ld (0c20dh),a		;939b   ; guarda el jugador que responde a la ficha tirada
	ld a,(0c00fh)		;939e   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;93a1
	jr z,L_93CE		;93a2
	jr L_93B8		;93a4
L_93A6:
	ld a,(0c00fh)		;93a6   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;93a9
	jr z,L_93D8		;93aa
	ld a,(0c20dh)		;93ac   ; lee el jugador que responde a la ficha tirada
	and a			;93af
	jr nz,L_93D8		;93b0
	ld a,(0d034h)		;93b2
	and a			;93b5
	jr nz,L_93D8		;93b6
L_93B8:
	ld hl,0c208h		;93b8   ; apunta a el paso del turno
	inc (hl)			;93bb
	ret			;93bc
L_93BD:
	ld a,(0c207h)		;93bd   ; espera a que el humano confirme (0xC007) o se acabe el tiempo (0xC004)
	and a			;93c0
	jr z,L_93CE		;93c1
	ld a,(0c007h)		;93c3   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and a			;93c6
	jr nz,L_93D8		;93c7
	ld hl,0c004h		;93c9   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;93cc
	ret nz			;93cd
L_93CE:
	ld a,006h		;93ce
	ld (0c208h),a		;93d0   ; guarda el paso del turno
	xor a			;93d3
	ld (0c004h),a		;93d4   ; guarda el temporizador de espera entre pasos
	ret			;93d7
L_93D8:
	ld a,004h		;93d8   ; pasa al paso 4 y pone 0xC219 = 4
	ld (0c208h),a		;93da   ; guarda el paso del turno
	xor a			;93dd
	ld (0c213h),a		;93de   ; guarda la opcion elegida en el cuadro
	ld (0c004h),a		;93e1   ; guarda el temporizador de espera entre pasos
	ld a,004h		;93e4
	ld (0c219h),a		;93e6   ; guarda la ultima opcion del cuadro
	ld a,(0c20dh)		;93e9   ; lee el jugador que responde a la ficha tirada
	and a			;93ec
	call z,L_97A4		;93ed   ; abre el cuadro de respuesta de 56 x 56 puntos
	ret			;93f0
L_93F1:
	call L_96C7		;93f1   ; pone el cursor de la mano en la ultima ficha (0xC20A = 0xC211 = 0xC200 + 1)
	ld a,(0c200h)		;93f4   ; lee contador de trabajo de las fichas de la mano
	inc a			;93f7
	ld (0c211h),a		;93f8   ; guarda el numero de opciones del cuadro
	ld (0c20ah),a		;93fb   ; guarda la posicion de la ficha en la mano
	ret			;93fe
L_93FF:
	call L_96C7		;93ff   ; cuenta las fichas de la mano que valen (sin los bits 6-7): deja 0xC200 = la ultima
	ld a,(0c200h)		;9402   ; lee contador de trabajo de las fichas de la mano
	ld (0c211h),a		;9405   ; guarda el numero de opciones del cuadro
	ld (0c20ah),a		;9408   ; guarda la posicion de la ficha en la mano
	ret			;940b
elige_ficha_humano:		; el humano elige la ficha que tira
	ld a,(0c20bh)		;940c   ; ELIGE FICHA EL HUMANO: 0xC20B elige el estado de la eleccion; cursor entre fichas con izquierda y derecha, tecla 0xC007
	call 04066h		;940f   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9412: 4 destinos del despachador p00:4066 (call en p02:940F, el
;   indice en A): 941A, 94F1, 95F7, 9613; lo leen p02:940F (8 bytes)
;   0x9412..0x941a  (8 bytes)
DATA_tabla_9412:
	defw 0941ah,094f1h,095f7h,09613h	; 9412  -> L_941A L_94F1 L_95F7 L_9613

; ======================================================================
; CODIGO 0x941a..0x98e3  (1225 bytes)
; ======================================================================


L_941A:
	call L_9A16		;941a   ; si el jugador tiene +0x34 (esta en espera), pone 0xC0E1 = 1 y mira si gana con 0x68EF: 0xC0E2 = 1
	jr c,L_9490		;941d
	ld a,(0c0e2h)		;941f
	and a			;9422
	jr nz,L_942B		;9423
	ld a,(0c007h)		;9425   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	rra			;9428
	jr c,L_9490		;9429
L_942B:
	ld a,(0c007h)		;942b   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	rra			;942e
	rra			;942f
	rra			;9430
	jr c,L_9454		;9431
	rra			;9433
	jr c,L_943D		;9434
	rra			;9436
	jp c,L_94E1		;9437
	jp L_946D		;943a
L_943D:
	ld a,(0d034h)		;943d
	and a			;9440
	jr nz,L_946D		;9441
	ld hl,0c211h		;9443   ; apunta a el numero de opciones del cuadro
	ld a,(0c20ah)		;9446   ; lee la posicion de la ficha en la mano
	cp (hl)			;9449
	jr z,L_9450		;944a
	inc a			;944c
	jp L_9467		;944d
L_9450:
	xor a			;9450
	jp L_9467		;9451
L_9454:
	ld a,(0d034h)		;9454
	and a			;9457
	jr nz,L_946D		;9458
	ld a,(0c20ah)		;945a   ; lee la posicion de la ficha en la mano
	and a			;945d
	jr z,L_9464		;945e
	dec a			;9460
	jp L_9467		;9461
L_9464:
	ld a,(0c211h)		;9464   ; lee el numero de opciones del cuadro
L_9467:
	ld (0c20ah),a		;9467   ; mueve el cursor y suena el sonido 0x06
	call 04116h		;946a   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_946D:
	ld a,(0c20ah)		;946d   ; coloca el sprite del cursor (12 de ancho por ficha): 0xCC00 = 0xCC, X = 0x21 + 12 x posicion, color 0x0E (4382)
	ld b,a			;9470
	ld c,00ch		;9471
	call multiplica_b_c		;9473   ; multiplica_b_c: A = B x C
	ld b,021h		;9476
	add a,b			;9478
	ld (0cc01h),a		;9479
	ld a,0cch		;947c
	ld (0cc00h),a		;947e   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld a,048h		;9481
	ld (0cc02h),a		;9483
	ld a,00eh		;9486
	ld hl,0ca00h		;9488   ; apunta a los colores de los sprites (4 bloques de 16)
	call 04382h		;948b   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	or a			;948e
	ret			;948f
L_9490:
	ld a,(0c24ah)		;9490   ; pregunta del tsumo (ganar): guarda el fondo, dibuja el cuadro y 0xC20B = 1, 0xC219 = 3
	and a			;9493
	jp z,L_949A		;9494
	call 0a74fh		;9497   ; borra_cuadro_voz: borra el cuadro de la cara que habla
L_949A:
	call 04107h		;949a   ; pide_sonido_03: pide el sonido 0x03
	call 069d3h		;949d   ; quedan_pocas: carry si quedan menos de 4 fichas muertas
	call 069b8h		;94a0   ; marca_si_gana: marca con el bit 4 de +0x60 si la mano gana
	ld a,001h		;94a3
	ld (0c220h),a		;94a5   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,06478h		;94a8
	ld de,0a248h		;94ab
	ld bc,03830h		;94ae
	ld a,002h		;94b1
	call 05024h		;94b3   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0687ch		;94b6
	ld bc,03028h		;94b9
	ld a,0ffh		;94bc
	ld d,000h		;94be
	call 04fe5h		;94c0   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06478h		;94c3
	ld hl,00706h		;94c6
	call ventana		;94c9   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,09902h		;94cc
	call 05363h		;94cf   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	xor a			;94d2
	ld (0c213h),a		;94d3   ; guarda la opcion elegida en el cuadro
	inc a			;94d6
	ld (0c20bh),a		;94d7   ; guarda el estado de la eleccion del humano
	inc a			;94da
	inc a			;94db
	ld (0c219h),a		;94dc   ; guarda la ultima opcion del cuadro
	or a			;94df
	ret			;94e0
L_94E1:
	ld hl,00000h		;94e1   ; cierra el cuadro y quita el cursor
	ld (0c0e1h),hl		;94e4
	ld a,0e0h		;94e7
	ld (0cc00h),a		;94e9   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	call 059cdh		;94ec   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	scf			;94ef
	ret			;94f0
L_94F1:
	ld a,(0c007h)		;94f1   ; teclas del cuadro de pregunta de la respuesta (derecha, izquierda, boton)
	rra			;94f4
	jr c,L_9513		;94f5
	rra			;94f7
	jr c,L_9502		;94f8
	rra			;94fa
	rra			;94fb
	rra			;94fc
	jr c,L_955D		;94fd
	jp L_9528		;94ff
L_9502:
	ld hl,0c219h		;9502   ; apunta a la ultima opcion del cuadro
	ld a,(0c213h)		;9505   ; lee la opcion elegida en el cuadro
	cp (hl)			;9508
	jr z,L_950F		;9509
	inc a			;950b
	jp L_9520		;950c
L_950F:
	xor a			;950f
	jp L_9520		;9510
L_9513:
	ld a,(0c213h)		;9513   ; lee la opcion elegida en el cuadro
	and a			;9516
	jr z,L_951D		;9517
	dec a			;9519
	jp L_9520		;951a
L_951D:
	ld a,(0c219h)		;951d   ; lee la ultima opcion del cuadro
L_9520:
	push af			;9520
	call 04116h		;9521   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
	pop af			;9524
	ld (0c213h),a		;9525   ; guarda la opcion elegida en el cuadro
L_9528:
	ld a,(0c213h)		;9528   ; coloca el cursor del cuadro (8 de ancho por opcion, 0x80 + 8 x opcion)
	ld b,a			;952b
	ld c,008h		;952c
	call multiplica_b_c		;952e   ; multiplica_b_c: A = B x C
	add a,080h		;9531
	ld (0cc00h),a		;9533   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;9536
	ld a,06ch		;9539
	ld (0cc01h),a		;953b
	ld (0cc05h),a		;953e
	ld a,038h		;9541
	ld (0cc02h),a		;9543
	ld a,03ch		;9546
	ld (0cc06h),a		;9548
	ld hl,0ca00h		;954b   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,009h		;954e
	call 04382h		;9550   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;9553
	ld a,002h		;9556
	call 04382h		;9558   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	or a			;955b
	ret			;955c
L_955D:
	ld a,(0c213h)		;955d   ; el boton: 0xC213 es la opcion elegida (0 no, 1 pon, 2 chi, 3 kan, 4 ron)
	and a			;9560
	jr z,L_9580		;9561
	dec a			;9563
	jp z,L_95A3		;9564
	dec a			;9567
	jp z,L_95C0		;9568
	jp nz,L_95DB		;956b
	ld a,(0d034h)		;956e
	and a			;9571
	jr z,L_9580		;9572
	ld a,(0d060h)		;9574
	and 010h		;9577
	jr z,L_9580		;9579
	ld a,001h		;957b
	ld (0cda0h),a		;957d   ; guarda 1 si el humano ha decidido ganar
L_9580:
	xor a			;9580   ; cierra el cuadro y devuelve el fondo
	ld (0c20bh),a		;9581   ; guarda el estado de la eleccion del humano
L_9584:
	xor a			;9584
	ld (0c220h),a		;9585   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,0a248h		;9588
	ld de,06478h		;958b
	ld bc,03830h		;958e
	ld a,001h		;9591
	call 05024h		;9593   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld a,0e0h		;9596
	ld (0cc00h),a		;9598   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;959b
	call 059cdh		;959e   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	or a			;95a1
	ret			;95a2
L_95A3:
	call busca_opciones_chi_kan		;95a3   ; chi del humano: mira las opciones (0x9D89) y pide el sonido 0x13
	ld a,(0c21ah)		;95a6   ; lee las opciones de chi y kan (3 bytes)
	cp 0ffh		;95a9
	jr z,L_95BE		;95ab
	call L_89C8		;95ad   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 04163h		;95b0   ; voz_kan: dice KAN: la voz 0x13 con el tono del personaje de 0xC20D
	ld a,002h		;95b3
	ld (0c20bh),a		;95b5   ; guarda el estado de la eleccion del humano
	call L_9BFA		;95b8   ; cuenta cuantas opciones validas hay en 0xC21A (hasta 0xFF) y guarda 0xC211
	jp L_9584		;95bb
L_95BE:
	or a			;95be
	ret			;95bf
L_95C0:
	ld a,(0d060h)		;95c0   ; mira si puede declarar la espera (bit 5 de +0x60)
	and 020h		;95c3
	ret z			;95c5
	ld hl,(0c0deh)		;95c6   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00034h		;95c9
	add hl,de			;95cc
	ld a,(hl)			;95cd
	and a			;95ce
	ret nz			;95cf
	call L_89A9		;95d0   ; guarda en +0x71 el numero de ficha robada (0xC1C1) y pone +0x35 = 1 si no tiene espera
	call 0a46eh		;95d3   ; declara_riichi: la maquina declara riichi: +0x34 = 0xFF y apuesta 1000
	call L_9580		;95d6   ; cierra el cuadro y devuelve el fondo
	scf			;95d9
	ret			;95da
L_95DB:
	ld a,(0d060h)		;95db
	and 010h		;95de
	jr nz,L_95EC		;95e0
	ld a,(0c00fh)		;95e2   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;95e5
	ret z			;95e6
	ld a,001h		;95e7
	ld (0cda0h),a		;95e9   ; guarda 1 si el humano ha decidido ganar
L_95EC:
	call 04184h		;95ec   ; voz_tsumo: dice TSUMO: la voz 0x16 con el tono del personaje de 0xC207
	ld a,001h		;95ef
	ld (0c0b1h),a		;95f1   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	jp L_9580		;95f4
L_95F7:
	call L_9C12		;95f7   ; si el humano ya ha elegido (0x9C12), recoge la ficha tirada
	ret nc			;95fa
	call L_9672		;95fb   ; una ficha mas del muro sacada de la parte de atras (0xC210 += 1), con su dibujo
	ld a,(0c207h)		;95fe   ; lee el jugador al que le toca (0 = el humano)
	ld (0c20dh),a		;9601   ; guarda el jugador que responde a la ficha tirada
	call 0a791h		;9604   ; suma_kan: suma uno a los kan del jugador 0xC207
	call borra_hueco_ficha		;9607   ; borra_hueco_ficha: borra el rectangulo de la ficha robada de la mano
	call L_98D4		;960a   ; prepara el cambio de mano (0x991B, 0xA28A), la ordena y la dibuja
	ld hl,0c20bh		;960d   ; apunta a el estado de la eleccion del humano
	inc (hl)			;9610
	or a			;9611
	ret			;9612
L_9613:
	ld a,(0c210h)		;9613   ; coge del muro la ficha que corresponde (0xC210 + 0x87) y la pone en 0xC209
	ld c,a			;9616
	dec c			;9617
	ld a,087h		;9618
	sub c			;961a
	ld hl,0c100h		;961b   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;961e   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9621
	ld (0c209h),a		;9622   ; guarda la ficha robada o tirada
	call dibuja_ficha_robada		;9625   ; dibuja_ficha_robada: dibuja la ficha 0xC209 en su sitio
	ld a,001h		;9628
	ld (0cd0ch),a		;962a   ; guarda 1 si se gana con la ficha de un kan
	xor a			;962d
	ld (0c20bh),a		;962e   ; guarda el estado de la eleccion del humano
	call L_93F1		;9631   ; pone el cursor de la mano en la ultima ficha (0xC20A = 0xC211 = 0xC200 + 1)
	or a			;9634
	ret			;9635
L_9636:
	ld hl,04343h		;9636   ; dibuja las fichas del muro muertas: un rectangulo de 122 x 74 y siete fichas
	ld bc,07a4ah		;9639
	ld d,000h		;963c
	ld a,0ffh		;963e
	call 04fe5h		;9640   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,04040h		;9643
	ld hl,0100ah		;9646
	call ventana		;9649   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	call 0a655h		;964c   ; dibuja_mesa_ronda: dibuja los datos de la ronda
	ld b,007h		;964f
	ld a,058h		;9651
	ld (0c203h),a		;9653   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9656
	ld (0c204h),a		;9658   ; guarda la Y donde se dibuja la ficha
L_965B:
	xor a			;965b
	ld (0c207h),a		;965c   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;965f   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	push bc			;9662
	call L_8B86		;9663
	pop bc			;9666
	ld a,(0c203h)		;9667   ; lee la X donde se dibuja la ficha
	add a,00ch		;966a
	ld (0c203h),a		;966c   ; guarda la X donde se dibuja la ficha
	djnz L_965B		;966f
	ret			;9671
L_9672:
	ld a,(0c24ah)		;9672   ; una ficha mas del muro sacada de la parte de atras (0xC210 += 1), con su dibujo
	and a			;9675
	jp z,L_967C		;9676
	call 0a74fh		;9679   ; borra_cuadro_voz: borra el cuadro de la cara que habla
L_967C:
	ld hl,0c210h		;967c   ; apunta a las fichas sacadas del final del muro (por kan)
	inc (hl)			;967f
L_9680:
	ld a,(0c207h)		;9680   ; lee el jugador al que le toca (0 = el humano)
	push af			;9683
	ld a,(0c203h)		;9684   ; lee la X donde se dibuja la ficha
	ld h,a			;9687
	ld a,(0c204h)		;9688   ; lee la Y donde se dibuja la ficha
	ld l,a			;968b
	push hl			;968c
	ld a,(0c210h)		;968d   ; lee las fichas sacadas del final del muro (por kan)
	ld b,a			;9690
	ld c,00ch		;9691
	call multiplica_b_c		;9693   ; multiplica_b_c: A = B x C
	add a,070h		;9696
	ld (0c203h),a		;9698   ; guarda la X donde se dibuja la ficha
	ld a,060h		;969b
	ld (0c204h),a		;969d   ; guarda la Y donde se dibuja la ficha
	xor a			;96a0
	ld (0c207h),a		;96a1   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;96a4   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c210h)		;96a7   ; lee las fichas sacadas del final del muro (por kan)
	add a,a			;96aa
	ld b,a			;96ab
	ld a,082h		;96ac
	sub b			;96ae
	ld hl,0c100h		;96af   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;96b2   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;96b5
	call dibuja_ficha_2		;96b6   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop hl			;96b9
	ld a,h			;96ba
	ld (0c203h),a		;96bb   ; guarda la X donde se dibuja la ficha
	ld a,l			;96be
	ld (0c204h),a		;96bf   ; guarda la Y donde se dibuja la ficha
	pop af			;96c2
	ld (0c207h),a		;96c3   ; guarda el jugador al que le toca (0 = el humano)
	ret			;96c6
L_96C7:
	xor a			;96c7   ; cuenta las fichas de la mano que valen (sin los bits 6-7): deja 0xC200 = la ultima
	ld (0c200h),a		;96c8   ; guarda contador de trabajo de las fichas de la mano
L_96CB:
	call 05e54h		;96cb   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	ld a,(0c200h)		;96ce   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;96d1   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;96d4
	and 0c0h		;96d5
	jr nz,L_96E5		;96d7
	ld a,(0c200h)		;96d9   ; lee contador de trabajo de las fichas de la mano
	inc a			;96dc
	ld (0c200h),a		;96dd   ; guarda contador de trabajo de las fichas de la mano
	cp 00dh		;96e0
	jp nz,L_96CB		;96e2
L_96E5:
	ld a,(0c200h)		;96e5   ; lee contador de trabajo de las fichas de la mano
	dec a			;96e8
	ld (0c200h),a		;96e9   ; guarda contador de trabajo de las fichas de la mano
	ret			;96ec
respuestas_humano:		; las respuestas del humano a la ficha tirada
	call 0a4bah		;96ed   ; RESPUESTAS DEL HUMANO (0x9304): teclas, y por 0xC213: 0 = no, 1 = pon, 2 = chi, 3 = kan, 4 = ron
	ld a,(0c007h)		;96f0   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	rra			;96f3
	jp c,L_9513		;96f4
	rra			;96f7
	jp c,L_9502		;96f8
	rra			;96fb
	rra			;96fc
	rra			;96fd
	jp nc,L_9528		;96fe
	ld a,0e0h		;9701
	ld (0cc00h),a		;9703   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;9706
	ld a,(0c213h)		;9709   ; lee la opcion elegida en el cuadro
	and a			;970c
	jr z,L_976C		;970d
	dec a			;970f
	jr z,L_9730		;9710
	dec a			;9712
	jr z,L_9741		;9713
	dec a			;9715
	jr z,L_971A		;9716
	jr L_974D		;9718
L_971A:
	ld a,(0d060h)		;971a   ; kan: sonido 0x13 (0x4163) y 0x987E
	and 004h		;971d
	ret z			;971f
	call 0a528h		;9720   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	call L_9672		;9723   ; una ficha mas del muro sacada de la parte de atras (0xC210 += 1), con su dibujo
	call L_89C8		;9726   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 04163h		;9729   ; voz_kan: dice KAN: la voz 0x13 con el tono del personaje de 0xC20D
	call hace_kan		;972c   ; hace_kan: hace un kan
	ret			;972f
L_9730:
	ld a,(0d060h)		;9730   ; pon: sonido 0x11 (0x414D) y 0x97E6
	rra			;9733
	ret nc			;9734
	call 0a528h		;9735   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	call L_89C8		;9738   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	call 0414dh		;973b   ; voz_pon: dice PON: la voz 0x11 con el tono del personaje de 0xC20D
	jp hace_pon		;973e   ; hace_pon: hace un pon
L_9741:
	ld a,(0d060h)		;9741   ; chi: sonido 0x12 (0x4158) y 0x9781
	and 002h		;9744
	ret z			;9746
	call 04158h		;9747   ; voz_chi: dice CHI: la voz 0x12 con el tono del personaje de 0xC20D
	jp L_9781		;974a
L_974D:
	ld a,(0d060h)		;974d   ; ron: 0xC0B1 = 2, sonido 0x14 (0x416E)
	and 008h		;9750
	jr nz,L_975E		;9752
	ld a,(0c00fh)		;9754   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;9757
	ret z			;9758
	ld a,001h		;9759
	ld (0cda0h),a		;975b   ; guarda 1 si el humano ha decidido ganar
L_975E:
	ld a,002h		;975e
	ld (0c0b1h),a		;9760   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	call 0a528h		;9763   ; ficha_en_su_sitio: dibuja la ficha en su sitio
	call 0416eh		;9766   ; voz_ron: dice RON: la voz 0x14 con el tono del personaje de 0xC20D
	jp L_9781		;9769
L_976C:
	call 0a4d0h		;976c   ; pone_ficha_normal: pone la ficha de la mano en su sitio normal
	ld a,(0d034h)		;976f
	and a			;9772
	jr z,L_9781		;9773
	ld a,(0d060h)		;9775
	and 008h		;9778
	jr z,L_9781		;977a
	ld a,001h		;977c
	ld (0cda0h),a		;977e   ; guarda 1 si el humano ha decidido ganar
L_9781:
	xor a			;9781   ; cierra el cuadro de respuestas y quita los dos sprites
	ld (0c220h),a		;9782   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,0a248h		;9785
	ld de,06478h		;9788
	ld bc,03838h		;978b
	ld a,001h		;978e
	call 05024h		;9790   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	xor a			;9793
	ld (0c215h),a		;9794   ; guarda el paso de la respuesta
	ld a,0e0h		;9797
	ld (0cc00h),a		;9799   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;979c
	call 059cdh		;979f   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	scf			;97a2
	ret			;97a3
L_97A4:
	ld a,(0c24ah)		;97a4   ; abre el cuadro de respuesta de 56 x 56 puntos
	and a			;97a7
	jp z,L_97AE		;97a8
	call 0a74fh		;97ab   ; borra_cuadro_voz: borra el cuadro de la cara que habla
L_97AE:
	call 04107h		;97ae   ; pide_sonido_03: pide el sonido 0x03
	xor a			;97b1
	ld (0c213h),a		;97b2   ; guarda la opcion elegida en el cuadro
	ld (0c242h),a		;97b5
	inc a			;97b8
	ld (0c220h),a		;97b9   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,06478h		;97bc
	ld de,0a248h		;97bf
	ld bc,03838h		;97c2
	ld a,002h		;97c5
	call 05024h		;97c7   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0687ch		;97ca
	ld bc,03030h		;97cd
	ld a,0ffh		;97d0
	ld d,000h		;97d2
	call 04fe5h		;97d4   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06478h		;97d7
	ld hl,00707h		;97da
	call ventana		;97dd   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,098e3h		;97e0
	jp 05363h		;97e3   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
hace_pon:		; hace un pon
	call L_87DF		;97e6   ; HACE UN PON: 0x87DF, 0x991B; las dos fichas iguales de la mano (bit 6) y la tirada pasan a ser el grupo (+0x37, +0x3F)
	call L_991B		;97e9   ; calcula en +0x32 de la mano el sitio donde cae el grupo bajado: +0x0E (grupos hechos) y tablas 0x993D por jugador
	ld a,(0c20dh)		;97ec   ; lee el jugador que responde a la ficha tirada
	add a,003h		;97ef
	and 003h		;97f1
	ld hl,0c207h		;97f3   ; apunta a el jugador al que le toca (0 = el humano)
	cp (hl)			;97f6
	jr nz,L_97FC		;97f7
	call L_99FE		;97f9   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9)
L_97FC:
	call L_9965		;97fc   ; dibuja en el sitio de +0x32 la ficha 0xC209 boca arriba y corre el sitio al siguiente (0x99FE)
	ld a,(0c20dh)		;97ff   ; lee el jugador que responde a la ficha tirada
	add a,002h		;9802
	and 003h		;9804
	ld hl,0c207h		;9806   ; apunta a el jugador al que le toca (0 = el humano)
	cp (hl)			;9809
	jr nz,L_980F		;980a
	call L_99FE		;980c   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9)
L_980F:
	call L_9965		;980f   ; dibuja en el sitio de +0x32 la ficha 0xC209 boca arriba y corre el sitio al siguiente (0x99FE)
	call L_998F		;9812   ; dibuja la ficha de la mano del jugador siguiente, de lado, en el sitio del grupo (tabla 0x99CE)
	ld hl,0d000h		;9815
	call hl_mano_de_c20d		;9818   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	push hl			;981b
	ld de,0006dh		;981c
	add hl,de			;981f
	ld a,(hl)			;9820
	pop hl			;9821
	call 0405ch		;9822   ; suma_a_hl: HL = HL + A
	set 6,(hl)		;9825
	inc hl			;9827
	set 6,(hl)		;9828
	ld a,(0c207h)		;982a   ; lee el jugador al que le toca (0 = el humano)
	push af			;982d
	ld a,(0c20dh)		;982e   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;9831   ; guarda el jugador al que le toca (0 = el humano)
	call ordena_mano_actual		;9834   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call L_9AF7		;9837
	call dibuja_mano		;983a   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop af			;983d
	ld (0c207h),a		;983e   ; guarda el jugador al que le toca (0 = el humano)
L_9841:
	ld hl,0d00eh		;9841
	call hl_mano_de_c20d		;9844   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;9847
	inc (hl)			;9848
	and 003h		;9849
	push af			;984b
	ld hl,0d037h		;984c
	call hl_mano_de_c20d		;984f   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	push hl			;9852
	ld hl,0d03fh		;9853
	call hl_mano_de_c20d		;9856   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;9859
	add a,a			;985a
	pop hl			;985b
	call 0405ch		;985c   ; suma_a_hl: HL = HL + A
	ld a,(0c209h)		;985f   ; lee la ficha robada o tirada
	ld (hl),a			;9862
	pop af			;9863
	inc hl			;9864
	ld (hl),a			;9865
	ld a,(0c207h)		;9866   ; lee el jugador al que le toca (0 = el humano)
	rlca			;9869
	rlca			;986a
	rlca			;986b
	rlca			;986c
	or (hl)			;986d
	ld (hl),a			;986e
	ld hl,0d03fh		;986f
	call hl_mano_de_c20d		;9872   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	inc (hl)			;9875
	ld a,(0c20dh)		;9876   ; lee el jugador que responde a la ficha tirada
	and a			;9879
	ret nz			;987a
	jp L_9781		;987b
hace_kan:		; hace un kan
	call L_991B		;987e   ; HACE UN KAN: 0x991B; las tres fichas iguales de la mano (bits 6 y 7) y la tirada
	ld b,003h		;9881
L_9883:
	push bc			;9883
	call L_9965		;9884   ; dibuja en el sitio de +0x32 la ficha 0xC209 boca arriba y corre el sitio al siguiente (0x99FE)
	pop bc			;9887
	djnz L_9883		;9888
	call L_998F		;988a   ; dibuja la ficha de la mano del jugador siguiente, de lado, en el sitio del grupo (tabla 0x99CE)
	ld hl,0d000h		;988d
	call hl_mano_de_c20d		;9890   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	push hl			;9893
	ld de,0006dh		;9894
	add hl,de			;9897
	ld a,(hl)			;9898
	pop hl			;9899
	call 0405ch		;989a   ; suma_a_hl: HL = HL + A
	set 6,(hl)		;989d
	set 7,(hl)		;989f
	inc hl			;98a1
	set 6,(hl)		;98a2
	set 7,(hl)		;98a4
	inc hl			;98a6
	set 6,(hl)		;98a7
	set 7,(hl)		;98a9
	ld a,(0c207h)		;98ab   ; lee el jugador al que le toca (0 = el humano)
	push af			;98ae
	ld a,(0c20dh)		;98af   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;98b2   ; guarda el jugador al que le toca (0 = el humano)
	call ordena_mano_actual		;98b5   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call borra_hueco_ficha		;98b8   ; borra_hueco_ficha: borra el rectangulo de la ficha robada de la mano
	call dibuja_mano		;98bb   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop af			;98be
	ld (0c207h),a		;98bf   ; guarda el jugador al que le toca (0 = el humano)
	ld hl,0d00eh		;98c2
	call hl_mano_de_c20d		;98c5   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	inc (hl)			;98c8
	ld a,(0c20dh)		;98c9   ; lee el jugador que responde a la ficha tirada
	and a			;98cc
	ret nz			;98cd
	jp L_9781		;98ce
L_98D1:
	jp L_9841		;98d1
L_98D4:
	call L_991B		;98d4   ; prepara el cambio de mano (0x991B, 0xA28A), la ordena y la dibuja
	call 0a28ah		;98d7   ; baja_grupo: dibuja el grupo que baja el jugador (chi, pon o kan)
	call ordena_mano_actual		;98da   ; ordena_mano_actual: ordena las 13 fichas de la mano del jugador actual
	call borra_hueco_ficha		;98dd   ; borra_hueco_ficha: borra el rectangulo de la ficha robada de la mano
	jp dibuja_mano		;98e0   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207

; ----------------------------------------------------------------------
; DATOS tiles_98E3: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p02:97E3 (31 bytes)
;   0x98e3..0x9902  (31 bytes)
DATA_tiles_98E3:
	defb 074h,080h,00fh,02eh,013h,02ah,0feh,074h,088h,060h,000h,061h,0feh,074h,090h,062h	; 98e3  t....*.t.`.a.t.b
	defb 000h,063h,0feh,074h,098h,064h,000h,061h,0feh,074h,0a0h,065h,000h,061h,0ffh	; 98f3  .c.t.d.a.t.e.a.

; ----------------------------------------------------------------------
; DATOS tiles_9902: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p02:94CF (25 bytes)
;   0x9902..0x991b  (25 bytes)
DATA_tiles_9902:
	defb 074h,080h,00fh,02eh,013h,02ah,0feh,074h,088h,064h,000h,061h,0feh,074h,090h,066h	; 9902  t....*.t.d.a.t.f
	defb 063h,062h,0feh,074h,098h,067h,000h,068h,0ffh	; 9912  cb.t.g.h.

; ======================================================================
; CODIGO 0x991b..0x993d  (34 bytes)
; ======================================================================


L_991B:
	ld hl,0d00eh		;991b   ; calcula en +0x32 de la mano el sitio donde cae el grupo bajado: +0x0E (grupos hechos) y tablas 0x993D por jugador
	call hl_mano_de_c20d		;991e   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;9921
L_9922:
	push af			;9922
	ld hl,0993dh		;9923
	ld a,(0c20dh)		;9926   ; lee el jugador que responde a la ficha tirada
	call 04d07h		;9929   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	pop af			;992c
	call 04d07h		;992d   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;9930
	ld hl,0d032h		;9931
	call hl_mano_de_c20d		;9934   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,e			;9937
	ld (hl),a			;9938
	inc hl			;9939
	ld a,d			;993a
	ld (hl),a			;993b
	ret			;993c

; ----------------------------------------------------------------------
; DATOS resto_993D: lo apuntan con el banco puesto p02:9923 (0x993D); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9923 (40 bytes)
;   0x993d..0x9965  (40 bytes)
DATA_resto_993D:
	defb 045h,099h,04dh,099h,055h,099h,05dh,099h,0c1h,0beh,09dh,0beh,079h,0beh,055h,0beh	; 993d  E.M.U.].....y.U.
	defb 0eah,01ah,0eah,03eh,0eah,062h,0eah,086h,032h,000h,056h,000h,07ah,000h,09eh,000h	; 994d  ...>.b..2.V.z...
	defb 004h,0ach,004h,088h,004h,064h,004h,040h	; 995d  .....d.@

; ======================================================================
; CODIGO 0x9965..0x99ce  (105 bytes)
; ======================================================================


L_9965:
	ld a,(0c207h)		;9965   ; dibuja en el sitio de +0x32 la ficha 0xC209 boca arriba y corre el sitio al siguiente (0x99FE)
	push af			;9968
	ld a,(0c20dh)		;9969   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;996c   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;996f   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld hl,0d032h		;9972
	call hl_mano_de_c20d		;9975   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;9978
	ld (0c203h),a		;9979   ; guarda la X donde se dibuja la ficha
	inc hl			;997c
	ld a,(hl)			;997d
	ld (0c204h),a		;997e   ; guarda la Y donde se dibuja la ficha
	ld a,(0c209h)		;9981   ; lee la ficha robada o tirada
	call dibuja_ficha_2		;9984   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	call L_99FE		;9987   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9)
	pop af			;998a
	ld (0c207h),a		;998b   ; guarda el jugador al que le toca (0 = el humano)
	ret			;998e
L_998F:
	call L_991B		;998f   ; dibuja la ficha de la mano del jugador siguiente, de lado, en el sitio del grupo (tabla 0x99CE)
L_9992:
	ld a,(0c20dh)		;9992   ; lee el jugador que responde a la ficha tirada
	ld hl,099ceh		;9995
	call 04d07h		;9998   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c207h)		;999b   ; lee el jugador al que le toca (0 = el humano)
	call 04d07h		;999e   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;99a1
	ld hl,0d032h		;99a2
	call hl_mano_de_c20d		;99a5   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;99a8
	add a,e			;99a9
	ld (0c203h),a		;99aa   ; guarda la X donde se dibuja la ficha
	inc hl			;99ad
	ld a,(hl)			;99ae
	add a,d			;99af
	ld (0c204h),a		;99b0   ; guarda la Y donde se dibuja la ficha
	ld a,(0c207h)		;99b3   ; lee el jugador al que le toca (0 = el humano)
	push af			;99b6
	ld a,(0c20dh)		;99b7   ; lee el jugador que responde a la ficha tirada
	inc a			;99ba
	and 003h		;99bb
	ld (0c207h),a		;99bd   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;99c0   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c209h)		;99c3   ; lee la ficha robada o tirada
	call dibuja_ficha_2		;99c6   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop af			;99c9
	ld (0c207h),a		;99ca   ; guarda el jugador al que le toca (0 = el humano)
	ret			;99cd

; ----------------------------------------------------------------------
; DATOS resto_99CE: lo apuntan con el banco puesto p02:9995 (0x99CE); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9995 (40 bytes)
;   0x99ce..0x99f6  (40 bytes)
DATA_resto_99CE:
	defb 0d6h,099h,0deh,099h,0e6h,099h,0eeh,099h,000h,000h,012h,006h,009h,006h,000h,006h	; 99ce  ................
	defb 006h,0fah,000h,000h,006h,0e8h,006h,0f1h,0f1h,000h,0fah,000h,000h,000h,0e8h,000h	; 99de  ................
	defb 000h,013h,000h,009h,000h,000h,000h,000h	; 99ee  ........

; ======================================================================
; CODIGO 0x99f6..0x9adb  (229 bytes)
; ======================================================================


hl_mano_de_c20d:		; H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(0c20dh)		;99f6   ; H += 4 x jugador (0xC20D): la mano de ese jugador
hl_mano_de_a:		; H += 4 x A (la mano del jugador A)
	add a,a			;99f9   ; H += 4 x A: la mano del jugador A
	add a,a			;99fa
	add a,h			;99fb
	ld h,a			;99fc
	ret			;99fd
L_99FE:
	ld hl,08eb9h		;99fe   ; avanza el sitio de +0x32 de la mano del jugador 0xC20D (suma de la tabla 0x8EB9)
	ld a,(0c20dh)		;9a01   ; lee el jugador que responde a la ficha tirada
	call 04d07h		;9a04   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;9a07
	ld hl,0d032h		;9a08
	call hl_mano_de_c20d		;9a0b   ; hl_mano_de_c20d: H += 4 x 0xC20D (la mano de ese jugador)
	ld a,(hl)			;9a0e
	add a,e			;9a0f
	ld (hl),a			;9a10
	inc hl			;9a11
	ld a,(hl)			;9a12
	add a,d			;9a13
	ld (hl),a			;9a14
	ret			;9a15
L_9A16:
	ld a,(0d034h)		;9a16   ; si el jugador tiene +0x34 (esta en espera), pone 0xC0E1 = 1 y mira si gana con 0x68EF: 0xC0E2 = 1
	or a			;9a19
	ret z			;9a1a
	ld hl,0c0e1h		;9a1b
	ld a,(hl)			;9a1e
	and a			;9a1f
	ret nz			;9a20
	ld (hl),001h		;9a21
	push hl			;9a23
	call 068efh		;9a24   ; prueba_ganar_robo: prueba si la mano gana por robo (B = 1)
	pop hl			;9a27
	ret nc			;9a28
	inc hl			;9a29
	ld (hl),001h		;9a2a
	scf			;9a2c
	ret			;9a2d
L_9A2E:
	ld a,(0c007h)		;9a2e   ; teclas de la eleccion de ficha cuando ya esta en espera (solo se puede tirar la ultima)
	rra			;9a31
	rra			;9a32
	rra			;9a33
	jp c,L_9454		;9a34
	rra			;9a37
	jp c,L_943D		;9a38
	rra			;9a3b
	jp nc,L_946D		;9a3c
	ld a,(0c207h)		;9a3f   ; lee el jugador al que le toca (0 = el humano)
	push af			;9a42
	ld a,(0c20dh)		;9a43   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;9a46   ; guarda el jugador al que le toca (0 = el humano)
	call tapa_ficha_tirada		;9a49   ; tapa_ficha_tirada: tapa en la mano la ficha que se tira
	pop af			;9a4c
	ld (0c207h),a		;9a4d   ; guarda el jugador al que le toca (0 = el humano)
L_9A50:
	ld a,0e0h		;9a50
	ld (0cc00h),a		;9a52   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;9a55
	call 059cdh		;9a58   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	scf			;9a5b
	ret			;9a5c
L_9A5D:
	ld a,(0c007h)		;9a5d   ; teclas del cuadro de respuestas del humano
	rra			;9a60
	jp c,L_9513		;9a61
	rra			;9a64
	jp c,L_9502		;9a65
	rra			;9a68
	rra			;9a69
	rra			;9a6a
	jp nc,L_9528		;9a6b
	ld a,(0c213h)		;9a6e   ; lee la opcion elegida en el cuadro
	and a			;9a71
	jr z,L_9A9A		;9a72
	dec a			;9a74
	jr z,L_9A9A		;9a75
	ld a,(0c207h)		;9a77   ; lee el jugador al que le toca (0 = el humano)
	push af			;9a7a
	ld hl,0c214h		;9a7b   ; apunta a 1 si las manos se ven boca arriba
	ld a,(hl)			;9a7e
	and a			;9a7f
	jr nz,L_9A87		;9a80
	ld a,001h		;9a82
	jp L_9A88		;9a84
L_9A87:
	xor a			;9a87
L_9A88:
	ld (hl),a			;9a88
	ld b,003h		;9a89
L_9A8B:
	push bc			;9a8b
	ld a,b			;9a8c
	ld (0c207h),a		;9a8d   ; guarda el jugador al que le toca (0 = el humano)
	call dibuja_mano		;9a90   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	pop bc			;9a93
	djnz L_9A8B		;9a94
	pop af			;9a96
	ld (0c207h),a		;9a97   ; guarda el jugador al que le toca (0 = el humano)
L_9A9A:
	jp L_9A50		;9a9a
L_9A9D:
	ld a,(0c007h)		;9a9d   ; teclas con el cuadro cerrado
	rra			;9aa0
	jp c,L_9513		;9aa1
	rra			;9aa4
	jp c,L_9502		;9aa5
	rra			;9aa8
	rra			;9aa9
	rra			;9aaa
	jp nc,L_9528		;9aab
	jp L_9A50		;9aae
borra_hueco_ficha:		; borra el rectangulo de la ficha robada de la mano
	call L_96C7		;9ab1   ; borra el rectangulo donde estaba la ficha robada de la mano del jugador 0xC207 (tablas 0x9ADB y 0x9AF3)
	ld a,(0c207h)		;9ab4   ; lee el jugador al que le toca (0 = el humano)
	ld hl,09adbh		;9ab7
	call 04067h		;9aba
	ld a,l			;9abd
	ld l,h			;9abe
	ld h,a			;9abf
	push hl			;9ac0
	ld a,(0c207h)		;9ac1   ; lee el jugador al que le toca (0 = el humano)
	and 001h		;9ac4
	add a,a			;9ac6
	ld hl,09af3h		;9ac7
	call 0405ch		;9aca   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9acd
	ld b,a			;9ace
	inc hl			;9acf
	ld a,(hl)			;9ad0
	ld c,a			;9ad1
	pop hl			;9ad2
	ld a,000h		;9ad3
	ld d,000h		;9ad5
	call 04fe5h		;9ad7   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;9ada

; ----------------------------------------------------------------------
; DATOS resto_9ADB: lo apuntan con el banco puesto p02:9AB7 (0x9ADB); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9AB7 (8 bytes)
;   0x9adb..0x9ae3  (8 bytes)
DATA_resto_9ADB:
	defb 0e3h,09ah,0eah,09ah,0eah,09ah,0e3h,09ah	; 9adb  ........

; ======================================================================
; CODIGO 0x9ae3..0x9af3  (16 bytes)
; ======================================================================


L_9AE3:
	ld a,(0c200h)		;9ae3   ; lee contador de trabajo de las fichas de la mano
	inc a			;9ae6
	jp L_8CCA		;9ae7
L_9AEA:
	ld a,(0c200h)		;9aea   ; lee contador de trabajo de las fichas de la mano
	inc a			;9aed
	inc a			;9aee
	inc a			;9aef
	jp L_8CCA		;9af0

; ----------------------------------------------------------------------
; DATOS resto_9AF3: lo apuntan con el banco puesto p02:9AC7 (0x9AF3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9AC7 (4 bytes)
;   0x9af3..0x9af7  (4 bytes)
DATA_resto_9AF3:
	defb 024h,012h,012h,024h	; 9af3

; ======================================================================
; CODIGO 0x9af7..0x9b20  (41 bytes)
; ======================================================================


L_9AF7:
	call L_96C7		;9af7   ; igual que 0x9AB1 para la otra mesa (tablas 0x9B20 y 0x9B37)
	ld a,(0c207h)		;9afa   ; lee el jugador al que le toca (0 = el humano)
	ld hl,09b20h		;9afd
	call 04067h		;9b00
	ld a,l			;9b03
	ld l,h			;9b04
	ld h,a			;9b05
	push hl			;9b06
	ld a,(0c207h)		;9b07   ; lee el jugador al que le toca (0 = el humano)
	and 001h		;9b0a
	add a,a			;9b0c
	ld hl,09b37h		;9b0d
	call 0405ch		;9b10   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9b13
	ld b,a			;9b14
	inc hl			;9b15
	ld a,(hl)			;9b16
	ld c,a			;9b17
	pop hl			;9b18
	ld a,000h		;9b19
	ld d,000h		;9b1b
	jp 04fe5h		;9b1d   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)

; ----------------------------------------------------------------------
; DATOS resto_9B20: lo apuntan con el banco puesto p02:9AFD (0x9B20); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9AFD (8 bytes)
;   0x9b20..0x9b28  (8 bytes)
DATA_resto_9B20:
	defb 028h,09bh,02fh,09bh,02fh,09bh,028h,09bh	; 9b20  (././.(.

; ======================================================================
; CODIGO 0x9b28..0x9b37  (15 bytes)
; ======================================================================


L_9B28:
	ld a,(0c200h)		;9b28   ; lee contador de trabajo de las fichas de la mano
	inc a			;9b2b
	jp L_8CCA		;9b2c
L_9B2F:
	ld a,(0c200h)		;9b2f   ; lee contador de trabajo de las fichas de la mano
	inc a			;9b32
	inc a			;9b33
	jp L_8CCA		;9b34

; ----------------------------------------------------------------------
; DATOS resto_9B37: lo apuntan con el banco puesto p02:9B0D (0x9B37); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9B0D (4 bytes)
;   0x9b37..0x9b3b  (4 bytes)
DATA_resto_9B37:
	defb 018h,012h,012h,018h	; 9b37

; ======================================================================
; CODIGO 0x9b3b..0x9d0e  (467 bytes)
; ======================================================================


L_9B3B:
	ld b,020h		;9b3b   ; pone 0x08 en 0xCA00 (32 bytes) y cuenta cuantas casillas libres hay en +0x69
	ld hl,0ca00h		;9b3d   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,008h		;9b40
L_9B42:
	ld (hl),a			;9b42
	inc hl			;9b43
	djnz L_9B42		;9b44
	ld hl,0d069h		;9b46
	ld b,002h		;9b49
L_9B4B:
	ld a,(hl)			;9b4b   ; busca la primera casilla libre de la lista +0x69
	cp 0ffh		;9b4c
	jr z,L_9B54		;9b4e
	inc hl			;9b50
	inc hl			;9b51
	djnz L_9B4B		;9b52
L_9B54:
	ld a,002h		;9b54
	sub b			;9b56
	ld (0c211h),a		;9b57   ; guarda el numero de opciones del cuadro
	xor a			;9b5a
	ld (0c213h),a		;9b5b   ; guarda la opcion elegida en el cuadro
	ret			;9b5e
L_9B5F:
	call 0a4bah		;9b5f   ; eleccion entre las fichas del kan (0xC211 = el numero de opciones)
	ld a,(0c007h)		;9b62   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	rra			;9b65
	rra			;9b66
	rra			;9b67
	jr c,L_9B73		;9b68
	rra			;9b6a
	jr c,L_9B83		;9b6b
	rra			;9b6d
	jr c,L_9BE0		;9b6e
	jp L_9B97		;9b70
L_9B73:
	ld a,(0c213h)		;9b73   ; lee la opcion elegida en el cuadro
	and a			;9b76
	jr z,L_9B7D		;9b77
	dec a			;9b79
	jp L_9B91		;9b7a
L_9B7D:
	ld a,(0c211h)		;9b7d   ; lee el numero de opciones del cuadro
	jp L_9B91		;9b80
L_9B83:
	ld hl,0c211h		;9b83   ; apunta a el numero de opciones del cuadro
	ld a,(0c213h)		;9b86   ; lee la opcion elegida en el cuadro
	cp (hl)			;9b89
	jr z,L_9B90		;9b8a
	inc a			;9b8c
	jp L_9B91		;9b8d
L_9B90:
	xor a			;9b90
L_9B91:
	ld (0c213h),a		;9b91   ; guarda la opcion elegida en el cuadro
	call 04116h		;9b94   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_9B97:
	ld a,(0c213h)		;9b97   ; coloca los dos sprites del cursor de las fichas del kan (+0x67 las dos)
	ld hl,0d067h		;9b9a
	call 04d07h		;9b9d   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,l			;9ba0
	ld b,a			;9ba1
	ld c,00ch		;9ba2
	call multiplica_b_c		;9ba4   ; multiplica_b_c: A = B x C
	ld b,021h		;9ba7
	add a,b			;9ba9
	ld (0cc01h),a		;9baa
	ld a,0cch		;9bad
	ld (0cc00h),a		;9baf   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld a,048h		;9bb2
	ld (0cc02h),a		;9bb4
	ld a,h			;9bb7
	ld b,a			;9bb8
	ld c,00ch		;9bb9
	call multiplica_b_c		;9bbb   ; multiplica_b_c: A = B x C
	ld b,021h		;9bbe
	add a,b			;9bc0
	ld (0cc05h),a		;9bc1
	ld a,0cch		;9bc4
	ld (0cc04h),a		;9bc6
	ld a,048h		;9bc9
	ld (0cc06h),a		;9bcb
	ld hl,0ca00h		;9bce   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,00eh		;9bd1
	call 04382h		;9bd3   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	ld hl,0ca10h		;9bd6
	ld a,00eh		;9bd9
	call 04382h		;9bdb   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	or a			;9bde
	ret			;9bdf
L_9BE0:
	call 0a528h		;9be0   ; el boton: 0xA528, quita el cursor y sigue con 0x9C93
	ld a,(0c207h)		;9be3   ; lee el jugador al que le toca (0 = el humano)
	push af			;9be6
	ld a,(0c20dh)		;9be7   ; lee el jugador que responde a la ficha tirada
	ld (0c207h),a		;9bea   ; guarda el jugador al que le toca (0 = el humano)
	call tapa_ficha_tirada		;9bed   ; tapa_ficha_tirada: tapa en la mano la ficha que se tira
	pop af			;9bf0
	ld (0c207h),a		;9bf1   ; guarda el jugador al que le toca (0 = el humano)
	call L_89C8		;9bf4   ; pone a cero +0x71 de las cuatro manos (0xD071, D471, D871, DC71)
	jp L_9A50		;9bf7
L_9BFA:
	ld hl,0c21ah		;9bfa   ; cuenta cuantas opciones validas hay en 0xC21A (hasta 0xFF) y guarda 0xC211
	ld b,003h		;9bfd
L_9BFF:
	ld a,(hl)			;9bff
	cp 0ffh		;9c00
	jr z,L_9C07		;9c02
	inc hl			;9c04
	djnz L_9BFF		;9c05
L_9C07:
	ld a,002h		;9c07
	sub b			;9c09
	ld (0c211h),a		;9c0a   ; guarda el numero de opciones del cuadro
	xor a			;9c0d
	ld (0c213h),a		;9c0e   ; guarda la opcion elegida en el cuadro
	ret			;9c11
L_9C12:
	ld a,(0c007h)		;9c12   ; eleccion del grupo del chi: izquierda, derecha y boton
	rra			;9c15
	rra			;9c16
	rra			;9c17
	jr c,L_9C23		;9c18
	rra			;9c1a
	jr c,L_9C33		;9c1b
	rra			;9c1d
	jr c,L_9C8A		;9c1e
	jp L_9C47		;9c20
L_9C23:
	ld a,(0c213h)		;9c23   ; lee la opcion elegida en el cuadro
	and a			;9c26
	jr z,L_9C2D		;9c27
	dec a			;9c29
	jp L_9C41		;9c2a
L_9C2D:
	ld a,(0c211h)		;9c2d   ; lee el numero de opciones del cuadro
	jp L_9C41		;9c30
L_9C33:
	ld hl,0c211h		;9c33   ; apunta a el numero de opciones del cuadro
	ld a,(0c213h)		;9c36   ; lee la opcion elegida en el cuadro
	cp (hl)			;9c39
	jr z,L_9C40		;9c3a
	inc a			;9c3c
	jp L_9C41		;9c3d
L_9C40:
	xor a			;9c40
L_9C41:
	ld (0c213h),a		;9c41   ; guarda la opcion elegida en el cuadro
	call 04116h		;9c44   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_9C47:
	ld a,(0c213h)		;9c47   ; coloca el cursor sobre el grupo elegido de 0xC21A (bit 6: grupo bajado; bit 7: tres iguales)
	ld hl,0c21ah		;9c4a   ; apunta a las opciones de chi y kan (3 bytes)
	call 0405ch		;9c4d   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9c50
	push af			;9c51
	cp 040h		;9c52
	jr c,L_9C67		;9c54
	and 0c0h		;9c56
	cp 0c0h		;9c58
	jr z,L_9C67		;9c5a
	pop af			;9c5c
	call L_96C7		;9c5d   ; cuenta las fichas de la mano que valen (sin los bits 6-7): deja 0xC200 = la ultima
	ld a,(0c200h)		;9c60   ; lee contador de trabajo de las fichas de la mano
	inc a			;9c63
	jp L_9C6A		;9c64
L_9C67:
	pop af			;9c67
	and 00fh		;9c68
L_9C6A:
	ld b,a			;9c6a
	ld c,00ch		;9c6b
	call multiplica_b_c		;9c6d   ; multiplica_b_c: A = B x C
	ld b,021h		;9c70
	add a,b			;9c72
	ld (0cc01h),a		;9c73
	ld a,0cch		;9c76
	ld (0cc00h),a		;9c78   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld a,048h		;9c7b
	ld (0cc02h),a		;9c7d
	ld hl,0ca00h		;9c80   ; apunta a los colores de los sprites (4 bloques de 16)
	ld a,00eh		;9c83
	call 04382h		;9c85   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes) (p00:4382)
	or a			;9c88
	ret			;9c89
L_9C8A:
	ld a,(0c207h)		;9c8a   ; lee el jugador al que le toca (0 = el humano)
	call tapa_ficha_tirada		;9c8d   ; tapa_ficha_tirada: tapa en la mano la ficha que se tira
	jp L_9A50		;9c90
tapa_ficha_tirada:		; tapa en la mano la ficha que se tira
	call L_96C7		;9c93   ; BORRA la ficha que se tira de la mano (0xC200 = la ultima) y la tapa con el color del fondo (0xAA)
	ld hl,0c200h		;9c96   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;9c99
	ld a,(0c20ah)		;9c9a   ; lee la posicion de la ficha en la mano
	cp (hl)			;9c9d
	jr z,L_9CBA		;9c9e
	call L_8CCA		;9ca0
L_9CA3:
	ld a,l			;9ca3
	ld l,h			;9ca4
	ld h,a			;9ca5
	push hl			;9ca6
	call tamano_ficha		;9ca7   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,(0c205h)		;9caa   ; lee el ancho de la ficha
	ld b,a			;9cad
	ld a,(0c206h)		;9cae   ; lee el alto de la ficha
	ld c,a			;9cb1
	ld a,0aah		;9cb2
	ld d,000h		;9cb4
	pop hl			;9cb6
	call 04fe5h		;9cb7   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
L_9CBA:
	ld b,060h		;9cba   ; retardo corto
L_9CBC:
	push bc			;9cbc
	ld b,0ffh		;9cbd
L_9CBF:
	push bc			;9cbf   ; retardo
	pop bc			;9cc0
	djnz L_9CBF		;9cc1
	pop bc			;9cc3
	djnz L_9CBC		;9cc4
	ret			;9cc6
L_9CC7:
	call sitio_de_la_ficha		;9cc7   ; sitio_de_la_ficha: calcula el sitio de la ficha 0xC200 + 1 de la mano
	jp L_9CA3		;9cca
L_9CCD:
	ld a,001h		;9ccd   ; abre el cuadro de respuesta (24 de alto) y pone 0xC220 = 1
	ld (0c220h),a		;9ccf   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,06478h		;9cd2
	ld de,0a248h		;9cd5
	ld bc,03820h		;9cd8
	ld a,002h		;9cdb
	call 05024h		;9cdd   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0687ch		;9ce0
	ld bc,03018h		;9ce3
	ld a,0ffh		;9ce6
	ld d,000h		;9ce8
	call 04fe5h		;9cea   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06478h		;9ced
	ld hl,00704h		;9cf0
	call ventana		;9cf3   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld hl,09d0eh		;9cf6
	jp 05363h		;9cf9   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
L_9CFC:
	xor a			;9cfc   ; cierra el cuadro de respuesta: devuelve el fondo de la pagina 1
	ld (0c220h),a		;9cfd   ; guarda 1 si el cuadro de respuestas esta abierto
	ld hl,0a248h		;9d00
	ld de,06478h		;9d03
	ld bc,03820h		;9d06
	ld a,001h		;9d09
	jp 05024h		;9d0b   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)

; ----------------------------------------------------------------------
; DATOS tiles_9D0E: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p02:9CF9 (14 bytes)
;   0x9d0e..0x9d1c  (14 bytes)
DATA_tiles_9D0E:
	defb 074h,080h,00fh,02eh,013h,02ah,0feh,074h,088h,069h,06ah,06bh,06ch,0ffh	; 9d0e  t....*.t.ijkl.

; ======================================================================
; CODIGO 0x9d1c..0x9feb  (719 bytes)
; ======================================================================


ventana:		; dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld a,085h		;9d1c   ; DIBUJA UNA VENTANA con marco: H = ancho en tiles, L = alto, DE = esquina; usa los tiles 0x85-0x8C (esquinas y lados)
	call 05398h		;9d1e   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,h			;9d21
	dec a			;9d22
	dec a			;9d23
	ld b,a			;9d24
L_9D25:
	push bc			;9d25
	ld a,d			;9d26
	add a,008h		;9d27
	ld d,a			;9d29
	push de			;9d2a
	ld a,086h		;9d2b
	call 05398h		;9d2d   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;9d30
	pop bc			;9d31
	djnz L_9D25		;9d32
	ld a,d			;9d34
	add a,008h		;9d35
	ld d,a			;9d37
	ld a,087h		;9d38
	call 05398h		;9d3a   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,l			;9d3d
	dec a			;9d3e
	dec a			;9d3f
	ld b,a			;9d40
L_9D41:
	push bc			;9d41
	ld a,e			;9d42
	add a,008h		;9d43
	ld e,a			;9d45
	push de			;9d46
	ld a,089h		;9d47
	call 05398h		;9d49   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;9d4c
	pop bc			;9d4d
	djnz L_9D41		;9d4e
	ld a,e			;9d50
	add a,008h		;9d51
	ld e,a			;9d53
	ld a,08ch		;9d54
	call 05398h		;9d56   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,h			;9d59
	dec a			;9d5a
	dec a			;9d5b
	ld b,a			;9d5c
L_9D5D:
	push bc			;9d5d
	ld a,d			;9d5e
	sub 008h		;9d5f
	ld d,a			;9d61
	push de			;9d62
	ld a,08bh		;9d63
	call 05398h		;9d65   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;9d68
	pop bc			;9d69
	djnz L_9D5D		;9d6a
	ld a,d			;9d6c
	sub 008h		;9d6d
	ld d,a			;9d6f
	ld a,08ah		;9d70
	call 05398h		;9d72   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,l			;9d75
	dec a			;9d76
	dec a			;9d77
	ld b,a			;9d78
L_9D79:
	push bc			;9d79   ; dibuja el lado izquierdo del marco de la ventana con el tile 0x88
	ld a,e			;9d7a
	sub 008h		;9d7b
	ld e,a			;9d7d
	push de			;9d7e
	ld a,088h		;9d7f
	call 05398h		;9d81   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;9d84
	pop bc			;9d85
	djnz L_9D79		;9d86
	ret			;9d88
busca_opciones_chi_kan:		; busca las opciones de chi y kan en la mano
	xor a			;9d89   ; busca las opciones de chi/kan: pone 0xFF en 0xC21A-C y mira si no se acaba el muro (685E)
	ld (0c200h),a		;9d8a   ; guarda contador de trabajo de las fichas de la mano
	ld a,0ffh		;9d8d
	ld (0c21ah),a		;9d8f   ; guarda las opciones de chi y kan (3 bytes)
	ld (0c21bh),a		;9d92
	ld (0c21ch),a		;9d95
	call 0685eh		;9d98   ; compara las fichas robadas (0xC1C1 + 0xC210) con 0x79: Z/C si se acaba el muro (p01:685E)
	ret nc			;9d9b
	call L_9DA5		;9d9c   ; busca tres fichas iguales a la tirada en la mano (0xC209) y las anota en 0xC21A con el bit 7
	call L_9E23		;9d9f   ; busca cuatro fichas iguales en la mano (kan cerrado) y anota la posicion de la primera en 0xC21A
	jp L_9E7F		;9da2
L_9DA5:
	call 05e54h		;9da5   ; busca tres fichas iguales a la tirada en la mano (0xC209) y las anota en 0xC21A con el bit 7
L_9DA8:
	ld a,(0c209h)		;9da8   ; lee la ficha robada o tirada
	ld b,a			;9dab
	ld a,(hl)			;9dac
	cp 040h		;9dad
	jr nc,L_9DEA		;9daf
	and 03fh		;9db1
	cp b			;9db3
	jr z,L_9DBE		;9db4
L_9DB6:
	inc hl			;9db6
	ld a,l			;9db7
	cp 00dh		;9db8
	jp nz,L_9DA8		;9dba
	ret			;9dbd
L_9DBE:
	inc hl			;9dbe
	ld a,(hl)			;9dbf
	cp 040h		;9dc0
	jr nc,L_9DEA		;9dc2
	and 03fh		;9dc4
	cp b			;9dc6
	jr nz,L_9DB6		;9dc7
	inc hl			;9dc9
	ld a,(hl)			;9dca
	cp 040h		;9dcb
	jr nc,L_9DEA		;9dcd
	and 03fh		;9dcf
	cp b			;9dd1
	jr nz,L_9DB6		;9dd2
	ld a,l			;9dd4
	dec a			;9dd5
	dec a			;9dd6
	push af			;9dd7
	ld hl,0c21ah		;9dd8   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c200h)		;9ddb   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;9dde   ; suma_a_hl: HL = HL + A
	pop af			;9de1
	set 7,a		;9de2
	ld (hl),a			;9de4
	ld hl,0c200h		;9de5   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;9de8
	ret			;9de9
L_9DEA:
	ld hl,(0c0deh)		;9dea   ; si en la lista de grupos de +0x37 hay un grupo de esa ficha (pon), lo anota en 0xC21A con el bit 6
	ld de,0003fh		;9ded
	add hl,de			;9df0
	ld a,(hl)			;9df1
	and a			;9df2
	ret z			;9df3
	ld d,a			;9df4
	push de			;9df5
	ld hl,(0c0deh)		;9df6   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00037h		;9df9
	add hl,de			;9dfc
	pop de			;9dfd
	ld e,d			;9dfe
L_9DFF:
	ld a,(hl)			;9dff   ; busca la ficha B en la lista de grupos
	and 03fh		;9e00
	cp b			;9e02
	jr z,L_9E0C		;9e03
	dec d			;9e05
	ret z			;9e06
	inc hl			;9e07
	inc hl			;9e08
	jp L_9DFF		;9e09
L_9E0C:
	ld a,d			;9e0c
	sub e			;9e0d
	neg		;9e0e
	push af			;9e10
	ld hl,0c21ah		;9e11   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c200h)		;9e14   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;9e17   ; suma_a_hl: HL = HL + A
	pop af			;9e1a
	set 6,a		;9e1b
	ld (hl),a			;9e1d
	ld hl,0c200h		;9e1e   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;9e21
	ret			;9e22
L_9E23:
	call 05e54h		;9e23   ; busca cuatro fichas iguales en la mano (kan cerrado) y anota la posicion de la primera en 0xC21A
	push hl			;9e26
L_9E27:
	ld a,(hl)			;9e27   ; busca cuatro fichas iguales en la mano
	push af			;9e28
	inc hl			;9e29
	ld a,l			;9e2a
	cp 00dh		;9e2b
	jr nz,L_9E32		;9e2d
	pop af			;9e2f
	pop hl			;9e30
	ret			;9e31
L_9E32:
	pop af			;9e32
	cp (hl)			;9e33
	jr z,L_9E40		;9e34
L_9E36:
	push af			;9e36   ; sigue con la ficha siguiente
	inc hl			;9e37
	ld a,l			;9e38
	cp 00dh		;9e39
	jr nz,L_9E32		;9e3b
	jp L_9E73		;9e3d
L_9E40:
	push af			;9e40
	inc hl			;9e41
	ld a,l			;9e42
	cp 00dh		;9e43
	jp z,L_9E73		;9e45
	pop af			;9e48
	cp (hl)			;9e49
	jr nz,L_9E36		;9e4a
	push af			;9e4c
	inc hl			;9e4d
	ld a,l			;9e4e
	cp 00dh		;9e4f
	jp z,L_9E73		;9e51
	pop af			;9e54
	cp (hl)			;9e55
	jr nz,L_9E36		;9e56
	dec hl			;9e58
	dec hl			;9e59
	dec hl			;9e5a
	ld a,l			;9e5b
	push af			;9e5c
	ld hl,0c21ah		;9e5d   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c200h)		;9e60   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;9e63   ; suma_a_hl: HL = HL + A
	pop af			;9e66
	ld (hl),a			;9e67
	ld hl,0c200h		;9e68   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;9e6b
	pop hl			;9e6c
	ld a,l			;9e6d
	add a,004h		;9e6e
	jp L_9E77		;9e70
L_9E73:
	pop af			;9e73
	pop hl			;9e74
	inc hl			;9e75
	ld a,l			;9e76
L_9E77:
	cp 00dh		;9e77
	ret z			;9e79
	ld l,a			;9e7a
	push hl			;9e7b
	jp L_9E27		;9e7c
L_9E7F:
	ld a,(0c200h)		;9e7f   ; anota en 0xC21A cada ficha de la mano que forma kan con un grupo de +0x37
	push af			;9e82
	call 05e54h		;9e83   ; mano_de_jugador: HL = 0xD000 + 0x400 x 0xC207
	push hl			;9e86
	call L_96C7		;9e87   ; cuenta las fichas de la mano que valen (sin los bits 6-7): deja 0xC200 = la ultima
	ld a,(0c200h)		;9e8a   ; lee contador de trabajo de las fichas de la mano
	inc a			;9e8d
	ld b,a			;9e8e
	xor a			;9e8f
	ld (0c20ch),a		;9e90
	pop hl			;9e93
	pop af			;9e94
	ld (0c200h),a		;9e95   ; guarda contador de trabajo de las fichas de la mano
L_9E98:
	push bc			;9e98   ; recorre las fichas de la mano comprobando cada una
	push hl			;9e99
	ld a,(hl)			;9e9a
	call L_9EA8		;9e9b   ; busca la ficha B entre los grupos de +0x37 y la anota en 0xC21A con los bits 6 y 7
	ld hl,0c20ch		;9e9e
	inc (hl)			;9ea1
	pop hl			;9ea2
	inc hl			;9ea3
	pop bc			;9ea4
	djnz L_9E98		;9ea5
	ret			;9ea7
L_9EA8:
	ld b,a			;9ea8   ; busca la ficha B entre los grupos de +0x37 y la anota en 0xC21A con los bits 6 y 7
	ld hl,(0c0deh)		;9ea9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0003fh		;9eac
	add hl,de			;9eaf
	ld a,(hl)			;9eb0
	and a			;9eb1
	ret z			;9eb2
	ld d,a			;9eb3
	push de			;9eb4
	ld hl,(0c0deh)		;9eb5   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00037h		;9eb8
	add hl,de			;9ebb
	pop de			;9ebc
	ld e,d			;9ebd
L_9EBE:
	ld a,(hl)			;9ebe   ; busca la ficha B en la lista de +0x37
	and 03fh		;9ebf
	cp b			;9ec1
	jr z,L_9ECB		;9ec2
	dec d			;9ec4
	ret z			;9ec5
	inc hl			;9ec6
	inc hl			;9ec7
	jp L_9EBE		;9ec8
L_9ECB:
	ld a,d			;9ecb
	sub e			;9ecc
	neg		;9ecd
	ld hl,0c21ah		;9ecf   ; apunta a las opciones de chi y kan (3 bytes)
	ld a,(0c200h)		;9ed2   ; lee contador de trabajo de las fichas de la mano
	call 0405ch		;9ed5   ; suma_a_hl: HL = HL + A
	ld a,(0c20ch)		;9ed8
	set 6,a		;9edb
	set 7,a		;9edd
	ld (hl),a			;9edf
	ld hl,0c200h		;9ee0   ; apunta a contador de trabajo de las fichas de la mano
	inc (hl)			;9ee3
	ret			;9ee4
L_9EE5:
	ld hl,0c0bah		;9ee5   ; recorre los jugadores que dijeron algo (0xC0BA: cuantos, 0xC0BB..): para el primero con +0x34 a cero sigue en 0x9F09
	ld a,(hl)			;9ee8
	ld b,a			;9ee9
	inc hl			;9eea
L_9EEB:
	push bc			;9eeb   ; por cada jugador que ha dicho algo mira si esta en espera
	push hl			;9eec
	ld a,(hl)			;9eed
	ld hl,0d000h		;9eee
	add a,a			;9ef1
	add a,a			;9ef2
	add a,h			;9ef3
	ld h,a			;9ef4
	ld de,00034h		;9ef5   ; +0x34 es el aviso de espera de esa mano
	add hl,de			;9ef8
	ld a,(hl)			;9ef9
	and a			;9efa
	jp z,L_9F03		;9efb   ; si no esta, sigue con el siguiente jugador
	pop hl			;9efe
	pop bc			;9eff
	jp L_9F09		;9f00
L_9F03:
	pop hl			;9f03
	inc hl			;9f04
	pop bc			;9f05
	djnz L_9EEB		;9f06
	ret			;9f08
L_9F09:
	ld a,(0c027h)		;9f09   ; dibuja las fichas del muro muerto: si 0xC027 es cero solo la ficha de indicador (la 0x83 desde el final); si no, los dos montones de cuatro
	and a			;9f0c
	jp nz,L_9F36		;9f0d
	ld a,(0c207h)		;9f10   ; lee el jugador al que le toca (0 = el humano)
	push af			;9f13
	xor a			;9f14
	ld (0c207h),a		;9f15   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;9f18   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
	ld a,048h		;9f1b
	ld (0c203h),a		;9f1d   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9f20
	ld (0c204h),a		;9f22   ; guarda la Y donde se dibuja la ficha
	ld a,083h		;9f25
	ld hl,0c100h		;9f27   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;9f2a   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9f2d
	call dibuja_ficha_2		;9f2e   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	pop af			;9f31
	ld (0c207h),a		;9f32   ; guarda el jugador al que le toca (0 = el humano)
	ret			;9f35
L_9F36:
	ld hl,04860h		;9f36   ; dibuja el muro muerto abierto (rectangulo de 112 x 18 puntos) y las fichas boca arriba hasta el indicador de dora
	ld bc,07012h		;9f39
	ld a,0ffh		;9f3c
	ld d,000h		;9f3e
	call 04fe5h		;9f40   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld a,(0c207h)		;9f43   ; lee el jugador al que le toca (0 = el humano)
	push af			;9f46
	ld b,004h		;9f47
	ld a,048h		;9f49
	ld (0c203h),a		;9f4b   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9f4e
	ld (0c204h),a		;9f50   ; guarda la Y donde se dibuja la ficha
	xor a			;9f53
	ld (0c207h),a		;9f54   ; guarda el jugador al que le toca (0 = el humano)
	call tamano_ficha		;9f57   ; tamano_ficha: 0xC205/0xC206 = ancho y alto de la ficha del jugador 0xC207
L_9F5A:
	push bc			;9f5a
	call L_8B86		;9f5b
	pop bc			;9f5e
	ld a,(0c203h)		;9f5f   ; lee la X donde se dibuja la ficha
	add a,00ch		;9f62
	ld (0c203h),a		;9f64   ; guarda la X donde se dibuja la ficha
	djnz L_9F5A		;9f67
	ld b,004h		;9f69
	ld a,080h		;9f6b
	ld (0c203h),a		;9f6d   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9f70
	ld (0c204h),a		;9f72   ; guarda la Y donde se dibuja la ficha
L_9F75:
	push bc			;9f75
	call L_8B86		;9f76
	pop bc			;9f79
	ld a,(0c203h)		;9f7a   ; lee la X donde se dibuja la ficha
	add a,00ch		;9f7d
	ld (0c203h),a		;9f7f   ; guarda la X donde se dibuja la ficha
	djnz L_9F75		;9f82
	ld a,080h		;9f84
	ld (0c203h),a		;9f86   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9f89
	ld (0c204h),a		;9f8b   ; guarda la Y donde se dibuja la ficha
	ld a,(0c210h)		;9f8e   ; lee las fichas sacadas del final del muro (por kan)
	inc a			;9f91
	ld b,a			;9f92
	xor a			;9f93
L_9F94:
	push bc			;9f94
	push af			;9f95
	add a,a			;9f96
	ld b,a			;9f97
	ld a,083h		;9f98
	sub b			;9f9a
	ld hl,0c100h		;9f9b   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;9f9e   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9fa1
	call dibuja_ficha_2		;9fa2   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ld a,(0c203h)		;9fa5   ; lee la X donde se dibuja la ficha
	add a,00ch		;9fa8
	ld (0c203h),a		;9faa   ; guarda la X donde se dibuja la ficha
	pop af			;9fad
	inc a			;9fae
	pop bc			;9faf
	djnz L_9F94		;9fb0
	ld a,048h		;9fb2
	ld (0c203h),a		;9fb4   ; guarda la X donde se dibuja la ficha
	ld a,060h		;9fb7
	ld (0c204h),a		;9fb9   ; guarda la Y donde se dibuja la ficha
	ld a,(0c210h)		;9fbc   ; lee las fichas sacadas del final del muro (por kan)
	inc a			;9fbf
	ld b,a			;9fc0
	xor a			;9fc1
L_9FC2:
	push bc			;9fc2
	push af			;9fc3
	add a,a			;9fc4
	ld b,a			;9fc5
	ld a,082h		;9fc6
	sub b			;9fc8
	ld hl,0c100h		;9fc9   ; apunta a el muro: 136 fichas (0x88)
	call 0405ch		;9fcc   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;9fcf
	call dibuja_ficha_2		;9fd0   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	ld a,(0c203h)		;9fd3   ; lee la X donde se dibuja la ficha
	add a,00ch		;9fd6
	ld (0c203h),a		;9fd8   ; guarda la X donde se dibuja la ficha
	pop af			;9fdb
	inc a			;9fdc
	pop bc			;9fdd
	djnz L_9FC2		;9fde
	pop af			;9fe0
	ld (0c207h),a		;9fe1   ; guarda el jugador al que le toca (0 = el humano)
	ret			;9fe4
respuesta_ronda:		; pasos de la respuesta de la ronda (pon, chi, kan, ron)
	ld a,(0c216h)		;9fe5   ; respuesta de la ronda: 0xC216 elige por la tabla de 0x9FE8 y 0xC215 el paso de cada una
	call 04066h		;9fe8   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9FEB: 4 destinos del despachador p00:4066 (call en p02:9FE8, el
;   indice en A): 9FF3, 9FF3, A060, A0EE; lo leen p02:9FE8 (8 bytes)
;   0x9feb..0x9ff3  (8 bytes)
DATA_tabla_9FEB:
	defw 09ff3h,09ff3h,0a060h,0a0eeh	; 9feb  -> L_9FF3 L_9FF3 0xa060 0xa0ee

; ======================================================================
; CODIGO 0x9ff3..0x9ff9  (6 bytes)
; ======================================================================


L_9FF3:
	ld a,(0c215h)		;9ff3   ; lee el paso de la respuesta
	call 04066h		;9ff6   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9FF9: 3 destinos del despachador p00:4066 (call en p02:9FF6, el
;   indice en A): 9FFF, A012, A028; lo leen p02:9FF6 (6 bytes)
;   0x9ff9..0x9fff  (6 bytes)
DATA_tabla_9FF9:
	defw 09fffh,0a012h,0a028h	; 9ff9  -> DATA_partida_9FFF 0xa012 0xa028

; ----------------------------------------------------------------------
; DATOS partida_9FFF: los 1 primeros bytes de una instruccion de 3 (CD 2E 9A)
;   que sigue en el banco 3: el trazador de un solo banco no puede verla
;   entera (tools/bancos.py); lo leen p02:9FFF (1 bytes)
;   0x9fff..0xa000  (1 bytes)
DATA_partida_9FFF:
	defb 0cdh	; 9fff
