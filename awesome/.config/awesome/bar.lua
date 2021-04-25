local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local tablet_widget = require("widgets/tablet")
local updates = require("widgets/updates")

local battery = require("widgets.battery")

local taglist_buttons = gears.table.join(
   awful.button({}, 1, function(t) t:view_only() end),
   awful.button({Modkey}, 1, function(t)
		 if client.focus then client.focus:move_to_tag(t) end
   end), awful.button({}, 3, awful.tag.viewtoggle),
   awful.button({Modkey}, 3, function(t)
		 if client.focus then client.focus:toggle_tag(t) end
   end)
)

local time_format = '<span color="'..beautiful.bg_focus..'">  </span>%a %b %d <span color="'..beautiful.bg_focus..'">  </span>%H:%M'
local textclock = wibox.widget.textclock(time_format)

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


local song_text = wibox.widget {
   markup = '',
   widget = wibox.widget.textbox,
}

awesome.connect_signal("signals::spotify", function(value)
						  song_text.markup = value
end)


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
		 --filter = awful.widget.taglist.filter.all,
		 filter = function (t) return t.selected or #t:clients() > 0 end,
		 buttons = taglist_buttons,
	  }
	  -- Create the wibox
	  s.mywibox = awful.wibar({position = "top", screen = s})

	  s.mytasklist = awful.widget.tasklist {
		 screen   = s,
		 filter   = awful.widget.tasklist.filter.focused,
		 style    = {
			fg_focus = beautiful.bg_focus,
			bg_focus = beautiful.bg_normal,
		 },
		 widget_template = {
			{
			   id     = 'text_role',
			   widget = wibox.widget.textbox,
			},
			layout = wibox.layout.fixed.horizontal,
		 },
	  }

	  -- Add widgets to the wibox
	  s.mywibox:setup{
		 layout = wibox.layout.align.horizontal,
		 expand = 'none',
		 { -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mylayoutbox,
			song_text,
			--current_client,
			s.mypromptbox,
		 },
		 s.mytasklist,
		 { -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			--spacing = beautiful.bar_right_spacing,
			{
			   layout = wibox.layout.fixed.horizontal,
			   spacing = beautiful.bar_right_spacing,
			   battery,
			   tablet_widget,
			   updates,
			   textclock,
			   wibox.widget.systray(),
			},
		 }
	  }
end)
