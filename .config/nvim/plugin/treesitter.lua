vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

if vim.fn.executable("tree-sitter") == 0 then
	vim.notify("tree-sitter CLI not found — parsers won't be installed", vim.log.levels.WARN)
else
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
end

local treesitter_group = vim.api.nvim_create_augroup("treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
