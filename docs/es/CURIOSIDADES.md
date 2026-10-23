# Curiosidades

## Una victoria falsa tiene su propio "yaku"

Si el jugador humano declara una victoria sin tener una mano que gane, p01:6CB1 no se niega: escribe el yaku 0x35 con
valor 0x83 en la lista (p01:6CC9) y la pantalla de puntuación toma el camino especial de p04:A943, que suena la voz
0x17 (p04:A5D5). Es la penalización del juego por una declaración falsa; el nombre estándar sería *chombo*, pero no se
ha leído el nombre que dibuja la pantalla, así que la página lo llama 0x35.

## La máquina aprende

Siete contadores por personaje se desplazan tras cada mano que gana el humano ([Los rivales](LOS-RIVALES.html)): quien
gana a menudo con toitoi hace que los demás piensen un poco más en toitoi. El código está en p03:BD8E-BFD6.

## Tres reglas que la mayoría de mahjongs no tiene

四連刻 (cuatro tripletes seguidos), 大車輪 (siete parejas seguidas) y 八連荘 (ocho victorias seguidas del que reparte)
están en la pantalla de reglas y cableadas a los yaku 0x2C, 0x2D y 0x34, todas apagadas de serie ([Las reglas](LAS-REGLAS.html)).

## El DAC y un registro que no es de banco

Los sonidos 0x17 y 0x18 necesitan el último banco en 0xA000. El motor no usa para ello el registro del mapper en
0xB000: p12:6060 y p12:627C escriben 0x0F en 0xA000, y p12:6055 y p12:62EC vuelven a escribir 0x0E. Las voces de
0xAE00 y 0xB6E2 son lo único del banco 15, además de sus tablas y su código.

## Espacio que nadie usa

Las colas de 0xFF al final de los bancos suman 1.649 bytes; la mayor, de 1.157 bytes, está al final del banco 14
(0xBB7B-0xBFFF).

## Código que nadie llama

Ocho fragmentos no los alcanza ninguna llamada, salto ni tabla: p00:533F, 5342, 5367, 5565, 5568 y 570B, p01:68F3 y
p03:BFAB. Son la segunda entrada de rutinas cuya primera entrada sí se usa (un `xor a` y un `ld a,1` delante de un
`ld (0xC0B9),a` compartido, por ejemplo); el listado los marca como código huérfano.

## Una tabla de sonidos con hueco para cada voz

La tabla de sonidos de p12:61B0 tiene 16 filas, pero la tabla tiene sitio para 24 entradas porque la indexación no
salta las voces: las ocho casillas de los sonidos 0x11-0x18 (p12:61D2) guardan ocho copias de 0x6254, la dirección del
propio cuadro de sonido, y no las lee nadie.
