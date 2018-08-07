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

# Natural mouse scrolling
# xmodmap -e "pointer = 1 2 3 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 5 4" &

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

session=${1:-i3}
echo $session
case $session in
	i3|i3wm)
		exec i3;;
	flux)
		exec startfluxbox;;
	monad)
		exec xmonad;;
	steam)
		xrandr --output DVI-I-1 --primary
		exec steam;;
	*)
		exec $1;;

esac

xset +fp $HOME/.fonts
xset fp rehash
# exec i3
# exec startfluxbox
