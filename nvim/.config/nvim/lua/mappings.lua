local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = { noremap = true, silent = true}

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
map('n','<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true })
map('n','<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })

--Nvim tree
map('n', '<leader>n', ':NvimTreeToggle<cr>', { noremap = true })

--Telescope
map('n', '<leader>ff', [[<cmd>Telescope find_files<cr>]], { noremap = true })
map('n', '<leader>b', [[<cmd>lua require 'telescope.builtin'.buffers { show_all_buffers = true }<cr>]], { noremap = true })

-- Fugitive
map('n', '<leader>gs', ':G<cr>', { noremap = true })
map('n', '<leader>gc', ':G commit<cr>', { noremap = true })
map('n', '<leader>gp', ':terminal git push<cr>', { noremap = true })

-- Ripgrep
map('n', '<leader>rg', ':Telescope grep_string search="" only_sort_text=true<cr> ', { noremap = true })

-- Barbar

map('n', '<A-1>', ':BufferGoto 1<CR>', opt)
map('n', '<A-2>', ':BufferGoto 2<CR>', opt)
map('n', '<A-3>', ':BufferGoto 3<CR>', opt)
map('n', '<A-4>', ':BufferGoto 4<CR>', opt)
map('n', '<A-5>', ':BufferGoto 5<CR>', opt)
map('n', '<A-6>', ':BufferGoto 6<CR>', opt)
map('n', '<A-7>', ':BufferGoto 7<CR>', opt)
map('n', '<A-8>', ':BufferGoto 8<CR>', opt)
map('n', '<A-9>', ':BufferGoto 9<CR>', opt)
map('n', '<A-0>', ':BufferLast<CR>', opt)

map('n', '<A-c>', ':BufferClose<CR>', opt)

map('n', '<C-p>', ':BufferPick<CR>', opt)

-- LspSaga

map('n', '<leader>gh', ':Lspsaga lsp_finder<CR>', opt)
map('n', '<leader>ca', ':Lspsaga code_action<CR>', opt)
map('n', 'K', ':Lspsaga hover_doc<CR>', opt)
