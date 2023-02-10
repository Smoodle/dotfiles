---------------------------
-- Default awesome theme --
---------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local shape = gears.shape

local xresources_theme = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local config_path = gfs.get_configuration_dir()

local theme = {}

theme.font = "Hack Nerd Font 12"

theme.tag_size = 5
theme.tag_content = " "
theme.tag_empty = " "

local main_bg_normal = xresources_theme.background or "#282a36"
local main_bg_focus = xresources_theme.color12 or "#bd93f9"

local main_fg_normal = xresources_theme.foreground or "#f8f8f2"
local main_fg_focus = xresources_theme.background or "#44475a"

local alt_color = "#363842"

theme.alt_color = alt_color

theme.bg_normal = main_bg_normal
theme.bg_focus = alt_color
theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.bg_systray = alt_color

theme.fg_normal = main_fg_normal
theme.fg_focus = main_bg_focus
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.border_radius = dpi(10)
theme.useless_gap = dpi(4)
theme.gap_single_client = false
theme.border_width = dpi(2)
theme.border_normal = "#424242"
theme.border_focus = main_bg_focus
theme.border_marked = main_bg_focus

theme.wibar_height = dpi(40)
theme.taglist_disable_icon = true

theme.bar_right_spacing = dpi(7)
theme.systray_icon_spacing = dpi(5)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]the
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"


-- Generate taglist squares:
--local taglist_square_size = dpi(5)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--        taglist_square_size, theme.fg_normal)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--        taglist_square_size, theme.fg_normal)

theme.tasklist_disable_icon = true
theme.taglist_spacing = dpi(6)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_max_width = dpi(400)
theme.notification_icon_size = dpi(100)
--theme.notification_shape = shape.rounded_rect
theme.notification_opacity = 1
theme.notification_margin = dpi(50)
theme.notification_border_width = dpi(2)
theme.notification_border_color = main_bg_focus

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(18)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- theme.wallpaper = ""

-- You can use your own layout icons like this:
theme.layout_floating = config_path .. "icons/floating.png"
theme.layout_tile = config_path .. "icons/tile.png"
theme.layout_max = config_path .. "icons/max.png"

theme.pfp = config_path .. "icons/pfp.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height,
        theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Hide border on fullscreen and max layout
theme.fullscreen_hide_border = true
theme.maximized_hide_border = true

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
