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

xset -b
xset +fp /usr/share/fonts/local
xset fp rehash
xsetroot -cursor_name left_ptr &
unclutter -idle 2 -jitter 2 -root &
urxvtd -q -o -f &

exec dbus-launch xmonad
