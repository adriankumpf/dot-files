local is_work_machine = require("utils").is_work_machine

local plugins = {
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	"https://github.com/rafamadriz/friendly-snippets",
}

local sources = { "lsp", "path", "buffer", "snippets" }
local providers = {
	lsp = {
		async = true,
	},
}

if is_work_machine() then
	table.insert(plugins, "https://github.com/zbirenbaum/copilot.lua")
	table.insert(plugins, "https://github.com/fang2hou/blink-copilot")

	table.insert(sources, 3, "copilot")
	providers.copilot = {
		name = "copilot",
		module = "blink-copilot",
		score_offset = 100,
		async = true,
	}
end

vim.pack.add(plugins, { confirm = false })

if is_work_machine() then
	require("copilot").setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	})
end

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
		["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
	},
	completion = {
		list = {
			selection = {
				preselect = false,
			},
		},
	},
	sources = {
		default = sources,
		providers = providers,
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
