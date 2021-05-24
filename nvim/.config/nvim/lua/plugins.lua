local packer = require('packer')
local use = packer.use

packer.init()
use {'wbthomason/packer.nvim', opt = true}

use { 'sainnhe/edge' }

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
			ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			highlight = {
				enable = true,              -- false will disable the whole extension
			},
			indent = {
				enable = true
			}
		}
	end}

use {'davidgranstrom/nvim-markdown-preview'}

use {'sainnhe/sonokai'}
use {'glepnir/zephyr-nvim'}

use {'neovim/nvim-lspconfig'}
use {'RishabhRD/nvim-lsputils',
	requires = {'RishabhRD/popfix'},
	config = function()
		vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
		vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
		vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
		vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
		vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
		vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
		vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
		vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
	end}

use {'hrsh7th/nvim-compe',
	config = function()
		require'compe'.setup {
			enabled = true;
			autocomplete = true;
			debug = false;
			min_length = 1;
			preselect = 'enable';
			throttle_time = 80;
			source_timeout = 200;
			incomplete_delay = 400;
			max_abbr_width = 100;
			max_kind_width = 100;
			max_menu_width = 100;
			documentation = true;

			source = {
				path = true;
				buffer = true;
				calc = true;
				nvim_lsp = true;
				nvim_lua = true;
				vsnip = true;
			};
		}
	end}

use {'junegunn/goyo.vim'}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
