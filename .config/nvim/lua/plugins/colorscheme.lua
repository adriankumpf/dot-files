local colorscheme = require("utils").colorscheme

return {
	{
		"ellisonleao/gruvbox.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = false,
		priority = 1000,
		config = function()
			if colorscheme() == "gruvbox" then
				local palette = require("gruvbox").palette

				require("gruvbox").setup({
					overrides = {
						GitSignsAdd = { fg = palette.bright_green, bg = palette.dark0 },
						GitSignsChange = { fg = palette.bright_aqua, bg = palette.dark0 },
						GitSignsDelete = { fg = palette.bright_red, bg = palette.dark0 },
						DiagnosticSignError = { fg = palette.bright_red, bg = palette.dark0 },
						DiagnosticSignWarn = { fg = palette.bright_yellow, bg = palette.dark0 },
						DiagnosticSignInfo = { fg = palette.bright_blue, bg = palette.dark0 },
						DiagnosticSignHint = { fg = palette.bright_aqua, bg = palette.dark0 },
					},
				})

				vim.cmd("colorscheme gruvbox")
			end
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			if colorscheme() == "github_light" then
				require("github-theme").setup({})

				vim.cmd("colorscheme github_light")
			end
		end,
	},
}
