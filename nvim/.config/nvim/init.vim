" Auto install vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'} " Autocomplete plugin
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " Sidebar
Plug 'ryanoasis/vim-devicons' " Add icons to nerdtree
Plug 'pangloss/vim-javascript' " Better js syntax
Plug 'mxw/vim-jsx' " Better jsx syntax
Plug 'ctrlpvim/ctrlp.vim' " File searching
Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-surround' " Better brackets
Plug 'rakr/vim-one' " One dark theme
Plug 'xolox/vim-misc' " Misc plugins ( to be used by other plugins )
Plug 'w0rp/ale' " Linter and fixer
Plug 'mhinz/vim-startify' " Custom start page
Plug 'mrk21/yaml-vim' " Better yaml support
Plug 'vim-airline/vim-airline' " Status line plugin
Plug 'vim-airline/vim-airline-themes' " Status line plugin theme
Plug 'edkolev/tmuxline.vim' " Auto change tmux line to match status line
Plug 'mileszs/ack.vim' " Ack searching
Plug 'xolox/vim-notes' " Note taking
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Set leader key
let mapleader = " "

" Open vim config
nnoremap <leader>ev :vsplit ~/dotfiles/vim/vimrc<cr>

" Source vim config
nnoremap <leader>sv :source $MYVIMRC<cr>

"Identation --------------------------------------------------

" turn on autoident
set autoindent

" Make so cursor can be in empty spaces
set virtualedit=all

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set linebreak
set textwidth=500

" Smart indent
set si    

" Wrap lines
set wrap 

" Set tabs as |
set listchars=tab:\|\ 
set list

"Maps

" Open CtrlP                                              
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'

" Tab functionality
nnoremap <leader>T :tabnew<Enter>

" Navigation tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Remove highlights
nnoremap <silent> <leader>, :noh<cr>

" Map nerd tree to Ctrl n
map <leader>n :NERDTreeToggle<CR>

nmap <leader>p :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" copy and paste
vmap <C-c> "+yi<ESC>
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Better split navigation
" navigate split screens easily
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>

" Pressing <space>ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Quickly open a buffer for scribble
map <leader>o :e ~/.buffer<cr>

"Git diff remaps
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>

nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Common typos
iabbrev lenght length
iabbrev nounce nonce
iabbrev nouce nonce
iabbrev adn and

set number relativenumber

colorscheme dracula

set t_Co=256
set notermguicolors
syntax enable
set background=dark " for the dark version

" Style

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Show location of cursor using a horizontal line.
set cursorline

" Show bearkline icon
set showbreak="蝹"

" Stausline

set statusline=%f         " Path to the file
set statusline+=\ -\     " Switch to the right side
set statusline+=%m         " Switch to the right side
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines

"Startify
let g:startify_custom_header = map(split(system('fortune | cowsay -f tux' ), '\n'), '"   ". v:val')

" Misc

set nopaste

set encoding=utf-8

let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
nmap <Leader><Leader>w <Plug>(easymotion-bd-w)

" Remove autocomment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" keep cursor in the middle of the screen while scrolling up and down.
set scrolloff=999

" show auto complete menus.
set wildmenu

" Make wildmenu behave like bash completion. Finding commands are so easy now.
set wildmode=list:longest,full

" Better Search
set gdefault
set ignorecase
set smartcase
set hlsearch

" Limit column
set colorcolumn=180

"Make backspace act like backspace
set backspace=indent,eol,start

"Splits
set splitbelow
set splitright

" Backup and swap settings
" Swap dir
set dir=~/.cache/vim
" Backup dir
set backupdir=~/.cache/vim

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null<Paste>

"Always show current position
set ruler

" Enable filetype plugins
filetype plugin on
filetype indent on

" Sets how many lines of history VIM has to remember
set history=500

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun

if has("autocmd")
	autocmd BufWritePre *.js,*.py,*.sh :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
	set undodir=~/.vim_runtime/temp_dirs/undodir
	set undofile
catch
endtry

" Set to auto read when a file is changed from the outside
set autoread

" Set 10 lines to the cursor - when moving vertically using j/k
set so=15

" Plugin Settings

" COC --------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Ctrl P --------------------------------------------------
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ }
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" vim-javascript --------------------------------------------------

" Better js sysntax
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Ale --------------------------------------------------

" Ale linters
let g:ale_linters = {'javascript': ['eslint'], 'java': []}
let g:ale_fixers = {'javascript' : ['eslint'], 'java': []}

"let g:ale_lint_delay = 500
let g:ale_fix_on_save = 1

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" Ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

nnoremap <Leader>a :Ack!<Space>

" let g:airline
let g:airline_powerline_fonts = 1

