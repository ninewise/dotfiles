#!/bin/sh
where="$(echo "$*" | cut -d'~' -f1)"
who="$(echo "$*" | cut -d'~' -f2)"
what="$(echo "$*" | cut -d'~' -f3)"

notify-send -a weechat "$who" "$what"

