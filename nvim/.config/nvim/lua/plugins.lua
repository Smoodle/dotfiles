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

use {'jlcrochet/vim-razor'}

use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
use {'junegunn/fzf.vim'}

use 'L3MON4D3/LuaSnip'
use 'saadparwaiz1/cmp_luasnip'

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function()
	  require("evilline")
  end
}

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
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

use {
	'nvim-telescope/telescope.nvim',
	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
	config = function()
		local actions = require('telescope.actions')
		require('telescope').setup{
			extensions = {
				fzf = {
	  				fuzzy = true,                    -- false will only do exact matching
	  				override_generic_sorter = true,  -- override the generic sorter
	  				override_file_sorter = true,     -- override the file sorter
	  				case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
									   -- the default case_mode is "smart_case"
				}
  			},
			defaults = {
				mappings = {
					i = {
						["<esc>"] = actions.close
					},
				},
			}
		}

		require('telescope').load_extension('fzf')
	end
}

use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

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

--[[
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
	end} ]]

use { 'tami5/lspsaga.nvim',
	config = function ()
		local lspsaga = require 'lspsaga'
lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
	enable = true,
	sign = true,
	sign_priority = 40,
	virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
	open = "o",
	vsplit = "s",
	split = "i",
	quit = "q",
	scroll_down = "<C-f>",
	scroll_up = "<C-b>",
  },
  code_action_keys = {
	quit = "q",
	exec = "<CR>",
  },
  rename_action_keys = {
	quit = "<C-c>",
	exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
}
	end }

--use {'kosayoda/nvim-lightbulb',
--	config = function()
--		vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
--	end}

use { 'hrsh7th/nvim-cmp',
	requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'onsails/lspkind-nvim'},
	config = function()
		vim.cmd [[ set completeopt=menu,menuone,noselect ]]
		-- Setup nvim-cmp.
		local cmp = require'cmp'
		local lspkind = require('lspkind')

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
			formatting = {
				format = lspkind.cmp_format({
					with_text = true, -- do not show text alongside icons
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Latex]",
					})
				})
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
