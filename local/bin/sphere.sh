#!/bin/sh

cmd_url="https://kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi"

if [ -n "$1" ]; then
    while [ -n "$1" ]; do
        case $1 in
            scrot) foto="$(mktemp XXXXXX.jpg)"
                   curl -L http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi \
                       | ffmpeg -y -ss 0 -i - -vframes 1 -q:v 2 "$foto"
                   feh "$foto"
                   rm "$foto"
                   ;;
            klein) curl --data "command=set_pos&posX=28&posY=16"          "$cmd_url"  ;;
            groot) curl --data "command=set_pos&posX=60&posY=6"           "$cmd_url"  ;;
            zetel) curl --data "command=set_pos&posX=10&posY=12"          "$cmd_url"  ;;
            r|\>)  curl --data "command=set_relative_pos&posX=10&posY=0"  "$cmd_url"  ;;
            l|\<)  curl --data "command=set_relative_pos&posX=-10&posY=0" "$cmd_url"  ;;
            d|v)   curl --data "command=set_relative_pos&posX=0&posY=-5"  "$cmd_url"  ;;
            u|\^)  curl --data "command=set_relative_pos&posX=0&posY=5"   "$cmd_url"  ;;
        esac > /dev/null 2>&1
        shift
    done
else
    mpv --no-correct-pts --fps=6 http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi 
fi


