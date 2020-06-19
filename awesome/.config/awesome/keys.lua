local gears = require("gears")
local awful = require("awful")

local keys = {}

keys.globalkeys = gears.table.join(
	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx(1)
		end,
		{description = "focus next by index", group = "client"}
		),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
		),
	-- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
	--           {description = "show main menu", group = "awesome"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
		{description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
		{description = "swap with previous client by index", group = "client"}),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
		{description = "focus the next screen", group = "screen"}),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
		{description = "focus the previous screen", group = "screen"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),

	-- Standard program
	awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit,
		{description = "quit awesome", group = "awesome"}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
		{description = "increase master width factor", group = "layout"}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
		{description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
		{description = "increase the number of master clients", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
		{description = "decrease the number of master clients", group = "layout"}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
		{description = "increase the number of columns", group = "layout"}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
		{description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
		{description = "select next", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
		{description = "select previous", group = "layout"}),
	awful.key({ modkey            }, "b", function ()  
		local scr = awful.screen.focused()
		scr.mywibox.visible = not scr.mywibox.visible
	end,
		{description = "hide wibar", group = "screen"}),

	awful.key({ modkey, "Control" }, "n",
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
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = "launcher"}),

	awful.key({ modkey }, "x",
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
	awful.key({ modkey,           }, "f",
		function (c) 
			awful.layout.set(awful.layout.suit.floating)
		end,
		{description = "Set tile layout", group = "layout"}),
	awful.key({ modkey,           }, "t",
		function (c) 
			awful.layout.set(awful.layout.suit.tile)
		end,
		{description = "Set tile layout", group = "layout"}),
	awful.key({ modkey,           }, "m",
		function (c)
			awful.layout.set(awful.layout.suit.max)
		end ,
		{description = "Set max layout", group = "layout"}),

	-- Volume Keys
	awful.key({}, "XF86AudioLowerVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%-", false)
	end),
	awful.key({}, "XF86AudioRaiseVolume", function ()
		awful.util.spawn("amixer -q -D pulse sset Master 5%+", false)
	end),
	awful.key({}, "XF86AudioMute", function ()
		awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
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

	-- Custom
	awful.key({ modkey, "Shift", "Control" }, "p", function() awful.spawn("/bin/sh /home/smoodle/.config/dmneu/dmenu_shutdown") end,
		{description = "show the power menu", group = "launcher"}),
	awful.key({ modkey, "Shift" }, "p", nil, function() awful.spawn("scrot -s -e 'mv $f ~/Pictures/Screenshots'") end,
		{description = "Take screenshot", group = "launcher"}),
	-- Menubar
	awful.key({ modkey }, "p", function() awful.spawn("rofi -show drun") end,
		{description = "show the menubar", group = "launcher"})
	)     

keys.clientkeys = gears.table.join(

	awful.key({ modkey, "Shift"         }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),

	awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
		{description = "close", group = "client"}),

	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
		{description = "toggle floating", group = "client"}),

	awful.key({ modkey            }, "Return", function (c)
		c:swap(awful.client.getmaster())
	end,
	{description = "move to master", group = "client"}),

awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
	{description = "move to screen", group = "client"})
)

	-- Bind all key numbers to tags.
	-- Be careful: we use keycodes to make it work on any keyboard layout.
	-- This should map on the top row of your keyboard, usually 1 to 9.
	for i = 1, 9 do
		keys.globalkeys = gears.table.join(keys.globalkeys,
			-- View tag only.
			awful.key({ modkey }, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						tag:view_only()
					end
				end,
				{description = "view tag #"..i, group = "tag"}),
			-- Toggle tag display.
			awful.key({ modkey, "Control" }, "#" .. i + 9,
				function ()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
				{description = "toggle tag #" .. i, group = "tag"}),
			-- Move client to tag.
			awful.key({ modkey, "Shift" }, "#" .. i + 9,
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
			awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
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
		awful.button({ modkey }, 1, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({ modkey }, 3, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end)
		)

	return keys