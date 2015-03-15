#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# For now, start stuff here
redshift &
dunst &
xcape -t 100 -e 'Super_L=Scroll_Lock;Shift_L=Escape'
feh  --bg-scale '/home/felix/Pictures/lain.png' &
# screen locking
xset dpms 0 0 50 &
xset s off &
xautolock -time 1 -locker i3lock-fancy &

# Start herbstluftwm in locked mode. Is unlocked after autostart.
#exec herbstluftwm --locked
exec xmonad
