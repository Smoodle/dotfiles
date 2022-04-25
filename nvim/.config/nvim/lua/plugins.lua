local packer = require('packer')
local use = packer.use

packer.init()

use {'wbthomason/packer.nvim', opt = true}

use {"rebelot/kanagawa.nvim",
	config = function()
		require('kanagawa').setup({
			undercurl = true,           -- enable undercurls
			commentStyle = "italic",
			functionStyle = "NONE",
			keywordStyle = "italic",
			statementStyle = "bold",
			typeStyle = "NONE",
			variablebuiltinStyle = "italic",
			specialReturn = true,       -- special highlight for the return keyword
			specialException = true,    -- special highlight for exception handling keywords
			transparent = false,        -- do not set background color
			dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
		colors = {},
			overrides = {},
		})

		-- setup must be called before loading
		vim.cmd("colorscheme kanagawa")
	end
}

use { 'windwp/nvim-autopairs',
	config = function()
		require('nvim-autopairs').setup{}
	end
}

use {'norcalli/nvim-colorizer.lua',
	config = function()
		require'colorizer'.setup()
	end
}

use {
	"folke/todo-comments.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
		vim.api.nvim_set_keymap('n', '<Leader>td', ':TodoTelescope<CR>', {noremap = true})
	end
}

use {'jlcrochet/vim-razor'}

use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

use {'L3MON4D3/LuaSnip',
	config = function()
		require("luasnip.loaders.from_snipmate").lazy_load()
	end
}

use 'saadparwaiz1/cmp_luasnip'

use { 'romgrk/barbar.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' }
}

use {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function()
		local default = {
			filters = {
				dotfiles = false,
			},
			disable_netrw = true,
			hijack_netrw = true,
			ignore_ft_on_setup = { "dashboard" },
			auto_close = false,
			open_on_tab = false,
			hijack_cursor = true,
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = false,
			},
			view = {
				allow_resize = true,
				side = "left",
				width = 30,
				hide_root_folder = true,
			},
			git = {
				enable = false,
				ignore = false,
			},
		}

		require'nvim-tree'.setup(default)
		vim.g.nvim_tree_disable_window_picker = 1
		vim.g.nvim_tree_quit_on_open = 1
		vim.g.nvim_tree_indent_markers = 1
		vim.g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
		vim.g.nvim_tree_git_hl = 0
		vim.g.nvim_tree_highlight_opened_files = 0
	end
}

use {'vim-pandoc/vim-pandoc-syntax'}
use {'vim-pandoc/vim-pandoc'}

use {'tpope/vim-surround'}
use {'tpope/vim-fugitive'}

use {
    'goolord/alpha-nvim',
	config = function ()
		local present, alpha = pcall(require, "alpha")
		if not present then
			return
		end

		local header = {
			type = "text",
			val = require("tables.banners")["pacman"],
			opts = {
				position = "center",
				hl = "Comment",
			},
		}

		local function getGreeting(name)
			local tableTime = os.date("*t")
			local hour = tableTime.hour
			local greeting = ""
			if (hour >= 23 or hour < 7) then
				greeting = "  It's bedtime"
			elseif (hour >= 0 and hour < 12) then
				greeting = "  Good morning"
			elseif (hour >= 12 and hour < 18) then
				greeting = "  Good afternoon"
			elseif (hour >= 18 and hour < 21) then
				greeting = "  Good evening"
			elseif (hour >= 21) then
				greeting = "望 Good night"
			end
			return greeting .. ", " .. name
		end

		local userName = "Smoodle"
		local greeting = getGreeting(userName)


		local greetHeading = {
			type = "text",
			val = greeting,
			opts = {
				position = "center",
				hl = "String"
			},
		}

		local plugins = ""
		if vim.fn.has "linux" == 1 or vim.fn.has "mac" == 1 then
			local handle = io.popen 'fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" '
			plugins = handle:read "*a"
			handle:close()

			plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
		else
			plugins = "N/A"
		end

		local pluginCount = {
			type = "text",
			val = "  " .. plugins .. " plugins in total",
			opts = {
				position = "center",
				hl = "String",
			},
		}

		local quote = [["Comfort is the killer of man."]]
		local quoteAuthor = "Hamza Ahmed"
		local fullQuote = quote .. "\n \n                  - " .. quoteAuthor

		local fortune = {
			type = "text",
			val = fullQuote,
			opts = {
				position = "center",
				hl = "Comment",
			},
		}

		local function button(sc, txt, keybind)
			local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

			local opts = {
				position = "center",
				text = txt,
				shortcut = sc,
				cursor = 0,
				width = 19,
				align_shortcut = "right",
				hl_shortcut = "Number",
				hl = "Function",
			}
			if keybind then
				opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
			end

			return {
				type = "button",
				val = txt,
				on_press = function()
					local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
					vim.api.nvim_feedkeys(key, "normal", false)
				end,
				opts = opts,
			}
		end

		local buttons = {
			type = "group",
			val = {
				button("r", "   Recents", ":Telescope oldfiles <CR>"),
				button("p", "   Projects", ":Telescope projects <CR>"),
				button("f", "   Files", ":Telescope find_files <CR>"),
				button("s", "   Session", ":SessionLoadPost<CR>"),
				button("c", "   Config", ":e ~/.config/nvim/init.lua <CR>"),
				button("q", "   Quit", ":qa<CR>"),
				--button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				--button("t", "  Find text", ":Telescope live_grep <CR>"),
			},
			opts = {
				position = "center",
				spacing = 1,
			},
		}

		local section = {
			header = header,
			buttons = buttons,
			greetHeading = greetHeading,
			pluginCount = pluginCount,
			--footer = fortune,
		}

		local opts = {
			layout = {
				{ type = "padding", val = 3 },
				section.header,
				{ type = "padding", val = 3 },
				section.greetHeading,
				section.pluginCount,
				{ type = "padding", val = 2 },
				section.buttons,
				{ type = "padding", val = 2 },
				section.footer,
			},
			opts = {
				margin = 44,
			},
		}
		alpha.setup(opts)
	end
}

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
			ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			highlight = {
				enable = true,              -- false will disable the whole extension
				use_languagetree = true,
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

use { 'hrsh7th/nvim-cmp',
	requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'onsails/lspkind-nvim'},
	config = function()
		vim.cmd [[ set completeopt=menu,menuone,noselect ]]
		-- Setup nvim-cmp.

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local cmp = require'cmp'
		local luasnip = require("luasnip")
		local lspkind = require('lspkind')

		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					--vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
			mapping = cmp.mapping.preset.insert({
				['<C-b>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
					end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
					end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = 'luasnip' }, -- For luasnip users.
				{ name = 'nvim_lsp' },
				--{ name = 'vsnip' }, -- For vsnip users.
				--{ name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
				{ name = 'path' },
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

use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' },
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			extensions = {}
		}
	end
}


packer.compile('~/.config/nvim/plugin/packer_load.vim')
