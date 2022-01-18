local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require 'init'

local o = vim.opt
if vim.fn.has('termguicolors') == 1 then
	o.termguicolors = true
end

o.syntax = 'enable' -- check if this does anything
o.encoding = 'utf-8'
o.hidden = true
o.completeopt = { 'menuone', 'noselect' }
o.shortmess:append({c = true})
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true
o.incsearch = true
o.autoread = true
o.nu = true
o.rnu = true
o.mouse = 'a'
o.title = true
o.cmdheight = 2
o.updatetime= 300
o.scrolloff= 5

o.tabstop=4
o.shiftwidth=4

--vim.g.onedark_style = 'darker'

-- dashboard
vim.g.dashboard_default_executive = 'telescope'
vim.api.nvim_command('autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2')

--colorscheme
vim.cmd('colorscheme onedark')

-- Auto insert mode on terminal
vim.api.nvim_command('autocmd TermOpen * startinsert')

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

vim.cmd [[
autocmd FileType cs call CSharp_Settings()

function! CSharp_Settings()
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal noexpandtab
endfunction
]]

require 'mappings'
