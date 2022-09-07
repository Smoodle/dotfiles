local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- Save and quit
map('n', '<leader>q', ':q<cr>', opt)
map('n', '<leader>w', ':w!<cr>', opt)

--Remove highlighting
map('n', '<leader>,', ':noh<cr>', opt)

--Copy paste outside vim
map('v', '<C-c>', '"+yi<ESC>', opt)
map('v', '<C-x>', '"+c<ESC>', opt)
map('v', '<C-v>', 'c<ESC>"+p', opt)
map('i', '<C-v>', '<ESC>"+pa', opt)

--Remove highligted
map('n', '<silent> <leader>,', ':noh<cr>', { noremap = true })

--Terminal
map('t', '<ESC>', [[<C-\><C-n>]], { noremap = true })

--Lsp
map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true })
map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })

--Nvim tree
map('n', '<leader>n', ':NvimTreeToggle<cr>', { noremap = true })

--Telescope
map('n', '<leader>f', [[<cmd>Telescope find_files<cr>]], { noremap = true })
map('n', '<leader>b', [[<cmd>lua require 'telescope.builtin'.buffers { show_all_buffers = true }<cr>]],
	{ noremap = true })

-- Neogit
map('n', '<leader>gs', ':Neogit<cr>', { noremap = true })

-- Ripgrep
map('n', '<leader>rg', ':Telescope grep_string search="" only_sort_text=true<cr> ', { noremap = true })

-- Custom functions
local function get_logger_message(word, pos)
	local type = vim.bo.filetype
	local path = vim.api.nvim_buf_get_name(0)

	if type == "lua" then
		return "print(\"  " .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. "  \" .. " .. word .. ")"
	elseif type == "rust" then
		return "println!(\"  " .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. "  {}\", " .. word .. ");"
	elseif type == "java" then
		return "System.out.println(\"  " .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. "  \" + " .. word .. ");"
	elseif type == "javascript" or type == "typescript" then
		return "console.log(`  " .. path .. " Line " .. pos[1] .. " Col " .. pos[2] .. "  ${" .. word .. "}`);"
	end
end

function Log_at_point()
	local selected_word = vim.fn.expand("<cword>")
	local original_pos = vim.api.nvim_win_get_cursor(0)

	vim.api.nvim_command("normal $%")

	local pos = vim.api.nvim_win_get_cursor(0)

	vim.api.nvim_buf_set_text(0, pos[1], 0, pos[1], 0, { get_logger_message(selected_word, original_pos), "" })
	vim.api.nvim_command("normal =j")
end

map('n', '<leader>p', ':lua Log_at_point()<CR>', opt)
