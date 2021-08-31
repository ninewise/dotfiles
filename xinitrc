#!/bin/sh

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

case "$(hostname)" in
mantle) xset dpms 0 0 300 s off ; backimg="bgs -z" ;;
abysm) xset dpms 0 0 50 s off ; backimg="feh --bg-fill" ;;
esac

xset r rate 300 55

forklog $backimg $(find -L /data/pictures/background-source/ -type f | sort -R | head)
forklog redshift

exec xmonad
