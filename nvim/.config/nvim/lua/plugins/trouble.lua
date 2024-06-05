return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Trouble popup",
		},
	},
	opts = {}, -- for default options, refer to the configuration section for custom setup.
}
