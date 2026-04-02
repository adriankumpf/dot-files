vim.pack.add({
	"https://github.com/mhinz/vim-sayonara",
	"https://github.com/Wansmer/treesj",
	"https://github.com/folke/flash.nvim",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/yorickpeterse/nvim-tree-pairs",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/iamcco/markdown-preview.nvim",
}, { confirm = false })

vim.keymap.set("n", ",q", vim.cmd.Sayonara, { desc = "Close buffer and window" })

local treesj = require("treesj")
treesj.setup({ use_default_keymaps = false, max_join_length = 150 })
vim.keymap.set("n", "gJ", treesj.join, { desc = "Join lines" })
vim.keymap.set("n", "gS", treesj.split, { desc = "Split lines" })

local flash = require("flash")
flash.setup()
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })

require("nvim-surround").setup()

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = { virt_text_pos = "right_align" },
})

local illuminate = require("illuminate")
illuminate.configure({ delay = 200 })
vim.keymap.set("n", "]]", illuminate.goto_next_reference, { desc = "Next Reference" })
vim.keymap.set("n", "[[", illuminate.goto_prev_reference, { desc = "Prev Reference" })

require("quicker").setup({
	highlight = {
		load_buffers = true,
	},
})

vim.keymap.set("n", "<leader>m", vim.cmd.MarkdownPreview, { silent = true, desc = "Markdown Preview" })
