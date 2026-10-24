#!/usr/bin/env python3
"""La musica de Hai no Majutsushi (PSG), ejecutando su motor de sonido (tools/motor_musica.py).

El arranque (p00:409E -> p00:558C) llama a p12:6000 con los bancos 12-13-14; `pide_sonido`
(p00:41D5) pone los mismos bancos y llama a p12:6003 con el numero en A; cada cuadro la
interrupcion (p00:4020) los pone y llama a p12:6006, que lleva cinco canales (0xCE00 + 0x2C x k)
y su estado comun en 0xCF08-0xCF2F. Los sonidos 0x11-0x18 son las voces del DAC (tools/voces.py).

Uso:  musica.py registros 0x09 [cuadros] | mp3 0x09 f.mp3 | todas docs/audio | barrido 0x01 0x10
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

BANCOS = ((0x4000, 0), (0x6000, 12), (0x8000, 13), (0xA000, 14))
# Quien pide cada sonido (las llamadas a p00:40FD-4148 y las teclas de funcion de p01:6146).
PIEZAS = [
    P(0x09, "Los menús (y la tecla F4 en la partida)", "The menus (and the F4 key during play)", "p00:42BD, p00:49D7"),
    P(0x0A, "Los menús de ajustes (y la tecla F5)", "The settings menus (and the F5 key)", "p00:4369, p00:4888"),
    P(0x0C, "La partida: la música de serie (y la tecla F2)", "The game: the default tune (and the F2 key)", "p00:44A4"),
    P(0x0B, "La partida: la tecla F3", "The game: the F3 key", "p01:616D"),
    P(0x0D, "Gana el jugador", "The player wins", "p00:457E"),
    P(0x0E, "Gana un rival", "A rival wins", "p00:4581, p00:4907"),
    P(0x0F, "La mano se acaba sin ganador", "The hand ends with no winner", "p00:48F3"),
    P(0x10, "El cuadro de p00:473E (estado 5, paso 6)", "The box of p00:473E (state 5, step 6)", "p00:475D"),
    P(0x03, "Se abre un cuadro de pregunta", "A question box opens", "p00:5EBC, p02:949A, p02:97AE"),
    P(0x04, "Se tira una ficha", "A tile is discarded", "p02:8D49"),
    P(0x05, "Los dados", "The dice", "p02:8F0B, p02:8F53"),
    P(0x06, "El cursor", "The cursor", "p00:43AC, p02 (4), p03 (6)"),
    P(0x07, "Se elige", "A choice is made", "p00:43D3, p03 (5)"),
    P(0x08, "Se reparten las fichas", "Tiles are dealt", "p02:8AED"),
]


def ejecuta(cfg, rom, numero, maximo=None):
    """Como motor_musica.ejecuta, pero la vuelta se busca por la posicion de los tres canales de
    musica (puntero, contador de la nota, contadores de repeticion y retorno: ix+0, ix+2..ix+8),
    no por toda la RAM del motor, que lleva contadores que nunca se repiten."""
    maximo = maximo or cfg.get("hz", 60) * cfg.get("max_s", 300)
    z = motor_musica.arranca(cfg, rom, numero)
    cuadros, vistos = [], {}
    for n in range(maximo):
        cuadros.append(motor_musica.cuadro(z))
        clave = bytes(z.mem[0xCE00 + 0x2C * c + k] for c in range(5) for k in (0, 2, 3, 4, 5, 6, 7, 8))
        if not any(z.mem[0xCE00 + 0x2C * c] for c in range(5)):
            return cuadros, None                 # todos los canales acabados
        if clave in vistos:
            return cuadros, vistos[clave]
        vistos[clave] = n + 1
    return cuadros, None


motor_musica.ejecuta = ejecuta

CFG = dict(rom="majutsushi.rom", org=0x4000, mapper="konami_scc",
           bancos0=BANCOS, bancos_frame=BANCOS[1:],
           init=[(0x6000, {})], frame=0x6006, pide=0x6003,
           ram=(0xCE00, 0xCF30), excluye=(0xCF18, 0xCF19), hz=60, max_s=240,
           sp=0xF000, piezas=PIEZAS)

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
