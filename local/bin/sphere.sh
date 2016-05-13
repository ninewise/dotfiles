
case $1 in
    scrot) foto="$(mktemp XXXXXX.jpg)"
           curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi \
               | ffmpeg -y -ss 0 -i - -vframes 1 -q:v 2 "$foto"
           feh "$foto"
           rm "$foto"
           ;;
    klein) curl --data "command=set_pos&posX=0&posY=12"  kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi  ;;
    groot) curl --data "command=set_pos&posX=50&posY=10" kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi  ;;
    zetel) curl --data "command=set_pos&posX=50&posY=22" kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi  ;;
    *)     curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi | mpv --no-correct-pts --fps 4.5 - ;;
esac > /dev/null 2>&1

