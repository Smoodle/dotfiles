require("signals.cpu")
require("signals.ram")
--require("signals.spotify")

local awful = require("awful")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and
		not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end

end)

client.connect_signal("focus",
	function(c)
		if c.maximized_horizontal == true and c.maximized_vertical == true then
			c.border_color = beautiful.border_normal
		else
			c.border_color = beautiful.border_focus
		end
	end)

client.connect_signal("unfocus",
	function(c) c.border_color = beautiful.border_normal
	end)

-- Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange",
	function ()
		local clients = awful.client.visible(s)
		local layout  = awful.layout.getname(awful.layout.get(s))

		if #clients > 0 then -- Fine grained borders and floaters control
			for _, c in pairs(clients) do -- Floaters always have borders
				if c.floating or layout == "floating" then
					c.border_width = beautiful.border_width

					-- No borders with only one visible client
				elseif #clients == 1 or layout == "max" then
					c.border_width = 0
				else
					c.border_width = beautiful.border_width
				end
			end
		end
	end)
end

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("property::minimized", function(c)
	c.minimized = false
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
