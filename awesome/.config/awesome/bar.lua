local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local helpers = require("helpers")

local tablet_widget = require("widgets/tablet")
local updates = require("widgets/updates")

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({Modkey}, 1, function(t)
		if client.focus then client.focus:move_to_tag(t) end
	end), awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({Modkey}, 3, function(t)
		if client.focus then client.focus:toggle_tag(t) end
	end)
)

local textclock = wibox.widget.textclock()

-- load the widget code
local calendar = require("widgets.calendar")
local cw = calendar({
	placement = 'top_right',
	theme = 'theme'
})

-- attach it as popup to your text clock widget:
textclock:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then
			cw.toggle()
		end
	end)

-- local current_client = wibox.widget {
-- 	text = '',
-- 	widget = wibox.widget.textbox
-- }
--
-- client.connect_signal("focus", function (c)
-- 	current_client.text = c.name or ''
-- end)
--
-- client.connect_signal("unfocus", function ()
-- 	current_client.text = ''
-- end)

awful.screen.connect_for_each_screen(function(s)
	-- Each screen has its own tag table.
	awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1,
			function() awful.layout.inc(1) end),
		awful.button({}, 3,
			function()
				awful.layout.inc(-1)
			end)))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	}
	-- Create the wibox
	s.mywibox = awful.wibar({position = "top", screen = s})

	-- Add widgets to the wibox
	s.mywibox:setup{
		layout = wibox.layout.align.horizontal,
		expand = 'none',
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mylayoutbox,
			--current_client,
			s.mypromptbox,
		},
		nil,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			--spacing = beautiful.bar_right_spacing,
			{
				layout = wibox.layout.fixed.horizontal,
				--spacing = beautiful.bar_right_spacing,
				tablet_widget,
				updates,
				textclock,
				wibox.widget.systray(),
			},
		}
	}
end)
