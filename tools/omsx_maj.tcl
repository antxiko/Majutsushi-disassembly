# omsx_maj.tcl - MSX2: vuelca VRAM (128 KB), registros del VDP, paleta, RAM y captura
# en los segundos emulados indicados. Variables: MAJ_SALIDA, MAJ_TIEMPOS,
# MAJ_TECLAS "t:fila:mascara[:segundos] ...", MAJ_POKES "t:dir:valor ...".
proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}
set ::SALIDA [opcion MAJ_SALIDA {work/omsx}]
set ::TIEMPOS [opcion MAJ_TIEMPOS {5 10 20}]
file mkdir $::SALIDA
set throttle off
proc vuelca {etiqueta} {
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
    puts $g [format "F0F1 = %02X %02X %02X" [debug read memory 0xF0F1] [debug read memory 0xF0F2] [debug read memory 0xF0F3]]
    close $g
    set h [open [file join $::SALIDA "ram-$etiqueta.bin"] wb]
    fconfigure $h -translation binary
    puts -nonewline $h [debug read_block memory 0 65536]
    close $h
    screenshot [file join $::SALIDA "ver-$etiqueta.png"]
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
after time [expr {[lindex $::TIEMPOS end] + 1}] exit
