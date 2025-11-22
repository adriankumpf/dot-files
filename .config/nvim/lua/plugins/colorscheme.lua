local colorscheme = require("utils").colorscheme

return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		cond = function()
			return colorscheme() == "gruvbox"
		end,
		opts = function()
			local palette = require("gruvbox").palette

			return {
				overrides = {
					GitSignsAdd = { fg = palette.bright_green, bg = palette.dark0 },
					GitSignsChange = { fg = palette.bright_aqua, bg = palette.dark0 },
					GitSignsDelete = { fg = palette.bright_red, bg = palette.dark0 },
					DiagnosticSignError = { fg = palette.bright_red, bg = palette.dark0 },
					DiagnosticSignWarn = { fg = palette.bright_yellow, bg = palette.dark0 },
					DiagnosticSignInfo = { fg = palette.bright_blue, bg = palette.dark0 },
					DiagnosticSignHint = { fg = palette.bright_aqua, bg = palette.dark0 },

					-- Fix highlighting module definitions until gruvbox.nvim is updated
					-- https://github.com/ellisonleao/gruvbox.nvim/issues/325
					["@module.elixir"] = { link = "GruvboxYellow" },
				},
			}
		end,
		init = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		cond = function()
			return colorscheme() == "github_light"
		end,
		init = function()
			vim.cmd("colorscheme github_light")
		end,
	},
}
