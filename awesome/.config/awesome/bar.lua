local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
-- local naughty = require("naughty")

local helpers = require("helpers")

local tablet_widget = require("widgets.tablet")
local minimized = require("widgets.minimized")
local bluetooth = require("widgets.bluetooth")
--local systray_widget = require("widgets.systray")
local battery = require("widgets.battery")
local power = require("widgets.power")
local systray = require("widgets.systray")

-- local notif = require("modules.notification")

if helpers.isLaptop() == false then
	battery = nil
end

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ Modkey }, 1, function(t)
		if client.focus then client.focus:move_to_tag(t) end
	end), awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ Modkey }, 3, function(t)
		if client.focus then client.focus:toggle_tag(t) end
	end)
)

local time_format = '%H:%M | %a:%d'
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

local power_icon = wibox.widget {
	{
		image   = gears.filesystem.get_configuration_dir() .. "/icons/power/power-off.png",
		visible = true,
		resize  = true,
		widget  = wibox.widget.imagebox
	},
	top = dpi(2),
	bottom = dpi(2),
	left = dpi(7),
	right = dpi(7),
	widget = wibox.container.margin
}

power_icon:connect_signal("button::press", function()
	Sidebar_toggle()
end)

local tag_icons = {}

for _ = 1, beautiful.tag_size, 1 do
	table.insert(tag_icons, beautiful.tag_empty);
end

local s_count = 0

awful.screen.connect_for_each_screen(function(s)
	s_count = s_count + 1
	-- Each screen has its own tag table.
	awful.tag(tag_icons, s, awful.layout.layouts[1])

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
		--filter = function (t) return t.selected or #t:clients() > 0 end,
		buttons = taglist_buttons,
		--style   = {
		--	shape = gears.shape.rounded_rect
		--},
		widget_template = {
			{
				{
					id = 'text_role',
					widget = wibox.widget.textbox,
				},
				id = 'text_margin_role',
				widget = wibox.container.margin
			},
			id = 'background_role',
			widget = wibox.container.background
		},
	}
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, opacity = 1 })

	s.mytasklist = awful.widget.tasklist {
		screen          = s,
		filter          = awful.widget.tasklist.filter.focused,
		style           = {
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

	if s_count > 1 then
		systray = nil
	end

	-- Add widgets to the wibox
	s.mywibox:setup {
		widget = wibox.container.margin,
		left = dpi(3),
		right = dpi(3),
		{
			layout = wibox.layout.align.horizontal,
			expand = 'none',
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				helpers.barItemBackground(s.mytaglist),
				helpers.barItemBackground(s.mylayoutbox),
			},
			nil,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(5),
				battery,
				tablet_widget,
				minimized,
				helpers.baseBar(bluetooth),
				-- notif,
				helpers.barItemBackground(helpers.baseBar(textclock)),
				systray,
				helpers.barItemBackground(power),
			}
		}
	}
end)
