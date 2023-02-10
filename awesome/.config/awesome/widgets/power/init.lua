local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local icon_button = function(icon_text)
	return wibox.widget {
		markup = "<span size='xx-large' font-weight='bold'>" .. icon_text .. "</span>",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	}
end

-- Power

local power_button = icon_button("  ")
power_button:connect_signal("button::press", function() awful.spawn.with_shell("shutdown now") end)

local restart_button = icon_button("  ")
restart_button:connect_signal("button::press", function() awful.spawn.with_shell("reboot") end)

local logout_button = icon_button(" 󰍃 ")
logout_button:connect_signal("button::press", function() awful.spawn.with_shell("killall xinit") end)

local power_grid = {
	helpers.barItemBackground(power_button),
	helpers.barItemBackground(restart_button),
	helpers.barItemBackground(logout_button),
	layout = wibox.layout.fixed.horizontal,
	spacing = dpi(30)
}

-- End Power

-- Welcome

local welcome = {
	helpers.barItemBackground({
		{
			markup = "<span size='large' font-weight='bold'>Welcome</span>",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		{
			markup = "<span>Smoodle</span>",
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.vertical,
		fill_space = true
	}),
	nil,
	{
		image         = "/home/smoodle/.config/awesome/icons/pfp.png",
		resize        = true,
		forced_height = dpi(100),
		forced_width  = dpi(100),
		widget        = wibox.widget.imagebox
	},
	layout = wibox.layout.align.horizontal,
}
-- End Welcome

local popup_content = {
	{
		welcome,
		power_grid,
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(10)
	},
	widget = wibox.container.margin,
	margins = dpi(20)

}

local popup = awful.popup {
	widget       = popup_content,
	border_color = beautiful.alt_color,
	border_width = 2,
	placement    = awful.placement.bottom_right,
	shape        = gears.shape.rounded_rect,
	ontop        = true,
	visible      = false,
}

awful.placement.bottom_right(popup, { margins = { bottom = dpi(50) } })
popup.placement = nil

local power_widget = {
	markup = "<span color='#d6595c'>  </span>",
	visible = true,
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal('power::toggle')
		end)
	},
	widget = wibox.widget.textbox,
}

local return_bar = helpers.baseBar(power_widget)

awesome.connect_signal('power::toggle', function()
	if popup.visible then
		popup.visible = false
	else
		popup.visible = true
	end
end)

return return_bar
