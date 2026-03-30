local cs = require("utils").colorscheme

if cs == "gruvbox" then
	vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" }, { confirm = false })

	local palette = require("gruvbox").palette

	-- Match sign column background to editor background
	require("gruvbox").setup({
		overrides = {
			GitSignsAdd = { fg = palette.bright_green, bg = palette.dark0 },
			GitSignsChange = { fg = palette.bright_aqua, bg = palette.dark0 },
			GitSignsDelete = { fg = palette.bright_red, bg = palette.dark0 },
			DiagnosticSignError = { fg = palette.bright_red, bg = palette.dark0 },
			DiagnosticSignWarn = { fg = palette.bright_yellow, bg = palette.dark0 },
			DiagnosticSignInfo = { fg = palette.bright_blue, bg = palette.dark0 },
			DiagnosticSignHint = { fg = palette.bright_aqua, bg = palette.dark0 },

			-- https://github.com/ellisonleao/gruvbox.nvim/issues/325
			["@module.elixir"] = { link = "GruvboxYellow" },
		},
	})
elseif cs == "github_light" then
	vim.pack.add({ "https://github.com/projekt0n/github-nvim-theme" }, { confirm = false })
end

vim.cmd.colorscheme(cs)
