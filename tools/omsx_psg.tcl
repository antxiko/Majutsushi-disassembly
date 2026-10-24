# omsx_psg.tcl - apunta los 14 registros del PSG en cada cuadro, para cotejar tools/musica.py.
# Variables: PSG_SALIDA (fichero), PSG_DESDE y PSG_HASTA (segundos emulados), PSG_TECLAS como MAJ_TECLAS.
proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}
set throttle off
set ::f [open [opcion PSG_SALIDA work/psg.txt] w]
proc cuadro {} {
    set l {}
    for {set r 0} {$r < 14} {incr r} { lappend l [format %02X [debug read "PSG regs" $r]] }
    puts $::f [join $l " "]
    after frame cuadro
}
foreach k [opcion PSG_TECLAS {}] {
    lassign [split $k :] t f m
    after time $t "keymatrixdown $f $m; after time 0.15 {keymatrixup $f $m}"
}
after time [opcion PSG_DESDE 20] cuadro
after time [opcion PSG_HASTA 40] {close $::f; exit}
