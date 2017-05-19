#!/bin/sh
notmuch address --format=json --output=recipients --output=sender --deduplicate=address from:"$*" OR to:"$*" | rg -i "$*"
