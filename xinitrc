#!/bin/sh

# My lovely bar
bar() {
    while sleep 1; do
        xsetroot -name "B$(acpi -b | tr -d ' ' | cut -d',' -f2)   $(date +'%a %d %b, %I:%M')"
    done
}


# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

forklog xcape -t 80 -e 'Super_L=Scroll_Lock;Shift_L=Escape;Alt_L=Control_R|G'
forklog sh ~/.fehbg
forklog xautolock -time 1 -locker slock
forklog redshift -l 51.2:3.75
forklog xset dpms 0 0 50 s off
forklog xset r rate 300 55
forklog bar

#forklog sxhkd -c ~/.config/sxhkd/sxhkd.conf
#exec nwm

exec dwmdb
