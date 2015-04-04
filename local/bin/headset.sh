#!/bin/bash
if ! pgrep pulseaudio; then pulseaudio --start 2> /dev/null ; fi
cat <(echo "connect 00:11:67:11:18:9B") <(echo "quit") \
    | bluetoothctl 2> /dev/null 2>&1

