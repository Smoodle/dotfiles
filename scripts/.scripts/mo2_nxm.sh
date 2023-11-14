#!/bin/bash

echo "GOT ARG $1"

STEAM_COMPAT_CLIENT_INSTALL_PATH=~/.steam/root/ STEAM_COMPAT_DATA_PATH=/home/smoodle/Games/SteamLibrary/steamapps/compatdata/489830/ ~/.steam/root/compatibilitytools.d/GE-Proton8-14/proton run /home/smoodle/Games/SteamLibrary/steamapps/compatdata/489830/pfx/drive_c/Modding/MO2/nxmhandler.exe "$1"
