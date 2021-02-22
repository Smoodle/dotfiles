local awful = require("awful")
local gears = require ("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local ram_widget = wibox.widget {
	markup = '',
	align = 'center',
	widget = wibox.widget.textbox
}

gears.timer {
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({"sh", "-c", "free | grep Mem | awk '{printf(\"%.2f\"), $3/$2 * 100.0}'"}, function(out)
			ram_widget.markup = '<span color="'..beautiful.bg_focus..'">Ram </span>' .. tonumber(out) .. "%"
		end)
	end}

return ram_widget
