#!/bin/bash
set -e

PATH="/Media/Wallpapers"
MIN_WIDTH=2560
MIN_HEIGTH=1440

/usr/bin/mkdir -p "$PATH/to_delete"

echo "Moving files"

for file in $PATH/*; do
	if [[ $file == *.jpg ]] || [[ $file == *.png ]] || [[ $file == *.gif ]]; then
		echo "Checking $file"

		if [[ $(/usr/bin/identify -format "%w" "$file") -lt $MIN_WIDTH ]] || [[ $(/usr/bin/identify -format "%h" "$file") -lt $MIN_HEIGTH ]]; then
			/usr/bin/mv "$file" $PATH/to_delete
		fi
	fi
done

echo "Done"
