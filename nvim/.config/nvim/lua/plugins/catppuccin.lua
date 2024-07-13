return {
	"catppuccin/nvim",
	enabled = false,
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
