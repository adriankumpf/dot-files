return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		if vim.fn.executable("tree-sitter") == 0 then
			vim.notify("tree-sitter CLI not found — parsers won't be installed", vim.log.levels.WARN)
			return
		end

		require("nvim-treesitter").install({
			"bash",
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
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
