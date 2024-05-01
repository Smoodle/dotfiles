local M = {}

M.log = function(time)
	if not time or time == "today" then
		print("today")
	end
end

return M
