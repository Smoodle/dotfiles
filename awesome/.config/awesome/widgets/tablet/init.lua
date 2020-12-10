local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local tablet_widget = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "/widgets/tablet/icons/drawing-tablet.png",
    resize = true,
    widget = wibox.widget.imagebox,
    visible = false
}

local tablet_mode = wibox.widget {
    {
        markup = '<b>Tablet Modes</b>',
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    },
    top = dpi(5),
    bottom = dpi(5),
    left = dpi(15),
    right = dpi(15),
    widget = wibox.container.margin
}

local screen_widget = wibox.widget {
    {
        {
            text = 'Map to Screen',
            align = 'center',
            widget = wibox.widget.textbox
        },
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(15),
        right = dpi(15),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_focus,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
}

local osu_widget = wibox.widget {
    {
        {
            text = 'Osu',
            align = 'center',
            widget = wibox.widget.textbox
        },
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(15),
        right = dpi(15),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_focus,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
}

local reset_widget = wibox.widget {
    {
        {
            text = 'Reset',
            align = 'center',
            widget = wibox.widget.textbox
        },
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(15),
        right = dpi(15),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_focus,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background
}

local popup_content = wibox.widget {
    {
        tablet_mode,
        screen_widget,
        osu_widget,
        reset_widget,
        spacing = dpi(10),
        layout = wibox.layout.flex.vertical
    },
    margins = dpi(15),
    widget = wibox.container.margin
}

local popup = awful.popup {
    widget = popup_content,
    ontop = true,
    visible = false,
    offset = {
        y = dpi(5),
    },
    shape = gears.shape.rounded_rect
}

screen_widget:connect_signal("button::press", function()
    awful.util.spawn_with_shell("sh /home/smoodle/.scripts/tablet/reset_wacom.sh && sh /home/smoodle/.scripts/tablet/map_to_output.sh")
    popup.visible = false
end)


reset_widget:connect_signal("button::press", function()
    awful.util.spawn_with_shell("sh /home/smoodle/.scripts/tablet/reset_wacom.sh")
    popup.visible = false
end)


osu_widget:connect_signal("button::press", function()
    awful.util.spawn_with_shell("sh /home/smoodle/.scripts/tablet/reset_wacom.sh && sh /home/smoodle/.scripts/tablet/wacom_small.sh")
    popup.visible = false
end)

tablet_widget:connect_signal("button::press", function(_, _, _, button)
    if(popup.visible) then
        popup.visible = false
    else
        popup:move_next_to(mouse.current_widget_geometry)
    end
end
) 

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async({"sh", "-c", "xsetwacom --list devices | wc -l"}, function(out)
                if(out == "0\n") then
                    tablet_widget.visible = false
                    popup.visible = false
                else
                    tablet_widget.visible = true
                end
            end)
        end
    }

return tablet_widget;
