# Por dentro

## Rehacer la ROM

```
make            # listado, reensamblado, comprobaciones y tests
make verify     # los 16 bancos reensamblados dan la ROM entera, byte a byte
make sanity     # nada declarado como datos corre como código; ni un byte sin dueño
```

Hace falta la imagen del cartucho (`majutsushi.rom`, 131.072 bytes, sha256
`7839c843dc787e01765c1ba3efbd26dcf5209d27e38bcee1345db3b3cffdf5db`), que no se distribuye.

## En cifras

| | |
|---|---|
| explicado | el 100 % de los 131.072 bytes |
| código | 39.774 bytes, 20.780 instrucciones |
| datos | 91.298 bytes |
| rutinas | 2.450, ninguna con menos del 10 % comentado |

## El cartucho

Un MegaROM de 16 bancos de 8 KB. El banco 0 está fijo en 0x4000-0x5FFF y lleva la interrupción, las rutinas del VDP
y las de dibujo. Las otras tres ventanas (0x6000, 0x8000 y 0xA000) se cambian escribiendo el número de banco en 0x7000,
0x9000 y 0xB000 (el mapper de Konami); el juego guarda copias de los tres números en 0xF0F1-0xF0F3 y p00:4207-425B los
ponen. El cartucho tiene además un DAC en 0x5000 (p12:62A8).

| banco | en | qué lleva |
|---|---|---|
| 0 | 0x4000 | interrupción, órdenes del VDP, dibujo de tiles, teclas, la máquina de estados |
| 1 | 0x6000 | grabar y cargar en un segundo cartucho, análisis de manos, tablas de yaku, el partidor de manos |
| 2 | 0x8000 | las decisiones de la máquina, reparto, descartes, llamadas, dados, cuadros de diálogo |
| 3 | 0xA000 | los menús (reglas, rivales, personalidades), el final de la mano, los resultados |
| 4 | 0xA000 | las comprobaciones de yaku, el pago, las animaciones de las caras de los rivales |
| 5 | 0x8000 | una fuente de 128 glifos de 16 x 16 puntos, 64 bytes cada uno |
| 6 | 0xA000 | gráficos del título y de los menús, paletas y listas RLE |
| 7-9 | 0x6000-0xBFFF | gráficos de la mesa, tiles y diálogos (las listas de imagen de p00:5911) |
| 10-11 | 0x8000-0xBFFF | retratos, gráficos de menús |
| 12 | 0x6000 | el motor de sonido, patrones de ritmo, las primeras músicas |
| 13-14 | 0x8000-0xBFFF | el resto de las músicas y después las voces |
| 15 | 0xA000 | las tablas de patrones de la máquina, los fu, el barajado del muro, dos voces |

## La máquina de estados

0xC000 guarda el estado y 0xC001 el paso dentro de él. La interrupción (colgada en H.KEYI por el INIT, p00:4010) corre
primero el motor de sonido con los bancos 12-13-14, devuelve los bancos del juego y luego corre un cuadro del juego:
p00:55F0 lee las teclas y p00:425D despacha por la tabla de nueve estados de p00:4271. El bucle `jr $` de p00:40BF no
hace otra cosa.

## Una mano en la RAM

Cada jugador tiene 0x400 bytes en 0xD000 + 0x400 x asiento (p02:85D8):

| desplazamiento | qué |
|---|---|
| +0x00 | las 13 fichas, ordenadas |
| +0x0E | el número de grupos cantados |
| +0x0F, +0x10 | el número de descartes y la lista |
| +0x34, +0x35 | riichi, doble riichi |
| +0x37, +0x3F | los grupos cantados y cuántos |
| +0x40 | 1 si la mano está abierta |
| +0x41 | la lista de descartes propios (comprobación de furiten) |
| +0x60 | qué puede decir el jugador al último descarte: bit 0 pon, 1 chi, 2 kan, 3 ron |
| +0x81 | en espera al final de la mano |
| +0x90..+0x96 | los siete contadores de estilo |
| +0x100..+0x3FF | el análisis de la máquina: fichas por palo, escaleras, parejas, huecos |

Una ficha es un byte: el número en el nibble bajo, el palo en los bits 4-5 (0, 1, 2; el 3 es honores: 0x31-0x34 vientos y
0x35-0x37 dragones), y los bits 6-7 marcan una ficha que forma parte de un grupo cantado. El muro son 136 bytes en 0xC100,
barajados por p15:A2A8 con como mucho cuatro de cada ficha.

## La pantalla

SCREEN 7, 512 x 212, 16 colores. Todo se dibuja con órdenes del VDP: los tiles se copian con HMMM desde una hoja en
y = 0xB0 (p00:5398), los paneles se rellenan con HMMV (p00:4FE5), las letras y las imágenes entran con LMMC (p00:5074)
y los retratos los decodifica p00:5911 desde tiles de 1, 2 o 3 bits por punto con una paleta de 2, 4 u 8 colores. Las
listas de imagen llevan seis bytes por entrada (formato, paleta, tile, cuántos, puntero) y acaban en 0xFF.

## Los bancos de datos

`tools/lectores.py` recorre cada lista que leen los cargadores, con el banco que está puesto cuando corre el cargador
(`tools/bancos.py` sigue el mapper por todo el cartucho). Con eso se explican las listas de imagen, las paletas, los
RLE, las listas de tiles, la fuente, las voces y los flujos de sonido; el resto son tablas a las que apunta alguna
instrucción o una nota explícita del listado.

### Lo que lee una partida, medido

`tools/omsx_leido.tcl` ejecuta el cartucho en openMSX con un punto de vigilancia en cada lectura
de 0x6000-0xBFFF y apunta, la primera vez, qué byte de qué banco se lee y qué instrucción lo lee; el
banco es el que tiene de verdad el mapper, seguido por sus escrituras (las voces 0x17 y 0x18 ponen
el banco 15 sin tocar las copias de 0xF0F1-3). Quince minutos de título, menús y dos manos, con
espacio cada pocos segundos (`tools/cobertura_leido.py`):

| banco | datos leídos |
|---|---|
| 5 | 2.753 de 8.192 bytes |
| 6 | 5.041 de 7.985 |
| 7 | 6.495 de 8.192 |
| 8 | 8.135 de 8.192 |
| 9 | 6.711 de 8.030 |
| 10 | 2.894 de 8.192 |
| 11 | 1.493 de 8.178 |
| 13 | 6.247 de 8.192 |
| 14 | 7.035 de 7.035 |
| 15 | 2.859 de 7.375 |
| total | 49.663 de 79.563 (62,4 %) |

Un byte que esta pasada no lee no es un byte que no lea nadie: la pasada solo recorre las pantallas
a las que lleva la tecla de espacio. Lo que sí enseña es que ni una sola lectura cae en el relleno de
0xFF del final de los bancos.

## El sonido

p12 corre cinco canales (tres músicas en el PSG y dos de efectos que se quedan los canales B y C del PSG) con un flujo
de notas (el nibble alto la nota, el bajo la duración) y órdenes: 0xD0-0xDF y 0xE0-0xFE, 0xFF acaba. Los flujos de los 16
sonidos están en p12:6F72-p13:903F, y todos acaban justo donde empieza el siguiente una vez contadas las subrutinas que
llama 0xF9. Los sonidos 0x11-0x18 son las voces de [Las voces](LAS-VOCES.html).
