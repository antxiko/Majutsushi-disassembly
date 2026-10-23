# Las voces

El cartucho tiene un DAC. Los sonidos 0x11-0x18 no son músicas del PSG sino ocho voces digitalizadas cortas,
que p12:6265 reproduce directamente en el registro del DAC en 0x5000 con la interrupción retenida.

| sonido | se dice cuando | bytes | audio |
|---|---|---|---|
| 0x11 | PON (p00:414D) | 1.154 | <audio controls src="../audio/voz_11.wav"></audio> |
| 0x12 | CHI (p00:4158) | 2.272 | <audio controls src="../audio/voz_12.wav"></audio> |
| 0x13 | KAN (p00:4163) | 1.440 | <audio controls src="../audio/voz_13.wav"></audio> |
| 0x14 | RON (p00:416E) | 1.431 | <audio controls src="../audio/voz_14.wav"></audio> |
| 0x15 | riichi (p00:4179) | 2.704 | <audio controls src="../audio/voz_15.wav"></audio> |
| 0x16 | tsumo (p00:4184) | 2.054 | <audio controls src="../audio/voz_16.wav"></audio> |
| 0x17 | con la penalización (p00:418F) | 2.272 | <audio controls src="../audio/voz_17.wav"></audio> |
| 0x18 | lo pide el motor cuando acaba un canal de efecto (p12:6941) | 2.332 | <audio controls src="../audio/voz_18.wav"></audio> |

## El formato

La tabla de p12:6065 guarda ocho punteros: 0x9040, 0x94C4, 0x9DA6, 0xA348, 0xA8E1 y 0xB373 (los bancos 13 y 14
puestos uno tras otro en 0x8000-0xBFFF) y 0xAE00 y 0xB6E2 (el banco 15 en 0xA000, que elige p12:6059). Una muestra
empieza con un byte de marca y acaba en el primer byte que la repite: los seis largos medidos en la ROM son 1.156,
2.274, 1.442, 1.433, 2.706 y 2.056 bytes con las dos marcas, y los dos del banco 15 son 2.274 y 2.334, que acaban
justo donde empieza la siguiente o donde acaba el banco.

Cada byte lleva dos nibbles, el alto primero. El DAC empieza en 0x80 y cada nibble le suma uno de dieciséis saltos
(la tabla de p12:62D1: 0, 1, 2, 4, 8, 16, 32, 64, -128, -64, -32, -16, -8, -4, -2, -1), módulo 256, y el resultado va a
0x5000. El ritmo es un bucle de 0xCF2F vueltas (p12:62AB): 3 de serie, 10 o 21 cuando p00:41AD pide la voz de un
personaje u otro (el tono de la voz de cada rival). Los ficheros de aquí usan 18 kHz, una estimación por las
instrucciones del bucle al ritmo de serie, y todos los valores quedan entre 12 y 247, como corresponde a una onda real.

`tools/voces.py` los escribe: `python tools/voces.py docs/audio`.
