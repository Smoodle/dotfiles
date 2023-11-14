#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

bg=#24273a
fg=#cad3f5

interval=0

# load colors
#. ~/.config/chadwm/scripts/bar_themes/onedark

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$fg^^b$bg^ CPU"
  printf "^c$fg^^b$bg^ $cpu_val"
}

pkg_updates() {
  #updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
  updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
  # updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)

  if [ -z "$updates" ]; then
    printf "^c$fg^  Fully Updated"
  else
    printf "^c$fg^  $updates"" updates"
  fi
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT0/capacity)"
  printf "^c$fg^   $get_capacity"
}

brightness() {
  printf "^c$red^   "
  printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
  printf "^c$fg^^b$bg^  "
  printf "^c$fg^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected" ;;
	down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$fg^^b$bg^ 󱑆 "
	printf "^c$fg^^b$bg^ $(date '+%d/%m/%y %H:%M') "
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$(cpu) $(mem) $(clock)"
  #sleep 1 && echo "$updates $(cpu) $(mem) $(clock)"
done
