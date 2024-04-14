return {
	{
		"folke/neodev.nvim",
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")

			local new_maker = function(filepath, bufnr, opts)
				opts = opts or {}

				filepath = vim.fn.expand(filepath)
				vim.loop.fs_stat(filepath, function(_, stat)
					if not stat then
						return
					end
					if stat.size > 100000 then
						return
					else
						previewers.buffer_previewer_maker(filepath, bufnr, opts)
					end
				end)
			end

			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
					buffer_previewer_maker = new_maker,
				},
				pickers = {
					find_files = { theme = "dropdown" },
					live_grep = { theme = "dropdown" },
				},
			})

			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>rg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"javascript",
					"typescript",
					"bash",
					"json",
					"c_sharp",
					"css",
					"html",
					"dockerfile",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"rust",
					"yaml",
				},

				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
					disable = function(_, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		keys = {
			{ "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>" },
		},
		config = function()
			require("neodev").setup({})

			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local signs = { Error = " ", Warn = " ", Hint = "󰼅 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "",
				},
			})

			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			local on_attach = function(_, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
				vim.keymap.set("n", "<leader>gf", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts)
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
						handlers = handlers,
					})
				end,

				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				--["rust_analyzer"] = function ()
				--	require("rust-tools").setup {}
				--end
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load()

			vim.o.completeopt = "menu,menuone,noselect"

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						before = function(_, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
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
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "nvim_lsp" },
					{ name = "neorg" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("statusline")
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = require("misc.alpha_banners")["pacman"]

			dashboard.section.buttons.val = {
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("ff", "󰈞  Find file", ":Telescope find_files<CR>"),
				dashboard.button("q", "󰩈  Quit NVIM", ":qa<CR>"),
			}

			dashboard.section.footer.val = "Neovim loaded " .. require("lazy").stats().count .. " plugins."

			dashboard.config.opts.noautocmd = true

			alpha.setup(dashboard.config)
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.move",
		version = false,
		config = function()
			require("mini.move").setup()
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup()
		end,
		keys = {
			{ "<leader>n", "<cmd>NvimTreeToggle<CR>" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup({})
		end,
		keys = {
			{ "<leader>ge", "<cmd>TroubleToggle<CR>" },
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { rgb_fn = true },
					javascript = { names = false },
					json = { names = false },
				},
			})
		end,
	},
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup()
		end,
	},
	{
		"nvim-orgmode/orgmode",
		config = function()
			require("orgmode").setup_ts_grammar()
			require("nvim-treesitter.configs").setup({
				-- If TS highlights are not enabled at all, or disabled via `disable` prop,
				-- highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					-- Required for spellcheck, some LaTex highlights and
					-- code block highlights that do not have ts grammar
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})
			require("orgmode").setup({})
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		config = function()
			require("org-bullets").setup({})
		end,
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.journal"] = {
						config = {
							strategy = "flat",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes/notes",
								work = "~/notes/work",
							},
							default_workspace = "work",
						},
					},
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/vscode-js-debug", -- Path to vscode-js-debug installation.
				debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			require("dapui").setup()

			vim.keymap.set("n", "<F5>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F10>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F12>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").toggle_breakpoint()
			end)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gs", "<cmd>LazyGit<CR>" },
		},
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
			require("telescope").load_extension("projects")
		end,
		keys = {
			{
				"<leader>rp",
				function()
					require("telescope").extensions.projects.projects({})
				end,
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("harpoon").setup()
			require("telescope").load_extension("harpoon")
		end,
		keys = {
			{ "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>" },
			{ "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>" },
			{ "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>" },
			{ "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>" },
		},
	},
	{
		"mhartington/formatter.nvim",
		config = function()
			local util = require("formatter.util")

			require("formatter").setup({
				-- Enable or disable logging
				logging = true,
				-- Set the log level
				log_level = vim.log.levels.WARN,
				-- All formatter configurations are opt-in
				filetype = {
					-- Formatter configurations for filetype "lua" go here
					-- and will be executed in order
					lua = {
						require("formatter.filetypes.lua").stylua,
					},

					javascript = {
						require("formatter.filetypes.javascript").prettier,
					},
					typescript = {
						require("formatter.filetypes.typescript").prettier,
					},
					typescriptreact = {
						require("formatter.filetypes.typescriptreact").prettier,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})

			vim.cmd [[
			augroup FormatAutogroup
			autocmd!
			autocmd BufWritePost * FormatWrite
			augroup END
			]]
		end,
	},
}
