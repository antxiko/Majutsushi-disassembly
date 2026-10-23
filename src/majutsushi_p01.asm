; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS partida_6000: los 1 ultimos bytes de la instruccion de p00:5FFF (3E
;   02), que empieza en el banco 0; lo leen p00:5FFF (1 bytes)
;   0x6000..0x6001  (1 bytes)
DATA_partida_6000:
	defb 002h	; 6000

; ======================================================================
; CODIGO 0x6001..0x60fa  (249 bytes)
; ======================================================================


L_6001:
	call 05024h		;6001   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0588ch		;6004
	ld bc,05018h		;6007
	ld a,0ffh		;600a
	ld d,000h		;600c
	call 04fe5h		;600e   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,09c5ch		;6011
	ld bc,05018h		;6014
	ld a,0ffh		;6017
	ld d,000h		;6019
	call 04fe5h		;601b   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,0582ch		;601e
	ld bc,05018h		;6021
	ld a,0ffh		;6024
	ld d,000h		;6026
	call 04fe5h		;6028   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,0145ch		;602b
	ld bc,05018h		;602e
	ld a,0ffh		;6031
	ld d,000h		;6033
	call 04fe5h		;6035   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,05488h		;6038
	ld hl,00b04h		;603b
	call 09d1ch		;603e   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,09858h		;6041
	ld hl,00b04h		;6044
	call 09d1ch		;6047   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,05428h		;604a
	ld hl,00b04h		;604d
	call 09d1ch		;6050   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,01058h		;6053
	ld hl,00b04h		;6056
	call 09d1ch		;6059   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	call 04c33h		;605c
	ret			;605f
cuadro_fichas_que_quedan:		; dibuja el cuadro de las fichas que quedan
	ld hl,06c50h		;6060   ; dibuja el cuadro de cuenta atras (fichas que quedan): guarda el fondo, lo pinta y escribe el numero (0xC20E)
	ld de,0d800h		;6063
	ld bc,02830h		;6066
	ld a,002h		;6069
	call 05024h		;606b   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,07054h		;606e
	ld bc,02028h		;6071
	ld a,0ffh		;6074
	ld d,000h		;6076
	call 04fe5h		;6078   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06c50h		;607b
	ld hl,00506h		;607e
	call 09d1ch		;6081   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	call cuenta_fichas_que_quedan		;6084   ; cuenta_fichas_que_quedan: calcula las fichas que quedan en el muro (BCD)
	ld hl,06140h		;6087
	call 05363h		;608a   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	ld hl,0c20eh		;608d   ; apunta a las fichas que quedan en el muro (BCD)
	ld de,0786ch		;6090
	ld b,001h		;6093
	call 04cc9h		;6095   ; numero_sin_ceros: escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ret			;6098
cuenta_fichas_que_quedan:		; calcula las fichas que quedan en el muro (BCD)
	or a			;6099   ; fichas que quedan = 0x7A - 0xC1C1 - 0xC210, en BCD, a 0xC20E
	ld a,07ah		;609a
	ld hl,0c1c1h		;609c   ; apunta a cuantas fichas se han robado del muro
	sub (hl)			;609f
	ld hl,0c210h		;60a0   ; apunta a las fichas sacadas del final del muro (por kan)
	sub (hl)			;60a3
	dec a			;60a4
	jr z,L_60AE		;60a5
	ld b,a			;60a7
	xor a			;60a8
L_60A9:
	add a,001h		;60a9
	daa			;60ab
	djnz L_60A9		;60ac
L_60AE:
	ld (0c20eh),a		;60ae   ; guarda las fichas que quedan en el muro (BCD)
	ret			;60b1
devuelve_fondo:		; devuelve a la pagina 0 los cuatro fondos guardados
	ld de,05488h		;60b2   ; devuelve a la pagina 0 los cuatro bloques del fondo guardados en la pagina 1 (a partir de 0xA248)
	ld hl,0a248h		;60b5
	ld bc,05820h		;60b8
	ld a,001h		;60bb
	call 05024h		;60bd   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld de,09858h		;60c0
	ld hl,0a268h		;60c3
	ld bc,05820h		;60c6
	ld a,001h		;60c9
	call 05024h		;60cb   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld de,05428h		;60ce
	ld hl,0a288h		;60d1
	ld bc,05820h		;60d4
	ld a,001h		;60d7
	call 05024h		;60d9   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld de,01058h		;60dc
	ld hl,0a2a8h		;60df
	ld bc,05820h		;60e2
	ld a,001h		;60e5
	call 05024h		;60e7   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ret			;60ea
L_60EB:
	ld de,06c50h		;60eb
	ld hl,0d800h		;60ee
	ld bc,02830h		;60f1
	ld a,001h		;60f4
	call 05024h		;60f6   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ret			;60f9

; ----------------------------------------------------------------------
; DATOS resto_60FA: lo apuntan con el banco puesto p00:5EF5 (0x60FA), p00:5EEF
;   (0x610F), p00:5F2F (0x6124), p00:5F35 (0x6132); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p00:5EF5, p00:5EEF,
;   p00:5F2F, p00:5F35 (70 bytes)
;   0x60fa..0x6140  (70 bytes)
DATA_resto_60FA:
	defb 074h,080h,00fh,02eh,013h,02ah,0feh,074h,088h,070h,071h,072h,063h,0feh,074h,090h	; 60fa  t....*.t.pqrc.t.
	defb 06ah,063h,06dh,061h,0ffh,074h,080h,00fh,02eh,013h,02ah,0feh,074h,088h,070h,071h	; 610a  jcma.t....*.t.pq
	defb 072h,063h,0feh,074h,090h,06eh,065h,063h,06fh,0ffh,074h,080h,00fh,02eh,013h,02ah	; 611a  rc.t.neco.t....*
	defb 0feh,074h,088h,070h,071h,072h,063h,0ffh,074h,080h,00fh,02eh,013h,02ah,0feh,074h	; 612a  .t.pqrc.t....*.t
	defb 088h,070h,071h,072h,063h,0ffh	; 613a

; ----------------------------------------------------------------------
; DATOS tiles_6140: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p01:608A (6 bytes)
;   0x6140..0x6146  (6 bytes)
DATA_tiles_6140:
	defb 074h,05ch,081h,071h,066h,0ffh	; 6140

; ======================================================================
; CODIGO 0x6146..0x6216  (208 bytes)
; ======================================================================


teclas_a_sonidos:		; pide el sonido que dicen las teclas de funcion
	ld a,(0c00ch)		;6146   ; pasa lo que han dicho las teclas de funcion (0xC00C) a un sonido: cada bit pide uno, si no es el mismo de antes
	rra			;6149   ; recorre los cinco bits de las teclas de funcion de 0xC00C: el primero que esta puesto elige su sonido
	jr c,L_6159		;614a
	rra			;614c
	jr c,L_6168		;614d
	rra			;614f
	jr c,L_616D		;6150
	rra			;6152
	jr c,L_6172		;6153
	rra			;6155
	jr c,L_6177		;6156
	ret			;6158
L_6159:
	ld hl,040fdh		;6159
L_615C:
	ld de,(0c0c2h)		;615c
	call 00020h		;6160   ; BIOS DCOMPR - Compares HL with DE
	ret z			;6163
	ld (0c0c2h),hl		;6164
	jp (hl)			;6167
L_6168:
	ld hl,04134h		;6168
	jr L_615C		;616b
L_616D:
	ld hl,0412fh		;616d
	jr L_615C		;6170
L_6172:
	ld hl,04125h		;6172
	jr L_615C		;6175
L_6177:
	ld hl,0412ah		;6177
	jr L_615C		;617a
prepara_inicio:		; prepara el fondo de la partida
	xor a			;617c   ; prepara la partida: pone a cero 0xC009 y 0xC24D, carga el fondo y el marco
	ld (0c009h),a		;617d
	ld (0c24dh),a		;6180
	call 0568ah		;6183   ; carga_fondo_mesa: carga el fondo de la mesa (bancos 7-9)
	call 056c6h		;6186   ; carga una imagen de los bancos 10-11 (HL = lista de tiles, DE = tabla) (p00:56C6)
	ld a,001h		;6189
	ld (0c0b0h),a		;618b   ; guarda 1 cuando la partida esta lista
	ret			;618e
busca_otro_cartucho:		; busca el cartucho de la memoria de partidas en las ranuras
	ld bc,00400h		;618f   ; busca otro cartucho con la memoria de partidas: recorre las 4 ranuras primarias y sus secundarias
	ld hl,0fcc1h		;6192
L_6195:
	push bc			;6195
	push hl			;6196
	ld a,(hl)			;6197
	bit 7,a		;6198
	jr nz,L_61A2		;619a
	ld a,c			;619c
	call L_61C2		;619d   ; mira si en la ranura A (0xF0F5) hay un cartucho con 'YZ' en 0x4010-0x4011 (RDSLT); si lo hay, A = ranura y acarreo
	jr L_61A5		;61a0
L_61A2:
	call L_61B2		;61a2
L_61A5:
	pop hl			;61a5
	pop bc			;61a6
	ret c			;61a7
	inc hl			;61a8
	inc c			;61a9
	djnz L_6195		;61aa
	ld a,0ffh		;61ac
	ld (0f0f5h),a		;61ae   ; guarda la ranura del otro cartucho (la memoria de partidas)
	ret			;61b1
L_61B2:
	and 080h		;61b2
	or c			;61b4
	ld b,004h		;61b5
L_61B7:
	push bc			;61b7
	call L_61C2		;61b8   ; mira si en la ranura A (0xF0F5) hay un cartucho con 'YZ' en 0x4010-0x4011 (RDSLT); si lo hay, A = ranura y acarreo
	pop bc			;61bb
	ret c			;61bc
	add a,004h		;61bd
	djnz L_61B7		;61bf
	ret			;61c1
L_61C2:
	ld (0f0f5h),a		;61c2   ; mira si en la ranura A (0xF0F5) hay un cartucho con 'YZ' en 0x4010-0x4011 (RDSLT); si lo hay, A = ranura y acarreo
	ld hl,04010h		;61c5
	call 0000ch		;61c8   ; BIOS RDSLT - Reads the value of an address in another slot
	cp 059h		;61cb
	jr nz,L_61E1		;61cd
	ld hl,04011h		;61cf
	ld a,(0f0f5h)		;61d2   ; lee la ranura del otro cartucho (la memoria de partidas)
	call 0000ch		;61d5   ; BIOS RDSLT - Reads the value of an address in another slot
	cp 05ah		;61d8
	jr nz,L_61E1		;61da
	ld a,(0f0f5h)		;61dc   ; lee la ranura del otro cartucho (la memoria de partidas)
	scf			;61df
	ret			;61e0
L_61E1:
	ld a,(0f0f5h)		;61e1   ; lee la ranura del otro cartucho (la memoria de partidas)
	and a			;61e4
	ret			;61e5
graba_partida:		; graba la partida en el otro cartucho
	ld a,(0fd9fh)		;61e6   ; salva la partida en el otro cartucho: pone un RET en el gancho de interrupcion (0xFD9F) mientras dura
	ld (0f0f8h),a		;61e9
	ld a,0c9h		;61ec
	ld (0fd9fh),a		;61ee
	call L_6222		;61f1   ; copia 5 bytes de 0x6244 a 0xC5C0 (el nombre del fichero) y pone a cero 8 bytes
	call L_6249		;61f4   ; llama a las rutinas del otro cartucho (en 0x8000, con la ranura 0xF0F5): 0, 2, 9 tres veces y 1; si alguna falla va a 0x63A8
	ld a,(0f0f8h)		;61f7
	ld (0fd9fh),a		;61fa
	ret			;61fd
carga_partida:		; carga la partida del otro cartucho
	ld a,(0fd9fh)		;61fe   ; carga la partida del otro cartucho (igual, con 0x62F9)
	ld (0f0f8h),a		;6201
	ld a,0c9h		;6204
	ld (0fd9fh),a		;6206
	call L_6222		;6209   ; copia 5 bytes de 0x6244 a 0xC5C0 (el nombre del fichero) y pone a cero 8 bytes
	call L_62F9		;620c
	ld a,(0f0f8h)		;620f
	ld (0fd9fh),a		;6212
	ret			;6215

; ----------------------------------------------------------------------
; DATOS resto_6216: lo apuntan con el banco puesto p01:6293 (0x6216), p01:6343
;   (0x6216); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6293, p01:6343 (12 bytes)
;   0x6216..0x6222  (12 bytes)
DATA_resto_6216:
	defb 034h,0c0h,009h,000h,040h,0c0h,040h,000h,080h,0c0h,01bh,000h	; 6216  4...@.@.....

; ======================================================================
; CODIGO 0x6222..0x6244  (34 bytes)
; ======================================================================


L_6222:
	ld hl,06244h		;6222   ; copia 5 bytes de 0x6244 a 0xC5C0 (el nombre del fichero) y pone a cero 8 bytes
	ld de,0c5c0h		;6225
	ld (0f0f6h),de		;6228
	ld bc,00005h		;622c
	ldir		;622f
	ld de,0c5c5h		;6231
	xor a			;6234
	ld b,008h		;6235
L_6237:
	ld (de),a			;6237
	inc de			;6238
	djnz L_6237		;6239
	inc de			;623b
	inc de			;623c
	inc de			;623d
	inc de			;623e
	ld a,(0f0f4h)		;623f   ; lee la ranura del cartucho
	ld (de),a			;6242
	ret			;6243

; ----------------------------------------------------------------------
; DATOS resto_6244: lo apuntan con el banco puesto p01:6222 (0x6244); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6222 (5 bytes)
;   0x6244..0x6249  (5 bytes)
DATA_resto_6244:
	defb 04dh,041h,04ah,041h,04eh	; 6244

; ======================================================================
; CODIGO 0x6249..0x646f  (550 bytes)
; ======================================================================


L_6249:
	ld de,(0f0f6h)		;6249   ; llama a las rutinas del otro cartucho (en 0x8000, con la ranura 0xF0F5): 0, 2, 9 tres veces y 1; si alguna falla va a 0x63A8
	ld a,(0f0f5h)		;624d   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6250
	call 00024h		;6252   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;6255
	ld (08000h),a		;6257
	ld c,000h		;625a
	ld de,(0f0f6h)		;625c
	call 08000h		;6260
	push af			;6263
	ld a,(0f0f4h)		;6264   ; lee la ranura del cartucho
	ld h,080h		;6267
	call 00024h		;6269   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;626c
	ld de,(0f0f6h)		;626d
	ld a,(0f0f5h)		;6271   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6274
	call 00024h		;6276   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;6279
	ld (08000h),a		;627b
	ld c,002h		;627e
	ld de,(0f0f6h)		;6280
	call 08000h		;6284
	push af			;6287
	ld a,(0f0f4h)		;6288   ; lee la ranura del cartucho
	ld h,080h		;628b
	call 00024h		;628d   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;6290
	ld b,003h		;6291
	ld hl,06216h		;6293
L_6296:
	push bc			;6296
	ld de,0c5cdh		;6297
	ld bc,00004h		;629a
	ldir		;629d
	push hl			;629f
	ld de,(0f0f6h)		;62a0
	ld a,(0f0f5h)		;62a4   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;62a7
	call 00024h		;62a9   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;62ac
	ld (08000h),a		;62ae
	ld c,009h		;62b1
	ld de,(0f0f6h)		;62b3
	call 08000h		;62b7
	push af			;62ba
	ld a,(0f0f4h)		;62bb   ; lee la ranura del cartucho
	ld h,080h		;62be
	call 00024h		;62c0   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;62c3
	pop hl			;62c4
	pop bc			;62c5
	or a			;62c6
	jp nz,L_63A8		;62c7
	djnz L_6296		;62ca
	ld de,(0f0f6h)		;62cc
	ld a,(0f0f5h)		;62d0   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;62d3
	call 00024h		;62d5   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;62d8
	ld (08000h),a		;62da
	ld c,001h		;62dd
	ld de,(0f0f6h)		;62df
	call 08000h		;62e3
	push af			;62e6
	ld a,(0f0f4h)		;62e7   ; lee la ranura del cartucho
	ld h,080h		;62ea
	call 00024h		;62ec   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;62ef
	or a			;62f0
	jp nz,L_63A8		;62f1
	xor a			;62f4
	ld (0c0e7h),a		;62f5   ; guarda 1 si ha fallado el grabar
	ret			;62f8
L_62F9:
	ld de,(0f0f6h)		;62f9   ; igual que 0x6249 pero para cargar (rutinas 0, 2, 8 tres veces y 1)
	ld a,(0f0f5h)		;62fd   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6300
	call 00024h		;6302   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;6305
	ld (08000h),a		;6307
	ld c,000h		;630a
	ld de,(0f0f6h)		;630c
	call 08000h		;6310
	push af			;6313
	ld a,(0f0f4h)		;6314   ; lee la ranura del cartucho
	ld h,080h		;6317
	call 00024h		;6319   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;631c
	ld de,(0f0f6h)		;631d
	ld a,(0f0f5h)		;6321   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6324
	call 00024h		;6326   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;6329
	ld (08000h),a		;632b
	ld c,002h		;632e
	ld de,(0f0f6h)		;6330
	call 08000h		;6334
	push af			;6337
	ld a,(0f0f4h)		;6338   ; lee la ranura del cartucho
	ld h,080h		;633b
	call 00024h		;633d   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;6340
	ld b,003h		;6341
	ld hl,06216h		;6343
L_6346:
	push bc			;6346
	ld de,0c5cdh		;6347
	ld bc,00004h		;634a
	ldir		;634d
	push hl			;634f
	ld de,(0f0f6h)		;6350
	ld a,(0f0f5h)		;6354   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6357
	call 00024h		;6359   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;635c
	ld (08000h),a		;635e
	ld c,008h		;6361
	ld de,(0f0f6h)		;6363
	call 08000h		;6367
	push af			;636a
	ld a,(0f0f4h)		;636b   ; lee la ranura del cartucho
	ld h,080h		;636e
	call 00024h		;6370   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;6373
	pop hl			;6374
	pop bc			;6375
	or a			;6376
	jp nz,L_63CE		;6377
	djnz L_6346		;637a
	ld de,(0f0f6h)		;637c
	ld a,(0f0f5h)		;6380   ; lee la ranura del otro cartucho (la memoria de partidas)
	ld h,080h		;6383
	call 00024h		;6385   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;6388
	ld (08000h),a		;638a
	ld c,001h		;638d
	ld de,(0f0f6h)		;638f
	call 08000h		;6393
	push af			;6396
	ld a,(0f0f4h)		;6397   ; lee la ranura del cartucho
	ld h,080h		;639a
	call 00024h		;639c   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;639f
	or a			;63a0
	jr nz,L_63CE		;63a1
	xor a			;63a3
	ld (0c0e8h),a		;63a4   ; guarda 1 si ha fallado el cargar
	ret			;63a7
L_63A8:
	ld a,(0f0f5h)		;63a8   ; error al grabar: llama a la rutina 6 del otro cartucho y pone 0xC0E7 = 1
	ld h,080h		;63ab
	call 00024h		;63ad   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;63b0
	ld (08000h),a		;63b2
	ld c,006h		;63b5
	ld de,(0f0f6h)		;63b7
	call 08000h		;63bb
	push af			;63be
	ld a,(0f0f4h)		;63bf   ; lee la ranura del cartucho
	ld h,080h		;63c2
	call 00024h		;63c4   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;63c7
	ld a,001h		;63c8
	ld (0c0e7h),a		;63ca   ; guarda 1 si ha fallado el grabar
	ret			;63cd
L_63CE:
	ld a,001h		;63ce   ; error al cargar: 0xC0E8 = 1
	ld (0c0e8h),a		;63d0   ; guarda 1 si ha fallado el cargar
	ret			;63d3
L_63D4:
	ld a,(0c02bh)		;63d4   ; pantalla de eleccion de contrasea o de ajustes: si 0xC02B ya no es cero, solo atiende las teclas
	and a			;63d7
	jp nz,L_6484		;63d8
	call 04e50h		;63db   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call 04e76h		;63de   ; pantalla_off: apaga la pantalla
	ld hl,05e60h		;63e1
	ld bc,04414h		;63e4
	ld a,0ffh		;63e7
	ld d,000h		;63e9
	call 04fe5h		;63eb   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,0585ah		;63ee
	ld hl,00a04h		;63f1
	call 09d1ch		;63f4   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	ld de,06062h		;63f7
	ld hl,0647fh		;63fa
	call 05acdh		;63fd   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call L_643F		;6400   ; rellena de 0xBB ocho cuadros de 52 x 52 puntos y escribe 8 x 8 tiles dentro
	call L_640E		;6403   ; dibuja ocho marcos de 48 x 48 puntos (hay un tile de la hoja en 0x6C40/0x6C70 para cada uno)
	call 04e69h		;6406   ; pantalla_on: enciende la pantalla
	ld hl,0c02bh		;6409   ; apunta a variable de los pasos de las pantallas de menu
	inc (hl)			;640c
	ret			;640d
L_640E:
	ld b,008h		;640e   ; dibuja ocho marcos de 48 x 48 puntos (hay un tile de la hoja en 0x6C40/0x6C70 para cada uno)
	ld hl,0646fh		;6410
L_6413:
	push bc			;6413   ; un marco de la lista de ocho: lee su posicion (X, Y) y calcula el origen del dibujo en la hoja (A = indice)
	ld d,(hl)			;6414
	inc hl			;6415
	ld e,(hl)			;6416
	inc hl			;6417
	push hl			;6418
	ld a,b			;6419   ; cuenta el marco desde el ultimo (8 - B)
	sub 008h		;641a
	neg		;641c
	ld c,a			;641e
	and 003h		;641f
	add a,a			;6421   ; el palo del marco (los dos bits bajos) por 16 para sacar su columna en la hoja
	add a,a			;6422
	add a,a			;6423
	add a,a			;6424
	ld b,a			;6425
	add a,a			;6426
	add a,b			;6427
	ld h,a			;6428   ; H = origen X del marco segun la columna; L = 0x40 en la fila de arriba y 0x70 en la de abajo
	ld a,c			;6429
	cp 004h		;642a
	ld l,040h		;642c
	jr c,L_6432		;642e
	ld l,070h		;6430   ; los marcos 4 a 7 estan en la fila de abajo de la hoja (Y = 0x70)
L_6432:
	ld bc,03030h		;6432
	ld a,001h		;6435
	call 05024h		;6437   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	pop hl			;643a
	pop bc			;643b
	djnz L_6413		;643c
	ret			;643e
L_643F:
	ld b,008h		;643f   ; rellena de 0xBB ocho cuadros de 52 x 52 puntos y escribe 8 x 8 tiles dentro
	ld hl,0646fh		;6441
L_6444:
	push bc			;6444   ; un cuadro de 52 x 52: la posicion menos 8 y rellena de 0xBB desde +6
	ld a,(hl)			;6445
	sub 008h		;6446
	ld d,a			;6448
	inc hl			;6449
	ld a,(hl)			;644a
	sub 008h		;644b
	ld e,a			;644d
	inc hl			;644e
	push hl			;644f
	push de			;6450
	ld a,d			;6451
	add a,006h		;6452
	ld h,a			;6454
	ld a,e			;6455
	add a,006h		;6456
	ld l,a			;6458
	ld bc,03434h		;6459
	ld a,0bbh		;645c   ; color 0xBB de relleno
	ld d,000h		;645e
	call 04fe5h		;6460   ; rellena y dibuja encima la ventana de 8 x 8 tiles
	pop de			;6463
	ld hl,00808h		;6464
	call 09d1ch		;6467   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	pop hl			;646a
	pop bc			;646b
	djnz L_6444		;646c
	ret			;646e

; ----------------------------------------------------------------------
; DATOS resto_646F: lo apuntan con el banco puesto p01:6410 (0x646F), p01:6441
;   (0x646F), p00:5EC5 (0x6478), p00:5EE0 (0x6478), p00:5F05 (0x6478),
;   p00:5F20 (0x6478); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6410, p01:6441, p00:5EC5, p00:5EE0, p00:5F05,
;   p00:5F20 (21 bytes)
;   0x646f..0x6484  (21 bytes)
DATA_resto_646F:
	defb 008h,008h,068h,008h,0c8h,008h,008h,052h,0c8h,052h,008h,09ch,068h,09ch,0c8h,09ch	; 646f  ..h....R.R..h...
	defb 0ach,086h,0adh,05bh,0ffh	; 647f

; ======================================================================
; CODIGO 0x6484..0x662b  (423 bytes)
; ======================================================================


L_6484:
	ld a,(0c007h)		;6484   ; teclas del cuadro de ajustes: ESPACIO sale (0xC02A = 1); las flechas cambian el registro de color 0xC012/0xC013
	and 010h		;6487
	jr nz,L_64A0		;6489
	ld a,(0c003h)		;648b   ; lee el contador de cuadros
	rra			;648e
	ret c			;648f
	ld a,(0c008h)		;6490   ; lee el estado anterior de las teclas del mando
	rra			;6493
	jr c,L_64A6		;6494
	rra			;6496
	jr c,L_64CA		;6497
	rra			;6499
	jr c,L_64D7		;649a
	rra			;649c
	jr c,L_64DD		;649d
	ret			;649f
L_64A0:
	ld a,001h		;64a0
	ld (0c02ah),a		;64a2   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;64a5
L_64A6:
	ld hl,0c012h		;64a6   ; apunta a el ajuste horizontal de la imagen (registro 18 del VDP)
L_64A9:
	ld a,(hl)			;64a9   ; sube el registro de ajuste hasta 7 (maximo) con 4 bits
	cp 007h		;64aa
	ret z			;64ac
	inc a			;64ad
	and 00fh		;64ae
	ld (hl),a			;64b0
L_64B1:
	ld hl,0c012h		;64b1   ; apunta a el ajuste horizontal de la imagen (registro 18 del VDP)
	ld a,(hl)			;64b4
	rlca			;64b5
	rlca			;64b6
	rlca			;64b7
	rlca			;64b8
	inc hl			;64b9
	or (hl)			;64ba
	ld b,a			;64bb
ajusta_pantalla:		; escribe el registro 18 del VDP con el ajuste de la pantalla
	ld a,(00007h)		;64bc   ; escribe el registro 18 del VDP (ajuste de la imagen) con 0xC012 y 0xC013
	inc a			;64bf
	ld c,a			;64c0
	di			;64c1
	out (c),b		;64c2
	ld a,092h		;64c4
	ei			;64c6
	out (c),a		;64c7
	ret			;64c9
L_64CA:
	ld hl,0c012h		;64ca   ; apunta a el ajuste horizontal de la imagen (registro 18 del VDP)
L_64CD:
	ld a,(hl)			;64cd   ; baja el registro de ajuste hasta 8 (minimo, que es -8 en 4 bits)
	cp 008h		;64ce
	ret z			;64d0
	dec a			;64d1
	and 00fh		;64d2
	ld (hl),a			;64d4
	jr L_64B1		;64d5
L_64D7:
	ld hl,0c013h		;64d7   ; apunta a el ajuste vertical de la imagen (registro 18 del VDP)
	jp L_64A9		;64da
L_64DD:
	ld hl,0c013h		;64dd   ; apunta a el ajuste vertical de la imagen (registro 18 del VDP)
	jp L_64CD		;64e0
L_64E3:
	ld a,(0c0e3h)		;64e3   ; mira si hay algun jugador con mas de 2 de 0xC0B3: devuelve acarreo
	and a			;64e6
	jr nz,L_64EF		;64e7
	ld a,(0c0b2h)		;64e9   ; lee el viento de la ronda (0 este)
	and a			;64ec
	jr z,L_6505		;64ed
L_64EF:
	ld a,(0c0b3h)		;64ef   ; lee el numero de la mano dentro del viento (0-3)
	cp 003h		;64f2
	jr nz,L_6505		;64f4
	ld hl,0c0a2h		;64f6
	ld b,004h		;64f9
L_64FB:
	ld a,(hl)			;64fb   ; recorre los cuatro marcadores (de 3 en 3 bytes): acarreo si alguno pasa de 2
	cp 003h		;64fc
	jr nc,L_6507		;64fe
	inc hl			;6500
	inc hl			;6501
	inc hl			;6502
	djnz L_64FB		;6503
L_6505:
	or a			;6505
	ret			;6506
L_6507:
	scf			;6507
	ret			;6508
L_6509:
	ld a,(0c207h)		;6509   ; por cada jugador (0xC207 o los cuatro) con los bits 3-4 puestos en +0x60 de su mano, hace la jugada de la IA (0x8CF5 y 0x8B8C)
	push af			;650c
	ld hl,0c207h		;650d   ; apunta a el jugador al que le toca (0 = el humano)
	ld a,(0c028h)		;6510   ; lee la regla del ron doble (ダブルロン; de serie si)
	and a			;6513
	ld a,000h		;6514
	ld b,004h		;6516
	jr nz,L_6528		;6518
	ld a,(0c0b1h)		;651a   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;651d
	ld a,(0c207h)		;651e   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_6526		;6521
	ld a,(0c20dh)		;6523   ; lee el jugador que responde a la ficha tirada
L_6526:
	ld b,001h		;6526
L_6528:
	ld (hl),a			;6528
L_6529:
	ld de,0d060h		;6529
	ld a,(hl)			;652c
	add a,a			;652d
	add a,a			;652e
	add a,d			;652f
	ld d,a			;6530
	ld a,(de)			;6531
	and 018h		;6532
	jr z,L_6551		;6534
	push hl			;6536
	push bc			;6537
	ld a,001h		;6538
	ld (0c214h),a		;653a   ; guarda 1 si las manos se ven boca arriba
	call 08cf5h		;653d   ; dibuja_mano: dibuja las 13 fichas de la mano del jugador 0xC207
	ld a,001h		;6540
	ld (0c0e0h),a		;6542
	ld a,(0c209h)		;6545   ; lee la ficha robada o tirada
	call 08b8ch		;6548   ; dibuja_ficha_2: dibuja la ficha A del jugador 0xC207 (sin el cambio por el reverso)
	xor a			;654b
	ld (0c0e0h),a		;654c
	pop bc			;654f
	pop hl			;6550
L_6551:
	inc (hl)			;6551
	djnz L_6529		;6552
	pop af			;6554
	ld (0c207h),a		;6555   ; guarda el jugador al que le toca (0 = el humano)
	ret			;6558
L_6559:
	ld a,(0cd0ch)		;6559   ; cuenta cuantos jugadores tienen los bits 3-4 puestos (0xC0BA) y guarda quienes son (0xC0BB..)
	and a			;655c
	jr nz,L_6599		;655d
	ld a,(0cd02h)		;655f
	and a			;6562
	jr nz,L_6599		;6563
	ld a,(0c0b1h)		;6565   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;6568
	jr z,L_6599		;6569
	ld a,(0c0b7h)		;656b   ; lee el jugador que reparte (0-3)
	ld c,a			;656e
	ld hl,0c0bbh		;656f
	ld b,004h		;6572
	exx			;6574
	ld c,000h		;6575
	exx			;6577
L_6578:
	ld de,0d060h		;6578   ; mira si el jugador C tiene los bits 3-4 de +0x60 (puede decir ron)
	ld a,c			;657b
	add a,a			;657c
	add a,a			;657d
	add a,d			;657e
	ld d,a			;657f
	ld a,(de)			;6580
	and 018h		;6581
	jr z,L_658A		;6583
	exx			;6585   ; cuenta los que pueden en C'
	inc c			;6586
	exx			;6587
	ld (hl),c			;6588
	inc hl			;6589
L_658A:
	ld a,c			;658a
	inc a			;658b
	and 003h		;658c
	ld c,a			;658e
	djnz L_6578		;658f
	exx			;6591
	ld a,c			;6592
	exx			;6593
	ld (0c0bah),a		;6594   ; guarda cuantos jugadores responden a la ficha tirada
	jr L_65AD		;6597
L_6599:
	ld a,001h		;6599
	ld (0c0bah),a		;659b   ; guarda cuantos jugadores responden a la ficha tirada
	ld a,(0c207h)		;659e   ; lee el jugador al que le toca (0 = el humano)
	ld (0c0bbh),a		;65a1
	add a,a			;65a4
	add a,a			;65a5
	ld hl,0d060h		;65a6
	add a,h			;65a9
	ld h,a			;65aa
	set 4,(hl)		;65ab
L_65AD:
	xor a			;65ad
	ld (0c0c5h),a		;65ae
	ret			;65b1
azar:		; numero al azar en A
	ld a,(0c1c0h)		;65b2   ; numero al azar: mezcla 0xC1C0 con el registro R del Z80 y el contador de cuadros
	add a,a			;65b5
	ld h,a			;65b6
	ld a,r		;65b7
	add a,h			;65b9
	ld h,a			;65ba
	ld a,(0c003h)		;65bb   ; lee el contador de cuadros
	srl a		;65be
	add a,h			;65c0
	adc a,a			;65c1
	ld (0c1c0h),a		;65c2   ; guarda la semilla del azar
	ret			;65c5
dibuja_rivales:		; dibuja las tres fichas de los rivales
	ld hl,070d0h		;65c6   ; dibuja las tres fichas de los rivales
	ld de,0c850h		;65c9
	call L_65DE		;65cc   ; dibuja la caja de un rival: borra 52 x 52 con 0xBB y encima la ventana
	ld hl,0a0d0h		;65cf
	ld de,06808h		;65d2
	call L_65DE		;65d5   ; dibuja la caja de un rival: borra 52 x 52 con 0xBB y encima la ventana
	ld hl,0d0d0h		;65d8
	ld de,00850h		;65db
L_65DE:
	push hl			;65de   ; dibuja la caja de un rival: borra 52 x 52 con 0xBB y encima la ventana
	push de			;65df
	push de			;65e0
	dec d			;65e1
	dec d			;65e2
	dec e			;65e3
	dec e			;65e4
	ex de,hl			;65e5
	ld bc,03434h		;65e6
	ld d,000h		;65e9
	ld a,0bbh		;65eb
	call 04fe5h		;65ed   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	pop de			;65f0
	ld a,d			;65f1   ; ventana de 8 x 8 un poco mas arriba y a la izquierda
	sub 008h		;65f2
	ld d,a			;65f4
	ld a,e			;65f5
	sub 008h		;65f6
	ld e,a			;65f8
	ld hl,00808h		;65f9
	call 09d1ch		;65fc   ; ventana: dibuja una ventana con marco (H = ancho, L = alto, DE = esquina)
	pop de			;65ff
	pop hl			;6600
	call L_6623		;6601
	ret			;6604
borra_cuadros:		; borra los cuadros del fondo
	ld hl,0c048h		;6605   ; borra con 0 los cuadros 0x48/0x60 de las dos paginas
	call L_6614		;6608
	ld hl,06000h		;660b
	call L_6614		;660e
	ld hl,00048h		;6611
L_6614:
	ld bc,04040h		;6614
	ld d,000h		;6617
	xor a			;6619
	jp 04fe5h		;661a   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
dibuja_cara:		; dibuja la cara de 48 x 48 del personaje A
	ld hl,0662bh		;661d   ; dibuja un tile de 48 x 48 de la hoja de la tabla 0x662B (A = cual)
	call 04d07h		;6620   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
L_6623:
	ld bc,03030h		;6623
	ld a,028h		;6626
	jp 05151h		;6628   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)

; ----------------------------------------------------------------------
; DATOS resto_662B: lo apuntan con el banco puesto p01:661D (0x662B), p03:AEF7
;   (0x662B), p04:A9F5 (0x663B), p04:AA33 (0x6640), p04:AA48 (0x664E),
;   p03:B787 (0x665E); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:661D, p03:AEF7, p04:A9F5, p04:AA33, p04:AA48,
;   p03:B787 (404 bytes)
;   0x662b..0x67bf  (404 bytes)
DATA_resto_662B:
	defb 040h,000h,040h,030h,040h,060h,040h,090h,070h,000h,070h,030h,070h,060h,070h,090h	; 662b  @.@0@`@.p.p0p`p.
	defb 092h,000h,000h,072h,0ffh,046h,066h,046h,066h,04ah,066h,087h,000h,036h,0ffh,036h	; 663b  ...r.FfFfJf..6.6
	defb 000h,030h,0ffh,04ah,066h,058h,066h,05ch,066h,060h,066h,046h,066h,096h,000h,036h	; 664b  .0.JfXf\f`fFf..6
	defb 0ffh,084h,000h,036h,0ffh,00dh,084h,036h,0ffh,0d0h,066h,0d0h,066h,0d4h,066h,0d9h	; 665b  ...6...6..f.f.f.
	defb 066h,0ddh,066h,0e3h,066h,0e7h,066h,0ebh,066h,0efh,066h,0f4h,066h,0f9h,066h,0feh	; 666b  f.f.f.f.f.f.f.f.
	defb 066h,002h,067h,008h,067h,00ch,067h,010h,067h,014h,067h,019h,067h,01eh,067h,022h	; 667b  f.g.g.g.g.g.g.g"
	defb 067h,026h,067h,02ah,067h,02eh,067h,033h,067h,037h,067h,03bh,067h,03fh,067h,044h	; 668b  g&g*g.g3g7g.g?gD
	defb 067h,048h,067h,04ch,067h,054h,067h,054h,067h,058h,067h,05ch,067h,060h,067h,064h	; 669b  gHgLgTgTgXg\g`gd
	defb 067h,068h,067h,06ch,067h,070h,067h,074h,067h,079h,067h,07eh,067h,082h,067h,086h	; 66ab  ghglgpgtgyg~g.g.
	defb 067h,08ah,067h,08eh,067h,092h,067h,097h,067h,09ch,067h,0a2h,067h,0ach,067h,0b0h	; 66bb  g.g.g.g.g.g.g.g.
	defb 067h,0b7h,067h,0bbh,067h,03dh,000h,02bh,0ffh,03dh,02bh,00bh,06ah,0ffh,034h,000h	; 66cb  g.g.g=.+.=+.j.4.
	defb 03ch,0ffh,06ch,05dh,05ch,037h,03ch,0ffh,028h,019h,013h,0ffh,00bh,069h,052h,0ffh	; 66db  <.l]\7<.(....iR.
	defb 072h,000h,031h,0ffh,070h,059h,04ch,04dh,0ffh,04bh,064h,071h,079h,0ffh,04ah,064h	; 66eb  r.1.pYLM.Kdqy.Jd
	defb 071h,050h,0ffh,07fh,000h,024h,0ffh,074h,075h,03eh,03dh,02bh,0ffh,011h,060h,01dh	; 66fb  qP...$.tu>=+..`.
	defb 0ffh,060h,073h,03ch,0ffh,00ch,069h,052h,0ffh,00bh,04eh,063h,030h,0ffh,00dh,05ah	; 670b  .`s<..iR..Nc0..Z
	defb 068h,057h,0ffh,05eh,061h,019h,0ffh,00dh,049h,035h,0ffh,00dh,024h,01dh,0ffh,00dh	; 671b  hW.^a...I5..$...
	defb 03ah,035h,0ffh,00dh,05ah,068h,035h,0ffh,058h,00dh,051h,0ffh,053h,06fh,067h,0ffh	; 672b  :5..Zh5.X.Q.Sog.
	defb 053h,00bh,05ah,0ffh,056h,05eh,061h,019h,0ffh,05ch,00bh,05ah,0ffh,08ah,000h,08bh	; 673b  S.Z.V^a..\.Z....
	defb 0ffh,074h,075h,03eh,03dh,02bh,00bh,06ah,0ffh,03dh,000h,02bh,0ffh,00eh,049h,035h	; 674b  .tu>=+.j.=.+..I5
	defb 0ffh,00eh,024h,01dh,0ffh,029h,00dh,051h,0ffh,058h,00eh,04fh,0ffh,07bh,00bh,05ah	; 675b  ..$..).Q.X.O.{.Z
	defb 0ffh,05ch,06fh,067h,0ffh,06eh,00bh,05ah,0ffh,013h,03ah,06bh,066h,0ffh,054h,055h	; 676b  .\og.n.Z..:kf.TU
	defb 06dh,05fh,0ffh,065h,000h,03ch,0ffh,062h,000h,03ch,0ffh,021h,000h,03ch,0ffh,00eh	; 677b  m_.e.<.b.<.!.<..
	defb 03ah,035h,0ffh,029h,07ch,03bh,0ffh,038h,045h,036h,030h,0ffh,014h,00dh,032h,02dh	; 678b  :5.)|..8E60...2-
	defb 0ffh,00eh,049h,035h,081h,083h,0ffh,054h,055h,06dh,05fh,001h,003h,086h,080h,093h	; 679b  ..I5...TUm_.....
	defb 0ffh,029h,00eh,04fh,0ffh,056h,05bh,013h,03ah,06bh,066h,0ffh,012h,03ah,027h,0ffh	; 67ab  .).O.V[.:kf..:'.
	defb 0bch,000h,03ch,0ffh	; 67bb

; ======================================================================
; CODIGO 0x67bf..0x6af7  (824 bytes)
; ======================================================================


analiza_otros:		; analiza las manos de los otros tres jugadores
	ld bc,00400h		;67bf   ; recorre los cuatro jugadores (0xD000 + 0x400 x n) y por cada uno que no es el actual prepara su analisis (0x67E0)
	ld hl,0d000h		;67c2
L_67C5:
	push bc			;67c5
	push hl			;67c6
	push hl			;67c7
	ld de,00060h		;67c8
	add hl,de			;67cb
	ld (hl),000h		;67cc
	pop hl			;67ce
	ld a,(0c207h)		;67cf   ; lee el jugador al que le toca (0 = el humano)
	cp c			;67d2
	call nz,L_67E0		;67d3   ; analiza la mano de otro jugador: punteros a sus campos en 0xCD80-0xCD88
	pop hl			;67d6
	ld bc,00400h		;67d7
	add hl,bc			;67da
	pop bc			;67db
	inc c			;67dc
	djnz L_67C5		;67dd
	ret			;67df
L_67E0:
	ld (0cd80h),hl		;67e0   ; analiza la mano de otro jugador: punteros a sus campos en 0xCD80-0xCD88
	push hl			;67e3
	ld de,00060h		;67e4
	add hl,de			;67e7
	ld (0cd82h),hl		;67e8
	ld (hl),000h		;67eb
	inc hl			;67ed
	ld (0cd84h),hl		;67ee
	ld a,006h		;67f1
	add a,l			;67f3
	ld l,a			;67f4
	ld (0cd86h),hl		;67f5
	ld a,006h		;67f8
	add a,l			;67fa
	ld l,a			;67fb
	ld (0cd88h),hl		;67fc
	pop hl			;67ff
	ld de,00034h		;6800
	add hl,de			;6803
	ld a,(hl)			;6804
	and a			;6805
	jr nz,L_6822		;6806
	ld a,(0cd0dh)		;6808   ; lee 1 si se gana con la ficha del kan de otro
	and a			;680b
	jr nz,L_6822		;680c
	call L_685E		;680e   ; compara las fichas robadas (0xC1C1 + 0xC210) con 0x79: Z/C si se acaba el muro
	jr nc,L_6822		;6811
	ld a,c			;6813
	dec a			;6814
	and 003h		;6815
	ld c,a			;6817
	ld a,(0c207h)		;6818   ; lee el jugador al que le toca (0 = el humano)
	cp c			;681b
	call z,L_6869		;681c   ; calcula las secuencias (chi) que se pueden hacer con la ficha de 0xC209: tabla 0x6C27, 6 bytes por numero (tres pares)
	call L_6826		;681f   ; busca en la mano (13 fichas) cuantas son iguales a la ficha de 0xC209 (maximo de tres)
L_6822:
	call L_68E0		;6822   ; mira si puede ganar o hacer pon con la mano apuntada por (0xCD80)
	ret			;6825
L_6826:
	ld hl,(0cd80h)		;6826   ; busca en la mano (13 fichas) cuantas son iguales a la ficha de 0xC209 (maximo de tres)
	ld a,(0c209h)		;6829   ; lee la ficha robada o tirada
	ld c,a			;682c
	ld b,00dh		;682d
	ld d,000h		;682f
L_6831:
	ld a,(hl)			;6831   ; busca en la mano las fichas iguales a la de 0xC209 que no son de grupo (bits 6 y 7 limpios)
	cp c			;6832
	jr nz,L_6840		;6833
	ld a,c			;6835
	and 0c0h		;6836
	jr nz,L_6840		;6838
	ld a,d			;683a   ; con la primera guarda su posicion (0x6852)
	and a			;683b
	call z,L_6852		;683c   ; guarda en 0xCD88 la posicion (13 - B) de la primera
	inc d			;683f
L_6840:
	inc l			;6840   ; al acabar mira cuantas son: 1 = pareja posible, 2 = triplete (+0x60 bits 0 y 2)
	djnz L_6831		;6841
	ld hl,(0cd82h)		;6843
	dec d			;6846
	dec d			;6847
	call z,L_684F		;6848
	dec d			;684b
	ret nz			;684c
	set 2,(hl)		;684d
L_684F:
	set 0,(hl)		;684f
	ret			;6851
L_6852:
	ld a,b			;6852   ; guarda en 0xCD88 la posicion (13 - B) de la primera
	sub 00dh		;6853
	neg		;6855
	push hl			;6857
	ld hl,(0cd88h)		;6858
	ld (hl),a			;685b
	pop hl			;685c
	ret			;685d
L_685E:
	ld a,(0c1c1h)		;685e   ; compara las fichas robadas (0xC1C1 + 0xC210) con 0x79: Z/C si se acaba el muro
	ld b,a			;6861
	ld a,(0c210h)		;6862   ; lee las fichas sacadas del final del muro (por kan)
	add a,b			;6865
	cp 079h		;6866
	ret			;6868
L_6869:
	ld a,(0c209h)		;6869   ; calcula las secuencias (chi) que se pueden hacer con la ficha de 0xC209: tabla 0x6C27, 6 bytes por numero (tres pares)
	ld c,a			;686c
	and 030h		;686d
	xor 030h		;686f
	ret z			;6871
	ld a,c			;6872
	and 00fh		;6873
	dec a			;6875
	add a,a			;6876
	ld b,a			;6877
	add a,a			;6878
	add a,b			;6879
	ld hl,06c27h		;687a
	call 0405ch		;687d   ; suma_a_hl: HL = HL + A
	ld de,(0cd84h)		;6880
	ld b,006h		;6884
	ld a,(0c209h)		;6886   ; lee la ficha robada o tirada
	and 0f0h		;6889
	ld c,a			;688b
L_688C:
	ld a,(hl)			;688c   ; copia la escalera (seis bytes) con los bits del palo
	and a			;688d
	or c			;688e
	ld (de),a			;688f
	inc hl			;6890
	inc de			;6891
	djnz L_688C		;6892
	ld hl,(0cd86h)		;6894
	ld d,h			;6897
	ld e,l			;6898
	inc de			;6899
	ld bc,00005h		;689a
	ld (hl),0ffh		;689d
	ldir		;689f   ; rellena con 0xFF los cinco bytes de la lista de posiciones
	exx			;68a1
	ld hl,(0cd86h)		;68a2
	exx			;68a5
	ld de,(0cd84h)		;68a6   ; prepara el recorrido de las tres escaleras posibles
	ld b,003h		;68aa
L_68AC:
	ld c,00dh		;68ac
	ld hl,(0cd80h)		;68ae
L_68B1:
	ld a,(de)			;68b1   ; busca cada ficha de la escalera en la mano
	cp (hl)			;68b2
	jr z,L_68C9		;68b3
	inc l			;68b5
	dec c			;68b6
	jr nz,L_68B1		;68b7
	ld a,e			;68b9   ; si no esta, y la escalera es la de la ficha (par), anota hueco
	rra			;68ba
	jr nc,L_68C0		;68bb
	inc e			;68bd
	jr L_68C5		;68be
L_68C0:
	exx			;68c0
	dec hl			;68c1
	ld (hl),0ffh		;68c2
	exx			;68c4
L_68C5:
	inc e			;68c5
	djnz L_68AC		;68c6
	ret			;68c8
L_68C9:
	ld a,c			;68c9   ; si esta, guarda su posicion
	sub 00dh		;68ca
	neg		;68cc
	exx			;68ce
	ld (hl),a			;68cf
	inc hl			;68d0
	exx			;68d1
	ld a,e			;68d2   ; si es la segunda de la pareja pone el bit 1 de +0x60 (chi posible)
	rra			;68d3
	jr nc,L_68D9		;68d4
	inc b			;68d6
	jr L_68C5		;68d7
L_68D9:
	ld hl,(0cd82h)		;68d9
	set 1,(hl)		;68dc
	jr L_68C5		;68de
L_68E0:
	ld hl,(0cd80h)		;68e0   ; mira si puede ganar o hacer pon con la mano apuntada por (0xCD80)
	ld b,002h		;68e3
	call prueba_ganar		;68e5   ; prueba_ganar: prueba si la mano gana con la ficha de 0xC621; carry = gana
	ret nc			;68e8
	ld hl,(0cd82h)		;68e9
	set 3,(hl)		;68ec
	ret			;68ee
prueba_ganar_robo:		; prueba si la mano gana por robo (B = 1)
	ld b,001h		;68ef
	jr L_68F5		;68f1
L_68F3:
	ld b,002h		;68f3
L_68F5:
	ld hl,(0c0deh)		;68f5   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
prueba_ganar:		; prueba si la mano gana con la ficha de 0xC621; carry = gana
	ld a,b			;68f8   ; prueba si la mano de HL gana con la ficha de 0xC621..0xC62E (B = 1 si es por robo, 2 si es por descarte); pone el acarreo si gana
	ld (0c0c0h),a		;68f9
	ld (0cd5ch),hl		;68fc   ; guarda la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld a,(0c20dh)		;68ff   ; lee el jugador que responde a la ficha tirada
	push af			;6902
	ld a,h			;6903
	rrca			;6904
	rrca			;6905
	and 003h		;6906
	ld (0c20dh),a		;6908   ; guarda el jugador que responde a la ficha tirada
	ld a,(0c0b1h)		;690b   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	push af			;690e
	ld a,b			;690f
	ld (0c0b1h),a		;6910   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	call prepara_analisis		;6913   ; prepara_analisis: pone a cero la lista de yaku y copia la mano a 0xC621
	call descompone_mano		;6916   ; descompone_mano: descompone la mano en grupos (escaleras, tripletes, pareja)
	ld a,(0cd40h)		;6919   ; lee la pareja de la mano
	or a			;691c
	jr nz,L_6936		;691d
	call mira_siete_parejas		;691f   ; mira_siete_parejas: mira si la mano son siete parejas
	jr z,L_693F		;6922
	pop af			;6924
	ld (0c0b1h),a		;6925   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	pop af			;6928
	ld (0c20dh),a		;6929   ; guarda el jugador que responde a la ficha tirada
	call cuenta_iguales		;692c   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call mira_trece_huerfanos		;692f   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	jr z,L_696F		;6932
	or a			;6934
	ret			;6935
L_6936:
	call copia_grupos		;6936   ; copia_grupos: copia los grupos de 0xCD48 a 0xCD95
	call cuenta_iguales		;6939   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call L_6CED		;693c   ; recorre las 32 comprobaciones de la tabla 0x716B (un yaku cada una, por el despachador)
L_693F:
	pop af			;693f
	ld (0c0b1h),a		;6940   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	pop af			;6943
	ld (0c20dh),a		;6944   ; guarda el jugador que responde a la ficha tirada
L_6947:
	ld hl,0c2e0h		;6947   ; suma los puntos (han) que salen de la tabla 0xC2E0 (pares codigo, valor): el 0x1C no cuenta
	ld c,000h		;694a
L_694C:
	ld a,(hl)			;694c   ; suma los han de la lista de yaku sin contar el 0x1C (dora)
	ld b,a			;694d
	and a			;694e
	jr z,L_695C		;694f
	inc hl			;6951
	cp 01ch		;6952
	jr z,L_6959		;6954
	ld a,c			;6956
	add a,(hl)			;6957
	ld c,a			;6958
L_6959:
	inc hl			;6959
	jr L_694C		;695a
L_695C:
	ld a,c			;695c   ; con los han en C: con cero no gana; con uno gana si la opcion 0xC029 lo permite y quedan honba
	or a			;695d
	ret z			;695e
	cp 002h		;695f
	jr nc,L_696F		;6961
	ld a,(0c029h)		;6963   ; lee la regla de dos han como minimo (二翻縛り; de serie si)
	and a			;6966
	jr z,L_696F		;6967
	ld a,(0c0b5h)		;6969   ; lee las barras de honba (BCD)
	cp 005h		;696c
	ret nc			;696e
L_696F:
	ld a,(0c0c0h)		;696f   ; el acarreo dice si hay alguna espera: la lista esta en +0x0F de la mano (cuenta) y +0x10 (fichas)
	dec a			;6972
	scf			;6973
	ret z			;6974
	ld hl,(0cd5ch)		;6975   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,0000fh		;6978
	add hl,de			;697b
	ld a,(hl)			;697c
	and a			;697d
	scf			;697e
	ret z			;697f
	ld b,a			;6980
	inc hl			;6981
L_6982:
	ld a,(hl)			;6982
	push hl			;6983
	push bc			;6984
	ld hl,(0cd5ch)		;6985   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,0c621h		;6988   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;698b
	ldir		;698e
	ld (de),a			;6990
	ld hl,0c621h		;6991   ; apunta a la mano de trabajo de 14 fichas ordenada
	call ordena_mano		;6994   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
	call descompone_mano		;6997   ; descompone_mano: descompone la mano en grupos (escaleras, tripletes, pareja)
	ld a,(0cd40h)		;699a   ; lee la pareja de la mano
	or a			;699d
	jr nz,L_69B4		;699e
	call mira_siete_parejas		;69a0   ; mira_siete_parejas: mira si la mano son siete parejas
	jr z,L_69B4		;69a3
	call cuenta_iguales		;69a5   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call mira_trece_huerfanos		;69a8   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	jr z,L_69B4		;69ab
	pop bc			;69ad
	pop hl			;69ae
	inc hl			;69af
	djnz L_6982		;69b0
	scf			;69b2
	ret			;69b3
L_69B4:
	pop bc			;69b4
	pop hl			;69b5
	or a			;69b6
	ret			;69b7
marca_si_gana:		; marca con el bit 4 de +0x60 si la mano gana
	call prueba_ganar_robo		;69b8   ; prueba una mano y marca con el bit 4 de +0x60 si gana
	push af			;69bb
	ld hl,(0c0deh)		;69bc   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00060h		;69bf
	add hl,de			;69c2
	pop af			;69c3
	jr c,L_69D0		;69c4
	push hl			;69c6
	call L_70DD		;69c7   ; pone a cero 0xCD02 y 0xCD00, y mira 0xC022
	pop hl			;69ca
	jr c,L_69D0		;69cb
	res 4,(hl)		;69cd
	ret			;69cf
L_69D0:
	set 4,(hl)		;69d0
	ret			;69d2
quedan_pocas:		; carry si quedan menos de 4 fichas muertas
	ld a,(0c1c1h)		;69d3   ; si quedan menos de 4 fichas en el muro (0xC1C1 + 0xC210 > 0x75) no hay mas jugada: acarreo
	ld b,a			;69d6
	ld a,(0c210h)		;69d7   ; lee las fichas sacadas del final del muro (por kan)
	add a,b			;69da
	ld b,a			;69db
	ld a,079h		;69dc
	sub b			;69de
	cp 004h		;69df
	ccf			;69e1
	ret nc			;69e2
	ld hl,(0c0deh)		;69e3   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00034h		;69e6
	add hl,de			;69e9
	ld a,(hl)			;69ea
	and a			;69eb
	ret nz			;69ec
	ld hl,(0c0deh)		;69ed   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00040h		;69f0
	add hl,de			;69f3
	ld a,(hl)			;69f4
	and a			;69f5
	ret nz			;69f6
	ld a,002h		;69f7
	ld (0c0c0h),a		;69f9
	call prueba_todos_los_yaku		;69fc   ; prueba_todos_los_yaku: prueba los yaku de la lista 0x6AF7
	push af			;69ff
	ld hl,(0c0deh)		;6a00   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00060h		;6a03
	add hl,de			;6a06
	pop af			;6a07
	jr c,L_6A0D		;6a08
	res 5,(hl)		;6a0a
	ret			;6a0c
L_6A0D:
	set 5,(hl)		;6a0d
	ret			;6a0f
prueba_todos_los_yaku:		; prueba los yaku de la lista 0x6AF7
	ld hl,06af7h		;6a10   ; prueba cada yaku de la lista 0x6AF7 (un byte por yaku, 0 acaba) sobre la mano de 0xC621
L_6A13:
	ld a,(hl)			;6a13
	or a			;6a14
	ret z			;6a15
	inc hl			;6a16
	ld (0c0c1h),a		;6a17
	push hl			;6a1a
	call L_6A81		;6a1b   ; prepara 0xC621: copia la mano de 13 fichas y la ficha de 0xC209 en la posicion que toque
	pop hl			;6a1e
	ld a,(0cd40h)		;6a1f   ; lee la pareja de la mano
	or a			;6a22
	jr nz,L_6A42		;6a23
	push hl			;6a25
	call mira_siete_parejas		;6a26   ; mira_siete_parejas: mira si la mano son siete parejas
	pop hl			;6a29
	jr z,L_6A7F		;6a2a
	push hl			;6a2c
	call cuenta_iguales		;6a2d   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call mira_trece_huerfanos		;6a30   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	pop hl			;6a33
	jr z,L_6A7F		;6a34
L_6A36:
	ld b,020h		;6a36
	ld de,0c2e0h		;6a38   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	xor a			;6a3b
L_6A3C:
	ld (de),a			;6a3c
	inc de			;6a3d
	djnz L_6A3C		;6a3e
	jr L_6A13		;6a40
L_6A42:
	push hl			;6a42
	ld a,(0c20dh)		;6a43   ; lee el jugador que responde a la ficha tirada
	push af			;6a46
	ld a,(0cd5dh)		;6a47
	rrca			;6a4a
	rrca			;6a4b
	and 003h		;6a4c
	ld (0c20dh),a		;6a4e   ; guarda el jugador que responde a la ficha tirada
	ld hl,(0c0deh)		;6a51   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00034h		;6a54
	add hl,de			;6a57
	ld a,(hl)			;6a58
	push hl			;6a59
	push af			;6a5a
	ld (hl),001h		;6a5b
	call copia_grupos		;6a5d   ; copia_grupos: copia los grupos de 0xCD48 a 0xCD95
	call cuenta_iguales		;6a60   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call L_6CED		;6a63   ; recorre las 32 comprobaciones de la tabla 0x716B (un yaku cada una, por el despachador)
	pop af			;6a66
	pop hl			;6a67
	ld (hl),a			;6a68
	pop af			;6a69
	ld (0c20dh),a		;6a6a   ; guarda el jugador que responde a la ficha tirada
	call L_6AC2		;6a6d   ; suma los han de 0xC2E0 salvo los de codigo 0x1C, 4 y 2; con acarreo si no hay ninguno que valga
	pop hl			;6a70
	jp nc,L_6A36		;6a71
	ld a,(0c0c1h)		;6a74
	push hl			;6a77
	call L_6B1A		;6a78   ; prueba cada espera de la lista de +0x0F (cada ficha que completa la mano)
	pop hl			;6a7b
	jp nc,L_6A36		;6a7c
L_6A7F:
	scf			;6a7f
	ret			;6a80
L_6A81:
	ld hl,(0c0deh)		;6a81   ; prepara 0xC621: copia la mano de 13 fichas y la ficha de 0xC209 en la posicion que toque
	ld (0cd5ch),hl		;6a84   ; guarda la direccion de la mano que se analiza y el byte siguiente (16 bits)
L_6A87:
	push af			;6a87
	ld de,0c621h		;6a88   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;6a8b
	ldir		;6a8e
	ld a,(0c209h)		;6a90   ; lee la ficha robada o tirada
	ld (de),a			;6a93
	ld a,(0c20ah)		;6a94   ; lee la posicion de la ficha en la mano
	ld b,a			;6a97
	ld hl,(0c0deh)		;6a98   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;6a9b
	add hl,de			;6a9e
	ld a,(hl)			;6a9f
	and a			;6aa0
	jr z,L_6AAF		;6aa1
	ld c,a			;6aa3
	add a,a			;6aa4
	add a,c			;6aa5
	ld c,a			;6aa6
	ld a,00dh		;6aa7
	sub c			;6aa9
	cp b			;6aaa
	jr nz,L_6AAF		;6aab
	ld b,00dh		;6aad
L_6AAF:
	ld a,b			;6aaf
	ld hl,0c621h		;6ab0   ; apunta a la mano de trabajo de 14 fichas ordenada
	call 0405ch		;6ab3   ; suma_a_hl: HL = HL + A
	pop af			;6ab6
	ld (hl),a			;6ab7
	ld hl,0c621h		;6ab8   ; apunta a la mano de trabajo de 14 fichas ordenada
	call ordena_mano		;6abb   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
	call descompone_mano		;6abe   ; descompone_mano: descompone la mano en grupos (escaleras, tripletes, pareja)
	ret			;6ac1
L_6AC2:
	ld hl,0c2e0h		;6ac2   ; suma los han de 0xC2E0 salvo los de codigo 0x1C, 4 y 2; con acarreo si no hay ninguno que valga
	ld c,000h		;6ac5
L_6AC7:
	ld a,(hl)			;6ac7   ; igual que 0x694C pero para la lista de 0x20 pares: cuenta menos los codigos 0x1C, 4 y 2
	cp 020h		;6ac8
	jr nc,L_6AF5		;6aca
	inc hl			;6acc   ; avanza al valor del yaku
	and a			;6acd
	jr z,L_6AE2		;6ace
	cp 01ch		;6ad0   ; salta los codigos 0x1C (dora), 4 (tsumo) y 2 (ippatsu), que no cuentan para saber si hay yaku
	jr z,L_6ADF		;6ad2
	cp 004h		;6ad4
	jr z,L_6ADF		;6ad6
	cp 002h		;6ad8
	jr z,L_6ADF		;6ada
	ld a,c			;6adc   ; suma el valor del yaku a C
	add a,(hl)			;6add
	ld c,a			;6ade
L_6ADF:
	inc hl			;6adf
	jr L_6AC7		;6ae0
L_6AE2:
	ld a,c			;6ae2   ; mismo control: sin han no vale
	or a			;6ae3
	ret z			;6ae4
	cp 002h		;6ae5
	jr nc,L_6AF5		;6ae7
	ld a,(0c029h)		;6ae9   ; lee la regla de dos han como minimo (二翻縛り; de serie si)
	and a			;6aec
	jr z,L_6AF5		;6aed
	ld a,(0c0b5h)		;6aef   ; lee las barras de honba (BCD)
	cp 005h		;6af2
	ret nc			;6af4
L_6AF5:
	scf			;6af5
	ret			;6af6

; ----------------------------------------------------------------------
; DATOS resto_6AF7: lo apuntan con el banco puesto p01:6A10 (0x6AF7), p01:6B8E
;   (0x6AF7); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6A10, p01:6B8E (35 bytes)
;   0x6af7..0x6b1a  (35 bytes)
DATA_resto_6AF7:
	defb 001h,002h,003h,004h,005h,006h,007h,008h,009h,011h,012h,013h,014h,015h,016h,017h	; 6af7  ................
	defb 018h,019h,021h,022h,023h,024h,025h,026h,027h,028h,029h,031h,032h,033h,034h,035h	; 6b07  ..!"#$%&'()12345
	defb 036h,037h,000h	; 6b17

; ======================================================================
; CODIGO 0x6b1a..0x6c27  (269 bytes)
; ======================================================================


L_6B1A:
	ld hl,(0cd5ch)		;6b1a   ; prueba cada espera de la lista de +0x0F (cada ficha que completa la mano)
	ld de,0000fh		;6b1d
	add hl,de			;6b20
	ld a,(hl)			;6b21
	and a			;6b22
	scf			;6b23
	ret z			;6b24
	ld b,a			;6b25
	inc hl			;6b26
L_6B27:
	ld a,(hl)			;6b27
	push hl			;6b28
	push bc			;6b29
	ld hl,(0cd5ch)		;6b2a   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	call L_6A87		;6b2d
	ld a,(0cd40h)		;6b30   ; lee la pareja de la mano
	or a			;6b33
	jp nz,L_69B4		;6b34
	call mira_siete_parejas		;6b37   ; mira_siete_parejas: mira si la mano son siete parejas
	jp z,L_69B4		;6b3a
	call cuenta_iguales		;6b3d   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call mira_trece_huerfanos		;6b40   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	jp z,L_69B4		;6b43
	pop bc			;6b46
	pop hl			;6b47
	inc hl			;6b48
	djnz L_6B27		;6b49
	scf			;6b4b
	ret			;6b4c
L_6B4D:
	ld a,001h		;6b4d   ; calcula para los cuatro jugadores si estan en espera: guarda 1 o 0 en +0x81 de cada mano
	ld (0c0b1h),a		;6b4f   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ld (0c0c0h),a		;6b52
	ld a,(0c20dh)		;6b55   ; lee el jugador que responde a la ficha tirada
	push af			;6b58
	ld b,004h		;6b59
L_6B5B:
	push bc			;6b5b
	ld a,(0c20dh)		;6b5c   ; lee el jugador que responde a la ficha tirada
	add a,a			;6b5f
	add a,a			;6b60
	ld hl,0d000h		;6b61
	add a,h			;6b64
	ld h,a			;6b65
	ld (0cd5ch),hl		;6b66   ; guarda la direccion de la mano que se analiza y el byte siguiente (16 bits)
	call L_6B8E		;6b69   ; prueba la lista de yaku sobre la mano de 0xCD5C
	ld a,001h		;6b6c
	jr c,L_6B71		;6b6e
	xor a			;6b70
L_6B71:
	ld hl,(0cd5ch)		;6b71   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00081h		;6b74
	add hl,de			;6b77
	ld (hl),a			;6b78
	ld a,(0c20dh)		;6b79   ; lee el jugador que responde a la ficha tirada
	inc a			;6b7c
	and 003h		;6b7d
	ld (0c20dh),a		;6b7f   ; guarda el jugador que responde a la ficha tirada
	pop bc			;6b82
	djnz L_6B5B		;6b83
	pop af			;6b85
	ld (0c20dh),a		;6b86   ; guarda el jugador que responde a la ficha tirada
	xor a			;6b89
	ld (0c0b1h),a		;6b8a   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ret			;6b8d
L_6B8E:
	ld hl,06af7h		;6b8e   ; prueba la lista de yaku sobre la mano de 0xCD5C
L_6B91:
	ld a,(hl)			;6b91
	or a			;6b92
	ret z			;6b93
	inc hl			;6b94
	ld (0c0c1h),a		;6b95
	push hl			;6b98
	ld hl,(0cd5ch)		;6b99   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,0c621h		;6b9c   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;6b9f
	ldir		;6ba2
	ld (de),a			;6ba4
	ld hl,0c621h		;6ba5   ; apunta a la mano de trabajo de 14 fichas ordenada
	call ordena_mano		;6ba8   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
	xor a			;6bab
	ld (0c1c1h),a		;6bac   ; guarda cuantas fichas se han robado del muro
	ld hl,0c2e0h		;6baf   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	ld de,0c2e1h		;6bb2
	ld bc,0001fh		;6bb5
	ld (hl),000h		;6bb8
	ldir		;6bba
	call descompone_mano		;6bbc   ; descompone_mano: descompone la mano en grupos (escaleras, tripletes, pareja)
	pop hl			;6bbf
	ld a,(0cd40h)		;6bc0   ; lee la pareja de la mano
	or a			;6bc3
	jr nz,L_6BDB		;6bc4
	push hl			;6bc6
	call mira_siete_parejas		;6bc7   ; mira_siete_parejas: mira si la mano son siete parejas
	pop hl			;6bca
	jp z,L_6A7F		;6bcb
	push hl			;6bce
	call cuenta_iguales		;6bcf   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call mira_trece_huerfanos		;6bd2   ; mira_trece_huerfanos: compara 0xCD20 con la mano de los trece huerfanos
	pop hl			;6bd5
	jp z,L_6A7F		;6bd6
	jr L_6B91		;6bd9
L_6BDB:
	push hl			;6bdb
	call copia_grupos		;6bdc   ; copia_grupos: copia los grupos de 0xCD48 a 0xCD95
	call cuenta_iguales		;6bdf   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call L_6CED		;6be2   ; recorre las 32 comprobaciones de la tabla 0x716B (un yaku cada una, por el despachador)
	pop hl			;6be5
	push hl			;6be6
	call L_6947		;6be7   ; suma los puntos (han) que salen de la tabla 0xC2E0 (pares codigo, valor): el 0x1C no cuenta
	pop hl			;6bea
	ret c			;6beb
	jr L_6B91		;6bec
busca_jugador_con_bit:		; busca el primer jugador con un bit de +0x60
	ld c,008h		;6bee   ; busca el primer jugador desde 0xC0B7 que tenga el bit C de +0x60 (C = 1, 2, 4 u 8): el siguiente que lo cumple
L_6BF0:
	ld a,c			;6bf0
	ld (0cd9ah),a		;6bf1
	ld a,(0c0b7h)		;6bf4   ; lee el jugador que reparte (0-3)
	ld de,0c20dh		;6bf7   ; apunta a el jugador que responde a la ficha tirada
	ld (de),a			;6bfa
	ld b,004h		;6bfb
L_6BFD:
	ld hl,0d060h		;6bfd   ; busca desde el jugador de 0xC20D el primero que tiene el bit pedido en C de +0x60
	ld a,(de)			;6c00
	add a,a			;6c01
	add a,a			;6c02
	add a,h			;6c03
	ld h,a			;6c04
	ld a,(hl)			;6c05
	and c			;6c06
	jr nz,L_6C12		;6c07
	ld a,(de)			;6c09
	inc a			;6c0a
	and 003h		;6c0b
	ld (de),a			;6c0d
	djnz L_6BFD		;6c0e   ; el siguiente jugador, modulo 4
	xor a			;6c10
	ret			;6c11
L_6C12:
	or 001h		;6c12
	ret			;6c14
L_6C15:
	ld c,004h		;6c15
	call L_6BF0		;6c17
	ret			;6c1a
L_6C1B:
	ld c,001h		;6c1b
	call L_6BF0		;6c1d
	ret			;6c20
L_6C21:
	ld c,002h		;6c21
	call L_6BF0		;6c23
	ret			;6c26

; ----------------------------------------------------------------------
; DATOS resto_6C27: lo apuntan con el banco puesto p01:687A (0x6C27), p00:4BD5
;   (0x6C2B), p00:4BDE (0x6C33), p00:4C48 (0x6C34), p00:4BF1 (0x6C3D),
;   p01:6060 (0x6C50); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:687A, p00:4BD5, p00:4BDE, p00:4C48, p00:4BF1,
;   p01:6060 (54 bytes)
;   0x6c27..0x6c5d  (54 bytes)
DATA_resto_6C27:
	defb 002h,003h,000h,000h,000h,000h,001h,003h,003h,004h,000h,000h,001h,002h,002h,004h	; 6c27  ................
	defb 004h,005h,002h,003h,003h,005h,005h,006h,003h,004h,004h,006h,006h,007h,004h,005h	; 6c37  ................
	defb 005h,007h,007h,008h,005h,006h,006h,008h,008h,009h,006h,007h,007h,009h,000h,000h	; 6c47  ................
	defb 007h,008h,000h,000h,000h,000h	; 6c57

; ======================================================================
; CODIGO 0x6c5d..0x6eca  (621 bytes)
; ======================================================================


analiza_mano_actual:		; analiza la mano del jugador al que le toca
	call L_6CB1		;6c5d   ; PREPARA el analisis de la mano para el que le toca: pone la mano, llama a los analizadores (0x6CD5) y la voz
	ret c			;6c60
	ld a,(0cd02h)		;6c61
	and a			;6c64
	ret nz			;6c65
	ld a,(0cd9dh)		;6c66
	and a			;6c69
	jp nz,L_715C		;6c6a
	ld a,(0c20dh)		;6c6d   ; lee el jugador que responde a la ficha tirada
	add a,a			;6c70
	add a,a			;6c71
	ld hl,0d000h		;6c72
	add a,h			;6c75
	ld h,a			;6c76
	ld a,(0c0b1h)		;6c77   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;6c7a
	jr nz,L_6C80		;6c7b
	ld hl,(0c0deh)		;6c7d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
L_6C80:
	ld (0cd5ch),hl		;6c80   ; guarda la direccion de la mano que se analiza y el byte siguiente (16 bits)
	call analiza_yaku		;6c83   ; analiza_yaku: analiza los yaku de la mano (tablas 0x716B y 0x71A5)
	call 0424bh		;6c86   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	call 0a1a6h		;6c89   ; calcula_fu: calcula los fu de la mano
	call 04207h		;6c8c   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call L_6CA3		;6c8f
	ld a,(0c241h)		;6c92   ; lee los fu de la mano (BCD)
	sub 020h		;6c95
	srl a		;6c97
	srl a		;6c99
	srl a		;6c9b
	srl a		;6c9d
	ld (0c236h),a		;6c9f   ; guarda los fu de la mano (nivel)
	ret			;6ca2
L_6CA3:
	ld hl,0c241h		;6ca3   ; apunta a los fu de la mano (BCD)
	ld a,(hl)			;6ca6
	and 00fh		;6ca7
	ret z			;6ca9
	ld a,(hl)			;6caa
	and 0f0h		;6cab
	add a,010h		;6cad
	ld (hl),a			;6caf
	ret			;6cb0
L_6CB1:
	ld a,(0c0b1h)		;6cb1   ; el jugador humano esta en la partida (0xC0B1/0xC207/0xC20D = 0)? y mira si hay una orden fija (0xCDA0)
	dec a			;6cb4
	ld a,(0c207h)		;6cb5   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_6CBD		;6cb8
	ld a,(0c20dh)		;6cba   ; lee el jugador que responde a la ficha tirada
L_6CBD:
	or a			;6cbd
	ret nz			;6cbe
L_6CBF:
	ld a,(0cda0h)		;6cbf   ; lee 1 si el humano ha decidido ganar
	or a			;6cc2
	ret z			;6cc3
	ld a,001h		;6cc4
	ld (0cd00h),a		;6cc6   ; guarda 1 si la mano es de limite
	ld a,035h		;6cc9
	ld (0c2e0h),a		;6ccb   ; guarda la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	ld a,083h		;6cce
	ld (0c2e1h),a		;6cd0
	scf			;6cd3
	ret			;6cd4
analiza_yaku:		; analiza los yaku de la mano (tablas 0x716B y 0x71A5)
	call prepara_analisis		;6cd5   ; analiza la mano del jugador: yaku en 0xC2E0, luego dos tablas de rutinas (0x716B y 0x71A5)
	call descompone_mano		;6cd8   ; descompone_mano: descompone la mano en grupos (escaleras, tripletes, pareja)
	call copia_grupos		;6cdb   ; copia_grupos: copia los grupos de 0xCD48 a 0xCD95
	xor a			;6cde
	ld (0cd00h),a		;6cdf   ; guarda 1 si la mano es de limite
	call cuenta_iguales		;6ce2   ; cuenta_iguales: cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	call L_6D02		;6ce5
	ld a,(0cd00h)		;6ce8   ; lee 1 si la mano es de limite
	and a			;6ceb
	ret nz			;6cec
L_6CED:
	call 04223h		;6ced   ; recorre las 32 comprobaciones de la tabla 0x716B (un yaku cada una, por el despachador)
	ld bc,02000h		;6cf0
L_6CF3:
	push bc			;6cf3
	ld a,c			;6cf4
	ld hl,0716bh		;6cf5
	call 04067h		;6cf8
	pop bc			;6cfb
	inc c			;6cfc
	djnz L_6CF3		;6cfd
	jp 04207h		;6cff   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_6D02:
	ld a,(0c024h)		;6d02   ; lee la regla de las ocho manos seguidas (八連荘; de serie no)
	and a			;6d05
	jr z,L_6D22		;6d06
	ld a,(0c0b1h)		;6d08   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;6d0b
	ld a,(0c207h)		;6d0c   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_6D14		;6d0f
	ld a,(0c20dh)		;6d11   ; lee el jugador que responde a la ficha tirada
L_6D14:
	ld b,a			;6d14
	ld a,(0c0b7h)		;6d15   ; lee el jugador que reparte (0-3)
	cp b			;6d18
	jr nz,L_6D22		;6d19
	ld a,(0c0c4h)		;6d1b   ; lee las manos seguidas del que reparte
	cp 008h		;6d1e
	jr nc,L_6D37		;6d20
L_6D22:
	call 04223h		;6d22   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ld bc,01400h		;6d25
L_6D28:
	push bc			;6d28
	ld a,c			;6d29
	ld hl,071a5h		;6d2a
	call 04067h		;6d2d
	pop bc			;6d30
	inc c			;6d31
	djnz L_6D28		;6d32
	jp 04207h		;6d34   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_6D37:
	ld a,034h		;6d37
	ld (0c2e0h),a		;6d39   ; guarda la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	ld a,051h		;6d3c
	ld (0c2e1h),a		;6d3e
	ld a,001h		;6d41
	ld (0cd00h),a		;6d43   ; guarda 1 si la mano es de limite
L_6D46:
	ret			;6d46
prepara_analisis:		; pone a cero la lista de yaku y copia la mano a 0xC621
	ld hl,0c2e0h		;6d47   ; pone a cero la lista de yaku (0xC2E0, 32 bytes) y copia la mano a 0xC621
	ld de,0c2e1h		;6d4a
	ld bc,0001fh		;6d4d
	ld (hl),000h		;6d50
	ldir		;6d52
	ld hl,(0cd5ch)		;6d54   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,0c621h		;6d57   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;6d5a
	ldir		;6d5d
	ld a,(0c209h)		;6d5f   ; lee la ficha robada o tirada
	ld (de),a			;6d62
	ld hl,0c621h		;6d63   ; apunta a la mano de trabajo de 14 fichas ordenada
	jp ordena_mano		;6d66   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
descompone_mano:		; descompone la mano en grupos (escaleras, tripletes, pareja)
	ld hl,0cd40h		;6d69   ; DESCOMPONE la mano de 0xC621 en grupos: copia a 0xCD10 la mano de 14 fichas, y busca sus tripletes y secuencias (las parejas en 0xCD04)
	xor a			;6d6c
	ld b,010h		;6d6d
L_6D6F:
	ld (hl),a			;6d6f
	inc hl			;6d70
	djnz L_6D6F		;6d71
	ld hl,0c621h		;6d73   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld de,0cd10h		;6d76   ; apunta a la mano de 14 fichas que se descompone
	ld bc,0000eh		;6d79
	ldir		;6d7c
	xor a			;6d7e
	ld (de),a			;6d7f
	inc de			;6d80
	ld (de),a			;6d81
	call cuenta_fichas		;6d82   ; cuenta_fichas: ordena y cuenta las fichas iguales de 0xCD10
	call L_6EB2		;6d85   ; recorre las 14 fichas de 0xCD10 y por su palo (bits 6-7) va a una rutina de la tabla 0x6ECA
	call L_6F5F		;6d88   ; deja la mano de 0xCD10 sin huecos
	call cuenta_fichas		;6d8b   ; cuenta_fichas: ordena y cuenta las fichas iguales de 0xCD10
	call L_6E8A		;6d8e
	ld hl,0cd40h		;6d91   ; apunta a la pareja de la mano
	ld de,0c540h		;6d94
	ld bc,00010h		;6d97
	ldir		;6d9a
	ld hl,0cd10h		;6d9c   ; apunta a la mano de 14 fichas que se descompone
	ld de,0c530h		;6d9f
	ld bc,00010h		;6da2
	ldir		;6da5
	ld de,0cd04h		;6da7
L_6DAA:
	ld hl,0cd03h		;6daa
	ld a,(hl)			;6dad
	and a			;6dae
	ret z			;6daf
	dec (hl)			;6db0
	push de			;6db1
	ld a,(de)			;6db2
	ld c,a			;6db3
	call L_6EE6		;6db4   ; quita de la mano la ficha C (y resta uno en su cuenta de 0xCD30)
	call L_6EE6		;6db7   ; quita de la mano la ficha C (y resta uno en su cuenta de 0xCD30)
	call L_6F5F		;6dba   ; deja la mano de 0xCD10 sin huecos
	call cuenta_fichas		;6dbd   ; cuenta_fichas: ordena y cuenta las fichas iguales de 0xCD10
	call L_6DF9		;6dc0   ; quita de la mano un triplete o una secuencia de las que hay en 0xCD10
	call L_6DEC		;6dc3   ; mira si la mano de 0xCD10 se ha quedado vacia (carry si lo esta)
	pop de			;6dc6
	jr c,L_6DE7		;6dc7
	push de			;6dc9
	ld hl,0c540h		;6dca
	ld de,0cd40h		;6dcd   ; apunta a la pareja de la mano
	ld bc,00010h		;6dd0
	ldir		;6dd3
	ld hl,0c530h		;6dd5
	ld de,0cd10h		;6dd8   ; apunta a la mano de 14 fichas que se descompone
	ld bc,00010h		;6ddb
	ldir		;6dde
	call cuenta_fichas		;6de0   ; cuenta_fichas: ordena y cuenta las fichas iguales de 0xCD10
	pop de			;6de3
	inc de			;6de4
	jr L_6DAA		;6de5
L_6DE7:
	ld a,(de)			;6de7
	ld (0cd40h),a		;6de8   ; guarda la pareja de la mano
	ret			;6deb
L_6DEC:
	ld hl,0cd10h		;6dec   ; mira si la mano de 0xCD10 se ha quedado vacia (carry si lo esta)
	ld b,00eh		;6def
L_6DF1:
	ld a,(hl)			;6df1   ; mira si la mano de 0xCD10 esta vacia (14 bytes a cero)
	or a			;6df2
	ret nz			;6df3
	inc hl			;6df4
	djnz L_6DF1		;6df5
	scf			;6df7
	ret			;6df8
L_6DF9:
	call L_6E70		;6df9   ; quita de la mano un triplete o una secuencia de las que hay en 0xCD10
	ld de,0cd10h		;6dfc   ; apunta a la mano de 14 fichas que se descompone
L_6DFF:
	ld a,(de)			;6dff
	and a			;6e00
	jr z,L_6E10		;6e01
	push bc			;6e03
	push de			;6e04
	call L_6E61		;6e05   ; cuantas fichas iguales a A hay (tabla 0xCD20 y cuenta en 0xCD30)
	pop de			;6e08
	push de			;6e09
	call L_6E14		;6e0a   ; intenta quitar una escalera: la ficha debe ser de numero hasta 7
	pop de			;6e0d
	pop bc			;6e0e
	ret nc			;6e0f
L_6E10:
	inc de			;6e10
	djnz L_6DFF		;6e11
	ret			;6e13
L_6E14:
	or a			;6e14   ; intenta quitar una escalera: la ficha debe ser de numero hasta 7
	ret z			;6e15
	cp 003h		;6e16
	jr z,L_6E54		;6e18
	ld a,(de)			;6e1a   ; mira que la ficha sea de numero 1 a 7 (empieza una escalera)
	cp 031h		;6e1b
	ret nc			;6e1d
	ld b,a			;6e1e
	and 00fh		;6e1f
	cp 008h		;6e21
	ret nc			;6e23
	ld a,b			;6e24   ; las tres fichas de la escalera: C, D = C + 1 y E = C + 2
	ld c,a			;6e25
	inc a			;6e26
	ld d,a			;6e27
	inc a			;6e28
	ld e,a			;6e29
	push bc			;6e2a
	call L_6E3C		;6e2b   ; comprueba que las tres estan en la mano
	pop bc			;6e2e
	jr z,L_6E33		;6e2f
	or a			;6e31
	ret			;6e32
L_6E33:
	ld a,b			;6e33
	call L_6F55		;6e34
	call L_6EDE		;6e37   ; quita de la mano (0xCD10) las tres fichas C, D y E
	scf			;6e3a
	ret			;6e3b
L_6E3C:
	ld a,c			;6e3c   ; mira las tres fichas C, D y E en la mano
	call L_6E47		;6e3d
	ret nz			;6e40
	ld a,d			;6e41
	call L_6E47		;6e42
	ret nz			;6e45
	ld a,e			;6e46
L_6E47:
	ld hl,0cd10h		;6e47   ; apunta a la mano de 14 fichas que se descompone
	ld b,00eh		;6e4a
L_6E4C:
	cp (hl)			;6e4c   ; busca la ficha A en la mano (acarreo si falta)
	ret z			;6e4d
	inc hl			;6e4e
	djnz L_6E4C		;6e4f
	or 001h		;6e51
	ret			;6e53
L_6E54:
	ld a,(de)			;6e54
	call L_6F48		;6e55   ; anade la ficha A a la primera casilla libre de la lista 0xCD48 (grupos de la mano)
	ld a,(de)			;6e58
	ld c,a			;6e59
	ld d,a			;6e5a
	ld e,a			;6e5b
	call L_6EDE		;6e5c   ; quita de la mano (0xCD10) las tres fichas C, D y E
	scf			;6e5f
	ret			;6e60
L_6E61:
	ld hl,0cd20h		;6e61   ; cuantas fichas iguales a A hay (tabla 0xCD20 y cuenta en 0xCD30)
	ld de,0cd30h		;6e64   ; apunta a cuantas hay de cada una
L_6E67:
	cp (hl)			;6e67
	jr z,L_6E6E		;6e68
	inc hl			;6e6a
	inc de			;6e6b
	jr L_6E67		;6e6c
L_6E6E:
	ld a,(de)			;6e6e
	ret			;6e6f
L_6E70:
	ld hl,0cd10h		;6e70   ; B = cuantas fichas distintas de cero hay en 0xCD10
	ld b,000h		;6e73
L_6E75:
	ld a,(hl)			;6e75   ; cuenta las fichas distintas de cero
	and a			;6e76
	ret z			;6e77
	inc b			;6e78
	inc hl			;6e79
	jr L_6E75		;6e7a
cuenta_fichas:		; ordena y cuenta las fichas iguales de 0xCD10
	exx			;6e7c   ; reordena y cuenta las fichas de 0xCD10 (6FA2)
	ld hl,0cd20h		;6e7d   ; apunta a las fichas distintas de la mano
	ld de,0cd30h		;6e80   ; apunta a cuantas hay de cada una
	exx			;6e83
	ld hl,0cd10h		;6e84   ; apunta a la mano de 14 fichas que se descompone
	jp L_6FA2		;6e87
L_6E8A:
	ld hl,0cd30h		;6e8a   ; apunta a cuantas hay de cada una
	ld de,0cd20h		;6e8d   ; apunta a las fichas distintas de la mano
	ld b,000h		;6e90
	exx			;6e92
	ld hl,0cd04h		;6e93
	exx			;6e96
L_6E97:
	ld a,(hl)			;6e97   ; por cada ficha con cuenta 2 o mas y menor de 0x40 anota la pareja
	and a			;6e98
	jr z,L_6EAD		;6e99
	cp 002h		;6e9b   ; toma solo las fichas con cuenta 2 o mas
	jr c,L_6EA9		;6e9d
	ld a,(de)			;6e9f
	cp 040h		;6ea0
	jr nc,L_6EA9		;6ea2
	exx			;6ea4   ; guarda la ficha en la lista de parejas y cuenta
	ld (hl),a			;6ea5
	inc hl			;6ea6
	exx			;6ea7
	inc b			;6ea8
L_6EA9:
	inc hl			;6ea9
	inc de			;6eaa
	jr L_6E97		;6eab
L_6EAD:
	ld a,b			;6ead
	ld (0cd03h),a		;6eae
	ret			;6eb1
L_6EB2:
	ld de,0cd10h		;6eb2   ; recorre las 14 fichas de 0xCD10 y por su palo (bits 6-7) va a una rutina de la tabla 0x6ECA
	ld b,00eh		;6eb5
L_6EB7:
	ld a,(de)			;6eb7   ; por cada ficha de la mano va a la rutina de su palo (tabla 0x6ECA)
	rlca			;6eb8   ; el palo esta en los bits 6-7 de la ficha: se pasa a los dos bits bajos
	rlca			;6eb9
	and 003h		;6eba
	push de			;6ebc
	push bc			;6ebd
	ld hl,06ecah		;6ebe
	call 04067h		;6ec1   ; salta a la rutina de ese palo (tabla 0x6ECA)
	pop bc			;6ec4
	pop de			;6ec5
	inc de			;6ec6
	djnz L_6EB7		;6ec7
L_6EC9:
	ret			;6ec9

; ----------------------------------------------------------------------
; DATOS resto_6ECA: lo apuntan con el banco puesto p01:6EBE (0x6ECA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6EBE (8 bytes)
;   0x6eca..0x6ed2  (8 bytes)
DATA_resto_6ECA:
	defb 0c9h,06eh,0d2h,06eh,009h,06fh,01ah,06fh	; 6eca  .n.n.o.o

; ======================================================================
; CODIGO 0x6ed2..0x7075  (419 bytes)
; ======================================================================


L_6ED2:
	ld a,(de)			;6ed2
	and 03fh		;6ed3
	or 080h		;6ed5
	call L_6F48		;6ed7   ; anade la ficha A a la primera casilla libre de la lista 0xCD48 (grupos de la mano)
	ld a,(de)			;6eda
	ld c,a			;6edb
	ld d,a			;6edc
	ld e,a			;6edd
L_6EDE:
	call L_6EE6		;6ede   ; quita de la mano (0xCD10) las tres fichas C, D y E
	ld c,d			;6ee1
	call L_6EE6		;6ee2   ; quita de la mano la ficha C (y resta uno en su cuenta de 0xCD30)
	ld c,e			;6ee5
L_6EE6:
	ld hl,0cd10h		;6ee6   ; quita de la mano la ficha C (y resta uno en su cuenta de 0xCD30)
	ld b,00eh		;6ee9
L_6EEB:
	ld a,(hl)			;6eeb   ; busca la ficha C en la mano
	cp c			;6eec
	jr z,L_6EF4		;6eed
	dec b			;6eef
	ret z			;6ef0
	inc hl			;6ef1
	jr L_6EEB		;6ef2
L_6EF4:
	xor a			;6ef4
	ld (hl),a			;6ef5
	ld a,c			;6ef6
	exx			;6ef7
	ld hl,0cd20h		;6ef8   ; apunta a las fichas distintas de la mano
	ld de,0cd30h		;6efb   ; apunta a cuantas hay de cada una
L_6EFE:
	cp (hl)			;6efe
	jr z,L_6F05		;6eff
	inc hl			;6f01
	inc de			;6f02
	jr L_6EFE		;6f03
L_6F05:
	ex de,hl			;6f05
	dec (hl)			;6f06
	exx			;6f07
	ret			;6f08
L_6F09:
	ld a,(de)			;6f09   ; saca una escalera de tres fichas con el bit 7 puesto en su grupo
	and 03fh		;6f0a
	or 080h		;6f0c   ; marca la escalera con el bit 7 en la lista de escaleras
	call L_6F55		;6f0e
	ld a,(de)			;6f11
	ld c,a			;6f12
	inc a			;6f13
	ld d,a			;6f14
	inc a			;6f15
	ld e,a			;6f16
	jp L_6EDE		;6f17   ; quita de la mano las tres fichas
L_6F1A:
	push de			;6f1a   ; saca un triplete de tres iguales
	call L_6F2D		;6f1b   ; mira si la ficha esta en la lista de descartes (+0x41): deja C = 0x80 si no
	pop de			;6f1e
	ld a,(de)			;6f1f
	and 03fh		;6f20
	or c			;6f22
	call L_6F5A		;6f23
	ld a,(de)			;6f26
	ld c,a			;6f27
	ld d,a			;6f28
	ld e,a			;6f29
	jp L_6EDE		;6f2a
L_6F2D:
	ld hl,(0cd5ch)		;6f2d   ; mira si la ficha esta en la lista de descartes (+0x41): deja C = 0x80 si no
	ld bc,00041h		;6f30   ; HL = la lista de descartes +0x41 de la mano que se analiza
	add hl,bc			;6f33
	ld c,080h		;6f34
	ld a,(hl)			;6f36
	and a			;6f37
	ret z			;6f38
	ld b,a			;6f39
	inc hl			;6f3a
	ld a,(de)			;6f3b   ; compara la ficha con cada descarte (sin los bits 6-7)
	and 03fh		;6f3c
L_6F3E:
	cp (hl)			;6f3e
	jr z,L_6F45		;6f3f
	inc hl			;6f41
	djnz L_6F3E		;6f42
	ret			;6f44
L_6F45:
	ld c,000h		;6f45
	ret			;6f47
L_6F48:
	ld hl,0cd48h		;6f48   ; anade la ficha A a la primera casilla libre de la lista 0xCD48 (grupos de la mano)
L_6F4B:
	ld b,a			;6f4b
L_6F4C:
	ld a,(hl)			;6f4c
	and a			;6f4d
	jr z,L_6F53		;6f4e
	inc hl			;6f50
	jr L_6F4C		;6f51
L_6F53:
	ld (hl),b			;6f53
	ret			;6f54
L_6F55:
	ld hl,0cd44h		;6f55   ; lo mismo en la lista 0xCD44
	jr L_6F4B		;6f58
L_6F5A:
	ld hl,0cd4ch		;6f5a   ; lo mismo en la lista 0xCD4C
	jr L_6F4B		;6f5d
L_6F5F:
	ld hl,0c570h		;6f5f   ; deja la mano de 0xCD10 sin huecos
	ld de,0c571h		;6f62
	ld bc,0000fh		;6f65
	ld (hl),000h		;6f68
	ldir		;6f6a
	ld hl,0cd10h		;6f6c   ; apunta a la mano de 14 fichas que se descompone
	ld de,0c570h		;6f6f
	ld b,00eh		;6f72
L_6F74:
	ld a,(hl)			;6f74   ; copia a 0xC570 las fichas que no son cero
	and a			;6f75
	jr z,L_6F7B		;6f76
	ld a,(hl)			;6f78
	ld (de),a			;6f79
	inc de			;6f7a
L_6F7B:
	inc hl			;6f7b
	djnz L_6F74		;6f7c
	ld hl,0c570h		;6f7e
	ld de,0cd10h		;6f81   ; apunta a la mano de 14 fichas que se descompone
	ld bc,00010h		;6f84
	ldir		;6f87
	ret			;6f89
borra_cuentas:		; pone a cero 0xCD20 (fichas y cuentas)
	ld hl,0cd20h		;6f8a   ; pone a cero 0xCD20 (32 bytes: fichas y cuentas)
	ld de,0cd21h		;6f8d
	ld bc,0001fh		;6f90
	ld (hl),000h		;6f93
	ldir		;6f95
	exx			;6f97
cuenta_iguales:		; cuenta las fichas iguales de 0xC621: 0xCD20 = ficha, 0xCD30 = cuantas
	ld hl,0cd20h		;6f98   ; cuenta las fichas iguales de 0xC621: 0xCD20 = ficha distinta, 0xCD30 = cuantas hay
	ld de,0cd30h		;6f9b   ; apunta a cuantas hay de cada una
	exx			;6f9e
	ld hl,0c621h		;6f9f   ; apunta a la mano de trabajo de 14 fichas ordenada
L_6FA2:
	ld b,00eh		;6fa2
L_6FA4:
	ld d,001h		;6fa4
	ld a,(hl)			;6fa6
	and a			;6fa7
	ret z			;6fa8
L_6FA9:
	dec b			;6fa9   ; cuenta las fichas iguales seguidas
	jr z,L_6FB3		;6faa
	inc hl			;6fac
	cp (hl)			;6fad
	jr nz,L_6FB3		;6fae
	inc d			;6fb0
	jr L_6FA9		;6fb1
L_6FB3:
	exx			;6fb3   ; guarda la ficha y su cuenta y sigue con el resto
	ld (hl),a			;6fb4   ; guarda la ficha distinta en 0xCD20
	inc hl			;6fb5
	exx			;6fb6
	ld a,d			;6fb7
	exx			;6fb8
	ld (de),a			;6fb9   ; y su cuenta en 0xCD30
	inc de			;6fba
	exx			;6fbb
	ld a,b			;6fbc
	and a			;6fbd
	jr nz,L_6FA4		;6fbe
	exx			;6fc0
	xor a			;6fc1   ; acaba las listas con un cero
	ld (hl),a			;6fc2
	ld (de),a			;6fc3
	exx			;6fc4
	ret			;6fc5
cuenta_escaleras:		; cuenta las escaleras de la lista 0xCD44
	ld hl,0cd44h		;6fc6   ; cuenta cuantas casillas de la lista 0xCD44 estan ocupadas
L_6FC9:
	ld b,004h		;6fc9
	ld d,000h		;6fcb
L_6FCD:
	ld a,(hl)			;6fcd
	and a			;6fce
	jr z,L_6FD2		;6fcf
	inc d			;6fd1
L_6FD2:
	inc hl			;6fd2
	djnz L_6FCD		;6fd3
	ld a,d			;6fd5
	ret			;6fd6
cuenta_tripletes:		; cuenta los tripletes de la lista 0xCD48
	ld hl,0cd48h		;6fd7   ; apunta a los tripletes de la mano
	jr L_6FC9		;6fda
cuenta_kan:		; cuenta los kan de la lista 0xCD4C
	ld hl,0cd4ch		;6fdc   ; apunta a los kan de la mano
	jr L_6FC9		;6fdf
mira_siete_parejas:		; mira si la mano son siete parejas
	ld a,(0cd9eh)		;6fe1   ; comprueba la mano especial de las siete parejas (0xCD9E aparte): todas las cuentas valen 2
	and a			;6fe4
	ret nz			;6fe5
	xor a			;6fe6
	ld (0cd99h),a		;6fe7   ; guarda 1 si la mano es de siete parejas
	ld hl,(0cd5ch)		;6fea   ; lee la direccion de la mano que se analiza y el byte siguiente (16 bits)
	ld de,00040h		;6fed
	add hl,de			;6ff0
	ld a,(hl)			;6ff1
	and a			;6ff2
	ret nz			;6ff3
	ld hl,0cd30h		;6ff4   ; apunta a cuantas hay de cada una
	ld b,007h		;6ff7
L_6FF9:
	ld a,(hl)			;6ff9
	cp 002h		;6ffa
	ret nz			;6ffc
	inc hl			;6ffd
	djnz L_6FF9		;6ffe
	ld a,001h		;7000
	ld (0cd99h),a		;7002   ; guarda 1 si la mano es de siete parejas
	ld b,002h		;7005
	ld c,00dh		;7007
	ld hl,0c2e0h		;7009   ; apunta a la lista de yaku de la mano: pares codigo, valor (32 como mucho)
L_700C:
	ld a,(hl)			;700c   ; busca la primera casilla libre de la lista de yaku
	and a			;700d
	jr z,L_7014		;700e
	inc hl			;7010
	inc hl			;7011
	jr L_700C		;7012
L_7014:
	ld (hl),c			;7014
	inc hl			;7015
	ld (hl),b			;7016
	xor a			;7017
	ret			;7018
copia_grupos:		; copia los grupos de 0xCD48 a 0xCD95
	ld hl,0cd95h		;7019   ; copia la lista de 0xCD48 (grupos) a 0xCD95 sin los ceros
	ld b,004h		;701c
	xor a			;701e
L_701F:
	ld (hl),a			;701f
	inc hl			;7020
	djnz L_701F		;7021
	ld hl,0cd48h		;7023   ; apunta a los tripletes de la mano
	ld de,0cd95h		;7026   ; apunta a los grupos de la mano (4)
	ld b,008h		;7029
L_702B:
	ld a,(hl)			;702b
	and a			;702c
	jr z,L_7031		;702d
	ld (de),a			;702f
	inc de			;7030
L_7031:
	inc hl			;7031
	djnz L_702B		;7032
	ret			;7034
pon_vientos_propios:		; pone en 0xCD90 los honores que cuentan: viento de la ronda, el propio y dragones
	ld hl,0cd90h		;7035   ; escribe el texto del viento de la ronda y del jugador (0xCD90..): '1' + 0xC0B2, el asiento, y 0x35-0x37
	ld a,(0c0b2h)		;7038   ; lee el viento de la ronda (0 este)
	add a,031h		;703b
	ld (hl),a			;703d
	inc hl			;703e
	ld a,(0c0b7h)		;703f   ; lee el jugador que reparte (0-3)
	ld b,a			;7042
	ld a,004h		;7043
	sub b			;7045
	ld b,a			;7046
	ld a,(0c0b1h)		;7047   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;704a
	ld a,(0c207h)		;704b   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_7053		;704e
	ld a,(0c20dh)		;7050   ; lee el jugador que responde a la ficha tirada
L_7053:
	add a,b			;7053   ; los cuatro vientos como numero 0x31 + la posicion
	and 003h		;7054
	add a,031h		;7056
	ld (hl),a			;7058
	inc hl			;7059
	ld a,035h		;705a   ; despues los tres dragones 0x35, 0x36 y 0x37
	ld (hl),a			;705c
	inc hl			;705d
	inc a			;705e
	ld (hl),a			;705f
	inc hl			;7060
	inc a			;7061
	ld (hl),a			;7062
	ret			;7063
mira_trece_huerfanos:		; compara 0xCD20 con la mano de los trece huerfanos
	ld hl,0cd20h		;7064   ; compara la cuenta de 0xCD20 con la mano de 0x7075 (la de los trece huerfanos)
	ld de,07075h		;7067
	ld b,00eh		;706a
L_706C:
	ld a,(de)			;706c   ; compara la cuenta con la mano de los trece huerfanos
	cp (hl)			;706d
	ret nz			;706e
	inc hl			;706f
	inc de			;7070
	djnz L_706C		;7071
	xor a			;7073
	ret			;7074

; ----------------------------------------------------------------------
; DATOS resto_7075: lo apuntan con el banco puesto p01:7067 (0x7075), p03:A679
;   (0x7078); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:7067, p03:A679 (14 bytes)
;   0x7075..0x7083  (14 bytes)
DATA_resto_7075:
	defb 001h,009h,011h,019h,021h,029h,031h,032h,033h,034h,035h,036h,037h,000h	; 7075  ....!)1234567.

; ======================================================================
; CODIGO 0x7083..0x716b  (232 bytes)
; ======================================================================


L_7083:
	xor a			;7083   ; mira si algun jugador tiene una mano que no vale (con 0xC023)
	ld (0cd00h),a		;7084   ; guarda 1 si la mano es de limite
	ld a,(0c023h)		;7087   ; lee la regla del descarte de punta y honor (流し満貫; de serie si)
	and a			;708a
	ret z			;708b
	call mira_manos_con_grupos		;708c   ; mira_manos_con_grupos: 0xCD01 = 1 si algun jugador ha bajado grupos
	ld a,(0cd01h)		;708f   ; lee 1 si algun jugador ha bajado grupos
	and a			;7092
	ret nz			;7093
	call prepara_analisis		;7094   ; prepara_analisis: pone a cero la lista de yaku y copia la mano a 0xC621
	ld hl,0d000h		;7097
	ld bc,00400h		;709a
L_709D:
	push bc			;709d   ; mira si algun jugador tiene una mano que le impide
	push hl			;709e
	call L_70C5		;709f   ; mira si en la mano (HL + 0x0F) hay alguna ficha de numero 2 a 8
	pop hl			;70a2
	pop bc			;70a3
	jr c,L_70AE		;70a4
	ld de,00400h		;70a6
	add hl,de			;70a9
	inc c			;70aa
	djnz L_709D		;70ab
	ret			;70ad
L_70AE:
	ld a,c			;70ae
	ld (0c207h),a		;70af   ; guarda el jugador al que le toca (0 = el humano)
	ld a,001h		;70b2
	ld (0c0b1h),a		;70b4   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ld (0cd00h),a		;70b7   ; guarda 1 si la mano es de limite
	ld a,02eh		;70ba
	ld (0c2e0h),a		;70bc   ; guarda la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	ld a,083h		;70bf
	ld (0c2e1h),a		;70c1
	ret			;70c4
L_70C5:
	ld de,0000fh		;70c5   ; mira si en la mano (HL + 0x0F) hay alguna ficha de numero 2 a 8
	add hl,de			;70c8
	ld b,(hl)			;70c9
	inc hl			;70ca
L_70CB:
	ld a,(hl)			;70cb   ; si la ficha es de numero 2 a 8
	cp 031h		;70cc
	jr nc,L_70D8		;70ce
	and 00fh		;70d0
	sub 002h		;70d2
	cp 007h		;70d4
	ccf			;70d6
	ret nc			;70d7
L_70D8:
	inc hl			;70d8
	djnz L_70CB		;70d9
	scf			;70db
	ret			;70dc
L_70DD:
	xor a			;70dd   ; pone a cero 0xCD02 y 0xCD00, y mira 0xC022
	ld (0cd02h),a		;70de
	ld (0cd00h),a		;70e1   ; guarda 1 si la mano es de limite
	ld a,(0c022h)		;70e4   ; lee la regla de los trece sin grupos (十三不搭; de serie si)
	and a			;70e7
	ret z			;70e8
	ld a,(0c1c1h)		;70e9   ; lee cuantas fichas se han robado del muro
	sub 034h		;70ec
	cp 004h		;70ee
	ret nc			;70f0
	call mira_manos_con_grupos		;70f1   ; mira_manos_con_grupos: 0xCD01 = 1 si algun jugador ha bajado grupos
	ld a,(0cd01h)		;70f4   ; lee 1 si algun jugador ha bajado grupos
	or a			;70f7
	ret nz			;70f8
	ld hl,(0c0deh)		;70f9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld (0cd5ch),hl		;70fc   ; guarda la direccion de la mano que se analiza y el byte siguiente (16 bits)
	call prepara_analisis		;70ff   ; prepara_analisis: pone a cero la lista de yaku y copia la mano a 0xC621
	call borra_cuentas		;7102   ; pone a cero 0xCD20 (6F8A)
	ld hl,0cd30h		;7105   ; apunta a cuantas hay de cada una
	ld d,000h		;7108
	ld b,00eh		;710a   ; mira las 14 cuentas de 0xCD30: si alguna llega a 3 no vale; cuenta cuantas son 2 (parejas)
L_710C:
	ld a,(hl)			;710c   ; cuenta cuantas fichas distintas de la mano tienen cuenta 2
	cp 003h		;710d
	ret nc			;710f
	cp 002h		;7110
	jr c,L_7115		;7112
	inc d			;7114
L_7115:
	inc hl			;7115
	djnz L_710C		;7116
	ld a,d			;7118   ; solo vale si hay exactamente una pareja
	dec a			;7119
	or a			;711a
	ret nz			;711b
	ld hl,0cd20h		;711c   ; comprueba que las 12 primeras fichas distintas no pasen de 0x30 y que cada paso entre una y la siguiente sea de 3 o mas
	ld b,00ch		;711f
L_7121:
	ld a,(hl)			;7121   ; comprueba que cada par de fichas numeradas distintas esten a 3 o mas
	inc hl			;7122
	cp 031h		;7123
	jr nc,L_712E		;7125
	sub (hl)			;7127
	neg		;7128
	cp 003h		;712a
	ccf			;712c
	ret nc			;712d
L_712E:
	djnz L_7121		;712e
	ld a,001h		;7130   ; se cumple: 0xCD02 = 0xCD00 = 1 y el yaku 0x2F (con el codigo 0x83) a la lista de 0xC2E0
	ld (0cd02h),a		;7132
	ld (0cd00h),a		;7135   ; guarda 1 si la mano es de limite
	ld a,02fh		;7138
	ld (0c2e0h),a		;713a   ; guarda la lista de yaku de la mano: pares codigo, valor (32 como mucho)
	ld a,083h		;713d
	ld (0c2e1h),a		;713f
	scf			;7142
	ret			;7143
mira_manos_con_grupos:		; 0xCD01 = 1 si algun jugador ha bajado grupos
	ld hl,0d040h		;7144   ; mira las cuatro manos (0xD040 + 0x400 x n): D = 1 si alguna tiene ese campo distinto de cero, y lo guarda en 0xCD01
	ld b,004h		;7147
	ld d,001h		;7149
L_714B:
	ld a,(hl)			;714b   ; mira las cuatro manos
	and a			;714c
	jr nz,L_7157		;714d
	ld a,h			;714f
	add a,004h		;7150
	ld h,a			;7152
	djnz L_714B		;7153
	ld d,000h		;7155
L_7157:
	ld a,d			;7157
	ld (0cd01h),a		;7158   ; guarda 1 si algun jugador ha bajado grupos
	ret			;715b
L_715C:
	xor a			;715c   ; 0xCD9D = 0 y pide por 0xA0AB (banco 3) el codigo 0x21
	ld (0cd9dh),a		;715d
	ld c,021h		;7160
	call 04223h		;7162   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	call 0a0abh		;7165   ; anota_yaku: anota el yaku C con valor B en 0xC2E0
	jp 04207h		;7168   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)

; ----------------------------------------------------------------------
; DATOS resto_716B: lo apuntan con el banco puesto p01:6CF5 (0x716B), p01:6D2A
;   (0x71A5); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6CF5, p01:6D2A (98 bytes)
;   0x716b..0x71cd  (98 bytes)
DATA_resto_716B:
	defb 07eh,0a3h,006h,0a5h,050h,0a3h,025h,0a3h,011h,0a4h,0d0h,0a4h,0e7h,0a4h,0beh,0a4h	; 716b  ~...P.%.........
	defb 0f3h,0a4h,03eh,0a5h,0e1h,06fh,05fh,0a4h,0adh,0a3h,031h,0a4h,08ah,0a4h,026h,0a5h	; 717b  ..>..o_...1...&.
	defb 06fh,0a5h,0c4h,0a5h,01eh,0a8h,01dh,0a6h,065h,0a6h,0a8h,0a6h,0bbh,0a6h,0ebh,0a6h	; 718b  o.......e.......
	defb 052h,0a7h,08fh,0a7h,0b8h,0a7h,064h,0a8h,097h,0a8h,0c8h,0a1h,0d9h,0a1h,0f4h,0a1h	; 719b  R.....d.........
	defb 000h,0a0h,080h,0a2h,046h,06dh,02ch,0a0h,05dh,0a0h,0beh,0a2h,08ah,0a0h,0c5h,0a0h	; 71ab  ....Fm,.].......
	defb 0f8h,0a0h,057h,0a1h,0dfh,0a2h,09dh,0a1h,0a6h,0a2h,012h,0a2h,04fh,0a2h,046h,06dh	; 71bb  ..W.........O.Fm
	defb 046h,06dh	; 71cb

; ======================================================================
; CODIGO 0x71cd..0x7804  (1591 bytes)
; ======================================================================


L_71CD:
	ld hl,(0c0deh)		;71cd   ; turno de un jugador de la maquina: el campo +0x34 de su mano decide si esta en espera
	ld bc,00034h		;71d0
	add hl,bc			;71d3
	ld a,(hl)			;71d4
	and a			;71d5
	jp nz,L_7291		;71d6
	call 08855h		;71d9   ; el campo +0x80 distinto de cero lleva a 0x72AE
	ld hl,(0c0deh)		;71dc   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00080h		;71df
	add hl,de			;71e2
	ld a,(hl)			;71e3
	and a			;71e4
	jp nz,L_72AE		;71e5
	call prepara_mano_ia		;71e8   ; prepara la mano (0x7284), la cambia por 0x8711 y sigue con 0x7208, 0x896D, 0x8680
	call 08711h		;71eb   ; busca_ficha_util: busca una ficha que le sirva entre las listas de los demas
	ret c			;71ee
	call L_7208		;71ef   ; busca una ficha que no deba tirar: mira la lista de +0x150 (cuenta) y la de +0x37 (cuenta en +0x3F, de 2 en 2)
	ld a,(0c0c6h)		;71f2
	and a			;71f5
	ret nz			;71f6
	call 0896dh		;71f7   ; mira si quedan menos de 4 fichas (0x69D3); si el bit 5 de +0x60 no esta, vuelve (p02:896D)
	ld hl,(0c0deh)		;71fa   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00034h		;71fd
	add hl,de			;7200
	ld a,(hl)			;7201
	and a			;7202
	ret nz			;7203
	call 08680h		;7204   ; manera_de_jugar: despacha por la manera de jugar de la maquina (+0x96)
	ret			;7207
L_7208:
	xor a			;7208   ; busca una ficha que no deba tirar: mira la lista de +0x150 (cuenta) y la de +0x37 (cuenta en +0x3F, de 2 en 2)
	ld (0c0c6h),a		;7209
	ld hl,(0c0deh)		;720c   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00150h		;720f
	add hl,de			;7212
	ld a,(hl)			;7213
	and a			;7214
	jr z,L_7222		;7215
	ld b,a			;7217
	call L_7262		;7218   ; DE = la ficha que toca (0xC209, o la que ocupa la posicion de la mano): usa 13 menos tres veces los grupos de +0x0E
	ld a,(de)			;721b
L_721C:
	inc hl			;721c
	cp (hl)			;721d
	jr z,L_7240		;721e
	djnz L_721C		;7220
L_7222:
	ld hl,(0c0deh)		;7222   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0003fh		;7225
	add hl,de			;7228
	ld a,(hl)			;7229
	and a			;722a
	ret z			;722b
	ld b,a			;722c
	ld hl,(0c0deh)		;722d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00037h		;7230
	add hl,de			;7233
	call L_7262		;7234   ; DE = la ficha que toca (0xC209, o la que ocupa la posicion de la mano): usa 13 menos tres veces los grupos de +0x0E
	ld a,(de)			;7237
L_7238:
	cp (hl)			;7238   ; busca la ficha de DE en la lista de pares de +0x37
	jr z,L_725D		;7239
	inc hl			;723b
	inc hl			;723c
	djnz L_7238		;723d
	ret			;723f
L_7240:
	ld c,(hl)			;7240
	push hl			;7241
	ld hl,(0c0deh)		;7242   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld b,00eh		;7245
	ld d,000h		;7247
L_7249:
	ld a,b			;7249
	dec a			;724a
	jr nz,L_7250		;724b
	ld hl,0c209h		;724d   ; apunta a la ficha robada o tirada
L_7250:
	ld a,(hl)			;7250
	cp c			;7251
	jr nz,L_7255		;7252
	inc d			;7254
L_7255:
	inc hl			;7255   ; cuenta las fichas iguales a C y mira si son cuatro
	djnz L_7249		;7256
	pop hl			;7258
	ld a,d			;7259
	cp 004h		;725a
	ret c			;725c
L_725D:
	ld a,(hl)			;725d
	ld (0c0c6h),a		;725e
	ret			;7261
L_7262:
	push hl			;7262   ; DE = la ficha que toca (0xC209, o la que ocupa la posicion de la mano): usa 13 menos tres veces los grupos de +0x0E
	ld hl,(0c0deh)		;7263   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;7266
	add hl,de			;7269
	ld a,(hl)			;726a
	add a,a			;726b
	add a,(hl)			;726c
	ld h,a			;726d
	ld a,00dh		;726e
	sub h			;7270
	ld c,a			;7271
	ld de,0c209h		;7272   ; apunta a la ficha robada o tirada
	ld a,(0c20ah)		;7275   ; lee la posicion de la ficha en la mano
	cp c			;7278
	jr z,L_7282		;7279
	ld de,(0c0deh)		;727b   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	call 04061h		;727f   ; suma_a_de: DE = DE + A
L_7282:
	pop hl			;7282
	ret			;7283
prepara_mano_ia:		; prepara el analisis de la mano de la maquina
	call L_72BF		;7284   ; un turno: prepara tablas (72BF), cuenta fichas (72D2), analiza la mano (7349) y sigue con 0x8039
	call reparte_por_palos		;7287   ; reparte_por_palos: reparte la mano por palos en +0x100-+0x13F
	call analiza_ia		;728a   ; analiza_ia: analisis de la mano para la maquina
	call 08039h		;728d   ; prepara_descarte: elige la ficha que va a tirar la maquina
	ret			;7290
L_7291:
	call prueba_ganar_robo		;7291   ; el campo +0x34 esta puesto: prueba 0x68EF y, si no gana, deja en 0xC20A el numero de fichas sueltas (13 - 3 x grupos)
	jr c,L_72A8		;7294
	ld hl,(0c0deh)		;7296   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0000eh		;7299
	add hl,de			;729c
	ld a,(hl)			;729d
	add a,a			;729e
	add a,(hl)			;729f
	ld b,a			;72a0
	ld a,00dh		;72a1
	sub b			;72a3
	ld (0c20ah),a		;72a4   ; guarda la posicion de la ficha en la mano
	ret			;72a7
L_72A8:
	ld a,001h		;72a8
	ld (0c0b1h),a		;72aa   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	ret			;72ad
L_72AE:
	ld hl,(0c0deh)		;72ae   ; devuelve 0xC0B1 a 1 si +0x76 es cero
	ld l,076h		;72b1
	ld a,(hl)			;72b3
	and a			;72b4
	ret nz			;72b5
	call 0886bh		;72b6   ; piensa_si_sigue: decide si vale la pena seguir con esa mano
	push af			;72b9
	call 0896dh		;72ba   ; mira si quedan menos de 4 fichas (0x69D3); si el bit 5 de +0x60 no esta, vuelve (p02:896D)
	pop af			;72bd
	ret			;72be
L_72BF:
	ld hl,(0c0deh)		;72bf   ; borra las tablas de analisis de la mano: 0x300 bytes a partir de +0x100
	ld bc,00100h		;72c2
	add hl,bc			;72c5
	ld bc,00300h		;72c6
L_72C9:
	ld (hl),000h		;72c9   ; pone a cero BC bytes
	inc hl			;72cb
	dec bc			;72cc
	ld a,b			;72cd
	or c			;72ce
	jr nz,L_72C9		;72cf
	ret			;72d1
reparte_por_palos:		; reparte la mano por palos en +0x100-+0x13F
	ld hl,(0c0deh)		;72d2   ; REPARTE LA MANO POR PALOS: copia las 13 fichas de la mano y la 14a (0xC209) a 0xC600, las ordena y mete cada una en la tabla de su palo (+0x100, +0x110, +0x120, +0x130), con su cuenta
	ld de,0c600h		;72d5   ; apunta a la mano de 14 fichas para repartir por palos
	ld bc,0000dh		;72d8
	ldir		;72db
	ld a,(0c209h)		;72dd   ; lee la ficha robada o tirada
	ld (de),a			;72e0
	call L_731D		;72e1   ; ordena de menor a mayor las 14 fichas de 0xC600 (burbuja; HL = 0xC600)
	ld hl,(0c0deh)		;72e4   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0c600h		;72e7   ; apunta a la mano de 14 fichas para repartir por palos
	ld b,00eh		;72ea
L_72EC:
	push bc			;72ec   ; por cada ficha de la mano que no es de grupo, elige su tabla por el palo (+0x100, 0x110, 0x120, 0x130)
	ld a,(de)			;72ed
	and 0c0h		;72ee   ; las fichas con bits 6-7 puestos (honores o ficha dada) no se reparten
	jr nz,L_7318		;72f0
	ld a,(de)			;72f2
	and 030h		;72f3
	rrca			;72f5
	rrca			;72f6
	rrca			;72f7
	rrca			;72f8
	and a			;72f9
	ld bc,00100h		;72fa
	jr z,L_730E		;72fd
	dec a			;72ff
	ld bc,00110h		;7300
	jr z,L_730E		;7303
	dec a			;7305
	ld bc,00120h		;7306
	jr z,L_730E		;7309
	ld bc,00130h		;730b
L_730E:
	push hl			;730e
	add hl,bc			;730f
	inc (hl)			;7310
	ld a,(hl)			;7311
	call 0405ch		;7312   ; suma_a_hl: HL = HL + A
	ld a,(de)			;7315
	ld (hl),a			;7316
	pop hl			;7317
L_7318:
	inc de			;7318
	pop bc			;7319
	djnz L_72EC		;731a
	ret			;731c
L_731D:
	ld hl,0c600h		;731d   ; ordena de menor a mayor las 14 fichas de 0xC600 (burbuja; HL = 0xC600)
ordena_mano:		; ordena de menor a mayor las 14 fichas de HL
	ld a,00eh		;7320   ; ordena de menor a mayor las 14 fichas de HL
L_7322:
	ld d,a			;7322
	srl d		;7323
	ld (0c200h),a		;7325   ; guarda contador de trabajo de las fichas de la mano
L_7328:
	and 001h		;7328
	ld b,d			;732a
	jr z,L_732E		;732b
	dec b			;732d
L_732E:
	push hl			;732e
	add a,l			;732f
	ld l,a			;7330
L_7331:
	ld a,(hl)			;7331   ; un paso de la ordenacion: intercambia dos fichas contiguas si estan al reves
	inc l			;7332
	cp (hl)			;7333
	jr c,L_733D		;7334
	jr z,L_733D		;7336
	ld c,(hl)			;7338
	ld (hl),a			;7339
	dec l			;733a
	ld (hl),c			;733b
	inc l			;733c
L_733D:
	inc l			;733d
	djnz L_7331		;733e
	ld hl,0c200h		;7340   ; apunta a contador de trabajo de las fichas de la mano
	dec (hl)			;7343
	ld a,(hl)			;7344
	pop hl			;7345
	jr nz,L_7328		;7346
	ret			;7348
analiza_ia:		; analisis de la mano para la maquina
	call prueba_siete_parejas_ia		;7349   ; ANALISIS DE LA MANO PARA LA MAQUINA: 7775 (mano especial) y, si +0x70 es cero, 784C y 7361; luego 75C4
	ld hl,(0c0deh)		;734c   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00070h		;734f
	add hl,de			;7352
	ld a,(hl)			;7353
	and a			;7354
	jr nz,L_735D		;7355
	call analiza_palos		;7357   ; analiza_palos: analiza los cuatro palos con la tabla del banco 15
	call L_7361		;735a   ; busca la mejor combinacion de fichas para descartar: prueba 7498 (de uno en uno) y deja las 4 elegidas en 0xC610
L_735D:
	call copia_y_analiza		;735d   ; copia_y_analiza: copia la mano ordenada y la analiza
	ret			;7360
L_7361:
	ld hl,0c610h		;7361   ; busca la mejor combinacion de fichas para descartar: prueba 7498 (de uno en uno) y deja las 4 elegidas en 0xC610
	ld de,0c611h		;7364
	ld bc,00003h		;7367
	ld (hl),000h		;736a
	ldir		;736c
	call L_7498		;736e   ; busca tres fichas de un mismo numero en los tres palos (D = 1..7) y deja el resultado en 0xC610
	jr c,L_7398		;7371
	ld hl,(0c0deh)		;7373   ; recorre los cuatro palos en 0x1C1+: por cada uno con fichas va a 0x7422 (una) o 0x73BF (varias)
	ld de,001c1h		;7376
	add hl,de			;7379
	ld de,0c610h		;737a
	ld bc,00400h		;737d
L_7380:
	push bc			;7380
	push hl			;7381
	ld a,(hl)			;7382
	ld b,a			;7383
	and a			;7384
	jr z,L_7392		;7385
	dec a			;7387
	jr z,L_738F		;7388
	call L_73BF		;738a   ; elige entre varias opciones al azar (0xC003) o por la que tiene menos
	jr L_7392		;738d
L_738F:
	call L_7422		;738f
L_7392:
	pop hl			;7392
	inc hl			;7393
	pop bc			;7394
	inc c			;7395
	djnz L_7380		;7396
L_7398:
	ld de,0c610h		;7398   ; mete en las listas de +0x140 (fichas propias) o +0x150 (con bit 6) las que ha elegido
	ld b,004h		;739b
L_739D:
	ld a,(de)			;739d   ; elige la lista de +0x140 o +0x150 segun el bit 6
	and a			;739e
	ret z			;739f
	and 040h		;73a0
	ld hl,00140h		;73a2
	jr z,L_73AA		;73a5
	ld hl,00150h		;73a7
L_73AA:
	push de			;73aa
	ld de,(0c0deh)		;73ab   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,de			;73af
	pop de			;73b0
	ld a,(hl)			;73b1
	inc (hl)			;73b2
	inc hl			;73b3
	call 0405ch		;73b4   ; suma_a_hl: HL = HL + A
	ld a,(de)			;73b7
	and 03fh		;73b8
	ld (hl),a			;73ba
	inc de			;73bb
	djnz L_739D		;73bc
	ret			;73be
L_73BF:
	exx			;73bf   ; elige entre varias opciones al azar (0xC003) o por la que tiene menos
	ld hl,(0c0deh)		;73c0   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00094h		;73c3
	add hl,de			;73c6
	ld a,(hl)			;73c7
	rrca			;73c8
	rrca			;73c9
	rrca			;73ca
	rrca			;73cb
	exx			;73cc
	and 00fh		;73cd
	cp 002h		;73cf
	jr nc,L_73F6		;73d1
	push bc			;73d3
	push de			;73d4
	call L_7449		;73d5   ; mira si las fichas son de un palo que no vale (7523, 7551) o de numero 2-8 (7576, 759D)
	pop de			;73d8
	pop bc			;73d9
	jr c,L_742B		;73da
	push bc			;73dc
	ld a,(0c003h)		;73dd   ; lee el contador de cuadros
L_73E0:
	ld c,a			;73e0
	sub b			;73e1
	jr nc,L_73E0		;73e2
	push de			;73e4
	ld hl,(0c0deh)		;73e5   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00200h		;73e8
	add hl,de			;73eb
	pop de			;73ec
	ld a,c			;73ed
	add a,a			;73ee
	add a,a			;73ef
	call 0405ch		;73f0   ; suma_a_hl: HL = HL + A
	pop bc			;73f3
	jr L_742B		;73f4
L_73F6:
	push bc			;73f6
	ld b,(hl)			;73f7
	push de			;73f8
	ld hl,(0c0deh)		;73f9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00200h		;73fc
	add hl,de			;73ff
	pop de			;7400
	ld (0cc80h),hl		;7401
L_7404:
	ld hl,(0cc80h)		;7404
	ld a,b			;7407
	dec a			;7408
	add a,a			;7409
	add a,a			;740a
	call 0405ch		;740b   ; suma_a_hl: HL = HL + A
	ld c,004h		;740e
L_7410:
	ld a,(hl)			;7410   ; mira cual de las cuatro fichas del bloque lleva el bit 6
	and 040h		;7411
	jr nz,L_741B		;7413
	inc hl			;7415
	dec c			;7416
	jr nz,L_7410		;7417
	djnz L_7404		;7419
L_741B:
	ld a,l			;741b
	and 0fch		;741c
	ld l,a			;741e
	pop bc			;741f
	jr L_742B		;7420
L_7422:
	push de			;7422
	ld hl,(0c0deh)		;7423   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00200h		;7426
	add hl,de			;7429
	pop de			;742a
L_742B:
	ld a,c			;742b   ; multiplica C por 16
	add a,a			;742c
	add a,a			;742d
	add a,a			;742e
	add a,a			;742f
	ld c,a			;7430
L_7431:
	ld a,(hl)			;7431   ; busca el bloque de cuatro fichas de ese palo
	and 030h		;7432
	cp c			;7434
	jr z,L_743D		;7435
	inc hl			;7437
	inc hl			;7438
	inc hl			;7439
	inc hl			;743a
	jr L_7431		;743b
L_743D:
	ld b,004h		;743d
L_743F:
	ld a,(hl)			;743f
	and a			;7440
	jr z,L_7445		;7441
	ld (de),a			;7443
	inc de			;7444
L_7445:
	inc hl			;7445
	djnz L_743F		;7446
	ret			;7448
L_7449:
	push bc			;7449   ; mira si las fichas son de un palo que no vale (7523, 7551) o de numero 2-8 (7576, 759D)
	call L_7523		;744a   ; mira si hay un 1 y un 9 del mismo palo
	pop bc			;744d
	ret c			;744e
	push bc			;744f
	call L_7551		;7450   ; mira si hay una pareja de fichas iguales
	pop bc			;7453
	ret c			;7454
	ld hl,(0c0deh)		;7455   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00092h		;7458
	add hl,de			;745b
	ld a,(hl)			;745c
	cp 020h		;745d
	jr nc,L_7465		;745f
	call L_7576		;7461   ; mira si todas las fichas son de numero 2 a 8
	ret			;7464
L_7465:
	call L_759D		;7465   ; mira si alguna ficha es de 1, 9 o honor
	ret			;7468
hl_lista_del_palo:		; HL = la lista de fichas del palo C en +0x200
	ld hl,(0c0deh)		;7469   ; si C es 0 a 2, la lista del palo; con mas, la suma de las tres cuentas por cuatro
	ld de,001c1h		;746c
	add hl,de			;746f
	ld a,c			;7470
	and a			;7471
	jr z,L_748D		;7472
	dec a			;7474   ; palo 1
	jr z,L_7483		;7475
	dec a			;7477
	jr z,L_7488		;7478
	ld a,(hl)			;747a   ; los tres palos juntos: suma las tres cuentas
	inc hl			;747b
	add a,(hl)			;747c
	inc hl			;747d
	add a,(hl)			;747e
	add a,a			;747f
	add a,a			;7480
	jr L_748D		;7481
L_7483:
	ld a,(hl)			;7483
	add a,a			;7484
	add a,a			;7485
	jr L_748D		;7486
L_7488:
	ld a,(hl)			;7488
	inc hl			;7489
	add a,(hl)			;748a
	add a,a			;748b
	add a,a			;748c
L_748D:
	ld hl,(0c0deh)		;748d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00200h		;7490
	add hl,de			;7493
	call 0405ch		;7494   ; suma_a_hl: HL = HL + A
	ret			;7497
L_7498:
	ld hl,(0c0deh)		;7498   ; busca tres fichas de un mismo numero en los tres palos (D = 1..7) y deja el resultado en 0xC610
	ld de,001c1h		;749b
	add hl,de			;749e
	ld b,003h		;749f
L_74A1:
	ld a,(hl)			;74a1   ; si hay fichas de los tres palos, empieza a probar las siete posibles
	and a			;74a2
	ret z			;74a3
	inc hl			;74a4
	djnz L_74A1		;74a5
	ld b,007h		;74a7
	ld d,001h		;74a9
L_74AB:
	exx			;74ab   ; prueba la posicion D en el primer palo
	ld de,0c610h		;74ac
	exx			;74af
	push de			;74b0
	push bc			;74b1
	call L_74D9		;74b2
	jr nc,L_74C1		;74b5
	call L_74E2		;74b7   ; y en el segundo
	jr nc,L_74C1		;74ba
	call L_74EB		;74bc   ; y en el tercero
	jr c,L_74D5		;74bf
L_74C1:
	pop bc			;74c1   ; acaba sin encontrar: borra 0xC610 (4 bytes)
	pop de			;74c2
	inc d			;74c3
	djnz L_74AB		;74c4
	ld hl,0c610h		;74c6   ; si ninguna sirve deja a cero los cuatro bytes del resultado
	ld de,0c611h		;74c9
	ld bc,00003h		;74cc
	ld (hl),000h		;74cf
	ldir		;74d1
	or a			;74d3
	ret			;74d4
L_74D5:
	pop bc			;74d5
	pop de			;74d6
	scf			;74d7
	ret			;74d8
L_74D9:
	ld a,000h		;74d9
	ld bc,001c1h		;74db
	call L_74F0		;74de   ; busca en el palo A la ficha de numero D
	ret			;74e1
L_74E2:
	ld a,001h		;74e2
	ld bc,001c2h		;74e4
	call L_74F0		;74e7   ; busca en el palo A la ficha de numero D
	ret			;74ea
L_74EB:
	ld a,002h		;74eb
	ld bc,001c3h		;74ed
L_74F0:
	ld hl,(0c0deh)		;74f0   ; busca en el palo A la ficha de numero D
	add hl,bc			;74f3
	ld b,(hl)			;74f4
	ld c,a			;74f5
	push de			;74f6
	call hl_lista_del_palo		;74f7   ; hl_lista_del_palo: HL = la lista de fichas del palo C en +0x200
	pop de			;74fa
L_74FB:
	push hl			;74fb
	push bc			;74fc
	ld b,004h		;74fd
L_74FF:
	ld a,(hl)			;74ff   ; mira en el bloque de cuatro fichas si alguna tiene el numero D
	and 00fh		;7500
	cp d			;7502
	jr z,L_7512		;7503
	inc hl			;7505
	djnz L_74FF		;7506
	pop bc			;7508   ; no hay: pasa al bloque siguiente
	pop hl			;7509
	inc hl			;750a
	inc hl			;750b
	inc hl			;750c
	inc hl			;750d
	djnz L_74FB		;750e
	or a			;7510
	ret			;7511
L_7512:
	pop bc			;7512   ; hay: copia sus fichas al resultado
	pop hl			;7513
	ld b,004h		;7514
L_7516:
	ld a,(hl)			;7516   ; copia las cuatro fichas del bloque a 0xC610
	and a			;7517
	jr z,L_751E		;7518
	exx			;751a
	ld (de),a			;751b
	inc de			;751c
	exx			;751d
L_751E:
	inc hl			;751e
	djnz L_7516		;751f
	scf			;7521
	ret			;7522
L_7523:
	ld a,c			;7523   ; mira si hay un 1 y un 9 del mismo palo
	cp 003h		;7524
	ret nc			;7526
	call hl_lista_del_palo		;7527   ; hl_lista_del_palo: HL = la lista de fichas del palo C en +0x200
L_752A:
	push bc			;752a   ; mira si la lista tiene un 1 y un 9
	push hl			;752b
	ld a,(hl)			;752c   ; primer numero del bloque
	and 00fh		;752d
	dec a			;752f
	jr nz,L_7543		;7530
	ld b,003h		;7532
	inc hl			;7534
	ld de,00407h		;7535   ; busca un 1 (D = 4) y un 7 (E = 7)
	cp d			;7538
	jr nz,L_753C		;7539
	ld d,e			;753b
L_753C:
	inc hl			;753c
	djnz L_754D		;753d
	ld a,d			;753f
	cp e			;7540
	jr z,L_754D		;7541
L_7543:
	pop hl			;7543   ; siguiente bloque de cuatro
	pop bc			;7544
	inc hl			;7545
	inc hl			;7546
	inc hl			;7547
	inc hl			;7548
	djnz L_752A		;7549
	or a			;754b
	ret			;754c
L_754D:
	pop hl			;754d
	pop bc			;754e
	scf			;754f
	ret			;7550
L_7551:
	ld a,c			;7551   ; mira si hay una pareja de fichas iguales
	cp 003h		;7552
	ret nc			;7554
	call hl_lista_del_palo		;7555   ; hl_lista_del_palo: HL = la lista de fichas del palo C en +0x200
L_7558:
	push hl			;7558
	push bc			;7559
	ld a,(hl)			;755a
	ld b,003h		;755b
	inc hl			;755d
L_755E:
	cp (hl)			;755e   ; busca una pareja
	jr z,L_7572		;755f
	inc hl			;7561
	ld a,(hl)			;7562
	and a			;7563
	jr z,L_7568		;7564
	djnz L_755E		;7566
L_7568:
	pop bc			;7568   ; siguiente bloque
	pop hl			;7569
	inc hl			;756a
	inc hl			;756b
	inc hl			;756c
	inc hl			;756d
	djnz L_7558		;756e
	or a			;7570
	ret			;7571
L_7572:
	pop bc			;7572
	pop hl			;7573
	scf			;7574
	ret			;7575
L_7576:
	ld a,c			;7576   ; mira si todas las fichas son de numero 2 a 8
	cp 003h		;7577
	ret nc			;7579
	call hl_lista_del_palo		;757a   ; hl_lista_del_palo: HL = la lista de fichas del palo C en +0x200
L_757D:
	push hl			;757d
	push bc			;757e
	ld b,004h		;757f
L_7581:
	ld a,(hl)			;7581   ; mira si todas las fichas son de numero 2 a 8
	and 00fh		;7582
	jr z,L_758F		;7584
	sub 002h		;7586
	cp 007h		;7588
	jr nc,L_7593		;758a
	inc hl			;758c
	djnz L_7581		;758d
L_758F:
	pop bc			;758f
	pop hl			;7590
	scf			;7591
	ret			;7592
L_7593:
	pop bc			;7593   ; sigue con el bloque siguiente
	pop hl			;7594
	inc hl			;7595
	inc hl			;7596
	inc hl			;7597
	inc hl			;7598
	djnz L_757D		;7599
	or a			;759b
	ret			;759c
L_759D:
	ld a,c			;759d   ; mira si alguna ficha es de 1, 9 o honor
	cp 003h		;759e
	ret nc			;75a0
	call hl_lista_del_palo		;75a1   ; hl_lista_del_palo: HL = la lista de fichas del palo C en +0x200
L_75A4:
	push hl			;75a4
	push bc			;75a5
	ld b,004h		;75a6
L_75A8:
	ld a,(hl)			;75a8   ; mira cada ficha del bloque: de numero entre 2 y 8
	and 00fh		;75a9
	jr z,L_75B6		;75ab
	sub 002h		;75ad
	cp 007h		;75af
	jr c,L_75BA		;75b1
	inc hl			;75b3
	djnz L_75A8		;75b4
L_75B6:
	pop bc			;75b6
	pop hl			;75b7
	scf			;75b8
	ret			;75b9
L_75BA:
	pop bc			;75ba   ; bloque siguiente
	pop hl			;75bb
	inc hl			;75bc
	inc hl			;75bd
	inc hl			;75be
	inc hl			;75bf
	djnz L_75A4		;75c0
	or a			;75c2
	ret			;75c3
copia_y_analiza:		; copia la mano ordenada y la analiza
	ld hl,(0c0deh)		;75c4   ; copia la mano ordenada a 0xC621 y sigue con cuatro analisis: 75E9, 7EB7, 7625, 7638 y 7752
	ld de,0c621h		;75c7   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;75ca
	ldir		;75cd
	ld a,(0c209h)		;75cf   ; lee la ficha robada o tirada
	ld (de),a			;75d2
	ld hl,0c621h		;75d3   ; apunta a la mano de trabajo de 14 fichas ordenada
	call ordena_mano		;75d6   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
	call L_75E9		;75d9   ; quita de la mano los tripletes y escaleras que ya estan hechos (listas de +0x140 y +0x150)
	call L_7EB7		;75dc   ; deja la mano de 0xC621 sin huecos
	call L_7625		;75df   ; cuenta en 0xC620 las fichas de 0xC621 que quedan
	call L_7638		;75e2   ; elige la tabla de rutinas de busqueda de partes (7804) segun el numero de grupos y la fase de la partida
	call L_7752		;75e5   ; las fichas que quedan sin pareja van a la lista +0x1B0
	ret			;75e8
L_75E9:
	ld bc,00140h		;75e9   ; quita de la mano los tripletes y escaleras que ya estan hechos (listas de +0x140 y +0x150)
	ld hl,(0c0deh)		;75ec   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;75ef
	ld a,(hl)			;75f0
	and a			;75f1
	jr z,L_7608		;75f2
	inc hl			;75f4
	ld b,a			;75f5
L_75F6:
	push bc			;75f6   ; quita de la mano una escalera de la lista de grupos (C, C + 1, C + 2)
	ld a,(hl)			;75f7
	and 03fh		;75f8
	ld c,a			;75fa
	inc a			;75fb
	ld d,a			;75fc
	inc a			;75fd
	ld e,a			;75fe
	push hl			;75ff
	call L_7E9F		;7600   ; la quita de la mano
	pop hl			;7603
	inc hl			;7604   ; siguiente grupo de la lista
	pop bc			;7605
	djnz L_75F6		;7606
L_7608:
	ld bc,00150h		;7608
	ld hl,(0c0deh)		;760b   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;760e
	ld a,(hl)			;760f
	and a			;7610
	ret z			;7611
	inc hl			;7612
	ld b,a			;7613
L_7614:
	push bc			;7614   ; quita de la mano un triplete de la lista de grupos (C, C, C)
	ld a,(hl)			;7615
	and 03fh		;7616
	ld c,a			;7618
	ld d,a			;7619
	ld e,a			;761a
	push hl			;761b
	call L_7E9F		;761c   ; la quita de la mano
	pop hl			;761f
	inc hl			;7620   ; siguiente grupo de la lista
	pop bc			;7621
	djnz L_7614		;7622
	ret			;7624
L_7625:
	ld hl,0c621h		;7625   ; cuenta en 0xC620 las fichas de 0xC621 que quedan
	ld bc,00e00h		;7628
L_762B:
	ld a,(hl)			;762b
	and a			;762c
	jr z,L_7630		;762d
	inc c			;762f
L_7630:
	inc hl			;7630
	djnz L_762B		;7631
	ld a,c			;7633
	ld (0c620h),a		;7634   ; guarda cuantas fichas hay en la mano de trabajo
	ret			;7637
L_7638:
	call 08189h		;7638   ; elige la tabla de rutinas de busqueda de partes (7804) segun el numero de grupos y la fase de la partida
	cp 003h		;763b
	jr nz,L_7651		;763d
	ld hl,(0c0deh)		;763f   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00160h		;7642
	add hl,de			;7645
	ld a,(hl)			;7646
	ld de,07818h		;7647
	jr z,L_7684		;764a
	ld de,0781ch		;764c
	jr L_7684		;764f
L_7651:
	ld hl,(0c0deh)		;7651   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00092h		;7654
	add hl,de			;7657
	ld a,(hl)			;7658
	rrca			;7659
	rrca			;765a
	and 00ch		;765b
	ld b,a			;765d
	ld hl,(0c0deh)		;765e   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00094h		;7661
	add hl,de			;7664
	ld a,(hl)			;7665
	rrca			;7666
	rrca			;7667
	rrca			;7668
	rrca			;7669
	and 003h		;766a
	or b			;766c
	add a,a			;766d
	add a,a			;766e
	ld hl,0780ch		;766f
	call 0405ch		;7672   ; suma_a_hl: HL = HL + A
	ex de,hl			;7675
	ld hl,(0c0deh)		;7676   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00070h		;7679
	add hl,bc			;767c
	ld a,(hl)			;767d
	and a			;767e
	jr z,L_7684		;767f
	ld de,07838h		;7681
L_7684:
	ex de,hl			;7684
	ld b,004h		;7685
L_7687:
	push bc			;7687
	push hl			;7688
	ld a,(hl)			;7689
	ld hl,07804h		;768a
	call 04d07h		;768d   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;7690
	call L_769A		;7691   ; llama a la rutina de HL para cada ficha que queda
	pop hl			;7694
	inc hl			;7695
	pop bc			;7696
	djnz L_7687		;7697
	ret			;7699
L_769A:
	ld hl,0c620h		;769a   ; llama a la rutina de HL para cada ficha que queda
	ld b,(hl)			;769d
	inc hl			;769e
L_769F:
	ex de,hl			;769f   ; llama a la rutina de HL para cada una de las fichas que quedan (B veces)
	push bc			;76a0
	push de			;76a1
	push hl			;76a2
	call L_76AD		;76a3   ; llama a la rutina que da HL (una de las cuatro de 0x7804)
	pop de			;76a6
	pop hl			;76a7
	pop bc			;76a8
	inc hl			;76a9
	djnz L_769F		;76aa   ; siguiente ficha
	ret			;76ac
L_76AD:
	jp (hl)			;76ad
L_76AE:
	ex de,hl			;76ae   ; DOS FICHAS CON UN HUECO: la primera menor de 0x30 y la segunda dos mas
	ld a,(hl)			;76af
	cp 030h		;76b0
	ret nc			;76b2
	and a			;76b3
	ret z			;76b4
	ld b,a			;76b5
	inc hl			;76b6
	ld a,(hl)			;76b7
	and a			;76b8
	ret z			;76b9
	ld c,a			;76ba
	sub b			;76bb   ; resta la primera a la segunda: tiene que dar 2
	cp 002h		;76bc
	ret nz			;76be
	xor a			;76bf   ; las quita de la mano
	ld (hl),a			;76c0
	dec hl			;76c1
	ld (hl),a			;76c2
	ld hl,(0c0deh)		;76c3   ; y las apunta en la lista de +0x190
	ld de,00190h		;76c6
	add hl,de			;76c9
L_76CA:
	ld a,(hl)			;76ca
	inc (hl)			;76cb
	add a,a			;76cc
	inc hl			;76cd
	call 0405ch		;76ce   ; suma_a_hl: HL = HL + A
	ld (hl),b			;76d1
	inc hl			;76d2
	ld (hl),c			;76d3
	ret			;76d4
L_76D5:
	ex de,hl			;76d5   ; DOS FICHAS SEGUIDAS por los dos lados: las dos con numero de 2 a 8
	ld a,(hl)			;76d6
	cp 030h		;76d7
	ret nc			;76d9
	and a			;76da
	ret z			;76db
	ld b,a			;76dc
	inc hl			;76dd
	ld a,(hl)			;76de
	and a			;76df
	ret z			;76e0
	ld c,a			;76e1
	sub b			;76e2   ; la segunda es la primera mas uno
	dec a			;76e3
	ret nz			;76e4
	ld a,b			;76e5
	and 00fh		;76e6
	sub 002h		;76e8
	cp 007h		;76ea
	ret nc			;76ec
	ld a,c			;76ed   ; y las dos de numero de 2 a 8
	and 00fh		;76ee
	sub 002h		;76f0
	cp 007h		;76f2
	ret nc			;76f4
	xor a			;76f5   ; las quita de la mano y las apunta en +0x180
	ld (hl),a			;76f6
	dec hl			;76f7
	ld (hl),a			;76f8
	ld hl,(0c0deh)		;76f9   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00180h		;76fc
	add hl,de			;76ff
	call L_76CA		;7700
	ret			;7703
L_7704:
	ex de,hl			;7704   ; DOS FICHAS SEGUIDAS en el borde: una de ellas es 1 o 9
	ld a,(hl)			;7705
	cp 030h		;7706
	ret nc			;7708
	and a			;7709
	ret z			;770a
	ld b,a			;770b
	inc hl			;770c
	ld a,(hl)			;770d
	and a			;770e
	ret z			;770f
	ld c,a			;7710
	sub b			;7711   ; la segunda es la primera mas uno
	dec a			;7712
	ret nz			;7713
	ld a,b			;7714   ; mira que no sean las dos de numero de 2 a 8
	and 00fh		;7715
	sub 002h		;7717
	cp 007h		;7719
	jr nc,L_7725		;771b
	ld a,c			;771d
	and 00fh		;771e
	sub 002h		;7720
	cp 007h		;7722
	ret c			;7724
L_7725:
	xor a			;7725   ; las quita y las apunta en +0x1A0
	ld (hl),a			;7726
	dec hl			;7727
	ld (hl),a			;7728
	ld hl,(0c0deh)		;7729   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,001a0h		;772c
	add hl,de			;772f
	call L_76CA		;7730
	ret			;7733
L_7734:
	ex de,hl			;7734   ; PAREJA: dos fichas iguales (sin los bits 6-7)
	ld a,(hl)			;7735
	and a			;7736
	ret z			;7737
	ld b,a			;7738
	and 0c0h		;7739
	ret nz			;773b
	inc hl			;773c
	ld a,(hl)			;773d
	and a			;773e
	ret z			;773f
	ld c,a			;7740
	sub b			;7741   ; las dos son iguales
	ret nz			;7742
	xor a			;7743   ; las quita y las apunta en +0x160
	ld (hl),a			;7744
	dec hl			;7745
	ld (hl),a			;7746
	ld hl,(0c0deh)		;7747   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00160h		;774a
	add hl,de			;774d
	call L_76CA		;774e
	ret			;7751
L_7752:
	ld de,0c620h		;7752   ; las fichas que quedan sin pareja van a la lista +0x1B0
	ld a,(de)			;7755
	ld b,a			;7756
	inc de			;7757
L_7758:
	ld a,(de)			;7758
	and a			;7759
	jr z,L_7771		;775a
	and 0c0h		;775c
	jr nz,L_7771		;775e
	push de			;7760
	ld hl,(0c0deh)		;7761   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,001b0h		;7764
	add hl,de			;7767
	ld a,(hl)			;7768
	inc (hl)			;7769
	inc hl			;776a
	call 0405ch		;776b   ; suma_a_hl: HL = HL + A
	pop de			;776e
	ld a,(de)			;776f
	ld (hl),a			;7770
L_7771:
	inc de			;7771
	djnz L_7758		;7772
	ret			;7774
prueba_siete_parejas_ia:		; comprueba si la mano de la maquina va a las siete parejas
	ld hl,(0c0deh)		;7775   ; comprueba si la mano va a las siete parejas: cuenta las parejas que lleva y las compara con 4 o 5
	ld de,00040h		;7778
	add hl,de			;777b
	ld a,(hl)			;777c
	and a			;777d
	jr nz,L_77FA		;777e
	ld hl,(0c0deh)		;7780   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00075h		;7783
	add hl,de			;7786
	ld a,(hl)			;7787
	and a			;7788
	jr nz,L_77FA		;7789
	ld hl,(0c0deh)		;778b   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00091h		;778e
	add hl,de			;7791
	ld a,(hl)			;7792
	rrca			;7793
	rrca			;7794
	rrca			;7795
	rrca			;7796
	and 003h		;7797
	cp 003h		;7799
	jr nc,L_77FA		;779b
	ld hl,(0c0deh)		;779d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,00094h		;77a0
	add hl,de			;77a3
	ld a,(hl)			;77a4
	rla			;77a5
	rla			;77a6
	rla			;77a7
	ld c,004h		;77a8
	jr nc,L_77AD		;77aa
	inc c			;77ac
L_77AD:
	push bc			;77ad
	ld hl,(0c0deh)		;77ae   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,0c621h		;77b1   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000dh		;77b4
	ldir		;77b7
	ld a,(0c209h)		;77b9   ; lee la ficha robada o tirada
	ld (de),a			;77bc
	ld hl,0c621h		;77bd   ; apunta a la mano de trabajo de 14 fichas ordenada
	call ordena_mano		;77c0   ; ordena_mano: ordena de menor a mayor las 14 fichas de HL
	ld hl,0cc80h		;77c3
	ld de,0cc81h		;77c6
	ld bc,0000eh		;77c9
	ld (hl),000h		;77cc
	ldir		;77ce
	ld hl,0c621h		;77d0   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld de,0cc80h		;77d3
	ld b,00eh		;77d6
L_77D8:
	ld a,(hl)			;77d8   ; cuenta las fichas iguales consecutivas en 0xCC80
	inc hl			;77d9
	cp (hl)			;77da
	jr nz,L_77E2		;77db
	ex de,hl			;77dd
	inc (hl)			;77de
	ex de,hl			;77df
	jr L_77E3		;77e0
L_77E2:
	inc de			;77e2
L_77E3:
	djnz L_77D8		;77e3
	ld hl,0cc80h		;77e5
	ld bc,00e00h		;77e8
L_77EB:
	ld a,(hl)			;77eb
	dec a			;77ec
	jr nz,L_77F0		;77ed
	inc c			;77ef
L_77F0:
	inc hl			;77f0   ; al acabar compara con el limite de parejas: A = 1 si llega
	djnz L_77EB		;77f1
	ld a,c			;77f3
	pop bc			;77f4
	cp c			;77f5
	ld a,001h		;77f6
	jr nc,L_77FB		;77f8
L_77FA:
	xor a			;77fa   ; descarta la mano de siete parejas: pone a cero el campo +0x70 de la mano
L_77FB:
	ld hl,(0c0deh)		;77fb   ; deja en +0x70 el resultado (A = 1 si lleva 4 o 5 parejas segun el nivel, 0 si no)
	ld de,00070h		;77fe
	add hl,de			;7801
	ld (hl),a			;7802
	ret			;7803

; ----------------------------------------------------------------------
; DATOS resto_7804: lo apuntan con el banco puesto p01:768A (0x7804), p01:766F
;   (0x780C), p01:7647 (0x7818), p01:764C (0x781C), p01:7681 (0x7838); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:768A, p01:766F, p01:7647, p01:764C, p01:7681 (72 bytes)
;   0x7804..0x784c  (72 bytes)
DATA_resto_7804:
	defb 0d5h,076h,0aeh,076h,034h,077h,004h,077h,000h,001h,002h,003h,000h,002h,001h,003h	; 7804  .v.v4w.w........
	defb 002h,001h,000h,003h,002h,000h,001h,003h,000h,001h,003h,002h,000h,002h,003h,001h	; 7814  ................
	defb 002h,000h,003h,001h,002h,001h,003h,000h,000h,003h,001h,002h,000h,003h,002h,001h	; 7824  ................
	defb 002h,003h,000h,001h,002h,003h,001h,000h,003h,000h,001h,002h,003h,000h,002h,001h	; 7834  ................
	defb 003h,002h,000h,001h,003h,002h,001h,000h	; 7844  ........

; ======================================================================
; CODIGO 0x784c..0x7ab9  (621 bytes)
; ======================================================================


analiza_palos:		; analiza los cuatro palos con la tabla del banco 15
	ld bc,00101h		;784c   ; analiza una por una las cuatro tablas de palo de la mano (+0x101, +0x111, +0x121 y +0x131) buscando grupos con la tabla de patrones del banco 15
	call L_787E		;784f   ; analiza un palo: pone a cero 0xC640, 0xC700 y el contador 0xC800, ordena el palo y mira cuantos numeros distintos tiene (0xC630)
	ld c,000h		;7852
	call L_7F11		;7854   ; pasa las combinaciones de 0xC800 a las tablas de la mano (+0x200 y +0x1C0) para este palo (C = base del palo)
	ld bc,00111h		;7857
	call L_787E		;785a   ; analiza un palo: pone a cero 0xC640, 0xC700 y el contador 0xC800, ordena el palo y mira cuantos numeros distintos tiene (0xC630)
	ld c,010h		;785d
	call L_7F11		;785f   ; pasa las combinaciones de 0xC800 a las tablas de la mano (+0x200 y +0x1C0) para este palo (C = base del palo)
	ld bc,00121h		;7862
	call L_787E		;7865   ; analiza un palo: pone a cero 0xC640, 0xC700 y el contador 0xC800, ordena el palo y mira cuantos numeros distintos tiene (0xC630)
	ld c,020h		;7868
	call L_7F11		;786a   ; pasa las combinaciones de 0xC800 a las tablas de la mano (+0x200 y +0x1C0) para este palo (C = base del palo)
	ld bc,00131h		;786d
	ld hl,(0c0deh)		;7870   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;7873
	call L_7A1C		;7874   ; cuenta cuantas fichas de cada numero hay: deja en 0xC638 una mascara de 9 bits por palo (un bit por numero)
	call L_7A7D		;7877   ; de la mascara de 0xC63C saca la lista de numeros presentes en 0xC631 y su cuenta en 0xC630
	call L_7FEF		;787a   ; si 0xC630 es cero no hace nada; si no, pone a cero 3 bytes de 0xCC80
	ret			;787d
L_787E:
	push bc			;787e   ; analiza un palo: pone a cero 0xC640, 0xC700 y el contador 0xC800, ordena el palo y mira cuantos numeros distintos tiene (0xC630)
	call L_7997		;787f   ; pone a cero 0xC640 (5 bytes)
	call L_79A4		;7882   ; pone a cero 0xC700 (256 bytes)
	xor a			;7885
	ld (0c800h),a		;7886   ; guarda las combinaciones que prueba la maquina
	pop bc			;7889
	ld hl,(0c0deh)		;788a   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,bc			;788d
	call L_7A1C		;788e   ; cuenta cuantas fichas de cada numero hay: deja en 0xC638 una mascara de 9 bits por palo (un bit por numero)
	call L_7A7D		;7891   ; de la mascara de 0xC63C saca la lista de numeros presentes en 0xC631 y su cuenta en 0xC630
	ld a,(0c630h)		;7894
	and a			;7897
	jr z,L_78C8		;7898
	call L_7AAC		;789a   ; elige de la tabla 0x7AB9 las 8 combinaciones que se prueban segun cuantos numeros hay
L_789D:
	xor a			;789d   ; por cada patron posible: deja la mano de 0xC621 en 0xC540, pasa la combinacion a 0xC640 y quita sus fichas
	ld (0c635h),a		;789e
	push bc			;78a1
	push hl			;78a2
	push hl			;78a3
	call L_78F8		;78a4   ; copia la mano de 0xC621 a 0xC540 (14 bytes)
	pop hl			;78a7
	call L_7997		;78a8   ; pone a cero 0xC640 (5 bytes)
	call L_79B2		;78ab   ; el nibble alto del patron es cuantas fichas lleva
	call L_79D3		;78ae   ; quita de la mano (0xC621) las fichas de la combinacion de 0xC640 (en la mano de 14 fichas) y deja la mano sin huecos
	call L_7B3D		;78b1   ; ordena las combinaciones y las pone en 0xC801 con las fichas que sobran (bit 6)
	call L_7904		;78b4   ; devuelve la mano de 0xC540 a 0xC621
	pop hl			;78b7
	inc hl			;78b8
	inc hl			;78b9
	inc hl			;78ba
	inc hl			;78bb
	pop bc			;78bc
	djnz L_789D		;78bd
	ld a,(0c635h)		;78bf
	and a			;78c2
	call nz,L_78D6		;78c3   ; guarda en la lista de combinaciones de 0xC800 (cuatro bytes cada una) la que se acaba de probar; el bit 6 marca las que son de ficha sola
	jr L_78CF		;78c6
L_78C8:
	call L_7B3D		;78c8   ; ordena las combinaciones y las pone en 0xC801 con las fichas que sobran (bit 6)
	xor a			;78cb
	ld (0c635h),a		;78cc
L_78CF:
	call L_7910		;78cf   ; ordena y pasa por 0xCC80 cada combinacion de 0xC800 (resta 1, ordena, suma 1)
	call L_795A		;78d2   ; quita de 0xC800 las combinaciones repetidas
	ret			;78d5
L_78D6:
	ld hl,0c800h		;78d6   ; guarda en la lista de combinaciones de 0xC800 (cuatro bytes cada una) la que se acaba de probar; el bit 6 marca las que son de ficha sola
	ld a,(hl)			;78d9
	inc (hl)			;78da
	add a,a			;78db
	add a,a			;78dc
	ld de,0c801h		;78dd
	call 04061h		;78e0   ; suma_a_de: DE = DE + A
	ld hl,0c640h		;78e3
	ld c,(hl)			;78e6
	inc hl			;78e7
	ld b,004h		;78e8
L_78EA:
	ld a,c			;78ea   ; completa el bloque de cuatro con las fichas de 0xC640, poniendo el bit 6 en las que ya estaban
	and a			;78eb
	jr z,L_78F2		;78ec
	dec c			;78ee
	ld a,(hl)			;78ef
	or 040h		;78f0
L_78F2:
	ld (de),a			;78f2
	inc hl			;78f3
	inc de			;78f4
	djnz L_78EA		;78f5
	ret			;78f7
L_78F8:
	ld hl,0c621h		;78f8   ; copia la mano de 0xC621 a 0xC540 (14 bytes)
	ld de,0c540h		;78fb
	ld bc,0000eh		;78fe
	ldir		;7901
	ret			;7903
L_7904:
	ld de,0c621h		;7904   ; devuelve la mano de 0xC540 a 0xC621
	ld hl,0c540h		;7907
	ld bc,0000eh		;790a
	ldir		;790d
	ret			;790f
L_7910:
	ld hl,0c800h		;7910   ; ordena y pasa por 0xCC80 cada combinacion de 0xC800 (resta 1, ordena, suma 1)
	ld a,(hl)			;7913
	and a			;7914
	ret z			;7915
	inc hl			;7916
	ld b,a			;7917
L_7918:
	push bc			;7918
	push hl			;7919
	call L_7940		;791a
	call L_7928		;791d   ; ordena de menor a mayor los cuatro bytes de 0xCC80 (burbuja)
	pop hl			;7920
	call L_794D		;7921
	pop bc			;7924
	djnz L_7918		;7925
	ret			;7927
L_7928:
	ld b,004h		;7928   ; ordena de menor a mayor los cuatro bytes de 0xCC80 (burbuja)
L_792A:
	ld d,b			;792a
	ld hl,0cc80h		;792b
	ld b,003h		;792e
L_7930:
	ld c,(hl)			;7930   ; un paso de la ordenacion de los cuatro bytes: si el siguiente es menor los cambia
	inc hl			;7931
	ld a,(hl)			;7932
	cp c			;7933
	jr nc,L_793A		;7934
	ld (hl),c			;7936
	dec hl			;7937
	ld (hl),a			;7938
	inc hl			;7939
L_793A:
	djnz L_7930		;793a
	ld b,d			;793c
	djnz L_792A		;793d
	ret			;793f
L_7940:
	ld b,004h		;7940
	ld de,0cc80h		;7942
L_7945:
	ld a,(hl)			;7945   ; resta uno a cada uno de los cuatro bytes de la combinacion
	dec a			;7946
	ld (de),a			;7947
	inc hl			;7948
	inc de			;7949
	djnz L_7945		;794a
	ret			;794c
L_794D:
	ld b,004h		;794d
	ld de,0cc80h		;794f
L_7952:
	ld a,(de)			;7952   ; suma uno a cada uno de los cuatro bytes
	inc a			;7953
	ld (hl),a			;7954
	inc hl			;7955
	inc de			;7956
	djnz L_7952		;7957
	ret			;7959
L_795A:
	ld hl,0c800h		;795a   ; quita de 0xC800 las combinaciones repetidas
	ld a,(hl)			;795d
	and a			;795e
	ret z			;795f
	ld b,a			;7960
	inc hl			;7961
L_7962:
	push bc			;7962   ; copia la combinacion B a 0xCC80 para compararla con las siguientes
	ld a,b			;7963
	ld de,0cc80h		;7964
	ld bc,00004h		;7967
	ldir		;796a
	dec a			;796c
	ld b,a			;796d
	push hl			;796e
L_796F:
	push bc			;796f
	push hl			;7970
	ld b,004h		;7971
	ld de,0cc80h		;7973
L_7976:
	ld a,(de)			;7976   ; compara cuatro bytes con la siguiente combinacion
	cp (hl)			;7977
	jr nz,L_798A		;7978
	inc de			;797a
	inc hl			;797b
	djnz L_7976		;797c
	pop hl			;797e   ; si son iguales borra la repetida (4 bytes a cero)
	push hl			;797f
	ld d,h			;7980
	ld e,l			;7981
	inc de			;7982
	ld (hl),000h		;7983
	ld bc,00003h		;7985
	ldir		;7988
L_798A:
	pop hl			;798a   ; pasa a la siguiente combinacion
	inc hl			;798b
	inc hl			;798c
	inc hl			;798d
	inc hl			;798e
	pop bc			;798f
	djnz L_796F		;7990
	pop hl			;7992   ; recupera el puntero a la lista de combinaciones
	pop bc			;7993
	djnz L_7962		;7994
	ret			;7996
L_7997:
	push hl			;7997   ; pone a cero 0xC640 (5 bytes)
	ld hl,0c640h		;7998
	ld b,005h		;799b
L_799D:
	ld (hl),000h		;799d
	inc hl			;799f
	djnz L_799D		;79a0
	pop hl			;79a2
	ret			;79a3
L_79A4:
	ld hl,0c700h		;79a4   ; pone a cero 0xC700 (256 bytes)
	ld de,0c701h		;79a7
	ld bc,000ffh		;79aa
	ld (hl),000h		;79ad
	ldir		;79af
	ret			;79b1
L_79B2:
	ld a,(hl)			;79b2   ; el nibble alto del patron es cuantas fichas lleva
	and 0f0h		;79b3
	ret z			;79b5
	rrca			;79b6
	rrca			;79b7
	rrca			;79b8
	rrca			;79b9
	ld de,0c640h		;79ba
	ld (de),a			;79bd   ; guarda en 0xC640 cuantas fichas lleva
	inc de			;79be
	ld b,a			;79bf
L_79C0:
	push hl			;79c0   ; cada ficha del patron sale de la tabla 0xC631 por su numero
	ld a,(hl)			;79c1
	and 00fh		;79c2
	dec a			;79c4
	ld hl,0c631h		;79c5
	call 0405ch		;79c8   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;79cb
	ld (de),a			;79cc
	pop hl			;79cd
	inc hl			;79ce
	inc de			;79cf
	djnz L_79C0		;79d0
	ret			;79d2
L_79D3:
	ld hl,0c640h		;79d3   ; quita de la mano (0xC621) las fichas de la combinacion de 0xC640 (en la mano de 14 fichas) y deja la mano sin huecos
	ld a,(hl)			;79d6
	and a			;79d7
	ret z			;79d8
	ld b,a			;79d9
	inc hl			;79da
L_79DB:
	push bc			;79db
	ld bc,00e04h		;79dc
	ld de,0c621h		;79df   ; apunta a la mano de trabajo de 14 fichas ordenada
L_79E2:
	ld a,(de)			;79e2   ; quita de la mano la ficha del patron si coincide
	cp (hl)			;79e3
	jr nz,L_79EB		;79e4
	dec c			;79e6
	jr z,L_79EE		;79e7
	xor a			;79e9
	ld (de),a			;79ea
L_79EB:
	inc de			;79eb
	djnz L_79E2		;79ec
L_79EE:
	inc hl			;79ee   ; al acabar las quita y deja la mano sin huecos
	pop bc			;79ef
	djnz L_79DB		;79f0
	ld hl,0cc80h		;79f2
	ld de,0cc81h		;79f5
	ld bc,0000dh		;79f8
	ld (hl),000h		;79fb
	ldir		;79fd
	ld hl,0c621h		;79ff   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld de,0cc80h		;7a02
	ld b,00eh		;7a05
L_7A07:
	ld a,(hl)			;7a07
	and a			;7a08
	jr z,L_7A0D		;7a09
	ld (de),a			;7a0b
	inc de			;7a0c
L_7A0D:
	inc hl			;7a0d
	djnz L_7A07		;7a0e
	ld hl,0cc80h		;7a10
	ld de,0c621h		;7a13   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000eh		;7a16
	ldir		;7a19
	ret			;7a1b
L_7A1C:
	call L_7A53		;7a1c   ; cuenta cuantas fichas de cada numero hay: deja en 0xC638 una mascara de 9 bits por palo (un bit por numero)
L_7A1F:
	ld hl,0c638h		;7a1f
	ld de,0c639h		;7a22
	ld (hl),000h		;7a25
	ld bc,00007h		;7a27
	ldir		;7a2a
	ld hl,0c621h		;7a2c   ; apunta a la mano de trabajo de 14 fichas ordenada
L_7A2F:
	ld a,(hl)			;7a2f   ; primera ficha de la mano de trabajo: si es cero acaba
	and a			;7a30
	ret z			;7a31
	ld de,0c638h		;7a32
	ld a,(hl)			;7a35   ; el numero 9 pasa a la segunda mascara
	cp 009h		;7a36
	jr nz,L_7A3B		;7a38
	inc de			;7a3a
L_7A3B:
	dec a			;7a3b
	ld b,a			;7a3c
	ld a,001h		;7a3d
	jr z,L_7A44		;7a3f
L_7A41:
	rlca			;7a41
	djnz L_7A41		;7a42
L_7A44:
	ld c,a			;7a44
L_7A45:
	ld a,(de)			;7a45   ; busca la mascara libre
	and c			;7a46
	jr z,L_7A4D		;7a47
	inc de			;7a49
	inc de			;7a4a
	jr L_7A45		;7a4b
L_7A4D:
	ld a,(de)			;7a4d
	or c			;7a4e
	ld (de),a			;7a4f
	inc hl			;7a50
	jr L_7A2F		;7a51
L_7A53:
	push hl			;7a53   ; copia la mano de HL a 0xC620/0xC621: el primer byte es el palo (bits 4-5), luego los numeros sin los bits de honor
	ld hl,0c620h		;7a54   ; apunta a cuantas fichas hay en la mano de trabajo
	ld de,0c621h		;7a57   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000eh		;7a5a
	ld (hl),000h		;7a5d
	ldir		;7a5f
	pop hl			;7a61
	ld de,0c620h		;7a62   ; apunta a cuantas fichas hay en la mano de trabajo
	ld a,(hl)			;7a65
	and 030h		;7a66
	rrca			;7a68
	rrca			;7a69
	rrca			;7a6a
	rrca			;7a6b
	ld (de),a			;7a6c
	inc de			;7a6d
L_7A6E:
	ld a,(hl)			;7a6e   ; copia el numero de cada ficha que no es de grupo
	and a			;7a6f
	ret z			;7a70
	and 0c0h		;7a71
	jr nz,L_7A7A		;7a73
	ld a,(hl)			;7a75
	and 00fh		;7a76
	ld (de),a			;7a78
	inc de			;7a79
L_7A7A:
	inc hl			;7a7a
	jr L_7A6E		;7a7b
L_7A7D:
	ld hl,0c630h		;7a7d   ; de la mascara de 0xC63C saca la lista de numeros presentes en 0xC631 y su cuenta en 0xC630
	ld de,0c631h		;7a80
	ld bc,00007h		;7a83
	ld (hl),000h		;7a86
	ldir		;7a88
	ld hl,0c631h		;7a8a
	ld de,(0c63ch)		;7a8d
	rr d		;7a91
	ld bc,00900h		;7a93
	ld a,e			;7a96
L_7A97:
	rra			;7a97   ; por cada numero con su bit puesto lo anota en la lista
	jr nc,L_7AA5		;7a98
	push af			;7a9a
	ld a,b			;7a9b
	sub 009h		;7a9c   ; el numero va de 1 a 9
	neg		;7a9e
	inc a			;7aa0
	ld (hl),a			;7aa1
	inc hl			;7aa2
	inc c			;7aa3
	pop af			;7aa4
L_7AA5:
	djnz L_7A97		;7aa5
	ld a,c			;7aa7
	ld (0c630h),a		;7aa8
	ret			;7aab
L_7AAC:
	ld a,(0c630h)		;7aac   ; elige de la tabla 0x7AB9 las 8 combinaciones que se prueban segun cuantos numeros hay
	dec a			;7aaf
	ld hl,07ab9h		;7ab0
	call 04d07h		;7ab3   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld b,(hl)			;7ab6
	inc hl			;7ab7
	ret			;7ab8

; ----------------------------------------------------------------------
; DATOS resto_7AB9: lo apuntan con el banco puesto p01:7AB0 (0x7AB9); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:7AB0 (132 bytes)
;   0x7ab9..0x7b3d  (132 bytes)
DATA_resto_7AB9:
	defb 0c1h,07ah,0cah,07ah,0dbh,07ah,0fch,07ah,002h,000h,000h,000h,000h,011h,000h,000h	; 7ab9  .z.z.z.z........
	defb 000h,004h,000h,000h,000h,000h,011h,000h,000h,000h,012h,000h,000h,000h,021h,002h	; 7ac9  ..............!.
	defb 000h,000h,008h,000h,000h,000h,000h,011h,000h,000h,000h,012h,000h,000h,000h,013h	; 7ad9  ................
	defb 000h,000h,000h,021h,002h,000h,000h,021h,003h,000h,000h,022h,003h,000h,000h,031h	; 7ae9  ...!...!..."...1
	defb 002h,003h,000h,010h,000h,000h,000h,000h,011h,000h,000h,000h,012h,000h,000h,000h	; 7af9  ................
	defb 013h,000h,000h,000h,014h,000h,000h,000h,021h,002h,000h,000h,021h,003h,000h,000h	; 7b09  ........!...!...
	defb 021h,004h,000h,000h,022h,003h,000h,000h,022h,004h,000h,000h,023h,004h,000h,000h	; 7b19  !..."..."...#...
	defb 031h,002h,003h,000h,031h,002h,004h,000h,031h,003h,004h,000h,032h,003h,004h,000h	; 7b29  1...1...1...2...
	defb 041h,002h,003h,004h	; 7b39

; ======================================================================
; CODIGO 0x7b3d..0x7fff  (1218 bytes)
; ======================================================================


L_7B3D:
	call L_7A1F		;7b3d   ; ordena las combinaciones y las pone en 0xC801 con las fichas que sobran (bit 6)
	call L_7B7D		;7b40   ; pasa por las tres rutinas siguientes: 7BE6, 7B87 y 7C67
	ld a,(0c800h)		;7b43   ; lee las combinaciones que prueba la maquina
	and a			;7b46
	ret z			;7b47
	ld bc,(0c648h)		;7b48
	ld a,b			;7b4c
	and a			;7b4d
	ret z			;7b4e
	ld a,c			;7b4f
	ld h,000h		;7b50
	ld l,a			;7b52
	add hl,hl			;7b53
	add hl,hl			;7b54
	ld de,0c801h		;7b55
	add hl,de			;7b58
	ld de,0c640h		;7b59
	ld a,(de)			;7b5c
	ld c,a			;7b5d
	and a			;7b5e
	ret z			;7b5f
	inc de			;7b60
L_7B61:
	push hl			;7b61
	push de			;7b62
	push bc			;7b63
L_7B64:
	ld a,(hl)			;7b64
	and a			;7b65
	jr z,L_7B6B		;7b66
	inc hl			;7b68
	jr L_7B64		;7b69
L_7B6B:
	ld a,(de)			;7b6b   ; pone el bit 6 a las fichas de la combinacion
	or 040h		;7b6c
	ld (hl),a			;7b6e
	dec c			;7b6f
	inc de			;7b70
	jr nz,L_7B64		;7b71
	pop bc			;7b73   ; recupera la cuenta de fichas y el puntero
	pop de			;7b74
	pop hl			;7b75
	inc hl			;7b76
	inc hl			;7b77
	inc hl			;7b78
	inc hl			;7b79
	djnz L_7B61		;7b7a   ; siguiente combinacion (4 bytes)
	ret			;7b7c
L_7B7D:
	call L_7BE6		;7b7d   ; pasa por las tres rutinas siguientes: 7BE6, 7B87 y 7C67
	call L_7B87		;7b80   ; mira las 4 mascaras de 0xC638 contra la tabla 0xA306 del banco 15 (44 patrones) y copia los grupos de la tabla 0xA35C a 0xC700
	call L_7C67		;7b83   ; busca para los cuatro bloques de 0xC700 su combinacion con las tablas 0xA589 y 0xA5D7 (banco 15)
	ret			;7b86
L_7B87:
	call L_79A4		;7b87   ; mira las 4 mascaras de 0xC638 contra la tabla 0xA306 del banco 15 (44 patrones) y copia los grupos de la tabla 0xA35C a 0xC700
	call 0424bh		;7b8a   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	ld hl,0c638h		;7b8d
	ld b,004h		;7b90
L_7B92:
	ld (0cc80h),hl		;7b92   ; lee la mascara de 9 bits del palo (dos bytes): si es cero acaba y vuelve a los bancos del juego
	ld e,(hl)			;7b95
	inc hl			;7b96
	ld d,(hl)			;7b97
	ld a,d			;7b98
	or e			;7b99
	jp z,04207h		;7b9a   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	inc hl			;7b9d
	push hl			;7b9e
	push bc			;7b9f
	ld bc,02b00h		;7ba0
L_7BA3:
	ld a,c			;7ba3
	ld hl,0a306h		;7ba4
	call 04d07h		;7ba7   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	or a			;7baa
	sbc hl,de		;7bab
	jr z,L_7BB4		;7bad
	inc c			;7baf
	djnz L_7BA3		;7bb0
	jr L_7BB7		;7bb2
L_7BB4:
	call L_7BBF		;7bb4   ; copia el grupo de patrones de la tabla 0xA35C a 0xC700 + 0x20 x el palo
L_7BB7:
	pop bc			;7bb7
	pop hl			;7bb8
	djnz L_7B92		;7bb9
	call 04207h		;7bbb   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ret			;7bbe
L_7BBF:
	ld a,(0cc80h)		;7bbf   ; copia el grupo de patrones de la tabla 0xA35C a 0xC700 + 0x20 x el palo
	and 007h		;7bc2
	ld l,a			;7bc4
	ld h,000h		;7bc5
	add hl,hl			;7bc7
	add hl,hl			;7bc8
	add hl,hl			;7bc9
	add hl,hl			;7bca
	add hl,hl			;7bcb
	ld de,0c700h		;7bcc
	add hl,de			;7bcf
	ex de,hl			;7bd0
	ld a,c			;7bd1
	ld hl,0a35ch		;7bd2
	call 04d07h		;7bd5   ; HL = el bloque de patrones de esa clave
	ld a,(hl)			;7bd8
	ld (de),a			;7bd9
	inc de			;7bda
	inc hl			;7bdb
	add a,a			;7bdc   ; cada dato de patron ocupa cuatro bytes
	add a,a			;7bdd
	ld b,a			;7bde
L_7BDF:
	ld a,(hl)			;7bdf   ; copia los bytes del patron
	ld (de),a			;7be0
	inc de			;7be1
	inc hl			;7be2
	djnz L_7BDF		;7be3
	ret			;7be5
L_7BE6:
	ld b,004h		;7be6   ; prepara de cada mascara 0xC638 las cuentas de fichas seguidas (de 3 y mas)
	ld hl,0c638h		;7be8
L_7BEB:
	ld e,(hl)			;7beb   ; lee la mascara de cada palo y la pasa a una cuenta de bits seguidos
	inc hl			;7bec
	ld d,(hl)			;7bed
	ld a,d			;7bee
	or e			;7bef
	ret z			;7bf0
	dec hl			;7bf1
	rr d		;7bf2   ; pasa a la siguiente mascara
	ld a,e			;7bf4
	exx			;7bf5
	ld bc,00900h		;7bf6
	ld hl,0cc80h		;7bf9   ; los nueve numeros en 0xCC80
L_7BFC:
	rra			;7bfc
	inc c			;7bfd
	jr c,L_7C02		;7bfe
	ld c,000h		;7c00
L_7C02:
	ld (hl),c			;7c02
	inc hl			;7c03
	djnz L_7BFC		;7c04
	call L_7C26		;7c06   ; quita de las cuentas las que no llegan a tres fichas seguidas en los bordes
	ld hl,0cc88h		;7c09
	ld bc,00900h		;7c0c
L_7C0F:
	ld a,(hl)			;7c0f
	and a			;7c10
	jr z,L_7C14		;7c11
	scf			;7c13
L_7C14:
	rl c		;7c14   ; deja en el resultado el patron de los numeros con cuenta
	dec hl			;7c16
	djnz L_7C0F		;7c17
	ld a,c			;7c19   ; la cuenta resultante
	exx			;7c1a
	ld c,000h		;7c1b
	rl c		;7c1d   ; la guarda con su acarreo
	ld (hl),a			;7c1f
	inc hl			;7c20
	ld (hl),c			;7c21
	inc hl			;7c22
	djnz L_7BEB		;7c23
	ret			;7c25
L_7C26:
	ld hl,0cc80h		;7c26   ; quita de las cuentas las que no llegan a tres fichas seguidas en los bordes
	ld bc,00900h		;7c29
L_7C2C:
	push bc			;7c2c   ; quita los extremos que no llegan a tres seguidos
	push hl			;7c2d
	ld a,b			;7c2e
	cp 009h		;7c2f
	jr z,L_7C46		;7c31
	ld a,(hl)			;7c33
	and a			;7c34
	jr nz,L_7C46		;7c35
	dec hl			;7c37
	ld a,(hl)			;7c38
	and a			;7c39
	jr z,L_7C46		;7c3a
	cp 003h		;7c3c   ; si la cuenta es menor de 3 la borra
	jr nc,L_7C46		;7c3e
	ld b,a			;7c40   ; quita ese numero de la lista
L_7C41:
	ld (hl),000h		;7c41
	dec hl			;7c43
	djnz L_7C41		;7c44
L_7C46:
	pop hl			;7c46   ; mira el otro extremo
	pop bc			;7c47
	push hl			;7c48
	ld a,b			;7c49
	dec a			;7c4a
	jr nz,L_7C62		;7c4b
	ld a,(hl)			;7c4d   ; mira el extremo opuesto
	and a			;7c4e
	jr nz,L_7C56		;7c4f
	dec hl			;7c51   ; y el vecino
	ld a,(hl)			;7c52
	and a			;7c53
	jr z,L_7C62		;7c54
L_7C56:
	cp 003h		;7c56   ; limpia la cuenta de dos
	jr nc,L_7C62		;7c58
	dec a			;7c5a
	jr z,L_7C60		;7c5b
	ld (hl),000h		;7c5d
	dec hl			;7c5f
L_7C60:
	ld (hl),000h		;7c60
L_7C62:
	pop hl			;7c62
	inc hl			;7c63
	djnz L_7C2C		;7c64
	ret			;7c66
L_7C67:
	ld hl,0c550h		;7c67   ; busca para los cuatro bloques de 0xC700 su combinacion con las tablas 0xA589 y 0xA5D7 (banco 15)
	ld de,0c551h		;7c6a
	ld bc,00017h		;7c6d
	ld (hl),000h		;7c70
	ldir		;7c72
	ld a,(0c800h)		;7c74   ; lee las combinaciones que prueba la maquina
	ld (0c648h),a		;7c77
	xor a			;7c7a
	ld (0c649h),a		;7c7b
	ld de,0c700h		;7c7e
	ld hl,0c564h		;7c81
	ld b,004h		;7c84
L_7C86:
	ld a,(de)			;7c86   ; los cuatro grupos de 0xC700: mete en 0xC564 su primer byte; si no hay ninguno 0xC635 = 1
	and a			;7c87
	jr z,L_7C93		;7c88
	ld (hl),a			;7c8a
	ld a,040h		;7c8b
	call 04061h		;7c8d   ; suma_a_de: DE = DE + A
	inc hl			;7c90
	djnz L_7C86		;7c91
L_7C93:
	ld a,b			;7c93   ; si no hay ninguno de los cuatro, avisa en 0xC635
	cp 004h		;7c94
	jr nz,L_7C9E		;7c96
	ld a,001h		;7c98
	ld (0c635h),a		;7c9a
	ret			;7c9d
L_7C9E:
	ld hl,0c564h		;7c9e   ; junta en D y E las parejas de nibbles de los cuatro grupos
	ld a,(hl)			;7ca1
	rlca			;7ca2
	rlca			;7ca3
	rlca			;7ca4
	rlca			;7ca5
	inc hl			;7ca6
	or (hl)			;7ca7
	ld d,a			;7ca8
	inc hl			;7ca9
	ld a,(hl)			;7caa
	rlca			;7cab
	rlca			;7cac
	rlca			;7cad
	rlca			;7cae
	inc hl			;7caf
	or (hl)			;7cb0
	ld e,a			;7cb1
	call 0424bh		;7cb2   ; pone el banco 15 y busca el par en la tabla 0xA589
	ld b,000h		;7cb5
L_7CB7:
	ld a,b			;7cb7
	ld hl,0a589h		;7cb8
	call 04d07h		;7cbb   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	or a			;7cbe
	sbc hl,de		;7cbf
	jr z,L_7CC6		;7cc1
	inc b			;7cc3
	jr L_7CB7		;7cc4
L_7CC6:
	ld a,b			;7cc6
	ld hl,0a5d7h		;7cc7
	call 04d07h		;7cca   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld a,(0c800h)		;7ccd   ; lee las combinaciones que prueba la maquina
	ld c,a			;7cd0
	add a,(hl)			;7cd1
	ld (0c800h),a		;7cd2   ; guarda las combinaciones que prueba la maquina
	ld a,(0c649h)		;7cd5
	add a,(hl)			;7cd8
	ld (0c649h),a		;7cd9
	ld b,(hl)			;7cdc
	push hl			;7cdd
	ld h,000h		;7cde
	ld l,c			;7ce0
	add hl,hl			;7ce1
	add hl,hl			;7ce2
	ld de,0c801h		;7ce3
	add hl,de			;7ce6
	pop de			;7ce7
	inc de			;7ce8
L_7CE9:
	push bc			;7ce9
	push de			;7cea
	ld (0c64ah),hl		;7ceb
	ld hl,0c701h		;7cee
	ld bc,00400h		;7cf1
L_7CF4:
	ld a,(de)			;7cf4
	and a			;7cf5
	jr z,L_7D1B		;7cf6
	push bc			;7cf8
	push de			;7cf9
	push hl			;7cfa
	dec a			;7cfb
	add a,a			;7cfc
	add a,a			;7cfd
	call 0405ch		;7cfe   ; suma_a_hl: HL = HL + A
	ld a,c			;7d01
	add a,a			;7d02
	add a,a			;7d03
	ld de,0c550h		;7d04
	call 04061h		;7d07   ; suma_a_de: DE = DE + A
	ld bc,00004h		;7d0a
	ldir		;7d0d
	pop hl			;7d0f
	pop de			;7d10
	pop bc			;7d11
	inc c			;7d12
	inc de			;7d13
	ld a,040h		;7d14
	call 0405ch		;7d16   ; suma_a_hl: HL = HL + A
	djnz L_7CF4		;7d19
L_7D1B:
	ld hl,(0c64ah)		;7d1b   ; pone a cero la combinacion y copia 0xC550
	ld d,h			;7d1e
	ld e,l			;7d1f
	inc de			;7d20
	ld bc,00003h		;7d21
	ld (hl),000h		;7d24
	ldir		;7d26
	ld hl,(0c64ah)		;7d28
	ld de,0c550h		;7d2b
	ld bc,01004h		;7d2e
L_7D31:
	ld a,(de)			;7d31   ; copia los cuatro bytes que no son cero
	and a			;7d32
	jr z,L_7D3A		;7d33
	ld (hl),a			;7d35
	inc hl			;7d36
	dec c			;7d37
	jr z,L_7D3D		;7d38
L_7D3A:
	inc de			;7d3a
	djnz L_7D31		;7d3b
L_7D3D:
	call L_7D56		;7d3d   ; prueba la primera pasada de las combinaciones y la segunda (7D7B)
	call L_7D7B		;7d40
	ld hl,(0c64ah)		;7d43
	inc hl			;7d46
	inc hl			;7d47
	inc hl			;7d48
	inc hl			;7d49
	pop de			;7d4a
	inc de			;7d4b
	inc de			;7d4c
	inc de			;7d4d
	inc de			;7d4e
	pop bc			;7d4f
	djnz L_7CE9		;7d50
	call 04207h		;7d52   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ret			;7d55
L_7D56:
	call L_7EE1		;7d56   ; prueba la primera pasada de las combinaciones y la segunda (7D7B)
	call L_7EF9		;7d59   ; guarda 0xC638 en 0xC520 (8 bytes)
	ld hl,(0c64ah)		;7d5c
	call L_7E7F		;7d5f   ; quita de la mano las fichas de las cuatro casillas de HL
	call L_7EB7		;7d62   ; deja la mano de 0xC621 sin huecos
	call L_7A1F		;7d65
	call L_7BE6		;7d68   ; prepara de cada mascara 0xC638 las cuentas de fichas seguidas (de 3 y mas)
	ld bc,(0c638h)		;7d6b
	ld a,b			;7d6f
	or c			;7d70
	call nz,L_7DDF		;7d71   ; dibuja con las tablas 0xA306 y 0xA35C las combinaciones por palo
	call L_7EED		;7d74   ; devuelve la mano de 0xC530 a 0xC621
	call L_7F05		;7d77   ; devuelve 0xC520 a 0xC638
	ret			;7d7a
L_7D7B:
	call L_7EE1		;7d7b   ; guarda la mano de 0xC621 en 0xC530
	call L_7EF9		;7d7e   ; guarda 0xC638 en 0xC520 (8 bytes)
	ld hl,(0c64ah)		;7d81
	call L_7E7F		;7d84   ; quita de la mano las fichas de las cuatro casillas de HL
	call L_7EB7		;7d87   ; deja la mano de 0xC621 sin huecos
	call L_7A1F		;7d8a
	ld bc,(0c63ch)		;7d8d
	ld a,b			;7d91
	or c			;7d92
	call nz,L_7D9D		;7d93   ; pone a cero 0xC568 y toma la mascara de 0xC63C
	call L_7EED		;7d96   ; devuelve la mano de 0xC530 a 0xC621
	call L_7F05		;7d99   ; devuelve 0xC520 a 0xC638
	ret			;7d9c
L_7D9D:
	ld hl,0c568h		;7d9d   ; pone a cero 0xC568 y toma la mascara de 0xC63C
	ld de,0c569h		;7da0
	ld bc,00003h		;7da3
	ld (hl),000h		;7da6
	ldir		;7da8
	ld de,(0c63ch)		;7daa
	rr d		;7dae   ; pasa el bit mas bajo de la mascara al acarreo
	ld a,e			;7db0
	ld bc,00941h		;7db1   ; B = 9 numeros, C = 0x41
	ld hl,0c568h		;7db4
	ld d,000h		;7db7
L_7DB9:
	rra			;7db9
	jr nc,L_7DBF		;7dba
	ld (hl),c			;7dbc
	inc hl			;7dbd
	inc d			;7dbe
L_7DBF:
	inc c			;7dbf   ; cuenta cuantos numeros hay en D
	djnz L_7DB9		;7dc0
	ld a,d			;7dc2
	and a			;7dc3
	ret z			;7dc4
	ld b,a			;7dc5
	ld c,000h		;7dc6
L_7DC8:
	ld hl,(0c64ah)		;7dc8
L_7DCB:
	ld a,(hl)			;7dcb
	and a			;7dcc
	jr z,L_7DD2		;7dcd
	inc hl			;7dcf
	jr L_7DCB		;7dd0
L_7DD2:
	ld a,c			;7dd2
	ld de,0c568h		;7dd3
	call 04061h		;7dd6   ; suma_a_de: DE = DE + A
	ld a,(de)			;7dd9
	ld (hl),a			;7dda
	inc c			;7ddb
	djnz L_7DC8		;7ddc
	ret			;7dde
L_7DDF:
	call 0424bh		;7ddf   ; dibuja con las tablas 0xA306 y 0xA35C las combinaciones por palo
	ld hl,(0c64ah)		;7de2
	ld de,0c56ch		;7de5
	ld bc,00004h		;7de8
	ldir		;7deb
	ld de,(0c638h)		;7ded
	ld c,000h		;7df1
L_7DF3:
	ld a,c			;7df3
	ld hl,0a306h		;7df4
	call 04d07h		;7df7   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	or a			;7dfa
	sbc hl,de		;7dfb
	jr z,L_7E02		;7dfd
	inc c			;7dff
	jr L_7DF3		;7e00
L_7E02:
	ld a,c			;7e02
	ld hl,0a35ch		;7e03
	call 04d07h		;7e06   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld b,(hl)			;7e09
	inc hl			;7e0a
	ld c,000h		;7e0b
L_7E0D:
	push bc			;7e0d
	ld a,c			;7e0e
	and a			;7e0f
	push hl			;7e10
	call nz,L_7E5D		;7e11   ; abre una combinacion nueva en 0xC800 y copia 0xC56C
	pop hl			;7e14
	ld d,(hl)			;7e15
	inc hl			;7e16
	ld e,(hl)			;7e17
	inc hl			;7e18
	ld a,(hl)			;7e19
	inc hl			;7e1a
	push hl			;7e1b
	ld l,(hl)			;7e1c
	ld h,a			;7e1d
	call L_7E2B		;7e1e   ; mete las cuatro fichas del grupo en 0xC64A (una por casilla libre)
	pop hl			;7e21
	inc hl			;7e22
	pop bc			;7e23
	inc c			;7e24
	djnz L_7E0D		;7e25
	call 04207h		;7e27   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ret			;7e2a
L_7E2B:
	push hl			;7e2b   ; mete las cuatro fichas del grupo en 0xC64A (una por casilla libre)
	push de			;7e2c
	call L_7E4E		;7e2d   ; mete D en la primera casilla libre de las cuatro de 0xC64A
	pop de			;7e30
	pop hl			;7e31
	ld a,e			;7e32
	and a			;7e33
	ret z			;7e34
	push hl			;7e35
	ld d,a			;7e36
	call L_7E4E		;7e37   ; mete D en la primera casilla libre de las cuatro de 0xC64A
	pop hl			;7e3a
	ld a,h			;7e3b
	and a			;7e3c
	ret z			;7e3d
	push hl			;7e3e
	ld d,a			;7e3f
	call L_7E4E		;7e40   ; mete D en la primera casilla libre de las cuatro de 0xC64A
	pop hl			;7e43
	ld a,l			;7e44
	and a			;7e45
	ret z			;7e46
	push hl			;7e47
	ld d,a			;7e48
	call L_7E4E		;7e49   ; mete D en la primera casilla libre de las cuatro de 0xC64A
	pop hl			;7e4c
	ret			;7e4d
L_7E4E:
	ld hl,(0c64ah)		;7e4e   ; mete D en la primera casilla libre de las cuatro de 0xC64A
	ld b,004h		;7e51
L_7E53:
	ld a,(hl)			;7e53   ; busca la primera casilla libre de los cuatro
	and a			;7e54
	jr z,L_7E5B		;7e55
	inc hl			;7e57
	djnz L_7E53		;7e58
	ret			;7e5a
L_7E5B:
	ld (hl),d			;7e5b
	ret			;7e5c
L_7E5D:
	ld hl,(0c64ah)		;7e5d   ; abre una combinacion nueva en 0xC800 y copia 0xC56C
	inc hl			;7e60
	inc hl			;7e61
	inc hl			;7e62
	inc hl			;7e63
	ld (0c64ah),hl		;7e64
	ld de,0c56ch		;7e67
	ex de,hl			;7e6a
	ld bc,00004h		;7e6b
	ldir		;7e6e
	ld hl,0c800h		;7e70   ; apunta a las combinaciones que prueba la maquina
	inc (hl)			;7e73
	ld bc,(0c648h)		;7e74
	inc b			;7e78
	inc c			;7e79
	ld (0c648h),bc		;7e7a
	ret			;7e7e
L_7E7F:
	ld b,004h		;7e7f   ; quita de la mano las fichas de las cuatro casillas de HL
L_7E81:
	ld a,(hl)			;7e81
	and a			;7e82
	push bc			;7e83
	push hl			;7e84
	call nz,L_7E8E		;7e85   ; quita de la mano la ficha C, y la siguiente y la otra (secuencia C, D, E) o el triplete si tiene el bit 6
	pop hl			;7e88
	pop bc			;7e89
	inc hl			;7e8a
	djnz L_7E81		;7e8b
	ret			;7e8d
L_7E8E:
	ld c,a			;7e8e   ; quita de la mano la ficha C, y la siguiente y la otra (secuencia C, D, E) o el triplete si tiene el bit 6
	and 040h		;7e8f
	ld a,c			;7e91
	jr z,L_7E9B		;7e92
	and 00fh		;7e94
	ld c,a			;7e96
	ld d,a			;7e97
	ld e,a			;7e98
	jr L_7E9F		;7e99
L_7E9B:
	inc a			;7e9b
	ld d,a			;7e9c
	inc a			;7e9d
	ld e,a			;7e9e
L_7E9F:
	call L_7EA7		;7e9f   ; quita de la mano la ficha C (la primera de 0xC621 igual a C)
	ld c,d			;7ea2
	call L_7EA7		;7ea3   ; quita de la mano la ficha C (la primera de 0xC621 igual a C)
	ld c,e			;7ea6
L_7EA7:
	ld hl,0c621h		;7ea7   ; quita de la mano la ficha C (la primera de 0xC621 igual a C)
	ld b,00eh		;7eaa
L_7EAC:
	ld a,(hl)			;7eac   ; busca la ficha C en la mano
	cp c			;7ead
	jr z,L_7EB4		;7eae
	inc hl			;7eb0
	djnz L_7EAC		;7eb1
	ret			;7eb3
L_7EB4:
	ld (hl),000h		;7eb4
	ret			;7eb6
L_7EB7:
	ld hl,0c570h		;7eb7   ; deja la mano de 0xC621 sin huecos
	ld de,0c571h		;7eba
	ld bc,0000fh		;7ebd
	ld (hl),000h		;7ec0
	ldir		;7ec2
	ld hl,0c621h		;7ec4   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld de,0c570h		;7ec7
	ld b,00eh		;7eca
L_7ECC:
	ld a,(hl)			;7ecc
	and a			;7ecd
	jr z,L_7ED2		;7ece
	ld (de),a			;7ed0
	inc de			;7ed1
L_7ED2:
	inc hl			;7ed2
	djnz L_7ECC		;7ed3
	ld hl,0c570h		;7ed5
	ld de,0c621h		;7ed8   ; apunta a la mano de trabajo de 14 fichas ordenada
	ld bc,0000eh		;7edb
	ldir		;7ede
	ret			;7ee0
L_7EE1:
	ld hl,0c621h		;7ee1   ; guarda la mano de 0xC621 en 0xC530
	ld de,0c530h		;7ee4
	ld bc,0000eh		;7ee7
	ldir		;7eea
	ret			;7eec
L_7EED:
	ld de,0c621h		;7eed   ; devuelve la mano de 0xC530 a 0xC621
	ld hl,0c530h		;7ef0
	ld bc,0000eh		;7ef3
	ldir		;7ef6
	ret			;7ef8
L_7EF9:
	ld hl,0c638h		;7ef9   ; guarda 0xC638 en 0xC520 (8 bytes)
	ld de,0c520h		;7efc
	ld bc,00008h		;7eff
	ldir		;7f02
	ret			;7f04
L_7F05:
	ld de,0c638h		;7f05   ; devuelve 0xC520 a 0xC638
	ld hl,0c520h		;7f08
	ld bc,00008h		;7f0b
	ldir		;7f0e
	ret			;7f10
L_7F11:
	ld a,(0c800h)		;7f11   ; pasa las combinaciones de 0xC800 a las tablas de la mano (+0x200 y +0x1C0) para este palo (C = base del palo)
	and a			;7f14
	ret z			;7f15
	ld b,a			;7f16
	push bc			;7f17
	call L_7F76		;7f18   ; cuenta cuantas fichas tiene cada combinacion de 0xC800 y quita las que tienen menos de las que podria
	pop bc			;7f1b
	exx			;7f1c
	ld de,001c0h		;7f1d
	ld hl,(0c0deh)		;7f20   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,de			;7f23
	ld de,0cc80h		;7f24
	ld c,000h		;7f27
	exx			;7f29
	ld de,00200h		;7f2a
	ld hl,(0c0deh)		;7f2d   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	add hl,de			;7f30
	ex de,hl			;7f31
	ld hl,0c801h		;7f32
	push bc			;7f35
L_7F36:
	push bc			;7f36   ; por cada ficha de la combinacion pasa su numero a la tabla
	push de			;7f37
	push hl			;7f38
	exx			;7f39
	ld a,(de)			;7f3a
	inc de			;7f3b
	exx			;7f3c
	and a			;7f3d
	jr z,L_7F56		;7f3e
	exx			;7f40
	ld a,(hl)			;7f41
	inc (hl)			;7f42
	inc c			;7f43
	exx			;7f44
	add a,a			;7f45
	add a,a			;7f46
	call 04061h		;7f47   ; suma_a_de: DE = DE + A
	ld b,004h		;7f4a
L_7F4C:
	ld a,(hl)			;7f4c
	and a			;7f4d
	jr z,L_7F51		;7f4e
	or c			;7f50
L_7F51:
	ld (de),a			;7f51
	inc hl			;7f52
	inc de			;7f53
	djnz L_7F4C		;7f54
L_7F56:
	pop hl			;7f56   ; siguiente combinacion
	inc hl			;7f57
	inc hl			;7f58
	inc hl			;7f59
	inc hl			;7f5a
	pop de			;7f5b
	pop bc			;7f5c
	djnz L_7F36		;7f5d
	pop bc			;7f5f   ; guarda la cuenta de combinaciones en +0x1C1 + palo
	ld hl,(0c0deh)		;7f60   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld de,001c1h		;7f63
	add hl,de			;7f66
	ld a,c			;7f67
	rrca			;7f68
	rrca			;7f69
	rrca			;7f6a
	rrca			;7f6b
	and 00fh		;7f6c
	call 0405ch		;7f6e   ; suma_a_hl: HL = HL + A
	exx			;7f71
	ld a,c			;7f72
	exx			;7f73
	ld (hl),a			;7f74
	ret			;7f75
L_7F76:
	ld hl,0cc80h		;7f76   ; cuenta cuantas fichas tiene cada combinacion de 0xC800 y quita las que tienen menos de las que podria
	ld de,0cc81h		;7f79
	ld bc,0003fh		;7f7c
	ld (hl),000h		;7f7f
	ldir		;7f81
	ld a,(0c800h)		;7f83   ; lee las combinaciones que prueba la maquina
	and a			;7f86
	ret z			;7f87
	ld b,a			;7f88
	ld c,a			;7f89
	ld de,0c801h		;7f8a
	ld hl,0cc80h		;7f8d
L_7F90:
	push bc			;7f90
	ld bc,00400h		;7f91
L_7F94:
	ld a,(de)			;7f94
	and a			;7f95
	jr z,L_7F99		;7f96
	inc c			;7f98
L_7F99:
	inc de			;7f99   ; cuenta cuantas fichas hay en cada combinacion
	djnz L_7F94		;7f9a
	ld (hl),c			;7f9c
	inc hl			;7f9d
	pop bc			;7f9e
	djnz L_7F90		;7f9f
	ld d,004h		;7fa1
L_7FA3:
	ld hl,0cc80h		;7fa3
	ld b,c			;7fa6
L_7FA7:
	ld a,(hl)			;7fa7   ; busca la cuenta D
	cp d			;7fa8
	jr z,L_7FB2		;7fa9
	inc hl			;7fab
	djnz L_7FA7		;7fac
	dec d			;7fae
	ret z			;7faf
	jr L_7FA3		;7fb0
L_7FB2:
	dec d			;7fb2
	ret z			;7fb3
	ld hl,0cc80h		;7fb4
	ld b,c			;7fb7
L_7FB8:
	ld a,(hl)			;7fb8
	cp d			;7fb9
	jr nz,L_7FBE		;7fba
	ld (hl),000h		;7fbc
L_7FBE:
	inc hl			;7fbe
	djnz L_7FB8		;7fbf
	jr L_7FB2		;7fc1
L_7FC3:
	ld hl,(0c0deh)		;7fc3   ; cuenta cuantas veces aparece el palo C entre las combinaciones de +0x200
	ld de,001c0h		;7fc6
	add hl,de			;7fc9
	ex de,hl			;7fca
	ld hl,(0c0deh)		;7fcb   ; lee la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ld bc,00200h		;7fce
	add hl,de			;7fd1
	ld a,(de)			;7fd2
	ld b,a			;7fd3
	inc de			;7fd4
	ld c,000h		;7fd5
	exx			;7fd7
	ld c,000h		;7fd8
	exx			;7fda
L_7FDB:
	ld a,(hl)			;7fdb   ; cuenta las combinaciones del palo C
	and 030h		;7fdc   ; palo de cada combinacion (bits 4-5)
	rrca			;7fde
	rrca			;7fdf
	rrca			;7fe0
	rrca			;7fe1
	exx			;7fe2
	cp c			;7fe3
	exx			;7fe4
	jr nz,L_7FEE		;7fe5
	inc c			;7fe7   ; si coincide con el buscado suma uno
	inc hl			;7fe8
	inc hl			;7fe9
	inc hl			;7fea
	inc hl			;7feb
	djnz L_7FDB		;7fec
L_7FEE:
	ret			;7fee
L_7FEF:
	ld a,(0c630h)		;7fef   ; si 0xC630 es cero no hace nada; si no, pone a cero 3 bytes de 0xCC80
	and a			;7ff2
	ret z			;7ff3
	ld hl,0cc80h		;7ff4
	ld de,0cc81h		;7ff7
	ld bc,00003h		;7ffa
	ld (hl),000h		;7ffd

; ----------------------------------------------------------------------
; DATOS partida_7FFF: los 1 primeros bytes de una instruccion de 2 (ED B0) que
;   sigue en el banco 2: el trazador de un solo banco no puede verla entera
;   (tools/bancos.py); lo leen p01:7FFF (1 bytes)
;   0x7fff..0x8000  (1 bytes)
DATA_partida_7FFF:
	defb 0edh	; 7fff
