#!/bin/bash

files="$(ls ~/.vimrc ~/.Xresources ~/.zshrc ~/.xinitrc)"

echo "$files" | while read file; do
    cp "$file" "${file##*/.}"
done


