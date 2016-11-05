#!/bin/sh

userresources=$HOME/.config/Xresources
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

# My lovely bar
bar() {
    while sleep 1; do
        xsetroot -name "B$(acpi -b | tr -d ' ' | cut -d',' -f2)   $(date +'%a %d %b, %I:%M')"
    done
}


# Forking graphical programs
forklog() {
    $* 2>&1 | logger &
}

forklog xcape -t 100 -e 'Super_L=Scroll_Lock;Shift_L=Escape'
forklog sh ~/.fehbg
forklog xautolock -time 1 -locker slock
forklog redshift -l 51.2:3.75
forklog xset dpms 0 0 50 s off
forklog bar

#forklog sxhkd -c ~/.config/sxhkd/sxhkd.conf
#exec nwm

exec dwmdb
