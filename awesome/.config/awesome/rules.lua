local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local ruled = require("ruled")
local helpers = require("helpers")

awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = Clientkeys,
			maximized = false,
			maximized_vertical   = false,
			maximized_horizontal = false,
			size_hints_honor = false,
			buttons = Clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap +
				awful.placement.no_offscreen
		}
	}, -- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry"
			},
			class = {
				"Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui", "veromix", "xtightvncviewer", "tint2"
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester" -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = {
			floating = true
		}
	},
	{
		rule_any = {type = {"normal", "dialog"}},
		properties = { titlebars_enabled = false
		}
	},
	{ rule = { class = "Thunderbird" }, properties = { screen = 1, tag = "8" } },
	{ rule = { class = "qBittorrent" }, properties = { screen = 1, tag = "9" } },
	{ rule = { class = "mpv" },
	  properties = { floating = true, ontop = true } },
	{ rule = {
		class = "jetbrains-studio",
		name="^win[0-9]+$"
	},
	properties = {
		placement = awful.placement.no_offscreen,
		titlebars_enabled = false
	}}
}

ruled.notification.connect_signal('request::rules', function() ruled.notification.append_rule {
	rule_any = {
		app_name = {
			"brave-browser",
			"Brave-browser",
			"brave",
			"Brave"
		},
		has_class = {
			"brave-browser",
			"Brave-browser",
			"brave",
			"Brave"
		}
	},
	properties = {
		ignore = true
	}
}
end)
