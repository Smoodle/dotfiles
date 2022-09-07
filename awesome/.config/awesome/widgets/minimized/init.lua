local wibox = require("wibox")
local helpers = require("helpers")
local minimized_apps = 0
local base_text = "絛 "

local minimized_widget = wibox.widget {
	markup = '',
	align = 'center',
	widget = wibox.widget.textbox
}

local main_widget = helpers.baseBar(minimized_widget)
main_widget.visible = false

client.connect_signal("property::minimized", function(c)
	if c.minimized == true then
		minimized_apps = minimized_apps + 1
	else
		minimized_apps = minimized_apps - 1
	end

	if minimized_apps > 0 then
		main_widget.visible = true
		minimized_widget.markup = base_text .. minimized_apps
	else
		main_widget.visible = false
	end
end)


return main_widget
