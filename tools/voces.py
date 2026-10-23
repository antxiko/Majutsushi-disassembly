#!/usr/bin/env python3
"""Las ocho voces digitales del cartucho (sonidos 0x11-0x18) sacadas de la ROM a WAV de 8 bits.

p12:6265 las reproduce con el DAC del cartucho (p12:62A8, la direccion 0x5000): el valor empieza en
0x80 y cada nibble de la muestra (primero el alto) le suma un salto de la tabla de p12:62D1; la
muestra acaba cuando un byte repite el primero (la marca, p12:628D). La velocidad la fija un bucle
de 0xCF2F vueltas (p12:62AB): con el valor de reposo (3) salen unos 18 kHz.

Uso: voces.py <carpeta de salida> [frecuencia]
"""
import os
import sys
import wave

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DELTAS = [0, 1, 2, 4, 8, 16, 32, 64, 128, 192, 224, 240, 248, 252, 254, 255]
PUNTEROS = [0x9040, 0x94C4, 0x9DA6, 0xA348, 0xA8E1, 0xB373, 0xAE00, 0xB6E2]


def muestras(rom):
    """[(sonido, bytes de la muestra)] con los bancos 13-14 (voces 0x11-0x16) o 15 (0x17-0x18)."""
    b13_14 = rom[13 * 0x2000:15 * 0x2000]          # 0x8000-0xBFFF
    b15 = rom[15 * 0x2000:16 * 0x2000]             # 0xA000-0xBFFF
    out = []
    for i, p in enumerate(PUNTEROS):
        buf, base = (b15, 0xA000) if i >= 6 else (b13_14, 0x8000)
        o = p - base
        marca = buf[o]
        n = 1
        while buf[o + n] != marca:
            n += 1
        out.append((0x11 + i, buf[o + 1:o + n]))
    return out


def a_pcm(datos):
    v = 0x80
    pcm = bytearray()
    for byte in datos:
        for nib in (byte >> 4, byte & 15):
            v = (v + DELTAS[nib]) & 0xFF
            pcm.append(v)
    return bytes(pcm)


def main(argv):
    rom = open(os.path.join(RAIZ, "majutsushi.rom"), "rb").read()
    carpeta = argv[1]
    hz = int(argv[2]) if len(argv) > 2 else 18000
    os.makedirs(carpeta, exist_ok=True)
    for s, d in muestras(rom):
        pcm = a_pcm(d)
        ruta = os.path.join(carpeta, "voz_%02X.wav" % s)
        with wave.open(ruta, "wb") as w:
            w.setnchannels(1)
            w.setsampwidth(1)
            w.setframerate(hz)
            w.writeframes(pcm)
        print("voz 0x%02X: %d bytes, %d puntos, %.2f s a %d Hz, minimo %d maximo %d" % (
            s, len(d), len(pcm), len(pcm) / hz, hz, min(pcm), max(pcm)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
