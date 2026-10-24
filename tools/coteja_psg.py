#!/usr/bin/env python3
"""Coteja una musica de tools/musica.py con el PSG de openMSX (tools/omsx_psg.tcl).

openMSX da los 14 registros en cada cuadro; el motor ejecutado da las escrituras de cada cuadro.
Se acumulan las escrituras en un estado y se busca el desfase con el que mas cuadros coinciden en
los registros de tono (0-5) y volumen (8-10), con la vuelta de la pieza ya desarrollada.

Uso: coteja_psg.py work/psg.txt 0x09
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
import musica  # noqa: E402

REGS = (0, 1, 2, 3, 4, 5, 8, 9, 10)


def estados_motor(n, cuadros_min):
    rom = open(os.path.join(motor_musica.RAIZ, musica.CFG["rom"]), "rb").read()
    cuadros, vuelta = musica.ejecuta(musica.CFG, rom, n)
    seq = list(cuadros)
    while vuelta is not None and len(seq) < cuadros_min:
        seq += cuadros[vuelta:]
    estado, out = [0] * 16, []
    for escr in seq:
        for r, v in escr:
            estado[r] = v
        out.append(tuple(estado[r] for r in REGS))
    return out


def estados_omsx(fichero):
    out = []
    for ln in open(fichero):
        q = [int(x, 16) for x in ln.split()]
        if len(q) == 14:
            out.append(tuple(q[r] for r in REGS))
    return out


def main(argv):
    o = estados_omsx(argv[1])
    m = estados_motor(int(argv[2], 0), len(o) + 4000)
    primero = next(k for k in range(len(o)) if any(o[k][6:]))   # el primer cuadro que suena
    mejor = (0, 0, 0, 0)
    for desde_o in range(primero, primero + 4):
        for desde_m in range(0, min(len(m), 300)):
            n = min(len(o) - desde_o, len(m) - desde_m)
            iguales = sum(1 for k in range(n) if o[desde_o + k] == m[desde_m + k])
            if iguales > mejor[0]:
                mejor = (iguales, desde_o, desde_m, n)
    iguales, desde_o, desde_m, n = mejor
    print("0x%s: %d de %d cuadros iguales (%.1f %%), openMSX desde el cuadro %d, motor desde el %d" % (
        argv[2][2:].upper(), iguales, n, 100.0 * iguales / max(n, 1), desde_o, desde_m))
    malos = [k for k in range(n) if o[desde_o + k] != m[desde_m + k]][:5]
    for k in malos:
        print("  cuadro %d: openMSX %s motor %s" % (k, o[desde_o + k], m[desde_m + k]))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
