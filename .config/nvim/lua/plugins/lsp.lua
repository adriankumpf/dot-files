local is_work_machine = require("utils").is_work_machine

return {
	-- LSP Support
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},

	-- Autocompletion
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"fang2hou/blink-copilot",
				dependencies = {
					{
						"zbirenbaum/copilot.lua",
						cmd = "Copilot",
						event = "InsertEnter",
						opts = {
							suggestion = { enabled = false },
							panel = { enabled = false },
							filetypes = {
								markdown = true,
								help = true,
							},
						},
						enabled = is_work_machine,
					},
				},
			},
		},
		version = "1.*",
		opts = {
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
				default = { "lsp", "path", "copilot", "buffer", "snippets" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
					lsp = {
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		init = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				elixir = { "credo" },
				dockerfile = { "hadolint" },
				sh = { "shellcheck" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			format_on_save = { timeout_ms = 5000, lsp_fallback = true },

			formatters_by_ft = {
				lua = { "stylua" },
				elixir = { "mix" },
				sh = { "shellharden" },
				fish = { "fish_indent" },
				xml = { "xmlformat" },
				markdown = { "prettier" },
				json = { "prettier" },
				-- filetypes that don't have other formatters configured
				["_"] = { "trim_whitespace" },
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
