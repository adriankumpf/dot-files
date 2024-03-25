local is_work_machine = require("utils").is_work_machine

return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})

			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")

			local lexical_config = {
				filetypes = { "elixir", "eelixir", "heex" },
				cmd = {

					vim.loop.os_homedir()
						.. "/Developer/third_party/lexical/_build/dev/package/lexical/bin/start_lexical.sh",
				},
				settings = {},
			}

			if not configs.lexical then
				configs.lexical = {
					default_config = {
						filetypes = lexical_config.filetypes,
						cmd = lexical_config.cmd,
						root_dir = function(fname)
							return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
						end,
						-- optional settings
						settings = lexical_config.settings,
					},
				}
			end

			lspconfig.lexical.setup({})

			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						keyOrdering = false,
					},
				},
			})

			local cmp = require("cmp")
			local cmp_format = lsp_zero.cmp_format()
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				formatting = cmp_format,
				sources = {
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "buffer", group_index = 2 },
					{ name = "path", group_index = 2 },
				},
				mapping = cmp.mapping.preset.insert({
					-- scroll up and down the documentation window
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					-- Use Enter to confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					-- Tab completion
					["<Tab>"] = cmp_action.tab_complete(),
					["<S-Tab>"] = cmp_action.select_prev_or_fallback(),

					-- Navigate between snippet placeholder
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
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
				-- filetypes that don't have other formatters configured
				["_"] = { "trim_whitespace" },
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
