local gears = require("gears")
local awful = require("awful")

local notified_exit = 0

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({"sh", "-c", "playerctl -p spotify status 2>&1"}, function(_,_,_, code)
			if code ~= 0 then
				if notified_exit == 1 then
					awesome.emit_signal("signals::spotify", "-1")
					notified_exit = 0
				end

				return
			end

			awful.spawn.easy_async({"sh", "-c", "playerctl metadata -p spotify -f '{{title}} - {{artist}}'"}, function(song)
				if notified_exit == 0 then notified_exit = 1 end

				awesome.emit_signal("signals::spotify", song)
			end)

		end)
	end}
