local cs = require("utils").colorscheme()

vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/tiagovla/scope.nvim",
	"https://github.com/kevinhwang91/nvim-hlslens",
	"https://github.com/ironhouzi/starlite-nvim",
}, { confirm = false })

-- Icons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Snacks
require("snacks").setup({
	dashboard = { enabled = false },
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
})

vim.keymap.set("n", ",d", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>f", function()
	if require("utils").is_git_repo() then
		Snacks.picker.git_files()
	else
		Snacks.picker.files()
	end
end, { desc = "Find Files (Project)" })
vim.keymap.set("n", "<leader>r", function()
	Snacks.picker.grep()
end, { desc = "Find in Files (Grep)" })
vim.keymap.set("n", "<leader>a", function()
	Snacks.picker.files({ follow = true, ignored = true, hidden = true })
end, { desc = "Find Files (All)" })
vim.keymap.set({ "n", "x" }, ",S", function()
	Snacks.picker.grep_word({ regex = false })
end, { desc = "Find Word" })

-- Oil
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Lualine
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

require("lualine").setup({
	options = {
		theme = cs == "gruvbox" and "powerline" or nil,
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
			{ "diff", source = diff_source },
		},
		lualine_y = {
			{ "progress", separator = "", padding = { left = 1, right = 0 } },
			{ "location", padding = { left = 0, right = 1 } },
		},
		lualine_z = {
			function()
				return " " .. os.date("%R")
			end,
		},
	},
	extensions = { "quickfix" },
})

-- Bufferline
require("scope").setup()

local bufferline_highlights
if cs == "gruvbox" then
	local palette = require("gruvbox").palette
	local background_color = palette.dark0

	bufferline_highlights = function(config)
		local hl = {}
		for name, tbl in pairs(config.highlights) do
			local tbl_copy = {}
			for k, v in pairs(tbl) do
				if k == "bg" then
					tbl_copy[k] = background_color
				else
					tbl_copy[k] = v
				end
			end
			hl[name] = tbl_copy
		end
		return hl
	end
end

require("bufferline").setup({
	options = {
		always_show_bufferline = true,
		show_close_icon = false,
		diagnostics = "nvim_lsp",
	},
	highlights = bufferline_highlights,
})

vim.keymap.set("n", "<M-,>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<M-.>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<M-S-,>", "<Cmd>BufferLineMovePrev<CR>", { silent = true })
vim.keymap.set("n", "<M-S-.>", "<Cmd>BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<M-c>", function()
	vim.cmd("BufferLineCloseRight")
	vim.cmd("BufferLineCloseLeft")
end, { silent = true })

-- Hlslens
require("hlslens").setup({
	calm_down = true,
	nearest_only = true,
})

local function star_search(method)
	return function()
		require("starlite")[method]()
		require("hlslens").start()
	end
end

vim.keymap.set("n", "*", star_search("star"), { silent = true, desc = "Search forward" })
vim.keymap.set("n", "g*", star_search("g_star"), { silent = true, desc = "Search forward (partial)" })
vim.keymap.set("n", "#", star_search("hash"), { silent = true })
vim.keymap.set("n", "g#", star_search("g_hash"), { silent = true })
vim.keymap.set("n", "n", function()
	vim.cmd("normal! " .. vim.v.count1 .. "nzzzv")
	require("hlslens").start()
end, { silent = true })
vim.keymap.set("n", "N", function()
	vim.cmd("normal! " .. vim.v.count1 .. "Nzzzv")
	require("hlslens").start()
end, { silent = true })
