# omsx_leido.tcl - MSX2: apunta que bytes de la ROM (bancos de DATOS: 5-11, 13, 14 y la tabla de
# p15) lee el programa como datos, y quien los lee, mientras corre el juego. Ademas sirve para
# dirigirlo: teclas, pokes y volcados como tools/omsx_maj.tcl.
#
# Variables (las de omsx_maj.tcl y):
#   MAJ_LEIDO   fichero donde se escriben las lecturas: "banco:direccion pc" (la primera lectura de
#               cada byte), al salir
#   MAJ_PCS     "t:direccion ..." : a ese segundo se pone el estado (poke de 0xC000 y 0xC001 ...)
#
#   MAJ_SOLO_FOTO 1: solo la captura en cada tiempo (sin volcar VRAM ni RAM: mucho mas rapido)
#
# El banco puesto en cada ventana lo da el mapper (ver banco_ventana).
proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}
set ::SALIDA [opcion MAJ_SALIDA {work/omsx}]
set ::TIEMPOS [opcion MAJ_TIEMPOS {5 10 20}]
set ::LEIDO [opcion MAJ_LEIDO {work/leido.txt}]
file mkdir $::SALIDA
set throttle off
array set ::visto {}

# El banco de cada ventana se lleva al dia vigilando las escrituras al mapper (cualquier escritura en
# 0x6000-0xBFFF elige el banco de su ventana; son pocas). Las copias de 0xF0F1-3 no bastan: para las
# voces 0x17 y 0x18 el motor escribe 0x0F directamente en 0xA000 (p12:627C) sin tocarlas. Al empezar,
# el banco de cada ventana lo da el debuggable "romblocks" del cartucho.
set ::ROMBLOCKS ""
foreach d [debug list] { if {[string match "*Majutsushi*romblocks" $d]} { set ::ROMBLOCKS $d } }
foreach v {0 1 2} { set ::banco($v) [debug read $::ROMBLOCKS [expr {0x6000 + 0x2000 * $v}]] }
proc mapper {} { set ::banco([expr {($::wp_last_address - 0x6000) >> 13}]) [expr {$::wp_last_value & 0x0F}] }
debug set_watchpoint write_mem {0x6000 0xBFFF} {} mapper
proc banco_ventana {v} { return $::banco($v) }
proc lectura {} {
    set a $::wp_last_address
    set v [expr {($a - 0x6000) >> 13}]
    set b [banco_ventana $v]
    if {$b == 0 || ($b >= 1 && $b <= 4)} { return }
    set k "$b:[format %04X $a]"
    if {![info exists ::visto($k)]} {
        set ::visto($k) [format %04X [reg PC]]
    }
}
if {[opcion MAJ_SOLO_FOTO 0] != 1} { debug set_watchpoint read_mem {0x6000 0xBFFF} {} lectura }

proc vuelca {etiqueta} {
    if {[opcion MAJ_SOLO_FOTO 0] != 1} { guarda_leido }
    if {[opcion MAJ_SOLO_FOTO 0] == 1} {
        screenshot [file join $::SALIDA "ver-$etiqueta.png"]
        return
    }
    set f [open [file join $::SALIDA "vram-$etiqueta.bin"] wb]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block VRAM 0 131072]
    close $f
    set g [open [file join $::SALIDA "vdp-$etiqueta.txt"] w]
    for {set i 0} {$i < 47} {incr i} {
        puts $g [format "R%d = 0x%02X" $i [debug read "VDP regs" $i]]
    }
    for {set i 0} {$i < 16} {incr i} {
        puts $g [format "P%d = 0x%04X" $i [expr {[debug read "VDP palette" [expr {$i*2}]] | ([debug read "VDP palette" [expr {$i*2+1}]] << 8)}]]
    }
    close $g
    set h [open [file join $::SALIDA "ram-$etiqueta.bin"] wb]
    fconfigure $h -translation binary
    puts -nonewline $h [debug read_block memory 0 65536]
    close $h
    screenshot [file join $::SALIDA "ver-$etiqueta.png"]
}
proc guarda_leido {} {
    set f [open $::LEIDO w]
    foreach k [lsort [array names ::visto]] { puts $f "$k $::visto($k)" }
    close $f
}
foreach k [opcion MAJ_TECLAS {}] {
    lassign [split $k :] t f m d
    if {$d eq ""} { set d 0.15 }
    after time $t "keymatrixdown $f $m; after time $d {keymatrixup $f $m}"
}
foreach k [opcion MAJ_POKES {}] {
    lassign [split $k :] t d v
    after time $t "poke $d $v"
}
foreach t $::TIEMPOS { after time $t "vuelca $t" }
# avance: cada 30 s de reloj emulado, una linea en <MAJ_SALIDA>/avance.txt
proc avance {} {
    set f [open [file join $::SALIDA avance.txt] a]
    puts $f "[machine_info time] s, [array size ::visto] bytes vistos, bancos $::banco(0) $::banco(1) $::banco(2)"
    close $f
    after time 30 avance
}
after time 30 avance
after time [expr {[lindex $::TIEMPOS end] + 1}] "guarda_leido; exit"

