require("utils").pack_add({
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

-- treesj.setup() eagerly requires a module per supported language (~18ms), so
-- load it on first use instead. `load = false` still puts it on the runtimepath.
require("utils").pack_add({ "https://github.com/Wansmer/treesj" }, { load = false })

local treesj
local function treesj_cmd(action)
	return function()
		if not treesj then
			treesj = require("treesj")
			treesj.setup({ use_default_keymaps = false, max_join_length = 150 })
		end
		treesj[action]()
	end
end

vim.keymap.set("n", "gJ", treesj_cmd("join"), { desc = "Join lines" })
vim.keymap.set("n", "gS", treesj_cmd("split"), { desc = "Split lines" })

local flash = require("flash")
flash.setup()
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })

require("nvim-surround").setup()

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = { virt_text_pos = "right_align" },
})

local quicker = require("quicker")
quicker.setup({
	highlight = { load_buffers = true },
	keys = {
		{
			">",
			function()
				quicker.expand({ before = 2, after = 2, add_to_existing = true })
			end,
			desc = "Expand quickfix context",
		},
		{ "<", quicker.collapse, desc = "Collapse quickfix context" },
	},
})

vim.keymap.set("n", "<leader>m", vim.cmd.MarkdownPreview, { silent = true, desc = "Markdown Preview" })
