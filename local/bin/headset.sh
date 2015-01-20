#!/bin/bash
if ! pgrep pulseaudio; then pulseaudio --start; fi
cat <(echo "connect 00:11:67:11:18:9B") <(echo "quit") | bluetoothctl

