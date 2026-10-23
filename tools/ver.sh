#!/bin/sh
# ver.sh <pNN> <desde> <hasta>: lineas del listado, compactas (sin tabuladores ni la direccion final)
sed -n "$2,$3p" src/majutsushi_$1.asm | sed 's/[ \t]*;\([0-9a-f]\{4\}\)$/ ;\1/; s/^\t//'
