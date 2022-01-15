local lspconfig = require 'lspconfig'

--ccls (C)
lspconfig.ccls.setup{}

--sumneko lua (lua)
local sumneko_root_path = '/home/smoodle/.builds/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

lspconfig.sumneko_lua.setup {
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim', 'awful', 'beautiful', 'awesome', 'screen', 'client', 'root', 'tag'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					[vim.fn.expand('/usr/share/awesome/lib')] = true,
				},
			},
		},
	},
}

-- tsserver (javascript/typescript)
lspconfig.tsserver.setup{}

-- bashls (bash/sh)
--lspconfig.pyls.setup{}

-- bashls (bash/sh)
lspconfig.bashls.setup{}

-- gopls (Golang)
lspconfig.gopls.setup{}

-- vimls (vim)
lspconfig.vimls.setup{}

local pid = vim.fn.getpid()

local omnisharp_bin = "/usr/lib/omnisharp-roslyn/OmniSharp"

lspconfig.omnisharp.setup {
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}
