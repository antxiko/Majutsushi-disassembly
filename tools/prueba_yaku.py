#!/usr/bin/env python3
"""Prueba el analisis de yaku del cartucho ejecutando su codigo (p01:6CD5) sobre manos puestas a mano
en la RAM, con tools/msx2run.py (Z80 + mapper). Sirve para medir que codigo de yaku (0xC2E0) sale de
cada mano y no suponerlo.

Uso como modulo:
    from prueba_yaku import Mesa
    m = Mesa(); m.pon_mano([...13 fichas...], ficha, robo=True); print(m.yakus())
Fichas: 0x01-0x09 (palo 0), 0x11-0x19 (palo 1), 0x21-0x29 (palo 2), 0x31-0x34 vientos, 0x35-0x37 dragones.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
from msx2run import Msx   # noqa: E402

RAIZ = os.path.dirname(AQUI)


class Mesa(Msx):
    def __init__(self):
        rom = open(os.path.join(RAIZ, "majutsushi.rom"), "rb").read()
        super().__init__(rom, True)
        self.tolera_bios = True
        for v, b in ((0x6000, 1), (0x8000, 2), (0xA000, 3)):
            self.pon_banco(v, b)
        # las opciones de reglas por defecto (p15:A19C -> 0xC020)
        d = rom[15 * 0x2000 + 0x19C: 15 * 0x2000 + 0x19C + 10]
        for i, x in enumerate(d):
            self.mem[0xC020 + i] = x
        self.mem[0xF0F1:0xF0F4] = bytes((1, 2, 3))

    def w(self, a, v):
        self.mem[a] = v & 0xFF

    def pon_mano(self, mano, ficha, robo=True, riichi=False, cerrada=True, jugador=0, viento_ronda=0,
                 reparte=1, quedan=0x40):
        mano = sorted(mano)
        base = 0xD000 + 0x400 * jugador
        for i in range(0x400):
            self.mem[base + i] = 0
        for i, x in enumerate(mano):
            self.mem[base + i] = x
        self.mem[base + 0x34] = 0xFF if riichi else 0
        self.w(0xC207, jugador)
        self.w(0xC20D, jugador)
        self.w(0xC209, ficha)
        self.w(0xC0B1, 1 if robo else 2)
        self.w(0xC0B2, viento_ronda)
        self.w(0xC0B7, reparte)
        self.w(0xC1C1, quedan)
        self.w(0xC0DE, base & 255)
        self.w(0xC0DF, base >> 8)
        self.w(0xCD5C, base & 255)
        self.w(0xCD5D, base >> 8)
        self.w(0xCD9E, 0)
        self.w(0xCD99, 0)
        self.w(0xCDA1, 0)
        self.w(0xCD9B, 0)
        for i in range(0x40):
            self.mem[0xC2E0 + i] = 0

    def analiza(self):
        self.pon_banco(0x6000, 1)
        self.pon_banco(0x8000, 2)
        self.pon_banco(0xA000, 3)
        self.llama(0x6CD5)

    def yakus(self):
        out = []
        k = 0xC2E0
        while self.mem[k] and k < 0xC320:
            out.append((self.mem[k], self.mem[k + 1]))
            k += 2
        return out


if __name__ == "__main__":
    m = Mesa()
    # 123 456 789 de palo 0, 123 del palo 1 y pareja de 5 del palo 2; espera el 3 del palo 1 (robo, cerrada)
    mano = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0x11, 0x12, 0x25, 0x25]
    m.pon_mano(mano, 0x13)
    m.analiza()
    print(m.yakus())
