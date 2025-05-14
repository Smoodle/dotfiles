#!/bin/sh

sleep 1

wpaperd -d &

#(hyprpaper && (sleep 3 && $HOME/.scripts/hyprland/wallpapper.sh)) &

#gammastep -l manual -l 38.736946:-9.142685 -m wayland &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

waybar &

keepassxc &

corectrl --minimize-systray &

steam &
