wget "$(xclip -o)" -O "eztv_add_selection.html"
cat "eztv_add_selection.html" | grep 'class="magnet"' | sed 's/.*\("magnet:[^"]*"\).*/\1/' | xargs transmission-remote --add
rm "eztv_add_selection.html"
