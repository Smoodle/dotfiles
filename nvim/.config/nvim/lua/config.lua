local o = vim.o
local g = vim.g
local wo = vim.wo
local opt = vim.opt

if vim.fn.has("termguicolors") == 1 then
	o.termguicolors = true
end

o.encoding    = "utf-8"
o.syntax = "enable"

wo.colorcolumn = '80'

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

o.scrolloff   = 8
o.mouse       = "a"
o.title       = true

-- Set undo
o.undodir     = os.getenv("HOME") .. "/.vim/undodir"
o.undofile    = true

o.hlsearch = false
o.incsearch   = true

o.splitbelow  = true
o.splitright  = true

-- Disable random files

o.swapfile    = false
o.backup      = false
o.writebackup = false

-- Relative line numbers
o.nu = true
o.rnu = true

o.cmdheight   = 2

-- No line wrap
o.wrap = false

-- Fast update time
o.updatetime = 50

-- Auto insert mode on terminal
--vim.api.nvim_command("autocmd TermOpen * startinsert")

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
