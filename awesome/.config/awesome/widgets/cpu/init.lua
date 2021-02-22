local awful = require("awful")
local gears = require ("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local cpu_widget = wibox.widget {
	markup = '',
	align = 'center',
	widget = wibox.widget.textbox
}

gears.timer {
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({"sh", "-c", "top -bn1 | grep \"Cpu(s)\" | sed \"s/.*, *\\([0-9.]*\\)%* id.*/\\1/\" | awk '{print 100 - $1}'"}, function(out)
			cpu_widget.markup = '<span color="'..beautiful.bg_focus..'">Cpu </span>'..tonumber(out).."%"
		end)
	end}

return cpu_widget
