#!/bin/bash

# Config
name='¡Nucleo Linux Bolivia les desea felices fiestas!'
correction=0

trap "tput reset; tput cnorm; exit" 2
clear

tput civis

line=2
middle_column=$(($(tput cols) / 2))
middle_column=$((middle_column-1))
color=0

new_year=$(date +'%Y')
let new_year

while true; do
    randomValue=$((RANDOM % 10 + 1))
    from_middle=$((middle_column-randomValue))
    column=$((RANDOM % (randomValue) * 2 + 1 + from_middle))
    tput setaf $color; tput bold

    tput cup 1 $column
    echo '*'

    color=$(((color+1)%8))

    from_middle=-2 # from left column
    for l in F E L I Z
    do
        tput cup $((line+1)) $((middle_column+from_middle))
        echo $l
        let from_middle++
        sleep 0.01
    done

    from_middle=-1
    for l in A Ñ O
    do
        tput cup $((line+2)) $((middle_column+from_middle))
        echo $l
        let from_middle++
        sleep 0.01
    done

    from_middle=0
    for l in N U E V O
    do
        tput cup $((line+3)) $((middle_column+from_middle))
        echo $l
        let from_middle++
        sleep 0.01
    done

    spaceCount=$((middle_column/8 + correction))
    spaces=""
    for (( c=1; c<=$spaceCount; c++ ))
    do
        spaces+=" "
    done

    tput cup $((line+4)) 1
    toilet "${spaces}$new_year" --gay -t

    tput setaf $color; tput bold

    tput cup 14 $column
    echo '*'

    tput cup $((line+15)) $((middle_column-(${#name}/2)))
    echo $name
done
