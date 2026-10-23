#!/usr/bin/env python3
"""Los lectores de datos de Hai no Majutsushi y sus formatos, para tools/bloques.py.

Cada recorredor hace con los bytes lo mismo que la rutina del cartucho que lo
lee, y devuelve donde acaba. Las rutinas, con su direccion en NUESTRO listado
(todas en el banco 0, fijo en 0x4000).
"""
import bloques as B

V789 = (7, 8, 9)        # p00:422D
V1011 = (None, 10, 11)  # p00:4232
V56 = (None, 5, 6)      # p00:4228


def ventana(trio):
    return B.Ventana((trio[0] if trio[0] is not None else 1, trio[1], trio[2]))


# ------------------------------------------------------------------ RLE
#
# p00:4E2D vuelca a la VRAM (desde HL) lo que lee en DE: 0 acaba; n de 1 a
# 0x7F repite n veces el byte de detras; 0x80 trae detras una direccion de
# VRAM nueva (dos bytes); 0x81-0xFF copian tal cual los n & 0x7F bytes de
# detras.

def rle(v, a):
    while True:
        x = v(a)
        a += 1
        if x == 0:
            return a
        if x < 0x80:
            a += 1
        elif x == 0x80:
            a += 2
        else:
            a += x & 0x7F


# ------------------------------------------------------------------ listas
#
# p00:4EDC aplica una lista de colores: la direccion del registro de paleta,
# dos bytes de color; acaba en un registro 0xFF.

def colores(v, a):
    while v(a) != 0xFF:
        a += 3
    return a + 1


# p00:5C92 escribe un texto de tiles: un tile por byte; 0xFE y un
# desplazamiento en X ponen otra linea; 0xFF acaba.

def texto_tiles(v, a):
    while True:
        x = v(a)
        a += 1
        if x == 0xFF:
            return a
        if x == 0xFE:
            a += 1


# p00:5369 dibuja una lista de tiles: X, Y y los tiles; 0xFE trae otro X, Y; 0xFF acaba.

def lista_tiles(v, a):
    a += 2
    while True:
        x = v(a)
        a += 1
        if x == 0xFF:
            return a
        if x == 0xFE:
            a += 2


# p00:58C5 y p00:58C9 dibujan una lista: X, Y y despues bloques hasta 0xFF; un bloque
# con el bit 7 puesto trae n & 0x7F tiles detras; si no, n y un solo tile que se repite.

def lista_bloques(v, a):
    a += 2
    while True:
        x = v(a)
        if x == 0xFF:
            return a + 1
        if x & 0x80:
            a += 1 + (x & 0x7F)
        else:
            a += 2


# p00:576A: letras de 3 x 3 tiles (9 bytes) o de 5 x 2 (10 bytes) segun 0xC0BE;
# 0xFE pasa a la linea siguiente; 0xFF acaba.

def dialogo(modo):
    paso = 10 if modo else 9

    def recorre(v, a):
        while True:
            x = v(a)
            a += 1
            if x == 0xFF:
                return a
            if x != 0xFE:
                a += paso - 1
    return recorre


# ------------------------------------------------------------ imagenes (p00:5911)
#
# p00:5911 dibuja una imagen: HL = lista de entradas de 6 bytes (formato, paleta,
# tile destino, cuantos tiles, puntero a los dibujos) hasta un 0xFF; DE = tabla de
# palabras con las paletas. El formato (bits 0-2) es los bits por punto (8, 16 o 24
# bytes por tile: p00:53F8, 5451, 54B2) y su tamano de paleta es 2, 4 u 8 colores.

BYTES_TILE = {0: 8, 1: 8, 2: 16, 3: 16, 4: 24, 5: 24, 6: 24, 7: 24}
BYTES_PALETA = {0: 2, 1: 2, 2: 4, 3: 4, 4: 8, 5: 8, 6: 12, 7: 12}


def imagen(v, lista_a, tabla_a, sitios):
    k = lista_a
    n_pal = 0
    pals = {}
    while v(k) != 0xFF:
        c, idx, cuantos, src = v(k), v(k + 1), v(k + 3), v.w(k + 4)
        n_pal = max(n_pal, idx + 1)
        pals[idx] = max(pals.get(idx, 0), BYTES_PALETA[c & 7])
        B.declara(v, src, src + cuantos * BYTES_TILE[c & 7], "tiles_%04X" % src,
                  "los dibujos de %d tiles de una entrada de la imagen %04X de p00:5911: %s por tile, "
                  "tiles de %d bits por punto (p00:5949)" % (
                      cuantos, lista_a, BYTES_TILE[c & 7], 1 if (c & 7) < 2 else (2 if (c & 7) < 4 else 3)),
                  sitios, F=BYTES_TILE[c & 7])
        k += 6
    B.declara(v, lista_a, k + 1, "imagen_%04X" % lista_a,
              "lista de la imagen de p00:5911: entradas de 6 bytes (formato, numero de paleta, tile "
              "destino, cuantos tiles, puntero a sus dibujos) y 0xFF", sitios, F=6)
    if n_pal:
        B.declara(v, tabla_a, tabla_a + 2 * n_pal, "paletas_%04X" % tabla_a,
                  "las %d palabras que apuntan a las paletas de la imagen %04X (p00:5911: palabra A de la "
                  "tabla)" % (n_pal, lista_a), sitios, F="w8")
        punt = sorted({v.w(tabla_a + 2 * i) for i in range(n_pal)})
        for idx in range(n_pal):
            p = v.w(tabla_a + 2 * idx)
            tam = pals.get(idx)
            nota = ""
            sig = [x for x in punt if x > p]
            hasta = min(sig[0] - p, 12) if sig else None
            if tam is None:
                # una paleta que ninguna entrada de esta lista pide: llega hasta la siguiente
                tam = hasta or 12
                nota = " (ninguna entrada de la lista la pide: su tamano es hasta la siguiente)"
            elif hasta and hasta > tam:
                nota = " (las entradas que la piden copian %d bytes; el resto, hasta la siguiente paleta, "                        "es de otro formato de la misma tabla)" % tam
                tam = hasta
            B.declara(v, p, p + tam, "paleta_%04X" % p,
                      "la paleta %d de la imagen %04X: %d bytes de colores que se copian a 0xE800 "
                      "(p00:592F)%s" % (idx, lista_a, tam, nota), sitios, F=tam)


def todo_imagenes():
    t = B.trazador()
    vistos = set()
    for (dst, b, pc, s, hl, de) in t.llamadas:
        if dst != 0x5911 or hl is None or de is None:
            continue
        v = B.Ventana(s)
        k = (v.banco(hl), hl, de)
        if k in vistos:
            continue
        vistos.add(k)
        imagen(v, hl, de, ["%s:%04X" % (B.nombre(b), pc)])
    # las que llegan por otro camino: p00:57D6 (la lista de HL; la tabla 0x795F), y p00:5753 (los
    # cuatro dialogos de p00:5746 y p00:570E)
    v = ventana(V789)
    for lista in (0x7987, 0x79A0, 0x79B3, 0x79CC):
        imagen(v, lista, 0x795F, ["p00:57D6"])
    for lista, tabla, texto, modo, sitio in ((0x8151, 0x8039, 0xB4F9, 0, "p00:5746"),
                                             (0x81BE, 0x805D, 0xB636, 0, "p00:570E"),
                                             (0x8225, 0x807F, 0xB773, 1, "p00:5720"),
                                             (0x82AA, 0x80AB, 0xB8D5, 1, "p00:5733")):
        imagen(v, lista, tabla, [sitio])
        fin = dialogo(modo)(v, texto)
        B.declara(v, texto, fin, "dialogo_%04X" % texto,
                  "el texto de un cuadro de dialogo (p00:576A): letras de %s tiles, 0xFE linea nueva, "
                  "0xFF acaba" % ("5 x 2" if modo else "3 x 3"), [sitio], F=16)


# ------------------------------------------------------------ otros lectores

def todo_listas():
    B.por_lector(0x4E2D, "DE", rle, "rle",
                 "datos a la VRAM en RLE (p00:4E2D): 0 acaba, n < 0x80 repite el byte de detras, 0x80 y "
                 "una direccion nueva, 0x81-0xFF copian n & 0x7F bytes", F=16)
    B.por_lector(0x4EDC, "HL", colores, "colores",
                 "lista de colores de la paleta (p00:4EDC): numero de registro y dos bytes, y 0xFF",
                 F=3)
    B.por_lector(0x5C92, "HL", texto_tiles, "texto_tiles",
                 "texto de tiles (p00:5C92): un tile por byte, 0xFE y un desplazamiento, 0xFF acaba",
                 F=16)
    B.por_lector(0x5363, "HL", lista_tiles, "tiles",
                 "lista de tiles (p00:5363): X, Y y los tiles, 0xFE trae otro X, Y y 0xFF acaba", F=16)
    B.por_lector(0x58C5, "HL", lista_bloques, "bloques",
                 "lista de tiles (p00:58C5): X, Y y bloques (bit 7: n tiles seguidos; si no, un tile "
                 "repetido n veces), 0xFF acaba", F=16)
    B.por_lector(0x58C9, "HL", lista_bloques, "bloques",
                 "lista de tiles (p00:58C9): X, Y y bloques (bit 7: n tiles seguidos; si no, un tile "
                 "repetido n veces), 0xFF acaba", F=16)


def todo_trozos():
    """Los dibujos que carga el codigo con su tamano a la vista: tiles de 1, 2 y 3 bits."""
    v = ventana(V789)
    for p, n, tam, que, sitio in (
            (0x6000, 0x14, 8, "20 tiles de 1 bit por punto", "p00:5A2E"),
            (0x60A0, 0x14, 8, "20 tiles de 1 bit por punto", "p00:5A3A"),
            (0x6008, 0x0A, 8, "10 tiles de 1 bit por punto", "p00:5A5F"),
            (0x6130, 1, 8, "un tile de 1 bit por punto", "p00:5A53"),
            (0x6138, 0x25, 16, "37 tiles de 2 bits por punto", "p00:5A6B"),
            (0x6398, 8, 24, "8 tiles de 3 bits por punto", "p00:5A86"),
            (0x6458, 8, 24, "8 tiles de 3 bits por punto", "p00:5AA3")):
        B.declara(v, p, p + n * tam, "dibujos_%04X" % p,
                  "los dibujos de la mesa (%s): %s" % (sitio, que), [sitio], F=tam)
    for p, sitio in ((0x6388, "p00:5A6E"), (0x6390, "p00:5A8C")):
        B.declara(v, p, p + 8, "paleta_%04X" % p, "una paleta de 8 colores que se copia a 0xE800 (%s)" % sitio,
                  [sitio], F=8)
    for p, sitio in ((0x783F, "p00:569D"), (0x78CF, "p00:56A6")):
        B.declara(v, p, p + 144, "mapa_%04X" % p,
                  "un mapa de 24 x 6 tiles (p00:56AC)", [sitio], F=24)
    w = ventana(V56)
    for p, n, tam, que, sitio in ((0xAFD1, 0x0D, 8, "13 tiles", "p00:5C39"),
                                  (0xB039, 0x0D, 8, "13 tiles", "p00:5C45"),
                                  (0xB0A1, 0x1A, 8, "26 tiles", "p00:5C51")):
        B.declara(w, p, p + n * tam, "dibujos_%04X" % p,
                  "los dibujos del titulo (%s): %s de 1 bit por punto" % (sitio, que), [sitio], F=tam)
    B.declara(w, 0x8000, 0xA000, "letras",
              "la fuente de 128 letras de 16 x 16 puntos, 64 bytes cada una (p00:5B29)",
              ["p00:5B53", "p00:5B55"], F=64)


def todo_sprites_de_caras():
    """p00:58A2: la lista B de la tabla de 0x58B9 (seis palabras) es un RLE de los sprites
    de la cara que habla, que se vuelca a la VRAM 0xFE00 (p00:58AE)."""
    w = ventana(V56)
    for k in range(6):
        a = w.w(0x58B9 + 2 * k)
        B.declara(w, a, rle(w, a), "rle_cara_%d" % k,
                  "el RLE de los sprites de la cara numero %d de la tabla de p00:58B9 (se vuelca a la "
                  "VRAM 0xFE00 con p00:4E2D): 0 acaba, n < 0x80 repite, 0x80 y una direccion, "
                  "0x81-0xFF copian n & 0x7F bytes" % k, ["p00:58A2"], F=16)


def todo():
    todo_sprites_de_caras()
    todo_imagenes()
    todo_listas()
    todo_trozos()


def leido_en_campana():
    import json
    import os
    d = {}
    carpeta = os.path.join(B.RAIZ, "work", "cob")
    if os.path.isdir(carpeta):
        for fn in sorted(os.listdir(carpeta)):
            if fn.endswith(".json"):
                for k, v in json.load(open(os.path.join(carpeta, fn)))["lector"].items():
                    b, a = k.split(":")
                    bl, pc = v.split(":")
                    d.setdefault((int(b), int(a, 16)), (int(bl), int(pc, 16)))
    return d
