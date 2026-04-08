#!/usr/bin/env bash

swww-daemon && swww img $HOME/Pictures/wallpaper.png &

nm-applet --indicator &
waybar &
mako &
