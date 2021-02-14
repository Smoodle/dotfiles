local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local update_widget = wibox.widget {
	image = "/home/smoodle/.config/awesome/widgets/updates/icons/update.png",
	resize = true,
	visible = false,
	widget = wibox.widget.imagebox
}

local function check_updates()
	awful.spawn.easy_async({"sh", "-c", "checkupdates 2> /dev/null | wc -l"},
		function (o)
			if (tonumber(o) > 0)
			then
				print(tonumber(o))
				update_widget.visible = true
			else
				awful.spawn.easy_async({"sh", "-c", "yay -Qum 2> /dev/null | wc -l"},
					function (aur_o)
						if (tonumber(aur_o) > 0)
						then
							update_widget.visible = true
						else
							update_widget.visible = false

						end
					end)
			end
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
