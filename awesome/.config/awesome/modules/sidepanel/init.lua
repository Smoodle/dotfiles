local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local cpu_bar = require("widgets.cpu")
local ram_bar = require("widgets.ram")

local icon_widget = function (image)
   return wibox.widget {
	  image  = gears.filesystem.get_configuration_dir() .. image,
	  resize = true,
	  widget = wibox.widget.imagebox,
	  forced_height = dpi(50),
	  forced_width = dpi(50),
   }
end

local top = wibox.widget {
   cpu_bar,
   ram_bar,
   widget = wibox.layout.align.vertical
}

local poweroff_widget = icon_widget("/icons/power/power-off.png")
local restart_widget = icon_widget("/icons/power/restart.png")
local logout_widget  = icon_widget("/icons/power/logout.png")

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

local powermenu = wibox.widget {
   {
	  poweroff_widget,
	  restart_widget,
	  logout_widget,
	  expand = "none",
	  layout = wibox.layout.align.horizontal
   },
   bottom = dpi(50),
   left = dpi(50),
   right = dpi(50),
   layout = wibox.container.margin
}

Sidebar = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})

Sidebar.bg = beautiful.bg_normal or "#111111"
Sidebar.fg = beautiful.fg_normal or "#FFFFFF"
Sidebar.opacity = 1
Sidebar.height = screen.primary.geometry.height * 0.30
Sidebar.width = dpi(400)
Sidebar.y = screen.primary.geometry.height * 0.30

--Sidebar.shape = function(cr, width, height)
--   gears.shape.partially_rounded_rect(cr, width, height, false, true, true, false, 30)
--end

Sidebar_toggle = function()
   Sidebar.visible = not Sidebar.visible
end

Sidebar:setup ({
	  {
		 {
			top,
			nil,
			powermenu,
			layout = wibox.layout.align.vertical,
		 },
		 margins = dpi(15),
		 layout = wibox.container.margin
	  },
	  right = dpi(2),
	  top = dpi(2),
	  bottom = dpi(2),
	  color = beautiful.fg_normal,
	  layout = wibox.container.margin
})
