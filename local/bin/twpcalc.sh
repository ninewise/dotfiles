#!/bin/bash

# Reading input {{{

# Terminal
read -p "Alias: " alias_
read -s -p "Secret: " secret

echo -n "$secret$alias_" | shasum | sed 's/../\\\\x&/g' | xargs echo -e | base64 | colrm 17

