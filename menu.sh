#!/bin/bash

PID_NAVIDAD="/tmp/nucleolinux-navidad.pid"
PID_ANIONUEVO="/tmp/nucleolinux-anionuevo.pid"

home="$(pwd)"
chmod +x *.sh

navidad() {
    terminator -f --title="NLBOL" -M -e "$home/navidad.sh" >/dev/null 2>&1 &
    echo $! > "$PID_NAVIDAD"
}

an() {
    terminator -f --title="NLBOL" -M -e "$home/an.sh" >/dev/null 2>&1 &
    echo $! > "$PID_ANIONUEVO"
}

detener() {

    # ---- NAVIDAD ----
    if [ -f "$PID_NAVIDAD" ]; then
        echo "Deteniendo Navidad..."
        killall -15 navidad.sh 2>/dev/null
        killall -15 audio-loop.sh 2>/dev/null
        killall -15 paplay 2>/dev/null
        pkill -f "$home/navidad.sh" 2>/dev/null
	pkill -15 -f "python3 .*terminator --title=NLBOL"
        rm -f "$PID_NAVIDAD"
    fi

    # ---- AÑO NUEVO ----
    if [ -f "$PID_ANIONUEVO" ]; then
        echo "Deteniendo Año Nuevo..."
        killall -15 an.sh 2>/dev/null
        killall -15 audio-loop.sh 2>/dev/null
        killall -15 paplay 2>/dev/null
        pkill -f "$home/an.sh" 2>/dev/null
        pkill -15 -f "python3 .*terminator --title=NLBOL"
        rm -f "$PID_ANIONUEVO"
    fi
}

salir() {
    detener
    clear
    exit 0
}

main() {
    clear
    cat <<EOF
=========================
          MENU
=========================

1.- Navidad
2.- Detener
3.- Feliz Año Nuevo
4.- Salir

EOF

    read -rp "Elegir opción: " option

    case "$option" in
        1) navidad ;;
        2) detener ;;
        3) an ;;
        4) salir ;;
        *) echo "Opción inválida"; sleep 1 ;;
    esac
}

while true; do
    main
done
