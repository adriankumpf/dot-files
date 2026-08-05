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

local treesitter_group = vim.api.nvim_create_augroup("treesitter", { clear = true })

-- start() attaches an empty highlighter when a parser is installed but its
-- queries are not (install() only checks for the parser, so a queries/<lang>
-- symlink orphaned by a plugin-manager migration goes unnoticed), and the
-- buffer silently renders as plain text. update() relinks them; warn once per
-- language rather than per buffer.
local warned = {}

vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	callback = function(args)
		if not pcall(vim.treesitter.start, args.buf) then
			return -- no parser for this filetype, which is the normal case
		end

		local lang = vim.treesitter.language.get_lang(args.match) or args.match
		if not vim.treesitter.query.get(lang, "highlights") and not warned[lang] then
			warned[lang] = true
			vim.notify(
				("treesitter: no highlights query for %s — run :lua require('nvim-treesitter').update()")
					:format(lang),
				vim.log.levels.WARN
			)
		end
	end,
})
