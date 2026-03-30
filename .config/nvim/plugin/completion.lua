vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	"https://github.com/rafamadriz/friendly-snippets",
}, { confirm = false })

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
		default = { "lsp", "path", "buffer", "snippets" },
		providers = {
			lsp = {
				async = true,
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
