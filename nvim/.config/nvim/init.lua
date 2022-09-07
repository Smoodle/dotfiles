local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

require("init")

local o = vim.opt

if vim.fn.has("termguicolors") == 1 then
	o.termguicolors = true
end

o.shortmess:append({ c = true })

o.syntax      = "enable" -- check if this does anything
o.encoding    = "utf-8"
o.hidden      = true
o.completeopt = { "menuone", "noselect" }
o.splitbelow  = true
o.splitright  = true
o.swapfile    = false
o.backup      = false
o.writebackup = false
o.undodir     = os.getenv("HOME") .. "/.vim/undodir"
o.undofile    = true
o.incsearch   = true
o.autoread    = true
o.nu          = true
o.rnu         = true
o.mouse       = "a"
o.title       = true
o.cmdheight   = 2
o.updatetime  = 300
o.scrolloff   = 5
o.tabstop     = 4
o.shiftwidth  = 4

-- Auto insert mode on terminal
vim.api.nvim_command("autocmd TermOpen * startinsert")

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

vim.cmd([[
autocmd FileType cs call CSharp_Settings()

function! CSharp_Settings()
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal noexpandtab
endfunction
]])

--Fold
vim.cmd([[
set nofoldenable
set foldlevel=99
set fillchars=fold:\
set foldtext=CustomFoldText()
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart

  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile

  if fs > v:foldend
      let line = getline(v:foldstart)
  else
      let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endfunction
]])

require("mappings")
