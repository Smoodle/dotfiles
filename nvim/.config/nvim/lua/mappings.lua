local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

vim.g.mapleader = ' '

-- Save and quit
map('n', '<leader>q', ':q<cr>', opt)
map('n', '<leader>w', ':w!<cr>', opt)

--Copy paste outside vim
map('v', '<C-c>', '"+yi<ESC>', opt)
map('v', '<C-x>', '"+c<ESC>', opt)
map('v', '<C-v>', 'c<ESC>"+p', opt)
map('i', '<C-v>', '<ESC>"+pa', opt)

--Remove highligted
map('n', '<silent> <leader>,', ':noh<cr>', { noremap = true })

--Terminal
map('t', '<ESC>', [[<C-\><C-n>]], { noremap = true })

--Nvim tree
map('n', '<leader>n', ':NvimTreeToggle<cr>', { noremap = true })

--Telescope
map('n', '<leader>ff', [[<cmd>Telescope fubd_files<cr>]], { noremap = true })
map('n', '<leader>b', [[<cmd>lua require 'telescope.builtin'.buffers { show_all_buffers = true }<cr>]], { noremap = true })

-- Fugitive
map('n', '<leader>gs', ':G<cr>', { noremap = true })
map('n', '<leader>gc', ':G commit<cr>', { noremap = true })
map('n', '<leader>gp', ':terminal git push<cr>', { noremap = true })
