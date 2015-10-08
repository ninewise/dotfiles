#!/bin/bash

# choose MAC address
mac="$(dmenu <<HERE
headset 00:11:67:11:18:9B
zeusplay 60:E3:27:09:12:DE
HERE
)"

command="connect ${mac#* }"

if ! pgrep pulseaudio; then pulseaudio --start 2> /dev/null ; fi
cat "$command" <(echo "quit") \
    | bluetoothctl > /dev/null 2>&1

