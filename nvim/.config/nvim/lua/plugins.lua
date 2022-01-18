local packer = require('packer')
local use = packer.use

packer.init()
use {'wbthomason/packer.nvim', opt = true}

use {'navarasu/onedark.nvim',
	config = function()
		require('onedark').setup {
			style = 'darker'
		}
		require('onedark').load()
	end
}

--use {
--	'junegunn/fzf.vim',
--	requires = {
--		{ 'junegunn/fzf', run = function() vim.fn['fzf#install()'](0) end}
--	}
--}

use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
use {'junegunn/fzf.vim'}

use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'

use({
	"NTBBloodbath/galaxyline.nvim",
	-- your statusline
	config = function()
		require("galaxyline.themes.eviline")
	end,
	-- some optional icons
	requires = { "kyazdani42/nvim-web-devicons", opt = true }
})

use { 'romgrk/barbar.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' }
}

use {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function()
		require'nvim-tree'.setup {}
		vim.g.nvim_tree_disable_window_picker = 1
	end
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

use {
	'neovim/nvim-lspconfig',
	'williamboman/nvim-lsp-installer',
}

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

--use {'kosayoda/nvim-lightbulb',
--	config = function()
--		vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
--	end}

use { 'hrsh7th/nvim-cmp',
	requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline'},
	config = function()
		vim.cmd [[ set completeopt=menu,menuone,noselect ]]
		-- Setup nvim-cmp.
		local cmp = require'cmp'

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
			},
			mapping = {
				['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
				['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
				['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				['<C-e>'] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				['<Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				['<S-Tab>'] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				--{ name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
					{ name = 'buffer' },
				})
		})

		-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline('/', {
			sources = {
				{ name = 'buffer' }
			}
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(':', {
			sources = cmp.config.sources({
				{ name = 'path' }
			}, {
					{ name = 'cmdline' }
				})
		})
	end
}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
