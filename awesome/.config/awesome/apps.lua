local apps = {
	terminal = "alacritty",
	updater = "alacritty -e paru",
	launcher = "rofi -show drun",
	file_manager = "thunar",
	screenshot = "sh -c ~/.scripts/screenshot",
	vpn = "mullvad-vpn",
	emacs = "emacsclient -c -a 'emacs'"
}

return apps
