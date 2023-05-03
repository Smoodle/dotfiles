local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local bluetooth_widget = wibox.widget {
	markup = '<span color="'..beautiful.fg_focus..'"></span>',
	--align = 'right',
	widget = wibox.widget.textbox,
}

local main_widget = bluetooth_widget
main_widget.visible = true

bluetooth_widget:connect_signal("button::press", function(_, _, _, _)
	awful.spawn.easy_async({"sh", "-c", "$HOME/.scripts/rofi-bluetooth"}, function(_) end)
end)

return main_widget
