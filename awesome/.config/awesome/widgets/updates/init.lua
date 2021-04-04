local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local update_widget = wibox.widget {
	markup = '',
	align = 'center',
	widget = wibox.widget.textbox
}

local function check_updates()
	awful.spawn.easy_async({"sh", "-c", "checkupdates 2> /dev/null | wc -l"},
		function (o)
			local total = tonumber(o)

			awful.spawn.easy_async({"sh", "-c", "paru -Qum 2> /dev/null | wc -l"},
				function (aur_o)
					total = total + tonumber(aur_o)
					if (total > 0)
					then
						update_widget.visible = true
						update_widget.markup = '<span color="'..beautiful.bg_focus..'">  </span>' .. total
					else
						update_widget.visible = false
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

return update_widget
