#!/usr/bin/env python3
"""Lo que el cartucho LEE al jugar, medido con openMSX (tools/omsx_leido.tcl), contra los bloques de
datos declarados en src/pNN.notes.

Cada fichero de lecturas trae una linea por byte leido: "banco:direccion pc" (la primera vez). Solo
se vigilan los bancos de datos (5-11, 13, 14 y 15): los de codigo se leen a cada instruccion.

Uso: cobertura_leido.py work/cobA/leido.txt [mas ficheros...]
     imprime, por banco, cuantos bytes de datos se han visto leer y que bloques D no se han tocado.
"""
import os
import re
import sys
from collections import defaultdict

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BANCOS = (5, 6, 7, 8, 9, 10, 11, 13, 14, 15)


def leidos(ficheros):
    s = defaultdict(set)
    for f in ficheros:
        for ln in open(f, encoding="utf-8"):
            m = re.match(r"(\d+):([0-9A-F]{4})", ln)
            if m:
                s[int(m.group(1))].add(int(m.group(2), 16))
    return s


def bloques(p):
    out = []
    for ln in open(os.path.join(RAIZ, "src", "p%02d.notes" % p), encoding="utf-8"):
        if ln.startswith("D "):
            q = ln.split(None, 4)
            out.append((int(q[1], 0), int(q[2], 0), q[3]))
    return sorted(out)


def main(argv):
    s = leidos(argv[1:])
    total_d = total_l = 0
    for p in BANCOS:
        bl = bloques(p)
        datos = sum(f - i for i, f, _ in bl if not n_es_relleno(_))
        vistos = len([a for a in s[p] if any(i <= a < f for i, f, n in bl if not n_es_relleno(n))])
        total_d += datos
        total_l += vistos
        sin = [(i, f, n) for i, f, n in bl if not any(i <= a < f for a in s[p]) and not n_es_relleno(n)]
        relleno = len([a for a in s[p] if any(i <= a < f for i, f, n in bl if n_es_relleno(n))])
        print("p%02d: %5d de %5d bytes de datos leidos (%.1f %%); %d bloques sin tocar de %d; %d lecturas en relleno" % (
            p, vistos, datos, 100.0 * vistos / max(datos, 1), len(sin), len(bl), relleno))
        for i, f, n in sin[:12]:
            print("      sin tocar %04X-%04X %s (%d bytes)" % (i, f, n, f - i))
    print("total: %d de %d bytes de datos (%.1f %%)" % (total_l, total_d, 100.0 * total_l / max(total_d, 1)))
    return 0


def n_es_relleno(n):
    return n.startswith("relleno")


if __name__ == "__main__":
    sys.exit(main(sys.argv))
