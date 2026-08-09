require("utils").pack_add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local treesitter = require("nvim-treesitter")

-- Default install_dir is stdpath("data")/site, which is already on the
-- runtimepath; the installer symlinks each language's queries into it.
treesitter.setup()

if vim.fn.executable("tree-sitter") == 0 then
	vim.notify("tree-sitter CLI not found — parsers won't be installed", vim.log.levels.WARN)
else
	treesitter.install({
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

-- Missing/orphaned queries for an installed parser show up in
-- :checkhealth nvim-treesitter; run require("nvim-treesitter").update() to relink.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
