#!/usr/bin/env python3
"""Lo que tools/anota.py sabe de Hai no Majutsushi: rutinas con nombre, RAM y los
campos de las fichas. Solo datos; la maquinaria esta en anota.py.

CADA ENTRADA SALE DE LEER SU RUTINA en el listado (la direccion es la fuente).
Lo que no se sabe no esta en la tabla.
"""

# Los bancos con codigo (los demas son datos de punta a punta).
BANCOS = (0, 1, 2, 3, 4, 12, 15)

# Los registros del mapper Konami con SCC (tools/paginas.py).
REGISTROS_MAPPER = {0x5000: "0x4000", 0x7000: "0x6000", 0x9000: "0x8000", 0xB000: "0xA000"}


# Que banco se ve en cada ventana al empezar una rutina del banco b: el juego
# corre con 1-2-3, el sonido con 12-13-14 (p00:41D5 y la interrupcion).
def trio(b):
    if b == 0:
        return {}
    if b == 12:
        return {0x6000: 12, 0x8000: 13, 0xA000: 14}
    if b == 4:
        return {0x6000: 1, 0x8000: 2, 0xA000: 4}
    if b == 15:
        return {0x6000: 1, 0x8000: 2, 0xA000: 15}
    return {0x6000: 1, 0x8000: 2, 0xA000: 3}


# Las rutinas del banco 0 que cambian lo que se ve (p00:4207-4258).
CAMBIOS_DE_BANCO = {
    0x4207: {0x6000: 1, 0x8000: 2, 0xA000: 3},
    0x4223: {0xA000: 4},
    0x4228: {0x8000: 5, 0xA000: 6},
    0x422D: {0x6000: 7, 0x8000: 8, 0xA000: 9},
    0x4232: {0x8000: 10, 0xA000: 11},
    0x424B: {0xA000: 15},
    0x4258: {0xA000: 11},
}

RUTINAS = {}
for _a, _r in CAMBIOS_DE_BANCO.items():
    _q = "-".join(str(_r[k]) for k in sorted(_r))
    RUTINAS[(0, _a)] = ("bancos_%s" % _q.replace("-", "_"),
                        "pone %s%s (y sus copias en 0xF0F1-3)" % (
                            "el " if len(_r) == 1 else "los bancos ", _q))

RUTINAS.update({
    (0, 0x4010): ("interrupcion", "el gancho H.KEYI: sonido (bancos 12-13-14) y el cuadro del juego"),
    (0, 0x405C): ("suma_a_hl", "HL = HL + A"),
    (0, 0x4061): ("suma_a_de", "DE = DE + A"),
    (0, 0x4066): ("despacha", "salta a la palabra A de la tabla que va detras del call"),
    (0, 0x4070): ("init", "el arranque del cartucho (INIT)"),
    (0, 0x40C1): ("cartucho_en_8000", "pone el cartucho tambien en 0x8000-0xBFFF (ENASLT)"),
    (0, 0x40E1): ("ranura_del_cartucho", "la ranura del cartucho, en 0xF0F4"),
    (0, 0x41D5): ("pide_sonido", "pide al motor de sonido (p12:6003) el sonido A; pone los bancos 12-13-14 y devuelve los de antes"),
    (0, 0x425D): ("cuadro_del_juego", "un cuadro de la maquina de estados del juego (0xC000, 0xC001)"),
})

RAM = {}
RAM16 = {}
FICHAS = ()

# --- lo que se sabe del juego (tools/anotaciones_juego.py)
from anotaciones_juego import RUTINAS_JUEGO, RAM_JUEGO   # noqa: E402
RUTINAS.update(RUTINAS_JUEGO)
RAM.update(RAM_JUEGO)
