local packer = require('packer')
local use = packer.use

packer.init()

use {
  	'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    --config = function()
	--	require('emacs')
	--end,
    -- some optional icons
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

--use {'norcalli/nvim-colorizer.lua',
--	config = function ()
--		require'colorizer'.setup()
--	end}

--use {'hrsh7th/nvim-compe',
--	config = function()
--		require'compe'.setup {
--			enabled = true;
--			autocomplete = true;
--			debug = false;
--			min_length = 1;
--			preselect = 'enable';
--			throttle_time = 80;
--			source_timeout = 200;
--			incomplete_delay = 400;
--			source = {
--				path = true;
--				buffer = true;
--				calc = true;
--				vsnip = true;
--				nvim_lsp = true;
--				nvim_lua = true;
--				spell = true;
--				tags = true;
--				snippets_nvim = true;
--				treesitter = true;
--			};
--		}
--
--		local t = function(str)
--			return vim.api.nvim_replace_termcodes(str, true, true, true)
--		end
--
--		-- Use (s-)tab to:
--		--- move to prev/next item in completion menuone
--		--- jump to prev/next snippet's placeholder
--		_G.tab_complete = function()
--			if vim.fn.pumvisible() == 1 then
--			return t "<C-n>"
--			elseif vim.fn.call("vsnip#available", {1}) == 1 then
--			return t "<Plug>(vsnip-expand-or-jump)"
--			else
--			return t "<Tab>"
--			end
--		end
--		_G.s_tab_complete = function()
--			if vim.fn.pumvisible() == 1 then
--			return t "<C-p>"
--			elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--			return t "<Plug>(vsnip-jump-prev)"
--			else
--			return t "<S-Tab>"
--			end
--		end
--
--		vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
--		vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
--		vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--		vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--	end}

--use {
--	'hoob3rt/lualine.nvim',
--	requires = {'kyazdani42/nvim-web-devicons', opt = true},
--	config = function()
--		local lualine = require('lualine')
--		lualine.theme = 'forest_night'
--		lualine.separator = '|'
--		lualine.sections = {
--			lualine_a = { 'mode' },
--			lualine_b = { 'branch' },
--			lualine_c = { 'filename' },
--			lualine_x = { 'encoding', 'fileformat', 'filetype' },
--			lualine_y = { 'progress' },
--			lualine_z = { 'location'  },
--		}
--		lualine.inactive_sections = {
--			lualine_a = {  },
--			lualine_b = {  },
--			lualine_c = { 'filename' },
--			lualine_x = { 'location' },
--			lualine_y = {  },
--			lualine_z = {   }
--		}
--		lualine.extensions = { 'fzf' }
--		lualine.status()
--	end
--}

use {
	'Shougo/deoplete.nvim',
	run = ':UpdateRemotePlugins',
}

use {'Shougo/deoplete-lsp'}

use {'romgrk/barbar.nvim',
	requires = { 'kyazdani42/nvim-web-devicons'}
}

packer.compile('~/.config/nvim/plugin/packer_load.vim')
