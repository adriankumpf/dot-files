return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "RRethy/nvim-treesitter-textsubjects" },
	build = ":TSUpdate",
	event = "BufReadPost",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"comment",
				"css",
				"dockerfile",
				"eex",
				"elixir",
				"erlang",
				"fish",
				"go",
				"heex",
				"html",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"python",
				"regex",
				"ruby",
				"rust",
				"scss",
				"vim",
				"vue",
				"yaml",
				"bash",
			},
			highlight = { enable = true },
			indent = { enable = true },
			textsubjects = {
				enable = true,
				keymaps = {
					["<cr>"] = "textsubjects-smart", -- works in visual mode
				},
			},
		})
	end,
}
