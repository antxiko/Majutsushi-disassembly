# Las reglas

La pantalla de *ajustes de reglas* (ルール設定) tiene diez opciones de sí o no. Viven en diez bytes en
0xC020-0xC029, copiados al empezar de la tabla de p15:A19C (`01 00 01 01 00 00 00 00 01 01`), que es
exactamente el estado que enseña la pantalla:

![los ajustes de reglas](../imagenes/reglas.png)

| byte | regla | de serie | se lee en |
|---|---|---|---|
| 0xC020 | 食い断幺: tanyao con la mano abierta | sí | p04:A431 |
| 0xC021 | 自摸平和: el pinfu cuenta con robo | no | p04:A3B6 |
| 0xC022 | 十三不搭: las trece fichas sin conexión | sí | p01:70E4 |
| 0xC023 | 流し満貫: nagashi mangan | sí | p01:7087 |
| 0xC024 | 八連荘: ocho victorias seguidas del que reparte | no | p01:6D02 |
| 0xC025 | 四連刻: cuatro tripletes seguidos | no | p04:A212 |
| 0xC026 | 大車輪: siete parejas seguidas de un palo | no | p04:A24F |
| 0xC027 | 槓ウラ: dora bajo el kan | no | p04:A8BE |
| 0xC028 | ダブルロン: ron doble | sí | p01:6510 |
| 0xC029 | 二翻縛り: mínimo dos han | sí | p01:6963 |

p03:A803 lleva la pantalla: el cursor se mueve con las cuatro direcciones, el botón cambia la opción
que tiene debajo y la última línea (終了) sale.
