#!/usr/bin/env bash

swww init && swww img $HOME/Pictures/neon-shallows.webp &

nm-applet --indicator &
waybar &
mako &
