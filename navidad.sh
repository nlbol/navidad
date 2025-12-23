#!/bin/bash

cleanup() {
    tput reset
    tput cnorm
    if [ -n "$AUDIO_PID" ]; then
        kill "$AUDIO_PID" 2>/dev/null
        pkill -P "$AUDIO_PID" 2>/dev/null
    fi
}

trap cleanup EXIT INT TERM

clear
tput civis

./audio-loop.sh >/dev/null 2>&1 &
AUDIO_PID=$!

lin=2
cols=$(tput cols)
center=$((cols / 2))
c=$((center - 1))
color=0

tput setaf 2
tput bold

for ((i=1; i<20; i+=2)); do
    tput cup "$lin" "$((center - i/2))"
    printf '%*s' "$i" '' | tr ' ' '*'
    ((lin++))
done

tput sgr0
tput setaf 3

for ((i=0; i<2; i++)); do
    tput cup "$((lin+i))" "$((center - 1))"
    echo "mWm"
done
lin=$((lin + 2))

new_year=$(( $(date +'%Y') + 1 ))

msg1="FELIZ NAVIDAD NUCLEO LINUX BOLIVIA"
msg2="Y mucho CODIGO el $new_year"

tput setaf 1
tput bold
tput cup "$lin"     "$((center - ${#msg1}/2))"; echo "$msg1"
tput cup "$((lin+1))" "$((center - ${#msg2}/2))"; echo "$msg2"

((lin += 2))

declare -A line column
k=1

while true; do
    for ((i=1; i<=35; i++)); do

        if (( k > 1 )); then
            prev=$((k-1))
            tput setaf 2
            tput bold
            tput cup "${line[$prev,$i]}" "${column[$prev,$i]}"
            echo "*"
            unset line["$prev,$i"]
            unset column["$prev,$i"]
        fi

        li=$((RANDOM % 9 + 3))
        half=$((li - 1))
        co=$((center - half + RANDOM % (li * 2)))

        tput setaf "$color"
        tput bold
        tput cup "$li" "$co"
        echo "o"

        line["$k,$i"]=$li
        column["$k,$i"]=$co

        color=$(((color + 1) % 8))

        sh=1
        for l in C O D I G O; do
            tput cup "$((lin))" "$((center - 3 + sh))"
            echo "$l"
            ((sh++))
            sleep 0.01
        done
    done
    k=$((k % 2 + 1))
done
