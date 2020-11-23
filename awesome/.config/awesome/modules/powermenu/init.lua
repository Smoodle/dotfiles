local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local poweroff_widget = wibox.widget {
    {
        image  = gears.filesystem.get_configuration_dir() .. "/modules/powermenu/icons/power-off.png",
        resize = true,
        widget = wibox.widget.imagebox,
        forced_height = dpi(100),
        forced_width = dpi(100),
    },
    {
        markup = "<span size='x-large' font-weight='bold'>Power off</span>",
        widget = wibox.widget.textbox,
        align = "center"
    },

    layout  = wibox.layout.align.vertical,
}

local poweroff = function ()
    awful.spawn.with_shell("shutdown now")
end

poweroff_widget:connect_signal("button::press", poweroff)

local restart_widget = wibox.widget {
    {
        image  = gears.filesystem.get_configuration_dir() .. "/modules/powermenu/icons/restart.png",
        resize = true,
        widget = wibox.widget.imagebox,
        forced_height = dpi(100),
        forced_width = dpi(100),
    },
    {
        markup = "<span size='x-large' font-weight='bold'>Restart</span>",
        widget = wibox.widget.textbox,
        align = "center"
    },

    layout  = wibox.layout.align.vertical,
}

local restart = function ()
    awful.spawn.with_shell("reboot")
end

restart_widget:connect_signal("button::press", restart)

local logout_widget = wibox.widget {
    {
        image  = gears.filesystem.get_configuration_dir() .. "/modules/powermenu/icons/logout.png",
        resize = true,
        widget = wibox.widget.imagebox,
        forced_height = dpi(100),
        forced_width = dpi(100),
    },
    {
        markup = "<span size='x-large' font-weight='bold'>Logout</span>",
        widget = wibox.widget.textbox,
        align = "center"
    },

    layout  = wibox.layout.align.vertical,
}

local logout = function ()
    awful.spawn.with_shell("killall xinit")
end

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
            layout = wibox.layout.align.vertical,
        },
        margins = dpi(10),
        widget  = wibox.container.margin,
    },
    placement    = awful.placement.centered,
    shape        = gears.shape.rounded_rect,
    visible      = false,
    ontop = true,
}

power_menu.toggle_power_menu = function ()
    power_menu.visible = not power_menu.visible
end

return power_menu
