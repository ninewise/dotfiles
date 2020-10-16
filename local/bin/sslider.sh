#!/bin/sh
card="$(aplay -l | sed -n 's/^card [0-9]*: \(\w*\).*/\1/p' | tail -1)"
#card=PCH
control="$(amixer -c "$card" scontrols | sed -n "1s/.*'\(.*\)'.*/\1/p")"

uplimit="$(amixer -c "$card" get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f6)"
lolimit="$(amixer -c "$card" get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f4)"
current="$(amixer -c "$card" get "$control" | sed -n '/dB/{p;q}' | sed 's/.*Playback \([0-9]*\) .*/\1/')"
wjt -l "$lolimit" -u "$uplimit" -x "$current" | while read next; do
    amixer -c "$card" -q set "$control" "$next"
done
