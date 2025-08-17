#!/usr/bin/env bash

swww init && swww img $HOME/Pictures/neon-shallows.webp &

nm-applet --indicator &
waybar &
mako &

# make screensharing work
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &
