local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local icon_widget = function (text, image)
	return wibox.widget {
		{
			image  = gears.filesystem.get_configuration_dir() .. image,
			resize = true,
			widget = wibox.widget.imagebox,
			forced_height = dpi(100),
			forced_width = dpi(100),
		},
		{
			markup = "<span size='x-large' font-weight='bold'>" .. text .. "</span>",
			widget = wibox.widget.textbox,
			align = "center"
		},
		nil,
		layout  = wibox.layout.fixed.vertical,
		fill_space = true,
		spacing = dpi(10)
	}
end

local poweroff_widget = icon_widget("Power off", "/modules/powermenu/icons/power-off.png")
local restart_widget = icon_widget("Restart", "/modules/powermenu/icons/restart.png")
local logout_widget  = icon_widget("Logout", "/modules/powermenu/icons/logout.png")

local poweroff = function ()
	awful.spawn.with_shell("shutdown now")
end

local restart = function ()
	awful.spawn.with_shell("reboot")
end

local logout = function ()
	awful.spawn.with_shell("killall xinit")
end

poweroff_widget:connect_signal("button::press", poweroff)
restart_widget:connect_signal("button::press", restart)
logout_widget:connect_signal("button::press", logout)

local power_menu = awful.popup {
	widget = {
		{
			{
				nil,
				{
					markup = "<span size='xx-large' font-weight='bold'>GoodBye!</span>",
					align = "center",
					valign = "center",
					widget = wibox.widget.textbox,
				},
				nil,
				layout = wibox.layout.align.horizontal,
				expand = "outside",
			},
			{
				poweroff_widget,
				restart_widget,
				logout_widget,
				layout = wibox.layout.flex.horizontal,
				expand = "none",
				spacing = dpi(40)
			},
			nil,
			layout = wibox.layout.fixed.vertical,
			fill_space = true,
			spacing = dpi(20)
		},
		margins = dpi(20),
		widget  = wibox.container.margin,
	},
	placement    = awful.placement.centered,
	shape        = gears.shape.rounded_rect,
	visible      = false,
	ontop = true,
}

power_menu:connect_signal("mouse::leave", function()
	power_menu.visible = not power_menu.visible
end)

power_menu.toggle_power_menu = function ()
	power_menu.visible = not power_menu.visible
end

return power_menu
