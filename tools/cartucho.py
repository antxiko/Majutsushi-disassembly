#!/usr/bin/env python3
"""Lo que el trazador de cartucho entero (tools/bancos.py) necesita saber de
ESTE cartucho: donde esta el despachador, como cambia de banco y por donde
arranca. bancos.py es maquinaria y no lleva direcciones de ningun juego; las
lee de aqui.

Hai no Majutsushi - Mahjong 2 (Konami, RC-765, 1989), MSX2, mapper Konami
con SCC, 16 bancos de 8 KB. Todo medido sobre los bytes
(tools/reconocimiento.py repasa cada escritura al mapper).
"""

# El despachador de Konami, con la tabla de destinos pegada detras del
# `call`: p00:4066 `pop hl / add a,a / call 405C / ld a,(hl) / inc hl /
# ld h,(hl) / ld l,a / jp (hl)` (el indice llega en A; p00:405C es
# `add a,l / ld l,a / ret nc / inc h / ret`).
DESPACHADOR = 0x4066
DESPACHADORES = (0x4066,)

# Registro del mapper -> casilla del reparto (0x6000, 0x8000, 0xA000).
RANURA_REG = {0x7000: 0, 0x9000: 1, 0xB000: 2}

# Las copias en RAM de los registros: 0xF0F1-0xF0F3.
SOMBRA = {0xF0F1: 0, 0xF0F2: 1, 0xF0F3: 2}
SOMBRA_RANURA = {0: 0, 1: 1, 2: 2}
PONE_ZONA = ()
DEVUELVE_ZONA = ()
# Subrutinas del banco 0 que CAMBIAN de banco y vuelven con `ret` (p00:4207-425B);
# cada una escribe el registro Y su copia en RAM (0xF0F1-3). None = esa ranura
# no la toca. Los bancos 1-4 y 15 tienen el codigo; 5-11 y 13-14, datos.
PONE_BANCOS = {0x4207: (1, 2, 3), 0x4223: (None, None, 4), 0x4228: (None, 5, 6),
               0x422D: (7, 8, 9), 0x4232: (None, 10, 11), 0x4246: (13, 14, 15),
               0x424B: (None, None, 15), 0x4258: (None, None, 11)}
NO_TOCAN_A = ()
NO_TOCAN_HL = ()

# Para tools/reconocimiento.py (se rellena con lo que se mida).
RUTINAS_BANCO = {}
RUTINAS_BANCO_MAS = {}
LLAMADAS_AJENAS = {(1, 0x6260), (1, 0x6284), (1, 0x62B7), (1, 0x62E3),
                   (1, 0x6310), (1, 0x6334), (1, 0x6367), (1, 0x6393),
                   (1, 0x63BB)}   # `call 0x8000` a la ROM de disco (p01:6260...)

# Los bancos que llevan codigo y el reparto con el que corre.
CODIGO = {0: (1, 2, 3), 1: (1, 2, 3), 2: (1, 2, 3), 3: (1, 2, 3), 4: (1, 2, 4), 12: (12, 13, 14), 15: (1, 2, 15)}


def semillas_iniciales(rom):
    """Los dos unicos puntos de entrada que el hardware garantiza.

    - INIT de la cabecera "AB" (0x4070): lo llama la BIOS al arrancar, con el
      mapper en su estado de encendido (bancos 1, 2 y 3).
    - 0x4010: lo que INIT instala en el gancho H.KEYI (0xFD9F), p00:40AF.
    """
    init = rom[2] | (rom[3] << 8)
    return [(init, (1, 2, 3), "cabecera AB: INIT"),
            (0x4010, (1, 2, 3),
             "gancho de interrupcion H.KEYI: INIT escribe 0xC3 en 0xFD9F y esta"
             " direccion en 0xFDA0 (p00:40AF-p00:40B7)")]
