#!/bin/sh

jp_vert () {
	scrot "/tmp/screenshot" -s -o -e 'tesseract -l jpn_vert --oem 3 --psm 5 $f - | tr -d " " | xclip -selection clipboard -i && rm $f'
}

jp () {
	scrot "/tmp/screenshot" -s -o -e 'tesseract -l jpn --oem 3 --psm 3 $f - | tr -d " " | xclip -selection clipboard -i && rm $f'
}

cmd="echo $'Japanese\nJapanese Vertical' | rofi -p OCR -dmenu"
input=$(eval "$cmd")

if [ "$input" = "Japanese" ];then
	jp
elif [ "$input" = "Japanese Vertical" ];then
	jp_vert
fi;
