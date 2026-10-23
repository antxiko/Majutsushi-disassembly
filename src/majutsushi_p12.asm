; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 12 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x6065  (101 bytes)
; ======================================================================


sonido_init:		; inicia el sonido
	jp L_6009		;6000   ; ENTRADA 0: inicia el sonido: el mezclador del PSG (registro 7) a 0xBF, todo en silencio
sonido_pide:		; pide el sonido A
	jp L_6010		;6003   ; ENTRADA 1: pide el sonido A (0x01-0x10 y 0x80-0x84: musica y efectos del PSG, 0x11-0x18: voces digitales)
sonido_cuadro:		; un cuadro de sonido
	jp L_6254		;6006   ; ENTRADA 2: un cuadro del sonido (la llama la interrupcion)
L_6009:
	ld a,007h		;6009
	ld e,0bfh		;600b
	jp 00093h		;600d   ; BIOS WRTPSG - Writes data to PSG-register
L_6010:
	ld c,a			;6010
	cp 080h		;6011
	jr nc,$+98		;6013   ; A >= 0x80: es una orden del PSG (parar, silencio, ritmo...)
	cp 011h		;6015
	jr c,$+94		;6017   ; A < 0x11: musica o efecto de cinco canales
	ld (0cf26h),a		;6019   ; A = 0x11-0x18: una voz digital: 0xCF26 = el sonido
	cp 017h		;601c
	call z,L_6059		;601e   ; el 0x17 y el 0x18 paran antes los canales del PSG (0x6059)
	cp 018h		;6021
	call z,L_6059		;6023   ; para el PSG mientras suene la voz: 0xCF08 bit 1 y el banco 15 en 0xA000
	cp 018h		;6026
	call z,L_61AA		;6028
	sub 011h		;602b   ; busca la voz en la tabla de 0x6065 (8 punteros): direccion de la primera muestra
	add a,a			;602d
	ld hl,06065h		;602e
	ld e,a			;6031
	ld d,000h		;6032
	add hl,de			;6034
	ld e,(hl)			;6035
	inc hl			;6036
	ld d,(hl)			;6037
	ex de,hl			;6038
	ld a,(hl)			;6039   ; el primer byte de la muestra es la marca del final (0xCF29); 0xCF27 = puntero a los datos
	ld (0cf29h),a		;603a
	inc hl			;603d
	ld (0cf27h),hl		;603e
	ld a,001h		;6041   ; 0xCF2C = 1: hay una voz pendiente; 0xCF2F += 3 (retardo entre muestras)
	ld (0cf2ch),a		;6043
	ld hl,0cf2fh		;6046
	inc (hl)			;6049
	inc (hl)			;604a
	inc (hl)			;604b
	ld hl,0cf08h		;604c   ; si el PSG esta parado por la voz, el banco 14 se vuelve a poner en 0xA000
	bit 1,(hl)		;604f
	jr z,L_6058		;6051
	ld a,00eh		;6053
	ld (0a000h),a		;6055
L_6058:
	ret			;6058
L_6059:
	ld hl,0cf08h		;6059   ; para el PSG mientras suene la voz: 0xCF08 bit 1 y el banco 15 en 0xA000
	set 1,(hl)		;605c
	ld a,00fh		;605e
	ld (0a000h),a		;6060
	ld a,c			;6063
	ret			;6064

; ----------------------------------------------------------------------
; DATOS voces: las 8 voces digitales (sonidos 0x11-0x18): el puntero a cada
;   muestra, en 0x8000-0xBFFF con los bancos 13-14 puestos (las dos ultimas,
;   en el banco 15, que el motor pone en 0xA000 con p12:6059); las lee
;   p12:602E
;   0x6065..0x6075  (16 bytes)
DATA_voces:
	defw 09040h,094c4h,09da6h,0a348h,0a8e1h,0b373h,0ae00h,0b6e2h	; 6065

; ======================================================================
; CODIGO 0x6075..0x6140  (203 bytes)
; ======================================================================


L_6075:
	cp 080h		;6075   ; ordenes del PSG: 0x80 = para y quita el ritmo, 0x81 = pone el tono, 0x82 y 0x83 cambian el retardo (0xCF2F), 0x84 = silencio con el ritmo
	jp z,L_6168		;6077
	cp 081h		;607a
	jp z,L_6170		;607c
	cp 082h		;607f
	jp z,L_619E		;6081
	cp 083h		;6084
	jp z,L_61A4		;6086
	cp 084h		;6089
	jp z,L_6189		;608b
	cp 009h		;608e
	jr c,L_6095		;6090
	call L_6168		;6092   ; para todo el PSG
L_6095:
	ld hl,0cf09h		;6095   ; 0xCF09 = el sonido; HL = su fila de la tabla de 0x61B0 (12 bytes) que se copia a 0xCF0A
	ld (hl),c			;6098
	ld hl,061b0h		;6099
	ld a,c			;609c
	add a,c			;609d
	ld e,a			;609e
	ld d,000h		;609f
	add hl,de			;60a1
	ld e,(hl)			;60a2
	inc hl			;60a3
	ld d,(hl)			;60a4
	ex de,hl			;60a5
	ld de,0cf0ah		;60a6
	ld bc,0000ch		;60a9
	ldir		;60ac
	ld ix,0cf0ch		;60ae   ; recorre los cinco canales (0xCF0C): el bit 7, 6, 5, 4 y 3 de la fila dicen cuales se ponen, y el siguiente byte es su prioridad
	ld hl,0cf0ah		;60b2
	bit 7,(hl)		;60b5
	jp z,L_60C6		;60b7
	inc hl			;60ba
	ld a,(hl)			;60bb
	ld hl,0ce01h		;60bc
	call L_6120		;60bf   ; compara la prioridad A con la del canal HL: si es menor, no pone el sonido
	inc ix		;60c2
	inc ix		;60c4
L_60C6:
	ld hl,0cf0ah		;60c6
	bit 6,(hl)		;60c9
	jp z,L_60DA		;60cb
	inc hl			;60ce
	ld a,(hl)			;60cf
	ld hl,0ce2dh		;60d0
	call L_6120		;60d3   ; compara la prioridad A con la del canal HL: si es menor, no pone el sonido
	inc ix		;60d6
	inc ix		;60d8
L_60DA:
	ld hl,0cf0ah		;60da
	bit 5,(hl)		;60dd
	jp z,L_60EE		;60df
	inc hl			;60e2
	ld a,(hl)			;60e3
	ld hl,0ce59h		;60e4
	call L_6120		;60e7   ; compara la prioridad A con la del canal HL: si es menor, no pone el sonido
	inc ix		;60ea
	inc ix		;60ec
L_60EE:
	ld hl,0cf0ah		;60ee
	bit 4,(hl)		;60f1
	jp z,L_6102		;60f3
L_60F6:
	inc hl			;60f6
	ld a,(hl)			;60f7
	ld hl,0ce85h		;60f8
	call L_6120		;60fb   ; compara la prioridad A con la del canal HL: si es menor, no pone el sonido
	inc ix		;60fe
	inc ix		;6100
L_6102:
	ld hl,0cf0ah		;6102   ; si el canal 3 (efecto en el canal B) esta pedido (bit 3 de 0xCF0A) y su contador es cero, ya no hace falta y lo anula
	bit 3,(hl)		;6105
	ret z			;6107
	ld de,0ce84h		;6108   ; prioridad del canal 4 en 0xCE84
	ld a,(de)			;610b
	ld b,a			;610c
	or b			;610d
	jp z,L_6119		;610e
	inc hl			;6111   ; si no, pone la prioridad en el canal 4 (0xCEB1)
	ld a,(hl)			;6112
	ld hl,0ceb1h		;6113
	jp L_6120		;6116
L_6119:
	set 4,(hl)		;6119
	res 3,(hl)		;611b
	jp L_60F6		;611d
L_6120:
	ld b,(hl)			;6120   ; compara la prioridad A con la del canal HL: si es menor, no pone el sonido
	cp b			;6121
	ret c			;6122
	ex de,hl			;6123   ; pone la prioridad y el numero del sonido en el canal
	ld (de),a			;6124
	dec de			;6125
	ld hl,0cf09h		;6126
	ld a,(hl)			;6129
	ld (de),a			;612a
	inc de			;612b
	inc de			;612c
	ld a,(ix+000h)		;612d   ; copia el puntero de musica del canal (IX) y limpia el resto con los 40 bytes de 0x6140
	ld (de),a			;6130
	inc de			;6131
	ld a,(ix+001h)		;6132
	ld (de),a			;6135
	inc de			;6136
	ld hl,06140h		;6137
	ld bc,00028h		;613a
	ldir		;613d
	ret			;613f

; ----------------------------------------------------------------------
; DATOS canal_inicial: el bloque de 40 bytes que se copia a un canal al darle
;   un sonido (p12:613A: ldir de 0x28 bytes): el primer byte es 1 y el resto
;   cero
;   0x6140..0x6168  (40 bytes)
DATA_canal_inicial:
	defb 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6140  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6150  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 6160  ........

; ======================================================================
; CODIGO 0x6168..0x61b2  (74 bytes)
; ======================================================================


L_6168:
	ld hl,0cf08h		;6168   ; para todo el PSG
	res 0,(hl)		;616b
	jp L_6181		;616d
L_6170:
	ld hl,0cf16h		;6170   ; inicia el ritmo (0xCF16 = 0x0E, 0xCF17 = 7)
	ld (hl),00eh		;6173
	inc hl			;6175
	ld (hl),007h		;6176
	ld hl,0cf08h		;6178
	set 0,(hl)		;617b
	res 5,(hl)		;617d
	res 4,(hl)		;617f
L_6181:
	ld hl,0cf18h		;6181   ; pone a cero el contador del ritmo
	xor a			;6184
	ld (hl),a			;6185
	inc hl			;6186
	ld (hl),a			;6187
	ret			;6188
L_6189:
	ld hl,0cf2eh		;6189   ; fundido de salida: periodo del fundido 0x10 y bit 5 de 0xCF08
	ld (hl),010h		;618c
	ld hl,0cf08h		;618e
	set 5,(hl)		;6191
	res 0,(hl)		;6193
	ld hl,0cf18h		;6195   ; pone a cero el contador y pone el limite en 4
	xor a			;6198
	ld (hl),a			;6199
	inc hl			;619a
	ld (hl),004h		;619b
	ret			;619d
L_619E:
	ld a,007h		;619e   ; 0xCF2F = 7 (retardo corto de las voces)
	ld (0cf2fh),a		;61a0
	ret			;61a3
L_61A4:
	ld a,012h		;61a4   ; 0xCF2F = 0x12 (retardo largo de las voces)
	ld (0cf2fh),a		;61a6
	ret			;61a9
L_61AA:
	ld a,043h		;61aa
	ld (0cf2fh),a		;61ac
	ld a,018h		;61af
	ret			;61b1

; ----------------------------------------------------------------------
; DATOS tabla_sonidos: los 16 punteros a las filas de los sonidos 0x01-0x10
;   (p12:60A1: 0x61B0 + 2 x A); cada fila lleva un byte de canales (un bit por
;   canal: 7, 6 y 5 son los tres de musica, 4 y 3 los de efectos), la
;   prioridad y un puntero por canal
;   0x61b2..0x61d2  (32 bytes)
DATA_tabla_sonidos:
	defw 061e2h,061eeh,061fah,06200h,06204h,06208h,0620ch,06210h	; 61b2
	defw 06214h,0621ch,06224h,0622ch,06234h,0623ch,06244h,0624ch	; 61c2

; ----------------------------------------------------------------------
; DATOS tabla_voces: ocho palabras 0x6254 que ocupan en la tabla de 0x61B0 las
;   casillas de los sonidos 0x11-0x18 (las voces no la usan: van por p12:6019)
;   0x61d2..0x61e2  (16 bytes)
DATA_tabla_voces:
	defw 06254h,06254h,06254h,06254h,06254h,06254h,06254h,06254h	; 61d2

; ----------------------------------------------------------------------
; DATOS filas_de_sonidos: las 16 filas de los sonidos 0x01-0x10 (byte de
;   canales, prioridad y un puntero por canal): la 1 y la 2 paran los cinco
;   canales (flujos 0x6F72 y 0x6F73), de la 3 a la 8 son efectos de uno o dos
;   canales y de la 9 a la 16 melodias de tres canales
;   0x61e2..0x6254  (114 bytes)
DATA_filas_de_sonidos:
	defb 0f8h,0ffh,072h,06fh,072h,06fh,072h,06fh,072h,06fh,072h,06fh,0f8h,001h,073h,06fh	; 61e2  ..rororororo..so
	defb 073h,06fh,073h,06fh,073h,06fh,073h,06fh,018h,003h,077h,08eh,09ah,08eh,010h,002h	; 61f2  sosososo..w.....
	defb 0bdh,08eh,010h,003h,0d0h,08eh,010h,003h,0d8h,08fh,010h,004h,0f9h,08fh,010h,004h	; 6202  ................
	defb 026h,090h,0e0h,001h,074h,06fh,00bh,072h,0f8h,073h,0e0h,001h,066h,076h,077h,078h	; 6212  &...to.r.s..fvwx
	defb 036h,07bh,0e0h,001h,07dh,07dh,027h,07fh,053h,082h,0e0h,001h,0efh,083h,0c1h,085h	; 6222  6{..}}'.S.......
	defb 01fh,087h,0e0h,001h,0f9h,088h,025h,089h,056h,089h,0e0h,001h,082h,089h,0cdh,089h	; 6232  ......%.V.......
	defb 01ah,08ah,0e0h,001h,04ah,08ah,0bbh,08ah,022h,08bh,0e0h,001h,07ah,08bh,09bh,08ch	; 6242  ....J..."...z...
	defb 082h,08dh	; 6252

; ======================================================================
; CODIGO 0x6254..0x62d1  (125 bytes)
; ======================================================================


L_6254:
	ld a,(0cf2ch)		;6254   ; UN CUADRO DE SONIDO: si hay una voz pendiente (0xCF2C), pone el DAC en reposo (0x80) y sale
	or a			;6257
	jp z,L_6265		;6258
	xor a			;625b
	ld (0cf2ch),a		;625c
	ld a,080h		;625f
	ld (0cf2ah),a		;6261
	ret			;6264
L_6265:
	ld a,(0cf26h)		;6265   ; si suena una voz digital (0xCF26): reproduce su muestra (el cartucho tiene un DAC en 0x5000); si no, 0x62FE
	or a			;6268
	jp z,L_62FE		;6269
	ld a,007h		;626c
	ld e,0bfh		;626e
	call 00093h		;6270   ; BIOS WRTPSG - Writes data to PSG-register
	ld hl,0cf08h		;6273
	bit 1,(hl)		;6276
	jr z,L_627F		;6278
	ld a,00fh		;627a
	ld (0a000h),a		;627c
L_627F:
	di			;627f   ; sin interrupciones mientras suena; 0xCF2D = 1 (la interrupcion del cuadro no hace nada)
	ld a,001h		;6280
	ld (0cf2dh),a		;6282
	ld hl,(0cf27h)		;6285
	ld de,0cf29h		;6288
L_628B:
	ld a,(de)			;628b   ; recorre la muestra: dos nibbles por byte; cada uno es un salto que se suma al valor del DAC (tabla 0x62D1 de 16 pasos con signo) y se escribe en 0x5000
	ld b,a			;628c
	ld a,(hl)			;628d
	cp b			;628e
	jp z,L_62E1		;628f
	and 0f0h		;6292
	rrca			;6294
	rrca			;6295
	rrca			;6296
	rrca			;6297
	push hl			;6298
	ld hl,062d1h		;6299
	ld c,a			;629c
	ld b,000h		;629d
	add hl,bc			;629f
	ld a,(0cf2ah)		;62a0
	add a,(hl)			;62a3
	ld (0cf2ah),a		;62a4
	pop hl			;62a7
	ld (05000h),a		;62a8   ; escribe el valor en el DAC del cartucho (0x5000)
	ld a,(0cf2fh)		;62ab   ; espera un bucle de 0xCF2F veces para fijar la velocidad de reproduccion
	ld b,a			;62ae
L_62AF:
	djnz L_62AF		;62af   ; espera (djnz) para dar la velocidad de la voz
	ld a,(hl)			;62b1   ; el nibble bajo de la muestra
	and 00fh		;62b2
	inc hl			;62b4
	push hl			;62b5
	ld hl,062d1h		;62b6
	ld c,a			;62b9
	ld b,000h		;62ba
	add hl,bc			;62bc
	ld a,(0cf2ah)		;62bd   ; suma el salto del nibble al valor del DAC y lo guarda en 0xCF2A
	add a,(hl)			;62c0
	ld (0cf2ah),a		;62c1
	pop hl			;62c4
	ld (05000h),a		;62c5   ; lo escribe en el DAC del cartucho
	ld a,(0cf2fh)		;62c8
	ld b,a			;62cb
L_62CC:
	djnz L_62CC		;62cc
	jp L_628B		;62ce

; ----------------------------------------------------------------------
; DATOS deltas_de_la_voz: los 16 saltos que dice cada nibble de una muestra de
;   voz: se suman al valor que lleva el DAC (p12:629C y p12:62BD): 0, 1, 2, 4,
;   8, 16, 32, 64, -128, -64, -32, -16, -8, -4, -2 y -1
;   0x62d1..0x62e1  (16 bytes)
DATA_deltas_de_la_voz:
	defb 000h,001h,002h,004h,008h,010h,020h,040h,080h,0c0h,0e0h,0f0h,0f8h,0fch,0feh,0ffh	; 62d1  ...... @........

; ======================================================================
; CODIGO 0x62e1..0x63f8  (279 bytes)
; ======================================================================


L_62E1:
	ld hl,0cf08h		;62e1   ; fin de la muestra (el primer byte repetido = 0xCF29): vuelve a poner el banco 14 y a cero todo
	bit 1,(hl)		;62e4
	jr z,L_62EF		;62e6
	res 1,(hl)		;62e8
	ld a,00eh		;62ea
	ld (0a000h),a		;62ec
L_62EF:
	xor a			;62ef   ; fin de la voz: pone a cero la voz, la marca, el retardo y el semaforo, e interrupciones otra vez
	ld (0cf26h),a		;62f0
	ld (0cf29h),a		;62f3
	ld (0cf2fh),a		;62f6
	ld (0cf2dh),a		;62f9
	ei			;62fc
	ret			;62fd
L_62FE:
	ld a,(0cf1ah)		;62fe   ; CUADRO DE MUSICA: manda el mezclador, avanza el ritmo y el fundido, y recorre los cinco canales (0xCE00, 0xCE2C, 0xCE58, 0xCE84, 0xCEB0; 44 bytes cada uno; 0xCF1B = su mascara 1, 2, 4, 8, 0x10)
	call L_6D3E		;6301
	ld a,(0cf08h)		;6304
	bit 0,a		;6307
	call nz,L_680F		;6309   ; cuenta atras del ritmo (0xCF16, 0xCF17): al llegar a cero para el ritmo y pone a cero los cinco canales
	ld a,(0cf08h)		;630c
	bit 5,a		;630f
	call nz,L_68B0		;6311   ; fundido de salida del PSG: cuenta cuadros
	ld a,001h		;6314
	ld (0cf1bh),a		;6316
	ld ix,0ce00h		;6319
	call L_6354		;631d   ; un canal: si (ix+0) no es cero, 0x635C
	ld a,002h		;6320
	ld (0cf1bh),a		;6322
	ld ix,0ce2ch		;6325
	call L_6354		;6329   ; un canal: si (ix+0) no es cero, 0x635C
	ld a,004h		;632c
	ld (0cf1bh),a		;632e
	ld ix,0ce58h		;6331
	call L_6354		;6335   ; un canal: si (ix+0) no es cero, 0x635C
	ld a,008h		;6338
	ld (0cf1bh),a		;633a
	ld ix,0ce84h		;633d
	call L_6354		;6341   ; un canal: si (ix+0) no es cero, 0x635C
	ld a,010h		;6344
	ld (0cf1bh),a		;6346
	ld ix,0ceb0h		;6349
	call L_6354		;634d   ; un canal: si (ix+0) no es cero, 0x635C
	call vuelca_psg		;6350   ; al final vuelca los registros al PSG (0x6C12)
	ret			;6353
L_6354:
	ld a,(ix+000h)		;6354   ; un canal: si (ix+0) no es cero, 0x635C
	or a			;6357
	call nz,L_635C		;6358   ; un paso del canal: baja su contador (ix+4); si no llega a cero, solo el efecto de cada cuadro (0x65B5)
	ret			;635b
L_635C:
	dec (ix+004h)		;635c   ; un paso del canal: baja su contador (ix+4); si no llega a cero, solo el efecto de cada cuadro (0x65B5)
	jp nz,L_65B5		;635f
	ld l,(ix+002h)		;6362   ; lee el siguiente byte de la musica (HL = (ix+2)): 0xFF = fin del canal; de 0xD0 en adelante es una orden (0x694D); si no, es una nota
	ld h,(ix+003h)		;6365
L_6368:
	ld a,(hl)			;6368
	cp 0ffh		;6369
	jp z,L_68CB		;636b
	cp 0d0h		;636e
	jp c,L_637A		;6370
	call L_694D		;6373   ; decide la tabla de la orden
	inc hl			;6376
	jp L_6368		;6377
L_637A:
	bit 0,(ix+009h)		;637a   ; nota: segun los bits 0, 1 y 2-5 de (ix+9) (tipo de canal) la nota se trata como tono (0x6391), segundo modo (0x6404) o ritmo (0x647E)
	jp nz,L_6391		;637e
	bit 1,(ix+009h)		;6381
	jp nz,L_6404		;6385
	ld a,(ix+009h)		;6388
	and 03ch		;638b
	jp nz,L_647E		;638d
	ret			;6390
L_6391:
	ld a,(hl)			;6391   ; tono: el nibble bajo es la duracion (multiplicada por (ix+0x14), el tempo) y el alto la nota (0-0xB)
	and 00fh		;6392
	ld b,a			;6394
	ld a,(ix+014h)		;6395
	jp z,L_639F		;6398
	ld e,a			;639b
L_639C:
	add a,e			;639c
	djnz L_639C		;639d
L_639F:
	ld (ix+004h),a		;639f   ; guarda la duracion en (ix+4)
	ld a,(hl)			;63a2
	and 0f0h		;63a3   ; el nibble alto es la nota
	rrca			;63a5
	rrca			;63a6
	rrca			;63a7
	rrca			;63a8
	call L_6807		;63a9   ; avanza el puntero de la musica del canal (HL + 1)
	bit 7,(ix+009h)		;63ac
	ret nz			;63b0
	cp 00ch		;63b1   ; con la nota < 0x0C: periodo del PSG = tabla 0x63F8 (12 notas) multiplicada por dos por la octava ((ix+0x16)); si no, silencio
	jp nc,L_63EF		;63b3   ; las notas desde 0x0C son silencio
	ld hl,063f8h		;63b6   ; periodo base de la nota
	ld e,a			;63b9
	ld d,000h		;63ba
	add hl,de			;63bc
	ld l,(hl)			;63bd
	ld h,000h		;63be
	ld a,(ix+016h)		;63c0   ; octava: duplica el periodo
	or a			;63c3
	jp z,L_63CB		;63c4
	ld b,a			;63c7
L_63C8:
	add hl,hl			;63c8
	djnz L_63C8		;63c9
L_63CB:
	ld (ix+010h),l		;63cb
	ld (ix+011h),h		;63ce
	ld e,(ix+015h)		;63d1
	ld a,(0cf08h)		;63d4
	and 021h		;63d7
	call nz,L_689B		;63d9   ; resta el fundido (0xCF19) al volumen E (no baja de cero)
	ld (ix+012h),e		;63dc
	ld a,(ix+00dh)		;63df
	and 0f0h		;63e2
	ld (ix+00dh),a		;63e4
	set 1,(ix+00dh)		;63e7
	call L_6511		;63eb   ; empieza una nota: periodo en (ix+0x0A) y volumen en (ix+0x0C), con la envolvente a cero (0x1D-0x20)
	ret			;63ee
L_63EF:
	ld a,(ix+00dh)		;63ef
	and 0f0h		;63f2
	ld (ix+00dh),a		;63f4
	ret			;63f7

; ----------------------------------------------------------------------
; DATOS periodos_base: los 12 periodos del PSG (byte bajo) de las doce notas
;   de la octava mas baja; cada octava los dobla (p12:63B6)
;   0x63f8..0x6404  (12 bytes)
DATA_periodos_base:
	defb 06ah,064h,05eh,059h,054h,04fh,04ah,046h,042h,03fh,03bh,038h	; 63f8  jd^YTOJFB?.8

; ======================================================================
; CODIGO 0x6404..0x6962  (1374 bytes)
; ======================================================================


L_6404:
	ld a,(ix+00dh)		;6404   ; tono de dos bytes: segun el tipo del canal
	and 003h		;6407
	jp z,L_646F		;6409
	cp 001h		;640c
	jp z,L_644C		;640e
	ld a,(hl)			;6411   ; el byte de la nota
	bit 6,(ix+00eh)		;6412
	jp nz,L_6436		;6416
	bit 5,(ix+00eh)		;6419
	jp nz,L_643C		;641d
	and 0f0h		;6420   ; el nibble alto es el periodo bajo
	ld b,a			;6422
	xor (hl)			;6423
	ld d,a			;6424
	inc hl			;6425
	ld a,(hl)			;6426
	ld (ix+010h),a		;6427
	ld (ix+011h),d		;642a
	ld a,b			;642d
	rrca			;642e
	rrca			;642f
	rrca			;6430
	rrca			;6431
	ld b,a			;6432
	jp L_6450		;6433
L_6436:
	ld (ix+010h),a		;6436
	jp L_645E		;6439
L_643C:
	and 0f0h		;643c   ; el periodo viene en nibbles
	rrca			;643e
	rrca			;643f
	rrca			;6440
	rrca			;6441
	ld b,a			;6442
	ld a,(hl)			;6443
	and 00fh		;6444   ; nibble bajo, byte alto del periodo
	ld (ix+011h),a		;6446
	jp L_6450		;6449
L_644C:
	ld a,(hl)			;644c
	and 00fh		;644d
	ld b,a			;644f
L_6450:
	bit 2,(ix+00dh)		;6450
	jp z,L_6459		;6454
	ld b,010h		;6457
L_6459:
	inc b			;6459
	inc b			;645a
	ld (ix+012h),b		;645b
L_645E:
	ld e,(ix+012h)		;645e
	ld a,(0cf08h)		;6461
	and 021h		;6464
	call nz,L_689B		;6466   ; resta el fundido (0xCF19) al volumen E (no baja de cero)
	ld (ix+012h),e		;6469
	call L_6511		;646c   ; empieza una nota: periodo en (ix+0x0A) y volumen en (ix+0x0C), con la envolvente a cero (0x1D-0x20)
L_646F:
	bit 7,(ix+009h)		;646f
	ret nz			;6473
	call L_6807		;6474   ; avanza el puntero de la musica del canal (HL + 1)
	ld a,(ix+013h)		;6477
	ld (ix+004h),a		;647a
	ret			;647d
L_647E:
	set 7,(ix+009h)		;647e   ; nota de ritmo: busca su patron (0x64B5) en la tabla segun el tipo y lo toca (0x6494)
	call L_6391		;6482   ; tono: el nibble bajo es la duracion (multiplicada por (ix+0x14), el tempo) y el alto la nota (0-0xB)
	ld b,a			;6485
	call L_64B5		;6486   ; elige la direccion del patron de ritmo por el tipo de canal (tablas 0x6DA3, 0x6E17, 0x6F20, 0x6D5B, 0x6D73, 0x6D8B)
	ld a,b			;6489
	add a,a			;648a
	ld e,a			;648b
	ld d,000h		;648c
	add hl,de			;648e
	ld e,(hl)			;648f
	inc hl			;6490
	ld d,(hl)			;6491
	ex de,hl			;6492
	ld a,(hl)			;6493
L_6494:
	set 1,(ix+009h)		;6494   ; toca el patron de ritmo: marca el canal y ejecuta sus ordenes
	call L_6368		;6498
	res 1,(ix+009h)		;649b   ; termina el patron
	res 7,(ix+009h)		;649f
	ld a,(ix+013h)		;64a3   ; recarga el contador de tempo
	ld (ix+019h),a		;64a6
	inc hl			;64a9
	ld (ix+017h),l		;64aa   ; guarda la posicion de la musica
	ld (ix+018h),h		;64ad
	set 0,(ix+00eh)		;64b0
	ret			;64b4
L_64B5:
	bit 2,(ix+009h)		;64b5   ; elige la direccion del patron de ritmo por el tipo de canal (tablas 0x6DA3, 0x6E17, 0x6F20, 0x6D5B, 0x6D73, 0x6D8B)
	jp nz,L_64D1		;64b9
	bit 3,(ix+009h)		;64bc
	jp nz,L_64E1		;64c0
	bit 4,(ix+009h)		;64c3
	jp nz,L_64F1		;64c7
	bit 5,(ix+009h)		;64ca
	jp nz,L_6501		;64ce
L_64D1:
	ld a,(ix+016h)		;64d1
	cp 001h		;64d4
	jp z,L_64DD		;64d6
	ld hl,06da3h		;64d9
	ret			;64dc
L_64DD:
	ld hl,06e17h		;64dd
	ret			;64e0
L_64E1:
	ld a,(ix+016h)		;64e1
	cp 001h		;64e4
	jp z,L_64ED		;64e6
	ld hl,06f20h		;64e9
	ret			;64ec
L_64ED:
	ld hl,06d5bh		;64ed
	ret			;64f0
L_64F1:
	ld a,(ix+016h)		;64f1
	cp 001h		;64f4
	jp z,L_64FD		;64f6
	ld hl,06d73h		;64f9
	ret			;64fc
L_64FD:
	ld hl,06d8bh		;64fd
	ret			;6500
L_6501:
	ld a,(ix+016h)		;6501
	cp 001h		;6504
	jp z,L_650D		;6506
	ld hl,06d8bh		;6509
	ret			;650c
L_650D:
	ld hl,06d8bh		;650d
	ret			;6510
L_6511:
	call L_66C4		;6511   ; empieza una nota: periodo en (ix+0x0A) y volumen en (ix+0x0C), con la envolvente a cero (0x1D-0x20)
	res 4,(ix+00eh)		;6514
	bit 4,(ix+00dh)		;6518
	jp z,L_6523		;651c
	set 6,(ix+00dh)		;651f
L_6523:
	ld a,(0cf08h)		;6523   ; mira si el ritmo ha acabado
	bit 3,a		;6526
	jr z,L_653D		;6528
	set 6,(ix+00fh)		;652a   ; marca el canal
	ld a,(0cf1bh)		;652e
	cp 004h		;6531
	jr nz,L_653D		;6533
	ld a,(0cf08h)		;6535
	res 3,a		;6538
	ld (0cf08h),a		;653a
L_653D:
	res 5,(ix+00dh)		;653d   ; empieza la nota: borra la envolvente
	ld a,(ix+00fh)		;6541
	and 0d7h		;6544
	ld (ix+00fh),a		;6546
	xor a			;6549   ; pone a cero los contadores del vibrato y la envolvente
	ld (ix+01dh),a		;654a
	ld (ix+01eh),a		;654d
	ld (ix+01fh),a		;6550
	ld (ix+020h),a		;6553
	set 2,(ix+00fh)		;6556
	ld a,(ix+012h)		;655a   ; volumen de la nota
	bit 7,(ix+00eh)		;655d
	jp z,L_656B		;6561
	ld e,(ix+015h)		;6564   ; le resta el volumen base
	sub e			;6567
	call m,L_65B3		;6568
L_656B:
	ld (ix+00ch),a		;656b   ; guarda el volumen
	bit 2,(ix+00dh)		;656e
	ret nz			;6572
	bit 6,(ix+00fh)		;6573   ; mira si el canal sigue con envolvente
	jr z,L_6583		;6577
	bit 7,(ix+00fh)		;6579
	jr nz,L_659C		;657d
	res 6,(ix+00fh)		;657f
L_6583:
	bit 1,(ix+00fh)		;6583   ; mira el ritmo
	ret z			;6587
	ld a,(0cf08h)		;6588
	bit 0,a		;658b
	jr z,L_65A8		;658d
	bit 2,a		;658f
	jr z,L_6597		;6591
	set 7,(ix+00fh)		;6593
L_6597:
	res 1,(ix+00fh)		;6597
	ret			;659b
L_659C:
	res 7,(ix+00fh)		;659c
	res 6,(ix+00fh)		;65a0
	set 1,(ix+00fh)		;65a4
L_65A8:
	ld a,(ix+025h)		;65a8
	ld (ix+00ch),a		;65ab
	res 2,(ix+00fh)		;65ae
	ret			;65b2
L_65B3:
	xor a			;65b3
	ret			;65b4
L_65B5:
	bit 0,(ix+00eh)		;65b5   ; efectos de cada cuadro de una nota: ritmo (0x669B), deslizamiento (0x65F6), vibrato (0x66E1) y envolvente de volumen (0x6736)
	jp nz,L_669B		;65b9
	bit 4,(ix+00dh)		;65bc
	call nz,L_65F6		;65c0   ; deslizamiento del tono: sube o baja el periodo de (ix+0x27) cada cuadro, (ix+0x28) veces
	bit 2,(ix+00eh)		;65c3
	call nz,L_66E1		;65c7   ; vibrato: cuenta cuadros
	bit 0,(ix+00fh)		;65ca
	call nz,L_6736		;65ce   ; envolvente de volumen (ataque, caida, sostenido y relajacion con los tiempos de (ix+0x21)-(ix+0x24))
	ld a,(0cf08h)		;65d1   ; si el ritmo esta en marcha (0xCF08 bit 0) baja un nivel el volumen cada 11 cuadros
	bit 0,a		;65d4
	ret z			;65d6
	ld a,(ix+009h)		;65d7
	bit 1,a		;65da
	ret nz			;65dc
	inc (ix+02bh)		;65dd
	ld a,00bh		;65e0
	cp (ix+02bh)		;65e2
	ret nz			;65e5
	xor a			;65e6
	ld (ix+02bh),a		;65e7
	ld b,(ix+00ch)		;65ea
	dec b			;65ed
	ld (ix+00ch),a		;65ee
	ret m			;65f1
	ld (ix+00ch),b		;65f2
	ret			;65f5
L_65F6:
	nop			;65f6   ; deslizamiento del tono: sube o baja el periodo de (ix+0x27) cada cuadro, (ix+0x28) veces
	bit 6,(ix+00dh)		;65f7
	ret z			;65fb
	bit 7,(ix+00dh)		;65fc
	jp nz,L_664B		;6600
	bit 5,(ix+00dh)		;6603
	jp nz,L_6623		;6607
	ld l,(ix+010h)		;660a
	ld h,(ix+011h)		;660d
	ld b,(ix+028h)		;6610
L_6613:
	ld d,000h		;6613
	ld e,(ix+027h)		;6615
	add hl,de			;6618
	jp nc,L_661E		;6619
	sbc hl,de		;661c
L_661E:
	djnz L_6613		;661e
	jp L_6668		;6620
L_6623:
	ld a,(ix+00ah)		;6623   ; deslizamiento hacia abajo: resta la velocidad del periodo
	ld d,(ix+00bh)		;6626
	sbc a,(ix+027h)		;6629
	ld e,a			;662c
	jp nc,L_663A		;662d   ; si se pasa del cero, queda en uno
	ld a,d			;6630
	or a			;6631
	jr nz,L_6639		;6632
	ld de,00001h		;6634
	jr L_663A		;6637
L_6639:
	dec d			;6639
L_663A:
	ld (ix+00ah),e		;663a   ; guarda el periodo
	ld (ix+00bh),d		;663d
	dec (ix+028h)		;6640   ; cuenta atras del deslizamiento
	ld a,(ix+028h)		;6643
	or a			;6646
	ret nz			;6647
	jp L_668D		;6648
L_664B:
	bit 5,(ix+00dh)		;664b
	jp nz,L_6673		;664f
	ld l,(ix+010h)		;6652
	ld h,(ix+011h)		;6655
	ld b,(ix+028h)		;6658
L_665B:
	ld d,000h		;665b
	ld e,(ix+027h)		;665d
	sbc hl,de		;6660
	jp nc,L_6666		;6662
	add hl,de			;6665
L_6666:
	djnz L_665B		;6666
L_6668:
	ld (ix+00ah),l		;6668
	ld (ix+00bh),h		;666b
	set 5,(ix+00dh)		;666e
	ret			;6672
L_6673:
	ld l,(ix+00ah)		;6673   ; deslizamiento hacia arriba: suma la velocidad
	ld h,(ix+00bh)		;6676
	ld d,000h		;6679
	ld e,(ix+027h)		;667b
	add hl,de			;667e
	ld (ix+00ah),l		;667f   ; guarda el periodo
	ld (ix+00bh),h		;6682
	dec (ix+028h)		;6685   ; cuenta atras
	ld a,(ix+028h)		;6688
	or a			;668b
	ret nz			;668c
L_668D:
	res 6,(ix+00dh)		;668d
	call L_66C4		;6691   ; pone el periodo de la nota en (ix+0x0A): el de (ix+0x10) mas el desplazamiento de (ix+0x26) si hay
	ld a,(ix+029h)		;6694
	ld (ix+028h),a		;6697
	ret			;669a
L_669B:
	dec (ix+019h)		;669b   ; canal de ritmo: baja (ix+0x19) y, al llegar a cero, sigue con la siguiente nota del patron (0x6494)
	ret nz			;669e
	ld l,(ix+017h)		;669f
	ld h,(ix+018h)		;66a2
	ld a,(hl)			;66a5
	cp 0ffh		;66a6
	jp z,L_66B3		;66a8
	set 7,(ix+009h)		;66ab
	call L_6494		;66af   ; toca el patron de ritmo: marca el canal y ejecuta sus ordenes
	ret			;66b2
L_66B3:
	res 0,(ix+00eh)		;66b3   ; fin del patron: apaga el canal
	xor a			;66b7
	ld (ix+00ch),a		;66b8
	ld a,(ix+00dh)		;66bb
	and 0f0h		;66be
	ld (ix+00dh),a		;66c0
	ret			;66c3
L_66C4:
	ld e,(ix+010h)		;66c4   ; pone el periodo de la nota en (ix+0x0A): el de (ix+0x10) mas el desplazamiento de (ix+0x26) si hay
	ld d,(ix+011h)		;66c7
	bit 1,(ix+00eh)		;66ca
	jp z,L_66DA		;66ce
	ld a,(ix+026h)		;66d1
	add a,e			;66d4
	ld e,a			;66d5
	jp nc,L_66DA		;66d6
	inc d			;66d9
L_66DA:
	ld (ix+00ah),e		;66da
	ld (ix+00bh),d		;66dd
	ret			;66e0
L_66E1:
	inc (ix+01eh)		;66e1   ; vibrato: cuenta cuadros
	ld a,(ix+01eh)		;66e4
	ld b,(ix+00eh)		;66e7
	bit 4,b		;66ea
	jp nz,L_6703		;66ec
	bit 3,b		;66ef
	jp z,L_6703		;66f1
	cp (ix+01ah)		;66f4   ; con el vibrato en espera compara con el retardo
	ret nz			;66f7
	ld (ix+01eh),000h		;66f8   ; y empieza
	set 4,(ix+00eh)		;66fc
	jp L_6707		;6700
L_6703:
	cp (ix+01bh)		;6703
	ret nz			;6706
L_6707:
	ld e,(ix+00ah)		;6707   ; vibrato: alterna el periodo mas y menos la amplitud
	ld d,(ix+00bh)		;670a   ; periodo actual
	ld b,(ix+01ch)		;670d   ; amplitud
	ld a,(ix+01dh)		;6710   ; invierte el signo del vibrato
	cpl			;6713
	ld (ix+01dh),a		;6714
	and a			;6717
	ld a,e			;6718
	jp nz,L_6725		;6719
	add a,b			;671c
	ld e,a			;671d
	jp nc,L_672B		;671e
	inc d			;6721
	jp L_672B		;6722
L_6725:
	sub b			;6725   ; resta la amplitud al periodo
	ld e,a			;6726
	jp nc,L_672B		;6727
	dec d			;672a
L_672B:
	ld (ix+00ah),e		;672b
	ld (ix+00bh),d		;672e
	ld (ix+01eh),000h		;6731
	ret			;6735
L_6736:
	bit 2,(ix+00dh)		;6736   ; envolvente de volumen (ataque, caida, sostenido y relajacion con los tiempos de (ix+0x21)-(ix+0x24))
	ret nz			;673a
	call L_6742		;673b   ; envolvente del volumen
	ld (ix+00ch),e		;673e
	ret			;6741
L_6742:
	ld e,(ix+00ch)		;6742   ; envolvente del volumen
	inc (ix+01fh)		;6745   ; cuenta de cuadros
	ld b,(ix+01fh)		;6748
	ld a,(ix+024h)		;674b   ; mira si ya acaba la nota
	cp (ix+004h)		;674e
	call nc,L_6802		;6751
	bit 5,(ix+00fh)		;6754   ; segun la fase: ataque, caida, sostenido o relajacion
	jp nz,L_67E8		;6758
	bit 3,(ix+00fh)		;675b
	jp nz,L_679C		;675f
	bit 2,(ix+00fh)		;6762
	jp nz,L_677C		;6766
	ld a,e			;6769   ; ataque: sube el volumen hasta el maximo
	inc a			;676a
	ld e,a			;676b
	cp (ix+012h)		;676c
	ret c			;676f
	set 2,(ix+00fh)		;6770
	ld e,(ix+012h)		;6774
	ld (ix+01fh),000h		;6777
	ret			;677b
L_677C:
	ld a,e			;677c   ; caida: baja el volumen hasta el sostenido
	dec a			;677d
	jp m,L_678A		;677e
	cp (ix+02ah)		;6781
	jp c,L_678A		;6784
	ld e,a			;6787
	jr L_678E		;6788
L_678A:
	ld a,(ix+02ah)		;678a
	ld e,a			;678d
L_678E:
	ld a,b			;678e   ; mira si acaba la caida
	cp (ix+021h)		;678f
	ret c			;6792
	ld (ix+01fh),000h		;6793
	set 3,(ix+00fh)		;6797
	ret			;679b
L_679C:
	bit 4,(ix+00fh)		;679c   ; sostenido
	jp nz,L_67CB		;67a0
	ld a,b			;67a3
	cp (ix+022h)		;67a4
	ret nz			;67a7
	ld a,e			;67a8   ; baja el volumen
	dec a			;67a9
	jp m,L_67C6		;67aa
	cp (ix+02ah)		;67ad
	jr c,L_67C6		;67b0
	ld e,a			;67b2
	inc (ix+020h)		;67b3   ; cuenta las bajadas
	ld a,(ix+020h)		;67b6
	cp (ix+023h)		;67b9
	ld (ix+01fh),000h		;67bc
	ret nz			;67c0
	set 5,(ix+00fh)		;67c1
	ret			;67c5
L_67C6:
	ld a,(ix+02ah)		;67c6
	ld e,a			;67c9
	ret			;67ca
L_67CB:
	ld a,(ix+022h)		;67cb   ; relajacion
	ld d,a			;67ce
	ld a,e			;67cf
	sub d			;67d0
	jp c,L_67DA		;67d1
	cp (ix+02ah)		;67d4
	jp nc,L_67DD		;67d7
L_67DA:
	ld a,(ix+02ah)		;67da
L_67DD:
	ld e,a			;67dd   ; y acaba
	ld a,b			;67de
	cp (ix+023h)		;67df
	ret nz			;67e2
	set 5,(ix+00fh)		;67e3
	ret			;67e7
L_67E8:
	ld a,(ix+024h)		;67e8
	cp (ix+004h)		;67eb
	jr nc,L_67F1		;67ee
	ret			;67f0
L_67F1:
	ld a,e			;67f1   ; baja el volumen de la envolvente
	dec a			;67f2
	jp m,L_67FD		;67f3
	cp (ix+02ah)		;67f6
	jr c,L_67FD		;67f9
	jr L_6800		;67fb
L_67FD:
	ld a,(ix+02ah)		;67fd
L_6800:
	ld e,a			;6800
	ret			;6801
L_6802:
	set 5,(ix+00fh)		;6802
	ret			;6806
L_6807:
	inc hl			;6807   ; avanza el puntero de la musica del canal (HL + 1)
	ld (ix+002h),l		;6808
	ld (ix+003h),h		;680b
	ret			;680e
L_680F:
	ld hl,0cf18h		;680f   ; cuenta atras del ritmo (0xCF16, 0xCF17): al llegar a cero para el ritmo y pone a cero los cinco canales
	ld de,0cf16h		;6812
	ld a,(de)			;6815
	ld b,a			;6816
	inc de			;6817
	ld a,(de)			;6818
	ld c,a			;6819
	inc (hl)			;681a
	ld a,(hl)			;681b
	cp b			;681c
	ret nz			;681d
	ld (hl),000h		;681e
	inc hl			;6820
	inc (hl)			;6821
	ld a,(hl)			;6822
	cp c			;6823
	ret nz			;6824
	ld hl,0cf08h		;6825
	res 0,(hl)		;6828
	xor a			;682a
	ld hl,0cf18h		;682b
	ld (hl),a			;682e
	inc hl			;682f
	ld (hl),a			;6830
	ld de,0002ch		;6831
	ld ix,0ce00h		;6834
	ld hl,0cf08h		;6838
	bit 2,(hl)		;683b
	jr nz,L_686C		;683d
	res 2,a		;683f
	res 0,a		;6841
	ld (0cf08h),a		;6843
	call L_68CB		;6846   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	add ix,de		;6849
	call L_68CB		;684b   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	add ix,de		;684e
	call L_68CB		;6850   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	add ix,de		;6853
	call L_68CB		;6855   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	add ix,de		;6858
	call L_68CB		;685a   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	ld a,(0cf25h)		;685d
	bit 2,a		;6860
	ret z			;6862
	ld a,(0cf08h)		;6863
	set 4,a		;6866
	ld (0cf08h),a		;6868
	ret			;686b
L_686C:
	ld a,(0cf08h)		;686c
	res 2,a		;686f
	ld (0cf08h),a		;6871
	ret			;6874
L_6875:
	xor a			;6875   ; pone a cero los campos del canal
	ld (ix+000h),a		;6876
	ld (ix+001h),a		;6879
	ld (ix+005h),a		;687c
	ld (ix+006h),a		;687f
	ld (ix+00ah),a		;6882   ; el periodo
	ld (ix+00bh),a		;6885
	ld (ix+00ch),a		;6888
	ld (ix+00dh),a		;688b
	ld (ix+00eh),a		;688e
	ld (ix+00fh),a		;6891
	ld (ix+029h),a		;6894
	ld (ix+02bh),a		;6897
	ret			;689a
L_689B:
	bit 2,(ix+00dh)		;689b   ; resta el fundido (0xCF19) al volumen E (no baja de cero)
	jp nz,L_68AD		;689f
	ld a,(0cf19h)		;68a2
	ld b,a			;68a5
	ld a,e			;68a6
	sub b			;68a7
	ld e,000h		;68a8
	ret m			;68aa
	ld e,a			;68ab
	ret			;68ac
L_68AD:
	ld e,000h		;68ad
	ret			;68af
L_68B0:
	ld a,(0cf2eh)		;68b0   ; fundido de salida del PSG: cuenta cuadros
	ld b,a			;68b3
	ld hl,0cf18h		;68b4
	inc (hl)			;68b7
	ld a,(hl)			;68b8
	cp b			;68b9
	ret nz			;68ba
	ld (hl),000h		;68bb   ; cuando llega baja el nivel
	inc hl			;68bd
	dec (hl)			;68be
	ret nz			;68bf
	ld hl,0cf08h		;68c0
	res 5,(hl)		;68c3
	ld hl,0cf18h		;68c5
	ld (hl),000h		;68c8
	ret			;68ca
L_68CB:
	ld a,(ix+000h)		;68cb   ; fin de un canal: si era el 0x0D pide el sonido 0x18
	cp 00dh		;68ce
	call z,L_6941		;68d0   ; pide el sonido 0x18 cuando acaba un canal de efecto
	xor a			;68d3   ; pone a cero los campos
	ld (ix+000h),a		;68d4
	ld (ix+001h),a		;68d7
	ld (ix+005h),a		;68da
	ld (ix+006h),a		;68dd
	ld (ix+00ah),a		;68e0
	ld (ix+00bh),a		;68e3
	ld (ix+00ch),a		;68e6
	ld (ix+00dh),a		;68e9
	ld (ix+00eh),a		;68ec
	ld (ix+00fh),a		;68ef
	ld (ix+029h),a		;68f2
	ld (ix+02bh),a		;68f5
	call L_6913		;68f8   ; revisa la pareja de canales
	ld hl,0cf1eh		;68fb
	ld a,(0cf1bh)		;68fe
	cp 008h		;6901
	jp nz,L_6910		;6903
	res 1,(hl)		;6906
	bit 3,(hl)		;6908
	ret z			;690a
	res 3,(hl)		;690b
	set 2,(hl)		;690d
	ret			;690f
L_6910:
	res 3,(hl)		;6910
	ret			;6912
L_6913:
	ld hl,0cf22h		;6913   ; vuelve a conectar la pareja de canales del PSG
	ld a,(0cf1bh)		;6916   ; elige la pareja segun el canal que acaba
	cp 010h		;6919   ; el canal 5 (0x10)
	jp z,L_6939		;691b
	cp 008h		;691e   ; el canal 4 (0x08)
	jp z,L_6931		;6920
	cp 004h		;6923   ; el canal 3 (0x04)
	jp z,L_692E		;6925
	cp 002h		;6928   ; el canal 2 (0x02)
	ret nz			;692a
	res 3,(hl)		;692b
	ret			;692d
L_692E:
	res 1,(hl)		;692e
	ret			;6930
L_6931:
	ld a,(0ce58h)		;6931
	or a			;6934
	ret z			;6935
	set 1,(hl)		;6936
	ret			;6938
L_6939:
	ld a,(0ce2ch)		;6939
	or a			;693c
	ret z			;693d
	set 3,(hl)		;693e
	ret			;6940
L_6941:
	ld a,(0cf1bh)		;6941   ; pide el sonido 0x18 cuando acaba un canal de efecto
	cp 004h		;6944
	ret c			;6946
	ld a,018h		;6947
	call L_6010		;6949
	ret			;694c
L_694D:
	cp 0e0h		;694d   ; decide la tabla de la orden
	jp c,L_6B84		;694f
	and 01fh		;6952   ; de 0xE0 a 0xFF por la tabla de 0x6962
	push hl			;6954
	ld hl,06962h		;6955
	add a,a			;6958
	ld e,a			;6959
	ld d,000h		;695a
	add hl,de			;695c
	ld e,(hl)			;695d
	inc hl			;695e
	ld d,(hl)			;695f
	ex de,hl			;6960
	jp (hl)			;6961

; ----------------------------------------------------------------------
; DATOS tabla_ordenes_E0: los 31 punteros a las rutinas de las ordenes
;   0xE0-0xFE de la musica (p12:694D)
;   0x6962..0x69a0  (62 bytes)
DATA_tabla_ordenes_E0:
	defw 069a0h,069b6h,069a0h,069b6h,069d6h,06a01h,06a15h,06a25h	; 6962
	defw 06a37h,06a48h,06a4fh,06a56h,06aa5h,06aafh,06ab6h,06ac1h	; 6972
	defw 06ac7h,06ad1h,06aech,06afbh,06afbh,06b01h,06b07h,06b11h	; 6982
	defw 06b11h,06b18h,06b23h,06b2bh,06b46h,06b5dh,06b61h	; 6992

; ======================================================================
; CODIGO 0x69a0..0x6b94  (500 bytes)
; ======================================================================


L_69A0:
	pop hl			;69a0   ; orden 0xE0/0xE2: tipo de canal (ix+0x0D) y su tempo (ix+0x13)
L_69A1:
	res 6,(ix+00eh)		;69a1   ; orden de tipo de canal
	ld a,(hl)			;69a5   ; el tipo en los dos bits bajos
	and 003h		;69a6
	ld (ix+00dh),a		;69a8
	ld b,a			;69ab
	inc hl			;69ac
	ld a,(hl)			;69ad   ; y el tempo en el byte siguiente
	ld (ix+013h),a		;69ae
	ld a,b			;69b1
	or a			;69b2
	ret nz			;69b3
	dec hl			;69b4
	ret			;69b5
L_69B6:
	pop hl			;69b6   ; orden 0xE1/0xE3: lo mismo conectando el ritmo (0xCF1E)
	ld a,(0cf1bh)		;69b7
	cp 008h		;69ba
	ld a,(0cf1eh)		;69bc
	jp nz,L_69CC		;69bf
	set 0,a		;69c2
	res 1,a		;69c4
	ld (0cf1eh),a		;69c6
	jp L_69A1		;69c9
L_69CC:
	set 2,a		;69cc
	res 3,a		;69ce
	ld (0cf1eh),a		;69d0
	jp L_69A1		;69d3
L_69D6:
	pop hl			;69d6   ; orden de ruido
	inc hl			;69d7
	ld a,(hl)			;69d8   ; el periodo en los 5 bits bajos
	and 01fh		;69d9
	ld b,a			;69db
	ld a,(0cf1bh)		;69dc
	cp 008h		;69df
	ld a,b			;69e1
	jp nz,L_69F3		;69e2
	ld (0cf1ch),a		;69e5   ; canal 3: ruido en 0xCF1C
	ld a,(0cf1eh)		;69e8
	set 0,a		;69eb
	res 1,a		;69ed
	ld (0cf1eh),a		;69ef
	ret			;69f2
L_69F3:
	ld (0cf1dh),a		;69f3   ; canal 4: ruido en 0xCF1D
	ld a,(0cf1eh)		;69f6
	set 2,a		;69f9
	res 3,a		;69fb
	ld (0cf1eh),a		;69fd
	ret			;6a00
L_6A01:
	pop hl			;6a01   ; orden 0xE5: envolvente del PSG (R13) en 0xCF1F, y las dos siguientes (R12, R11)
	inc hl			;6a02
	res 3,(ix+00dh)		;6a03
	ld a,(hl)			;6a07
	ld (0cf1fh),a		;6a08
	ld de,0cf1eh		;6a0b
	ld a,(de)			;6a0e
	set 5,a		;6a0f
	ld (de),a			;6a11
	jp L_6A16		;6a12
L_6A15:
	pop hl			;6a15   ; orden 0xE6: periodo de la envolvente (R12) en 0xCF21
L_6A16:
	inc hl			;6a16   ; orden de envolvente: periodo
	ld a,(hl)			;6a17
	ld (0cf21h),a		;6a18
	ld de,0cf1eh		;6a1b   ; pone el bit 6 de 0xCF1E
	ld a,(de)			;6a1e
	set 6,a		;6a1f
	ld (de),a			;6a21
	jp L_6A26		;6a22
L_6A25:
	pop hl			;6a25   ; orden 0xE7: periodo de la envolvente (R11) en 0xCF20
L_6A26:
	inc hl			;6a26   ; orden de envolvente: segundo periodo
	ld a,(hl)			;6a27
	ld (0cf20h),a		;6a28
	ld de,0cf1eh		;6a2b
	ld a,(de)			;6a2e
	set 7,a		;6a2f
	ld (de),a			;6a31
	set 2,(ix+00dh)		;6a32
	ret			;6a36
L_6A37:
	pop hl			;6a37   ; orden 0xE8: apaga el ruido y el ritmo del canal
	ld de,0cf1eh		;6a38
	ld a,(de)			;6a3b
	and 01fh		;6a3c
	ld (de),a			;6a3e
	ld a,(ix+00dh)		;6a3f
	and 0f3h		;6a42
	ld (ix+00dh),a		;6a44
	ret			;6a47
L_6A48:
	pop hl			;6a48   ; orden 0xE9: tempo del canal (ix+0x14)
	inc hl			;6a49
	ld a,(hl)			;6a4a
	ld (ix+014h),a		;6a4b
	ret			;6a4e
L_6A4F:
	pop hl			;6a4f   ; orden 0xEA: volumen base del canal (ix+0x15)
	inc hl			;6a50
	ld a,(hl)			;6a51
	ld (ix+015h),a		;6a52
	ret			;6a55
L_6A56:
	pop hl			;6a56   ; envolvente: nibble alto del primer byte
	inc hl			;6a57
	ld a,(hl)			;6a58
	and 0f0h		;6a59
	rrca			;6a5b
	rrca			;6a5c
	rrca			;6a5d
	rrca			;6a5e
	cp 008h		;6a5f
	jp nc,L_6A68		;6a61
	set 2,(ix+00fh)		;6a64   ; si es menor de 8 pone el bit 2
L_6A68:
	res 3,a		;6a68
	inc a			;6a6a
	bit 2,(ix+00fh)		;6a6b
	jp nz,L_6A76		;6a6f
	set 1,(ix+00fh)		;6a72
L_6A76:
	ld (ix+021h),a		;6a76   ; guarda la duracion del ataque
	ld a,(hl)			;6a79   ; nibble bajo
	and 00fh		;6a7a
	cp 008h		;6a7c
	res 4,(ix+00fh)		;6a7e
	jp c,L_6A89		;6a82   ; si es menor de 8 limpia el bit 4
	set 4,(ix+00fh)		;6a85
L_6A89:
	res 3,a		;6a89   ; guarda la caida
	inc a			;6a8b
	ld (ix+022h),a		;6a8c
	inc hl			;6a8f
	ld a,(hl)			;6a90   ; el segundo byte: sostenido y relajacion
	and 0f0h		;6a91
	rrca			;6a93
	rrca			;6a94
	rrca			;6a95
	rrca			;6a96
	ld (ix+023h),a		;6a97   ; guarda el sostenido
	ld a,(hl)			;6a9a
	and 00fh		;6a9b
	ld (ix+024h),a		;6a9d   ; guarda la relajacion
	set 0,(ix+00fh)		;6aa0
	ret			;6aa4
L_6AA5:
	pop hl			;6aa5   ; orden 0xEC: sin envolvente
	res 0,(ix+00fh)		;6aa6
	res 1,(ix+00fh)		;6aaa
	ret			;6aae
L_6AAF:
	pop hl			;6aaf   ; orden 0xED: volumen de sostenido (ix+0x25)
	inc hl			;6ab0
	ld a,(hl)			;6ab1
	ld (ix+025h),a		;6ab2
	ret			;6ab5
L_6AB6:
	pop hl			;6ab6   ; orden 0xEE: transposicion (ix+0x26)
	inc hl			;6ab7
	ld a,(hl)			;6ab8
	ld (ix+026h),a		;6ab9
	set 1,(ix+00eh)		;6abc
	ret			;6ac0
L_6AC1:
	pop hl			;6ac1   ; orden 0xEF: sin transposicion
	res 1,(ix+00eh)		;6ac2
	ret			;6ac6
L_6AC7:
	pop hl			;6ac7   ; orden 0xF0: sin vibrato ni transposicion
	ld a,(ix+00eh)		;6ac8
	and 0e2h		;6acb
	ld (ix+00eh),a		;6acd
	ret			;6ad0
L_6AD1:
	pop hl			;6ad1   ; vibrato: pone los bits 2 y 4 de (ix+0x0E)
	inc hl			;6ad2
	ld a,(ix+00eh)		;6ad3
	or 014h		;6ad6
	ld (ix+00eh),a		;6ad8
	ld a,(hl)			;6adb   ; amplitud en el nibble bajo
	and 00fh		;6adc
	ld (ix+01ch),a		;6ade
	ld a,(hl)			;6ae1
	and 0f0h		;6ae2   ; retardo en el alto
	rrca			;6ae4
	rrca			;6ae5
	rrca			;6ae6
	rrca			;6ae7
	ld (ix+01bh),a		;6ae8
	ret			;6aeb
L_6AEC:
	pop hl			;6aec   ; orden 0xF2: vibrato con el retardo de (ix+0x1A)
	inc hl			;6aed
	ld a,(hl)			;6aee
	ld (ix+01ah),a		;6aef
	ld a,(ix+00eh)		;6af2
	or 00ch		;6af5
	ld (ix+00eh),a		;6af7
	ret			;6afa
L_6AFB:
	pop hl			;6afb   ; orden 0xF3/0xF4: el siguiente tono va por un byte (bit 6 de (ix+0x0E))
	set 6,(ix+00eh)		;6afc
	ret			;6b00
L_6B01:
	pop hl			;6b01   ; orden 0xF5: el siguiente tono va por nibbles (bit 5)
	set 5,(ix+00eh)		;6b02
	ret			;6b06
L_6B07:
	pop hl			;6b07   ; orden 0xF6: quita los dos modos
	ld a,(ix+00eh)		;6b08
	and 09fh		;6b0b
	ld (ix+00eh),a		;6b0d
	ret			;6b10
L_6B11:
	pop hl			;6b11   ; orden 0xF7/0xF8: octava (ix+0x01)
	inc hl			;6b12
	ld a,(hl)			;6b13
	ld (ix+001h),a		;6b14
	ret			;6b17
L_6B18:
	pop hl			;6b18   ; orden 0xF9: llamada a una subrutina de musica: guarda la posicion (ix+7, ix+8) y salta a la direccion que sigue
	call L_6B38		;6b19   ; lee la direccion de salto que sigue a la orden y apunta HL a su byte anterior
	ld (ix+007h),e		;6b1c
	ld (ix+008h),d		;6b1f
	ret			;6b22
L_6B23:
	pop hl			;6b23   ; orden 0xFA: vuelve de la subrutina a la posicion guardada
	ld l,(ix+007h)		;6b24
	ld h,(ix+008h)		;6b27
	ret			;6b2a
L_6B2B:
	pop hl			;6b2b   ; orden 0xFB: bucle con contador (ix+5): cuenta, y salta a la direccion mientras no llegue
	inc hl			;6b2c
	ld a,(ix+005h)		;6b2d
	inc a			;6b30
	cp (hl)			;6b31
	jp z,L_6B3F		;6b32
	ld (ix+005h),a		;6b35
L_6B38:
	inc hl			;6b38   ; lee la direccion de salto que sigue a la orden y apunta HL a su byte anterior
	ld e,(hl)			;6b39
	inc hl			;6b3a
	ld d,(hl)			;6b3b
	ex de,hl			;6b3c
	dec hl			;6b3d
	ret			;6b3e
L_6B3F:
	inc hl			;6b3f
	inc hl			;6b40
	ld (ix+005h),000h		;6b41
	ret			;6b45
L_6B46:
	pop hl			;6b46   ; orden 0xFC: igual con otro contador (ix+6)
	inc hl			;6b47
	ld a,(ix+006h)		;6b48
	inc a			;6b4b
	cp (hl)			;6b4c
	jp z,L_6B56		;6b4d
	ld (ix+006h),a		;6b50
	jp L_6B38		;6b53
L_6B56:
	inc hl			;6b56
	inc hl			;6b57
	ld (ix+006h),000h		;6b58
	ret			;6b5c
L_6B5D:
	pop hl			;6b5d   ; orden 0xFD: salto a una direccion
	jp L_6B38		;6b5e
L_6B61:
	pop hl			;6b61   ; orden de tipo de nota
	inc hl			;6b62
	ld a,(hl)			;6b63
	ld (ix+009h),a		;6b64
	cp 004h		;6b67   ; con tipo menor de 4 limpia el bit 0 de (ix+0x0E)
	jp c,L_6B7F		;6b69
	ld a,(ix+00eh)		;6b6c   ; con tipo mayor lo pone y limpia el resto
	set 0,a		;6b6f
	and 011h		;6b71
	ld (ix+00eh),a		;6b73
	res 0,(ix+00fh)		;6b76
	res 1,(ix+00fh)		;6b7a
	ret			;6b7e
L_6B7F:
	res 0,(ix+00eh)		;6b7f
	ret			;6b83
L_6B84:
	and 00fh		;6b84   ; comando D0-DF
	push hl			;6b86
	ld hl,06b94h		;6b87
	add a,a			;6b8a   ; indice por dos en la tabla de 0x6B94
	ld e,a			;6b8b
	ld d,000h		;6b8c
	add hl,de			;6b8e
	ld e,(hl)			;6b8f
	inc hl			;6b90
	ld d,(hl)			;6b91
	ex de,hl			;6b92
	jp (hl)			;6b93

; ----------------------------------------------------------------------
; DATOS tabla_ordenes_D0: los 16 punteros a las rutinas de las ordenes
;   0xD0-0xDF de la musica (p12:6B84)
;   0x6b94..0x6bb4  (32 bytes)
DATA_tabla_ordenes_D0:
	defw 06bb4h,06bb4h,06bb4h,06bb4h,06bb4h,06bb4h,06bbch,06bd7h	; 6b94
	defw 06beeh,06bf8h,06bf8h,06bfah,06c01h,06bf8h,06bf8h,06c07h	; 6ba4

; ======================================================================
; CODIGO 0x6bb4..0x6d4f  (411 bytes)
; ======================================================================


L_6BB4:
	pop hl			;6bb4   ; orden 0xD0-0xD5: instrumento (ix+0x16)
	ld a,(hl)			;6bb5
	and 00fh		;6bb6
	ld (ix+016h),a		;6bb8
	ret			;6bbb
L_6BBC:
	pop hl			;6bbc   ; deslizamiento hacia arriba: pone los bits 4 y 6 de (ix+0x0D)
	ld a,(ix+00dh)		;6bbd
	or 050h		;6bc0
	ld (ix+00dh),a		;6bc2
	res 7,(ix+00dh)		;6bc5
	inc hl			;6bc9   ; velocidad y duracion
	ld a,(hl)			;6bca
	ld (ix+027h),a		;6bcb
	inc hl			;6bce
	ld a,(hl)			;6bcf
	ld (ix+028h),a		;6bd0
	ld (ix+029h),a		;6bd3
	ret			;6bd6
L_6BD7:
	pop hl			;6bd7   ; deslizamiento hacia abajo
	ld a,(ix+00dh)		;6bd8
	or 0d0h		;6bdb
	ld (ix+00dh),a		;6bdd
	inc hl			;6be0   ; velocidad y duracion
	ld a,(hl)			;6be1
	ld (ix+027h),a		;6be2
	inc hl			;6be5
	ld a,(hl)			;6be6
	ld (ix+028h),a		;6be7
	ld (ix+029h),a		;6bea
	ret			;6bed
L_6BEE:
	pop hl			;6bee   ; orden 0xD8: sin deslizamiento
	ld a,(ix+00dh)		;6bef
	and 00fh		;6bf2
	ld (ix+00dh),a		;6bf4
	ret			;6bf7
L_6BF8:
	pop hl			;6bf8   ; ordenes sin efecto (0xD9, 0xDC, 0xDD)
	ret			;6bf9
L_6BFA:
	pop hl			;6bfa   ; orden 0xDB: volumen minimo (ix+0x2A)
	inc hl			;6bfb
	ld a,(hl)			;6bfc
	ld (ix+02ah),a		;6bfd
	ret			;6c00
L_6C01:
	pop hl			;6c01   ; orden 0xDC: sin volumen minimo
	xor a			;6c02
	ld (ix+02ah),a		;6c03
	ret			;6c06
L_6C07:
	pop hl			;6c07   ; orden 0xDF: nivel de volumen
	set 7,(ix+00eh)		;6c08
	sub 005h		;6c0c
	ld (ix+015h),a		;6c0e
	ret			;6c11
vuelca_psg:		; vuelca los canales al PSG
	ld hl,0cf22h		;6c12   ; VUELCA AL PSG: decide a que registros va cada pareja de canales segun el volumen (0xCF22) y los escribe
	res 0,(hl)		;6c15
	ld a,(0ce59h)		;6c17
	ld b,a			;6c1a
	ld a,(0ce85h)		;6c1b
	cp b			;6c1e
	jp c,L_6C24		;6c1f
	set 0,(hl)		;6c22
L_6C24:
	res 2,(hl)		;6c24   ; compara los volumenes de los canales 1 y 4 para elegir el del PSG
	ld a,(0ce2dh)		;6c26
	ld b,a			;6c29
	ld a,(0ceb1h)		;6c2a
	cp b			;6c2d
	jp c,L_6C33		;6c2e
	set 2,(hl)		;6c31   ; si gana el canal 4 pone el bit 2
L_6C33:
	call L_6C40		;6c33   ; escribe los tres tonos (R0-R5) y los volumenes (R8-R10)
	call L_6CAD		;6c36   ; el ruido (R6)
	call L_6CD7		;6c39   ; la envolvente (R11, R12, R13)
	call L_6D05		;6c3c   ; mezclador (R7): une los bits de cada canal (tablas 0x6D4F, 0x6D53, 0x6D57)
	ret			;6c3f
L_6C40:
	ld b,000h		;6c40   ; escribe los tres tonos (R0-R5) y los volumenes (R8-R10)
	ld c,008h		;6c42
	ld hl,0ce0ah		;6c44
	call L_6C8F		;6c47   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
	ld hl,0cf22h		;6c4a
	bit 2,(hl)		;6c4d
	jp nz,L_6C67		;6c4f
	bit 3,(hl)		;6c52
	jp z,L_6C5E		;6c54
	res 3,(hl)		;6c57
	ld a,008h		;6c59
	ld (0ce38h),a		;6c5b
L_6C5E:
	ld hl,0ce36h		;6c5e
	call L_6C8F		;6c61   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
	jp L_6C6D		;6c64
L_6C67:
	ld hl,0cebah		;6c67
	call L_6C8F		;6c6a   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
L_6C6D:
	ld hl,0cf22h		;6c6d   ; elige el canal de la pareja C del PSG
	bit 0,(hl)		;6c70
	jp nz,L_6C88		;6c72
	bit 1,(hl)		;6c75
	jp z,L_6C81		;6c77
	res 1,(hl)		;6c7a   ; el canal 4 con el aviso pone el volumen 6
	ld a,006h		;6c7c
	ld (0ce64h),a		;6c7e
L_6C81:
	ld hl,0ce62h		;6c81
	call L_6C8F		;6c84   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
	ret			;6c87
L_6C88:
	ld hl,0ce8eh		;6c88
	call L_6C8F		;6c8b   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
	ret			;6c8e
L_6C8F:
	ld e,(hl)			;6c8f   ; escribe en el PSG el periodo (dos registros) y el volumen del canal HL
	ld a,b			;6c90
	call 00093h		;6c91   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6c94
	inc b			;6c95
	ld e,(hl)			;6c96
	ld a,b			;6c97
	call 00093h		;6c98   ; BIOS WRTPSG - Writes data to PSG-register
	inc hl			;6c9b
	ld e,(hl)			;6c9c
	ld a,c			;6c9d
	inc b			;6c9e
	inc c			;6c9f
	inc hl			;6ca0
	bit 3,(hl)		;6ca1
	ret nz			;6ca3
	call 00093h		;6ca4   ; BIOS WRTPSG - Writes data to PSG-register
	bit 2,(hl)		;6ca7
	ret z			;6ca9
	set 3,(hl)		;6caa
	ret			;6cac
L_6CAD:
	ld hl,0cf1eh		;6cad   ; el ruido (R6)
	bit 0,(hl)		;6cb0
	jp z,L_6CC3		;6cb2
	res 0,(hl)		;6cb5
	set 1,(hl)		;6cb7
	ld a,(0cf1ch)		;6cb9
	ld e,a			;6cbc
	ld a,006h		;6cbd
	call 00093h		;6cbf   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6cc2
L_6CC3:
	bit 1,(hl)		;6cc3   ; el ruido: segun los bits de 0xCF1E
	ret nz			;6cc5
	bit 2,(hl)		;6cc6
	ret z			;6cc8
	res 2,(hl)		;6cc9   ; escribe el periodo del ruido
	set 3,(hl)		;6ccb
	ld a,(0cf1dh)		;6ccd
	ld e,a			;6cd0   ; de 0xCF1D
	ld a,006h		;6cd1
	call 00093h		;6cd3   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6cd6
L_6CD7:
	ld hl,0cf1eh		;6cd7   ; la envolvente (R11, R12, R13)
	bit 7,(hl)		;6cda
	ret z			;6cdc
	res 7,(hl)		;6cdd
	ld a,(0cf20h)		;6cdf
	ld e,a			;6ce2
	ld a,00bh		;6ce3
	call 00093h		;6ce5   ; BIOS WRTPSG - Writes data to PSG-register
	bit 6,(hl)		;6ce8
	ret z			;6cea
	res 6,(hl)		;6ceb
	ld a,(0cf21h)		;6ced
	ld e,a			;6cf0
	ld a,00ch		;6cf1
	call 00093h		;6cf3   ; BIOS WRTPSG - Writes data to PSG-register
	bit 5,(hl)		;6cf6
	ret z			;6cf8
	res 5,(hl)		;6cf9
	ld a,(0cf1fh)		;6cfb
	ld e,a			;6cfe
	ld a,00dh		;6cff
	call 00093h		;6d01   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6d04
L_6D05:
	ld hl,0ce0dh		;6d05   ; mezclador (R7): une los bits de cada canal (tablas 0x6D4F, 0x6D53, 0x6D57)
	ld a,(hl)			;6d08
	ld hl,06d4fh		;6d09
	call L_6D48		;6d0c   ; HL += A & 3
	ld b,(hl)			;6d0f
	ld a,(0cf22h)		;6d10
	bit 2,a		;6d13
	ld hl,0ce39h		;6d15
	jp z,L_6D1E		;6d18
	ld hl,0cebdh		;6d1b
L_6D1E:
	ld a,(hl)			;6d1e
	ld hl,06d53h		;6d1f
	call L_6D48		;6d22   ; HL += A & 3
	ld c,(hl)			;6d25
	ld a,(0cf22h)		;6d26
	bit 0,a		;6d29
	ld hl,0ce65h		;6d2b
	jp z,L_6D34		;6d2e
	ld hl,0ce91h		;6d31
L_6D34:
	ld a,(hl)			;6d34
	ld hl,06d57h		;6d35
	call L_6D48		;6d38   ; HL += A & 3
	ld a,(hl)			;6d3b
	or b			;6d3c
	or c			;6d3d
L_6D3E:
	ld e,a			;6d3e
	ld (0cf1ah),a		;6d3f
	ld a,007h		;6d42
	call 00093h		;6d44   ; BIOS WRTPSG - Writes data to PSG-register
	ret			;6d47
L_6D48:
	and 003h		;6d48   ; HL += A & 3
	ld e,a			;6d4a
	ld d,000h		;6d4b
	add hl,de			;6d4d
	ret			;6d4e

; ----------------------------------------------------------------------
; DATOS tablas_mezclador: tres tablas de 4 bytes con los bits del mezclador
;   del PSG (R7) de cada pareja de canales (p12:6D0C, 6D22 y 6D38)
;   0x6d4f..0x6d5b  (12 bytes)
DATA_tablas_mezclador:
	defb 089h,081h,088h,080h	; 6d4f
	defb 092h,082h,090h,080h	; 6d53
	defb 0a4h,084h,0a0h,080h	; 6d57

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6D5B: 12 palabras (una por nota 0x0-0xB) que apuntan a los
;   patrones de ritmo del tipo 0x04 (p12:64D9)
;   0x6d5b..0x6d73  (24 bytes)
DATA_ritmo_tabla_6D5B:
	defw 06d73h,06d73h,06d73h,06d73h,06d73h,06d73h,06d73h,06d73h	; 6d5b
	defw 06d73h,06d73h,06d73h,06d73h	; 6d6b  -> DATA_ritmo_tabla_6D73 DATA_ritmo_tabla_6D73 DATA_ritmo_tabla_6D73 DATA_ritmo_tabla_6D73

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6D73: 12 palabras (una por nota) con los patrones de ritmo
;   de otro tipo (p12:64F9)
;   0x6d73..0x6d8b  (24 bytes)
DATA_ritmo_tabla_6D73:
	defw 06d8bh,06d8bh,06d8bh,06d8bh,06d8bh,06d8bh,06d8bh,06d8bh	; 6d73
	defw 06d8bh,06d8bh,06d8bh,06d8bh	; 6d83  -> DATA_ritmo_tabla_6D8B DATA_ritmo_tabla_6D8B DATA_ritmo_tabla_6D8B DATA_ritmo_tabla_6D8B

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6D8B: 12 palabras (una por nota) con los patrones de ritmo
;   de otros tipos (p12:64ED, 64FD, 650D)
;   0x6d8b..0x6da3  (24 bytes)
DATA_ritmo_tabla_6D8B:
	defw 06da3h,06da3h,06da3h,06da3h,06da3h,06da3h,06da3h,06da3h	; 6d8b
	defw 06da3h,06da3h,06da3h,06da3h	; 6d9b  -> DATA_ritmo_tabla_6DA3 DATA_ritmo_tabla_6DA3 DATA_ritmo_tabla_6DA3 DATA_ritmo_tabla_6DA3

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6DA3: 10 palabras con los patrones de ritmo del tipo 0x04
;   de la octava 1 (p12:64D9)
;   0x6da3..0x6db7  (20 bytes)
DATA_ritmo_tabla_6DA3:
	defw 06db7h,06dbeh,06dd1h,06de6h,06dffh,06e08h,06e08h,06e08h	; 6da3
	defw 06e08h,06e08h	; 6db3

; ----------------------------------------------------------------------
; DATOS ritmo_patrones_6DB7: cinco patrones de ritmo (flujos de ordenes y
;   notas, p12:6368) a los que apuntan las tablas de arriba
;   0x6db7..0x6e17  (96 bytes)
DATA_ritmo_patrones_6DB7:
	defb 0e1h,001h,0e4h,000h,008h,006h,0ffh,0e3h,001h,0e4h,004h,085h,000h,0e4h,000h,0e1h	; 6db7  ................
	defb 004h,007h,006h,005h,004h,003h,002h,001h,000h,0ffh,0e1h,001h,0e4h,014h,006h,0e2h	; 6dc7  ................
	defb 001h,062h,000h,0e1h,002h,0e4h,010h,002h,001h,0e1h,001h,0e4h,006h,001h,0ffh,0e3h	; 6dd7  .b..............
	defb 001h,0e5h,001h,000h,030h,001h,0b0h,0e8h,0e1h,001h,0e4h,006h,007h,006h,005h,004h	; 6de7  ....0...........
	defb 003h,002h,001h,000h,000h,000h,000h,0ffh,0e3h,001h,080h,009h,070h,003h,050h,003h	; 6df7  ............p.P.
	defb 0ffh,0e2h,001h,0e5h,009h,001h,0a0h,094h,050h,096h,000h,097h,000h,098h,000h,0ffh	; 6e07  ........P.......

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6E17: 10 palabras con los patrones de ritmo de las notas
;   0-9 del tipo 0x08 (p12:64DD)
;   0x6e17..0x6e2b  (20 bytes)
DATA_ritmo_tabla_6E17:
	defw 06e2bh,06e2fh,06eb8h,06ed2h,06eech,06f06h,06f20h,06f20h	; 6e17
	defw 06f20h,06f20h	; 6e27  -> DATA_ritmo_tabla_6F20 DATA_ritmo_tabla_6F20

; ----------------------------------------------------------------------
; DATOS ritmo_patrones_6E2B: los patrones de ritmo del tipo 0x08: flujos de
;   ordenes y notas que acaban en 0xFF
;   0x6e2b..0x6f20  (245 bytes)
DATA_ritmo_patrones_6E2B:
	defb 0e2h,001h,0eeh,006h,0e2h,001h,040h,085h,050h,093h,060h,084h,070h,092h,080h,082h	; 6e2b  ......@.P.`.p...
	defb 090h,090h,090h,080h,090h,08dh,090h,082h,090h,090h,080h,084h,090h,075h,0a0h,084h	; 6e3b  .............u..
	defb 0a0h,078h,0a0h,088h,0a0h,07ah,0a0h,08bh,0a0h,082h,0a0h,08dh,0a0h,084h,0a0h,08fh	; 6e4b  .x...z..........
	defb 090h,086h,090h,090h,080h,087h,080h,094h,070h,089h,070h,096h,070h,08bh,060h,098h	; 6e5b  ........p.p.p.`.
	defb 060h,08dh,050h,099h,050h,08fh,050h,098h,050h,090h,050h,094h,050h,091h,050h,095h	; 6e6b  `.P.P.P.P.P.P.P.
	defb 050h,092h,050h,096h,050h,093h,050h,097h,050h,094h,050h,098h,050h,095h,050h,099h	; 6e7b  P.P.P.P.P.P.P.P.
	defb 050h,096h,040h,09ah,040h,097h,040h,09bh,040h,098h,040h,09ch,0e2h,002h,040h,099h	; 6e8b  P.@.@.@.@.@...@.
	defb 040h,09dh,040h,09ah,040h,09eh,040h,09bh,040h,09fh,040h,09ch,040h,0a0h,040h,09dh	; 6e9b  @.@.@.@.@.@.@.@.
	defb 030h,0a1h,030h,09eh,030h,0a2h,020h,09fh,020h,0a3h,020h,0a0h,0ffh,0e2h,002h,090h	; 6eab  0.0.0. . . .....
	defb 046h,0f5h,090h,080h,080h,080h,070h,070h,070h,060h,050h,040h,030h,040h,050h,060h	; 6ebb  F.....ppp`P@0@P`
	defb 050h,040h,030h,020h,020h,0f6h,0ffh,0e2h,002h,090h,035h,0f5h,080h,070h,060h,050h	; 6ecb  P@0  .....5..p`P
	defb 040h,050h,060h,070h,060h,050h,040h,030h,040h,050h,060h,050h,040h,030h,020h,0f6h	; 6edb  @P`p`P@0@P`P@0 .
	defb 0ffh,0e2h,002h,090h,070h,0f5h,090h,080h,080h,080h,070h,070h,070h,060h,050h,040h	; 6eeb  ....p.....ppp`P@
	defb 030h,040h,050h,060h,050h,040h,030h,020h,020h,0f6h,0ffh,0e2h,002h,090h,054h,0f5h	; 6efb  0@P`P@0  .....T.
	defb 080h,070h,060h,050h,040h,050h,060h,070h,060h,050h,040h,030h,040h,050h,060h,050h	; 6f0b  .p`P@P`p`P@0@P`P
	defb 040h,030h,020h,0f6h,0ffh	; 6f1b

; ----------------------------------------------------------------------
; DATOS ritmo_tabla_6F20: 12 palabras (una por nota) con los patrones del tipo
;   0x03 (p12:64E9)
;   0x6f20..0x6f38  (24 bytes)
DATA_ritmo_tabla_6F20:
	defw 06f39h,06f38h,06f38h,06f38h,06f4ch,06f5fh,06f38h,06f38h	; 6f20
	defw 06f38h,06f38h,06f38h,06f38h	; 6f30  -> DATA_ritmo_patrones_6F38 DATA_ritmo_patrones_6F38 DATA_ritmo_patrones_6F38 DATA_ritmo_patrones_6F38

; ----------------------------------------------------------------------
; DATOS ritmo_patrones_6F38: un flujo vacio (0xFF) y tres patrones de ritmo
;   con la nota repetida (0x6F39, 0x6F4C, 0x6F5F)
;   0x6f38..0x6f72  (58 bytes)
DATA_ritmo_patrones_6F38:
	defb 0ffh,0e2h,004h,070h,035h,060h,035h,050h,035h,040h,035h,030h,035h,020h,035h,010h	; 6f38  ...p5`5P5@505 5.
	defb 035h,000h,035h,0ffh,0e2h,004h,070h,02ah,060h,02ah,050h,02ah,040h,02ah,030h,02ah	; 6f48  5.5...p*`*P*@*0*
	defb 020h,02ah,010h,02ah,000h,02ah,0ffh,0e2h,004h,070h,028h,060h,028h,050h,028h,040h	; 6f58   *.*.*...p(`(P(@
	defb 028h,030h,028h,020h,028h,010h,028h,000h,028h,0ffh	; 6f68  (0( (.(.(.

; ----------------------------------------------------------------------
; DATOS sonido01_canaltodos: el flujo de silencio del sonido 1: un 0xFF que
;   para los cinco canales (el motor lo recorre con p12:6362)
;   0x6f72..0x6f73  (1 bytes)
DATA_sonido01_canaltodos:
	defb 0ffh	; 6f72

; ----------------------------------------------------------------------
; DATOS sonido02_canaltodos: el flujo de silencio del sonido 2: un 0xFF que
;   para los cinco canales (el motor lo recorre con p12:6362)
;   0x6f73..0x6f74  (1 bytes)
DATA_sonido02_canaltodos:
	defb 0ffh	; 6f73

; ----------------------------------------------------------------------
; DATOS sonido09_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 9: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x6f74..0x6f81  (13 bytes)
DATA_sonido09_canal0:
	defb 0f9h,081h,06fh,0f9h,0e2h,06fh,0f9h,0e2h,06fh,0f9h,074h,06fh,0ffh	; 6f74  ..o..o..o.to.

; ----------------------------------------------------------------------
; DATOS subflujo_6F81: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x6f81..0x6fe2  (97 bytes)
DATA_subflujo_6F81:
	defb 0feh,001h,0e9h,008h,0eah,00ah,0ebh,043h,023h,0f1h,042h,0f2h,00bh,0dbh,004h,0d2h	; 6f81  .......C#.B.....
	defb 020h,0eah,008h,020h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,070h,0eah,008h,070h	; 6f91   .. ..@..@..p..p
	defb 0eah,00ah,0ebh,084h,021h,0edh,009h,093h,0ebh,080h,021h,070h,090h,0ebh,043h,023h	; 6fa1  ....!.....!p..C#
	defb 0d1h,020h,0eah,008h,020h,0eah,00ah,0d2h,0b0h,0eah,008h,0b0h,0eah,00ah,0ebh,081h	; 6fb1  . .. ...........
	defb 042h,0d1h,041h,0e9h,001h,0ech,0eah,006h,0d2h,0b3h,0eah,007h,093h,0eah,008h,073h	; 6fc1  B.A............s
	defb 0eah,009h,063h,0e9h,008h,0f1h,058h,0f2h,020h,0ebh,006h,024h,0eah,009h,04bh,0fah	; 6fd1  ..c...X. ..$..K.
	defb 0ffh	; 6fe1

; ----------------------------------------------------------------------
; DATOS subflujo_6FE2: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x6fe2..0x720b  (553 bytes)
DATA_subflujo_6FE2:
	defb 0feh,001h,0e9h,008h,0eah,00ah,0edh,009h,0f1h,044h,0f2h,00ah,0ebh,0a3h,043h,0dbh	; 6fe2  .........D....C.
	defb 004h,0d1h,040h,0eah,007h,040h,0eah,00ah,070h,0eah,007h,070h,0eah,00ah,020h,0eah	; 6ff2  ..@..@..p..p.. .
	defb 007h,020h,0eah,00ah,040h,0eah,007h,040h,0eah,00ah,0d2h,0b0h,0eah,007h,0b0h,0eah	; 7002  . ..@..@........
	defb 00ah,0ebh,084h,021h,0d1h,023h,0ebh,0a3h,043h,0d2h,0b0h,0eah,007h,0b0h,0eah,00ah	; 7012  ...!.#..C.......
	defb 090h,0eah,007h,090h,0eah,00ah,0b0h,090h,070h,0eah,007h,070h,0eah,00ah,090h,0eah	; 7022  ........p..p....
	defb 007h,090h,0eah,009h,0edh,008h,0ebh,084h,021h,0b3h,0f1h,052h,0f2h,00ch,0ebh,017h	; 7032  ........!..R....
	defb 023h,0eah,00ah,0d1h,070h,0eah,008h,070h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah	; 7042  #...p..p.. .. ..
	defb 045h,070h,0eah,008h,070h,0eah,00ah,060h,070h,060h,040h,020h,0eah,008h,020h,0eah	; 7052  Ep..p..`p`@ .. .
	defb 00ah,0d2h,090h,0eah,008h,090h,0eah,00ah,0bbh,0edh,008h,0ebh,094h,021h,093h,0feh	; 7062  .............!..
	defb 001h,0e9h,008h,0eah,00ah,0edh,009h,0f1h,044h,0f2h,00ah,0ebh,0a2h,043h,0d1h,040h	; 7072  ........D....C.@
	defb 0eah,007h,040h,0eah,00ah,070h,0eah,007h,070h,0eah,00ah,020h,0eah,007h,020h,0eah	; 7082  ..@..p..p.. .. .
	defb 00ah,040h,0eah,007h,040h,0eah,00ah,0d2h,0b0h,0eah,007h,0b0h,0eah,00ah,0ebh,084h	; 7092  .@..@...........
	defb 021h,0d1h,023h,0ebh,0a2h,043h,0d2h,0b0h,0eah,007h,0b0h,0eah,00ah,0eah,00ah,090h	; 70a2  !.#..C..........
	defb 0eah,007h,090h,0eah,00ah,0b0h,090h,070h,0eah,007h,070h,0eah,00ah,090h,0eah,007h	; 70b2  .......p..p.....
	defb 090h,0eah,009h,0ebh,084h,021h,0b3h,0f1h,044h,0f2h,00ch,0ebh,0a2h,043h,0eah,00ah	; 70c2  .....!..D....C..
	defb 0d1h,070h,0eah,008h,070h,0eah,00ah,020h,0eah,008h,020h,0ebh,017h,023h,0eah,00ah	; 70d2  .p..p.. .. ..#..
	defb 045h,070h,0eah,008h,070h,0eah,00ah,060h,070h,060h,040h,020h,0eah,008h,020h,0eah	; 70e2  Ep..p..`p`@ .. .
	defb 00ah,0d2h,0b0h,0eah,008h,0b0h,0eah,00ah,0feh,001h,0e9h,008h,0eah,00ah,0ebh,013h	; 70f2  ................
	defb 023h,0d1h,040h,0eah,008h,040h,0eah,00ah,0d2h,040h,0eah,008h,040h,0eah,00ah,020h	; 7102  #.@..@...@..@..
	defb 0eah,008h,020h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,070h,0eah,008h,070h,0eah	; 7112  .. ..@..@..p..p.
	defb 00ah,060h,0eah,008h,060h,0eah,00ah,040h,0eah,008h,040h,0feh,001h,0e9h,008h,0eah	; 7122  .`..`..@..@.....
	defb 009h,0ebh,013h,023h,0eah,006h,0d3h,0b0h,0eah,005h,0b0h,0eah,008h,0edh,008h,0ebh	; 7132  ...#............
	defb 080h,011h,0d2h,070h,0eah,008h,070h,0eah,00ah,0f2h,00dh,0f1h,044h,0d1h,070h,090h	; 7142  ...p..p.....D.p.
	defb 070h,0eah,008h,070h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0d0h,020h,040h,020h	; 7152  p..p......... @
	defb 040h,021h,070h,060h,0f1h,052h,045h,0d1h,0b1h,0d0h,020h,040h,020h,040h,020h,0d1h	; 7162  @!p`.RE... @ @ .
	defb 0b0h,070h,060h,042h,070h,041h,071h,092h,0b0h,0d0h,021h,0d1h,0b1h,0d0h,090h,0b0h	; 7172  .p`BpAq...!.....
	defb 070h,090h,040h,070h,020h,040h,0d1h,0b0h,0d0h,020h,0d1h,090h,0b0h,070h,090h,040h	; 7182  p.@p @... ...p.@
	defb 070h,0feh,001h,0e9h,008h,0eah,008h,0edh,008h,0ebh,080h,011h,0d2h,070h,0eah,008h	; 7192  p............p..
	defb 070h,0eah,00ah,0f2h,00dh,0f1h,044h,0d1h,070h,090h,070h,0eah,008h,070h,0eah,00ah	; 71a2  p.....D.p.p..p..
	defb 0b0h,0eah,008h,0b0h,0eah,00ah,0d0h,020h,040h,020h,040h,021h,0d0h,070h,060h,0f1h	; 71b2  ....... @ @!.p`.
	defb 052h,045h,0d1h,0b1h,0d0h,020h,040h,020h,040h,020h,0d1h,0b0h,070h,060h,042h,070h	; 71c2  RE... @ @ ..p`Bp
	defb 041h,071h,092h,0b0h,0d0h,021h,0d1h,0b0h,090h,070h,0eah,008h,070h,0ebh,013h,023h	; 71d2  Aq...!...p..p..#
	defb 0eah,00ah,040h,0eah,008h,040h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,040h,0eah	; 71e2  ..@..@.. .. ..@.
	defb 008h,040h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah,060h,040h,020h,0eah,008h,020h	; 71f2  .@........`@ ..
	defb 0eah,009h,0d2h,020h,0eah,006h,020h,0fah,0ffh	; 7202  ... .. ..

; ----------------------------------------------------------------------
; DATOS sonido09_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 9: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x720b..0x7218  (13 bytes)
DATA_sonido09_canal1:
	defb 0f9h,018h,072h,0f9h,06eh,072h,0f9h,06eh,072h,0f9h,00bh,072h,0ffh	; 720b  ..r.nr.nr..r.

; ----------------------------------------------------------------------
; DATOS subflujo_7218: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7218..0x726e  (86 bytes)
DATA_subflujo_7218:
	defb 0feh,001h,0e9h,008h,0eah,00ah,0ebh,044h,023h,0f1h,046h,0f2h,00eh,0dbh,003h,0d4h	; 7218  .......D#.F.....
	defb 0b0h,0eah,007h,0b0h,0eah,00ah,0d3h,010h,0eah,007h,010h,0eah,00ah,040h,0eah,007h	; 7228  .............@..
	defb 040h,0eah,00ah,0edh,008h,0ebh,084h,031h,063h,0ebh,080h,033h,040h,060h,0ebh,044h	; 7238  @......1c..3@`.D
	defb 023h,0b0h,0eah,007h,0b0h,0eah,00ah,070h,0eah,007h,070h,0eah,00ah,0ebh,023h,023h	; 7248  #......p..p...##
	defb 0d4h,040h,040h,0d3h,020h,020h,040h,040h,0d4h,040h,040h,0d3h,020h,020h,040h,040h	; 7258  .@@.  @@.@@.  @@
	defb 020h,020h,040h,040h,0fah,0ffh	; 7268

; ----------------------------------------------------------------------
; DATOS subflujo_726E: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x726e..0x73f8  (394 bytes)
DATA_subflujo_726E:
	defb 0feh,001h,0e9h,008h,0eah,00ah,0ebh,023h,023h,0d4h,040h,040h,0d3h,020h,020h,040h	; 726e  .......##.@@.  @
	defb 040h,0d4h,040h,040h,0d3h,020h,020h,040h,040h,0d4h,040h,040h,0d3h,040h,040h,0d4h	; 727e  @.@@.  @@.@@.@@.
	defb 090h,090h,0d3h,070h,070h,090h,090h,0d4h,090h,090h,0b0h,0b0h,0d3h,090h,090h,0b0h	; 728e  ...pp...........
	defb 0b0h,0d4h,0b0h,0b0h,0d3h,000h,000h,070h,070h,0d2h,000h,000h,0d3h,000h,000h,020h	; 729e  .......pp......
	defb 020h,090h,090h,0d2h,020h,020h,0d3h,020h,020h,0d4h,070h,070h,0d3h,020h,020h,070h	; 72ae   ...  .  .pp.  p
	defb 070h,0d4h,070h,070h,0b0h,0b0h,0d3h,0b0h,0b0h,020h,020h,0d2h,020h,020h,0feh,001h	; 72be  p.pp.....  .  ..
	defb 0e9h,008h,0eah,00ah,0ebh,023h,023h,0d4h,040h,040h,0d3h,020h,020h,040h,040h,0d4h	; 72ce  .....##.@@.  @@.
	defb 040h,040h,0d3h,020h,020h,040h,040h,0d4h,040h,040h,0d3h,040h,040h,0d4h,090h,090h	; 72de  @@.  @@.@@.@@...
	defb 0d3h,070h,070h,090h,090h,0d4h,090h,090h,0b0h,0b0h,0d3h,090h,090h,0b0h,0b0h,0d4h	; 72ee  .pp.............
	defb 0b0h,0b0h,0d3h,000h,000h,070h,070h,0d2h,000h,000h,0d3h,000h,000h,0d4h,0b0h,0b0h	; 72fe  .....pp.........
	defb 0d3h,090h,090h,0b0h,0b0h,0d4h,0b0h,0b0h,040h,040h,0d3h,020h,020h,040h,040h,0d4h	; 730e  ........@@.  @@.
	defb 0b0h,0b0h,040h,040h,0b0h,0b0h,040h,040h,0c1h,0feh,001h,0e9h,008h,0eah,00ah,0ebh	; 731e  ..@@..@@........
	defb 023h,023h,0d4h,070h,070h,0d3h,070h,070h,0d4h,070h,070h,0d3h,070h,070h,0d4h,060h	; 732e  ##.pp.pp.pp.pp.`
	defb 060h,0d3h,060h,060h,0d4h,060h,060h,0d3h,060h,060h,0d4h,040h,040h,0d3h,040h,040h	; 733e  `.``.``.``.@@.@@
	defb 0d4h,040h,040h,0d3h,040h,040h,0d4h,0b0h,0b0h,0d3h,0b0h,0b0h,0d4h,0b0h,0b0h,0d3h	; 734e  .@@.@@..........
	defb 060h,060h,0d3h,000h,000h,0d2h,000h,000h,0d3h,000h,000h,0d2h,000h,000h,0d4h,090h	; 735e  ``..............
	defb 090h,0d3h,090h,090h,0d4h,090h,090h,0d3h,090h,090h,0d3h,020h,020h,0d2h,020h,020h	; 736e  ...........  .
	defb 0d3h,020h,020h,0d2h,020h,020h,0d4h,020h,020h,0d3h,020h,020h,0d4h,020h,0d3h,020h	; 737e  .  .  .  .  . .
	defb 0d4h,020h,0d3h,020h,0feh,001h,0e9h,008h,0eah,00ah,0ebh,023h,023h,0d4h,070h,070h	; 738e  . . .......##.pp
	defb 0d3h,070h,070h,0d4h,070h,070h,0d3h,070h,070h,0d4h,060h,060h,0d3h,060h,060h,0d4h	; 739e  .pp.pp.pp.``.``.
	defb 060h,060h,0d3h,060h,060h,0d4h,040h,040h,0d3h,040h,040h,0d4h,040h,040h,0d3h,040h	; 73ae  ``.``.@@.@@.@@.@
	defb 040h,0d4h,0b0h,0b0h,0d3h,0b0h,0b0h,0d4h,0b0h,0b0h,0d3h,060h,060h,000h,000h,070h	; 73be  @..........``..p
	defb 070h,000h,000h,070h,070h,0d3h,020h,020h,0d2h,020h,020h,0d3h,020h,020h,0d2h,020h	; 73ce  p..pp.  .  .  .
	defb 020h,0d4h,070h,070h,0d3h,070h,070h,0d4h,070h,070h,0d3h,070h,070h,0d4h,070h,070h	; 73de   .pp.pp.pp.pp.pp
	defb 0d3h,070h,070h,0d4h,070h,070h,070h,070h,0fah,0ffh	; 73ee  .pp.pppp..

; ----------------------------------------------------------------------
; DATOS sonido09_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 9: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x73f8..0x7405  (13 bytes)
DATA_sonido09_canal2:
	defb 0f9h,005h,074h,0f9h,065h,074h,0f9h,065h,074h,0f9h,0f8h,073h,0ffh	; 73f8  ..t.et.et..s.

; ----------------------------------------------------------------------
; DATOS subflujo_7405: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7405..0x7465  (96 bytes)
DATA_subflujo_7405:
	defb 0feh,001h,0e9h,008h,0eah,009h,0f1h,044h,0f2h,00ch,0ebh,014h,023h,0dbh,003h,0d3h	; 7405  .......D....#...
	defb 090h,0eah,007h,090h,0eah,009h,0b0h,0eah,007h,0b0h,0eah,009h,0d2h,020h,0eah,007h	; 7415  ............. ..
	defb 020h,0eah,009h,0ebh,084h,010h,0edh,008h,043h,0eah,009h,0ebh,081h,023h,020h,040h	; 7425   .......C....# @
	defb 0eah,009h,090h,0eah,007h,090h,0eah,009h,060h,0eah,007h,060h,0eah,009h,0edh,008h	; 7435  ........`..`....
	defb 0ebh,081h,042h,0b1h,0ech,0e9h,001h,0eah,006h,063h,0eah,007h,043h,0eah,008h,023h	; 7445  ..B......c..C..#
	defb 013h,0e9h,008h,0eah,009h,0f1h,048h,0f2h,026h,0ebh,006h,024h,0d3h,0bbh,0fah,0ffh	; 7455  ......H.&..$....

; ----------------------------------------------------------------------
; DATOS subflujo_7465: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7465..0x7666  (513 bytes)
DATA_subflujo_7465:
	defb 0feh,001h,0e9h,008h,0eah,009h,0edh,008h,0ebh,0a3h,032h,0f1h,044h,0f2h,00ch,0dbh	; 7465  ..........2.D...
	defb 003h,0d2h,0b0h,0eah,007h,0b0h,0eah,009h,0d1h,020h,0eah,007h,020h,0eah,009h,0d2h	; 7475  ......... .. ...
	defb 090h,0eah,007h,090h,0eah,009h,0b0h,0eah,007h,0b0h,0eah,009h,060h,0eah,007h,060h	; 7485  ............`..`
	defb 0eah,009h,0ebh,084h,021h,093h,0ebh,084h,021h,0eah,009h,0ebh,0a3h,032h,060h,0eah	; 7495  ....!...!....2`.
	defb 007h,060h,0eah,009h,040h,0eah,007h,040h,0eah,009h,060h,040h,020h,0eah,007h,020h	; 74a5  .`..@..@..`@ ..
	defb 0eah,009h,040h,0eah,007h,040h,0eah,008h,0edh,007h,0ebh,084h,021h,063h,0edh,008h	; 74b5  ..@..@......!c..
	defb 0ebh,0a2h,032h,0b0h,0eah,007h,0b0h,0eah,009h,0b0h,0eah,007h,0b0h,0eah,00ah,0d1h	; 74c5  ..2.............
	defb 000h,0eah,008h,000h,0eah,00ah,0d2h,070h,0eah,008h,070h,0feh,001h,0e9h,008h,0eah	; 74d5  .......p..p.....
	defb 00ah,0ebh,087h,023h,0f1h,052h,0f2h,00dh,0edh,008h,0d1h,005h,0ebh,0a3h,032h,0d2h	; 74e5  ...#.R........2.
	defb 090h,0eah,008h,090h,0ebh,084h,023h,0eah,00ah,063h,0ebh,0a3h,032h,070h,0eah,008h	; 74f5  ......#..c..2p..
	defb 070h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,070h,0eah,008h,070h,0eah,00ah,090h	; 7505  p.. .. ..p..p...
	defb 070h,0ebh,084h,021h,063h,0edh,007h,063h,0feh,001h,0e9h,008h,0eah,009h,0edh,008h	; 7515  p..!c..c........
	defb 0ebh,0a2h,032h,0f1h,044h,0f2h,00ch,0d2h,0b0h,0eah,007h,0b0h,0eah,009h,0d1h,020h	; 7525  ..2.D..........
	defb 0eah,007h,020h,0eah,009h,0d2h,090h,0eah,007h,090h,0eah,009h,0b0h,0eah,007h,0b0h	; 7535  .. .............
	defb 0eah,009h,060h,0eah,007h,060h,0ebh,084h,021h,0eah,009h,093h,0eah,009h,0ebh,0a2h	; 7545  ..`..`..!.......
	defb 032h,060h,0eah,007h,060h,0eah,009h,040h,0eah,007h,040h,0eah,009h,060h,040h,020h	; 7555  2`..`..@..@..`@
	defb 0eah,007h,020h,0eah,009h,040h,0eah,007h,040h,0eah,009h,0edh,007h,0ebh,087h,021h	; 7565  .. ..@..@......!
	defb 063h,0edh,008h,0ebh,089h,021h,0b0h,0eah,007h,0b0h,0eah,009h,0b0h,0eah,007h,0b0h	; 7575  c....!..........
	defb 0eah,009h,0ebh,081h,023h,0d1h,000h,0eah,007h,000h,0eah,00ah,0f1h,054h,0f2h,00eh	; 7585  ....#........T..
	defb 0d2h,070h,0eah,008h,070h,0eah,00ah,0d1h,005h,0d2h,090h,0eah,008h,090h,0eah,00ah	; 7595  .p..p...........
	defb 063h,070h,0eah,008h,070h,0feh,001h,0e9h,008h,0eah,009h,0ebh,013h,023h,0d3h,0b0h	; 75a5  cp..p........#..
	defb 0eah,007h,0b0h,0eah,009h,090h,0eah,007h,090h,0eah,009h,0b0h,0eah,007h,0b0h,0eah	; 75b5  ................
	defb 009h,0d2h,020h,0eah,007h,020h,0eah,009h,010h,0eah,007h,010h,0eah,009h,0d3h,0b0h	; 75c5  .. .. ..........
	defb 0eah,007h,0b0h,0feh,001h,0e9h,008h,0eah,00ah,0edh,008h,0ebh,083h,021h,0f2h,00dh	; 75d5  .............!..
	defb 0f1h,064h,0d2h,070h,090h,0b5h,0d1h,021h,0d2h,095h,0b0h,090h,0eah,00ah,075h,040h	; 75e5  .d.p...!......u@
	defb 070h,0eah,00ah,025h,0d3h,0b0h,0d2h,020h,075h,041h,075h,040h,070h,09dh,070h,090h	; 75f5  p..%... uAu@p.p.
	defb 0feh,001h,0e9h,008h,0eah,00ah,0edh,008h,0ebh,083h,021h,0f1h,064h,0f2h,00dh,0d2h	; 7605  ..........!.d...
	defb 0b5h,0d1h,021h,0d2h,095h,0b0h,090h,075h,040h,070h,025h,0d3h,0b0h,0d2h,020h,002h	; 7615  ..!....u@p%... .
	defb 040h,001h,041h,060h,040h,060h,090h,0b0h,0eah,008h,0b0h,0eah,00ah,090h,060h,070h	; 7625  @.A`@`........`p
	defb 0eah,008h,070h,0eah,00ah,0d1h,090h,0eah,008h,090h,0eah,00ah,070h,0eah,008h,070h	; 7635  ..p.........p..p
	defb 0eah,00ah,090h,0eah,008h,090h,0eah,00ah,0d0h,020h,0eah,008h,020h,0eah,00ah,0d1h	; 7645  ......... .. ...
	defb 0b0h,090h,070h,0eah,008h,070h,0eah,008h,0d2h,070h,0eah,007h,070h,0eah,00ah,0fah	; 7655  ..p..p...p..p...
	defb 0ffh	; 7665

; ----------------------------------------------------------------------
; DATOS sonido10_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 10: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x7666..0x76a8  (66 bytes)
DATA_sonido10_canal0:
	defb 0feh,001h,0e9h,007h,0eah,00ah,0ebh,043h,023h,0dbh,004h,0d2h,040h,0eah,008h,040h	; 7666  .......C#...@..@
	defb 0eah,00ah,0d1h,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h,0eah,006h,040h	; 7676  ...@..@..@..@..@
	defb 0eah,00ah,0d2h,010h,0eah,008h,010h,010h,0eah,00ah,0d1h,040h,0eah,008h,040h,0eah	; 7686  ...........@..@.
	defb 00ah,040h,0eah,008h,040h,0eah,00ah,0d0h,040h,0eah,008h,040h,0eah,00ah,0fbh,002h	; 7696  .@..@...@..@....
	defb 066h,076h	; 76a6

; ----------------------------------------------------------------------
; DATOS subflujo_76A8: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x76a8..0x783e  (406 bytes)
DATA_subflujo_76A8:
	defb 0feh,001h,0e9h,007h,0eah,00ah,0dbh,005h,0edh,009h,0ebh,086h,011h,0f1h,053h,0f2h	; 76a8  ..............S.
	defb 012h,0d1h,045h,061h,015h,041h,0d2h,0b1h,0d1h,011h,0d2h,091h,061h,0ebh,086h,012h	; 76b8  ..Ea.A......a...
	defb 043h,0ebh,086h,012h,0eah,009h,011h,061h,045h,061h,015h,061h,0dch,0ebh,043h,023h	; 76c8  C......aEa.a..C#
	defb 040h,0eah,008h,040h,0eah,00ah,0d1h,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h	; 76d8  @..@...@..@..@..
	defb 040h,0eah,006h,040h,0eah,00ah,0d2h,010h,0eah,008h,010h,0eah,006h,010h,0eah,00ah	; 76e8  @..@............
	defb 0d1h,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d2h,040h,0eah	; 76f8  .@..@..@..@...@.
	defb 008h,040h,0eah,009h,0dbh,005h,0ebh,086h,010h,0edh,00ah,065h,091h,0b5h,091h,0b1h	; 7708  .@.........e....
	defb 0d1h,001h,0d2h,091h,051h,093h,071h,051h,0feh,001h,0e9h,007h,0eah,00ah,0dch,0ebh	; 7718  ....Q.qQ........
	defb 016h,023h,0d2h,040h,0eah,008h,040h,0eah,00ah,0dbh,005h,0d1h,040h,0eah,008h,040h	; 7728  .#.@..@.....@..@
	defb 0eah,00ah,040h,0eah,008h,040h,0eah,006h,040h,0eah,00ah,020h,0eah,008h,020h,0eah	; 7738  ..@..@..@.. .. .
	defb 00ah,020h,030h,0eah,008h,030h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d2h,0b0h	; 7748  . 0..0..@..@....
	defb 0eah,008h,0b0h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d1h,040h,0eah,008h,040h	; 7758  .....@..@...@..@
	defb 0eah,00ah,040h,0eah,008h,040h,0eah,006h,040h,0eah,00ah,020h,0eah,008h,020h,0eah	; 7768  ..@..@..@.. .. .
	defb 00ah,020h,030h,0eah,008h,030h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d2h,040h	; 7778  . 0..0..@..@...@
	defb 0eah,008h,040h,0eah,00ah,0feh,001h,0e9h,007h,0eah,00ah,0edh,009h,0ebh,086h,011h	; 7788  ..@.............
	defb 0f1h,053h,0f2h,012h,0dbh,005h,0d1h,045h,061h,015h,041h,0d2h,0b1h,0d1h,011h,0d2h	; 7798  .S.....Ea.A.....
	defb 091h,061h,0ebh,086h,012h,043h,0ebh,023h,023h,010h,0eah,008h,010h,0eah,00ah,060h	; 77a8  .a...C.##......`
	defb 0eah,008h,060h,0eah,009h,0ebh,086h,012h,045h,061h,015h,061h,0ebh,043h,023h,040h	; 77b8  ..`.....Ea.a.C#@
	defb 0eah,008h,040h,0eah,00ah,0d1h,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h	; 77c8  ..@...@..@..@..@
	defb 0eah,006h,040h,0eah,00ah,0d2h,010h,0eah,008h,010h,0eah,006h,010h,0eah,00ah,0d1h	; 77d8  ..@.............
	defb 040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d2h,040h,0eah,008h	; 77e8  @..@..@..@...@..
	defb 040h,0eah,009h,0edh,00ah,0ebh,086h,010h,065h,091h,0b5h,091h,0b1h,0d1h,001h,0d2h	; 77f8  @.......e.......
	defb 091h,051h,093h,071h,051h,0feh,001h,0e9h,007h,0eah,00ah,0dbh,004h,0ebh,006h,022h	; 7808  .Q.qQ.........."
	defb 0d2h,045h,061h,095h,0d1h,011h,0ebh,007h,023h,06bh,0ebh,016h,022h,011h,041h,0ebh	; 7818  .Ea.....#k..".A.
	defb 006h,022h,025h,041h,0d2h,0b5h,0d1h,021h,015h,041h,025h,0d2h,081h,0feh,001h,0e9h	; 7828  ."%A...!.A%.....
	defb 007h,0eah,00ah,0ebh,043h,023h	; 7838

; ----------------------------------------------------------------------
; DATOS subflujo_783E: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x783e..0x7877  (57 bytes)
DATA_subflujo_783E:
	defb 0dch,0d2h,090h,0eah,008h,090h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0d1h,010h	; 783e  ................
	defb 0eah,008h,010h,0eah,006h,010h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,090h	; 784e  ........@..@..@.
	defb 0eah,008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h,0eah	; 785e  .....`..`.......
	defb 00ah,0fbh,002h,03eh,078h,0f9h,0a8h,076h,0ffh	; 786e  ...>x..v.

; ----------------------------------------------------------------------
; DATOS sonido10_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 10: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x7877..0x78bf  (72 bytes)
DATA_sonido10_canal1:
	defb 0feh,001h,0e9h,007h,0eah,00ah,0ebh,043h,023h,0dbh,004h,0d4h,090h,0eah,008h,090h	; 7877  .......C#.......
	defb 0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0d3h,010h,0eah,008h,010h,0eah,006h,010h	; 7887  ................
	defb 0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,090h,0eah,008h,090h,0eah,00ah,060h	; 7897  ..@..@..@......`
	defb 0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h,0eah,00ah,0fbh,002h,077h,078h,0feh	; 78a7  ..`..........wx.
	defb 001h,0e9h,007h,0eah,00ah,0ebh,043h,023h	; 78b7  ......C#

; ----------------------------------------------------------------------
; DATOS subflujo_78BF: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x78bf..0x79d2  (275 bytes)
DATA_subflujo_78BF:
	defb 0d4h,090h,0eah,008h,090h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0d3h,010h,0eah	; 78bf  ................
	defb 008h,010h,0eah,006h,010h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,090h,0eah	; 78cf  .......@..@..@..
	defb 008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h,0eah,00ah	; 78df  ....`..`........
	defb 0fbh,004h,0bfh,078h,020h,0eah,008h,020h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah	; 78ef  ...x .. ........
	defb 0b0h,0eah,008h,0b0h,0eah,006h,0b0h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,020h	; 78ff  ......... .. ..
	defb 090h,0eah,008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h	; 790f  ......`..`......
	defb 0eah,00ah,020h,0eah,008h,020h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah,0b0h,0eah	; 791f  .. .. ..........
	defb 008h,0b0h,0eah,006h,0b0h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,020h,090h,0eah	; 792f  ....... .. .. ..
	defb 008h,090h,0eah,00ah,050h,0eah,008h,050h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah	; 793f  ....P..P.. .. ..
	defb 0feh,001h,0e9h,007h,0eah,00ah,0ebh,043h,023h,0d4h,040h,0eah,008h,040h,0eah,00ah	; 794f  .......C#.@..@..
	defb 0d2h,090h,0eah,008h,090h,0eah,00ah,090h,0eah,008h,090h,0eah,006h,090h,0eah,00ah	; 795f  ................
	defb 0ebh,013h,022h,0d4h,040h,0eah,008h,040h,0eah,006h,040h,0eah,00ah,040h,0eah,008h	; 796f  ..".@..@..@..@..
	defb 040h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0ebh,043h,023h,0b0h,0eah,008h,0b0h	; 797f  @..@..@...C#....
	defb 0eah,00ah,040h,0eah,008h,040h,0eah,00ah,0d2h,040h,0eah,008h,040h,0eah,00ah,040h	; 798f  ..@..@...@..@..@
	defb 0eah,008h,040h,0eah,006h,040h,0eah,00ah,0ebh,013h,022h,0d4h,040h,0eah,008h,040h	; 799f  ..@..@....".@..@
	defb 0eah,006h,040h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,0eah,008h,040h,0ebh	; 79af  ..@..@..@..@..@.
	defb 043h,023h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0feh,001h,0e9h,007h,0eah,00ah	; 79bf  C#..............
	defb 0ebh,043h,023h	; 79cf

; ----------------------------------------------------------------------
; DATOS subflujo_79D2: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x79d2..0x7b36  (356 bytes)
DATA_subflujo_79D2:
	defb 0d4h,090h,0eah,008h,090h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0d3h,010h,0eah	; 79d2  ................
	defb 008h,010h,0eah,006h,010h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,090h,0eah	; 79e2  .......@..@..@..
	defb 008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h,0eah,00ah	; 79f2  ....`..`........
	defb 0fbh,004h,0d2h,079h,020h,0eah,008h,020h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah	; 7a02  ...y .. ........
	defb 0b0h,0eah,008h,0b0h,0eah,006h,0b0h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,020h	; 7a12  ......... .. ..
	defb 090h,0eah,008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,010h,0eah,008h,010h	; 7a22  ......`..`......
	defb 0eah,00ah,020h,0eah,008h,020h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah,0b0h,0eah	; 7a32  .. .. ..........
	defb 008h,0b0h,0eah,006h,0b0h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah,020h,090h,0eah	; 7a42  ....... .. .. ..
	defb 008h,090h,0eah,00ah,050h,0eah,008h,050h,0eah,00ah,020h,0eah,008h,020h,0eah,00ah	; 7a52  ....P..P.. .. ..
	defb 0feh,001h,0e9h,007h,0eah,00ah,0ebh,043h,023h,0d3h,040h,0eah,008h,040h,0eah,00ah	; 7a62  .......C#.@..@..
	defb 060h,0eah,008h,060h,0eah,00ah,090h,0eah,008h,090h,0eah,006h,090h,0eah,00ah,010h	; 7a72  `..`............
	defb 0eah,008h,010h,0eah,00ah,010h,060h,0eah,008h,060h,0eah,00ah,000h,0eah,008h,000h	; 7a82  ......`..`......
	defb 0eah,00ah,0d4h,0b0h,0eah,008h,0b0h,0eah,00ah,0a0h,0eah,008h,0a0h,0eah,00ah,0b0h	; 7a92  ................
	defb 0eah,008h,0b0h,0eah,00ah,0d3h,010h,0eah,008h,010h,0eah,006h,010h,0eah,00ah,0d4h	; 7aa2  ................
	defb 060h,0eah,008h,060h,0eah,00ah,060h,080h,0eah,008h,080h,0eah,00ah,0a0h,0eah,008h	; 7ab2  `..`..`.........
	defb 0a0h,0eah,00ah,060h,0eah,008h,060h,0feh,001h,0e9h,007h,0eah,00ah,0ebh,033h,022h	; 7ac2  ...`..`.......3"
	defb 0d4h,0b0h,0eah,008h,0b0h,0eah,00ah,0d3h,010h,0eah,008h,010h,0eah,00ah,020h,0eah	; 7ad2  .............. .
	defb 008h,020h,0eah,006h,020h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,060h,0b0h,0eah	; 7ae2  . .. ..`..`..`..
	defb 008h,0b0h,0eah,00ah,090h,0eah,008h,090h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah	; 7af2  ..........`..`..
	defb 040h,0eah,008h,040h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,090h,0eah,008h,090h	; 7b02  @..@..`..`......
	defb 0eah,006h,090h,0eah,00ah,040h,0eah,008h,040h,0eah,00ah,040h,0b0h,0eah,008h,0b0h	; 7b12  .....@..@..@....
	defb 0eah,00ah,0d2h,020h,0eah,008h,020h,0eah,00ah,0d3h,040h,0eah,008h,040h,0eah,00ah	; 7b22  ... .. ...@..@..
	defb 0f9h,077h,078h,0ffh	; 7b32

; ----------------------------------------------------------------------
; DATOS sonido10_canal2: el flujo de ordenes y notas del canal 2 (musica) del
;   sonido 10: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x7b36..0x7b78  (66 bytes)
DATA_sonido10_canal2:
	defb 0feh,001h,0e9h,007h,0eah,009h,0ebh,043h,023h,0dbh,003h,0d3h,0b0h,0eah,007h,0b0h	; 7b36  .......C#.......
	defb 0eah,009h,0d1h,010h,0eah,007h,010h,0eah,009h,010h,0eah,007h,010h,0eah,006h,010h	; 7b46  ................
	defb 0eah,009h,0d3h,0b0h,0eah,007h,0b0h,0b0h,0eah,009h,0d1h,010h,0eah,007h,010h,0eah	; 7b56  ................
	defb 009h,010h,0eah,007h,010h,0eah,009h,0d0h,010h,0eah,007h,010h,0eah,009h,0fbh,002h	; 7b66  ................
	defb 036h,07bh	; 7b76

; ----------------------------------------------------------------------
; DATOS subflujo_7B78: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7b78..0x7d44  (460 bytes)
DATA_subflujo_7B78:
	defb 0feh,001h,0e9h,007h,0eah,008h,0edh,008h,0ebh,087h,021h,0f1h,054h,0f2h,018h,0d2h	; 7b78  ..........!.T...
	defb 09dh,061h,045h,0ebh,086h,034h,011h,013h,0ebh,0a3h,045h,0d3h,093h,0ebh,043h,023h	; 7b88  .aE..4....E...C#
	defb 0d2h,0eah,009h,090h,0eah,008h,090h,0eah,009h,0b0h,0eah,008h,0b0h,0eah,009h,0d1h	; 7b98  ................
	defb 010h,0eah,008h,010h,0eah,006h,010h,0eah,00ah,040h,0eah,008h,040h,0eah,009h,040h	; 7ba8  .........@..@..@
	defb 090h,0eah,008h,090h,0eah,009h,060h,0eah,008h,060h,0eah,009h,010h,0eah,008h,010h	; 7bb8  ......`..`......
	defb 0eah,009h,0d2h,010h,0eah,007h,010h,0eah,009h,0d1h,010h,0eah,007h,010h,0eah,009h	; 7bc8  ................
	defb 010h,0eah,007h,010h,010h,0eah,009h,0d3h,0b0h,0eah,007h,0b0h,0b0h,0eah,009h,0d1h	; 7bd8  ................
	defb 010h,0eah,007h,010h,0eah,009h,010h,0eah,007h,010h,0eah,009h,0d2h,010h,0eah,007h	; 7be8  ................
	defb 010h,0eah,008h,0ebh,087h,021h,0f1h,062h,0f2h,018h,0d1h,02bh,0f3h,043h,05bh,023h	; 7bf8  .....!.b...+.C[#
	defb 0feh,001h,0e9h,007h,0eah,009h,0ebh,043h,023h,0d3h,0b0h,0eah,007h,0b0h,0eah,009h	; 7c08  .......C#.......
	defb 0d2h,0b0h,0eah,007h,0b0h,0eah,009h,0b0h,0eah,007h,0b0h,0b0h,0eah,009h,090h,0eah	; 7c18  ................
	defb 007h,090h,0eah,009h,090h,0a0h,0eah,007h,0a0h,0eah,009h,0b0h,0eah,007h,0b0h,0eah	; 7c28  ................
	defb 009h,040h,0eah,007h,040h,0eah,009h,0d3h,080h,0eah,007h,080h,0eah,009h,0d2h,080h	; 7c38  .@..@...........
	defb 0eah,007h,080h,0eah,009h,080h,0eah,007h,080h,080h,0eah,009h,060h,0eah,007h,060h	; 7c48  ............`..`
	defb 0eah,009h,060h,070h,0eah,007h,070h,0eah,009h,080h,0eah,007h,080h,0eah,009h,0d3h	; 7c58  ..`p..p.........
	defb 080h,0eah,007h,080h,0eah,009h,0feh,001h,0e9h,007h,0eah,008h,0edh,008h,0ebh,087h	; 7c68  ................
	defb 021h,0f1h,053h,0f2h,018h,0d2h,09dh,061h,045h,0ebh,087h,023h,011h,013h,0ebh,043h	; 7c78  !.S....aE..#...C
	defb 023h,0d3h,090h,0eah,007h,090h,0eah,009h,0d2h,040h,0eah,007h,040h,0eah,009h,0eah	; 7c88  #........@..@...
	defb 009h,090h,0eah,008h,090h,0eah,009h,0b0h,0eah,008h,0b0h,0eah,009h,0d1h,010h,0eah	; 7c98  ................
	defb 008h,010h,0eah,006h,010h,0eah,009h,040h,0eah,008h,040h,0eah,009h,040h,090h,0eah	; 7ca8  .......@..@..@..
	defb 008h,090h,0eah,009h,060h,0eah,008h,060h,0eah,009h,010h,0eah,008h,010h,0eah,009h	; 7cb8  ....`..`........
	defb 0d2h,010h,0eah,007h,010h,0eah,009h,0d1h,010h,0eah,007h,010h,0eah,009h,010h,0eah	; 7cc8  ................
	defb 007h,010h,010h,0eah,009h,0d3h,0b0h,0eah,007h,0b0h,0b0h,0eah,009h,0d1h,010h,0eah	; 7cd8  ................
	defb 007h,010h,0eah,009h,010h,0eah,007h,010h,0eah,009h,0d2h,010h,0eah,007h,010h,0eah	; 7ce8  ................
	defb 008h,0ebh,087h,021h,0f1h,062h,0d1h,02bh,0f2h,018h,043h,05bh,023h,0feh,001h,0e9h	; 7cf8  ...!.b.+..C[#...
	defb 007h,0eah,009h,0ebh,006h,021h,0d2h,015h,011h,045h,081h,0d1h,010h,020h,0d1h,010h	; 7d08  .....!...E... ..
	defb 020h,0d1h,010h,020h,0d1h,010h,020h,0d1h,010h,020h,010h,0d2h,0b0h,0ebh,006h,021h	; 7d18   .. .. .. .....!
	defb 0a0h,060h,080h,0a0h,0eah,009h,0ebh,006h,021h,0b5h,0b1h,065h,0b1h,095h,0d1h,011h	; 7d28  .`......!..e....
	defb 0d2h,085h,041h,0feh,001h,0e9h,007h,0eah,009h,0ebh,043h,023h	; 7d38  ..A.......C#

; ----------------------------------------------------------------------
; DATOS subflujo_7D44: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7d44..0x7d7d  (57 bytes)
DATA_subflujo_7D44:
	defb 0d2h,040h,0eah,008h,040h,0eah,00ah,060h,0eah,008h,060h,0eah,00ah,080h,0eah,008h	; 7d44  .@..@..`..`.....
	defb 080h,0eah,006h,080h,0eah,00ah,0b0h,0eah,008h,0b0h,0eah,00ah,0b0h,0d1h,040h,0eah	; 7d54  ..............@.
	defb 008h,040h,0eah,00ah,010h,0eah,008h,010h,0eah,00ah,0d2h,080h,0eah,008h,080h,0eah	; 7d64  .@..............
	defb 00ah,0fbh,002h,044h,07dh,0f9h,078h,07bh,0ffh	; 7d74  ...D}.x{.

; ----------------------------------------------------------------------
; DATOS sonido11_canal0: el flujo de ordenes y notas del canal 0 (musica) del
;   sonido 11: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x7d7d..0x7d9f  (34 bytes)
DATA_sonido11_canal0:
	defb 0f9h,09fh,07dh,0f9h,0deh,07dh,0f9h,09fh,07dh,0f9h,011h,07eh,0f9h,09fh,07dh,0f9h	; 7d7d  ..}..}..}..~..}.
	defb 0deh,07dh,0f9h,09fh,07dh,0f9h,045h,07eh,0f9h,081h,07eh,0f9h,0d5h,07eh,0f9h,07dh	; 7d8d  .}..}.E~..~..~.}
	defb 07dh,0ffh	; 7d9d

; ----------------------------------------------------------------------
; DATOS subflujo_7D9F: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7d9f..0x7dde  (63 bytes)
DATA_subflujo_7D9F:
	defb 0feh,001h,0e9h,008h,0f2h,00fh,0f1h,042h,0eah,00ah,0edh,009h,0ebh,085h,045h,0dbh	; 7d9f  .......B......E.
	defb 003h,0d1h,055h,0ebh,085h,048h,051h,0ebh,085h,045h,075h,0ebh,085h,048h,071h,0dbh	; 7daf  ..U..HQ..Eu..Hq.
	defb 006h,0ebh,083h,020h,0edh,008h,090h,0d0h,000h,0d1h,090h,070h,0ebh,085h,048h,091h	; 7dbf  ... .......p..H.
	defb 071h,0ebh,087h,024h,055h,0eah,00ah,0ebh,084h,010h,0d1h,020h,050h,0fah,0ffh	; 7dcf  q..$U...... P..

; ----------------------------------------------------------------------
; DATOS subflujo_7DDE: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7dde..0x7e11  (51 bytes)
DATA_subflujo_7DDE:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,041h,0eah,00ah,0edh,008h,0ebh,083h,036h,0dbh	; 7dde  .......A......6.
	defb 006h,0d6h,002h,001h,0d1h,072h,092h,051h,072h,052h,0edh,008h,0d8h,0ebh,084h,010h	; 7dee  .....r.QrR......
	defb 020h,050h,0edh,009h,0ebh,085h,045h,025h,0ebh,085h,048h,001h,0ebh,085h,045h,0dch	; 7dfe   P....E%..H...E.
	defb 007h,0fah,0ffh	; 7e0e

; ----------------------------------------------------------------------
; DATOS subflujo_7E11: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7e11..0x7e45  (52 bytes)
DATA_subflujo_7E11:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,042h,0eah,00ah,0edh,009h,0ebh,085h,045h,0dbh	; 7e11  .......B......E.
	defb 006h,0d6h,002h,001h,0d1h,072h,092h,051h,072h,052h,0dbh,007h,0d8h,0ebh,084h,012h	; 7e21  .....r.QrR......
	defb 0edh,008h,020h,000h,0f2h,016h,0ebh,087h,026h,027h,0ebh,087h,023h,0d2h,093h,0dch	; 7e31  .. .....&'..#...
	defb 0d1h,003h,0fah,0ffh	; 7e41

; ----------------------------------------------------------------------
; DATOS subflujo_7E45: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7e45..0x7e81  (60 bytes)
DATA_subflujo_7E45:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,051h,0eah,00ah,0edh,009h,0ebh,085h,045h,0dbh	; 7e45  .......Q......E.
	defb 006h,0d1h,072h,092h,051h,0ebh,082h,031h,0edh,008h,090h,070h,050h,070h,050h,020h	; 7e55  ..r.Q..1...pPpP
	defb 000h,020h,0dbh,007h,0ebh,087h,045h,055h,0dbh,006h,0ebh,084h,012h,000h,020h,0ebh	; 7e65  . ....EU...... .
	defb 087h,045h,055h,0ebh,084h,011h,0d1h,090h,0d0h,000h,0fah,0ffh	; 7e75  .EU.........

; ----------------------------------------------------------------------
; DATOS subflujo_7E81: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7e81..0x7ed5  (84 bytes)
DATA_subflujo_7E81:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,041h,0eah,00ah,0ebh,085h,045h,0edh,009h,0dbh	; 7e81  .......A....E...
	defb 006h,0d0h,022h,022h,021h,001h,0d1h,071h,0edh,008h,0ebh,081h,011h,090h,0d0h,000h	; 7e91  ..""!..q........
	defb 0d1h,090h,070h,0ebh,087h,043h,055h,0ebh,081h,011h,000h,020h,0ebh,087h,043h,055h	; 7ea1  ..p..CU.... ..CU
	defb 0ebh,081h,010h,090h,0d0h,000h,0edh,009h,0ebh,085h,045h,022h,022h,021h,001h,0d1h	; 7eb1  ..........E""!..
	defb 071h,0edh,008h,0ebh,081h,011h,090h,070h,050h,000h,0ebh,085h,046h,023h,043h,053h	; 7ec1  q......pP...F#CS
	defb 091h,071h,0fah,0ffh	; 7ed1

; ----------------------------------------------------------------------
; DATOS subflujo_7ED5: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7ed5..0x7f27  (82 bytes)
DATA_subflujo_7ED5:
	defb 0feh,001h,0e9h,008h,0f2h,00bh,0f1h,042h,0eah,00ah,0ebh,085h,045h,0edh,009h,0dbh	; 7ed5  .......B....E...
	defb 003h,0d1h,055h,0ebh,085h,048h,051h,0ebh,085h,045h,075h,0ebh,085h,048h,071h,0ebh	; 7ee5  ..U..HQ..Eu..Hq.
	defb 081h,011h,090h,0d0h,000h,020h,000h,0d1h,090h,070h,050h,070h,0ebh,087h,045h,025h	; 7ef5  ..... ...pPp..E%
	defb 0ebh,081h,011h,020h,050h,0f1h,041h,0dbh,006h,0ebh,085h,045h,072h,092h,051h,072h	; 7f05  ... P.A....Er.Qr
	defb 052h,0ebh,081h,011h,020h,000h,0ebh,087h,036h,02ch,0ebh,081h,011h,000h,020h,040h	; 7f15  R... ...6,.... @
	defb 0fah,0ffh	; 7f25

; ----------------------------------------------------------------------
; DATOS sonido11_canal1: el flujo de ordenes y notas del canal 1 (musica) del
;   sonido 11: lo recorre el motor de p12:6362 nota a nota (de 0x00 a 0xCF, el
;   nibble alto es la nota y el bajo la duracion; de 0xD0 a 0xFE, ordenes)
;   0x7f27..0x7f4f  (40 bytes)
DATA_sonido11_canal1:
	defb 0f9h,04fh,07fh,0f9h,08eh,07fh,0f9h,04fh,07fh,0f9h,0f7h,07fh,0f9h,04fh,07fh,0f9h	; 7f27  .O.....O.....O..
	defb 08eh,07fh,0f9h,04fh,07fh,0f9h,05ch,080h,0f9h,0c5h,080h,0f9h,058h,081h,0f9h,082h	; 7f37  ...O..\.....X...
	defb 081h,0f9h,016h,082h,0f9h,027h,07fh,0ffh	; 7f47  .....'..

; ----------------------------------------------------------------------
; DATOS subflujo_7F4F: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7f4f..0x7f8e  (63 bytes)
DATA_subflujo_7F4F:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00bh,0ebh,032h,033h,0dbh,005h,0d4h	; 7f4f  .....(.....23...
	defb 050h,0eah,008h,050h,0eah,00ah,0d3h,000h,000h,050h,0eah,008h,050h,0eah,00ah,000h	; 7f5f  P..P.....P..P...
	defb 0eah,008h,000h,0eah,00ah,0d4h,050h,0d3h,000h,0eah,008h,000h,0eah,00ah,000h,050h	; 7f6f  ......P........P
	defb 0eah,008h,050h,0eah,00ah,000h,0eah,008h,000h,0fbh,002h,04fh,07fh,0fah,0ffh	; 7f7f  ..P........O...

; ----------------------------------------------------------------------
; DATOS subflujo_7F8E: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7f8e..0x7ff7  (105 bytes)
DATA_subflujo_7F8E:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah,00ah,0ebh,032h,033h,0dbh,005h,0d4h	; 7f8e  .....(.....23...
	defb 050h,0eah,008h,050h,0eah,00ah,0a0h,0a0h,0d3h,050h,0eah,008h,050h,0eah,00ah,0d4h	; 7f9e  P..P.....P..P...
	defb 0a0h,0eah,008h,0a0h,0eah,00ah,050h,0a0h,0eah,008h,0a0h,0eah,00ah,0a0h,0d3h,050h	; 7fae  ......P........P
	defb 0eah,008h,050h,0eah,00ah,0d4h,0a0h,0eah,008h,0a0h,0eah,00ah,070h,0eah,008h,070h	; 7fbe  ..P.........p..p
	defb 0eah,00ah,0d3h,020h,020h,0a0h,0eah,008h,0a0h,0eah,00ah,020h,0eah,008h,020h,0eah	; 7fce  ...  ...... .. .
	defb 00ah,000h,070h,0eah,008h,070h,0eah,00ah,070h,0d2h,000h,0eah,008h,000h,0eah,00ah	; 7fde  ..p..p..p.......
	defb 0d3h,070h,0eah,008h,070h,0eah,00ah,0fah,0ffh	; 7fee  .p..p....

; ----------------------------------------------------------------------
; DATOS subflujo_7FF7: un trozo de musica al que se salta con una llamada
;   (orden 0xF9) o es la continuacion del flujo anterior: flujo de ordenes y
;   notas que acaba en 0xFF, 0xFA (vuelve) o 0xFD (salta)
;   0x7ff7..0x8000  (9 bytes)
DATA_subflujo_7FF7:
	defb 0feh,001h,0e9h,008h,0f1h,028h,0f2h,00ch,0eah	; 7ff7  .....(...
