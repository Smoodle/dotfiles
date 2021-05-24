" Auto install packer

lua << EOF
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end
EOF

" Start packer plugins
packadd packer.nvim
lua require "init"

" Main config
set encoding=utf-8
set hidden
set completeopt=menuone,noselect
set shortmess+=c
set splitbelow
set splitright
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set autoread
set nu rnu
set mouse=a
set title
set cmdheight=2
set updatetime=300
set scrolloff=5

syntax enable

if has('termguicolors')
	set termguicolors
endif
" The configuration options should be placed before `colorscheme edge`.
let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
colorscheme edge

set tabstop=4
set shiftwidth=4
"set expandtab "Use spaces

let mapleader = " "

nmap <leader>q :q<cr>
nmap <leader>w :w!<cr>
vmap <C-c> "+yi<ESC>
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
nnoremap <silent> <leader>, :noh<cr>

" Auto insert mode on terminal
autocmd TermOpen * startinsert

" Window keys
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

" Terminal
tnoremap <Esc> <C-\><C-n>

" NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <Leader>b :lua require'telescope.builtin'.buffers { show_all_buffers = true }<cr>

" Dashboard
let g:dashboard_default_executive = 'telescope'
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2

" Vim Pandoc
let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#command#prefer_pdf = 1
let g:pandoc#modules#disabled = ["folding", "spell"]

"Fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :terminal git push<CR>

"LSP
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)
vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]
EOF
