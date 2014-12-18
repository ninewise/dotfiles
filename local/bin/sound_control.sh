#!/bin/bash

command="${1:=toggle}"

current="$(amixer get Master | sed -n '/%/s/.*\[\(.*\)%\].*/\1/p' | head -1)"

case $command in
    toggle) amixer set Master toggle ;;
    down)   amixer set Master "$((current - 5))%" ;;
    up)     amixer set Master "$((current + 5))%" ;;
    *)      notify-send "learn to volume" ;;
esac
