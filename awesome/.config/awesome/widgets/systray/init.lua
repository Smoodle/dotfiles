local wibox = require("wibox")
local awful = require("awful")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local old_systray = wibox.widget {
		{
			{
				wibox.widget.systray,
				left = dpi(5),
				right = dpi(5),
				top = dpi(2),
				bottom = dpi(2),
				widget = wibox.container.margin,
			},
			bg = beautiful.alt_color,
			shape = helpers.rrect(dpi(4)),
			widget = wibox.container.background,
		},
		margins = dpi(3),
		widget = wibox.container.margin,
}

local systray = helpers.barItemBackground({wibox.widget.systray})

awesome.connect_signal('signals::systray', function(value)
	if value == true then
		systray.visible = true
	else
		systray.visible = false
	end
end)

return systray
