# lanza_maj.ps1 <dir> "<tiempos>" "<teclas>" "<pokes>": UN openMSX (MSX2) con tools/omsx_maj.tcl, fuera del sandbox.
param([string]$dir, [string]$tiempos = "5 10 20", [string]$teclas = "", [string]$pokes = "", [string]$rom = "majutsushi.rom", [string]$maquina = "C-BIOS_MSX2", [string]$tipo = "Majutsushi")
$raiz = Split-Path -Parent $PSScriptRoot
Set-Location $raiz
$env:MAJ_SALIDA = "work/$dir"
$env:MAJ_TIEMPOS = $tiempos
$env:MAJ_TECLAS = $teclas
$env:MAJ_POKES = $pokes
New-Item -ItemType Directory -Force "work/$dir" | Out-Null
$args_ = @("-machine", $maquina, "-carta", $rom, "-romtype", $tipo, "-script", "tools/omsx_maj.tcl")
Start-Process -FilePath "C:\Program Files\openMSX\openmsx.exe" -ArgumentList $args_ -Wait -WindowStyle Minimized
"hecho" | Out-File -Encoding ascii "work/$dir/fin.txt"
