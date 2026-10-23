# El juego

*Hai no Majutsushi - Mahjong 2* (牌の魔術師, "el mago de las fichas") es un mahjong japonés
(riichi) de cuatro jugadores para MSX2, publicado por Konami en 1989 (RC-765, 128 KB). Te sientas a
una mesa contra tres jugadores de la máquina elegidos entre ocho personajes de los propios
juegos de Konami. El cartucho lo dibuja todo en SCREEN 7 (512 x 212, 16 colores) y habla con el PSG
más ocho voces digitales que reproduce un DAC que va en el propio cartucho.

Las imágenes de esta página son capturas de openMSX con el cartucho en marcha (C-BIOS
MSX2), hechas con `tools/omsx_leido.tcl`; la partida se dejó jugar sola con la barra espaciadora.

## Del título a la primera mano

![el título: bambú, el logotipo y PUSH SPACE KEY](../imagenes/titulo.png)

El título se va armando durante unos diez segundos (el bambú, luego el logotipo, luego el
texto) con la animación de p00:5C6F. Una tecla lleva a un menú de dos líneas:
*partida de práctica* (練習対局) o *partida de verdad* (実戦対局).

![el menú de modo](../imagenes/menu_modo.png)

Después viene un menú de cinco líneas: ajustes de personalidad (性格設定), elección de
rivales (面子選択), ajustes de reglas (ルール設定), corrección de pantalla (画面補正) y *salir* (終了), que
empieza la partida. Las reglas están en [Las reglas](LAS-REGLAS.html) y las personalidades en
[Los rivales](LOS-RIVALES.html).

![el menú de cinco líneas](../imagenes/menu_cinco.png)

Los tres rivales aparecen uno a uno, cada uno en su retrato enmarcado, y se tiran los dados para ver
quién reparte (el viento Este, 東).

![los tres rivales](../imagenes/rivales_presentacion.png)

![los dados](../imagenes/dados.png)

## La mesa

![la mesa al empezar una mano](../imagenes/mesa_inicio.png)

Las cuatro manos están en los cuatro lados de la mesa, con el muro en el medio y el marcador encima
(ronda, honba y varillas de riichi, el que reparte). Los descartes se apilan delante de cada jugador. El
jugador humano (siempre el asiento 0) elige la ficha que tira con los cursores y la barra espaciadora.

![una mano en marcha](../imagenes/mesa_partida.png)

Cuando un descarte permite cantar, el juego abre una cajita con las opciones y el rival que canta enseña
su retrato con el grito (PON, CHI, KAN, RON):

![PON](../imagenes/pon.png)

![la caja de las llamadas](../imagenes/cuadro_llamada.png)

## El final de una mano

Una mano acaba con una victoria por robo (*tsumo*), una victoria por descarte (*ron*) o un empate por
muro agotado (*ryuukyoku*, 流局), y el juego enseña los pagos.

![una mano sin ganador con los cuatro marcadores](../imagenes/ryuukyoku.png)

Cuando alguien gana sale la lista de yaku, una línea por yaku con su valor en *han*, y los fu:

![una victoria: robo con la mano cerrada, un han, 30 fu](../imagenes/victoria.png)

![los pagos tras una victoria](../imagenes/pagos.png)

El código de cada pantalla está en [Por dentro](POR-DENTRO.html); los yaku, en [Los yaku](LOS-YAKU.html).

## Animado

![el título montándose](../imagenes/titulo.gif)

![los dados y el reparto](../imagenes/reparto.gif)

![una mano jugándose](../imagenes/partida.gif)
