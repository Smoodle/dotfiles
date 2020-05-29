#!/bin/sh

#Keyboard settings
setxkbmap pt -option "ctrl:nocaps" &
xset r rate 280 40 &
xset -dpms
xset s off

# Remove mouse after 3 seconds
unclutter --timeout 3 &

#Wallpapper
feh --bg-scale ~/Pictures/Wallpapers/1588133874953.jpg ~/Pictures/Wallpapers/1588715831828.png

#Applications
