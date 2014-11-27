#!/bin/bash

files="$(ls ~/.vimrc ~/.Xresources ~/.zshrc)"

echo "$files" | while read file; do
    cp "$file" "${file##*/.}"
done


