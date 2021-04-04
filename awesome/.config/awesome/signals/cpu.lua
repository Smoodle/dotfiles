local gears = require("gears")
local awful = require("awful")

gears.timer {
	timeout = 10,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async({"sh", "-c", "top -bn1 | grep \"Cpu(s)\" | sed \"s/.*, *\\([0-9.]*\\)%* id.*/\\1/\" | awk '{print 100 - $1}'"},
		function(out)
			awesome.emit_signal("signals::cpu", tonumber(out))
		end)
	end}
