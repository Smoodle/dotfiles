local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local poweroff_widget = wibox.widget {
    {
        image  = "/home/smoodle/.config/awesome/modules/powermenu/icons/poweroff.svg",
        resize = true,
        widget = wibox.widget.imagebox,
    },
    {
        text   = 'Power Off',
        widget = wibox.widget.textbox,
        align = "center"
    },

    layout  = wibox.layout.align.vertical,
    forced_height = dpi(300),
    forced_width = dpi(200),
    --expand = "none"
}

local poweroff = function ()
    awful.spawn.with_shell("shutdown now")
end

poweroff_widget:connect_signal("button::press", poweroff)

local restart_widget = wibox.widget {
    {
        image  = "/home/smoodle/.config/awesome/modules/powermenu/icons/restart.png",
        resize = true,
        widget = wibox.widget.imagebox,
    },
    {
        text   = 'Restart',
        widget = wibox.widget.textbox,
        align = "center"
    },

    layout  = wibox.layout.align.vertical,
    forced_height = dpi(300),
    forced_width = dpi(200),
    --expand = "none"
}

local restart = function ()
    awful.spawn.with_shell("reboot")
end

restart_widget:connect_signal("button::press", restart)

local power_menu = awful.popup {
    widget = {
        {
            poweroff_widget,
            restart_widget,
            layout = wibox.layout.flex.horizontal,
            spacing = dpi(30)
        },
        margins = 10,
        widget  = wibox.container.margin
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
