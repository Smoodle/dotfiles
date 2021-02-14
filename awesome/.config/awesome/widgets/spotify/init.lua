local awful = require("awful")
local wibox = require("wibox")

local previous_icon = {
		image = "/home/smoodle/.config/awesome/widgets/spotify/icons/previous.png",
		resize = true,
		widget = wibox.widget.imagebox
}

local play_pause_icon = {
		image = "/home/smoodle/.config/awesome/widgets/spotify/icons/play.png",
		resize = true,
		widget = wibox.widget.imagebox
}

local next_icon = {
		image = "/home/smoodle/.config/awesome/widgets/spotify/icons/next.png",
		resize = true,
		widget = wibox.widget.imagebox
}

local spotify_controlls = {
	previous_icon,
	play_pause_icon,
	next_icon,
	visible = false,
	widget = wibox.layout.fixed.horizontal
}

local spotify = {
	image = "/home/smoodle/.config/awesome/widgets/spotify/icons/spotify.png",
	resize = true,
	visible = false,
	spacing = 30,
	widget = wibox.widget.imagebox
}

return spotify_controlls
