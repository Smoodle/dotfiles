#!/bin/sh

PREFIX_PATH="/home/smoodle/Games/Skyrim/Prefix"
PROTON_PATH="/home/smoodle/Games/Skyrim/Proton"

WINE="$PROTON_PATH/lutris-GE-Proton8-14-x86_64/bin/wine"

 if [ "$1" = "mo2" ]; then
 	WINEPREFIX="$PREFIX_PATH" $WINE "$PREFIX_PATH/drive_c/Modding/MO2/ModOrganizer.exe"
 fi

if [ "$1" = "install" ]; then
	WINEPREFIX="$PREFIX_PATH" $WINE "$2"
fi
