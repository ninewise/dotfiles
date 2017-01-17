#!/bin/sh
uplimit="$(amixer get Master | grep "Limits:" | tr -s ' ' | cut -d' ' -f6)"
lolimit="$(amixer get Master | grep "Limits:" | tr -s ' ' | cut -d' ' -f4)"
current="$(amixer get Master | grep "Mono:"   | tr -s ' ' | cut -d' ' -f4)"
wjt -l "$lolimit" -u "$uplimit" -x "$current" | while read next; do
    amixer -q set Master "$next"
done
