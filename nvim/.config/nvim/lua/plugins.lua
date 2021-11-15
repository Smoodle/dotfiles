local packer = require('packer')
local use = packer.use

packer.init()
use {'wbthomason/packer.nvim', opt = true}

use 'navarasu/onedark.nvim'

use {
	'glepnir/galaxyline.nvim',
	branch = 'main',
	requires = { 'kyazdani42/nvim-web-devicons' }
}

use { 'romgrk/barbar.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' }
}

use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
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
	config = function()
		local actions = require('telescope.actions')
		require('telescope').setup{
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close
					},
				},
			}
		}
	end
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

use {'kabouzeid/nvim-lspinstall'}

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

use {'kosayoda/nvim-lightbulb',
	config = function()
		vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
	end}

use {'hrsh7th/nvim-compe'}

use {'junegunn/goyo.vim'}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
