#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

Hai no Majutsushi - Mahjong 2 (Konami, RC-765, 1989) es un cartucho de 128 KB
con el mapper Konami CON SCC: 16 bancos de 8 KB que se eligen escribiendo el
numero de banco en 0x5000 (0x4000-0x5FFF), 0x7000 (0x6000-0x7FFF), 0x9000
(0x8000-0x9FFF) y 0xB000 (0xA000-0xBFFF). El banco 0 se queda fijo en 0x4000.

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez).

Uso como programa:
    paginas.py org <n>               imprime el org del banco n
    paginas.py lista                 imprime "n org" para los 16
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada banco
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16

# banco -> direccion de ejecucion. Medido, no supuesto: ver reconocimiento.py.
_R6, _R8, _RA = 0x6000, 0x8000, 0xA000
ORG = {0: 0x4000,
       1: _R6, 2: _R8, 3: _RA,
       4: _RA, 5: _R8, 6: _RA,
       7: _R6, 8: _R8, 9: _RA,
       10: _R8, 11: _RA,
       12: _R6, 13: _R8, 14: _RA,
       15: _RA}

# Registro del mapper -> ranura que gobierna (Konami con SCC).
REGISTROS = {0x5000: 0x4000, 0x7000: 0x6000, 0x9000: 0x8000, 0xB000: 0xA000}

# Los registros del OTRO mapper Konami: tienen que estar a cero.
AJENOS = (0x6000, 0x8000, 0xA000)

# Escrituras a un registro ajeno (banco, pc del `ld (nn),a`):
#  - p01:6257..63B2 (9): el cargador/grabador de partidas en DISCO. Busca una
#    ROM de disco que lleve "YZ"? en su 0x4010 (p01:61C2), la pone en la pagina 2
#    con ENASLT (0x0024), escribe un 4 en SU 0x8000 y la llama en 0x8000
#    (p01:6260...). Es el codigo del otro slot, no el nuestro.
#  - p12:6055, 6060, 627C, 62EC: 0x0E/0x0F en 0xA000 alrededor de la
#    reproduccion del PCM; 0xA000 no es registro de banco en este mapper.
OTRO_SLOT = {(1, 0x6257), (1, 0x627B), (1, 0x62AE), (1, 0x62DA), (1, 0x6307),
             (1, 0x632B), (1, 0x635E), (1, 0x638A), (1, 0x63B2),
             (12, 0x6055), (12, 0x6060), (12, 0x627C), (12, 0x62EC)}

# Valores escritos en un registro que no son un banco: (registro, valor).
NO_BANCO = {}

# Escrituras al mapper que ponen un banco fuera de su ranura, medidas en
# reconocimiento.py: (banco, pc de la escritura) -> ranura.
# p00:4246 (`push af / ld a,13 / jr 420A`) pondria 13-14-15 en 6000-A000, pero
# nadie la llama (ni `call`, ni `jp`, ni una tabla): codigo muerto.
EXCEPCIONES = {(13, (0, 0x4210)): 0x6000, (14, (0, 0x4216)): 0x8000}

NUNCA_MAPEADOS = ()


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p31."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("%d bancos de %d bytes en %s/" % (N_PAGINAS, TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
