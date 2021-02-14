local awful = require("awful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("apps")
local helpers = require("helpers")

local power_menu = {
	{"logout", function() end},
	{"restart", function() end},
	{"shutdown", function() end},
}

local main_menu = {
	{"hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{"power", power_menu },
}

Menu = awful.menu ({ items = main_menu })
