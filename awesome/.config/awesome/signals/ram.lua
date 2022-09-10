local gears = require("gears")
local awful = require("awful")

gears.timer {
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({"sh", "-c", "free | grep Mem | awk '{printf(\"%.2f\"), $3/$2 * 100.0}'"}, function(out)
			awesome.emit_signal("signals::ram", tonumber(out))
		end)
end}
