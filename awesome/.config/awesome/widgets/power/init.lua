local wibox = require("wibox")
local gears = require("gears")

local battery_widget = wibox.widget {
    {
        min_value    = 0,
        max_value    = 100,
        value        = 0,
        paddings     = 1,
        border_width = 1,
        forced_width = 50,
        border_color = "#0000ff",
        id           = "mypb",
        widget       = wibox.widget.progressbar,
    },
    {
        id           = "mytb",
        text         = "100%",
        widget       = wibox.widget.textbox,
    },
    layout      = wibox.layout.stack,
    set_battery = function(self, val)
        self.mytb.text  = tonumber(val).."%"
        self.mypb.value = tonumber(val)
    end,
}

local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

gears.timer {
    timeout   = 10,
    call_now  = true,
    autostart = true,
    callback  = function()
        -- You should read it from `/sys/class/power_supply/` (on Linux)
        -- instead of spawning a shell. This is only an example.

        if not file_exists(file) then return {} end

        awful.spawn.easy_async(
            {"sh", "-c", "acpi | sed -n 's/^.*, \([0-9]*\)%/\1/p'"},
            function(out)
                mybatterybar.battery = out
            end
        )
    end
}

return battery_widget
