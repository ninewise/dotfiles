#!/bin/sh

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

xset dpms 0 0 50 s off
xset r rate 300 55
# xsetroot -solid "#002a3b"

forklog feh --bg-fill $(find -L /data/pictures/background-source/ -type f | sort -R | head)
forklog redshift -l 51.2:3.75

exec dwm

exec valgrind --extra-debuginfo-path=/data/programming/dwm/ --track-origins=yes --leak-check=full --show-leak-kinds=all dwm
