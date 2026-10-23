# Hai no Majutsushi - Mahjong 2 - desensamblado comentado

*(Also available [in English](README.md).)*

El desensamblado comentado de **Hai no Majutsushi - Mahjong 2** (牌の魔術師; Konami, 1989, RC-765) para MSX2: un MegaROM de 128 KB con el mapper de Konami y un DAC, dieciséis bancos de 8 KB.

- El **100 %** del binario explicado: 39.764 bytes de código y 91.308 de datos con nombre, ni un solo byte sin dueño.
- El **25,9 %** del listado comentado, 2.448 rutinas, ninguna por debajo del 10 % de comentarios.
- El listado se reensambla en la ROM original **byte a byte**.
- Los 24 yaku que el juego reconoce con más frecuencia se **midieron ejecutando su propio código** sobre manos escritas a mano; las ocho voces digitales están decodificadas de la ROM; las imágenes son capturas de openMSX con el cartucho en marcha.

La web: <https://antxiko.github.io/Majutsushi-disassembly/>
(en castellano: <https://antxiko.github.io/Majutsushi-disassembly/es/>).

## Reproducirlo

La imagen del cartucho no se distribuye. Pon la tuya en la raíz como `majutsushi.rom` (sha256 `7839c843...`) y ejecuta `make`. Los detalles, en [POR DENTRO](docs/es/POR-DENTRO.md).

## Legal

El juego es de Konami y de sus titulares. La licencia de `LICENSE` solo cubre las herramientas, los comentarios, el análisis y la documentación de aquí. Véase [AVISO-LEGAL.md](AVISO-LEGAL.md).
