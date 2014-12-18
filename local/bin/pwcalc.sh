#!/bin/bash

# Reading input {{{

# Terminal
#read -p "Alias: " alias_
#read -s -p "Secret: " secret

# GUI
pair="$(zenity --password --username --title="Password Calculator")"
alias_="${pair%|*}"
secret="${pair#*|}"

pass="$(echo -n "$secret$alias_" | shasum | xxd -r -p | base64 | colrm 17)"

echo -n "$pass" | xclip
notify-send "xclip set to ${pass:0:3}...${pass:(-3):3}"

