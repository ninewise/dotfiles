#!/bin/bash

# Reading input {{{

# Terminal
read -p "Alias: " alias_
read -s -p "Secret: " secret

echo -n "$secret$alias_" | shasum | xxd -r -p | base64 | colrm 17

