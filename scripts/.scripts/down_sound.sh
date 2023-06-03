#!/bin/sh

for f in *
do
	echo "$f" | grep -P '\[(.*?)\]' -o | sed 's/\[sound=//' | sed 's/\]//' | sed -e's/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g' | xargs echo -e | tr " " "\n" | xargs wget
done

