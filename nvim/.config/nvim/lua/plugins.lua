local packer = require('packer')
local use = packer.use

packer.init()
use {'wbthomason/packer.nvim', opt = true}

use {
	'glepnir/galaxyline.nvim',
	branch = 'main',
	requires = {'kyazdani42/nvim-web-devicons', opt = true}
}
use {'preservim/nerdtree',
	requires = { 'ryanoasis/vim-devicons'}
}
use {'vim-pandoc/vim-pandoc-syntax'}
use {'vim-pandoc/vim-pandoc'}
use {'tpope/vim-surround'}
use {'tpope/vim-commentary'}
use {'tpope/vim-fugitive'}
use {'glepnir/dashboard-nvim'}
use {
	'nvim-telescope/telescope.nvim',
	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
}
use {'nvim-treesitter/nvim-treesitter',
	config = function()
		require'nvim-treesitter.configs'.setup {
			ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			highlight = {
				enable = true,              -- false will disable the whole extension
			},
			indent = {
				enable = false
			}
		}
	end}

use {'sainnhe/sonokai'}
use {'glepnir/zephyr-nvim'}

use {'neovim/nvim-lspconfig'}
use {
	'Shougo/deoplete.nvim',
	run = ':UpdateRemotePlugins',
}
use {'Shougo/deoplete-lsp'}

use {'junegunn/goyo.vim'}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
