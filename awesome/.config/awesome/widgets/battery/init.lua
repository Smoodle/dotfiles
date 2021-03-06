local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local bat = "BAT0"

local battery_widget = wibox.widget {
   markup = '<span color="'..beautiful.bg_focus..'">icon</span><span color="'.. beautiful.fg_normal ..'">Percentage</span>',
   align = "center",
   widget = wibox.widget.textbox,
}

local main_widget = helpers.baseBar(battery_widget);
main_widget.visible = false

local icon = ""
local value = ""

local function update_text()
   battery_widget.markup = '<span color="'..beautiful.bg_focus..'">' .. icon .. '</span><span color="'.. beautiful.fg_normal ..'">'.. value ..'</span>'
end

local function toggle_widget()
   main_widget.visible = not main_widget.visible
end

gears.timer {
   timeout = 10,
   call_now = true,
   autostart = true,
   callback = function()
	  awful.spawn.easy_async({"sh", "-c", " [ -d /sys/class/power_supply/" .. bat .. "/ ] && echo 1"}, function(out)
			if out == "1\n"
			then
			   if main_widget.visible == false then
				  toggle_widget()
			   end

			   awful.spawn.easy_async({"sh", "-c", "cat /sys/class/power_supply/" .. bat .. "/status"}, function(out2)

					 if out2 == "Charging\n"
					 then
						icon = " "
					 else
						icon = " "
					 end

					 awful.spawn.easy_async({"sh", "-c", "cat /sys/class/power_supply/" .. bat .. "/capacity"}, function(out3)
						   value = out3
						   update_text()
					 end)

			   end)
			else
			   if main_widget.visible == true then
				  toggle_widget()
			   end
			end
	  end)
   end,
}

return main_widget
