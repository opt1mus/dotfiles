#!/bin/bash
#
# ~/.xinitrc
#

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

mkdir -p $XDG_RUNTIME_DIR/webkit
touch $XDG_RUNTIME_DIR/{cookies,history}.db
ln -sfn $XDG_RUNTIME_DIR/webkit ~/.local/share/webkit
ln -sf $XDG_RUNTIME_DIR/cookies.db ~/.local/share/luakit/cookies.db
ln -sf $XDG_RUNTIME_DIR/history.db ~/.local/share/luakit/history.db

xset -b &
xset +fp /usr/share/fonts/local
xset fp rehash &
xsetroot -cursor_name left_ptr &

# hanns.g
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --output LVDS --mode 1600x1200 --addmode VGA-0 1920x1080_60.00
xrandr --output VGA-0 --mode 1920x1080_60.00 --left-of LVDS

unclutter -idle 2 -jitter 2 -root &
urxvtd -q -o -f &

exec dbus-launch xmonad
