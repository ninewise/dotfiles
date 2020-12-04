#!/bin/sh
control="$(amixer scontrols | sed -n "1s/.*'\(.*\)'.*/\1/p")"

uplimit="$(amixer get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f6)"
lolimit="$(amixer get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f4)"
current="$(amixer get "$control" | sed -n '/dB/{p;q}' | sed 's/.*Playback \([0-9]*\) .*/\1/')"
wjt -l "$lolimit" -u "$uplimit" -x "$current" | while read next; do
    amixer -q set "$control" "$next"
done
