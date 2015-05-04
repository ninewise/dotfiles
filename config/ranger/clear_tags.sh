#!/usr/bin/bash

if [ ! -e "/mnt/memoria/" ]; then
    echo "No memoria"
    exit 1
fi

cat ./tagged | while read file; do
    if [ -e "$file" ]; then
        echo "$file"
    fi
done

