#!/bin/sh

LINUX_LOCATION=~/.local/share/qutebrowser/greasemonkey
MAC_LOCATION=~/Library/ApplicationSupport/qutebrowser/greasemonkey

download() {
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		wget -P $LINUX_LOCATION $1
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		wget -P $MAC_LOCATION $1
	fi
}

clean_folder () {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
	  echo "Removing $LINUX_LOCATION/*"
	  rm -rf "$LINUX_LOCATION"
  elif [[ "$OSTYPE" == "darwin" ]]; then
	  rm -rf "$MAC_LOCATION/*"
  fi
}

clean_folder

download https://www.4chan-x.net/builds/4chan-X.user.js
download https://github.com/KevinParnell/OneeChan/raw/master/builds/OneeChan.user.js
