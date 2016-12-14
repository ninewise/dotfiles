#!/bin/sh
current="$(amixer get Master | sed -n '/%/s/.*\[\(.*\)%\].*/\1/p' | head -1)"
wjt -t -x "$current" | while read next; do
    amixer -q set Master "$next"
done
