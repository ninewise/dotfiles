#!/bin/bash
curl -IL "$1" \
    | grep Content-Type \
    | tail -n 1 \
    | grep image && rifle "$1" || xdg-open "$1"
