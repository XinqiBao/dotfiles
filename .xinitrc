#!/bin/sh

xrandr --output eDP1 --mode 1920x1080
xwallpaper --zoom ~/pic/death-stranding_3.png
setxkbmap -option caps:escape

X_DIR=~/.config/x11
[[ -f $X_DIR/xbindkeysrc ]] && xbindkeys -f $X_DIR/xbindkeysrc
[[ -f $X_DIR/xresources ]] && xrdb -merge $X_DIR/xresources

autostart="xcompmgr slstatus fcitx5"
for program in $autostart; do
    pidof -s "$program" || setsid -f "$program"
done > /dev/null 2>&1

exec dwm
