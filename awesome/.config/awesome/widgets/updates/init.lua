local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local helpers = require("helpers")

local update_widget = wibox.widget {
	markup = '',
	align = 'center',
	widget = wibox.widget.textbox
}

local main_widget = helpers.baseBar(update_widget);
main_widget.visible = false

local function check_updates()
	awful.spawn.easy_async({"sh", "-c", "checkupdates 2> /dev/null | wc -l"},
		function (o)
			local total = tonumber(o)

			awful.spawn.easy_async({"sh", "-c", "paru -Qum 2> /dev/null | wc -l"},
				function (aur_o)
					total = total + tonumber(aur_o)
					if (total > 0)
					then
						main_widget.visible = true
						update_widget.markup = '<span color="'..beautiful.bg_focus..'">  </span>' .. total
					else
						main_widget.visible = false
					end
				end)
		end)
end

gears.timer {
	timeout   = 60,
	call_now  = true,
	autostart = true,
	callback  = function()
		check_updates()
	end
}

return main_widget
