#!/bin/sh

userresources=$XDG_CONFIG_HOME/.Xresources
usermodmap=$XDG_CONFIG_HOME/.Xmodmap
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

# use mouse when key is pressed, for gaming
fix_gaming () {
    if xinput list-props 12 | grep $1 | grep "Disable While Typing Enabled" >& /dev/null; then
        xinput set-prop 12 $1 0
    else
        return 1
    fi
}

fix_gaming 314 || fix_gaming 322

~/.fehbg &
nm-applet &
#pulseeffects --gapplication-service &
$INIT &
exec ${WM:-dwm}
