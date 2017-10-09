#!/bin/sh
{
    sleep 1
    xset dpms force off
} &
killall -SIGUSR1 dunst # pause
slock
killall -SIGUSR2 dunst # resume
