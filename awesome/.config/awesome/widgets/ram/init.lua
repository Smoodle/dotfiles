local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local ram_text = wibox.widget {
	text   = 'Ram',
	widget = wibox.widget.textbox,
}

local ram_widget = wibox.widget {
    max_value     = 100,
    value         = 50,
    margins       = {
        top = dpi(8),
        bottom = dpi(8),
    },
    forced_height  = dpi(20),
    shape         = gears.shape.rounded_bar,
    bar_shape     = gears.shape.rect,
    color         = beautiful.bg_focus,
    background_color = beautiful.fg_focus,
    border_width  = 0,
    border_color  = beautiful.border_color,
    widget        = wibox.widget.progressbar,
}

awesome.connect_signal("signals::ram", function(value)
	ram_widget.value = value
end)

local ram = wibox.widget {
	{
		ram_text,
		nil,
		ram_widget,
		spacing = dpi(20),
		widget = wibox.layout.fixed.horizontal,
	},
	left = dpi(10),
	right = dpi(10),
	widget = wibox.container.margin,
}

return ram
