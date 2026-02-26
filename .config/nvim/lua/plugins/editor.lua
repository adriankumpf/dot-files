return {
	-- Sane buffer/window deletion.
	{
		"mhinz/vim-sayonara",
		cmd = "Sayonara",
		keys = {
			{
				",q",
				function()
					vim.cmd.Sayonara()
				end,
				desc = "Delete Buffer",
			},
		},
	},

	-- Transition between multi- & single-line code
	{
		"Wansmer/treesj",
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = {
			{ "gJ", function() require("treesj").join() end, desc = "Join lines" },
			{ "gS", function() require("treesj").split() end, desc = "Split lines" },
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 150,
		},
	},

	-- Quick on-screen jumps
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash",
			},
		},
	},

	--  Heuristically set indent settings
	{ "tpope/vim-sleuth", event = "VeryLazy" },

	-- Modifying surrounding delimiter pairs
	{ "kylechui/nvim-surround", event = "VeryLazy", config = true },

	-- Git Stuff
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { virt_text_pos = "right_align" },
		},
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = { delay = 200 },
		config = function(_, opts)
			-- illuminate does not use the standard 'setup' function
			require("illuminate").configure(opts)
		end,
		keys = {
			{
				"]]",
				function()
					require("illuminate").goto_next_reference()
				end,
				desc = "Next Reference",
			},
			{
				"[[",
				function()
					require("illuminate").goto_prev_reference()
				end,
				desc = "Prev Reference",
			},
		},
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = ":call mkdp#util#install()",
		keys = {
			{
				"<leader>m",
				function()
					vim.cmd.MarkdownPreview()
				end,
				silent = true,
			},
		},
	},

	{ "yorickpeterse/nvim-tree-pairs", event = "VeryLazy", config = true },

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			picker = {
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
						},
					},
				},
			},
		},
		keys = {
			{
				",d",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
			},
			{
				"<leader>f",
				function()
					if require("utils").is_git_repo() then
						Snacks.picker.git_files()
					else
						Snacks.picker.files()
					end
				end,
				desc = "Find Files (Project)",
			},
			{
				"<leader>r",
				function()
					Snacks.picker.grep()
				end,
				desc = "Find in Files (Grep)",
			},
			{
				"<leader>a",
				function()
					Snacks.picker.files({ follow = true, ignored = true, hidden = true })
				end,
				desc = "Find Files (All)",
			},
			{
				",S",
				function()
					Snacks.picker.grep_word({ regex = false })
				end,
				desc = "Find Word",
				mode = { "n", "x" },
			},
		},
	},

	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		opts = {
			highlight = {
				load_buffers = true,
			},
		},
		keys = {
			{
				">",
				function()
					require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
				end,
				ft = "qf",
				desc = "Expand quickfix context",
			},
			{
				"<",
				function()
					require("quicker").collapse()
				end,
				ft = "qf",
				desc = "Collapse quickfix context",
			},
		},
	},
}
