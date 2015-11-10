#!/bin/bash

command="${1:=toggle}"

current="$(amixer get Master | sed -n '/%/s/.*\[\(.*\)%\].*/\1/p' | head -1)"

case $command in
    toggle) amixer -q set Master toggle ;;
    down)   amixer -q set Master "$((current - 5))%" ;;
    up)     amixer -q set Master "$((current + 5))%" ;;
    *)      notify-send "learn to volume" ;;
esac

sound_notification.sh

