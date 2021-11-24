local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local helpers = require("helpers")
local apps = require("apps")

local naughty = require("naughty")

local update_widget = wibox.widget {
   markup = '',
   align = 'center',
   widget = wibox.widget.textbox
}

local main_widget = helpers.baseBar(update_widget)
main_widget.visible = false
main_widget:connect_signal("button::press",
						   function ()
							  awful.spawn.easy_async(apps.updater,
							  						 function (_ , _, reason, err_code)
							  							   naughty.notify({ title = "Update", text = "reason: " .. reason .. " exit code: " .. err_code, timeout = 5 })
							  							if (reason == "exit")
							  							then
							  							   naughty.notify({ title = "Update", text = "Update closed", timeout = 5 })
							  							elseif (reason == "signal" and err_code ~= 0)
							  							then
							  							   naughty.notify({ title = "Update", text = "Update error with code: " .. err_code, timeout = 5 })
							  							else
							  							   main_widget.visible = false
							  							   naughty.notify({ title = "Update!", text = "Update Sucessfull ", timeout = 5 })
							  							end
							  end)
end)

local function check_updates()
   awful.spawn.easy_async({"sh", "-c", "checkupdates 2> /dev/null | wc -l"},
	  function (o)
		 local total = tonumber(o)

		 awful.spawn.easy_async({"sh", "-c", "paru -Qum 2> /dev/null | wc -l"},
			function (aur_o)
			   total = total + tonumber(aur_o)
			   if (total > 0)
			   then
				  update_widget.markup = '<span color="'..beautiful.fg_focus..'">  </span>' .. total
				  main_widget.visible = true
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
