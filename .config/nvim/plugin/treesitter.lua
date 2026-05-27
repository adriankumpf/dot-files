vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

local treesitter = require("nvim-treesitter")
local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site")

treesitter.setup({ install_dir = install_dir })

local ok, treesitter_install = pcall(require, "nvim-treesitter.install")
if ok and treesitter_install.get_package_path then
	local runtime_dir = treesitter_install.get_package_path("runtime")
	if vim.uv.fs_stat(runtime_dir) then
		vim.opt.runtimepath:append(runtime_dir)
	end
end

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

local treesitter_group = vim.api.nvim_create_augroup("treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function()
		pcall(vim.treesitter.start)
	end,
})
