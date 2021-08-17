#!/bin/sh

# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

case "$(hostname)" in
mantle) xset dpms 0 0 300 s off ;;
abysm) xset dpms 0 0 50 s off ;;
esac

xset r rate 300 55

forklog bgs -z $(find -L /data/pictures/background-source/ -type f | sort -R | head)
forklog redshift

exec xmonad
