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

	-- Transition between multi- & single-line code (gJ | gS)
	"AndrewRadev/splitjoin.vim",

	-- Quick on-screen jumps
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				function()
					require("leap").leap({ target_windows = { vim.fn.win_getid() } })
				end,
				desc = "Leap",
			},
		},
	},

	--  Heuristically set indent settings
	"tpope/vim-sleuth",

	-- Modifying surrounding delimiter pairs
	{ "kylechui/nvim-surround", config = true },

	-- Comments
	{
		"numToStr/Comment.nvim",
		config = true,
	},

	-- Strip trailing whitespace
	{ "mcauley-penney/tidy.nvim", event = "BufWritePre", config = true },

	-- Git Stuff
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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

	{
		"yorickpeterse/nvim-tree-pairs",
		config = true,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
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
				desc = "Expand quickfix context",
			},
			{
				"<",
				function()
					require("quicker").collapse()
				end,
				desc = "Collapse quickfix context",
			},
		},
	},
}
