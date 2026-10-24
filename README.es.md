# Hai no Majutsushi - Mahjong 2 - desensamblado comentado

*(Also available [in English](README.md).)*

El desensamblado comentado de **Hai no Majutsushi - Mahjong 2** (牌の魔術師; Konami, 1989, RC-765) para MSX2: un MegaROM de 128 KB con el mapper de Konami y un DAC, dieciséis bancos de 8 KB.

- El **100 %** del binario explicado: 39.774 bytes de código y 91.298 de datos con nombre, ni un solo byte sin dueño.
- El **25,9 %** del listado comentado, 2.450 rutinas, ninguna por debajo del 10 % de comentarios.
- El listado se reensambla en la ROM original **byte a byte**.
- Los 48 códigos de yaku se **midieron ejecutando el código del propio juego** sobre manos escritas a mano; las ocho voces digitales están decodificadas de la ROM; las catorce músicas y efectos del PSG los toca el motor del propio cartucho (la del título, cotejada con openMSX); un [parche tutorial](https://antxiko.github.io/Majutsushi-TutorialPatch/es/) añade un tutorial en inglés con F1; las imágenes son capturas de openMSX con el cartucho en marcha.

La web: <https://antxiko.github.io/Majutsushi-disassembly/>
(en castellano: <https://antxiko.github.io/Majutsushi-disassembly/es/>).

## Reproducirlo

La imagen del cartucho no se distribuye. Pon la tuya en la raíz como `majutsushi.rom` (sha256 `7839c843...`) y ejecuta `make`. Los detalles, en [POR DENTRO](docs/es/POR-DENTRO.md).

## Legal

El juego es de Konami y de sus titulares. La licencia de `LICENSE` solo cubre las herramientas, los comentarios, el análisis y la documentación de aquí. Véase [AVISO-LEGAL.md](AVISO-LEGAL.md).
