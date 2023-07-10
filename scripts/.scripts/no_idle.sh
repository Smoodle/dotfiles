#!/bin/bash
#requires:
# 'xprintidle' for inactivity check (in ms)
# 'rand' for generating random number (screen resolution)
# 'xdotool' to move the mouse pointer

#parameters:
# 100000 idle time in ms before executing the mousemove
# 800 / 600: your screen resolution, at at least the moving range for the mouse pointer

while :
do
    if  [ $(xprintidle) -gt 10000 ]
    then
		xPos=$(expr 0 + $RANDOM % 800)
		yPos=$(expr 0 + $RANDOM % 600)
        xdotool mousemove $xPos $yPos;
    fi

    sleep 30
done
