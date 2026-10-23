#!/usr/bin/env python3
"""Comenta, en las rutinas de ordenes del VDP de p00, cada `out (c),x` con el registro del V9938 que
escribe: la primera escritura va a R#17 (indice de registro) y las siguientes, por el puerto 0x9B, a
R#32.. o R#36.. consecutivos. Escribe lineas 'p00 0xDIR texto' en work/c_p00_vdp.txt (para mete_c.py).
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
NOM = {32: "SX bajo", 33: "SX alto", 34: "SY bajo", 35: "SY alto", 36: "DX bajo", 37: "DX alto",
       38: "DY bajo", 39: "DY alto", 40: "NX bajo", 41: "NX alto", 42: "NY bajo", 43: "NY alto",
       44: "CLR (color o dato)", 45: "ARG (direccion y memoria)", 46: "CMD (la orden)"}
RUT = {0x4F18: 36, 0x4F64: 36, 0x4FE5: 36, 0x5028: 32, 0x5074: 36, 0x50E1: 32, 0x5151: 32}


def main():
    ls = []
    for ln in open(os.path.join(RAIZ, "src", "majutsushi_p00.asm"), encoding="utf-8"):
        m = re.match(r"^\t([^;]*?)\s*;([0-9a-f]{4})", ln)
        if m:
            ls.append((int(m.group(2), 16), re.sub(r"\s+", " ", m.group(1).strip())))
    out = []
    pos = {a: i for i, (a, _) in enumerate(ls)}
    for ini, reg0 in RUT.items():
        i = pos[ini]
        reg, puerto_datos = reg0, False
        k = 0
        while i < len(ls):
            a, ins = ls[i]
            if ins == "inc c" and k >= 0:
                pass
            if re.match(r"out \(c\),", ins):
                if puerto_datos:
                    nom = NOM.get(reg, "R#%d" % reg)
                    out.append("p00 0x%04X al VDP: R#%d, %s" % (a, reg, nom))
                    reg += 1
                else:
                    k += 1
                    out.append("p00 0x%04X al puerto de control: %s" % (
                        a, "el numero del primer registro que se va a escribir (el valor de R#17)" if k == 1 else "selecciona R#17 (registro de indice, con auto-incremento)"
                        if k == 2 else "otro dato de control"))
            if ins == "inc c":
                puerto_datos = True if puerto_datos is False and k >= 2 else puerto_datos
            if ins == "dec c":
                puerto_datos = False
            if ins == "ret":
                break
            i += 1
    open(os.path.join(RAIZ, "work", "c_p00_vdp.txt"), "w", encoding="utf-8").write("\n".join(out) + "\n")
    print(len(out), "comentarios")


if __name__ == "__main__":
    main()
