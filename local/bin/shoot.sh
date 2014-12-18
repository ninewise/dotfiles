#!/bin/bash

file="$(mktemp XXXXXX.png)"
scrot $* "$file"
chmod 755 $file
scp -P 2222 "$file" ftper@178.116.153.116:'~/Pictures'
rm "$file"
url="http://178.116.153.116:8080/$file"
notify-send "Screenshot uploaded to $url"
echo "$url" | xclip -sel c

