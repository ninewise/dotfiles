#!/bin/sh

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

forklog xcape -t 80 -e 'Super_L=Scroll_Lock;Shift_L=Escape;Alt_L=Control_R|G'
forklog xautolock -time 1 -locker slock
forklog redshift -l 51.2:3.75
forklog xset dpms 0 0 50 s off
forklog xset r rate 300 55

xsetroot -solid "#002a3b"

exec valgrind --extra-debuginfo-path=/data/programming/dwm/ --track-origins=yes --leak-check=full --show-leak-kinds=all dwm
