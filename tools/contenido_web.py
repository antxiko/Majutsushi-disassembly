#!/usr/bin/env python3
"""EL CONTENIDO de la web de este cartucho: lo unico que es de este juego.

jekyll.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui.

Todas las cifras de aqui estan medidas sobre este cartucho, con las
herramientas de tools/: CODIGO y DATOS los imprime tools/presupuesto.py
(make sanity) y RUTINAS, INSTRUCCIONES y COMENTARIOS los da
tools/densidad_total.py.
"""

NOMBRE = "Hai no Majutsushi - Mahjong 2"
CATALOGO = "RC-765"
ANIO = 1989
REPOSITORIO = "https://github.com/antxiko/Majutsushi-disassembly"

CODIGO = 39764
DATOS = 91308
RUTINAS = 2448
INSTRUCCIONES = 20776
COMENTARIOS = 5377


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


PIE_LEGAL = {
    "es": "<em>Hai no Majutsushi - Mahjong 2</em> (牌の魔術師) lo public&oacute; Konami para MSX2 "
          "en 1989; su n&uacute;mero de cat&aacute;logo es RC-765 y son 128 KB. Todos los derechos "
          "sobre el juego siguen siendo de sus titulares. Este trabajo es de "
          "preservaci&oacute;n, estudio y documentaci&oacute;n, y la imagen del cartucho "
          "no se distribuye.",
    "en": "<em>Hai no Majutsushi - Mahjong 2</em> (牌の魔術師) was published by Konami for the "
          "MSX2 in 1989; its catalogue number is RC-765 and it is 128 KB. All rights in the "
          "game remain with their holders. This is preservation, study and documentation work, "
          "and the cartridge image is not distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Hai no Majutsushi - desensamblado comentado",
        claim="Un mahjong japon&eacute;s de cuatro jugadores con ocho rivales de Konami, cuyos "
              "estilos de juego se adaptan a las manos que ganas: los yaku medidos ejecutando "
              "su propio c&oacute;digo, las reglas, las voces digitales sacadas de la ROM y el "
              "cartucho entero explicado.",
        ficha=["Konami - <b>(c) Konami 1989</b>",
               "Cartucho <b>RC-765</b>, MegaROM de 128 KB (Konami con DAC)",
               "<b>MSX2</b>", "Volcado <b>7839c843...</b>"],
        aviso="<b>Las im&aacute;genes son capturas de openMSX</b> con el cartucho en marcha, "
              "no dibujos hechos desde la ROM; los datos que carga el juego est&aacute;n "
              "explicados y medidos, y las voces s&iacute; est&aacute;n decodificadas "
              "byte a byte de la ROM.",
    ),
    "en": dict(
        titulo="Hai no Majutsushi - commented disassembly",
        claim="A Japanese four-player mahjong with eight Konami characters as rivals, whose "
              "playing styles adapt to the hands you win: the yaku measured by running its own "
              "code, the rules, the digital voices taken from the ROM and the whole cartridge "
              "explained.",
        ficha=["Konami - <b>(c) Konami 1989</b>",
               "Cartridge <b>RC-765</b>, 128 KB MegaROM (Konami with DAC)",
               "<b>MSX2</b>", "Dump <b>7839c843...</b>"],
        aviso="<b>The pictures are openMSX screenshots</b> of the cartridge running, not "
              "drawings made from the ROM; the data the game loads is explained and "
              "measured, and the voices are decoded byte by byte from the ROM.",
    ),
}

# Los tres bloques: el juego | curiosidades | por dentro.
# (en, es, titulo en, titulo es, que hay en, que hay es)
PAGINAS = [
    [("THE-GAME.html", "EL-JUEGO.html", "The game", "El juego",
      "the screens in order, from the title to the payment",
      "las pantallas en orden, del t&iacute;tulo al pago"),
     ("THE-RIVALS.html", "LOS-RIVALES.html", "The rivals", "Los rivales",
      "the eight characters and the seven counters that give each its style",
      "los ocho personajes y los siete contadores que dan su estilo a cada uno"),
     ("THE-RULES.html", "LAS-REGLAS.html", "The rules", "Las reglas",
      "the ten options and their defaults",
      "las diez opciones y su valor de serie"),
     ("THE-YAKU.html", "LOS-YAKU.html", "The yaku", "Los yaku",
      "every hand the game recognises, measured by running it",
      "cada mano que reconoce el juego, medida ejecut&aacute;ndola"),
     ("THE-VOICES.html", "LAS-VOCES.html", "The voices", "Las voces",
      "the eight digital voices, decoded from the ROM",
      "las ocho voces digitales, decodificadas de la ROM")],
    [("CURIOSITIES.html", "CURIOSIDADES.html", "Curiosities", "Curiosidades",
      "the false-win penalty, the free space, a cartridge with a DAC",
      "la penalizaci&oacute;n por ganar en falso, el espacio libre, un cartucho con DAC")],
    [("UNDER-THE-HOOD.html", "POR-DENTRO.html", "Under the hood", "Por dentro",
      "rebuilding the ROM, the mapper, the state machine, the hands in RAM, the data banks",
      "rehacer la ROM, el mapper, la m&aacute;quina de estados, las manos en RAM, los bancos de datos")],
]

# Repositorio nuevo: no hay paginas viejas que redirigir.
VIEJAS = {}

LOGOTIPO = "titulo.png"
