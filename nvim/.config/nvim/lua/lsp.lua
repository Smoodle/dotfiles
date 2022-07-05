local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp_installer.setup({
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

local lspconfig = require('lspconfig')
local servers = lsp_installer.get_installed_servers()

for _, lsp in ipairs(servers) do
	lspconfig[lsp.name].setup {
		capabilities = capabilities,
	}
end
