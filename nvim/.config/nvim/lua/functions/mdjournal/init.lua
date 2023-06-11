local M = {}

local dir = "~/notes/journal/"

M.journal = function (opts)
	if opts.args == "today" then
		vim.cmd("edit " .. dir .. os.date("%d_%m_%y") .. ".md")
	elseif opts.args == "yesterday" then
		vim.cmd("edit " .. dir .. os.date("%d_%m_%y", os.time() - (24 * 60 * 60)) .. ".md")
	elseif opts.args == "tomorrow" then
		vim.cmd("edit " .. dir .. os.date("%d_%m_%y", os.time() + (24 * 60 * 60)) .. ".md")
	else
		vim.cmd("edit " .. dir .. os.date("%d_%m_%y") .. ".md")
	end


end

M.setup = function ()
	vim.api.nvim_create_user_command('Journal',M.journal ,{
		nargs = "?",
		complete = function (ArgLead, CmdLine, CursorPos)
			return { "yesterday", "today", "tomorrow" }
		end
	})
end

return M
