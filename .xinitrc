#!/bin/bash
#
# ~/.xinitrc
#

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xset +fp /usr/share/fonts/local
xset fp rehash
xsetroot -cursor_name left_ptr &
unclutter -idle 2 -jitter 2 -root &
urxvtd -q -o -f &

exec dbus-launch xmonad
