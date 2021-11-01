local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

require("awful.autofocus")

local apps = require("apps")

local keys = {}

root.buttons(gears.table.join(
    awful.button({ }, 3, function () Menu:toggle() end)
))

keys.globalkeys = gears.table.join(
	awful.key({ Modkey,           }, "j",
		function ()
			awful.client.focus.byidx(1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ Modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),

	-- Layout manipulation
	awful.key({ Modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
		{description = "swap with next client by index", group = "client"}),
	awful.key({ Modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
		{description = "swap with previous client by index", group = "client"}),
	awful.key({ Modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
		{description = "focus the next screen", group = "screen"}),
	awful.key({ Modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
		{description = "focus the previous screen", group = "screen"}),
	awful.key({ Modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),
	awful.key({ Modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),

	-- Standard program
	awful.key({ Modkey, "Shift"   }, "Return", function () awful.spawn(Terminal) end,
		{description = "open a terminal", group = "launcher"}),
	awful.key({ Modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
	awful.key({ Modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
		{description = "increase master width factor", group = "layout"}),
	awful.key({ Modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
		{description = "decrease master width factor", group = "layout"}),
	awful.key({ Modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
		{description = "increase the number of master clients", group = "layout"}),
	awful.key({ Modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
		{description = "decrease the number of master clients", group = "layout"}),
	awful.key({ Modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
		{description = "increase the number of columns", group = "layout"}),
	awful.key({ Modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
		{description = "decrease the number of columns", group = "layout"}),
	awful.key({ Modkey,           }, "space", function () awful.layout.inc( 1)                end,
		{description = "select next", group = "layout"}),
	awful.key({ Modkey            }, "d", function ()
		local src = awful.screen.focused()
		src.selected_tag.master_count = src.selected_tag.master_count - 1
	end, {description = "decrease master count", group = "screen"}),
	awful.key({ Modkey            }, "i", function ()
		local src = awful.screen.focused()
		src.selected_tag.master_count = src.selected_tag.master_count + 1
	end, {description = "decrease master count", group = "screen"}),
	awful.key({ Modkey            }, "b", function ()
		local scr = awful.screen.focused()
		scr.mywibox.visible = not scr.mywibox.visible
	end,
		{description = "hide wibar", group = "screen"}),

	awful.key({ Modkey, "Control" }, "n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal(
					"request::activate", "key.unminimize", {raise = true}
				)
			end
		end,
		{description = "restore minimized", group = "client"}),

	-- Prompt
	awful.key({ Modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = "launcher"}),

	awful.key({ Modkey }, "x",
		function ()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{description = "lua execute prompt", group = "awesome"}),

	--layout keys
	awful.key({ Modkey,           }, "f",
		function ()
			awful.layout.set(awful.layout.suit.floating)
		end,
		{description = "Set tile layout", group = "layout"}),
	awful.key({ Modkey,           }, "t",
		function ()
			awful.layout.set(awful.layout.suit.tile)
		end,
		{description = "Set tile layout", group = "layout"}),
	awful.key({ Modkey,           }, "m",
		function ()
			awful.layout.set(awful.layout.suit.max)
		end ,
		{description = "Set max layout", group = "layout"}),

	-- Volume Keys
	awful.key({}, "XF86AudioLowerVolume", function ()
		awful.util.spawn("pulsemixer --change-volume -5", false)
	end),
	awful.key({}, "XF86AudioRaiseVolume", function ()
		awful.util.spawn("pulsemixer --change-volume +5", false)
	end),
	awful.key({}, "XF86AudioMute", function ()
		awful.util.spawn("pulsemixer --toggle-mute", false)
	end),
	-- Media Keys
	awful.key({}, "XF86AudioPlay", function()
		awful.util.spawn("playerctl play-pause", false)
	end),
	awful.key({}, "XF86AudioNext", function()
		awful.util.spawn("playerctl next", false)
	end),

	awful.key({}, "XF86AudioPrev", function()
		awful.util.spawn("playerctl previous", false)
	end),
	-- Light keys
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("xbacklight -inc 10", false)
	end),

	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("xbacklight -dec 10", false)
	end),

	awful.key({ Modkey }, "+", function()
		beautiful.useless_gap = beautiful.useless_gap + 1
		awful.screen.connect_for_each_screen(function(s)
			awful.layout.arrange(s)
		end)
	end, {description = "increase the gaps", group = "launcher"}),

	awful.key({ Modkey }, "-", function()
		if (beautiful.useless_gap) <= 0 then
			return
		end

		beautiful.useless_gap = beautiful.useless_gap - 1

		if (beautiful.useless_gap < 0) then
			beautiful.useless_gap = 0
		end

		awful.screen.connect_for_each_screen(function(s)
			awful.layout.arrange(s)
		end)
	end, {description = "reduce the gaps", group = "launcher"}),

	-- Custom
	awful.key({ Modkey }, "e", function() awful.spawn(apps.file_manager) end,
		{description = "show the file browser", group = "launcher"}),

	awful.key({ Modkey }, "a", function()
		awful.spawn.with_shell("~/.scripts/mpv_picker /Media/Anime")
	end, {description = "Open mpv picker", group = "launcher"}),

	awful.key({ Modkey, "Shift" }, "p", function() awful.spawn(apps.screenshot) end,
		{description = "Take screenshot", group = "launcher"}),

	awful.key({ Modkey }, "v", function() awful.spawn(apps.vpn) end,
		{description = "Open VPN", group = "launcher"}),

	-- Menubar
	awful.key({ Modkey }, "p", function() awful.spawn(apps.launcher) end,
		{description = "show the menubar", group = "launcher"}),

	awful.key({ Modkey }, "w", function() Menu:toggle() end,
		{description = "show the menu", group = "launcher"}),

	awful.key({ Modkey, "Shift" }, "q", function() Sidebar_toggle() end,
		{description = "toggle side bar", group = "launcher"})
)

keys.clientkeys = gears.table.join(
	awful.key({ Modkey, "Shift"         }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, {description = "toggle fullscreen", group = "client"}),

	awful.key({ Modkey, "Shift"   }, "c", function (c)
		c:kill()
	end, {description = "close", group = "client"}),

	awful.key({ Modkey, "Shift" }, "space",
		function(c)
			awful.client.floating.toggle()
			c:raise()
		end,
		{description = "toggle floating", group = "client"}),

	awful.key({ Modkey }, "Return", function (c)
		c:swap(awful.client.getmaster())
	end,
		{description = "move to master", group = "client"}),
	awful.key({ Modkey, "Shift"}, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "(un)maximize", group = "client"}),


	awful.key({ Modkey, "Shift" }, ".", function (c)
		c:move_to_screen()
	end, {description = "move one screen forward", group = "client"}),

	awful.key({ Modkey, "Shift" }, ",", function (c)
		c:move_to_screen(c.screen.index - 1)
	end, {description = "move one screen backwards", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	keys.globalkeys = gears.table.join(keys.globalkeys,
		-- View tag only.
		awful.key({ Modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ Modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ Modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end

keys.clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({ Modkey }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({ Modkey }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end),
	awful.button({ Modkey , "Shift" }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		if (c.floating == false) then
			c.floating = true
		end

		awful.mouse.client.resize(c)
	end)
)

return keys
