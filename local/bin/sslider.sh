#!/bin/sh
if pamixer -v >/dev/null 2>&1; then
	uplimit=100
	lolimit=0
	current="$(pamixer --get-volume)"
	setV() { pamixer --set-volume "$@"; }
else
	control="$(amixer scontrols | sed -n "1s/.*'\(.*\)'.*/\1/p")"
	uplimit="$(amixer get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f6)"
	lolimit="$(amixer get "$control" | grep "Limits:" | tr -s ' ' | cut -d' ' -f4)"
	current="$(amixer get "$control" | sed -n '/dB/{p;q}' | sed 's/.*Playback \([0-9]*\) .*/\1/')"
	setV() { amixer -q set "$control" "$@"; }
fi

wjt -l "$lolimit" -u "$uplimit" -x "$current" | while read next; do setV "$next"; done
