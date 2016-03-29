
case $1 in
    klein) curl --data "command=set_pos&posX=0&posY=12"  kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi ;;
    groot) curl --data "command=set_pos&posX=50&posY=10" kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi ;;
    zetel) curl --data "command=set_pos&posX=50&posY=22" kelder.zeus.ugent.be/webcam/cgi/ptdc.cgi ;;
esac > /dev/null

curl http://kelder.zeus.ugent.be/webcam/video/mjpg.cgi | mpv --no-correct-pts --fps 5 -
