local gears = require("gears")

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function()
		if awesome.systray() > 0 then
			awesome.emit_signal("signals::systray", true)
		else
			awesome.emit_signal("signals::systray", false)
		end
end}
