# La música

Los sonidos 0x01-0x10 son los del PSG: las músicas y los efectos cortos. El motor está en el banco
12 (p12:6000 lo arranca, p12:6003 pide un sonido, p12:6006 toca un cuadro), con cinco canales en la
RAM de 0xCE00, de 0x2C bytes cada uno. Cada canal lee una ristra de notas y órdenes: las 0xD0-0xDF
van por la tabla de p12:6B94 y las 0xE0-0xFE por la de p12:6962, entre ellas una llamada (0xF9),
su vuelta (0xFA), dos repeticiones con contador (0xFB, 0xFC), un salto (0xFD) y el final (0xFF). Los
dieciséis sonidos tienen su fila en p12:61E2, a la que se llega por los punteros de p12:61B2.

Las grabaciones de abajo no salen del sonido de un emulador. `tools/musica.py` ejecuta el motor
del propio cartucho en un emulador de Z80 con el mapper, una llamada a p12:6006 cada 1/60 s, y
apunta lo que manda al PSG; el fichero se sintetiza con esos valores de los registros. Una música
que se repite suena hasta su vuelta y una vez más; la vuelta se encuentra cuando los cinco canales
vuelven al mismo estado (puntero, contador de la nota, contadores de repetición y retorno).

Cotejado con openMSX (`tools/omsx_psg.tcl` apunta los registros del PSG en cada cuadro y
`tools/coteja_psg.py` los alinea): en los primeros 50 s de la música del título, la 0x09, 2.778 de
3.000 cuadros son idénticos en los tres tonos y los tres volúmenes, y los otros 222 difieren en 2 a
8 unidades del tono fino del canal A o en 1 de un volumen: la fase de un vibrato y de una envolvente.
Las demás músicas se ejecutan igual pero no se han cotejado con el emulador: la demo que sigue al
título no encaja con ninguna, probablemente porque los efectos de los dados y de los descartes
suenan por los mismos canales.

| sonido | cuándo | lo pide | audio |
|---|---|---|---|
| 0x09 | Los menús (y la tecla F4 en la partida) | p00:42BD, p00:49D7 | <audio controls preload="none" src="../audio/musica_09.mp3"></audio> |
| 0x0A | Los menús de ajustes (y la tecla F5) | p00:4369, p00:4888 | <audio controls preload="none" src="../audio/musica_0A.mp3"></audio> |
| 0x0C | La partida: la música de serie (y la tecla F2) | p00:44A4 | <audio controls preload="none" src="../audio/musica_0C.mp3"></audio> |
| 0x0B | La partida: la tecla F3 | p01:616D | <audio controls preload="none" src="../audio/musica_0B.mp3"></audio> |
| 0x0D | Gana el jugador | p00:457E | <audio controls preload="none" src="../audio/musica_0D.mp3"></audio> |
| 0x0E | Gana un rival | p00:4581, p00:4907 | <audio controls preload="none" src="../audio/musica_0E.mp3"></audio> |
| 0x0F | La mano se acaba sin ganador | p00:48F3 | <audio controls preload="none" src="../audio/musica_0F.mp3"></audio> |
| 0x10 | El cuadro de p00:473E (estado 5, paso 6) | p00:475D | <audio controls preload="none" src="../audio/musica_10.mp3"></audio> |
| 0x03 | Se abre un cuadro de pregunta | p00:5EBC, p02:949A, p02:97AE | <audio controls preload="none" src="../audio/musica_03.mp3"></audio> |
| 0x04 | Se tira una ficha | p02:8D49 | <audio controls preload="none" src="../audio/musica_04.mp3"></audio> |
| 0x05 | Los dados | p02:8F0B, p02:8F53 | <audio controls preload="none" src="../audio/musica_05.mp3"></audio> |
| 0x06 | El cursor | p00:43AC, p02 (4), p03 (6) | <audio controls preload="none" src="../audio/musica_06.mp3"></audio> |
| 0x07 | Se elige | p00:43D3, p03 (5) | <audio controls preload="none" src="../audio/musica_07.mp3"></audio> |
| 0x08 | Se reparten las fichas | p02:8AED | <audio controls preload="none" src="../audio/musica_08.mp3"></audio> |

El sonido 0x01 calla los tres canales en un solo cuadro, y el 0x02 tampoco suena.

## Las teclas de función

En el turno del jugador (p00:5E7B), p01:6146 convierte las teclas de función recién pulsadas (0xC00C, bit 0 = F1)
en un sonido; manda la primera que esté pulsada, y solo si no es el que ya se pidió (0xC0C2): F1
pide el 0x01 (silencio), F2 el 0x0C, F3 el 0x0B, F4 el 0x09 y F5 el 0x0A. Así el jugador elige la
música de fondo, o la quita.

| sonido | duración |
|---|---|
| 0x09 | 72,6 s, vuelve al principio |
| 0x0A | 78,4 s, vuelve a los 41,1 s |
| 0x0B | 51,2 s, vuelve al principio |
| 0x0C | 58,2 s, vuelve a los 31,5 s |
| 0x10 | 37,4 s, vuelve a los 18,7 s |
| 0x0D, 0x0E, 0x0F | 3,6, 3,7 y 4,4 s |
