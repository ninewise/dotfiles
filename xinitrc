#!/bin/sh

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

xset dpms 0 0 50 s off
xset r rate 300 55
xsetroot -solid "#002a3b"

forklog xcape -t 80 -e 'Shift_L=Escape;Alt_L=Control_R|G'
forklog xautolock -time 1 -locker slock
forklog redshift -l 51.2:3.75

exec dwm

exec valgrind --extra-debuginfo-path=/data/programming/dwm/ --track-origins=yes --leak-check=full --show-leak-kinds=all dwm
