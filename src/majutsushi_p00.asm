; ==========================================================================
; HAI NO MAJUTSUSHI - MAHJONG 2 - Konami (1989) - MSX2 - MegaROM RC-765 de 128 KB (Konami SCC) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l5028h:	equ 0x05028
l5480h:	equ 0x05480

; ----------------------------------------------------------------------
; DATOS cabecera_ab: la cabecera del cartucho (MSX): 'AB', la direccion del
;   INIT (0x4070) y los cuatro punteros STATEMENT, DEVICE, TEXT y MSX-BASIC a
;   cero; la BIOS la lee al arrancar
;   0x4000..0x4010  (16 bytes)

; ----------------------------------------------------------------------
; =====  CABECERA AB, INTERRUPCION Y UTILIDADES  =====
; ----------------------------------------------------------------------
DATA_cabecera_ab:
	defb 041h,042h,070h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  ABp@............

; ======================================================================
; CODIGO 0x4010..0x412f  (287 bytes)
; ======================================================================


interrupcion:		; el gancho H.KEYI: sonido (bancos 12-13-14) y el cuadro del juego
	di			;4010   ; la interrupcion del cuadro (el INIT la cuelga en H.KEYI, 0xFD9F): todo el juego corre aqui dentro
	ld a,(0cf2dh)		;4011   ; 0xCF2D = 1 mientras suena una voz PCM (p12:6280): sin interrupciones de juego mientras tanto
	or a			;4014
	ret nz			;4015
	ld hl,0c006h		;4016   ; 0xC006: semaforo del sonido (no se reentra)
	ld a,(hl)			;4019
	and a			;401a
	ld (hl),001h		;401b
	jp nz,L_405A		;401d
	ld a,00ch		;4020   ; pone los bancos 12-13-14 (el motor de sonido) en 0x6000/0x8000/0xA000
	ld (07000h),a		;4022   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4025
	ld (09000h),a		;4026   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4029
	ld (0b000h),a		;402a   ; el mapper: pone en 0xA000 el banco de A
	call 06006h		;402d   ; motor de sonido: un cuadro de musica (p12:6006)
	xor a			;4030
	ld (0c006h),a		;4031   ; guarda el semaforo del sonido
	di			;4034   ; devuelve los bancos de antes, leyendolos de sus copias en RAM 0xF0F1-3
	ld a,(0f0f1h)		;4035   ; lee la copia del banco en 0x6000
	ld (07000h),a		;4038   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;403b   ; lee la copia del banco en 0x8000
	ld (09000h),a		;403e   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;4041   ; lee la copia del banco en 0xA000
	ld (0b000h),a		;4044   ; el mapper: pone en 0xA000 el banco de A
	ld hl,0c005h		;4047   ; 0xC005: semaforo del cuadro del juego
	ld a,(hl)			;404a
	and a			;404b
	jr nz,L_405A		;404c
	inc (hl)			;404e
	ei			;404f
	call lee_mandos		;4050   ; lee los mandos y el teclado (p00:55F0)
	call cuadro_del_juego		;4053   ; un paso de la maquina de estados del juego (p00:425D)
	xor a			;4056
	ld (0c005h),a		;4057   ; guarda el semaforo del cuadro del juego
L_405A:
	ei			;405a
	ret			;405b
suma_a_hl:		; HL = HL + A
	add a,l			;405c   ; HL = HL + A
	ld l,a			;405d
	ret nc			;405e
	inc h			;405f
	ret			;4060
suma_a_de:		; DE = DE + A
	add a,e			;4061   ; DE = DE + A
	ld e,a			;4062
	ret nc			;4063
	inc d			;4064
	ret			;4065
despacha:		; salta a la palabra A de la tabla que va detras del call
	pop hl			;4066   ; DESPACHADOR: saca la direccion de retorno (HL = tabla que va detras del call), multiplica A por dos y salta a la palabra de esa tabla
L_4067:
	add a,a			;4067
	call suma_a_hl		;4068   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;406b
	inc hl			;406c
	ld h,(hl)			;406d
	ld l,a			;406e
	jp (hl)			;406f
init:		; el arranque del cartucho (INIT)
	di			;4070   ; INIT: interrupciones fuera, modo 1, pila en 0xF0F0
	im 1		;4071
	ld sp,0f0f0h		;4073
	call cartucho_en_8000		;4076   ; pone el cartucho tambien en la pagina 2 (ENASLT) y guarda su ranura
	call ranura_del_cartucho		;4079   ; ranura_del_cartucho: la ranura del cartucho, en 0xF0F4
	ld hl,0c000h		;407c   ; borra la RAM de 0xC000 a 0xF0EF
	ld de,0c001h		;407f   ; apunta a el paso dentro del estado
	ld bc,030efh		;4082
	ld (hl),000h		;4085
	ldir		;4087
	ld hl,0f0f1h		;4089   ; apunta a la copia del banco en 0x6000
	ld a,001h		;408c   ; bancos 1-2-3 en 0x6000/0x8000/0xA000, con su copia en 0xF0F1-3
	ld (07000h),a		;408e   ; el mapper: pone en 0x6000 el banco de A
	ld (hl),a			;4091
	inc a			;4092
	ld (09000h),a		;4093   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;4096
	ld (hl),a			;4097
	inc a			;4098
	ld (0b000h),a		;4099   ; el mapper: pone en 0xA000 el banco de A
	inc hl			;409c
	ld (hl),a			;409d
	call arranca_pantalla		;409e   ; p00:558C: arranca el sonido, pone SCREEN 7 y limpia la VRAM
	call 0618fh		;40a1   ; p01:618F: prepara el juego (primera vez)
	ld bc,00000h		;40a4
	ld (0c012h),bc		;40a7   ; guarda el ajuste horizontal de la imagen (registro 18 del VDP) y el byte siguiente (16 bits)
	call 064bch		;40ab   ; p01:64BC
	di			;40ae
	ld a,0c3h		;40af   ; H.KEYI = jp 0x4010: desde aqui manda la interrupcion
	ld (0fd9fh),a		;40b1
	ld hl,interrupcion		;40b4
	ld (0fda0h),hl		;40b7
	xor a			;40ba
	ld (0f3dbh),a		;40bb
	ei			;40be
L_40BF:
	jr L_40BF		;40bf   ; bucle sin fin: de aqui en adelante todo pasa en la interrupcion
cartucho_en_8000:		; pone el cartucho tambien en 0x8000-0xBFFF (ENASLT)
	call 00138h		;40c1   ; BIOS RSLREG - Reads the primary slot register | busca la ranura del cartucho: lee el registro de ranura primaria de la pagina 1...
	rrca			;40c4
	rrca			;40c5
	and 003h		;40c6
	ld c,a			;40c8
	ld b,000h		;40c9
	ld hl,0fcc1h		;40cb   ; HL = 0xFCC1 + ranura primaria: la tabla EXPTBL de ranuras expandidas
	add hl,bc			;40ce
	ld a,(hl)			;40cf
	and 080h		;40d0   ; bit 7 de EXPTBL = la ranura esta expandida; se junta con el numero de ranura en C
	or c			;40d2
	ld c,a			;40d3
	inc hl			;40d4
	inc hl			;40d5
	inc hl			;40d6
	inc hl			;40d7
	ld a,(hl)			;40d8   ; lee la ranura secundaria que guarda la BIOS (0xFCC5 + ranura) y la mete en los bits 2-3 de A
	and 00ch		;40d9
	or c			;40db
	ld h,080h		;40dc
	jp 00024h		;40de   ; BIOS ENASLT - Switches to specified slot and page definitively | ...y lo pone en la pagina 2 con ENASLT (el cartucho de 128 KB solo da 0x4000-0xBFFF con el trio de bancos)
ranura_del_cartucho:		; la ranura del cartucho, en 0xF0F4
	call 00138h		;40e1   ; BIOS RSLREG - Reads the primary slot register | guarda en 0xF0F4 el codigo de ranura del cartucho (la de la pagina 1)
	rrca			;40e4
	rrca			;40e5
	and 003h		;40e6
	ld c,a			;40e8
	ld b,000h		;40e9
	ld hl,0fcc1h		;40eb
	add hl,bc			;40ee
	or (hl)			;40ef
	ld c,a			;40f0
	inc hl			;40f1
	inc hl			;40f2
	inc hl			;40f3
	inc hl			;40f4
	ld a,(hl)			;40f5
	and 00ch		;40f6
	or c			;40f8
	ld (0f0f4h),a		;40f9   ; 0xF0F4 = ranura del cartucho (con la secundaria)
	ret			;40fc

; ----------------------------------------------------------------------
; =====  Atajos: cada uno pide un sonido  =====
; ----------------------------------------------------------------------
pide_sonido_01:		; pide el sonido 0x01 al motor de sonido (p12:6003)
	ld a,001h		;40fd   ; pide el sonido 0x01
	jp pide_sonido		;40ff   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_02:		; pide el sonido 0x02
	ld a,002h		;4102   ; pide el sonido 0x02
	jp pide_sonido		;4104   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_03:		; pide el sonido 0x03
	ld a,003h		;4107   ; pide el sonido 0x03
	jp pide_sonido		;4109   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_04:		; pide el sonido 0x04
	ld a,004h		;410c   ; pide el sonido 0x04
	jp pide_sonido		;410e   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_05:		; pide el sonido 0x05
	ld a,005h		;4111   ; pide el sonido 0x05
	jp pide_sonido		;4113   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_06:		; pide el sonido 0x06 (el del cursor)
	ld a,006h		;4116   ; pide el sonido 0x06
	jp pide_sonido		;4118   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_07:		; pide el sonido 0x07 (el del boton)
	ld a,007h		;411b   ; pide el sonido 0x07
	jp pide_sonido		;411d   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_08:		; pide el sonido 0x08
	ld a,008h		;4120   ; pide el sonido 0x08
	jp pide_sonido		;4122   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_09:		; pide el sonido 0x09
	ld a,009h		;4125   ; pide el sonido 0x09
	jp pide_sonido		;4127   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_0A:		; pide el sonido 0x0A
	ld a,00ah		;412a   ; pide el sonido 0x0A
	jp pide_sonido		;412c   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes

; ----------------------------------------------------------------------
; DATOS resto_412F: lo apuntan con el banco puesto p01:616D (0x412F), p00:44A4
;   (0x4134), p01:6168 (0x4134); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p01:616D, p00:44A4, p01:6168 (10 bytes)
;   0x412f..0x4139  (10 bytes)
DATA_resto_412F:
	defb 03eh,00bh,0c3h,0d5h,041h,03eh,00ch,0c3h,0d5h,041h	; 412f  >...A>...A

; ======================================================================
; CODIGO 0x4139..0x41b7  (126 bytes)
; ======================================================================


pide_sonido_0D:		; pide el sonido 0x0D
	ld a,00dh		;4139   ; pide el sonido 0x0D
	jp pide_sonido		;413b   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_0E:		; pide el sonido 0x0E
	ld a,00eh		;413e   ; pide el sonido 0x0E
	jp pide_sonido		;4140   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_0F:		; pide el sonido 0x0F
	ld a,00fh		;4143   ; pide el sonido 0x0F
	jp pide_sonido		;4145   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_10:		; pide el sonido 0x10
	ld a,010h		;4148   ; pide el sonido 0x10
	jp pide_sonido		;414a   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_pon:		; dice PON: la voz 0x11 con el tono del personaje de 0xC20D
	ld a,(0c20dh)		;414d   ; antes de pedir el 0x11, dice la voz del personaje de 0xC20D (p00:41AD)
	call tono_de_la_voz		;4150   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,011h		;4153
	jp pide_sonido		;4155   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_chi:		; dice CHI: la voz 0x12 con el tono del personaje de 0xC20D
	ld a,(0c20dh)		;4158   ; igual, con el sonido 0x12
	call tono_de_la_voz		;415b   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,012h		;415e
	jp pide_sonido		;4160   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_kan:		; dice KAN: la voz 0x13 con el tono del personaje de 0xC20D
	ld a,(0c20dh)		;4163   ; igual, con el sonido 0x13
	call tono_de_la_voz		;4166   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,013h		;4169
	jp pide_sonido		;416b   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_ron:		; dice RON: la voz 0x14 con el tono del personaje de 0xC20D
	ld a,(0c20dh)		;416e   ; igual, con el sonido 0x14
	call tono_de_la_voz		;4171   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,014h		;4174
	jp pide_sonido		;4176   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_riichi:		; dice RIICHI: la voz 0x15 con el tono del personaje de 0xC207
	ld a,(0c207h)		;4179   ; antes de pedir el 0x15, dice la voz del personaje de 0xC207
	call tono_de_la_voz		;417c   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,015h		;417f
	jp pide_sonido		;4181   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_tsumo:		; dice TSUMO: la voz 0x16 con el tono del personaje de 0xC207
	ld a,(0c207h)		;4184   ; igual, con el sonido 0x16
	call tono_de_la_voz		;4187   ; tono_de_la_voz: pone el tono de voz del personaje A (tabla 0xC030)
	ld a,016h		;418a
	jp pide_sonido		;418c   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
voz_17:		; la voz 0x17 (con el tono 0x83)
	ld a,083h		;418f   ; pide la voz 0x83 y despues el sonido 0x17
	call pide_sonido		;4191   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
	ld a,017h		;4194
	jp pide_sonido		;4196   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_sonido_18:		; pide la voz 0x18
	ld a,018h		;4199
	jp pide_sonido		;419b   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_orden_80:		; pide la orden 0x80 del motor de sonido (parar)
	ld a,080h		;419e
	jp pide_sonido		;41a0   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_orden_81:		; pide la orden 0x81 del motor de sonido (ritmo)
	ld a,081h		;41a3   ; pide la voz 0x81
	jp pide_sonido		;41a5   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
pide_orden_84:		; pide la orden 0x84 del motor de sonido (fundido)
	ld a,084h		;41a8
	jp pide_sonido		;41aa   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
tono_de_la_voz:		; pone el tono de voz del personaje A (tabla 0xC030)
	ld hl,0c030h		;41ad   ; voz del personaje: HL = 0xC030 + A (la tabla de 3 personajes), y el valor de ahi elige por la tabla de 41B7
	call suma_a_hl		;41b0   ; suma_a_hl: HL = HL + A
	ld a,(hl)			;41b3
	call despacha		;41b4   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_41B7: 9 destinos del despachador p00:4066 (call en p00:41B4, el
;   indice en A): 41C9, 41C9, 41CE, 41CF, 41CF, 41C9, 41C9, 41CE, 41CF; lo
;   leen p00:41B4 (18 bytes)
;   0x41b7..0x41c9  (18 bytes)
DATA_tabla_41B7:
	defw 041c9h,041c9h,041ceh,041cfh,041cfh,041c9h,041c9h,041ceh	; 41b7
	defw 041cfh	; 41c7  -> L_41CF

; ======================================================================
; CODIGO 0x41c9..0x4271  (168 bytes)
; ======================================================================


L_41C9:
	ld a,082h		;41c9   ; voz 0x82
	call pide_sonido		;41cb   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
L_41CE:
	ret			;41ce
L_41CF:
	ld a,083h		;41cf   ; voz 0x83
	call pide_sonido		;41d1   ; pide_sonido: pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
	ret			;41d4
pide_sonido:		; pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes
	di			;41d5   ; PIDE SONIDO A al motor de p12:6003: guarda todos los registros, pone 12-13-14 y devuelve los bancos de sus copias
	push hl			;41d6
	push de			;41d7
	push bc			;41d8
	push ix		;41d9
	push af			;41db
	ld a,00ch		;41dc
	ld (07000h),a		;41de   ; el mapper: pone en 0x6000 el banco de A
	inc a			;41e1
	ld (09000h),a		;41e2   ; el mapper: pone en 0x8000 el banco de A
	inc a			;41e5
	ld (0b000h),a		;41e6   ; el mapper: pone en 0xA000 el banco de A
	pop af			;41e9
	push af			;41ea
	call 06003h		;41eb   ; motor de sonido: arranca el sonido A (A >= 0x80 son voces PCM)
	ld hl,0f0f1h		;41ee   ; apunta a la copia del banco en 0x6000
	ld a,(hl)			;41f1
	ld (07000h),a		;41f2   ; el mapper: pone en 0x6000 el banco de A
	inc hl			;41f5
	ld a,(hl)			;41f6
	ld (09000h),a		;41f7   ; el mapper: pone en 0x8000 el banco de A
	inc hl			;41fa
	ld a,(hl)			;41fb
	ld (0b000h),a		;41fc   ; el mapper: pone en 0xA000 el banco de A
	pop af			;41ff
	pop ix		;4200
	pop bc			;4202
	pop de			;4203
	pop hl			;4204
	ei			;4205
	ret			;4206

; ----------------------------------------------------------------------
; =====  Rutinas de banco: ponen bancos y su copia en 0xF0F1-3  =====
; ----------------------------------------------------------------------
bancos_1_2_3:		; pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	push af			;4207   ; bancos 1-2-3 en las tres ventanas (lo normal del juego), con sus copias en 0xF0F1-3
	ld a,001h		;4208   ; empieza por el banco 1
L_420A:
	di			;420a   ; la copia en RAM de cada registro va delante de la escritura al mapper
	push hl			;420b
	ld hl,0f0f1h		;420c   ; apunta a la copia del banco en 0x6000
	ld (hl),a			;420f
	ld (07000h),a		;4210   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4213
	inc hl			;4214
	ld (hl),a			;4215
	ld (09000h),a		;4216   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4219
	inc hl			;421a
	ld (hl),a			;421b
	ld (0b000h),a		;421c   ; el mapper: pone en 0xA000 el banco de A
	pop hl			;421f
	pop af			;4220
	ei			;4221
	ret			;4222
bancos_4:		; pone el 4 (y sus copias en 0xF0F1-3)
	push af			;4223
	ld a,004h		;4224   ; 0x4223: solo el banco 4 (en 0xA000)
	jr L_424E		;4226
bancos_5_6:		; pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	push af			;4228
	ld a,005h		;4229   ; 0x4228: bancos 5 y 6 (en 0x8000 y 0xA000)
	jr L_4235		;422b
bancos_7_8_9:		; pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	push af			;422d
	ld a,007h		;422e   ; 0x422D: bancos 7, 8 y 9
	jr L_420A		;4230
bancos_10_11:		; pone los bancos 10-11 (y sus copias en 0xF0F1-3)
	push af			;4232
	ld a,00ah		;4233   ; 0x4232: bancos 10 y 11 (en 0x8000 y 0xA000)
L_4235:
	di			;4235
	ld (0f0f2h),a		;4236   ; guarda la copia del banco en 0x8000
	ld (09000h),a		;4239   ; el mapper: pone en 0x8000 el banco de A
	inc a			;423c
	ld (0f0f3h),a		;423d   ; guarda la copia del banco en 0xA000
	ld (0b000h),a		;4240   ; el mapper: pone en 0xA000 el banco de A
	pop af			;4243
	ei			;4244
	ret			;4245
L_4246:
	push af			;4246
	ld a,00dh		;4247
	jr L_420A		;4249
bancos_15:		; pone el 15 (y sus copias en 0xF0F1-3)
	push af			;424b
	ld a,00fh		;424c   ; 0x424B: solo el banco 15 (en 0xA000)
L_424E:
	di			;424e
	ld (0f0f3h),a		;424f   ; guarda la copia del banco en 0xA000
	ld (0b000h),a		;4252   ; el mapper: pone en 0xA000 el banco de A
	pop af			;4255
	ei			;4256
	ret			;4257
bancos_11:		; pone el 11 (y sus copias en 0xF0F1-3)
	push af			;4258
	ld a,00bh		;4259   ; 0x4258: solo el banco 11 (en 0xA000)
	jr L_424E		;425b

; ----------------------------------------------------------------------
; =====  LA MAQUINA DE ESTADOS DEL JUEGO  =====
; ----------------------------------------------------------------------
cuadro_del_juego:		; un cuadro de la maquina de estados del juego (0xC000, 0xC001)
	ld hl,0c003h		;425d   ; un cuadro del juego: 0xC003 cuenta cuadros
	inc (hl)			;4260
	ld bc,(0c000h)		;4261   ; C = estado (0xC000), B = paso (0xC001)
	ld a,c			;4265
	cp 003h		;4266   ; los estados 0, 1 y 2 vuelven por p00:499E
	jr nc,L_426E		;4268
	ld hl,0499eh		;426a
	push hl			;426d
L_426E:
	call despacha		;426e   ; salta por la tabla de estados de p00:4271 (A = estado)

; ----------------------------------------------------------------------
; DATOS tabla_4271: 9 destinos del despachador p00:4066 (call en p00:426E, el
;   indice en A): 4283, 42D1, 42DC, 430A, 44CA, 451B, 4531, 476A, 48C6; lo
;   leen p00:426E (18 bytes)
;   0x4271..0x4283  (18 bytes)
DATA_tabla_4271:
	defw 04283h,042d1h,042dch,0430ah,044cah,0451bh,04531h,0476ah	; 4271	tabla de estados: 9 rutinas (titulo, menus, partida, ...) que elige 0xC000
	defw 048c6h	; 4281  -> L_48C6

; ======================================================================
; CODIGO 0x4283..0x4287  (4 bytes)
; ======================================================================


L_4283:
	ld a,b			;4283   ; estado 0: el paso (B) elige por la tabla de 0x4287
	call despacha		;4284   ; el paso (B) elige por su tabla de p00:4287

; ----------------------------------------------------------------------
; DATOS tabla_4287: 4 destinos del despachador p00:4066 (call en p00:4284, el
;   indice en A): 428F, 4297, 42A5, 42C5; lo leen p00:4284 (8 bytes)
;   0x4287..0x428f  (8 bytes)
DATA_tabla_4287:
	defw 0428fh,04297h,042a5h,042c5h	; 4287  -> L_428F L_4297 L_42A5 L_42C5

; ======================================================================
; CODIGO 0x428f..0x4313  (132 bytes)
; ======================================================================


L_428F:
	call limpia_pantalla		;428f   ; estado 0, paso 0: limpia la pantalla y la prepara
	call L_5C12		;4292   ; prepara la pantalla del titulo (bancos 5-6: paleta de 0xAF80, imagenes de 0xAFD1, 0xB039 y 0xB0A1)
	jr L_42EB		;4295
L_4297:
	call L_5C6F		;4297   ; un paso de la animacion del titulo: cada dos cuadros se dibuja otra columna del dibujo; al acabar, 0xC202 = 1
	ld a,(0c202h)		;429a   ; lee la Y de la ficha en la hoja de tiles
	or a			;429d
	ret z			;429e
	call dibuja_mesa		;429f   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	xor a			;42a2
	jr L_42E8		;42a3
L_42A5:
	ld hl,0c004h		;42a5   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;42a8
	ret nz			;42a9
	call limpia_pantalla		;42aa   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call pantalla_off		;42ad   ; pantalla_off: apaga la pantalla
	call L_5CB2		;42b0   ; prepara la pantalla del menu (bancos 10-11): lista 0x9502, tabla 0x94B2
	call L_5CD7		;42b3
	call pantalla_on		;42b6   ; pantalla_on: enciende la pantalla
	xor a			;42b9
	ld (0c01ah),a		;42ba   ; guarda el paso de la animacion del titulo
	call pide_sonido_09		;42bd   ; pide_sonido_09: pide el sonido 0x09
	ld a,002h		;42c0
	jp L_42E8		;42c2
L_42C5:
	call L_5CE3		;42c5   ; el paso (0xC01A) elige la animacion del titulo
	ld a,(0c01ah)		;42c8   ; lee el paso de la animacion del titulo
	inc a			;42cb
	ret nz			;42cc
	xor a			;42cd
	jp L_450F		;42ce
L_42D1:
	ld hl,0c004h		;42d1   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;42d4
	ret nz			;42d5
	call limpia_pantalla		;42d6   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	jp L_450D		;42d9
L_42DC:
	ld a,b			;42dc
	and a			;42dd
	jr nz,L_42F0		;42de
	call limpia_pantalla		;42e0   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call 0617ch		;42e3   ; prepara_inicio: prepara el fondo de la partida
	ld a,020h		;42e6
L_42E8:
	ld (0c004h),a		;42e8   ; pone el temporizador 0xC004 a A
L_42EB:
	ld hl,0c001h		;42eb   ; paso siguiente: 0xC001 + 1
	inc (hl)			;42ee
	ret			;42ef
L_42F0:
	call bancos_4		;42f0   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	call 0b0d9h		;42f3   ; efecto_final_mano: el efecto de fondo del final de la mano
	call bancos_1_2_3		;42f6   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld a,(0c0b0h)		;42f9   ; lee 1 cuando la partida esta lista
	or a			;42fc
	ret nz			;42fd
	xor a			;42fe
L_42FF:
	ld (0c000h),a		;42ff   ; guarda el estado de la maquina de estados del juego (0-8)
	ld a,020h		;4302
	ld (0c004h),a		;4304   ; guarda el temporizador de espera entre pasos
	jp L_4516		;4307
L_430A:
	push bc			;430a
	call copia_sprites		;430b   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	pop bc			;430e
	ld a,b			;430f
	call despacha		;4310   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_4313: 8 destinos del despachador p00:4066 (call en p00:4310, el
;   indice en A): 4323, 4396, 441B, 4433, 444E, 445C, 4488, 4496; lo leen
;   p00:4310 (16 bytes)
;   0x4313..0x4323  (16 bytes)
DATA_tabla_4313:
	defw 04323h,04396h,0441bh,04433h,0444eh,0445ch,04488h,04496h	; 4313

; ======================================================================
; CODIGO 0x4323..0x438c  (105 bytes)
; ======================================================================


L_4323:
	call limpia_pantalla		;4323   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call L_59A9		;4326
	ld bc,00a07h		;4329
	call 00047h		;432c   ; BIOS WRTVDP - Writes data in the VDP-register
	call pantalla_off		;432f   ; pantalla_off: apaga la pantalla
	call L_4A09		;4332
	call L_5A89		;4335   ; carga dos conjuntos de tiles de los bancos 7-9 (las fichas del mahjong y sus numeros) con 3 y 2 bits por punto
	call espera_vdp		;4338   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	call L_57E3		;433b   ; vuelca una paleta de los bancos 5-6 (DE = lista)
	ld hl,04e4eh		;433e
	ld bc,0643ch		;4341
	ld a,0ffh		;4344
	ld d,000h		;4346
	call vdp_hmmv_2		;4348   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,04848h		;434b
	ld hl,00e09h		;434e
	call 09d1ch		;4351
	ld de,06858h		;4354
	ld hl,0438ch		;4357
	call escribe_texto		;435a   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	ld de,06870h		;435d
	ld hl,04391h		;4360
	call escribe_texto		;4363   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call pantalla_on		;4366   ; pantalla_on: enciende la pantalla
	call pide_sonido_0A		;4369
	call L_4375		;436c   ; llena de 9 la fila 0xCA00 (16 bytes) y de 2 la 0xCA10
	call L_43AF		;436f   ; dibuja el cursor del menu: dos sprites (0xCC00 y 0xCC04) en la tabla de atributos en RAM
	jp L_42EB		;4372
L_4375:
	ld hl,0ca00h		;4375   ; llena de 9 la fila 0xCA00 (16 bytes) y de 2 la 0xCA10
	ld a,009h		;4378
	call L_4382		;437a   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes)
	ld hl,0ca10h		;437d
	ld a,002h		;4380
L_4382:
	ld d,h			;4382   ; llena 16 bytes de HL con A (el primer byte y ldir de 15 a los siguientes)
	ld e,l			;4383
	inc de			;4384
	ld bc,0000fh		;4385   ; 15 bytes mas
	ld (hl),a			;4388
	ldir		;4389
	ret			;438b

; ----------------------------------------------------------------------
; DATOS resto_438C: lo apuntan con el banco puesto p00:4357 (0x438C), p00:4360
;   (0x4391); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:4357, p00:4360 (10 bytes)
;   0x438c..0x4396  (10 bytes)
DATA_resto_438C:
	defb 09dh,09eh,060h,02fh,0ffh,0a3h,07eh,060h,02fh,0ffh	; 438c  ..`/..~`/.

; ======================================================================
; CODIGO 0x4396..0x44c0  (298 bytes)
; ======================================================================


L_4396:
	ld a,(0c007h)		;4396   ; menu de dos opciones del titulo: lee las teclas (0xC007) y mueve el cursor
	ld c,a			;4399
	and 010h		;439a
	jr nz,L_43D3		;439c
	ld de,0c00fh		;439e   ; apunta a la opcion elegida en el menu del titulo (0 o 1)
	ld a,c			;43a1
	and 003h		;43a2
	ld c,058h		;43a4
	jr z,L_43AF		;43a6
	ld a,(de)			;43a8
	xor 001h		;43a9
	ld (de),a			;43ab
L_43AC:
	call pide_sonido_06		;43ac   ; pide_sonido_06: pide el sonido 0x06 (el del cursor)
L_43AF:
	ld hl,0cc00h		;43af   ; dibuja el cursor del menu: dos sprites (0xCC00 y 0xCC04) en la tabla de atributos en RAM
	exx			;43b2
	ld hl,0cc04h		;43b3
	exx			;43b6
	ld a,(de)			;43b7
	and a			;43b8
	ld a,05ch		;43b9
	jr z,L_43BF		;43bb
	ld a,074h		;43bd
L_43BF:
	ld (hl),a			;43bf   ; segundo byte del sprite: la X; escribe el patron A en el sprite de 0xCC00 y en el segundo de 0xCC04 (con el banco alterno)
	inc hl			;43c0
	exx			;43c1
	ld (hl),a			;43c2
	inc hl			;43c3
	exx			;43c4
	ld a,c			;43c5
	ld (hl),a			;43c6
	inc hl			;43c7
	exx			;43c8
	ld (hl),a			;43c9
	inc hl			;43ca
	exx			;43cb
	ld (hl),038h		;43cc   ; el color/atributos del cursor: 0x38 y 0x3C
	exx			;43ce
	ld (hl),03ch		;43cf
	exx			;43d1
	ret			;43d2
L_43D3:
	call pide_sonido_07		;43d3   ; se ha elegido: sale del menu y prepara la partida
	call limpia_pantalla		;43d6   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	xor a			;43d9
	ld (0c018h),a		;43da   ; guarda la opcion elegida en la pantalla de dos opciones (+1)
	ld (0c019h),a		;43dd   ; guarda la opcion elegida en la pantalla de cinco opciones (+1)
	call L_49FB		;43e0
	call bancos_15		;43e3   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	call 0a000h		;43e6   ; copia_estilos_rivales: copia a 0xC040 la tabla de estilos de los ocho rivales
	call 0a190h		;43e9   ; opciones_por_defecto: pone las diez opciones de reglas por defecto
	call bancos_1_2_3		;43ec   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call L_440B		;43ef
	ld a,(0f0f5h)		;43f2   ; lee la ranura del otro cartucho (la memoria de partidas)
	inc a			;43f5
	jr z,L_43FF		;43f6
	ld a,(0c00fh)		;43f8   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;43fb
	jp nz,L_42EB		;43fc
L_43FF:
	call carga_fondo_mesa		;43ff   ; carga_fondo_mesa: carga el fondo de la mesa (bancos 7-9)
	call L_5A89		;4402   ; carga dos conjuntos de tiles de los bancos 7-9 (las fichas del mahjong y sus numeros) con 3 y 2 bits por punto
	ld a,004h		;4405
	ld (0c001h),a		;4407   ; guarda el paso dentro del estado
	ret			;440a
L_440B:
	ld a,001h		;440b
	ld (0c031h),a		;440d   ; guarda el personaje que juega de rival 1
	ld a,002h		;4410
	ld (0c032h),a		;4412   ; guarda el personaje que juega de rival 2
	ld a,003h		;4415
	ld (0c033h),a		;4417   ; guarda el personaje que juega de rival 3
	ret			;441a
L_441B:
	call 0b373h		;441b   ; PANTALLA DE DOS OPCIONES (grabar, cargar): 0xC02C elige el paso por la tabla de 0xB377 (p03:B373)
	ld a,(0c018h)		;441e   ; lee la opcion elegida en la pantalla de dos opciones (+1)
	and a			;4421
	ret z			;4422
	cp 002h		;4423
	jr z,L_442D		;4425
	call L_49FB		;4427
	jp L_42EB		;442a
L_442D:
	ld hl,0c001h		;442d   ; apunta a el paso dentro del estado
	inc (hl)			;4430
	jr L_443F		;4431
L_4433:
	call L_44AC		;4433
	ld a,(0c02ah)		;4436   ; lee 1 cuando la pantalla de menu ha acabado
	and a			;4439
	ret z			;443a
	cp 002h		;443b
	jr z,L_4476		;443d
L_443F:
	call limpia_pantalla		;443f   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call L_49FB		;4442
	call carga_fondo_mesa		;4445   ; carga_fondo_mesa: carga el fondo de la mesa (bancos 7-9)
	call L_5A89		;4448   ; carga dos conjuntos de tiles de los bancos 7-9 (las fichas del mahjong y sus numeros) con 3 y 2 bits por punto
	jp L_42EB		;444b
L_444E:
	call 0b3d1h		;444e   ; PANTALLA DE CINCO OPCIONES: 0xC02C elige el paso por la tabla de 0xB3D5 (p03:B3D1)
	ld a,(0c019h)		;4451   ; lee la opcion elegida en la pantalla de cinco opciones (+1)
	and a			;4454
	ret z			;4455
	call L_49FB		;4456
	jp L_42EB		;4459
L_445C:
	call L_44B9		;445c
	ld a,(0c02ah)		;445f   ; lee 1 cuando la pantalla de menu ha acabado
	dec a			;4462
	jr z,L_4476		;4463
	dec a			;4465
	ret nz			;4466
	call L_49FB		;4467
	call limpia_pantalla		;446a   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call L_5746		;446d
	call L_5A89		;4470   ; carga dos conjuntos de tiles de los bancos 7-9 (las fichas del mahjong y sus numeros) con 3 y 2 bits por punto
	jp L_42EB		;4473
L_4476:
	call L_49FB		;4476
	xor a			;4479
	ld (0c019h),a		;447a   ; guarda la opcion elegida en la pantalla de cinco opciones (+1)
	ld (0c018h),a		;447d   ; guarda la opcion elegida en la pantalla de dos opciones (+1)
	call limpia_pantalla		;4480   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	ld hl,0c001h		;4483   ; apunta a el paso dentro del estado
	dec (hl)			;4486
	ret			;4487
L_4488:
	call 0aa15h		;4488   ; PANTALLA DE ELEGIR RIVALES: 0xC02C elige el paso por la tabla de 0xAA19 (p03:AA15)
	ld a,(0c02ah)		;448b   ; lee 1 cuando la pantalla de menu ha acabado
	and a			;448e
	ret z			;448f
	call L_49FB		;4490
	jp L_42EB		;4493
L_4496:
	call 08ed9h		;4496   ; estado de la pantalla de la ronda inicial (0xC02C): elige por la tabla de 0x8EDD (p02:8ED9)
	ld a,(0c02ah)		;4499   ; lee 1 cuando la pantalla de menu ha acabado
	and a			;449c
	ret z			;449d
	call L_49FB		;449e
	call L_586C		;44a1   ; pone los iconos de los tres rivales (0xC031-3) en el marco
	ld hl,04134h		;44a4
	ld (0c0c2h),hl		;44a7
	jr $+99		;44aa
L_44AC:
	ld a,(0c018h)		;44ac   ; lee la opcion elegida en la pantalla de dos opciones (+1)
	dec a			;44af
	jp z,0b48ch		;44b0
L_44B3:
	ld a,002h		;44b3
	ld (0c02ah),a		;44b5   ; guarda 1 cuando la pantalla de menu ha acabado
	ret			;44b8
L_44B9:
	ld a,(0c019h)		;44b9   ; lee la opcion elegida en la pantalla de cinco opciones (+1)
	dec a			;44bc
	call despacha		;44bd   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_44C0: 5 destinos del despachador p00:4066 (call en p00:44BD, el
;   indice en A): AFE7, AD9B, A803, 63D4, 44B3; lo leen p00:44BD (10 bytes)
;   0x44c0..0x44ca  (10 bytes)
DATA_tabla_44C0:
	defw 0afe7h,0ad9bh,0a803h,063d4h,044b3h	; 44c0

; ======================================================================
; CODIGO 0x44ca..0x44ce  (4 bytes)
; ======================================================================


L_44CA:
	ld a,b			;44ca
	call despacha		;44cb   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_44CE: 2 destinos del despachador p00:4066 (call en p00:44CB, el
;   indice en A): 44D2, 44E4; lo leen p00:44CB (4 bytes)
;   0x44ce..0x44d2  (4 bytes)
DATA_tabla_44CE:
	defw 044d2h,044e4h	; 44ce  -> L_44D2 L_44E4

; ======================================================================
; CODIGO 0x44d2..0x453a  (104 bytes)
; ======================================================================


L_44D2:
	call L_44E0		;44d2   ; salta a la rutina guardada en 0xC0C2 (HL)
	call prepara_partida		;44d5   ; prepara_partida: prepara la pantalla de la partida
	ld a,001h		;44d8
	ld (0c1c2h),a		;44da   ; guarda el paso del reparto
	jp L_42EB		;44dd
L_44E0:
	ld hl,(0c0c2h)		;44e0   ; salta a la rutina guardada en 0xC0C2 (HL)
	jp (hl)			;44e3
L_44E4:
	call 06146h		;44e4   ; pasa al estado siguiente y borra la tabla 0xCD00 (256 bytes)
	ld a,(0c1c2h)		;44e7   ; lee el paso del reparto
	and a			;44ea
	jp nz,08a71h		;44eb
	call mano_del_actual		;44ee   ; mano_del_actual: HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	ld hl,0cd00h		;44f1   ; apunta a 1 si la mano es de limite
	ld de,0cd01h		;44f4   ; apunta a 1 si algun jugador ha bajado grupos
	ld bc,000ffh		;44f7
	ld (hl),000h		;44fa
	ldir		;44fc
	call bancos_15		;44fe   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	call 0a04ch		;4501   ; estilos_a_manos: pone a cada rival elegido su estilo en +0x90 de su mano
	call 0a080h		;4504   ; prepara_ia: prepara la partida de los tres rivales de la maquina
	call 0a072h		;4507   ; pone a cero 0xC510 (13 bytes) (p15:A072)
	call bancos_1_2_3		;450a   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_450D:
	ld a,020h		;450d   ; pone el temporizador a 0x20 y pasa al estado siguiente (paso 0)
L_450F:
	ld (0c004h),a		;450f   ; guarda el temporizador de espera entre pasos
	ld hl,0c000h		;4512   ; apunta a el estado de la maquina de estados del juego (0-8)
	inc (hl)			;4515
L_4516:
	xor a			;4516   ; vuelve al paso 0 del estado
	ld (0c001h),a		;4517   ; guarda el paso dentro del estado
	ret			;451a
L_451B:
	call turno_humano		;451b   ; turno_humano: un paso de las respuestas del humano
	ld a,(0c0b8h)		;451e   ; lee el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	and a			;4521
	ld a,008h		;4522
	jp nz,L_42FF		;4524
	ld a,(0c0b1h)		;4527   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	and a			;452a
	ret z			;452b
	call L_4571		;452c   ; dice la voz del jugador al que le toca (por 0xC0B1 elige entre 0xC207 y 0xC20D)
	jr L_450D		;452f
L_4531:
	push bc			;4531
	call copia_sprites		;4532   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	pop bc			;4535
	ld a,b			;4536
	call despacha		;4537   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_453A: 7 destinos del despachador p00:4066 (call en p00:4537, el
;   indice en A): 4548, 459A, 45A5, 45B1, 4619, 4677, 4738; lo leen p00:4537
;   (14 bytes)
;   0x453a..0x4548  (14 bytes)
DATA_tabla_453A:
	defw 04548h,0459ah,045a5h,045b1h,04619h,04677h,04738h	; 453a

; ======================================================================
; CODIGO 0x4548..0x4611  (201 bytes)
; ======================================================================


L_4548:
	ld a,(0c24ah)		;4548   ; lee el tiempo que queda de la cara que habla
	and a			;454b
	jp nz,0a747h		;454c   ; cuenta_atras_cuadro: cuenta atras del cuadro de la voz
	call 06559h		;454f   ; cuenta cuantos jugadores tienen los bits 3-4 puestos (0xC0BA) y guarda quienes son (0xC0BB..) (p01:6559)
	call 06509h		;4552   ; por cada jugador (0xC207 o los cuatro) con los bits 3-4 puestos en +0x60 de su mano, hace la jugada de la IA (0x8CF5 y 0x8B8C) (p01:6509)
	call 09ee5h		;4555   ; recorre los jugadores que dijeron algo (0xC0BA: cuantos, 0xC0BB..): para el primero con +0x34 a cero sigue en 0x9F09 (p02:9EE5)
	ld a,(0c0bah)		;4558   ; lee cuantos jugadores responden a la ficha tirada
	cp 003h		;455b
	jr z,L_4584		;455d
	ld hl,0cd02h		;455f
	ld a,(hl)			;4562
	and a			;4563
	push hl			;4564
	call z,06c5dh		;4565
	pop hl			;4568
	ld (hl),000h		;4569
	ld a,0f0h		;456b
	call L_42E8		;456d   ; pone el temporizador 0xC004 a A
	ret			;4570
L_4571:
	ld a,(0c0b1h)		;4571   ; dice la voz del jugador al que le toca (por 0xC0B1 elige entre 0xC207 y 0xC20D)
	dec a			;4574
	ld a,(0c207h)		;4575   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_457D		;4578
	ld a,(0c20dh)		;457a   ; lee el jugador que responde a la ficha tirada
L_457D:
	and a			;457d
	jp z,pide_sonido_0D		;457e
	jp pide_sonido_0E		;4581
L_4584:
	xor a			;4584
	ld (0c0b1h),a		;4585   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	inc a			;4588
	ld (0c0e6h),a		;4589   ; guarda 1 si se anula porque tres jugadores dicen ron
	inc a			;458c
	ld (0c0b8h),a		;458d   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ld a,0f0h		;4590
	ld (0c004h),a		;4592   ; guarda el temporizador de espera entre pasos
	ld a,008h		;4595
	jp L_42FF		;4597
L_459A:
	ld hl,0c004h		;459a   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;459d
	ret nz			;459e
	call 0a580h		;459f   ; muestra_puntuacion: muestra los yaku y los puntos de la mano ganadora
	jp L_42EB		;45a2
L_45A5:
	call bancos_4		;45a5   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	call 0a943h		;45a8   ; puntua_mano: puntua la mano ganadora y paga
	call bancos_1_2_3		;45ab   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	jp L_42EB		;45ae
L_45B1:
	ld a,(0c007h)		;45b1   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 010h		;45b4
	jr nz,L_45CC		;45b6
	ld a,(0c007h)		;45b8   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 020h		;45bb
	ret z			;45bd
	ld hl,0c001h		;45be   ; apunta a el paso dentro del estado
	dec (hl)			;45c1
	dec (hl)			;45c2
	call 0a646h		;45c3
	ld a,0f0h		;45c6
	ld (0c004h),a		;45c8   ; guarda el temporizador de espera entre pasos
	ret			;45cb
L_45CC:
	ld hl,0c0a0h		;45cc
	ld de,0c280h		;45cf
	ld bc,0000ch		;45d2
	ldir		;45d5
	ld a,(0c207h)		;45d7   ; lee el jugador al que le toca (0 = el humano)
	push af			;45da
	ld b,004h		;45db
L_45DD:
	push bc			;45dd
	ld a,b			;45de
	dec a			;45df
	ld (0c207h),a		;45e0   ; guarda el jugador al que le toca (0 = el humano)
	ld hl,04611h		;45e3
	call palabra_de_tabla		;45e6   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld b,000h		;45e9
	ld a,(hl)			;45eb
	ld c,a			;45ec
	inc hl			;45ed
	ld a,(hl)			;45ee
	and a			;45ef
	jr nz,L_45F3		;45f0
	inc b			;45f2
L_45F3:
	ld e,a			;45f3   ; cuenta en B cuantas de las dos fichas son cero (D, E)
	inc hl			;45f4
	ld a,(hl)			;45f5
	and a			;45f6
	jr nz,L_45FA		;45f7
	inc b			;45f9
L_45FA:
	ld d,a			;45fa
	ld a,b			;45fb
	cp 002h		;45fc
	jp z,L_4604		;45fe
	call suma_puntos_actual		;4601   ; suma_puntos_actual: suma al marcador del jugador 0xC207 el importe C (signo) y DE (BCD)
L_4604:
	pop bc			;4604
	djnz L_45DD		;4605
	call dibuja_marcadores		;4607   ; dibuja_marcadores: dibuja los cuatro paneles de puntos de los jugadores
	pop af			;460a
	ld (0c207h),a		;460b   ; guarda el jugador al que le toca (0 = el humano)
	jp L_42EB		;460e

; ----------------------------------------------------------------------
; DATOS resto_4611: lo apuntan con el banco puesto p00:45E3 (0x4611); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:45E3 (8 bytes)
;   0x4611..0x4619  (8 bytes)
DATA_resto_4611:
	defb 08ch,0c2h,08fh,0c2h,092h,0c2h,095h,0c2h	; 4611  ........

; ======================================================================
; CODIGO 0x4619..0x4765  (332 bytes)
; ======================================================================


L_4619:
	ld a,(0c007h)		;4619   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 010h		;461c
	ret z			;461e
	ld a,(0c0b1h)		;461f   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;4622
	ld a,(0c207h)		;4623   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_462B		;4626
	ld a,(0c20dh)		;4628   ; lee el jugador que responde a la ficha tirada
L_462B:
	add a,a			;462b
	add a,a			;462c
	ld hl,0d034h		;462d
	add a,h			;4630
	ld h,a			;4631
	ld a,(hl)			;4632
	and a			;4633
	jr z,L_463A		;4634
	xor a			;4636
	ld (0c0b4h),a		;4637   ; guarda las barras de riichi sobre la mesa (BCD)
L_463A:
	ld a,(0c028h)		;463a   ; lee la regla del ron doble (ダブルロン; de serie si)
	and a			;463d
	jp z,L_42EB		;463e
	ld a,(0c0c5h)		;4641
	and a			;4644
	jp nz,L_42EB		;4645
	ld hl,0c0bah		;4648   ; apunta a cuantos jugadores responden a la ficha tirada
	ld a,(hl)			;464b
	cp 002h		;464c
	jp c,L_42EB		;464e
	xor a			;4651
	ld (0c232h),a		;4652   ; guarda la linea de la lista de yaku que se escribe
	ld hl,0c28ch		;4655
	ld de,0c28dh		;4658
	ld bc,0000bh		;465b
	ld (hl),a			;465e
	ldir		;465f
	inc a			;4661
	ld (0c0c5h),a		;4662
	ld a,(0c0bch)		;4665
	ld (0c20dh),a		;4668   ; guarda el jugador que responde a la ficha tirada
	call 06c5dh		;466b   ; analiza_mano_actual: analiza la mano del jugador al que le toca
	call 0a646h		;466e
	ld a,001h		;4671
	ld (0c001h),a		;4673   ; guarda el paso dentro del estado
	ret			;4676
L_4677:
	call 0bd8eh		;4677   ; adapta_estilo: adapta el estilo de los rivales a la mano ganadora
	call 0be64h		;467a
	ld de,0c0b5h		;467d   ; apunta a las barras de honba (BCD)
	ld a,(0cda0h)		;4680   ; lee 1 si el humano ha decidido ganar
	and a			;4683
	jr z,L_4691		;4684
	ld a,(de)			;4686
	cp 099h		;4687
	jr z,L_46DC		;4689
	add a,001h		;468b
	daa			;468d
	ld (de),a			;468e
	jr L_46DC		;468f
L_4691:
	ld hl,0c0bah		;4691   ; apunta a cuantos jugadores responden a la ficha tirada
	ld b,(hl)			;4694
	ld a,(0c0b7h)		;4695   ; lee el jugador que reparte (0-3)
L_4698:
	inc hl			;4698   ; busca el jugador entre los de 0xC0B7+: si coincide con el que reparte salta a 0x46CF
	cp (hl)			;4699
	jr z,L_46CF		;469a
	djnz L_4698		;469c
	push de			;469e   ; si nadie gana, mira si hay un jugador con tres o mas (p01:64E3): si es asi, final de la partida
	call 064e3h		;469f   ; mira si hay algun jugador con mas de 2 de 0xC0B3: devuelve acarreo (p01:64E3)
	pop de			;46a2
	jp c,L_46E3		;46a3
	ld hl,0c0b3h		;46a6   ; apunta a el numero de la mano dentro del viento (0-3)
	ld a,(hl)			;46a9
	inc a			;46aa
	cp 004h		;46ab
	jr c,L_46BF		;46ad
	dec hl			;46af
	ld a,(hl)			;46b0
	inc a			;46b1
	cp 004h		;46b2
	jr c,L_46BC		;46b4
	ld a,001h		;46b6
	ld (0c0e3h),a		;46b8
	xor a			;46bb
L_46BC:
	ld (hl),a			;46bc
	inc hl			;46bd
	xor a			;46be
L_46BF:
	ld (hl),a			;46bf
	xor a			;46c0
	ld (de),a			;46c1
	ld (0c0c4h),a		;46c2   ; guarda las manos seguidas del que reparte
	ld hl,0c0b7h		;46c5   ; apunta a el jugador que reparte (0-3)
	ld a,(hl)			;46c8
	inc a			;46c9
	and 003h		;46ca
	ld (hl),a			;46cc
	jr L_46DC		;46cd
L_46CF:
	ld a,(de)			;46cf   ; suma uno al contador de manos seguidas (BCD, tope 99)
	cp 099h		;46d0
	jr z,L_46D8		;46d2
	add a,001h		;46d4
	daa			;46d6
	ld (de),a			;46d7
L_46D8:
	ld hl,0c0c4h		;46d8   ; apunta a las manos seguidas del que reparte
	inc (hl)			;46db
L_46DC:
	xor a			;46dc
	ld (0c0b1h),a		;46dd   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	jp L_495A		;46e0
L_46E3:
	ld a,(0c0b4h)		;46e3   ; lee las barras de riichi sobre la mesa (BCD)
	and a			;46e6
	jr z,L_473E		;46e7
	ld hl,0c0a0h		;46e9
	ld de,0c280h		;46ec
	ld bc,0000ch		;46ef
	ldir		;46f2
	ld hl,0c28ch		;46f4
	ld de,0c28dh		;46f7
	ld bc,0000bh		;46fa
	ld (hl),000h		;46fd
	ldir		;46ff
	ld a,(0c0b1h)		;4701   ; lee como se gana la mano: 1 por robo, 2 por la ficha tirada
	dec a			;4704
	ld a,(0c207h)		;4705   ; lee el jugador al que le toca (0 = el humano)
	jr z,L_470D		;4708
	ld a,(0c20dh)		;470a   ; lee el jugador que responde a la ficha tirada
L_470D:
	push af			;470d
	ld b,a			;470e
	add a,a			;470f
	add a,b			;4710
	ld hl,0c28ch		;4711
	call suma_a_hl		;4714   ; suma_a_hl: HL = HL + A
	inc hl			;4717
	ld a,(0c0b4h)		;4718   ; lee las barras de riichi sobre la mesa (BCD)
	ld b,a			;471b
	and 00fh		;471c
	rrd		;471e
	ld e,(hl)			;4720
	inc hl			;4721
	ld a,b			;4722
	rrca			;4723
	rrca			;4724
	rrca			;4725
	rrca			;4726
	and 00fh		;4727
	rld		;4729
	ld d,(hl)			;472b
	pop af			;472c
	ld c,000h		;472d
	call suma_puntos		;472f   ; suma_puntos: suma al marcador del jugador A (3 bytes en 0xC0A0 + 3 x A) el importe C (signo) y DE (BCD)
	call dibuja_marcadores		;4732   ; dibuja_marcadores: dibuja los cuatro paneles de puntos de los jugadores
	jp L_42EB		;4735
L_4738:
	ld a,(0c007h)		;4738   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 010h		;473b
	ret z			;473d
L_473E:
	ld hl,05e5eh		;473e
	ld bc,04414h		;4741
	ld a,099h		;4744
	ld d,000h		;4746
	call vdp_hmmv_2		;4748   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,05858h		;474b
	ld hl,00a04h		;474e
	call 09d1ch		;4751
	ld de,06060h		;4754
	ld hl,04765h		;4757
	call escribe_texto		;475a   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call pide_sonido_10		;475d   ; pide_sonido_10: pide el sonido 0x10
	ld a,0f0h		;4760
	jp L_450F		;4762

; ----------------------------------------------------------------------
; DATOS resto_4765: lo apuntan con el banco puesto p00:4757 (0x4765); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:4757 (5 bytes)
;   0x4765..0x476a  (5 bytes)
DATA_resto_4765:
	defb 082h,027h,022h,039h,0ffh	; 4765

; ======================================================================
; CODIGO 0x476a..0x4773  (9 bytes)
; ======================================================================


L_476A:
	push bc			;476a
	call copia_sprites		;476b   ; copia_sprites: copia la tabla de colores de los sprites a la VRAM
	pop bc			;476e
	ld a,b			;476f
	call despacha		;4770   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_4773: 7 destinos del despachador p00:4066 (call en p00:4770, el
;   indice en A): 4781, 47A7, 47DD, 4824, 4892, 489B, 48B7; lo leen p00:4770
;   (14 bytes)
;   0x4773..0x4781  (14 bytes)
DATA_tabla_4773:
	defw 04781h,047a7h,047ddh,04824h,04892h,0489bh,048b7h	; 4773

; ======================================================================
; CODIGO 0x4781..0x481e  (157 bytes)
; ======================================================================


L_4781:
	ld hl,0c004h		;4781   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;4784
	ret nz			;4785
	call limpia_pantalla		;4786   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call carga_fondo_mesa		;4789   ; carga_fondo_mesa: carga el fondo de la mesa (bancos 7-9)
	call dibuja_mesa		;478c   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	call 0b8d4h		;478f   ; resultados_finales: pantalla de los resultados finales
	call L_56F2		;4792   ; carga una imagen de los bancos 10-11 y su paleta (0xF800)
	call bancos_4		;4795   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	call 0b695h		;4798   ; inicia las caras de los rivales: pone a cero 0xC300, 0xC301 y 0xC25D (34 bytes), y pone los sprites fuera de pantalla (p04:B695)
	call bancos_1_2_3		;479b   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call espera_vdp		;479e   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	call L_57F2		;47a1
	jp L_42EB		;47a4
L_47A7:
	call bancos_4		;47a7   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	call 0b6ach		;47aa   ; anima_rivales: anima las caras de los tres rivales
	call bancos_1_2_3		;47ad   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld a,(0c007h)		;47b0   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 010h		;47b3
	ret z			;47b5
	call L_47BC		;47b6
	jp L_42EB		;47b9
L_47BC:
	call limpia_pantalla		;47bc   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call pantalla_off		;47bf   ; pantalla_off: apaga la pantalla
	call L_57E3		;47c2   ; vuelca una paleta de los bancos 5-6 (DE = lista)
	call L_580B		;47c5
	call L_5801		;47c8
	call L_581C		;47cb
	call dibuja_mesa		;47ce   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	call 0bc66h		;47d1   ; PANTALLA DE LOS RESULTADOS POR RIVAL: dibuja la lista 0xBD33 y los nueve marcadores de 0xC082..0xC09A y las nueve cuentas de 0xC034..0xC03C (p03:BC66)
	ld bc,00807h		;47d4
	call 00047h		;47d7   ; BIOS WRTVDP - Writes data in the VDP-register
	jp pantalla_on		;47da   ; pantalla_on: enciende la pantalla
L_47DD:
	ld a,(0c007h)		;47dd   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 010h		;47e0
	ret z			;47e2
	call limpia_pantalla		;47e3   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call pantalla_off		;47e6   ; pantalla_off: apaga la pantalla
	ld hl,05e4eh		;47e9
	ld bc,0443ch		;47ec
	ld a,0ffh		;47ef
	ld d,000h		;47f1
	call vdp_hmmv_2		;47f3   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,05848h		;47f6
	ld hl,00a09h		;47f9
	call 09d1ch		;47fc
	ld de,07858h		;47ff
	ld hl,0481eh		;4802
	call escribe_texto		;4805   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	ld de,07870h		;4808
	ld hl,04821h		;480b
	call escribe_texto		;480e   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call L_4375		;4811   ; llena de 9 la fila 0xCA00 (16 bytes) y de 2 la 0xCA10
	call pantalla_on		;4814   ; pantalla_on: enciende la pantalla
	xor a			;4817
	ld (0c01eh),a		;4818   ; guarda la opcion elegida en el segundo menu del titulo
	jp L_42EB		;481b

; ----------------------------------------------------------------------
; DATOS resto_481E: lo apuntan con el banco puesto p00:4802 (0x481E), p00:480B
;   (0x4821); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:4802, p00:480B (6 bytes)
;   0x481e..0x4824  (6 bytes)
DATA_resto_481E:
	defb 0bah,0bbh,0ffh,022h,039h,0ffh	; 481e

; ======================================================================
; CODIGO 0x4824..0x48ca  (166 bytes)
; ======================================================================


L_4824:
	ld a,(0c007h)		;4824   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	ld c,a			;4827
	and 010h		;4828
	jr nz,L_483E		;482a
	ld a,c			;482c
	and 003h		;482d
	ld de,0c01eh		;482f   ; apunta a la opcion elegida en el segundo menu del titulo
	ld c,068h		;4832
	jp z,L_43AF		;4834
	ld a,(de)			;4837
	xor 001h		;4838
	ld (de),a			;483a
	jp L_43AC		;483b
L_483E:
	ld a,(0f0f5h)		;483e   ; lee la ranura del otro cartucho (la memoria de partidas)
	inc a			;4841
	jr z,L_484B		;4842
	ld a,(0c00fh)		;4844   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;4847
	jp nz,L_42EB		;4848
L_484B:
	call pide_orden_81		;484b   ; pide_orden_81: pide la orden 0x81 del motor de sonido (ritmo)
	ld a,(0c01eh)		;484e   ; lee la opcion elegida en el segundo menu del titulo
	and a			;4851
	jr z,L_485F		;4852
	ld a,03ch		;4854
	ld (0c004h),a		;4856   ; guarda el temporizador de espera entre pasos
	ld a,006h		;4859
	ld (0c001h),a		;485b   ; guarda el paso dentro del estado
	ret			;485e
L_485F:
	call limpia_pantalla		;485f   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call carga_fondo_mesa		;4862   ; carga_fondo_mesa: carga el fondo de la mesa (bancos 7-9)
	call L_5746		;4865
	call dibuja_mesa		;4868   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	ld bc,00a07h		;486b
	call 00047h		;486e   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,0c0a0h		;4871
	ld de,0c0a1h		;4874
	ld bc,00d5fh		;4877
	ld (hl),000h		;487a
	ldir		;487c
	call L_49FB		;487e
	xor a			;4881
	ld (0c018h),a		;4882   ; guarda la opcion elegida en la pantalla de dos opciones (+1)
	ld (0c019h),a		;4885   ; guarda la opcion elegida en la pantalla de cinco opciones (+1)
	call pide_sonido_0A		;4888
	ld hl,00403h		;488b
	ld (0c000h),hl		;488e   ; guarda el estado de la maquina de estados del juego (0-8) y el byte siguiente (16 bits)
	ret			;4891
L_4892:
	call limpia_pantalla		;4892   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call L_49FB		;4895
	jp L_42EB		;4898
L_489B:
	call 0bba0h		;489b   ; PANTALLA DE GRABAR: si no hay otro cartucho (0xF0F5 = 0xFF) espera y sale; si no dibuja la ventana con la lista 0x5A17 (p03:BBA0)
	ld a,(0c02ah)		;489e   ; lee 1 cuando la pantalla de menu ha acabado
	and a			;48a1
	ret z			;48a2
	cp 002h		;48a3
	jp z,L_4476		;48a5
	call pide_orden_81		;48a8   ; pide_orden_81: pide la orden 0x81 del motor de sonido (ritmo)
	ld a,(0c01eh)		;48ab   ; lee la opcion elegida en el segundo menu del titulo
	and a			;48ae
	jp z,L_485F		;48af
	ld a,03ch		;48b2
	jp L_42E8		;48b4
L_48B7:
	ld hl,0c004h		;48b7   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;48ba
	ret nz			;48bb
	call pide_sonido_01		;48bc   ; pide_sonido_01: pide el sonido 0x01 al motor de sonido (p12:6003)
	ld hl,00000h		;48bf
	ld (0c000h),hl		;48c2   ; guarda el estado de la maquina de estados del juego (0-8) y el byte siguiente (16 bits)
	ret			;48c5
L_48C6:
	ld a,b			;48c6
	call despacha		;48c7   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_48CA: 4 destinos del despachador p00:4066 (call en p00:48C7, el
;   indice en A): 48D2, 490C, 4944, 4955; lo leen p00:48C7 (8 bytes)
;   0x48ca..0x48d2  (8 bytes)
DATA_tabla_48CA:
	defw 048d2h,0490ch,04944h,04955h	; 48ca  -> L_48D2 L_490C L_4944 L_4955

; ======================================================================
; CODIGO 0x48d2..0x4aed  (539 bytes)
; ======================================================================


L_48D2:
	ld a,(0c0b8h)		;48d2   ; lee el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	dec a			;48d5
	jr nz,L_48F3		;48d6
	call 06cbfh		;48d8
	jr c,L_48FE		;48db
	call 07083h		;48dd   ; mira si algun jugador tiene una mano que no vale (con 0xC023) (p01:7083)
	jr nc,L_48F3		;48e0
	call L_4571		;48e2   ; dice la voz del jugador al que le toca (por 0xC0B1 elige entre 0xC207 y 0xC20D)
L_48E5:
	xor a			;48e5
	ld (0c0b8h),a		;48e6   ; guarda el final de la ronda: 1 sin fichas, 2 hay ganador o aborto
	ld (0c0e4h),a		;48e9
	ld hl,00106h		;48ec
	ld (0c000h),hl		;48ef   ; guarda el estado de la maquina de estados del juego (0-8) y el byte siguiente (16 bits)
	ret			;48f2
L_48F3:
	call pide_sonido_0F		;48f3
	call 0b63dh		;48f6   ; fin_de_ronda: fin de la ronda: elige el aviso y quien reparte
	ld a,0f0h		;48f9
	jp L_42E8		;48fb
L_48FE:
	xor a			;48fe
	ld (0c207h),a		;48ff   ; guarda el jugador al que le toca (0 = el humano)
	ld a,001h		;4902
	ld (0c0b1h),a		;4904   ; guarda como se gana la mano: 1 por robo, 2 por la ficha tirada
	call pide_sonido_0E		;4907
	jr L_48E5		;490a
L_490C:
	ld a,(0c007h)		;490c   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and a			;490f
	jr nz,L_491C		;4910
	ld a,(0c003h)		;4912   ; lee el contador de cuadros
	rra			;4915
	ret c			;4916
	ld hl,0c004h		;4917   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;491a
	ret nz			;491b
L_491C:
	xor a			;491c
	ld (0c0c4h),a		;491d   ; guarda las manos seguidas del que reparte
	ld hl,0c0b5h		;4920   ; apunta a las barras de honba (BCD)
	ld a,(hl)			;4923
	cp 099h		;4924
	jr nc,L_492C		;4926
	add a,001h		;4928
	daa			;492a
	ld (hl),a			;492b
L_492C:
	ld hl,0c0e4h		;492c
	ld a,(hl)			;492f
	and a			;4930
	jr nz,L_4939		;4931
	ld hl,0c001h		;4933   ; apunta a el paso dentro del estado
	inc (hl)			;4936
	inc (hl)			;4937
	ret			;4938
L_4939:
	call 0b580h		;4939   ; cuenta cuantos jugadores tienen +0x81 (en espera al acabar la ronda) en 0xC22F (p03:B580)
	call 0b59ch		;493c   ; paga_esperas: paga las esperas de una ronda sin ganador
	ld a,0f0h		;493f
	jp L_42E8		;4941
L_4944:
	ld a,(0c007h)		;4944   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and a			;4947
	jr nz,L_494F		;4948
	ld hl,0c004h		;494a   ; apunta a el temporizador de espera entre pasos
	dec (hl)			;494d
	ret nz			;494e
L_494F:
	call 0bf09h		;494f   ; ajusta el estilo de los tres rivales (+0x90..+0x96) segun lo que ha pasado en la ronda (p03:BF09)
	jp L_42EB		;4952
L_4955:
	ld a,(0c007h)		;4955   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and a			;4958
	ret z			;4959
L_495A:
	call L_44E0		;495a   ; salta a la rutina guardada en 0xC0C2 (HL)
	call limpia_pantalla		;495d   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call pantalla_off		;4960   ; pantalla_off: apaga la pantalla
	call L_5746		;4963
	call dibuja_mesa		;4966   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	ld a,(0c207h)		;4969   ; lee el jugador al que le toca (0 = el humano)
	push af			;496c
	call 09636h		;496d   ; dibuja las fichas del muro muertas: un rectangulo de 122 x 74 y siete fichas (p02:9636)
	pop af			;4970
	ld (0c207h),a		;4971   ; guarda el jugador al que le toca (0 = el humano)
	call 065c6h		;4974   ; dibuja_rivales: dibuja las tres fichas de los rivales
	call pantalla_on		;4977   ; pantalla_on: enciende la pantalla
	call L_570E		;497a   ; carga las tres columnas de texto de dialogo en 0xC0BF/0xC0BE
	call dibuja_mesa		;497d   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	call 0bfd6h		;4980   ; copia_estilos: copia los estilos de los tres rivales a sus manos
	call borra_manos		;4983   ; borra_manos: borra 4 KB de 0xD000 (las manos)
	call 09374h		;4986   ; borra_temporales: borra 0xC200-0xC3FF
	call 08e68h		;4989   ; posicion_descartes: pone la posicion inicial de los descartes de los cuatro
	xor a			;498c
	ld (0c214h),a		;498d   ; guarda 1 si las manos se ven boca arriba
	inc a			;4990
	ld (0c1c2h),a		;4991   ; guarda el paso del reparto
	call 06605h		;4994   ; borra_cuadros: borra los cuadros del fondo
	ld hl,00104h		;4997
	ld (0c000h),hl		;499a   ; guarda el estado de la maquina de estados del juego (0-8) y el byte siguiente (16 bits)
	ret			;499d
L_499E:
	ld a,(0c000h)		;499e   ; lee el estado de la maquina de estados del juego (0-8)
	cp 003h		;49a1
	ret nc			;49a3
	call L_560C		;49a4   ; teclas y joystick 1 en un byte: bits 0-5 de la palanca y 2 botones (PSG puerto 14, filas 6 y 8 del teclado)
	ld hl,0c011h		;49a7
	call L_5605		;49aa   ; flancos de una tecla: guarda el estado nuevo y deja en la direccion anterior lo recien pulsado
	or a			;49ad
	ret z			;49ae
	ld hl,0c004h		;49af   ; apunta a el temporizador de espera entre pasos
	ld (hl),000h		;49b2
	ld l,(hl)			;49b4
	ld b,(hl)			;49b5
	djnz L_49CC		;49b6
	and 030h		;49b8
	ret z			;49ba
	ld a,040h		;49bb
	ld (0c002h),a		;49bd
	ld (hl),003h		;49c0
	inc hl			;49c2
	ld c,000h		;49c3
	ld (hl),c			;49c5
	call pide_sonido_01		;49c6   ; pide_sonido_01: pide el sonido 0x01 al motor de sonido (p12:6003)
	jp pide_sonido_18		;49c9   ; pide_sonido_18: pide la voz 0x18
L_49CC:
	ld hl,0c000h		;49cc   ; apunta a el estado de la maquina de estados del juego (0-8)
	ld a,(hl)			;49cf
	and a			;49d0
	jr nz,L_49DA		;49d1
	inc hl			;49d3
	ld a,(hl)			;49d4
	cp 003h		;49d5
	call c,pide_sonido_09		;49d7   ; pide_sonido_09: pide el sonido 0x09
L_49DA:
	ld hl,00001h		;49da
	ld (0c000h),hl		;49dd   ; guarda el estado de la maquina de estados del juego (0-8) y el byte siguiente (16 bits)
	call limpia_pantalla		;49e0   ; limpia_pantalla: apaga la pantalla, quita los sprites y borra la VRAM visible
	call pantalla_off		;49e3   ; pantalla_off: apaga la pantalla
	call L_5CB2		;49e6   ; prepara la pantalla del menu (bancos 10-11): lista 0x9502, tabla 0x94B2
	call L_5CD7		;49e9
	call L_5DC7		;49ec
	call L_5DB3		;49ef   ; copia un rectangulo de la pagina 0 a si mismo (borra la franja inferior)
	call L_59C1		;49f2
	call L_5DC1		;49f5   ; dibuja la lista de tiles de 0x59D9 (el texto del titulo)
	jp pantalla_on		;49f8   ; pantalla_on: enciende la pantalla
L_49FB:
	ld hl,0c02ah		;49fb   ; apunta a 1 cuando la pantalla de menu ha acabado
	ld de,0c02bh		;49fe   ; apunta a variable de los pasos de las pantallas de menu
	ld bc,00005h		;4a01
	ld (hl),000h		;4a04
	ldir		;4a06
	ret			;4a08
L_4A09:
	ld hl,0c020h		;4a09   ; apunta a la regla 'comer 断幺' (tanyao con la mano abierta; de serie si)
	ld bc,02fe0h		;4a0c
	ld d,h			;4a0f
	ld e,l			;4a10
	inc e			;4a11
	ld (hl),000h		;4a12
	ldir		;4a14
	ret			;4a16
suma_puntos_actual:		; suma al marcador del jugador 0xC207 el importe C (signo) y DE (BCD)
	ld a,(0c207h)		;4a17   ; suma al marcador del jugador 0xC207 el importe C:DE
suma_puntos:		; suma al marcador del jugador A (3 bytes en 0xC0A0 + 3 x A) el importe C (signo) y DE (BCD)
	ld hl,04aedh		;4a1a   ; suma al marcador del jugador A (0-3) el importe con signo: C = signo, DE = magnitud en BCD; HL = su ficha de 3 bytes (0xC0A0 + 3 x A)
	call palabra_de_tabla		;4a1d   ; HL = el marcador del jugador A (tabla 0x4AED)
L_4A20:
	ld a,d			;4a20
	or e			;4a21
	ret z			;4a22
	ld b,000h		;4a23
	ld a,c			;4a25
	cp (hl)			;4a26
	jp z,L_4AD2		;4a27   ; mismo signo que el marcador: se suman las magnitudes
	jr nc,L_4A45		;4a2a
	inc hl			;4a2c
	ld a,e			;4a2d   ; estan en el otro byte: compara la parte baja del importe con la del marcador
	cp (hl)			;4a2e
	jr z,L_4A34		;4a2f
	jp L_4A66		;4a31   ; distinta: a la resta de uno en uno
L_4A34:
	inc hl			;4a34   ; los marcadores ya son iguales en la parte baja: compara la parte alta
	ld a,d			;4a35
	cp (hl)			;4a36
	jr z,L_4A3D		;4a37
	dec hl			;4a39
	jp L_4A66		;4a3a
L_4A3D:
	ld a,000h		;4a3d   ; los dos son iguales: el marcador queda a cero (tres bytes)
	ld (hl),a			;4a3f
	dec hl			;4a40
	ld (hl),a			;4a41
	dec hl			;4a42
	ld (hl),a			;4a43
	ret			;4a44
L_4A45:
	push hl			;4a45   ; el importe es mayor: mira si el marcador es cero para poner solo el signo
	inc hl			;4a46
	ld a,(hl)			;4a47
	and a			;4a48
	jr nz,L_4A57		;4a49
	inc hl			;4a4b   ; tambien el segundo byte del marcador es cero: queda con el signo uno y se suma
	ld a,(hl)			;4a4c
	and a			;4a4d
	jr nz,L_4A57		;4a4e
	pop hl			;4a50   ; devuelve HL al signo y pone 1 (el marcador cambia de signo)
	ld a,001h		;4a51
	ld (hl),a			;4a53
	jp L_4AD2		;4a54
L_4A57:
	pop hl			;4a57   ; si no, compara la parte baja del importe con la del marcador
	inc hl			;4a58
	ld a,e			;4a59
	cp (hl)			;4a5a
	jr z,L_4A60		;4a5b
	jp L_4A66		;4a5d
L_4A60:
	inc hl			;4a60
	ld a,d			;4a61
	cp (hl)			;4a62
	jr z,L_4A3D		;4a63
	dec hl			;4a65
L_4A66:
	ld a,(hl)			;4a66   ; signo distinto: se resta de uno en uno, DE baja y el marcador sube o baja a la vez
	and 00fh		;4a67
	sub 001h		;4a69
	jr nc,L_4A6F		;4a6b
	adc a,009h		;4a6d
L_4A6F:
	rl b		;4a6f   ; segundo nibble: resta uno a cada nibble del marcador con ajuste decimal
	push af			;4a71   ; guarda el acarreo y toma el nibble alto del byte bajo del marcador
	ld a,(hl)			;4a72
	and 0f0h		;4a73
	rra			;4a75
	rra			;4a76
	rra			;4a77
	rra			;4a78
	rr b		;4a79   ; sigue con el nibble alto: lo resta con el acarreo, ajustando el decimal (suma 9 si se pasa)
	sbc a,000h		;4a7b
	jr nc,L_4A81		;4a7d
	adc a,009h		;4a7f
L_4A81:
	rl b		;4a81   ; junta los dos nibbles y sigue con el byte alto
	rla			;4a83   ; junta los nibbles del byte bajo
	rla			;4a84
	rla			;4a85
	rla			;4a86
	exx			;4a87
	pop bc			;4a88
	or b			;4a89
	exx			;4a8a
	ld (hl),a			;4a8b
	inc hl			;4a8c
	ld a,(hl)			;4a8d   ; pasa al byte alto del marcador
	and 00fh		;4a8e
	rr b		;4a90
	sbc a,000h		;4a92
	jr nc,L_4A98		;4a94
	adc a,009h		;4a96
L_4A98:
	rl b		;4a98   ; repite con el byte alto del marcador
	push af			;4a9a   ; guarda el acarreo del nibble bajo
	ld a,(hl)			;4a9b
	and 0f0h		;4a9c
	rra			;4a9e
	rra			;4a9f
	rra			;4aa0
	rra			;4aa1
	rr b		;4aa2   ; resta el nibble alto con el acarreo y ajusta
	sbc a,000h		;4aa4
	jr nc,L_4AAA		;4aa6
	adc a,009h		;4aa8
L_4AAA:
	rl b		;4aaa   ; junta nibbles y mira si el marcador ha llegado a cero para cambiarle el signo (0x4AE6)
	rla			;4aac   ; junta los nibbles del byte alto
	rla			;4aad
	rla			;4aae
	rla			;4aaf
	exx			;4ab0
	pop bc			;4ab1
	or b			;4ab2
	exx			;4ab3
	ld (hl),a			;4ab4
	dec hl			;4ab5
	ld a,(hl)			;4ab6
	and a			;4ab7   ; si el byte alto queda a cero mira el bajo
	jr nz,L_4ACC		;4ab8
	inc hl			;4aba
	ld a,(hl)			;4abb
	and a			;4abc
	jr nz,L_4ACB		;4abd
	dec hl			;4abf   ; los dos a cero: da la vuelta al signo
	dec hl			;4ac0
	ld a,(hl)			;4ac1
	rra			;4ac2
	ccf			;4ac3
	rla			;4ac4
	ld (hl),a			;4ac5
	inc hl			;4ac6
	inc hl			;4ac7
	jp L_4AE6		;4ac8
L_4ACB:
	dec hl			;4acb
L_4ACC:
	call resta_uno_bcd_de		;4acc   ; no ha acabado: DE - 1 y repite
	jr nz,L_4A66		;4acf
	ret			;4ad1
L_4AD2:
	inc hl			;4ad2   ; mismo signo: suma uno al marcador en BCD con tope 9999
L_4AD3:
	ld a,(hl)			;4ad3   ; suma uno al marcador en BCD (dos bytes) con tope 9999
	add a,001h		;4ad4
	daa			;4ad6
	ld (hl),a			;4ad7
	inc hl			;4ad8
	ld a,(hl)			;4ad9   ; suma el acarreo al byte alto
	adc a,000h		;4ada
	daa			;4adc
	ld (hl),a			;4add
	jr nc,L_4AE6		;4ade   ; si se pasa de 9999 deja 9999
	ld a,099h		;4ae0
	ld (hl),a			;4ae2
	dec hl			;4ae3
	ld (hl),a			;4ae4
	ret			;4ae5
L_4AE6:
	dec hl			;4ae6
	call resta_uno_bcd_de		;4ae7   ; resta_uno_bcd_de: DE = DE - 1 en BCD; Z si acaba en cero
	jr nz,L_4AD3		;4aea
	ret			;4aec

; ----------------------------------------------------------------------
; DATOS resto_4AED: lo apuntan con el banco puesto p00:4A1A (0x4AED); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:4A1A (8 bytes)
;   0x4aed..0x4af5  (8 bytes)
DATA_resto_4AED:
	defb 0a0h,0c0h,0a3h,0c0h,0a6h,0c0h,0a9h,0c0h	; 4aed  ........

; ======================================================================
; CODIGO 0x4af5..0x55e4  (2799 bytes)
; ======================================================================


resta_uno_bcd_de:		; DE = DE - 1 en BCD; Z si acaba en cero
	ld a,e			;4af5   ; DE = DE - 1 en BCD (cada cifra con su decimal); Z si ha llegado a cero
	and 00fh		;4af6
	sub 001h		;4af8
	jr nc,L_4AFE		;4afa
	adc a,009h		;4afc
L_4AFE:
	rl b		;4afe   ; resta uno a cada nibble de E (decimal)
	push af			;4b00
	ld a,e			;4b01
	and 0f0h		;4b02   ; mira la parte baja de DE y el nibble alto
	rra			;4b04
	rra			;4b05
	rra			;4b06
	rra			;4b07
	rr b		;4b08
	sbc a,000h		;4b0a   ; resta con el acarreo y ajusta el decimal
	jr nc,L_4B10		;4b0c
	adc a,009h		;4b0e
L_4B10:
	rl b		;4b10   ; junta los nibbles de E
	rla			;4b12   ; junta los nibbles
	rla			;4b13
	rla			;4b14
	rla			;4b15
	exx			;4b16
	pop bc			;4b17
	or b			;4b18
	exx			;4b19
	ld e,a			;4b1a
	ld a,d			;4b1b
	and 00fh		;4b1c   ; nibble bajo de D
	rr b		;4b1e
	sbc a,000h		;4b20
	jr nc,L_4B26		;4b22
	adc a,009h		;4b24
L_4B26:
	rl b		;4b26   ; y lo mismo con D
	push af			;4b28
	ld a,d			;4b29
	and 0f0h		;4b2a   ; nibble alto de D
	rra			;4b2c
	rra			;4b2d
	rra			;4b2e
	rra			;4b2f
	rr b		;4b30
	sbc a,000h		;4b32
	jr nc,L_4B38		;4b34
	adc a,009h		;4b36
L_4B38:
	rl b		;4b38   ; junta los nibbles de D y deja Z si DE es cero
	rla			;4b3a   ; junta los nibbles de D
	rla			;4b3b
	rla			;4b3c
	rla			;4b3d
	exx			;4b3e
	pop bc			;4b3f
	or b			;4b40
	exx			;4b41
	ld d,a			;4b42
	ld a,d			;4b43   ; deja Z si DE ha llegado a cero
	or e			;4b44
	ret			;4b45
dibuja_marcadores:		; dibuja los cuatro paneles de puntos de los jugadores
	ld hl,05884h		;4b46   ; dibuja el marcador de los cuatro jugadores: un panel por jugador con sus puntos (0xC282/0xC28E y 0xC0A2)
	ld bc,l5028h		;4b49
	ld a,0ffh		;4b4c
	ld d,000h		;4b4e
	call vdp_hmmv_2		;4b50   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,l5480h		;4b53
	ld hl,00b06h		;4b56
	call 09d1ch		;4b59
	ld hl,0c282h		;4b5c
	ld de,06c8bh		;4b5f
	call numero_2_bytes		;4b62   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c28eh		;4b65
	ld de,06c93h		;4b68
	call numero_2_bytes		;4b6b   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0609ch		;4b6e
	ld b,040h		;4b71
	ld c,004h		;4b73
	call vdp_linea		;4b75   ; vdp_linea: LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	ld hl,0c0a2h		;4b78
	ld de,06c9dh		;4b7b
	call numero_2_bytes		;4b7e   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,09c54h		;4b81
	ld bc,l5028h		;4b84
	ld a,0ffh		;4b87
	ld d,000h		;4b89
	call vdp_hmmv_2		;4b8b   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,09850h		;4b8e
	ld hl,00b06h		;4b91
	call 09d1ch		;4b94
	ld hl,0c285h		;4b97
	ld de,0b05bh		;4b9a
	call numero_2_bytes		;4b9d   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c291h		;4ba0
	ld de,0b063h		;4ba3
	call numero_2_bytes		;4ba6   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0a46ch		;4ba9
	ld b,040h		;4bac
	ld c,004h		;4bae
	call vdp_linea		;4bb0   ; vdp_linea: LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	ld hl,0c0a5h		;4bb3
	ld de,0b06dh		;4bb6
	call numero_2_bytes		;4bb9   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,05824h		;4bbc
	ld bc,l5028h		;4bbf
	ld a,0ffh		;4bc2
	ld d,000h		;4bc4
	call vdp_hmmv_2		;4bc6   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,05420h		;4bc9
	ld hl,00b06h		;4bcc
	call 09d1ch		;4bcf
	ld hl,0c288h		;4bd2
	ld de,06c2bh		;4bd5
	call numero_2_bytes		;4bd8   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c294h		;4bdb
	ld de,06c33h		;4bde
	call numero_2_bytes		;4be1   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0603ch		;4be4
	ld b,040h		;4be7
	ld c,004h		;4be9
	call vdp_linea		;4beb   ; vdp_linea: LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	ld hl,0c0a8h		;4bee
	ld de,06c3dh		;4bf1
	call numero_2_bytes		;4bf4   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,01454h		;4bf7
	ld bc,l5028h		;4bfa
	ld a,0ffh		;4bfd
	ld d,000h		;4bff
	call vdp_hmmv_2		;4c01   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,01050h		;4c04
	ld hl,00b06h		;4c07
	call 09d1ch		;4c0a
	ld hl,0c28bh		;4c0d
	ld de,0285bh		;4c10
	call numero_2_bytes		;4c13   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c297h		;4c16
	ld de,02863h		;4c19
	call numero_2_bytes		;4c1c   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,01c6ch		;4c1f
	ld b,040h		;4c22
	ld c,004h		;4c24
	call vdp_linea		;4c26   ; vdp_linea: LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	ld hl,0c0abh		;4c29
	ld de,0286dh		;4c2c
	call numero_2_bytes		;4c2f   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ret			;4c32
L_4C33:
	ld hl,0c0a2h		;4c33
	ld de,06c94h		;4c36
	call numero_2_bytes		;4c39   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c0a5h		;4c3c
	ld de,0b064h		;4c3f
	call numero_2_bytes		;4c42   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c0a8h		;4c45
	ld de,06c34h		;4c48
	call numero_2_bytes		;4c4b   ; numero_2_bytes: escribe el numero BCD de 2 bytes de HL en DE
	ld hl,0c0abh		;4c4e
	ld de,02864h		;4c51
numero_2_bytes:		; escribe el numero BCD de 2 bytes de HL en DE
	ld b,002h		;4c54   ; escribe en pantalla el numero de 2 bytes BCD de HL (signo en HL-2) en DE
	jp L_4C90		;4c56
numero_con_signo:		; escribe el numero BCD de HL en DE con '-' si es negativo
	push hl			;4c59   ; escribe un numero BCD de 2 bytes en DE, con '-' si es negativo
	dec hl			;4c5a
	dec hl			;4c5b
	ld a,(hl)			;4c5c
	and a			;4c5d
	jr z,L_4C70		;4c5e
	push de			;4c60
	ld a,d			;4c61
	sub 008h		;4c62
	ld d,a			;4c64
	ld a,040h		;4c65
	call dibuja_tile		;4c67   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;4c6a
	ld a,041h		;4c6b
	jp L_4C72		;4c6d
L_4C70:
	ld a,001h		;4c70
L_4C72:
	pop hl			;4c72
	ld (0c218h),a		;4c73
	ld c,000h		;4c76
	ld a,(hl)			;4c78
	rra			;4c79
	rra			;4c7a
	rra			;4c7b
	rra			;4c7c
	call L_4CF2		;4c7d   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	ld a,(hl)			;4c80
	call L_4CF2		;4c81   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	dec hl			;4c84
	ld c,0ffh		;4c85
	ld a,(hl)			;4c87
	rra			;4c88
	rra			;4c89
	rra			;4c8a
	rra			;4c8b
	call L_4CF2		;4c8c   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	ret			;4c8f
L_4C90:
	push hl			;4c90   ; numero BCD de B bytes: si el signo es distinto de cero dibuja el tile 0x40 (el menos) a la izquierda
	dec hl			;4c91
	dec hl			;4c92
	ld a,(hl)			;4c93
	and a			;4c94
	jr z,L_4CA7		;4c95
	push de			;4c97
	ld a,d			;4c98
	sub 008h		;4c99
	ld d,a			;4c9b
	ld a,040h		;4c9c
	call dibuja_tile		;4c9e   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	pop de			;4ca1
	ld a,041h		;4ca2
	jp L_4CA9		;4ca4
L_4CA7:
	ld a,001h		;4ca7
L_4CA9:
	pop hl			;4ca9
	ld (0c218h),a		;4caa
	ld c,000h		;4cad
L_4CAF:
	ld a,(hl)			;4caf
	rra			;4cb0
	rra			;4cb1
	rra			;4cb2
	rra			;4cb3
	call L_4CF2		;4cb4   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	ld a,(hl)			;4cb7
	call L_4CF2		;4cb8   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	dec hl			;4cbb
	djnz L_4CAF		;4cbc
	ld c,0ffh		;4cbe
	xor a			;4cc0
	call L_4CF2		;4cc1   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	xor a			;4cc4
	call L_4CF2		;4cc5   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	ret			;4cc8
numero_sin_ceros:		; escribe B bytes BCD de HL en DE sin ceros por la izquierda
	ld c,000h		;4cc9
L_4CCB:
	dec b			;4ccb
	jr nz,L_4CD0		;4ccc
	ld c,0ffh		;4cce
L_4CD0:
	inc b			;4cd0   ; dibuja las dos cifras de un byte BCD con 0x4CE1
	ld a,(hl)			;4cd1   ; primer nibble del byte BCD
	rra			;4cd2
	rra			;4cd3
	rra			;4cd4
	rra			;4cd5
	call L_4CE1		;4cd6
	ld a,(hl)			;4cd9   ; segundo nibble
	call L_4CE1		;4cda
	dec hl			;4cdd
	djnz L_4CCB		;4cde
	ret			;4ce0
L_4CE1:
	and 00fh		;4ce1
	jr z,L_4CE7		;4ce3
	ld c,0ffh		;4ce5
L_4CE7:
	add a,001h		;4ce7
	and c			;4ce9
	call dibuja_tile		;4cea   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,d			;4ced
	add a,008h		;4cee
	ld d,a			;4cf0
	ret			;4cf1
L_4CF2:
	push hl			;4cf2   ; dibuja una cifra (A & 0x0F) en D,E como tile y avanza 8 puntos; ceros por la izquierda, en blanco mientras C = 0
	ld hl,0c218h		;4cf3
	and 00fh		;4cf6
	jr z,L_4CFC		;4cf8
	ld c,0ffh		;4cfa
L_4CFC:
	add a,(hl)			;4cfc
	and c			;4cfd
	call dibuja_tile		;4cfe   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,d			;4d01
	add a,008h		;4d02
	ld d,a			;4d04
	pop hl			;4d05
	ret			;4d06
palabra_de_tabla:		; HL = la palabra numero A de la tabla que apunta HL
	add a,a			;4d07   ; HL = la palabra numero A de la tabla que apunta HL
	add a,l			;4d08
	ld l,a			;4d09
	jr nc,L_4D0D		;4d0a
	inc h			;4d0c
L_4D0D:
	ld a,(hl)			;4d0d
	inc hl			;4d0e
	ld h,(hl)			;4d0f
	ld l,a			;4d10
	ret			;4d11
lee_vram:		; lee BC bytes de la VRAM (desde HL) a DE
	call direccion_lectura_vram_x2		;4d12   ; lee BC bytes de la VRAM (desde HL) a DE
	call L_4D25		;4d15   ; cambia HL y DE y pone en A y B la cuenta de la lectura de bloque (BC)
	ex af,af'			;4d18
	ld a,(00006h)		;4d19
	ld c,a			;4d1c
	ex af,af'			;4d1d
L_4D1E:
	inir		;4d1e
	dec a			;4d20
	jr nz,L_4D1E		;4d21
	ex de,hl			;4d23
	ret			;4d24
L_4D25:
	ex de,hl			;4d25   ; cambia HL y DE y pone en A y B la cuenta de la lectura de bloque (BC)
	ld a,c			;4d26
	or a			;4d27
	ld a,b			;4d28
	ld b,c			;4d29
	ret z			;4d2a
	inc a			;4d2b
	ret			;4d2c
copia_a_vram_hl:		; copia BC bytes de HL a la VRAM en DE
	ex de,hl			;4d2d   ; copia BC bytes de la RAM (HL) a la VRAM (DE)
	call L_4D89		;4d2e   ; direccion de escritura de la VRAM = HL x 2: R14 = bits 14-16, y despues los dos bytes de direccion con el bit 6 puesto
	call L_4D25		;4d31   ; cambia HL y DE y pone en A y B la cuenta de la lectura de bloque (BC)
	ex af,af'			;4d34
	ld a,(00007h)		;4d35
	ld c,a			;4d38
	ex af,af'			;4d39
L_4D3A:
	otir		;4d3a
	dec a			;4d3c
	jr nz,L_4D3A		;4d3d
	ret			;4d3f
copia_a_vram:		; copia BC bytes de la RAM (DE) a la VRAM en HL
	ex de,hl			;4d40   ; copia BC bytes de la RAM (DE) a la VRAM (HL, el acarreo es el bit 16)
	push de			;4d41
	or a			;4d42
	call direccion_escritura_vram		;4d43   ; direccion_escritura_vram: direccion de escritura de la VRAM = HL (el acarreo es el bit 16)
	pop de			;4d46
	call L_4D25		;4d47   ; cambia HL y DE y pone en A y B la cuenta de la lectura de bloque (BC)
	ex af,af'			;4d4a
	ld a,(00007h)		;4d4b
	ld c,a			;4d4e
	ex af,af'			;4d4f
L_4D50:
	otir		;4d50
	dec a			;4d52
	jr nz,L_4D50		;4d53
	ret			;4d55
rellena_vram:		; rellena BC bytes de la VRAM con A desde HL
	push de			;4d56   ; rellena BC bytes de la VRAM con A, desde HL
	push af			;4d57
	call L_4D89		;4d58   ; direccion de escritura de la VRAM = HL x 2: R14 = bits 14-16, y despues los dos bytes de direccion con el bit 6 puesto
	ld d,c			;4d5b
	ld a,c			;4d5c
	or a			;4d5d
	jr z,L_4D61		;4d5e
	inc b			;4d60
L_4D61:
	ld a,(00007h)		;4d61
	ld c,a			;4d64
	pop af			;4d65
L_4D66:
	out (c),a		;4d66   ; escribe B x C bytes iguales al puerto de la VRAM
	dec d			;4d68
	jr nz,L_4D66		;4d69
	djnz L_4D66		;4d6b
	pop de			;4d6d
	ret			;4d6e
L_4D6F:
	push bc			;4d6f   ; lee un byte de la VRAM en HL
	call direccion_lectura_vram_x2		;4d70   ; direccion_lectura_vram_x2: direccion de lectura de la VRAM = HL x 2
	ld a,(00006h)		;4d73
	ld c,a			;4d76
	in a,(c)		;4d77
	pop bc			;4d79
	ret			;4d7a
L_4D7B:
	push bc			;4d7b   ; escribe A en la VRAM en HL
	push af			;4d7c
	call L_4D89		;4d7d   ; direccion de escritura de la VRAM = HL x 2: R14 = bits 14-16, y despues los dos bytes de direccion con el bit 6 puesto
	ld a,(00007h)		;4d80
	ld c,a			;4d83
	pop af			;4d84
	out (c),a		;4d85
	pop bc			;4d87
	ret			;4d88
L_4D89:
	push bc			;4d89   ; direccion de escritura de la VRAM = HL x 2: R14 = bits 14-16, y despues los dos bytes de direccion con el bit 6 puesto
	ld a,(00007h)		;4d8a   ; lee el puerto de datos del VDP (0x0007) y lo pone en C como puerto de control (+1)
	inc a			;4d8d
	ld c,a			;4d8e
	ld a,h			;4d8f
	rlca			;4d90
	rlca			;4d91
	rlca			;4d92
	and 007h		;4d93   ; R#14 = bits 14-16 de la direccion
	di			;4d95
	out (c),a		;4d96
	ld a,08eh		;4d98
	out (c),a		;4d9a
	ld a,l			;4d9c   ; direccion baja multiplicada por dos
	sla a		;4d9d
	out (c),a		;4d9f
	ld a,h			;4da1   ; direccion alta por dos con el bit 6 (escritura)
	rl a		;4da2
	and 03fh		;4da4
	or 040h		;4da6
	out (c),a		;4da8
	pop bc			;4daa
	ei			;4dab
	ret			;4dac
direccion_lectura_vram_x2:		; direccion de lectura de la VRAM = HL x 2
	push bc			;4dad   ; igual pero para leer (sin el bit 6)
	ld a,(00007h)		;4dae   ; puerto de datos del VDP en C
	inc a			;4db1
	ld c,a			;4db2
	ld a,h			;4db3
	rlca			;4db4
	rlca			;4db5
	rlca			;4db6
	and 007h		;4db7
	di			;4db9   ; sin interrupciones mientras se escribe la direccion
	out (c),a		;4dba
	ld a,08eh		;4dbc   ; R#14 recibe los tres bits altos de la direccion
	out (c),a		;4dbe
	ld a,l			;4dc0
	sla a		;4dc1   ; byte bajo por dos para la direccion de la VRAM
	out (c),a		;4dc3
	ld a,h			;4dc5
	rl a		;4dc6
	and 03fh		;4dc8
	out (c),a		;4dca
	pop bc			;4dcc
	ei			;4dcd
	ret			;4dce
L_4DCF:
	push bc			;4dcf   ; lee un byte de la VRAM: direccion de lectura (0x4E09) y lo lee del puerto de datos
	call L_4E09		;4dd0
	ld a,(00006h)		;4dd3   ; puerto de datos
	ld c,a			;4dd6
	in a,(c)		;4dd7
	pop bc			;4dd9
	ret			;4dda
L_4DDB:
	push bc			;4ddb
	push af			;4ddc
	call direccion_escritura_vram		;4ddd   ; direccion_escritura_vram: direccion de escritura de la VRAM = HL (el acarreo es el bit 16)
	ld a,(00007h)		;4de0
	ld c,a			;4de3
	pop af			;4de4
	out (c),a		;4de5
	pop bc			;4de7
	ret			;4de8
direccion_escritura_vram:		; direccion de escritura de la VRAM = HL (el acarreo es el bit 16)
	push bc			;4de9   ; direccion de escritura de la VRAM: R14 por los tres bits altos de H (el acarreo es el 16) y despues L y H con el bit 6
	ld a,(00007h)		;4dea   ; puerto de control del VDP en C
	inc a			;4ded
	ld c,a			;4dee
	ld a,h			;4def   ; R#14 con los tres bits altos de H
	rla			;4df0
	rla			;4df1
	rla			;4df2
	and 007h		;4df3
	di			;4df5
	out (c),a		;4df6
	ld a,08eh		;4df8
	out (c),a		;4dfa
	ld a,l			;4dfc   ; direccion baja a la VRAM
	out (c),a		;4dfd
	ld a,h			;4dff   ; direccion alta con el bit 6 puesto (escribir)
	and 03fh		;4e00
	or 040h		;4e02
	out (c),a		;4e04
	pop bc			;4e06
	ei			;4e07
	ret			;4e08
L_4E09:
	push bc			;4e09   ; igual para leer
	ld a,(00007h)		;4e0a   ; puerto de control en C
	inc a			;4e0d
	ld c,a			;4e0e
	ld a,h			;4e0f   ; R#14 con los tres bits altos de H
	rla			;4e10
	rla			;4e11
	rla			;4e12
	and 007h		;4e13
	di			;4e15
	out (c),a		;4e16
	ld a,08eh		;4e18
	out (c),a		;4e1a
	ld a,l			;4e1c   ; direccion baja
	out (c),a		;4e1d
	ld a,h			;4e1f   ; direccion alta sin el bit 6 (leer)
	and 03fh		;4e20
	out (c),a		;4e22
	pop bc			;4e24
	ei			;4e25
	ret			;4e26
vuelca_lista_vram:		; vuelca a la VRAM una lista de bloques (direccion, n, datos; 0 acaba)
	ex de,hl			;4e27   ; vuelca a la VRAM una lista: direccion, y despues bloques (n con bit 7 = seguido; 0 acaba, otra direccion si n = 0x80)
	ld e,(hl)			;4e28
	inc hl			;4e29
	ld d,(hl)			;4e2a
	inc hl			;4e2b
	ex de,hl			;4e2c
L_4E2D:
	call direccion_escritura_vram		;4e2d   ; direccion_escritura_vram: direccion de escritura de la VRAM = HL (el acarreo es el bit 16)
	ld a,(00007h)		;4e30
	ld c,a			;4e33
L_4E34:
	ld a,(de)			;4e34   ; siguiente bloque de la lista: 0 acaba, el bit 7 dice si se repite un byte o se copian varios
	and a			;4e35   ; un byte 0 acaba la lista
	ret z			;4e36
	inc de			;4e37
	ld b,a			;4e38
	and 07fh		;4e39   ; los 7 bits bajos son la cuenta
	cp b			;4e3b
	jr z,L_4E48		;4e3c
	and a			;4e3e   ; 0x80 solo = otra direccion
	jr z,vuelca_lista_vram		;4e3f
	ex de,hl			;4e41   ; copia la cuenta de bytes con otir
	ld b,a			;4e42
	otir		;4e43
	ex de,hl			;4e45
	jr L_4E34		;4e46
L_4E48:
	ld a,(de)			;4e48
	inc de			;4e49
L_4E4A:
	out (c),a		;4e4a
	djnz L_4E4A		;4e4c
	jr L_4E34		;4e4e
limpia_pantalla:		; apaga la pantalla, quita los sprites y borra la VRAM visible
	call quita_sprites		;4e50   ; apaga la pantalla, limpia la tabla de sprites y borra la VRAM visible
	call pantalla_off		;4e53   ; pantalla_off: apaga la pantalla
	ld hl,00000h		;4e56
	ld bc,000d8h		;4e59
	xor a			;4e5c
	ld d,000h		;4e5d
	call vdp_hmmv_2		;4e5f   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld b,000h		;4e62
	ld c,017h		;4e64
	call 00047h		;4e66   ; BIOS WRTVDP - Writes data in the VDP-register
pantalla_on:		; enciende la pantalla
	ld a,(0f3e0h)		;4e69   ; enciende la pantalla (bit 6 del registro 1)
	or 040h		;4e6c
	ld b,a			;4e6e
	ld c,001h		;4e6f
	call 00047h		;4e71   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_4EA7		;4e74
pantalla_off:		; apaga la pantalla
	ld a,(0f3e0h)		;4e76   ; apaga la pantalla (bit 6 del registro 1 a 0)
	and 0bfh		;4e79
	ld b,a			;4e7b
	ld c,001h		;4e7c
	call 00047h		;4e7e   ; BIOS WRTVDP - Writes data in the VDP-register
	jr L_4E9C		;4e81
quita_sprites:		; pone todos los sprites fuera de pantalla
	ld hl,0cc00h		;4e83   ; pone todos los sprites fuera de pantalla (Y = 0xE0) y copia la tabla a la VRAM
	ld de,0cc01h		;4e86
	ld bc,0007fh		;4e89
	ld (hl),0e0h		;4e8c
	ldir		;4e8e
	ld de,0f600h		;4e90
	ld hl,0cc00h		;4e93   ; apunta a la tabla de atributos de los sprites (32 de 4 bytes)
	ld bc,00080h		;4e96
	jp copia_a_vram		;4e99   ; copia_a_vram: copia BC bytes de la RAM (DE) a la VRAM en HL
L_4E9C:
	ld a,(0ffe7h)		;4e9c
	or 002h		;4e9f
	ld b,a			;4ea1
	ld c,008h		;4ea2
	jp 00047h		;4ea4   ; BIOS WRTVDP - Writes data in the VDP-register
L_4EA7:
	ld a,(0ffe7h)		;4ea7
	and 0fdh		;4eaa
	ld b,a			;4eac
	ld c,008h		;4ead
	jp 00047h		;4eaf   ; BIOS WRTVDP - Writes data in the VDP-register
pon_color:		; escribe el color D,E en la paleta A
	push bc			;4eb2   ; pone el color D,E en la paleta A: registro 16 del VDP y los dos bytes, y los guarda en la copia en 0xF680
	push hl			;4eb3
	ld b,a			;4eb4
	ld a,(00007h)		;4eb5   ; puerto del VDP en C
	inc a			;4eb8
	ld c,a			;4eb9
	di			;4eba
	out (c),b		;4ebb   ; escribe el numero de paleta en el registro de paleta (R#16)
	ld a,090h		;4ebd
	out (c),a		;4ebf
	inc c			;4ec1
	out (c),d		;4ec2   ; dos bytes de color (rojo y azul, verde) por el puerto de paleta
	push af			;4ec4
	pop af			;4ec5
	out (c),e		;4ec6
	dec c			;4ec8
	ld hl,0f680h		;4ec9   ; guarda la copia del color en 0xF680 + numero
	ld a,b			;4ecc
	add a,l			;4ecd
	ld l,a			;4ece
	call direccion_escritura_vram		;4ecf   ; direccion_escritura_vram: direccion de escritura de la VRAM = HL (el acarreo es el bit 16)
	dec c			;4ed2
	out (c),d		;4ed3
	nop			;4ed5
	out (c),e		;4ed6
	pop hl			;4ed8
	pop bc			;4ed9
	ei			;4eda
	ret			;4edb
pon_colores:		; aplica una lista de colores (A, D, E; 0xFF acaba)
	ld a,(hl)			;4edc   ; aplica una lista de colores de paleta (A, D, E; 0xFF acaba)
	inc hl			;4edd
	inc a			;4ede
	ret z			;4edf
	dec a			;4ee0
	ld d,(hl)			;4ee1
	inc hl			;4ee2
	ld e,(hl)			;4ee3
	inc hl			;4ee4
	call pon_color		;4ee5   ; pon_color: escribe el color D,E en la paleta A
	jr pon_colores		;4ee8
espera_vdp:		; espera a que el VDP acabe la orden en marcha
	ld a,002h		;4eea   ; espera a que el VDP acabe su comando (estado S#2, bit 0)
	call L_4EF4		;4eec
	rra			;4eef
	jp c,espera_vdp		;4ef0   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	ret			;4ef3
L_4EF4:
	di			;4ef4
	call L_4EFA		;4ef5   ; lee el registro de estado A del VDP: lo selecciona en R15, lo lee y vuelve a dejar R15 = 0
	ei			;4ef8
	ret			;4ef9
L_4EFA:
	push bc			;4efa   ; lee el registro de estado A del VDP: lo selecciona en R15, lo lee y vuelve a dejar R15 = 0
	push hl			;4efb
	ld hl,(00006h)		;4efc   ; lee los puertos del VDP de 0x0006 y 0x0007
	inc h			;4eff
	inc l			;4f00
	ld c,h			;4f01   ; escribe el numero de registro de estado en R#15
	out (c),a		;4f02
	ld a,08fh		;4f04
	out (c),a		;4f06
	ld c,l			;4f08   ; lee el estado
	in a,(c)		;4f09
	push af			;4f0b
	xor a			;4f0c   ; y deja R#15 a cero
	ld c,h			;4f0d
	out (c),a		;4f0e
	ld a,08fh		;4f10
	out (c),a		;4f12
	pop af			;4f14
	pop hl			;4f15
	pop bc			;4f16
	ret			;4f17
vdp_linea:		; LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	ld d,a			;4f18   ; LINE: traza una linea: prepara los registros 36-42 (origen X con su bit 8, Y, largo, grosor) y lanza la orden 0x70
	call espera_vdp		;4f19   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	push bc			;4f1c
	ld a,(00007h)		;4f1d
	inc a			;4f20
	ld c,a			;4f21
	ld a,024h		;4f22
	di			;4f24
	out (c),a		;4f25   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;4f27
	out (c),a		;4f29   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;4f2b
	inc c			;4f2c
	ld a,d			;4f2d
	rla			;4f2e
	rl h		;4f2f
	ld a,000h		;4f31
	rla			;4f33
	out (c),h		;4f34   ; al VDP: R#36, DX bajo
	out (c),a		;4f36   ; al VDP: R#37, DX alto
	xor a			;4f38
	out (c),l		;4f39   ; al VDP: R#38, DY bajo
	out (c),a		;4f3b   ; al VDP: R#39, DY alto
	pop hl			;4f3d
	ld a,h			;4f3e
	and a			;4f3f
	jr nz,L_4F4A		;4f40   ; destino: la pagina baja o alta segun el bit 7 del color
	ld a,d			;4f42
	rla			;4f43
	jr c,L_4F4A		;4f44
	ld a,002h		;4f46
	jr L_4F51		;4f48
L_4F4A:
	ld a,d			;4f4a
	rla			;4f4b
	rl h		;4f4c
	ld a,000h		;4f4e
	rla			;4f50
L_4F51:
	out (c),h		;4f51   ; al VDP: R#40, NX bajo
	out (c),a		;4f53   ; al VDP: R#41, NX alto
	xor a			;4f55
	out (c),a		;4f56   ; al VDP: R#42, NY bajo
	out (c),a		;4f58   ; al VDP: R#43, NY alto
	out (c),l		;4f5a   ; al VDP: R#44, CLR (color o dato)
	out (c),a		;4f5c   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,070h		;4f5e
	out (c),a		;4f60   ; al VDP: R#46, CMD (la orden)
	ei			;4f62
	ret			;4f63
L_4F64:
	ld d,a			;4f64   ; LINE en vertical: igual que 0x4F18 con los ejes cambiados
	call espera_vdp		;4f65   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	push bc			;4f68
	ld a,(00007h)		;4f69
	inc a			;4f6c
	ld c,a			;4f6d
	ld a,024h		;4f6e
	di			;4f70
	out (c),a		;4f71   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;4f73
	out (c),a		;4f75   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;4f77
	inc c			;4f78
	xor a			;4f79
	rl d		;4f7a
	rl h		;4f7c
	rla			;4f7e
	out (c),h		;4f7f   ; al VDP: R#36, DX bajo
	out (c),a		;4f81   ; al VDP: R#37, DX alto
	xor a			;4f83
	out (c),l		;4f84   ; al VDP: R#38, DY bajo
	out (c),a		;4f86   ; al VDP: R#39, DY alto
	pop hl			;4f88
	out (c),h		;4f89   ; al VDP: R#40, NX bajo
	xor a			;4f8b
	cp h			;4f8c
	jr nz,L_4F90		;4f8d
	inc a			;4f8f
L_4F90:
	out (c),a		;4f90   ; al VDP: R#41, NX alto
	xor a			;4f92
	out (c),a		;4f93   ; al VDP: R#42, NY bajo
	out (c),a		;4f95   ; al VDP: R#43, NY alto
	out (c),l		;4f97   ; al VDP: R#44, CLR (color o dato)
	inc a			;4f99
	out (c),a		;4f9a   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,070h		;4f9c
	out (c),a		;4f9e   ; al VDP: R#46, CMD (la orden)
	ei			;4fa0
	ret			;4fa1
L_4FA2:
	ld b,e			;4fa2   ; contorno: la linea de arriba, de ancho E
	dec b			;4fa3
	call L_4FCD		;4fa4   ; guarda los registros y traza una linea vertical (0x4F64)
	ld b,d			;4fa7   ; la de abajo
	call L_4FD9		;4fa8
	push af			;4fab
	push hl			;4fac
	push af			;4fad
	ld a,l			;4fae
	dec a			;4faf
	add a,e			;4fb0
	ld l,a			;4fb1
	ld b,d			;4fb2
	pop af			;4fb3
	call L_4FD9		;4fb4
	pop hl			;4fb7
	pop af			;4fb8   ; las de los lados con alto D
	push de			;4fb9
	ld b,a			;4fba
	and 080h		;4fbb
	ld e,a			;4fbd
	ld a,b			;4fbe
	rla			;4fbf
	and 080h		;4fc0
	add a,e			;4fc2
	push af			;4fc3
	ld a,h			;4fc4
	adc a,d			;4fc5
	ld h,a			;4fc6
	pop af			;4fc7
	pop de			;4fc8
	ld b,e			;4fc9   ; desplaza el origen de la derecha
	jp L_4FCD		;4fca
L_4FCD:
	push af			;4fcd   ; guarda los registros y traza una linea vertical (0x4F64)
	push hl			;4fce
	push de			;4fcf
	push bc			;4fd0
	call L_4F64		;4fd1   ; LINE en vertical: igual que 0x4F18 con los ejes cambiados
	pop bc			;4fd4
	pop de			;4fd5
	pop hl			;4fd6
	pop af			;4fd7
	ret			;4fd8
L_4FD9:
	push af			;4fd9
	push hl			;4fda
	push de			;4fdb
	push bc			;4fdc
	call vdp_linea		;4fdd   ; vdp_linea: LINE: traza una linea (HL = origen, B = largo, C = grosor, A = color)
	pop bc			;4fe0
	pop de			;4fe1
	pop hl			;4fe2
	pop af			;4fe3
	ret			;4fe4
vdp_hmmv_2:		; HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ex af,af'			;4fe5   ; HMMV: rellena un rectangulo con el color A': espera al VDP, escribe destino y tamano (registros 36-43) y la orden 0xC0
	call espera_vdp		;4fe6   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	push bc			;4fe9
	ld a,(00007h)		;4fea
	inc a			;4fed
	ld c,a			;4fee
	ld a,024h		;4fef
	di			;4ff1
	out (c),a		;4ff2   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;4ff4   ; empieza a escribir desde el registro 36
	out (c),a		;4ff6   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;4ff8
	inc c			;4ff9
	xor a			;4ffa
	sla h		;4ffb
	rla			;4ffd
	out (c),h		;4ffe   ; al VDP: R#36, DX bajo
	out (c),a		;5000   ; al VDP: R#37, DX alto
	out (c),l		;5002   ; al VDP: R#38, DY bajo
	out (c),d		;5004   ; al VDP: R#39, DY alto
	pop hl			;5006
	xor a			;5007
	sla h		;5008
	rla			;500a
	out (c),h		;500b   ; al VDP: R#40, NX bajo
	out (c),a		;500d   ; al VDP: R#41, NX alto
	xor a			;500f
	out (c),l		;5010   ; al VDP: R#42, NY bajo
	cp l			;5012
	jr nz,L_5016		;5013
	inc a			;5015
L_5016:
	out (c),a		;5016   ; al VDP: R#43, NY alto
	ex af,af'			;5018
	out (c),a		;5019   ; al VDP: R#44, CLR (color o dato)
	xor a			;501b
	out (c),a		;501c   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,0c0h		;501e
	out (c),a		;5020   ; al VDP: R#46, CMD (la orden)
	ei			;5022
	ret			;5023
vdp_copia:		; HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ex af,af'			;5024   ; HMMM: copia un rectangulo de la VRAM a otro sitio
	call espera_vdp		;5025   ; espera_vdp: espera a que el VDP acabe la orden en marcha
L_5028:
	push bc			;5028   ; HMMM: copia un rectangulo; escribe origen (reg 32), destino (reg 36), tamano (reg 40), los bits de pagina de A y la orden 0xD0
	ld a,(00007h)		;5029
	inc a			;502c
	ld c,a			;502d
	ld a,020h		;502e
	di			;5030
	out (c),a		;5031   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;5033
	out (c),a		;5035   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;5037
	inc c			;5038
	xor a			;5039
	sla h		;503a
	rla			;503c
	out (c),h		;503d   ; al VDP: R#32, SX bajo
	out (c),a		;503f   ; al VDP: R#33, SX alto
	out (c),l		;5041   ; al VDP: R#34, SY bajo
	ex af,af'			;5043
	ld b,a			;5044
	and 001h		;5045
	out (c),a		;5047   ; al VDP: R#35, SY alto
	xor a			;5049
	sla d		;504a
	rla			;504c
	out (c),d		;504d   ; al VDP: R#36, DX bajo
	out (c),a		;504f   ; al VDP: R#37, DX alto
	out (c),e		;5051   ; al VDP: R#38, DY bajo
	ld a,b			;5053
	rra			;5054
	and 001h		;5055
	out (c),a		;5057   ; al VDP: R#39, DY alto
	pop hl			;5059
	xor a			;505a
	sla h		;505b
	rla			;505d
	out (c),h		;505e   ; al VDP: R#40, NX bajo
	out (c),a		;5060   ; al VDP: R#41, NX alto
	out (c),l		;5062   ; al VDP: R#42, NY bajo
	xor a			;5064
	out (c),a		;5065   ; al VDP: R#43, NY alto
	out (c),a		;5067   ; al VDP: R#44, CLR (color o dato)
	ld a,b			;5069
	and 03ch		;506a
	out (c),a		;506c   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,0d0h		;506e
	out (c),a		;5070   ; al VDP: R#46, CMD (la orden)
	ei			;5072
	ret			;5073
vdp_lmmc:		; LMMC: manda al VDP un rectangulo con puntos de HL
	ex af,af'			;5074   ; LMMC: manda al VDP un rectangulo punto a punto con la operacion de B y los datos de (HL): orden 0xB0
	call espera_vdp		;5075   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	push bc			;5078
	ld a,(00007h)		;5079
	inc a			;507c
	ld c,a			;507d
	ld a,024h		;507e
	di			;5080
	out (c),a		;5081   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;5083
	out (c),a		;5085   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;5087
	inc c			;5088
	ex af,af'			;5089
	ld b,a			;508a
	rla			;508b
	rl d		;508c
	ld a,000h		;508e
	rla			;5090
	out (c),d		;5091   ; al VDP: R#36, DX bajo
	out (c),a		;5093   ; al VDP: R#37, DX alto
	out (c),e		;5095   ; al VDP: R#38, DY bajo
	ld a,b			;5097
	rra			;5098
	rra			;5099
	rra			;509a
	rra			;509b
	and 001h		;509c
	out (c),a		;509e   ; al VDP: R#39, DY alto
	pop de			;50a0
	ld a,b			;50a1
	rla			;50a2
	rl d		;50a3
	ld a,000h		;50a5
	rla			;50a7
	out (c),d		;50a8   ; al VDP: R#40, NX bajo
	xor a			;50aa
	out (c),a		;50ab   ; al VDP: R#41, NX alto
	xor a			;50ad
	out (c),e		;50ae   ; al VDP: R#42, NY bajo
	cp e			;50b0
	jr nz,L_50B4		;50b1
	inc a			;50b3
L_50B4:
	out (c),a		;50b4   ; al VDP: R#43, NY alto
	ld a,(hl)			;50b6
	inc hl			;50b7
	out (c),a		;50b8   ; al VDP: R#44, CLR (color o dato)
	xor a			;50ba
	out (c),a		;50bb   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,b			;50bd
	and 00fh		;50be
	or 0b0h		;50c0
	out (c),a		;50c2   ; al VDP: R#46, CMD (la orden)
	dec c			;50c4
	dec c			;50c5
	ld a,0ach		;50c6
	out (c),a		;50c8   ; al puerto de control: otro dato de control
	ld a,091h		;50ca
	out (c),a		;50cc   ; al puerto de control: otro dato de control
	inc c			;50ce
	inc c			;50cf
L_50D0:
	ld a,002h		;50d0   ; mientras el VDP pida datos (estado S#2, bit 7), manda el siguiente byte de (HL) al registro 44
	call L_4EF4		;50d2
	rra			;50d5
	ret nc			;50d6
	add a,a			;50d7
	add a,a			;50d8
	jr nc,L_50D0		;50d9
	ld a,(hl)			;50db
	inc hl			;50dc
	out (c),a		;50dd   ; al VDP: R#47, R#47
	jr L_50D0		;50df
vdp_lmcm:		; LMCM: lee un rectangulo de la VRAM a DE
	ex af,af'			;50e1   ; LMCM: lee un rectangulo de la VRAM: orden 0xA0; deja en (DE) los puntos que da el VDP
	call espera_vdp		;50e2   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	ld a,007h		;50e5
	call L_4EF4		;50e7
	push de			;50ea
	push bc			;50eb
	ld a,(00007h)		;50ec
	inc a			;50ef
	ld c,a			;50f0
	ld a,020h		;50f1
	di			;50f3
	out (c),a		;50f4   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;50f6
	out (c),a		;50f8   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;50fa
	inc c			;50fb
	ex af,af'			;50fc
	ld b,a			;50fd
	rla			;50fe
	rl h		;50ff
	ld a,000h		;5101
	rla			;5103
	out (c),h		;5104   ; al VDP: R#32, SX bajo
	out (c),a		;5106   ; al VDP: R#33, SX alto
	out (c),l		;5108   ; al VDP: R#34, SY bajo
	ld a,b			;510a
	rra			;510b
	rra			;510c
	rra			;510d
	rra			;510e
	and 001h		;510f
	out (c),a		;5111   ; al VDP: R#35, SY alto
	out (c),a		;5113   ; al VDP: R#36, DX bajo
	out (c),a		;5115   ; al VDP: R#37, DX alto
	out (c),a		;5117   ; al VDP: R#38, DY bajo
	out (c),a		;5119   ; al VDP: R#39, DY alto
	pop de			;511b
	ld a,b			;511c
	rla			;511d
	rl d		;511e
	ld a,000h		;5120
	rla			;5122
	out (c),d		;5123   ; al VDP: R#40, NX bajo
	out (c),a		;5125   ; al VDP: R#41, NX alto
	xor a			;5127
	out (c),e		;5128   ; al VDP: R#42, NY bajo
	cp e			;512a
	jr nz,L_512E		;512b
	inc a			;512d
L_512E:
	out (c),a		;512e   ; al VDP: R#43, NY alto
	xor a			;5130
	out (c),a		;5131   ; al VDP: R#44, CLR (color o dato)
	out (c),a		;5133   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,b			;5135
	and 00fh		;5136
	or 0a0h		;5138
	out (c),a		;513a   ; al VDP: R#46, CMD (la orden)
	pop de			;513c
L_513D:
	ld a,002h		;513d   ; lee un byte del VDP mientras haya (estado S#2 bit 7) y lo guarda en DE
	call L_4EF4		;513f
	rra			;5142
	ret nc			;5143   ; si no hay mas, vuelve
	add a,a			;5144
	add a,a			;5145
	jr nc,L_513D		;5146
	ld a,007h		;5148   ; lee el dato del registro S#7
	call L_4EF4		;514a
	ld (de),a			;514d
	inc de			;514e
	jr L_513D		;514f
vdp_lmmm:		; LMMM: copia un rectangulo con operacion logica (A)
	ex af,af'			;5151   ; LMMM: copia un rectangulo con la operacion logica de A: origen, destino, tamano y orden 0x90
	call espera_vdp		;5152   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	push bc			;5155
	ld a,(00007h)		;5156
	inc a			;5159
	ld c,a			;515a
	ld a,020h		;515b
	di			;515d
	out (c),a		;515e   ; al puerto de control: el numero del primer registro que se va a escribir (el valor de R#17)
	ld a,091h		;5160
	out (c),a		;5162   ; al puerto de control: selecciona R#17 (registro de indice, con auto-incremento)
	inc c			;5164
	inc c			;5165
	ex af,af'			;5166
	ld b,a			;5167
	rla			;5168
	rla			;5169
	rl h		;516a
	ld a,000h		;516c
	rla			;516e
	out (c),h		;516f   ; al VDP: R#32, SX bajo
	out (c),a		;5171   ; al VDP: R#33, SX alto
	out (c),l		;5173   ; al VDP: R#34, SY bajo
	ld a,b			;5175
	rra			;5176
	rra			;5177
	rra			;5178
	rra			;5179
	rra			;517a
	and 001h		;517b
	out (c),a		;517d   ; al VDP: R#35, SY alto
	ld a,b			;517f
	rla			;5180
	rla			;5181
	rl d		;5182
	ld a,000h		;5184
	rla			;5186
	out (c),d		;5187   ; al VDP: R#36, DX bajo
	out (c),a		;5189   ; al VDP: R#37, DX alto
	out (c),e		;518b   ; al VDP: R#38, DY bajo
	ld a,b			;518d
	rra			;518e
	rra			;518f
	rra			;5190
	rra			;5191
	and 001h		;5192
	out (c),a		;5194   ; al VDP: R#39, DY alto
	pop hl			;5196
	xor a			;5197
	sla h		;5198
	rla			;519a
	out (c),h		;519b   ; al VDP: R#40, NX bajo
	out (c),a		;519d   ; al VDP: R#41, NX alto
	xor a			;519f
	out (c),l		;51a0   ; al VDP: R#42, NY bajo
	cp l			;51a2
	jr nz,L_51A6		;51a3
	inc a			;51a5
L_51A6:
	out (c),a		;51a6   ; al VDP: R#43, NY alto
	out (c),a		;51a8   ; al VDP: R#44, CLR (color o dato)
	out (c),a		;51aa   ; al VDP: R#45, ARG (direccion y memoria)
	ld a,b			;51ac
	and 00fh		;51ad
	or 090h		;51af
	out (c),a		;51b1   ; al VDP: R#46, CMD (la orden)
	ei			;51b3
	ret			;51b4
L_51B5:
	ld (0faf5h),a		;51b5
	or a			;51b8
	ld a,01fh		;51b9
	jr z,L_51BF		;51bb
	or 020h		;51bd
L_51BF:
	ld b,a			;51bf
	ld c,002h		;51c0
	call 00047h		;51c2   ; BIOS WRTVDP - Writes data in the VDP-register
	ret			;51c5
L_51C6:
	call espera_vdp		;51c6   ; PSET: espera al VDP y escribe R#36 con X (H) y R#38 con Y (L)
	di			;51c9
	ld a,(00007h)		;51ca
	ld c,a			;51cd
	inc c			;51ce
	ld a,024h		;51cf
	out (c),a		;51d1
	ld a,091h		;51d3   ; selecciona R#17
	out (c),a		;51d5
	inc c			;51d7
	inc c			;51d8
	xor a			;51d9
	out (c),h		;51da
	out (c),a		;51dc
	out (c),l		;51de
	out (c),a		;51e0
	dec c			;51e2
	dec c			;51e3
	ld a,02ch		;51e4   ; R#44 (color) en otra escritura con R#17 = 0x2C
	out (c),a		;51e6
	ld a,091h		;51e8
	out (c),a		;51ea
	inc c			;51ec
	inc c			;51ed
	out (c),e		;51ee   ; el color de E
	xor a			;51f0
	out (c),a		;51f1
	ld a,050h		;51f3   ; la orden 0x50 (PSET)
	out (c),a		;51f5
	ei			;51f7
	ret			;51f8
L_51F9:
	call espera_vdp		;51f9   ; espera al VDP y pone los argumentos de la orden
	di			;51fc
	ld a,(00007h)		;51fd
	ld c,a			;5200
	inc c			;5201
	ld a,020h		;5202
	out (c),a		;5204
	ld a,097h		;5206   ; R#17 con 0x97 (a partir del registro 23)
	out (c),a		;5208
	inc c			;520a
	inc c			;520b
	xor a			;520c
	out (c),h		;520d   ; X e Y a cero
	out (c),a		;520f
	out (c),l		;5211
	out (c),a		;5213
	dec c			;5215
	dec c			;5216
	out (c),a		;5217   ; los argumentos de la orden
	ld a,0adh		;5219
	out (c),a		;521b
	ld a,040h		;521d
	out (c),a		;521f
	ld a,0aeh		;5221   ; lanza la orden y espera el fin
	out (c),a		;5223
L_5225:
	ld a,002h		;5225   ; espera a que acabe la orden (estado S#2) y deja el registro de estado en 0
	call L_4EFA		;5227   ; lee el registro de estado A del VDP: lo selecciona en R15, lo lee y vuelve a dejar R15 = 0
	rra			;522a
	jr c,L_5225		;522b
	ld a,007h		;522d
	call L_4EFA		;522f   ; lee el registro de estado A del VDP: lo selecciona en R15, lo lee y vuelve a dejar R15 = 0
	ei			;5232
	ret			;5233
L_5234:
	ld a,001h		;5234
	jr L_5239		;5236
L_5238:
	xor a			;5238
L_5239:
	push af			;5239
	call L_529C		;523a   ; DIBUJA UN TILE DE 8 x 8 en D,E: convierte (0x5274) y lo copia con ocho copias de 8 bytes a la VRAM
	call avanza_tile		;523d   ; avanza_tile: D += 8 (y E += 8 si D da la vuelta)
	pop af			;5240
	djnz L_5239		;5241
	ret			;5243
L_5244:
	ld de,0e800h		;5244
	call L_524D		;5247
	ld de,0e804h		;524a
L_524D:
	ld b,008h		;524d
L_524F:
	push bc			;524f   ; un tile de 8 filas: lee el byte de cada fila (los 8 bits son 8 puntos) y los pasa a nibbles con el color de C
	push hl			;5250
	ex de,hl			;5251
	ld a,(de)			;5252
	ld d,a			;5253
	ld b,004h		;5254
L_5256:
	ld a,c			;5256   ; cada punto con su bit: si esta a uno pone C, si no 0
	rl d		;5257
	jr c,L_525C		;5259
	xor a			;525b
L_525C:
	rld		;525c
	ld a,c			;525e
	rl d		;525f
	jr c,L_5264		;5261
	xor a			;5263
L_5264:
	rld		;5264   ; mete el nibble en el buffer (rld) y pasa al siguiente par
	inc hl			;5266
	djnz L_5256		;5267
	inc hl			;5269   ; salta los cuatro bytes del otro plano y sigue con la fila siguiente
	inc hl			;526a
	inc hl			;526b
	inc hl			;526c
	ex de,hl			;526d
	pop hl			;526e
	inc hl			;526f
	pop bc			;5270
	djnz L_524F		;5271
	ret			;5273
L_5274:
	and a			;5274   ; si A no es cero va a la variante de 2 colores (0x5244); si no, prepara el color C en los dos nibbles
	jr nz,L_5244		;5275
	ld a,c			;5277
	rrca			;5278
	rrca			;5279
	rrca			;527a
	rrca			;527b
	or c			;527c
	ld c,a			;527d
	ld b,008h		;527e   ; 8 filas con el color de fondo 0xFF donde el bit vale cero
	ld de,0e800h		;5280
L_5283:
	push bc			;5283   ; una fila: el byte de origen se despliega en 8 puntos
	push hl			;5284
	ex de,hl			;5285
	ld a,(de)			;5286
	ld d,a			;5287
	ld b,008h		;5288
L_528A:
	ld a,c			;528a   ; cada bit pone el color C o 0xFF
	rl d		;528b
	jr c,L_5291		;528d
	ld a,0ffh		;528f
L_5291:
	ld (hl),a			;5291   ; guarda el punto y repite con los 8 de la fila
	inc hl			;5292
	djnz L_528A		;5293
	ex de,hl			;5295   ; pasa a la fila siguiente del origen
	pop hl			;5296
	inc hl			;5297
	pop bc			;5298
	djnz L_5283		;5299
	ret			;529b
L_529C:
	push af			;529c   ; DIBUJA UN TILE DE 8 x 8 en D,E: convierte (0x5274) y lo copia con ocho copias de 8 bytes a la VRAM
	ld a,001h		;529d
	ld (0faf6h),a		;529f
	pop af			;52a2
	push bc			;52a3
	push de			;52a4
	push af			;52a5
	push hl			;52a6
	push de			;52a7
	call L_5274		;52a8   ; si A no es cero va a la variante de 2 colores (0x5244); si no, prepara el color C en los dos nibbles
	pop de			;52ab   ; intercambia X e Y: la direccion de la VRAM sale de D = Y / 2 y E = X
	ld b,d			;52ac
	ld d,e			;52ad
	ld e,b			;52ae
	srl d		;52af
	rr e		;52b1
	ld a,(0faf6h)		;52b3
	and a			;52b6
	jr z,L_52BB		;52b7
	ld a,080h		;52b9   ; con la bandera 0xFAF6 puesta suma 0x80 (la pagina alta)
L_52BB:
	add a,d			;52bb
	ld d,a			;52bc
	ld hl,0e800h		;52bd
	ld b,008h		;52c0
L_52C2:
	push bc			;52c2   ; copia 8 bytes de una fila del buffer a la VRAM y pasa a la siguiente (0x80 mas)
	ld bc,00008h		;52c3
	call copia_a_vram_hl		;52c6   ; copia_a_vram_hl: copia BC bytes de HL a la VRAM en DE
	ex de,hl			;52c9
	ld bc,00080h		;52ca
	add hl,bc			;52cd
	ex de,hl			;52ce
	pop bc			;52cf
	djnz L_52C2		;52d0
	pop hl			;52d2
	pop af			;52d3
	and a			;52d4   ; avanza HL 8 o 16 bytes segun el formato
	ld bc,00008h		;52d5
	jr z,L_52DD		;52d8
	ld bc,00010h		;52da
L_52DD:
	add hl,bc			;52dd
	pop de			;52de
	pop bc			;52df
	ret			;52e0
L_52E1:
	ld a,(0c0b9h)		;52e1   ; lee el tamano de las baldosas de la imagen que se carga
	and a			;52e4
	jr nz,L_532A		;52e5
	push de			;52e7
	ex de,hl			;52e8
	ld b,008h		;52e9
L_52EB:
	push bc			;52eb   ; un tile de 4 bits por punto: duplica el nibble de cada byte en los dos lados
	push hl			;52ec
	ld b,004h		;52ed
	ld hl,0e800h		;52ef
L_52F2:
	push bc			;52f2   ; el nibble alto, si no es cero, se copia tambien al bajo
	ld a,(de)			;52f3
	and 0f0h		;52f4
	jr z,L_52FE		;52f6
	ld c,a			;52f8
	rrca			;52f9
	rrca			;52fa
	rrca			;52fb
	rrca			;52fc
	or c			;52fd
L_52FE:
	ld (hl),a			;52fe   ; guarda el nibble alto duplicado
	inc hl			;52ff
	ld a,(de)			;5300   ; el nibble bajo, si no es cero, tambien duplicado
	and 00fh		;5301
	jr z,L_530B		;5303
	ld c,a			;5305
	rlca			;5306
	rlca			;5307
	rlca			;5308
	rlca			;5309
	or c			;530a
L_530B:
	ld (hl),a			;530b   ; guarda y avanza a la columna siguiente
	inc hl			;530c
	inc de			;530d
	pop bc			;530e
	djnz L_52F2		;530f
	pop hl			;5311   ; copia la fila de 8 bytes del buffer a la VRAM
	push hl			;5312
	push de			;5313
	ex de,hl			;5314
	ld hl,0e800h		;5315
	ld bc,00008h		;5318
	call copia_a_vram_hl		;531b   ; copia 8 bytes a la VRAM y avanza 0x80
	pop de			;531e
	pop hl			;531f
	ld bc,00080h		;5320   ; baja a la fila siguiente (0x80)
	add hl,bc			;5323
	pop bc			;5324
	djnz L_52EB		;5325
	ex de,hl			;5327
	pop de			;5328
	ret			;5329
L_532A:
	push de			;532a
	ld b,008h		;532b
L_532D:
	push bc			;532d   ; copia 8 filas de 4 bytes a la VRAM (tile ya en 4 bits)
	ld bc,00004h		;532e
	call copia_a_vram_hl		;5331   ; copia_a_vram_hl: copia BC bytes de HL a la VRAM en DE
	ex de,hl			;5334
	ld bc,00080h		;5335
	add hl,bc			;5338
	ex de,hl			;5339
	pop bc			;533a
	djnz L_532D		;533b
	pop de			;533d
	ret			;533e
L_533F:
	xor a			;533f
	jr L_5344		;5340
L_5342:
	ld a,001h		;5342
L_5344:
	ld (0c0b9h),a		;5344   ; guarda el tamano de las baldosas de la imagen que se carga
L_5347:
	push bc			;5347
	call L_52E1		;5348
	ld a,(0c0b9h)		;534b   ; lee el tamano de las baldosas de la imagen que se carga
	and a			;534e
	ld a,002h		;534f
	jr nz,L_5354		;5351
	add a,a			;5353
L_5354:
	add a,e			;5354   ; avanza la X del siguiente tile; si pasa de 0x80 baja la fila
	cp 080h		;5355
	jr c,L_535E		;5357
	ld a,004h		;5359
	add a,d			;535b
	ld d,a			;535c
	xor a			;535d
L_535E:
	ld e,a			;535e
	pop bc			;535f
	djnz L_5347		;5360
	ret			;5362
dibuja_lista_tiles:		; dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	ld c,0ffh		;5363
	jr L_5369		;5365
L_5367:
	ld c,000h		;5367
L_5369:
	ld d,(hl)			;5369
	inc hl			;536a
	ld e,(hl)			;536b
	inc hl			;536c
L_536D:
	ld a,(hl)			;536d   ; siguiente tile de la lista: 0xFF acaba, 0xFE trae otro X, Y; si C = 0 el tile se pinta 0x33
	inc hl			;536e
	ld b,a			;536f
	inc b			;5370
	ret z			;5371
	inc b			;5372
	jr z,dibuja_lista_tiles		;5373
	and c			;5375
	jr nz,L_537A		;5376
	ld a,033h		;5378
L_537A:
	call dibuja_tile		;537a   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld a,d			;537d
	add a,008h		;537e
	ld d,a			;5380
	jr L_536D		;5381
L_5383:
	ld d,(hl)			;5383
	inc hl			;5384
	ld e,(hl)			;5385
	inc hl			;5386
L_5387:
	ld a,(hl)			;5387   ; otra lista de tiles igual que la anterior, dibujando con la copia de la pagina 1
	inc hl			;5388
	ld b,a			;5389
	inc b			;538a
	ret z			;538b
	inc b			;538c
	jr z,L_5383		;538d
	call dibuja_tile_pagina1		;538f   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
	ld a,d			;5392
	add a,008h		;5393
	ld d,a			;5395
	jr L_5387		;5396
dibuja_tile:		; dibuja el tile A de 8 x 8 en D,E
	push bc			;5398   ; dibuja el tile A (8x8, de la hoja en la VRAM) en D,E
	push hl			;5399
	push de			;539a
	call origen_tile		;539b   ; origen_tile: HL = el origen en la hoja de tiles del tile A
	ld bc,00808h		;539e
	ld a,028h		;53a1
	call vdp_lmmm		;53a3   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)
	pop de			;53a6
	pop hl			;53a7
	pop bc			;53a8
	ret			;53a9
dibuja_tile_pagina1:		; dibuja el tile A en D,E con la copia de la pagina 1
	push bc			;53aa
	push hl			;53ab
	push de			;53ac
	call origen_tile		;53ad   ; origen_tile: HL = el origen en la hoja de tiles del tile A
	ld bc,00808h		;53b0
	ld a,003h		;53b3
	call vdp_copia		;53b5   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	pop de			;53b8
	pop hl			;53b9
	pop bc			;53ba
	ret			;53bb
L_53BC:
	push bc			;53bc   ; dibuja un tile de 4 x 8 (el medio ancho de las letras de dialogo) con una copia HMMM
	push hl			;53bd
	push de			;53be
	call L_53CE		;53bf   ; origen en la hoja de tiles del tile A de 4 puntos de ancho (X = (A & 0x3F) x 4, Y = 0xB0 + (A >> 6) x 8)
	ld bc,00408h		;53c2
	ld a,003h		;53c5
	call vdp_copia		;53c7   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	pop de			;53ca
	pop hl			;53cb
	pop bc			;53cc
	ret			;53cd
L_53CE:
	ld b,a			;53ce   ; origen en la hoja de tiles del tile A de 4 puntos de ancho (X = (A & 0x3F) x 4, Y = 0xB0 + (A >> 6) x 8)
	and 03fh		;53cf   ; X en la hoja: (A & 0x3F) x 4
	add a,a			;53d1
	add a,a			;53d2
	ld h,a			;53d3
	ld a,b			;53d4   ; Y en la hoja: 0xB0 + (A & 0xC0) / 8
	and 0c0h		;53d5
	rrca			;53d7
	rrca			;53d8
	rrca			;53d9
	add a,0b0h		;53da
	ld l,a			;53dc
	ret			;53dd
origen_tile:		; HL = el origen en la hoja de tiles del tile A
	ld b,a			;53de   ; origen en la hoja de tiles del tile A de 8 x 8 (X = (A & 0x1F) x 8, Y = 0xB0 + (A >> 5) x 8)
	and 01fh		;53df   ; X en la hoja: (A & 0x1F) x 8
	add a,a			;53e1
	add a,a			;53e2
	add a,a			;53e3
	ld h,a			;53e4
	ld a,b			;53e5   ; Y en la hoja: 0xB0 + (A & 0xE0) / 4
	and 0e0h		;53e6
	rrca			;53e8
	rrca			;53e9
	add a,0b0h		;53ea
	ld l,a			;53ec
	ret			;53ed
avanza_tile:		; D += 8 (y E += 8 si D da la vuelta)
	ld a,d			;53ee   ; D += 8 y, si da la vuelta, E += 8
	add a,008h		;53ef
	ld d,a			;53f1
	ret nz			;53f2
	ld a,e			;53f3
	add a,008h		;53f4
	ld e,a			;53f6
	ret			;53f7
L_53F8:
	push bc			;53f8
	push de			;53f9
	exx			;53fa
	ld hl,0e000h		;53fb
	exx			;53fe
L_53FF:
	push bc			;53ff
	call L_5424		;5400   ; pasa 8 filas de 1 bit por punto (1 byte por fila, HL) a 4 bits por punto, usando la paleta de 2 entradas de 0xE800
	pop bc			;5403
	djnz L_53FF		;5404
	pop de			;5406
	pop bc			;5407
	ld hl,0e000h		;5408
	jp L_5347		;540b
L_540E:
	push bc			;540e
	push de			;540f
	exx			;5410
	ld hl,0e000h		;5411
	exx			;5414
L_5415:
	push bc			;5415
	call L_5424		;5416   ; pasa 8 filas de 1 bit por punto (1 byte por fila, HL) a 4 bits por punto, usando la paleta de 2 entradas de 0xE800
	pop bc			;5419
	djnz L_5415		;541a
	pop de			;541c
	pop bc			;541d
	ld hl,0e000h		;541e
	jp L_556D		;5421
L_5424:
	ld b,008h		;5424   ; pasa 8 filas de 1 bit por punto (1 byte por fila, HL) a 4 bits por punto, usando la paleta de 2 entradas de 0xE800
L_5426:
	ld e,(hl)			;5426
	inc hl			;5427
	push bc			;5428
	call L_5430		;5429   ; una fila: 8 puntos de 1 bit -> 4 bytes de 2 puntos (cada punto elige entre las entradas de 0xE800)
	pop bc			;542c
	djnz L_5426		;542d
	ret			;542f
L_5430:
	ld b,004h		;5430   ; una fila: 8 puntos de 1 bit -> 4 bytes de 2 puntos (cada punto elige entre las entradas de 0xE800)
L_5432:
	xor a			;5432   ; una fila de 1 bit por punto: pasa cada par de bits a un byte con los colores de la paleta de 2 entradas
	rl e		;5433
	rla			;5435
	exx			;5436
	ld e,a			;5437
	ld d,0e8h		;5438
	ld a,(de)			;543a   ; color de la paleta para el primer punto
	add a,a			;543b
	add a,a			;543c
	add a,a			;543d
	add a,a			;543e
	ld c,a			;543f
	exx			;5440
	xor a			;5441   ; segundo punto de la pareja
	rl e		;5442
	rla			;5444
	exx			;5445
	ld e,a			;5446
	ld d,0e8h		;5447
	ld a,(de)			;5449   ; color de la paleta del segundo punto, junto al primero
	or c			;544a
	ld (hl),a			;544b
	inc hl			;544c
	exx			;544d
	djnz L_5432		;544e
	ret			;5450
L_5451:
	push bc			;5451   ; 8 filas de 2 bits por punto (2 bytes por fila, HL) -> 4 bits, y a la VRAM por 0x5347
	push de			;5452
	exx			;5453
	ld hl,0e000h		;5454
	exx			;5457
L_5458:
	push bc			;5458
	call L_547D		;5459   ; 8 filas de 2 bits por punto
	pop bc			;545c
	djnz L_5458		;545d
	pop de			;545f
	pop bc			;5460
	ld hl,0e000h		;5461
	jp L_5347		;5464
L_5467:
	push bc			;5467   ; igual que 0x5451, pero a la VRAM por 0x556D (la imagen va hacia la izquierda)
	push de			;5468
	exx			;5469
	ld hl,0e000h		;546a
	exx			;546d
L_546E:
	push bc			;546e
	call L_547D		;546f   ; 8 filas de 2 bits por punto
	pop bc			;5472
	djnz L_546E		;5473
	pop de			;5475
	pop bc			;5476
	ld hl,0e000h		;5477
	jp L_556D		;547a
L_547D:
	ld b,008h		;547d   ; 8 filas de 2 bits por punto
L_547F:
	push bc			;547f
L_5480:
	call L_5487		;5480   ; una fila de 2 bits por punto: 8 puntos -> 4 bytes, con la paleta de 4 colores de 0xE800
	pop bc			;5483
	djnz L_547F		;5484
	ret			;5486
L_5487:
	ld b,004h		;5487   ; una fila de 2 bits por punto: 8 puntos -> 4 bytes, con la paleta de 4 colores de 0xE800
	ld e,(hl)			;5489
	inc hl			;548a
	ld d,(hl)			;548b
	inc hl			;548c
L_548D:
	xor a			;548d   ; una fila de 2 bits por punto: cada par de bits elige uno de los cuatro colores de 0xE800
	rl d		;548e
	rla			;5490
	rl e		;5491
	rla			;5493
	exx			;5494
	ld e,a			;5495
	ld d,0e8h		;5496
	ld a,(de)			;5498   ; color de la paleta (cuatro) para el primer punto
	add a,a			;5499
	add a,a			;549a
	add a,a			;549b
	add a,a			;549c
	ld c,a			;549d
	exx			;549e
	xor a			;549f
	rl d		;54a0
	rla			;54a2
	rl e		;54a3
	rla			;54a5
	exx			;54a6
	ld e,a			;54a7
	ld d,0e8h		;54a8
	ld a,(de)			;54aa   ; color del segundo punto
	or c			;54ab
	ld (hl),a			;54ac
	inc hl			;54ad
	exx			;54ae
	djnz L_548D		;54af
	ret			;54b1
L_54B2:
	push bc			;54b2   ; 8 filas de 3 bits por punto (3 bytes por fila, HL) -> 4 bits, y a la VRAM por 0x5347
	push de			;54b3
	exx			;54b4
	ld hl,0e000h		;54b5
	exx			;54b8
L_54B9:
	push bc			;54b9   ; repite el tile B veces y vuelca los tiles a la VRAM por 0x5347
	call L_54DE		;54ba
	pop bc			;54bd
	djnz L_54B9		;54be
	pop de			;54c0
	pop bc			;54c1
	ld hl,0e000h		;54c2
	jp L_5347		;54c5
L_54C8:
	push bc			;54c8   ; igual que 0x54B2, pero por 0x556D
	push de			;54c9
	exx			;54ca
	ld hl,0e000h		;54cb
	exx			;54ce
L_54CF:
	push bc			;54cf   ; igual, pero por 0x556D (hacia la izquierda)
	call L_54DE		;54d0
	pop bc			;54d3
	djnz L_54CF		;54d4
	pop de			;54d6
	pop bc			;54d7
	ld hl,0e000h		;54d8
	jp L_556D		;54db
L_54DE:
	ld b,008h		;54de
L_54E0:
	push bc			;54e0
	call L_54E8		;54e1   ; una fila de 3 bits por punto: 8 puntos -> 4 bytes, con la paleta de 8 colores de 0xE800
	pop bc			;54e4
	djnz L_54E0		;54e5
	ret			;54e7
L_54E8:
	ld b,004h		;54e8   ; una fila de 3 bits por punto: 8 puntos -> 4 bytes, con la paleta de 8 colores de 0xE800
	ld e,(hl)			;54ea
	inc hl			;54eb
	ld d,(hl)			;54ec
	inc hl			;54ed
	ld c,(hl)			;54ee
	inc hl			;54ef
L_54F0:
	xor a			;54f0   ; una fila de 3 bits por punto: cada trio de bits elige uno de los ocho colores de 0xE800
	rl c		;54f1   ; un punto de 3 bits: se desplazan tres bytes (C, D, E) bit a bit hacia A
	rla			;54f3
	rl d		;54f4
	rla			;54f6
	rl e		;54f7
	rla			;54f9
	exx			;54fa   ; color de la paleta (8 entradas) que elige el trio de bits
	ld e,a			;54fb
	ld d,0e8h		;54fc
	ld a,(de)			;54fe   ; color de la paleta (ocho) para el primer punto
	add a,a			;54ff
	add a,a			;5500
	add a,a			;5501
	add a,a			;5502
	ld c,a			;5503
	exx			;5504   ; segundo punto del par con otro trio de bits
	xor a			;5505
	rl c		;5506
	rla			;5508
	rl d		;5509
	rla			;550b
	rl e		;550c
	rla			;550e
	exx			;550f
	ld e,a			;5510   ; busca su color en 0xE800
	ld d,0e8h		;5511
	ld a,(de)			;5513   ; color del segundo punto
	or c			;5514   ; junta los dos colores en un byte
	ld (hl),a			;5515
	inc hl			;5516
	exx			;5517
	djnz L_54F0		;5518   ; repite cuatro veces (ocho puntos)
	ret			;551a
L_551B:
	push de			;551b   ; vuelca a la VRAM (en DE) un tile ya en 4 bits (32 bytes en 0xE000) de derecha a izquierda
	ld a,(00007h)		;551c
	ld c,a			;551f
	ld b,008h		;5520
L_5522:
	push bc			;5522
	ex de,hl			;5523
	call L_4D89		;5524   ; direccion de escritura de la VRAM = HL x 2: R14 = bits 14-16, y despues los dos bytes de direccion con el bit 6 puesto
	ex de,hl			;5527
	ld b,004h		;5528
L_552A:
	push bc			;552a   ; un tile de 4 bits por punto hacia la izquierda: cuatro pares por fila
	call L_553E		;552b   ; dos puntos a la VRAM: con 0xC0B9 = 0 repite el nibble en los dos lados
	pop bc			;552e
	djnz L_552A		;552f
	ld c,008h		;5531
	add hl,bc			;5533
	ex de,hl			;5534
	ld c,080h		;5535
	add hl,bc			;5537
	ex de,hl			;5538
	pop bc			;5539
	djnz L_5522		;553a
	pop de			;553c
	ret			;553d
L_553E:
	ld a,(0c0b9h)		;553e   ; dos puntos a la VRAM: con 0xC0B9 = 0 repite el nibble en los dos lados
	and a			;5541
	jr nz,L_555C		;5542
	ld a,(hl)			;5544   ; con 0xC0B9 = 0: el nibble bajo del byte, duplicado, al VDP
	and 00fh		;5545
	ld b,a			;5547
	rlca			;5548
	rlca			;5549
	rlca			;554a
	rlca			;554b
	or b			;554c
	out (c),a		;554d
	ld a,(hl)			;554f   ; el nibble alto duplicado
	and 0f0h		;5550
	ld b,a			;5552
	rrca			;5553
	rrca			;5554
	rrca			;5555
	rrca			;5556
	or b			;5557
	out (c),a		;5558
	dec hl			;555a
	ret			;555b
L_555C:
	ld a,(hl)			;555c   ; con 0xC0B9 distinto de cero solo el nibble alto
	dec hl			;555d
	rrca			;555e
	rrca			;555f
	rrca			;5560
	rrca			;5561
	out (c),a		;5562
	ret			;5564
L_5565:
	xor a			;5565
	jr L_556A		;5566
L_5568:
	ld a,001h		;5568
L_556A:
	ld (0c0b9h),a		;556a   ; guarda el tamano de las baldosas de la imagen que se carga
L_556D:
	inc hl			;556d   ; pasa al tile siguiente de una imagen que se pinta hacia la izquierda (E += 2 o 4, con salto de fila a los 0x80)
	inc hl			;556e
	inc hl			;556f
L_5570:
	push bc			;5570
	call L_551B		;5571   ; vuelca a la VRAM (en DE) un tile ya en 4 bits (32 bytes en 0xE000) de derecha a izquierda
	ld a,(0c0b9h)		;5574   ; lee el tamano de las baldosas de la imagen que se carga
	and a			;5577
	ld a,002h		;5578
	jr nz,L_557D		;557a
	add a,a			;557c
L_557D:
	add a,e			;557d   ; avanza la X al tile siguiente (hacia la izquierda: salta a la fila de abajo al llegar a 0x80)
	cp 080h		;557e
	jr nz,L_5587		;5580
	ld a,004h		;5582
	add a,d			;5584
	ld d,a			;5585
	xor a			;5586
L_5587:
	ld e,a			;5587
	pop bc			;5588
	djnz L_5570		;5589
	ret			;558b
arranca_pantalla:		; arranca el sonido, pone SCREEN 7 y limpia la VRAM
	ld a,00ch		;558c   ; arranca el sonido (p12:6000), pone SCREEN 7, borra las paginas 0 y 1 y carga seis registros del VDP (tabla 0x55E4)
	ld (07000h),a		;558e   ; el mapper: pone en 0x6000 el banco de A
	inc a			;5591
	ld (09000h),a		;5592   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5595
	ld (0b000h),a		;5596   ; el mapper: pone en 0xA000 el banco de A
	call 06000h		;5599   ; sonido_init: inicia el sonido
	ld a,(0f0f1h)		;559c   ; lee la copia del banco en 0x6000
	ld (07000h),a		;559f   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;55a2   ; lee la copia del banco en 0x8000
	ld (09000h),a		;55a5   ; el mapper: pone en 0x8000 el banco de A
	ld a,(0f0f3h)		;55a8   ; lee la copia del banco en 0xA000
	ld (0b000h),a		;55ab   ; el mapper: pone en 0xA000 el banco de A
	ld a,007h		;55ae
	call 0005fh		;55b0   ; BIOS CHGMOD - Switches to given screen mode | CHGMOD 7: 512 x 212 puntos, 16 colores
	ld bc,00f07h		;55b3
	call 00047h		;55b6   ; BIOS WRTVDP - Writes data in the VDP-register
	xor a			;55b9
	ld h,a			;55ba
	ld l,a			;55bb
	ld b,a			;55bc
	ld c,a			;55bd
	ld d,a			;55be
	call vdp_hmmv_2		;55bf   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	xor a			;55c2
	ld h,a			;55c3
	ld l,a			;55c4
	ld b,a			;55c5
	ld c,a			;55c6
	ld d,001h		;55c7
	call vdp_hmmv_2		;55c9   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	call espera_vdp		;55cc   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	ld b,006h		;55cf
	ld hl,055e4h		;55d1
L_55D4:
	push bc			;55d4   ; carga seis registros del VDP desde la tabla de 0x55E4 (numero y valor)
	ld c,(hl)			;55d5
	inc hl			;55d6
	ld b,(hl)			;55d7
	inc hl			;55d8
	push hl			;55d9
	call 00047h		;55da   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;55dd
	pop bc			;55de
	djnz L_55D4		;55df
	jp L_4E9C		;55e1

; ----------------------------------------------------------------------
; DATOS resto_55E4: lo apuntan con el banco puesto p00:55D1 (0x55E4); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:55D1 (12 bytes)
;   0x55e4..0x55f0  (12 bytes)
DATA_resto_55E4:
	defb 001h,062h,005h,0efh,006h,01fh,008h,008h,009h,080h,00bh,001h	; 55e4  .b..........

; ======================================================================
; CODIGO 0x55f0..0x5892  (674 bytes)
; ======================================================================


lee_mandos:		; lee los mandos y el teclado
	call L_560C		;55f0   ; lee los mandos y el teclado: mandos (0xC007), pulsaciones nuevas (0xC008) y de repeticion (0xC00D), con retardo (0xC016)
	call L_5602		;55f3   ; flancos de bajada de las teclas: 0xC007 = lo que se acaba de pulsar
	call L_5647		;55f6   ; lee las teclas de las filas 6 y 7 del teclado (F1-F3, CTRL/SHIFT, RET/ESC...) en 5 bits
	ld hl,0c00dh		;55f9   ; apunta a el estado anterior de las teclas de las filas 6 y 7
	call L_5605		;55fc   ; flancos de una tecla: guarda el estado nuevo y deja en la direccion anterior lo recien pulsado
	jp L_565F		;55ff
L_5602:
	ld hl,0c008h		;5602   ; flancos de bajada de las teclas: 0xC007 = lo que se acaba de pulsar
L_5605:
	ld c,(hl)			;5605   ; flancos de una tecla: guarda el estado nuevo y deja en la direccion anterior lo recien pulsado
	ld (hl),a			;5606
	xor c			;5607
	and (hl)			;5608
	dec hl			;5609
	ld (hl),a			;560a
	ret			;560b
L_560C:
	ld e,08fh		;560c   ; teclas y joystick 1 en un byte: bits 0-5 de la palanca y 2 botones (PSG puerto 14, filas 6 y 8 del teclado)
	ld a,00fh		;560e
	call 00093h		;5610   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;5613
	di			;5615
	call 00096h		;5616   ; BIOS RDPSG - Reads value from PSG-register
	ei			;5619
	cpl			;561a
	and 03fh		;561b
	push af			;561d
	ld a,006h		;561e
	call 00141h		;5620   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5623
	rrca			;5624
	rrca			;5625
	rrca			;5626
	and 020h		;5627
	ld e,a			;5629
	ld a,008h		;562a
	call 00141h		;562c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;562f
	rrca			;5630
	rrca			;5631
	ld b,a			;5632
	and 004h		;5633
	or e			;5635
	ld c,a			;5636
	ld a,b			;5637
	rrca			;5638
	rrca			;5639
	ld b,a			;563a
	and 018h		;563b
	or c			;563d
	ld c,a			;563e
	ld a,b			;563f
	rrca			;5640
	and 003h		;5641
	or c			;5643
	pop bc			;5644
	or b			;5645
	ret			;5646
L_5647:
	ld a,006h		;5647   ; lee las teclas de las filas 6 y 7 del teclado (F1-F3, CTRL/SHIFT, RET/ESC...) en 5 bits
	call 00141h		;5649   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;564c
	and 0e0h		;564d
	ld e,a			;564f
	ld a,007h		;5650
	call 00141h		;5652   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;5655
	and 003h		;5656
	or e			;5658
	rlca			;5659
	rlca			;565a
	rlca			;565b
	and 01fh		;565c
	ret			;565e
L_565F:
	ld hl,0c016h		;565f   ; repeticion de las teclas: si se mantiene pulsada se repite despues de 0x2D cuadros, cada 5
	ld de,0c007h		;5662   ; apunta a las teclas y los mandos pulsados ahora (flancos de subida)
	ld bc,0c008h		;5665   ; apunta a el estado anterior de las teclas del mando
	ld a,(hl)			;5668
	cp 02dh		;5669
	jr nc,L_5678		;566b
	ld a,(de)			;566d
	and 00fh		;566e
	jr nz,L_5687		;5670
	ld a,(bc)			;5672
	and a			;5673
	jr z,L_5687		;5674
	inc (hl)			;5676
	ret			;5677
L_5678:
	ld a,(bc)			;5678   ; si la tecla sigue pulsada
	and a			;5679
	jr z,L_5687		;567a
	inc hl			;567c
	inc (hl)			;567d   ; cuenta de la repeticion
	ld a,(hl)			;567e
	cp 005h		;567f
	ret nz			;5681
	ld (hl),000h		;5682
	ld a,(bc)			;5684
	ld (de),a			;5685
	ret			;5686
L_5687:
	ld (hl),000h		;5687
	ret			;5689
carga_fondo_mesa:		; carga el fondo de la mesa (bancos 7-9)
	call bancos_7_8_9		;568a   ; carga el fondo de la pantalla de juego (imagenes de los bancos 7-9) y pone el marco
	ld hl,065e8h		;568d
	ld de,06518h		;5690
	xor a			;5693
	call carga_imagen		;5694   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	ld de,00040h		;5697
	ld hl,0783fh		;569a
	call L_56AC		;569d   ; dibuja un rectangulo de tiles de 24 x 6 (HL = tile map)
	ld de,00070h		;56a0
	ld hl,078cfh		;56a3
	call L_56AC		;56a6   ; dibuja un rectangulo de tiles de 24 x 6 (HL = tile map)
	jp bancos_1_2_3		;56a9   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_56AC:
	ld bc,00618h		;56ac   ; dibuja un rectangulo de tiles de 24 x 6 (HL = tile map)
L_56AF:
	push bc			;56af
	push de			;56b0
	ld b,c			;56b1
L_56B2:
	ld a,(hl)			;56b2   ; una fila del rectangulo de tiles: un tile por byte, 8 puntos mas a la derecha
	call dibuja_tile_pagina1		;56b3   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
	inc hl			;56b6
	ld a,d			;56b7
	add a,008h		;56b8
	ld d,a			;56ba
	djnz L_56B2		;56bb
	pop de			;56bd
	ld a,e			;56be
	add a,008h		;56bf
	ld e,a			;56c1
	pop bc			;56c2
	djnz L_56AF		;56c3
	ret			;56c5
L_56C6:
	call bancos_10_11		;56c6   ; carga una imagen de los bancos 10-11 (HL = lista de tiles, DE = tabla)
	ld hl,0806ch		;56c9
	ld de,08000h		;56cc
	xor a			;56cf
	call carga_imagen		;56d0   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	ld hl,0f800h		;56d3
	ld de,0946ah		;56d6
	call L_4E2D		;56d9
	jp bancos_1_2_3		;56dc   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_56DF:
	call bancos_10_11		;56df   ; carga otra imagen de los bancos 10-11
	ld hl,08f87h		;56e2
	ld de,08f6bh		;56e5
	xor a			;56e8
	call carga_imagen		;56e9   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	call bancos_1_2_3		;56ec   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	jp bancos_4		;56ef   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
L_56F2:
	call bancos_10_11		;56f2   ; carga una imagen de los bancos 10-11 y su paleta (0xF800)
	ld hl,0a635h		;56f5
	ld de,0a4f5h		;56f8
	xor a			;56fb
	call carga_imagen		;56fc   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	ld hl,0f800h		;56ff
	ld de,0b97ah		;5702
	call L_4E2D		;5705
	jp bancos_1_2_3		;5708   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_570B:
	call L_5746		;570b
L_570E:
	ld hl,081beh		;570e   ; carga las tres columnas de texto de dialogo en 0xC0BF/0xC0BE
	ld de,0805dh		;5711
	ld bc,0b636h		;5714
	ld a,024h		;5717
	ld (0c0bfh),a		;5719
	xor a			;571c
	call L_5753		;571d   ; dibuja un bloque de texto (letras de 3 x 3 tiles de 4 puntos)
	ld hl,08225h		;5720
	ld de,0807fh		;5723
	ld bc,0b773h		;5726
	ld a,048h		;5729
	ld (0c0bfh),a		;572b
	ld a,001h		;572e
	call L_5753		;5730   ; dibuja un bloque de texto (letras de 3 x 3 tiles de 4 puntos)
	ld hl,082aah		;5733
	ld de,080abh		;5736
	ld bc,0b8d5h		;5739
	ld a,078h		;573c
	ld (0c0bfh),a		;573e
	ld a,001h		;5741
	jp L_5753		;5743
L_5746:
	ld hl,08151h		;5746
	ld de,08039h		;5749
	ld bc,0b4f9h		;574c
	xor a			;574f
	ld (0c0bfh),a		;5750
L_5753:
	ld (0c0beh),a		;5753   ; dibuja un bloque de texto (letras de 3 x 3 tiles de 4 puntos)
	call bancos_7_8_9		;5756   ; bancos_7_8_9: pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	push bc			;5759
	ld a,001h		;575a
	call carga_imagen		;575c   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	pop bc			;575f
	ld h,b			;5760
	ld l,c			;5761
	ld d,000h		;5762
	call L_576A		;5764   ; dibuja un texto: A = 0 letras grandes (3x3), si no pequenas (5x2); 0xFF acaba y 0xFE hace otra linea
	jp bancos_1_2_3		;5767   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_576A:
	ld a,(0c0beh)		;576a   ; dibuja un texto: A = 0 letras grandes (3x3), si no pequenas (5x2); 0xFF acaba y 0xFE hace otra linea
	and a			;576d
	ld a,(0c0bfh)		;576e
	jr nz,L_57A3		;5771
	ld e,a			;5773
L_5774:
	ld a,(hl)			;5774   ; siguiente letra de un dialogo: 0xFF acaba, 0xFE baja de linea
	inc a			;5775
	ret z			;5776
	inc a			;5777
	jr z,L_579A		;5778
	ld b,003h		;577a
	push de			;577c
L_577D:
	ld c,003h		;577d
	push de			;577f
L_5780:
	ld a,(hl)			;5780   ; una letra de 3 x 3 tiles de medio ancho: cada tile con 0x53BC
	call L_53BC		;5781   ; dibuja un tile de 4 x 8 (el medio ancho de las letras de dialogo) con una copia HMMM
	inc hl			;5784
	ld a,d			;5785
	add a,004h		;5786
	ld d,a			;5788
	dec c			;5789
	jr nz,L_5780		;578a
	pop de			;578c
	ld a,e			;578d
	add a,008h		;578e
	ld e,a			;5790
	djnz L_577D		;5791
	pop de			;5793
	ld a,d			;5794
	add a,00ch		;5795
	ld d,a			;5797
	jr L_5774		;5798
L_579A:
	ld d,000h		;579a   ; salto de linea: X a cero e Y mas 0x12
	ld a,e			;579c
	add a,012h		;579d
	ld e,a			;579f
	inc hl			;57a0
	jr L_5774		;57a1
L_57A3:
	ld e,a			;57a3
L_57A4:
	ld a,(hl)			;57a4   ; siguiente letra de un dialogo de 5 x 2 tiles
	inc a			;57a5
	ret z			;57a6
	inc a			;57a7
	jr z,L_57CA		;57a8
	ld b,002h		;57aa
	push de			;57ac
L_57AD:
	ld c,005h		;57ad
	push de			;57af
L_57B0:
	ld a,(hl)			;57b0   ; una letra de 5 x 2 tiles de medio ancho
	call L_53BC		;57b1   ; dibuja un tile de 4 x 8 (el medio ancho de las letras de dialogo) con una copia HMMM
	inc hl			;57b4
	ld a,d			;57b5
	add a,004h		;57b6
	ld d,a			;57b8
	dec c			;57b9
	jr nz,L_57B0		;57ba
	pop de			;57bc
	ld a,e			;57bd
	add a,008h		;57be
	ld e,a			;57c0
	djnz L_57AD		;57c1
	pop de			;57c3
	ld a,d			;57c4
	add a,012h		;57c5
	ld d,a			;57c7
	jr L_57A4		;57c8
L_57CA:
	ld d,000h		;57ca   ; salto de linea del dialogo ancho: X a cero e Y mas 0x0C
	ld a,e			;57cc
	add a,00ch		;57cd
	ld e,a			;57cf
	inc hl			;57d0
	jr L_57A4		;57d1
L_57D3:
	ld hl,07987h		;57d3
L_57D6:
	call bancos_7_8_9		;57d6   ; carga la lista de HL (bancos 7-9) y la pinta
	ld de,0795fh		;57d9
	xor a			;57dc
	call carga_imagen		;57dd   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	jp bancos_1_2_3		;57e0   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_57E3:
	call bancos_5_6		;57e3   ; vuelca una paleta de los bancos 5-6 (DE = lista)
	ld hl,0f800h		;57e6
	ld de,0b46fh		;57e9
	call L_4E2D		;57ec
	jp bancos_1_2_3		;57ef   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_57F2:
	call bancos_10_11		;57f2   ; bancos_10_11: pone los bancos 10-11 (y sus copias en 0xF0F1-3)
	ld hl,0f800h		;57f5
	ld de,0ba5eh		;57f8
	call L_4E2D		;57fb
	jp bancos_1_2_3		;57fe   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5801:
	ld hl,079a0h		;5801
	jr L_57D6		;5804
L_5806:
	ld hl,079b3h		;5806
	jr L_57D6		;5809
L_580B:
	ld hl,079cch		;580b
	jr L_57D6		;580e
L_5810:
	call bancos_15		;5810   ; bancos_15: pone el 15 (y sus copias en 0xF0F1-3)
	ld hl,0aaa0h		;5813
	call L_58C5		;5816   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_4		;5819   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
L_581C:
	call bancos_7_8_9		;581c   ; bancos_7_8_9: pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	ld hl,0bd32h		;581f
	call L_58C5		;5822   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_1_2_3		;5825   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5828:
	call bancos_7_8_9		;5828   ; bancos_7_8_9: pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	ld hl,0bc02h		;582b
	call L_58C5		;582e   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_1_2_3		;5831   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5834:
	call bancos_7_8_9		;5834   ; bancos_7_8_9: pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	ld hl,0ba37h		;5837
	call L_58C5		;583a   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_1_2_3		;583d   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5840:
	call bancos_7_8_9		;5840   ; bancos_7_8_9: pone los bancos 7-8-9 (y sus copias en 0xF0F1-3)
	ld hl,0be87h		;5843
	call L_58C5		;5846   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_1_2_3		;5849   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_584C:
	ld de,04e4ch		;584c   ; pinta los cuatro tiles de una esquina del marco
	ld a,04bh		;584f
	call dibuja_tile		;5851   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld de,04e54h		;5854
	ld a,04ch		;5857
	call dibuja_tile		;5859   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld de,07e4ch		;585c
	ld a,04dh		;585f
	call dibuja_tile		;5861   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	ld de,07e54h		;5864
	ld a,04eh		;5867
	jp dibuja_tile		;5869   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
L_586C:
	ld a,(0c031h)		;586c   ; pone los iconos de los tres rivales (0xC031-3) en el marco
	ld de,070d0h		;586f
	call L_5884		;5872
	ld a,(0c032h)		;5875   ; lee el personaje que juega de rival 2
	ld de,0a0d0h		;5878
	call L_5884		;587b
	ld a,(0c033h)		;587e   ; lee el personaje que juega de rival 3
	ld de,0d0d0h		;5881
L_5884:
	ld hl,05890h		;5884
	call palabra_de_tabla		;5887   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ld bc,03030h		;588a
	ld a,003h		;588d
	jp vdp_copia		;588f   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)

; ----------------------------------------------------------------------
; DATOS posiciones_caras: las ocho posiciones (X, Y) de la hoja de caras de
;   los personajes, de 48 x 48 puntos (p00:5884: 0x5890 + 2 x el numero del
;   personaje, de 1 a 8): cuatro filas de dos columnas, X = 0x40 y 0x70, Y =
;   0, 0x30, 0x60 y 0x90
;   0x5892..0x58a2  (16 bytes)
DATA_posiciones_caras:
	defb 040h,000h	; 5892
	defb 040h,030h	; 5894
	defb 040h,060h	; 5896
	defb 040h,090h	; 5898
	defb 070h,000h	; 589a
	defb 070h,030h	; 589c
	defb 070h,060h	; 589e
	defb 070h,090h	; 58a0

; ======================================================================
; CODIGO 0x58a2..0x58b9  (23 bytes)
; ======================================================================


L_58A2:
	push af			;58a2   ; carga la lista de paleta numero B de la tabla 0x58B9 (bancos 5-6)
	call bancos_5_6		;58a3   ; bancos_5_6: pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	ld a,b			;58a6
	ld hl,058b9h		;58a7
	call palabra_de_tabla		;58aa   ; palabra_de_tabla: HL = la palabra numero A de la tabla que apunta HL
	ex de,hl			;58ad
	ld hl,0fe00h		;58ae
	call L_4E2D		;58b1
	call bancos_1_2_3		;58b4   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	pop af			;58b7
	ret			;58b8

; ----------------------------------------------------------------------
; DATOS resto_58B9: lo apuntan con el banco puesto p00:58A7 (0x58B9); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:58A7 (12 bytes)
;   0x58b9..0x58c5  (12 bytes)
DATA_resto_58B9:
	defb 050h,0b8h,009h,0b7h,0f3h,0b9h,09fh,0bbh,057h,0b5h,037h,0bdh	; 58b9  P.......W.7.

; ======================================================================
; CODIGO 0x58c5..0x59d9  (276 bytes)
; ======================================================================


L_58C5:
	ld c,000h		;58c5   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jr L_58CB		;58c7
L_58C9:
	ld c,001h		;58c9
L_58CB:
	ld a,(hl)			;58cb   ; posicion D, E de la lista de tiles
	ld d,a			;58cc
	inc hl			;58cd
	ld a,(hl)			;58ce
	ld e,a			;58cf
	inc hl			;58d0
L_58D1:
	ld a,(hl)			;58d1   ; siguiente bloque: 0xFF acaba; el bit 7 trae n tiles distintos y si no uno repetido n veces
	cp 0ffh		;58d2
	ret z			;58d4
	and 080h		;58d5
	jr z,L_58F1		;58d7
	ld a,(hl)			;58d9
	and 07fh		;58da
	ld b,a			;58dc
	inc hl			;58dd
L_58DE:
	push bc			;58de
	push hl			;58df
	push de			;58e0
	ld a,(hl)			;58e1
	call L_5909		;58e2   ; un tile: C bit 0 = 0 con 0x5398 (tile normal), si no con 0x53AA
	pop de			;58e5
	call avanza_tile		;58e6   ; avanza_tile: D += 8 (y E += 8 si D da la vuelta)
	pop hl			;58e9
	inc hl			;58ea
	pop bc			;58eb
	djnz L_58DE		;58ec
	jp L_58D1		;58ee
L_58F1:
	ld a,(hl)			;58f1
	ld b,a			;58f2
	inc hl			;58f3
	ld a,(hl)			;58f4
	push hl			;58f5
L_58F6:
	push bc			;58f6
	push af			;58f7
	push de			;58f8
	call L_5909		;58f9   ; un tile: C bit 0 = 0 con 0x5398 (tile normal), si no con 0x53AA
	pop de			;58fc
	call avanza_tile		;58fd   ; avanza_tile: D += 8 (y E += 8 si D da la vuelta)
	pop af			;5900
	pop bc			;5901
	djnz L_58F6		;5902
	pop hl			;5904
	inc hl			;5905
	jp L_58D1		;5906
L_5909:
	rr c		;5909   ; un tile: C bit 0 = 0 con 0x5398 (tile normal), si no con 0x53AA
	jp nc,dibuja_tile		;590b   ; dibuja_tile: dibuja el tile A de 8 x 8 en D,E
	jp dibuja_tile_pagina1		;590e   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
carga_imagen:		; carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	ld (0c0b9h),a		;5911   ; CARGA UNA IMAGEN: HL = lista de entradas (formato en C, tabla en A de 4D07, posicion, nombre de tile); DE = tabla de paletas; A = 0xC0B9 (tamano de baldosa); acaba en 0xFF
L_5914:
	ld a,(hl)			;5914   ; siguiente entrada de la imagen: 0xFF acaba; C = formato, el byte siguiente es la paleta
	inc a			;5915
	ret z			;5916
	push de			;5917
	ld c,(hl)			;5918
	inc hl			;5919
	ld a,(hl)			;591a
	ex de,hl			;591b
	call palabra_de_tabla		;591c   ; la paleta de la entrada (2, 4, 8 o 12 bytes) a 0xE800
	push de			;591f
	push bc			;5920
	ld a,c			;5921
	and 006h		;5922
	add a,a			;5924
	jr nz,L_5929		;5925
	ld a,002h		;5927
L_5929:
	ld c,a			;5929   ; copia la paleta a 0xE800 y calcula el destino del tile (0x5962)
	ld b,000h		;592a
	ld de,0e800h		;592c
	ldir		;592f
	pop bc			;5931
	pop hl			;5932
	inc hl			;5933
	push hl			;5934
	call L_5962		;5935   ; direccion de la baldosa en la tabla de tiles de 0xD800
	pop hl			;5938
	inc hl			;5939
	ld b,(hl)			;593a
	inc hl			;593b
	ld a,(hl)			;593c
	inc hl			;593d
	push hl			;593e
	ld h,(hl)			;593f
	ld l,a			;5940
	call L_5949		;5941   ; el formato dice cual de las seis rutinas se usa
	pop hl			;5944
	pop de			;5945
	inc hl			;5946
	jr L_5914		;5947
L_5949:
	ld a,c			;5949   ; el formato dice cual de las seis rutinas se usa
	and 007h		;594a
	jp z,L_53F8		;594c
	dec a			;594f
	jp z,L_540E		;5950
	dec a			;5953
	jp z,L_5451		;5954
	dec a			;5957
	jp z,L_5467		;5958
	dec a			;595b   ; los formatos 4 y 5 son de 3 bits por punto
	jp z,L_54B2		;595c
	jp L_54C8		;595f
L_5962:
	ld a,(0c0b9h)		;5962   ; direccion de la VRAM del tile con el tamano de 0xC0B9 = 0: 0xD800 + (A & 0xE0) x 32 + (A & 0x1F) x 4
	and a			;5965
	jr nz,L_5982		;5966
	ld a,(hl)			;5968
	ld b,a			;5969   ; grupo de la baldosa (bits 5-7)
	and 0e0h		;596a
	ld h,000h		;596c
	ld l,a			;596e
	add hl,hl			;596f
	add hl,hl			;5970
	add hl,hl			;5971
	add hl,hl			;5972
	add hl,hl			;5973
	ld de,0d800h		;5974   ; base 0xD800 de las baldosas en la VRAM
	add hl,de			;5977
	ld a,b			;5978
	and 01fh		;5979   ; numero dentro del grupo x 4
	add a,a			;597b
	add a,a			;597c
	call suma_a_hl		;597d   ; suma_a_hl: HL = HL + A
	ex de,hl			;5980
	ret			;5981
L_5982:
	ld a,(hl)			;5982   ; igual con 0xC0B9 distinto de cero: 0xD800 + (A & 0xC0) x 16 + (A & 0x3F) x 2
	ld b,a			;5983
	and 0c0h		;5984
	ld h,000h		;5986
	ld l,a			;5988
	add hl,hl			;5989
	add hl,hl			;598a
	add hl,hl			;598b
	add hl,hl			;598c
	ld de,0d800h		;598d
	add hl,de			;5990
	ld a,b			;5991
	and 03fh		;5992
	add a,a			;5994
	call suma_a_hl		;5995   ; suma_a_hl: HL = HL + A
	ex de,hl			;5998
	ret			;5999
L_599A:
	call bancos_5_6		;599a   ; carga una paleta de los bancos 5-6 y la aplica (bancos 5-6)
	ld de,0b171h		;599d
	ld hl,0f800h		;59a0
	call L_4E2D		;59a3
	jp bancos_1_2_3		;59a6   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_59A9:
	call bancos_5_6		;59a9   ; bancos_5_6: pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	ld hl,0bec2h		;59ac
	call pon_colores		;59af   ; pon_colores: aplica una lista de colores (A, D, E; 0xFF acaba)
	jp bancos_1_2_3		;59b2   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_59B5:
	call bancos_5_6		;59b5   ; bancos_5_6: pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	ld hl,0bef3h		;59b8
	call pon_colores		;59bb   ; pon_colores: aplica una lista de colores (A, D, E; 0xFF acaba)
	jp bancos_1_2_3		;59be   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_59C1:
	call bancos_5_6		;59c1   ; bancos_5_6: pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	ld hl,0bf24h		;59c4
	call pon_colores		;59c7   ; pon_colores: aplica una lista de colores (A, D, E; 0xFF acaba)
	jp bancos_1_2_3		;59ca   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
copia_sprites:		; copia la tabla de colores de los sprites a la VRAM
	ld hl,0ca00h		;59cd   ; copia la tabla de atributos de sprites de 0xCA00 a la VRAM (0xF400, 640 bytes)
	ld de,0f400h		;59d0
	ld bc,00280h		;59d3
	jp copia_a_vram		;59d6   ; copia_a_vram: copia BC bytes de la RAM (DE) a la VRAM en HL

; ----------------------------------------------------------------------
; DATOS tiles_59D9: lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae
;   otro X, Y y 0xFF acaba; lo leen p00:5DC4 (17 bytes)
;   0x59d9..0x59ea  (17 bytes)
DATA_tiles_59D9:
	defb 048h,0a8h,0a3h,0a4h,0a5h,0a6h,0a7h,0a8h,0a9h,0aah,0abh,0ach,0adh,0aeh,0afh,0b0h	; 59d9  H...............
	defb 0ffh	; 59e9

; ----------------------------------------------------------------------
; DATOS resto_59EA: lo apuntan con el banco puesto p03:B39E (0x59EA), p03:B3FC
;   (0x59F5), p03:BBE4 (0x5A17); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p03:B39E, p03:B3FC, p03:BBE4 (56 bytes)
;   0x59ea..0x5a22  (56 bytes)
DATA_resto_59EA:
	defb 058h,054h,09ch,046h,08ah,0ffh,058h,06ch,022h,039h,0ffh,058h,030h,0a1h,0a2h,025h	; 59ea  XT.F..Xl"9.X0..%
	defb 02eh,0ffh,058h,048h,086h,01dh,09fh,0a0h,0ffh,058h,060h,03eh,046h,03eh,025h,02eh	; 59fa  ..XH.....X`>F>%.
	defb 0ffh,058h,078h,0ach,086h,0adh,05bh,0ffh,058h,090h,022h,039h,0ffh,058h,054h,0afh	; 5a0a  .Xx...[.X."9.XT.
	defb 046h,075h,0ffh,058h,06ch,022h,039h,0ffh	; 5a1a  Fu.Xl"9.

; ======================================================================
; CODIGO 0x5a22..0x5ce9  (711 bytes)
; ======================================================================


dibuja_mesa:		; carga las fichas y el tapete de los bancos 7-9
	call bancos_7_8_9		;5a22   ; carga la imagen de fondo de la mesa (bancos 7-9): rectangulos de tiles de los bancos 7, 8 y 9 en las filas 0xB0-0xC8 de la VRAM
	ld de,000b0h		;5a25
	ld hl,06000h		;5a28
	ld bc,0140eh		;5a2b
	call L_5238		;5a2e
	ld de,000b8h		;5a31
	ld hl,060a0h		;5a34
	ld bc,0140eh		;5a37
	call L_5238		;5a3a
	ld hl,098b8h		;5a3d   ; rellena con 0xFF un cuadro de 8 x 8 en 0x98B8 (pagina 1)
	ld bc,00808h		;5a40
	ld a,0ffh		;5a43
	ld d,001h		;5a45
	call vdp_hmmv_2		;5a47   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,000c0h		;5a4a
	ld hl,06130h		;5a4d
	ld bc,00109h		;5a50
	call L_5238		;5a53
	ld de,008c0h		;5a56
	ld hl,06008h		;5a59
	ld bc,00a09h		;5a5c
	call L_5238		;5a5f
	ld de,000c8h		;5a62
	ld hl,06138h		;5a65
	ld bc,0250eh		;5a68
	call L_5234		;5a6b
	ld hl,06388h		;5a6e   ; la paleta de 8 colores del bloque en 0xE800 y el tile en 0xE02C
	ld de,0e800h		;5a71
	ld bc,00008h		;5a74
	ldir		;5a77
	ld a,001h		;5a79
	ld (0c0b9h),a		;5a7b   ; guarda el tamano de las baldosas de la imagen que se carga
	ld de,0e02ch		;5a7e
	ld hl,06398h		;5a81
	ld b,008h		;5a84
	call L_54B2		;5a86   ; 8 filas de 3 bits por punto (3 bytes por fila, HL) -> 4 bits, y a la VRAM por 0x5347
L_5A89:
	call bancos_7_8_9		;5a89   ; carga dos conjuntos de tiles de los bancos 7-9 (las fichas del mahjong y sus numeros) con 3 y 2 bits por punto
	ld hl,06390h		;5a8c
	ld de,0e800h		;5a8f
	ld bc,00008h		;5a92
	ldir		;5a95
	xor a			;5a97
	ld (0c0b9h),a		;5a98   ; guarda el tamano de las baldosas de la imagen que se carga
	ld de,0e814h		;5a9b
	ld hl,06458h		;5a9e
	ld b,008h		;5aa1
	call L_54B2		;5aa3   ; 8 filas de 3 bits por punto (3 bytes por fila, HL) -> 4 bits, y a la VRAM por 0x5347
	call bancos_1_2_3		;5aa6   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ret			;5aa9
L_5AAA:
	call dibuja_mesa		;5aaa   ; carga la mesa y devuelve el banco 4 en 0xA000
	call bancos_4		;5aad   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ret			;5ab0
L_5AB1:
	call escribe_texto		;5ab1   ; escribe_texto: escribe un texto de letras de 16 puntos de alto en D,E
	call bancos_4		;5ab4   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ret			;5ab7
L_5AB8:
	call L_5ACF		;5ab8
	call bancos_4		;5abb   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ret			;5abe
L_5ABF:
	call L_5B23		;5abf
	call bancos_4		;5ac2   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ret			;5ac5
L_5AC6:
	call L_5B25		;5ac6
	call bancos_4		;5ac9   ; bancos_4: pone el 4 (y sus copias en 0xF0F1-3)
	ret			;5acc
escribe_texto:		; escribe un texto de letras de 16 puntos de alto en D,E
	ld c,00eh		;5acd   ; escribe un texto de letras de 16 puntos de alto (C = 0x0E, color) en la VRAM
L_5ACF:
	ld a,c			;5acf
	ld (0cc90h),a		;5ad0   ; guarda el color y pone a cero el ancho del texto (0xCC93)
	xor a			;5ad3
	ld (0cc93h),a		;5ad4
	call espera_vdp		;5ad7   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	ld (0cc80h),de		;5ada
	ld de,000dch		;5ade
	ld b,d			;5ae1
L_5AE2:
	ld a,(hl)			;5ae2   ; siguiente letra del texto: 0xFF acaba; la dibuja con el color de 0xCC90
	ld c,a			;5ae3
	inc a			;5ae4
	jr z,L_5B0E		;5ae5
	inc b			;5ae7
	push hl			;5ae8
	push bc			;5ae9
	push de			;5aea   ; por cada letra: la dibuja con 0x5B29; las de codigo < 10 miden 8 puntos y las demas 16
	ld a,c			;5aeb
	push af			;5aec
	ld a,(0cc90h)		;5aed
	ld c,a			;5af0
	pop af			;5af1
	call dibuja_letra		;5af2   ; dibuja_letra: dibuja la letra A de 16 x 16 con el color C
	pop de			;5af5
	pop bc			;5af6
	ld a,c			;5af7
	dec a			;5af8
	cp 00ah		;5af9
	ld a,008h		;5afb
	jr c,L_5B01		;5afd
	ld a,010h		;5aff
L_5B01:
	push af			;5b01   ; avanza la X de la letra segun mida 8 o 16 (los codigos 1 a 10 son estrechos) y suma el ancho a 0xCC93
	add a,d			;5b02
	ld d,a			;5b03
	pop af			;5b04
	ld hl,0cc93h		;5b05
	add a,(hl)			;5b08
	ld (hl),a			;5b09
	pop hl			;5b0a
	inc hl			;5b0b
	jr L_5AE2		;5b0c
L_5B0E:
	push hl			;5b0e   ; subraya el texto con un rectangulo del ancho acumulado (0xCC93)
	ld de,(0cc80h)		;5b0f
	ld hl,000dch		;5b13
	ld a,(0cc93h)		;5b16
	ld b,a			;5b19
	ld c,010h		;5b1a
	ld a,008h		;5b1c
	call vdp_lmmm		;5b1e   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)
	pop hl			;5b21
	ret			;5b22
L_5B23:
	ld c,00eh		;5b23
L_5B25:
	ld b,000h		;5b25
	jr L_5B2B		;5b27
dibuja_letra:		; dibuja la letra A de 16 x 16 con el color C
	ld b,001h		;5b29   ; dibuja la letra A de 16 x 16 puntos (de los 64 bytes de su forma en el banco 5, a 0x8000 + 64 x (A - 1)) con el color C
L_5B2B:
	push af			;5b2b
	ld a,b			;5b2c
	ld (0cc92h),a		;5b2d
	pop af			;5b30
	ld b,a			;5b31
	ld a,c			;5b32
	ld (0cc91h),a		;5b33
	call espera_vdp		;5b36   ; espera_vdp: espera a que el VDP acabe la orden en marcha
	ld a,b			;5b39
	and a			;5b3a
	jr z,L_5B8C		;5b3b
	call bancos_5_6		;5b3d   ; bancos_5_6: pone los bancos 5-6 (y sus copias en 0xF0F1-3)
	exx			;5b40
	dec a			;5b41
	ld l,a			;5b42
	ld h,000h		;5b43
	add hl,hl			;5b45
	add hl,hl			;5b46
	add hl,hl			;5b47
	add hl,hl			;5b48
	add hl,hl			;5b49
	add hl,hl			;5b4a
	ld de,08000h		;5b4b
	add hl,de			;5b4e
	ld a,(0cc92h)		;5b4f
	and a			;5b52
	jr nz,L_5B68		;5b53
	call L_5B96		;5b55   ; desempaqueta la forma de 1 bit de la letra a 4 bits en 0xE800 (con 0xE900 para la mitad de abajo)
	exx			;5b58
	call bancos_1_2_3		;5b59   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld hl,0e800h		;5b5c
	ld bc,01010h		;5b5f
	ld a,008h		;5b62
	call vdp_lmmc		;5b64   ; vdp_lmmc: LMMC: manda al VDP un rectangulo con puntos de HL
	ret			;5b67
L_5B68:
	call L_5BCE		;5b68
	exx			;5b6b
	call bancos_1_2_3		;5b6c   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ld b,d			;5b6f
	ld d,e			;5b70
	ld e,b			;5b71
	srl d		;5b72
	rr e		;5b74
	ld hl,0e800h		;5b76
	ld b,010h		;5b79
L_5B7B:
	push bc			;5b7b
	ld bc,00010h		;5b7c
	call copia_a_vram_hl		;5b7f   ; copia_a_vram_hl: copia BC bytes de HL a la VRAM en DE
	ex de,hl			;5b82
	ld bc,00080h		;5b83
	add hl,bc			;5b86
	ex de,hl			;5b87
	pop bc			;5b88
	djnz L_5B7B		;5b89
	ret			;5b8b
L_5B8C:
	ex de,hl			;5b8c
	ld bc,01010h		;5b8d
	xor a			;5b90
	ld d,a			;5b91
	call vdp_hmmv_2		;5b92   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ret			;5b95
L_5B96:
	ld de,0e800h		;5b96   ; desempaqueta la forma de 1 bit de la letra a 4 bits en 0xE800 (con 0xE900 para la mitad de abajo)
	call L_5B9F		;5b99
	ld de,0e900h		;5b9c
L_5B9F:
	ld b,004h		;5b9f
L_5BA1:
	push bc			;5ba1   ; un bloque de la letra: 4 veces 8 filas, con 8 bytes mas a la derecha cada vez
	push de			;5ba2
	call L_5BAF		;5ba3
	pop de			;5ba6
	ld a,e			;5ba7
	add a,008h		;5ba8
	ld e,a			;5baa
	pop bc			;5bab
	djnz L_5BA1		;5bac
	ret			;5bae
L_5BAF:
	ld a,(0cc91h)		;5baf
	ld c,a			;5bb2
	ld b,008h		;5bb3
L_5BB5:
	push bc			;5bb5
	push hl			;5bb6
	ld h,(hl)			;5bb7
	ld b,008h		;5bb8
L_5BBA:
	ld a,c			;5bba
	rl h		;5bbb
	jr c,L_5BC0		;5bbd
	xor a			;5bbf
L_5BC0:
	ld (de),a			;5bc0   ; guarda el punto en el buffer
	inc de			;5bc1
	djnz L_5BBA		;5bc2
	ld a,e			;5bc4   ; salta al siguiente renglon del buffer (+0x18)
	add a,018h		;5bc5
	ld e,a			;5bc7
	pop hl			;5bc8   ; recupera el origen y avanza a la fila siguiente
	inc hl			;5bc9
	pop bc			;5bca
	djnz L_5BB5		;5bcb   ; repite las ocho filas
	ret			;5bcd
L_5BCE:
	ld de,0e800h		;5bce   ; lo mismo, pero con pares de puntos por byte (se pinta por 0x5BE7)
	call L_5BD7		;5bd1
	ld de,0e880h		;5bd4
L_5BD7:
	ld b,004h		;5bd7
L_5BD9:
	push bc			;5bd9   ; igual para la letra de 4 bits por punto
	push de			;5bda
	call L_5BE7		;5bdb
	pop de			;5bde
	ld a,e			;5bdf
	add a,004h		;5be0
	ld e,a			;5be2
	pop bc			;5be3
	djnz L_5BD9		;5be4
	ret			;5be6
L_5BE7:
	ld a,(0cc91h)		;5be7
	ld c,a			;5bea
	ld b,008h		;5beb
L_5BED:
	push bc			;5bed   ; una fila de la letra: lee el byte y lo despliega
	push hl			;5bee
	ex de,hl			;5bef
	ld a,(de)			;5bf0
	ld d,a			;5bf1
	ld b,004h		;5bf2
L_5BF4:
	ld a,c			;5bf4
	rl d		;5bf5
	jr c,L_5BFA		;5bf7
	xor a			;5bf9
L_5BFA:
	rld		;5bfa
	ld a,c			;5bfc
	rl d		;5bfd
	jr c,L_5C02		;5bff
	xor a			;5c01
L_5C02:
	rld		;5c02   ; rld: mete el nibble
	inc hl			;5c04   ; siguiente byte del buffer
	djnz L_5BF4		;5c05
	ld a,l			;5c07   ; pasa a la fila siguiente (0x0C mas)
	add a,00ch		;5c08
	ld l,a			;5c0a
	ex de,hl			;5c0b
	pop hl			;5c0c   ; recupera el origen y avanza una fila
	inc hl			;5c0d
	pop bc			;5c0e
	djnz L_5BED		;5c0f
	ret			;5c11
L_5C12:
	call bancos_5_6		;5c12   ; prepara la pantalla del titulo (bancos 5-6: paleta de 0xAF80, imagenes de 0xAFD1, 0xB039 y 0xB0A1)
	call pantalla_off		;5c15   ; pantalla_off: apaga la pantalla
	ld hl,0af80h		;5c18
	call pon_colores		;5c1b   ; pon_colores: aplica una lista de colores (A, D, E; 0xFF acaba)
	ld bc,00f07h		;5c1e
	call 00047h		;5c21   ; BIOS WRTVDP - Writes data in the VDP-register
	ld hl,02840h		;5c24   ; rellena el rectangulo del titulo con color 0 (pagina 1)
	ld bc,0a848h		;5c27
	xor a			;5c2a
	ld d,001h		;5c2b
	call vdp_hmmv_2		;5c2d   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld hl,0afd1h		;5c30
	ld de,008b0h		;5c33
	ld bc,00d01h		;5c36
	call L_5238		;5c39
	ld hl,0b039h		;5c3c
	ld de,070b0h		;5c3f
	ld bc,00d02h		;5c42
	call L_5238		;5c45
	ld hl,0b0a1h		;5c48
	ld de,0d8b0h		;5c4b
	ld bc,01a03h		;5c4e
	call L_5238		;5c51
	ld de,04040h		;5c54   ; escribe el texto de HL (0xAF90) a partir de 0x4040: letras en tiles, 0xFE = linea nueva
	ld hl,0af90h		;5c57
	call L_5C92		;5c5a
	call pantalla_on		;5c5d   ; pantalla_on: enciende la pantalla
	ld hl,0c200h		;5c60   ; el contador de la animacion del titulo: 0xC200 = 0x3C, 0xC201 = 0x31, 0xC202 = 0
	ld (hl),03ch		;5c63
	inc hl			;5c65
	ld (hl),031h		;5c66
	inc hl			;5c68
	ld (hl),000h		;5c69
	call bancos_1_2_3		;5c6b   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	ret			;5c6e
L_5C6F:
	ld hl,0c200h		;5c6f   ; un paso de la animacion del titulo: cada dos cuadros se dibuja otra columna del dibujo; al acabar, 0xC202 = 1
	dec (hl)			;5c72
	ld a,(hl)			;5c73
	and 001h		;5c74
	ret nz			;5c76
	inc hl			;5c77
	dec (hl)			;5c78
	jr nz,L_5C81		;5c79
	ld a,001h		;5c7b
	ld (0c202h),a		;5c7d   ; guarda la Y de la ficha en la hoja de tiles
	ret			;5c80
L_5C81:
	ld a,031h		;5c81
	sub (hl)			;5c83
	ld c,a			;5c84
	ld b,0a8h		;5c85
	ld hl,02840h		;5c87
	ld de,02840h		;5c8a
	ld a,001h		;5c8d
	jp vdp_copia		;5c8f   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
L_5C92:
	push de			;5c92
L_5C93:
	ld a,(hl)			;5c93   ; tile del texto: 0xFF acaba, 0xFE baja de linea
	inc hl			;5c94
	ld c,a			;5c95
	inc a			;5c96
	jr z,L_5CB0		;5c97
	inc a			;5c99
	jr nz,L_5CA7		;5c9a
	pop de			;5c9c   ; sale del texto con 0xFE: X mas el desplazamiento
	ld a,(hl)			;5c9d
	inc hl			;5c9e
	add a,d			;5c9f
	ld d,a			;5ca0
	ld a,008h		;5ca1
	add a,e			;5ca3
	ld e,a			;5ca4
	jr L_5C92		;5ca5
L_5CA7:
	ld a,c			;5ca7
	call dibuja_tile_pagina1		;5ca8   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
	call avanza_tile		;5cab   ; avanza_tile: D += 8 (y E += 8 si D da la vuelta)
	jr L_5C93		;5cae
L_5CB0:
	pop de			;5cb0
	ret			;5cb1
L_5CB2:
	ld bc,00007h		;5cb2   ; prepara la pantalla del menu (bancos 10-11): lista 0x9502, tabla 0x94B2
	call 00047h		;5cb5   ; BIOS WRTVDP - Writes data in the VDP-register
	call bancos_10_11		;5cb8   ; bancos_10_11: pone los bancos 10-11 (y sus copias en 0xF0F1-3)
	ld hl,09502h		;5cbb
	ld de,094b2h		;5cbe
	xor a			;5cc1
	call carga_imagen		;5cc2   ; carga_imagen: carga y dibuja una imagen de tiles (HL = lista, DE = tabla de paletas)
	call bancos_1_2_3		;5cc5   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
	call L_59B5		;5cc8
	call bancos_10_11		;5ccb   ; bancos_10_11: pone los bancos 10-11 (y sus copias en 0xF0F1-3)
	ld hl,0a453h		;5cce
	call L_58C9		;5cd1
	jp bancos_1_2_3		;5cd4   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5CD7:
	call bancos_10_11		;5cd7   ; bancos_10_11: pone los bancos 10-11 (y sus copias en 0xF0F1-3)
	ld hl,0a0e9h		;5cda
	call L_58C5		;5cdd   ; dibuja una lista de tiles a pantalla: D,E = posicion, n tiles repetidos (bit 7: la secuencia entera que sigue); 0xFF acaba
	jp bancos_1_2_3		;5ce0   ; bancos_1_2_3: pone los bancos 1-2-3 (y sus copias en 0xF0F1-3)
L_5CE3:
	ld a,(0c01ah)		;5ce3   ; el paso (0xC01A) elige la animacion del titulo
	call despacha		;5ce6   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_5CE9: 6 destinos del despachador p00:4066 (call en p00:5CE6, el
;   indice en A): 5CF5, 5D01, 5D2B, 5D51, 5D6B, 5D8C; lo leen p00:5CE6 (12
;   bytes)
;   0x5ce9..0x5cf5  (12 bytes)
DATA_tabla_5CE9:
	defw 05cf5h,05d01h,05d2bh,05d51h,05d6bh,05d8ch	; 5ce9

; ======================================================================
; CODIGO 0x5cf5..0x5ea5  (432 bytes)
; ======================================================================


L_5CF5:
	call L_5DE5		;5cf5   ; dibuja los dos tiles 0xB1 y 0xB2 en la esquina de la pantalla
	xor a			;5cf8
	ld (0c01ch),a		;5cf9
L_5CFC:
	ld hl,0c01ah		;5cfc   ; apunta a el paso de la animacion del titulo
	inc (hl)			;5cff
	ret			;5d00
L_5D01:
	ld hl,0c01ch		;5d01   ; barrido del titulo: 0xC01C sube de 2 en 2 hasta 0xD0
	push hl			;5d04
	ld a,(hl)			;5d05
	ld hl,00000h		;5d06
	ld de,01860h		;5d09
	add a,d			;5d0c
	ld d,a			;5d0d
	ld bc,00210h		;5d0e
	ld a,028h		;5d11
	call vdp_lmmm		;5d13   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)
	pop hl			;5d16
	inc (hl)			;5d17
	inc (hl)			;5d18
	ld a,(hl)			;5d19
	cp 0d0h		;5d1a
	ret c			;5d1c
	call L_5DB3		;5d1d   ; copia un rectangulo de la pagina 0 a si mismo (borra la franja inferior)
L_5D20:
	xor a			;5d20
	ld b,008h		;5d21
L_5D23:
	ld hl,0c01bh		;5d23
	ld (hl),b			;5d26
	inc hl			;5d27
	ld (hl),a			;5d28
	jr L_5CFC		;5d29
L_5D2B:
	ld hl,0c01bh		;5d2b   ; animacion de la paleta (colores 2, 8 y 9) del titulo: cada 8 cuadros
	dec (hl)			;5d2e
	ret nz			;5d2f
	ld (hl),008h		;5d30
	inc hl			;5d32
	ld a,(hl)			;5d33
	cp 008h		;5d34
	jr nc,L_5D4B		;5d36
	ld d,a			;5d38
	ld e,000h		;5d39
	inc (hl)			;5d3b
	ld a,002h		;5d3c
	call pon_color		;5d3e   ; pon_color: escribe el color D,E en la paleta A
	ld a,008h		;5d41
	call pon_color		;5d43   ; pon_color: escribe el color D,E en la paleta A
	ld a,009h		;5d46
	jp pon_color		;5d48   ; pon_color: escribe el color D,E en la paleta A
L_5D4B:
	ld b,008h		;5d4b
	ld a,007h		;5d4d
	jr L_5D23		;5d4f
L_5D51:
	ld hl,0c01bh		;5d51
	dec (hl)			;5d54
	ret nz			;5d55
	ld (hl),008h		;5d56
	inc hl			;5d58
	ld a,(hl)			;5d59
	inc a			;5d5a
	jr z,L_5D20		;5d5b
	ld d,(hl)			;5d5d
	ld e,000h		;5d5e
	dec (hl)			;5d60
	ld a,002h		;5d61
	call pon_color		;5d63   ; pon_color: escribe el color D,E en la paleta A
	ld a,009h		;5d66
	jp pon_color		;5d68   ; pon_color: escribe el color D,E en la paleta A
L_5D6B:
	ld hl,0c01bh		;5d6b
	dec (hl)			;5d6e
	ret nz			;5d6f
	ld (hl),008h		;5d70
	inc hl			;5d72
	ld a,(hl)			;5d73
	cp 008h		;5d74
	jr nc,L_5D20		;5d76
	rrca			;5d78
	rrca			;5d79
	rrca			;5d7a
	rrca			;5d7b
	and 0f0h		;5d7c
	ld d,a			;5d7e
	ld e,000h		;5d7f
	inc (hl)			;5d81
	ld a,002h		;5d82
	call pon_color		;5d84   ; pon_color: escribe el color D,E en la paleta A
	ld a,009h		;5d87
	jp pon_color		;5d89   ; pon_color: escribe el color D,E en la paleta A
L_5D8C:
	ld hl,0c01bh		;5d8c   ; ultimo paso de la animacion: paleta 2 y luego 13, a 0xFF en 0xC01A al acabar
	dec (hl)			;5d8f
	ret nz			;5d90
	ld (hl),008h		;5d91
	inc hl			;5d93
	ld a,(hl)			;5d94
	cp 005h		;5d95
	jr nc,L_5DA2		;5d97
	ld d,070h		;5d99
	ld e,a			;5d9b
	inc (hl)			;5d9c
	ld a,002h		;5d9d
	jp pon_color		;5d9f   ; pon_color: escribe el color D,E en la paleta A
L_5DA2:
	ld a,00dh		;5da2
	ld de,03706h		;5da4
	call pon_color		;5da7   ; pon_color: escribe el color D,E en la paleta A
	call L_5DC1		;5daa   ; dibuja la lista de tiles de 0x59D9 (el texto del titulo)
	ld a,0ffh		;5dad
	ld (0c01ah),a		;5daf   ; guarda el paso de la animacion del titulo
	ret			;5db2
L_5DB3:
	ld hl,02838h		;5db3   ; copia un rectangulo de la pagina 0 a si mismo (borra la franja inferior)
	ld de,02838h		;5db6
	ld bc,0c040h		;5db9   ; apunta a la tabla de estilo de los ocho rivales (8 bytes cada uno)
	ld a,028h		;5dbc
	jp vdp_lmmm		;5dbe   ; vdp_lmmm: LMMM: copia un rectangulo con operacion logica (A)
L_5DC1:
	ld hl,059d9h		;5dc1   ; dibuja la lista de tiles de 0x59D9 (el texto del titulo)
	jp dibuja_lista_tiles		;5dc4   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
L_5DC7:
	call L_5DE5		;5dc7   ; dibuja los dos tiles 0xB1 y 0xB2 en la esquina de la pantalla
	ld b,01ah		;5dca
	ld de,01860h		;5dcc
L_5DCF:
	push bc			;5dcf
	push de			;5dd0
	ld hl,00000h		;5dd1   ; copia un rectangulo de 8 x 16 desde el origen
	ld bc,00810h		;5dd4
	ld a,028h		;5dd7
	call vdp_lmmm		;5dd9   ; con la operacion 0x28
	pop de			;5ddc
	ld a,d			;5ddd   ; avanza 8 en X y repite
	add a,008h		;5dde
	ld d,a			;5de0
	pop bc			;5de1
	djnz L_5DCF		;5de2
	ret			;5de4
L_5DE5:
	ld a,0b1h		;5de5   ; dibuja los dos tiles 0xB1 y 0xB2 en la esquina de la pantalla
	ld de,00000h		;5de7
	call dibuja_tile_pagina1		;5dea   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
	ld a,0b2h		;5ded
	ld de,00008h		;5def
	jp dibuja_tile_pagina1		;5df2   ; dibuja_tile_pagina1: dibuja el tile A en D,E con la copia de la pagina 1
prepara_partida:		; prepara la pantalla de la partida
	call limpia_pantalla		;5df5   ; PREPARA LA PARTIDA: apaga, SCREEN 7, pone a cero los contadores de la mano y dibuja la mesa y los marcadores
	ld bc,00a07h		;5df8
	call 00047h		;5dfb   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0c0b6h)		;5dfe   ; lee quien reparte en la primera mano
	ld (0c0b7h),a		;5e01   ; guarda el jugador que reparte (0-3)
	xor a			;5e04
	ld (0c0b2h),a		;5e05   ; guarda el viento de la ronda (0 este)
	ld (0c0e3h),a		;5e08
	ld (0c0b3h),a		;5e0b   ; guarda el numero de la mano dentro del viento (0-3)
	ld (0c0b5h),a		;5e0e   ; guarda las barras de honba (BCD)
	ld (0c0b4h),a		;5e11   ; guarda las barras de riichi sobre la mesa (BCD)
	call L_57E3		;5e14   ; vuelca una paleta de los bancos 5-6 (DE = lista)
	call pantalla_off		;5e17   ; pantalla_off: apaga la pantalla
	call dibuja_mesa		;5e1a   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	call 09636h		;5e1d
	call 065c6h		;5e20
	call pantalla_on		;5e23   ; pantalla_on: enciende la pantalla
	call L_570E		;5e26   ; carga las tres columnas de texto de dialogo en 0xC0BF/0xC0BE
	call dibuja_mesa		;5e29   ; dibuja_mesa: carga las fichas y el tapete de los bancos 7-9
	call sprites_fuera		;5e2c   ; sprites_fuera: pone los 32 sprites fuera de pantalla
	call borra_manos		;5e2f   ; borra_manos: borra 4 KB de 0xD000 (las manos)
	ld hl,0c0a1h		;5e32
	ld de,05002h		;5e35
	ld b,004h		;5e38
L_5E3A:
	ld (hl),d			;5e3a
	inc l			;5e3b
	ld (hl),e			;5e3c
	inc l			;5e3d
	inc l			;5e3e
	djnz L_5E3A		;5e3f
	ld a,(0c0b6h)		;5e41   ; lee quien reparte en la primera mano
	ld (0c207h),a		;5e44   ; guarda el jugador al que le toca (0 = el humano)
	call 08e68h		;5e47
	jp 06605h		;5e4a
mano_del_actual:		; HL = la mano del jugador 0xC207 y la guarda en 0xC0DE
	call mano_de_jugador		;5e4d   ; HL = la tabla del jugador actual (0xD000 + 0x400 x 0xC207) y la guarda en 0xC0DE
	ld (0c0deh),hl		;5e50   ; guarda la direccion de la mano del jugador actual y el byte siguiente (16 bits)
	ret			;5e53
mano_de_jugador:		; HL = 0xD000 + 0x400 x 0xC207
	ld hl,0d000h		;5e54   ; HL = 0xD000 + 0x400 x jugador (0xC207)
	ld a,(0c207h)		;5e57   ; lee el jugador al que le toca (0 = el humano)
	add a,a			;5e5a
	add a,a			;5e5b
	add a,h			;5e5c
	ld h,a			;5e5d
	ret			;5e5e
sprites_fuera:		; pone los 32 sprites fuera de pantalla
	ld hl,0cc00h		;5e5f   ; pone todos los sprites fuera de pantalla (Y = 0xE0) en 0xCC00
	ld de,0cc01h		;5e62
	ld bc,0007fh		;5e65
	ld (hl),0e0h		;5e68
	ldir		;5e6a
	ret			;5e6c
borra_manos:		; borra 4 KB de 0xD000 (las manos)
	ld hl,0d000h		;5e6d   ; borra 4 KB de 0xD000 (las manos de los cuatro jugadores)
	ld de,0d001h		;5e70
	ld bc,00fffh		;5e73
	ld (hl),000h		;5e76
	ldir		;5e78
	ret			;5e7a
turno_humano:		; un paso de las respuestas del humano
	call copia_sprites		;5e7b   ; un paso del turno de un jugador: copia sprites, lee el mando y despacha por 0xC217
	call 06146h		;5e7e   ; teclas_a_sonidos: pide el sonido que dicen las teclas de funcion
	ld a,(0c217h)		;5e81   ; lee el paso de las respuestas del humano
	and a			;5e84
	jp nz,L_5E9F		;5e85
	ld a,(0c220h)		;5e88   ; lee 1 si el cuadro de respuestas esta abierto
	and a			;5e8b
	jr nz,L_5E95		;5e8c
	ld a,(0c007h)		;5e8e   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and 002h		;5e91
	jr nz,L_5E99		;5e93
L_5E95:
	call 09217h		;5e95   ; turno_jugador: un paso del turno del jugador 0xC207
	ret			;5e98
L_5E99:
	ld a,(0c207h)		;5e99   ; lee el jugador al que le toca (0 = el humano)
	and a			;5e9c
	jr nz,L_5E95		;5e9d
L_5E9F:
	ld a,(0c217h)		;5e9f   ; lee el paso de las respuestas del humano
	call despacha		;5ea2   ; despacha: salta a la palabra A de la tabla que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_5EA5: 4 destinos del despachador p00:4066 (call en p00:5EA2, el
;   indice en A): 5EAD, 5F45, 5F90, 5FA0; lo leen p00:5EA2 (8 bytes)
;   0x5ea5..0x5ead  (8 bytes)
DATA_tabla_5EA5:
	defw 05eadh,05f45h,05f90h,05fa0h	; 5ea5  -> L_5EAD L_5F45 L_5F90 L_5FA0

; ======================================================================
; CODIGO 0x5ead..0x5fff  (338 bytes)
; ======================================================================


L_5EAD:
	ld a,(0c24ah)		;5ead   ; lee el tiempo que queda de la cara que habla
	and a			;5eb0
	jp z,L_5EB7		;5eb1
	call 0a74fh		;5eb4
L_5EB7:
	ld a,001h		;5eb7
	ld (0c217h),a		;5eb9   ; guarda el paso de las respuestas del humano
	call pide_sonido_03		;5ebc   ; pide_sonido_03: pide el sonido 0x03
	ld a,(0c00fh)		;5ebf   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;5ec2
	jr nz,L_5F05		;5ec3
	ld hl,06478h		;5ec5
	ld de,0a248h		;5ec8
	ld bc,03828h		;5ecb
	ld a,002h		;5ece
	call vdp_copia		;5ed0   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0687eh		;5ed3
	ld bc,0301ch		;5ed6
	ld a,0ffh		;5ed9
	ld d,000h		;5edb
	call vdp_hmmv_2		;5edd   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06478h		;5ee0
	ld hl,00705h		;5ee3
	call 09d1ch		;5ee6
	ld a,(0c214h)		;5ee9   ; lee 1 si las manos se ven boca arriba
	and a			;5eec
	jr z,L_5EF5		;5eed
	ld hl,0610fh		;5eef
	jp L_5EF8		;5ef2
L_5EF5:
	ld hl,060fah		;5ef5
L_5EF8:
	call dibuja_lista_tiles		;5ef8   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	xor a			;5efb
	ld (0c213h),a		;5efc   ; guarda la opcion elegida en el cuadro
	ld a,002h		;5eff
	ld (0c219h),a		;5f01   ; guarda la ultima opcion del cuadro
	ret			;5f04
L_5F05:
	ld hl,06478h		;5f05
	ld de,0a248h		;5f08
	ld bc,03820h		;5f0b
	ld a,002h		;5f0e
	call vdp_copia		;5f10   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,0687eh		;5f13
	ld bc,03014h		;5f16
	ld a,0ffh		;5f19
	ld d,000h		;5f1b
	call vdp_hmmv_2		;5f1d   ; vdp_hmmv_2: HMMV: rellena un rectangulo con el color A (origen HL, D = pagina, tamano BC)
	ld de,06478h		;5f20
	ld hl,00704h		;5f23
	call 09d1ch		;5f26
	ld a,(0c214h)		;5f29   ; lee 1 si las manos se ven boca arriba
	and a			;5f2c
	jr z,L_5F35		;5f2d
	ld hl,06124h		;5f2f
	jp L_5F38		;5f32
L_5F35:
	ld hl,06132h		;5f35
L_5F38:
	call dibuja_lista_tiles		;5f38   ; dibuja_lista_tiles: dibuja una lista de tiles de HL (x, y, tiles; 0xFF acaba)
	xor a			;5f3b
	ld (0c213h),a		;5f3c   ; guarda la opcion elegida en el cuadro
	ld a,001h		;5f3f
	ld (0c219h),a		;5f41   ; guarda la ultima opcion del cuadro
	ret			;5f44
L_5F45:
	call 09a5dh		;5f45   ; espera la respuesta del cuadro de pregunta (0x9A5D): si es la opcion buena (0xC213 = 1), cierra el cuadro y sigue
	ret nc			;5f48
	ld a,(0c213h)		;5f49   ; lee la opcion elegida en el cuadro
	and a			;5f4c
	jr z,L_5F8A		;5f4d
	dec a			;5f4f
	jr nz,L_5F8A		;5f50
	ld a,(0c00fh)		;5f52   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;5f55
	jr nz,L_5F69		;5f56
	ld hl,0a248h		;5f58
	ld de,06478h		;5f5b
	ld bc,03828h		;5f5e
	ld a,001h		;5f61
	call vdp_copia		;5f63   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	jp L_5F77		;5f66
L_5F69:
	ld hl,0a248h		;5f69
	ld de,06478h		;5f6c
	ld bc,03820h		;5f6f
	ld a,001h		;5f72
	call vdp_copia		;5f74   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
L_5F77:
	call L_5FCC		;5f77   ; restaura cuatro bloques del fondo (bajo el cuadro de pregunta) en la pagina 1
	call 06060h		;5f7a   ; cuadro_fichas_que_quedan: dibuja el cuadro de las fichas que quedan
	ld a,0e0h		;5f7d
	ld (0cc00h),a		;5f7f   ; guarda la tabla de atributos de los sprites (32 de 4 bytes)
	ld (0cc04h),a		;5f82
	ld hl,0c217h		;5f85   ; apunta a el paso de las respuestas del humano
	inc (hl)			;5f88
	ret			;5f89
L_5F8A:
	ld hl,0c217h		;5f8a   ; apunta a el paso de las respuestas del humano
	inc (hl)			;5f8d
	inc (hl)			;5f8e
	ret			;5f8f
L_5F90:
	ld a,(0c007h)		;5f90   ; lee las teclas y los mandos pulsados ahora (flancos de subida)
	and a			;5f93
	ret z			;5f94
	call 060b2h		;5f95   ; devuelve_fondo: devuelve a la pagina 0 los cuatro fondos guardados
	call 060ebh		;5f98
	xor a			;5f9b
	ld (0c217h),a		;5f9c   ; guarda el paso de las respuestas del humano
	ret			;5f9f
L_5FA0:
	ld a,(0c00fh)		;5fa0   ; lee la opcion elegida en el menu del titulo (0 o 1)
	and a			;5fa3
	jr nz,L_5FB9		;5fa4
	ld hl,0a248h		;5fa6
	ld de,06478h		;5fa9
	ld bc,03828h		;5fac
	ld a,001h		;5faf
	call vdp_copia		;5fb1   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	xor a			;5fb4
	ld (0c217h),a		;5fb5   ; guarda el paso de las respuestas del humano
	ret			;5fb8
L_5FB9:
	ld hl,0a248h		;5fb9
	ld de,06478h		;5fbc
	ld bc,03820h		;5fbf
	ld a,001h		;5fc2
	call vdp_copia		;5fc4   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	xor a			;5fc7
	ld (0c217h),a		;5fc8   ; guarda el paso de las respuestas del humano
	ret			;5fcb
L_5FCC:
	ld hl,05488h		;5fcc   ; restaura cuatro bloques del fondo (bajo el cuadro de pregunta) en la pagina 1
	ld de,0a248h		;5fcf
	ld bc,05820h		;5fd2
	ld a,002h		;5fd5
	call vdp_copia		;5fd7   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,09858h		;5fda
	ld de,0a268h		;5fdd
	ld bc,05820h		;5fe0
	ld a,002h		;5fe3
	call vdp_copia		;5fe5   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,05428h		;5fe8
	ld de,0a288h		;5feb
	ld bc,05820h		;5fee
	ld a,002h		;5ff1
	call vdp_copia		;5ff3   ; vdp_copia: HMMM: copia un rectangulo de la VRAM (origen HL, destino DE, tamano BC, A = paginas)
	ld hl,01058h		;5ff6
	ld de,0a2a8h		;5ff9
	ld bc,05820h		;5ffc

; ----------------------------------------------------------------------
; DATOS partida_5FFF: los 1 primeros bytes de una instruccion de 2 (3E 02) que
;   sigue en el banco 1: el trazador de un solo banco no puede verla entera
;   (tools/bancos.py); lo leen p00:5FFF (1 bytes)
;   0x5fff..0x6000  (1 bytes)
DATA_partida_5FFF:
	defb 03eh	; 5fff
