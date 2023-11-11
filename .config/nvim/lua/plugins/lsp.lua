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

			local lsp_configurations = require("lspconfig.configs")

			if not lsp_configurations.lexical then
				lsp_configurations.lexical = {
					default_config = {
						name = "Lexical",
						filetypes = { "elixir", "eelixir" },
						cmd = {
							vim.loop.os_homedir()
								.. "/Developer/third_party/lexical/_build/dev/package/lexical/bin/start_lexical.sh",
						},
						root_dir = function(fname)
							return require("lspconfig.util").root_pattern("mix.exs", ".git")(fname)
								or vim.loop.os_homedir()
						end,
						settings = {},
					},
				}
			end

			require("lspconfig").lexical.setup({})

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
					{ name = "nvim_lsp" },
					{ name = "codeium" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					-- scroll up and down the documentation window
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					-- Use Enter to confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = false }),

					-- Tab completion
					-- ["<Tab>"] = cmp_action.tab_complete(),
					-- ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
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
		"mhartington/formatter.nvim",
		config = function()
			local util = require("formatter.util")

			require("formatter").setup({
				filetype = {
					lua = {
						require("formatter.filetypes.lua").stylua,
					},

					fish = {
						require("formatter.filetypes.fish").fishindent,
					},

					elixir = {
						function()
							return {
								exe = "mix",
								args = {
									"format",
									"--stdin-filename",
									util.escape_path(util.get_current_buffer_file_path()),
									"-",
								},
								stdin = true,
							}
						end,
					},

					sh = {
						function()
							return {
								exe = "shellharden",
								args = {
									"--transform",
									util.escape_path(util.get_current_buffer_file_path()),
									"--",
								},
								stdin = true,
							}
						end,
					},

					-- ["*"] = {
					--   require("formatter.filetypes.any").remove_trailing_whitespace
					-- }
				},
			})

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					pcall(vim.cmd["FormatWriteLock"])
				end,
			})
		end,
	},
}
