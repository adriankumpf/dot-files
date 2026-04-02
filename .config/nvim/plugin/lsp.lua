vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()

require("conform").setup({
	format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },

	formatters_by_ft = {
		lua = { "stylua" },
		elixir = { "mix", "trim_whitespace" },
		sh = { "shellharden" },
		fish = { "fish_indent" },
		xml = { "xmllint" },
		markdown = { "prettier" },
		json = { "prettier" },
		-- filetypes that don't have other formatters configured
		["_"] = { "trim_whitespace" },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local lint = require("lint")
local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })

lint.linters_by_ft = {
	elixir = { "credo" },
	dockerfile = { "hadolint" },
	sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = lint_group,
	callback = function()
		lint.try_lint()
	end,
})
