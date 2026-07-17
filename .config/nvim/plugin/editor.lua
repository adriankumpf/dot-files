require("utils").pack_add({
	"https://github.com/Wansmer/treesj",
	"https://github.com/folke/flash.nvim",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/yorickpeterse/nvim-tree-pairs",
	"https://github.com/stevearc/quicker.nvim",
	"https://github.com/iamcco/markdown-preview.nvim",
})

-- Delete the buffer along with its window; quit when it's the last listed
-- buffer. In unlisted buffers (help, quickfix, ...) just close.
-- :confirm prompts instead of failing on unsaved changes.
vim.keymap.set("n", ",q", function()
	if #vim.fn.getbufinfo({ buflisted = 1 }) <= 1 and vim.bo.buflisted then
		vim.cmd("confirm quitall")
	else
		vim.cmd("confirm bdelete")
	end
end, { desc = "Close buffer and window" })

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

require("quicker").setup({
	highlight = {
		load_buffers = true,
	},
})

vim.keymap.set("n", "<leader>m", vim.cmd.MarkdownPreview, { silent = true, desc = "Markdown Preview" })
