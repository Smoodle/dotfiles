local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local settings_widget = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "/widgets/settings/icons/settings.png",
    resize = true,
    visible = true,
    widget = wibox.widget.imagebox
}

local pop = awful.popup {
    widget = wibox.widget {
        text = "teste",
        widget = wibox.widget.textbox
    },
    ontop = true,
    offset = {
        t = dpi(5),
    },
    visible = false,
    shape = gears.shape.rounded_rect,
}

settings_widget:connect_signal("button::press", function()
    if(pop.visible) then
        pop.visible = false
    else
        pop:move_next_to(mouse.current_widget_geometry)
    end
end)

return settings_widget
