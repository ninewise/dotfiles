#!/bin/bash

dotfiles=( vimrc Xresources zshrc xinitrc )
configfiles=( herbstluftwm/autostart herbstluftwm/panel.sh )

for file in "${dotfiles[@]}"; do
    cp "$HOME/.$file" "$file"
done

for file in "${configfiles[@]}"; do
    mkdir -p "${file%/*}"
    cp "$HOME/.config/$file" "$file"
done


