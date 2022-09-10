local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local helpers = {}

helpers.notify = function (title, message)
	naughty.notify({ title = title, text = message, timeout = 0 })
end

helpers.rrect = function(radius)
	return function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, radius)
	end
end

helpers.text = function(text)
	return wibox.widget{
		markup = text,
		widget = wibox.widget.textbox
	}
end

helpers.baseBar = function(child)
	return wibox.widget {
		--left = beautiful.bar_right_spacing,
		right = beautiful.bar_right_spacing,
		widget = wibox.container.margin,
		children = { child }
	}
end

helpers.printTable = function(t)
	local printTable_cache = {}
	local function sub_printTable( t, indent )
		if ( printTable_cache[tostring(t)] ) then
			print( indent .. "*" .. tostring(t) )
		else
			printTable_cache[tostring(t)] = true
			if ( type( t ) == "table" ) then
				for pos,val in pairs( t ) do
					if ( type(val) == "table" ) then
						print( indent .. "[" .. pos .. "] => " .. tostring( t ).. " {" )
						sub_printTable( val, indent .. string.rep( " ", string.len(pos)+8 ) )
						print( indent .. string.rep( " ", string.len(pos)+6 ) .. "}" )
					elseif ( type(val) == "string" ) then
						print( indent .. "[" .. pos .. '] => "' .. val .. '"' )
					else
						print( indent .. "[" .. pos .. "] => " .. tostring(val) )
					end
				end
			else
				print( indent..tostring(t) )
			end
		end
	end

	if ( type(t) == "table" ) then
		print( tostring(t) .. " {" )
		sub_printTable( t, "  " )
		print( "}" )
	else
		sub_printTable( t, "  " )
	end
end

helpers.isLaptop = function()
   local hostname = io.popen("uname -n"):read()

   if hostname:find("-lp", 1, true) then
	  return true
   end

   return false
end

return helpers
