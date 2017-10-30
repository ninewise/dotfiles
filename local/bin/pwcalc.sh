#!/bin/bash

# Reading input {{{

# Terminal
#read -p "Alias: " alias_
#read -s -p "Secret: " secret

# GUI
alias_="$(zenity --password --title="Password Calculator - Alias" 2> /dev/null)"
secret="$(zenity --password --title="Password Calculator - Secret" 2> /dev/null)"

pass="$(echo -n "$secret$alias_" | shasum | sed 's/../\\\\x&/g' | xargs echo -e | base64 | colrm 17)"

echo -n "$pass" | xclip
echo -n "$pass" | xclip -sel c
notify-send "xclip set to ${pass:0:3}...${pass:(-3):3}"

sleep 2
cat -A /dev/urandom | head -c10 | xclip
cat -A /dev/urandom | head -c10 | xclip -sel c
notify-send "cleaned xclip"

