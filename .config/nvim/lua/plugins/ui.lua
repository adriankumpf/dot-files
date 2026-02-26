local colorscheme = require("utils").colorscheme

return {
	-- Icons (compatibility shim replaces nvim-web-devicons)
	{
		"nvim-mini/mini.icons",
		opts = {},
		config = function(_, opts)
			require("mini.icons").setup(opts)
			MiniIcons.mock_nvim_web_devicons()
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		event = "VeryLazy",
		opts = function()
			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end

			return {
				options = {
					theme = colorscheme() == "gruvbox" and "powerline" or nil,
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{ "diagnostics" },
						{
							"filetype",
							icon_only = true,
							separator = "",
							padding = { left = 1, right = 0 },
						},
						{ "filename", path = 1, symbols = { modified = "", unnamed = "" } },
					},
					lualine_x = {
						{ require("lazy.status").updates, cond = require("lazy.status").has_updates },
						{ "diff", source = diff_source },
					},
					lualine_y = {
						{ "progress", separator = "", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "quickfix" },
			}
		end,
	},

	-- Tabs
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-mini/mini.icons",
			{ "tiagovla/scope.nvim", config = true },
		},
		event = "VeryLazy",
		opts = {
			options = {
				always_show_bufferline = true,
				show_close_icon = false,
				diagnostics = "nvim_lsp",
			},
			highlights = function(config)
				if colorscheme() == "gruvbox" then
					local hl = {}

					local palette = require("gruvbox").palette
					local backgroud_color = palette.dark0 -- "NONE"

					for name, tbl in pairs(config.highlights) do
						local tbl_copy = {}
						for k, v in pairs(tbl) do
							if k == "bg" then
								tbl_copy[k] = backgroud_color
							else
								tbl_copy[k] = v
							end
						end
						hl[name] = tbl_copy
					end

					return hl
				else
					return {}
				end
			end,
		},
		keys = {
			-- Move to previous/next
			{ "<M-,>", ":BufferLineCyclePrev<CR>", silent = true, mode = { "n" } },
			{ "<M-.>", ":BufferLineCycleNext<CR>", silent = true, mode = { "n" } },

			-- Re-order to previous/next
			{ "<M-S-,>", ":BufferLineMovePrev<CR>", silent = true, mode = { "n" } },
			{ "<M-S-.>", ":BufferLineMoveNext<CR>", silent = true, mode = { "n" } },

			-- Close all but current
			{
				"<M-c>",
				function()
					vim.cmd("BufferLineCloseRight")
					vim.cmd("BufferLineCloseLeft")
				end,
				silent = true,
				mode = { "n" },
			},
		},
	},

	--  Directory viewer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		opts = {
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{ "-", "<CMD>Oil<CR>", mode = { "n" }, desc = "Open parent directory" },
		},
		lazy = false,
	},

	{
		"kevinhwang91/nvim-hlslens",
		dependencies = { "ironhouzi/starlite-nvim" },
		keys = {
			{
				"*",
				function()
					require("starlite").star()
					require("hlslens").start()
				end,
				noremap = true,
				silent = true,
				desc = "Search forward",
			},
			{
				"g*",
				function()
					require("starlite").g_star()
					require("hlslens").start()
				end,
				noremap = true,
				silent = true,
				desc = "Search backward",
			},
			{
				"#",
				function()
					require("starlite").hash()
					require("hlslens").start()
				end,
				noremap = true,
				silent = true,
			},
			{
				"g#",
				function()
					require("starlite").g_hash()
					require("hlslens").start()
				end,
				noremap = true,
				silent = true,
			},
			{
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
				noremap = true,
				silent = true,
			},
			{
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'Nzzzv')<CR><Cmd>lua require('hlslens').start()<CR>]],
				noremap = true,
				silent = true,
			},
		},
		opts = {
			calm_down = true,
			nearest_only = true,
		},
	},
}
