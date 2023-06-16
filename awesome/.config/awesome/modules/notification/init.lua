local helpers = require("helpers")
local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local main_widget = wibox.widget {
	markup = " ",
	align = "center",
	widget = wibox.widget.textbox,
	visible = true
}

local notif_content = wibox.widget {
	base_layout = wibox.widget {
		spacing = dpi(10),
		layout  = wibox.layout.fixed.vertical
	},
	widget_template = {
		{
			{
				naughty.widget.icon,
				{
					naughty.widget.title,
					naughty.widget.message,
					naughty.list.widgets,
					layout = wibox.layout.align.vertical
				},
				spacing = dpi(5),
				resize = true,
				layout  = wibox.layout.flex.horizontal
			},
			bg = beautiful.alt_color,
			widget = wibox.container.background,
		},
		bottom = dpi(5),
		widget  = wibox.container.margin
	},
	widget = naughty.list.notifications,
}

local notification_popup = awful.popup {
	widget = {
		{
			{
				markup = "Notifications",
				align = "center",
				widget = wibox.widget.textbox
			},
			notif_content,
			spacing = dpi(10),
			layout        = wibox.layout.fixed.vertical
		},
		margins = dpi(5),
		widget = wibox.container.margin
	},
	placement    = awful.placement.right,
	shape        = gears.shape.rounded_rect,
	ontop        = true,
	visible      = false,
}

naughty.connect_signal("added", function ()
	if #naughty.active > 0 then
		main_widget.markup = '<span color="'..beautiful.fg_focus..'"> </span>'
	else
		main_widget.markup = ' '
	end
end)

naughty.connect_signal("destroyed", function ()
	if #naughty.active > 0 then
		main_widget.markup = '<span color="'..beautiful.fg_focus..'"> </span>'
	else
		main_widget.markup = ' '

		if notification_popup.visible == true then
			notification_popup.visible = false
		end
	end
end)

main_widget:connect_signal("button::press", function(_, _, _, _)
	notification_popup.visible = not notification_popup.visible
end)

return main_widget
