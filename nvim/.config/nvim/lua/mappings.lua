vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Better copy paste
vim.keymap.set("v", "<C-c>", '"+yi<ESC>', { desc = "Copy to clipboard" })
vim.keymap.set("v", "<C-x>", '"+c<ESC>', { desc = "Cut to clipboard" })
vim.keymap.set("v", "<C-v>", 'c<ESC>"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", '<ESC>"+pa', { desc = "Paste from clipboard" })

-- Better window movement
vim.api.nvim_command([[
	function! WinMove(key)
		let t:curwin = winnr()
		exec "wincmd ".a:key
		if (t:curwin == winnr())
			if (match(a:key,'[jk]'))
				wincmd v
			else
				wincmd s
			endif
			exec "wincmd ".a:key
		endif
	endfunction
	
	nnoremap <silent> <C-h> :call WinMove('h')<CR>
	nnoremap <silent> <C-j> :call WinMove('j')<CR>
	nnoremap <silent> <C-k> :call WinMove('k')<CR>
	nnoremap <silent> <C-l> :call WinMove('l')<CR>
]])

-- Custom functions
vim.keymap.set("n", "<leader>p", ':lua require("custom.log").Log_at_point()<CR>', { desc = "Log item at point" })
