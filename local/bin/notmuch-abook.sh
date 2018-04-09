#!/bin/sh
notmuch address --output=recipients --output=sender --deduplicate=address from:'*'"$*"'*' OR to:'*'"$*"'*' \
	| grep -i "$*" \
	| grep -v noreply \
	| sort | uniq
