#!/usr/bin/env python3
"""Lo que se ha MEDIDO de Hai no Majutsushi, clavado para que no se deshaga solo.

Necesitan la ROM, y si no esta FALLAN (un test que se salta no comprueba nada). Cada una lee el
binario y, las de los yaku, EJECUTAN el codigo del cartucho (tools/prueba_yaku.py).
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG   # noqa: E402

ROM = os.path.join(RAIZ, "majutsushi.rom")
SHA = "7839c843dc787e01765c1ba3efbd26dcf5209d27e38bcee1345db3b3cffdf5db"
FALTA = ("falta majutsushi.rom en la raiz del repo: son los 131.072 bytes de Hai no Majutsushi - "
         "Mahjong 2 (Konami, RC-765, 1989, MSX2) y no se distribuyen aqui. El sha256 tiene que ser %s" % SHA)


def leer_rom():
    if not os.path.exists(ROM):
        raise AssertionError(FALTA)
    return open(ROM, "rb").read()


def b(rom, banco, a, n=1):
    o = banco * 0x2000 + (a - ORG[banco])
    return rom[o:o + n]


def w(rom, banco, a):
    x = b(rom, banco, a, 2)
    return x[0] | x[1] << 8


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.rom = leer_rom()

    def test_sha256(self):
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)
        self.assertEqual(len(self.rom), 16 * 0x2000)

    def test_cabecera_ab_e_init(self):
        self.assertEqual(self.rom[:2], b"AB")
        self.assertEqual(self.rom[2] | self.rom[3] << 8, 0x4070)

    def test_el_despachador_de_konami(self):
        # pop hl / add a,a / call 0x405C / ld a,(hl) / inc hl / ld h,(hl) / ld l,a / jp (hl)
        self.assertEqual(b(self.rom, 0, 0x4066, 10).hex(), "e187cd5c407e23666fe9")

    def test_la_interrupcion_llama_al_sonido_con_los_bancos_12_13_14(self):
        # ld a,0x0C / ld (0x7000),a / inc a / ld (0x9000),a / inc a / ld (0xB000),a / call 0x6006
        esperado = bytes.fromhex("3e0c320070 3c320090 3c3200b0 cd0660".replace(" ", ""))
        self.assertEqual(b(self.rom, 0, 0x4020, len(esperado)), esperado)

    def test_la_baraja_son_136_fichas_de_34_clases(self):
        # p15:A2A8: ld b,0x88 y cada ficha sale de A2C5 (A 1-9, 0x11-0x19, 0x21-0x29, 0x31-0x37)
        self.assertEqual(b(self.rom, 15, 0xA2A8, 2).hex(), "0688")
        self.assertEqual(b(self.rom, 15, 0xA2C8, 2).hex(), "d621")   # sub 0x21: 33 numeros + 1

    def test_las_ocho_voces_digitales(self):
        marcas = {}
        punt = [w(self.rom, 12, 0x6065 + 2 * i) for i in range(8)]
        self.assertEqual(punt, [0x9040, 0x94C4, 0x9DA6, 0xA348, 0xA8E1, 0xB373, 0xAE00, 0xB6E2])
        largos = (1156, 2274, 1442, 1433, 2706, 2056, 2274, 2334)
        # los bancos 13 y 14 seguidos (voces 0 a 5) y el 15 (6 y 7)
        mem13_14 = self.rom[13 * 0x2000:15 * 0x2000]
        mem15 = self.rom[15 * 0x2000:16 * 0x2000]
        for i, p in enumerate(punt):
            buf, base = (mem15, 0xA000) if i >= 6 else (mem13_14, 0x8000)
            o = p - base
            m = buf[o]
            n = 1
            while o + n < len(buf) and buf[o + n] != m:
                n += 1
            marcas[i] = n + 1
            self.assertEqual(n + 1, largos[i], "voz %d" % i)

    def test_la_tabla_de_deltas_de_la_voz(self):
        self.assertEqual(b(self.rom, 12, 0x62D1, 16).hex(), "000102040810204080c0e0f0f8fcfeff")

    def test_los_periodos_base_del_psg(self):
        self.assertEqual(b(self.rom, 12, 0x63F8, 12).hex(), "6a645e59544f4a46423f3b38")

    def test_las_filas_de_sonido_acaban_donde_acaba_la_tabla(self):
        a = 0x61E2
        for n in range(16):
            fl = b(self.rom, 12, a)[0]
            canales = bin(fl).count("1")
            a += 2 + 2 * canales
            self.assertEqual(w(self.rom, 12, 0x61B2 + 2 * n), a - 2 - 2 * canales)
        self.assertEqual(a, 0x6254)

    def test_las_manos_estan_cada_0x400_en_la_ram(self):
        # p02:85D8: ld a,(0xC20D) / add a,a / add a,a / add a,h / ld h,a / ret
        self.assertEqual(b(self.rom, 2, 0x85D8, 8).hex(), "3a0dc28787846 7c9".replace(" ", ""))


class Yaku(unittest.TestCase):
    """El analisis de manos del cartucho ejecutado sobre manos puestas a mano."""

    @classmethod
    def setUpClass(cls):
        leer_rom()
        from prueba_yaku import Mesa
        cls.Mesa = Mesa

    def codigos(self, mano, ficha, **kw):
        m = self.Mesa()
        m.pon_mano(mano, ficha, **kw)
        m.analiza()
        return dict(m.yakus())

    def test_ittsu_y_tsumo(self):
        y = self.codigos([1, 2, 3, 4, 5, 6, 7, 8, 9, 0x11, 0x12, 0x25, 0x25], 0x13)
        self.assertEqual(y.get(0x04), 1)       # robo con la mano cerrada
        self.assertEqual(y.get(0x10), 2)       # 123 456 789 del mismo palo

    def test_siete_parejas(self):
        y = self.codigos([0x08, 0x08, 0x16, 0x23, 0x23, 0x24, 0x24, 0x27, 0x27, 0x29, 0x29, 0x34, 0x34], 0x16)
        self.assertEqual(y.get(0x0D), 2)

    def test_sanshoku_doujun(self):
        y = self.codigos([1, 2, 3, 0x11, 0x12, 0x13, 0x21, 0x21, 0x21, 0x22, 0x23, 0x32, 0x32], 0x21)
        self.assertEqual(y.get(0x11), 2)

    def test_tanyao(self):
        y = self.codigos([5, 5, 5, 0x14, 0x14, 0x14, 0x15, 0x16, 0x16, 0x16, 0x22, 0x22, 0x22], 0x16)
        self.assertEqual(y.get(0x05), 1)

    def test_cuatro_tripletes_cerrados_es_limite(self):
        y = self.codigos([3, 3, 6, 6, 6, 8, 8, 8, 0x16, 0x16, 0x32, 0x32, 0x32], 0x16)
        self.assertEqual(y, {0x20: 0x81})

    def test_renhou_es_limite(self):
        y = self.codigos([1, 2, 3, 3, 4, 5, 5, 5, 0x17, 0x17, 0x17, 0x27, 0x27], 0x27, robo=False)
        self.assertEqual(y.get(0x2B), 0x81)


if __name__ == "__main__":
    unittest.main()
