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
map('n', '<leader>f', [[<cmd>Telescope find_files<cr>]], { noremap = true })
map('n', '<leader>b', [[<cmd>lua require 'telescope.builtin'.buffers { show_all_buffers = true }<cr>]], { noremap = true })

-- Neogit
map('n', '<leader>gs', ':Neogit<cr>', { noremap = true })

-- Ripgrep
map('n', '<leader>rg', ':Telescope grep_string search="" only_sort_text=true<cr> ', { noremap = true })

-- LspSaga
map('n', '<leader>gh', ':Lspsaga lsp_finder<CR>', opt)
map('n', '<leader>ca', ':Lspsaga code_action<CR>', opt)
map('n', 'K', ':Lspsaga hover_doc<CR>', opt)
