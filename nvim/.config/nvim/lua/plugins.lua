local packer = require('packer')
local use = packer.use

packer.init()

use {
	'glepnir/galaxyline.nvim',
	branch = 'main',
	requires = {'kyazdani42/nvim-web-devicons', opt = true}
}

use {'wbthomason/packer.nvim', opt = true}
use {'preservim/nerdtree',
	requires = { 'ryanoasis/vim-devicons'}
}
use {'neovim/nvim-lspconfig'}
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
			ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			highlight = {
				enable = true,              -- false will disable the whole extension
			},
			indent = {
				enable = true
			}
		}
	end}

use {'sainnhe/sonokai'}
use {'glepnir/zephyr-nvim'}

use {
	'Shougo/deoplete.nvim',
	run = ':UpdateRemotePlugins',
}

use {'Shougo/deoplete-lsp'}

use {'romgrk/barbar.nvim',
	requires = { 'kyazdani42/nvim-web-devicons'}
}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
