local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
map('n', '<leader>', '<Nop>', opt)

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

-- Custom functions
map('n', '<leader>p', ':lua require("custom.log").Log_at_point()<CR>', opt)
