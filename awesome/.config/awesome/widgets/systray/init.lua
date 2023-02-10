local wibox = require("wibox")
local awful = require("awful")

local sys_left_icon = ""
local sys_right_icon = ""

local togglertext = wibox.widget {
	text = sys_left_icon,
	valign = "center",
	align = "center",
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal('systray::toggle')
		end)
	},
	widget = wibox.widget.textbox,
}

local systray = wibox.widget {
	{
		widget = wibox.widget.systray,
	},
	visible = false,
	widget = wibox.layout.fixed.horizontal
}

local systray_widget = wibox.widget {
	systray,
	togglertext,
	widget = wibox.layout.fixed.horizontal
}

awesome.connect_signal('systray::toggle', function()
	if systray.visible then
		systray.visible = false
		togglertext.text = sys_left_icon
	else
		systray.visible = true
		togglertext.text = sys_right_icon
	end
end)

return systray_widget
