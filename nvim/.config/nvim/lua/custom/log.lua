local function get_logger_message(word, pos)
	local type = vim.bo.filetype
	local path = vim.api.nvim_buf_get_name(0)

	if type == "lua" then
		return 'print("  ' .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. '  " .. ' .. word .. ")"
	elseif type == "rust" then
		return 'println!("  ' .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. '  {}", ' .. word .. ");"
	elseif type == "java" then
		return 'System.out.println("  '
			.. path
			.. " Line "
			.. pos[1]
			.. " Col "
			.. pos[2]
			.. '  " + '
			.. word
			.. ");"
	elseif type == "javascript" or type == "typescript" then
		return "console.log(`  " .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. "  ${" .. word .. "}`);"
	end
end

local M = {}

function M.Log_at_point()
	local selected_word = vim.fn.expand("<cword>")
	local original_pos = vim.api.nvim_win_get_cursor(0)

	vim.api.nvim_command("normal $%")

	local pos = vim.api.nvim_win_get_cursor(0)

	vim.api.nvim_buf_set_text(0, pos[1], 0, pos[1], 0, { get_logger_message(selected_word, original_pos), "" })
	vim.api.nvim_command("normal =j")
end

return M
