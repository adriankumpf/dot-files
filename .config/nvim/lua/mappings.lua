vim.keymap.set("i", "jj", "<esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", ",w", ":w<CR>", { silent = true, desc = "Save file" })

vim.keymap.set("n", "<Leader><Leader>", "<C-^>", { desc = "Switch to alternate file" })

vim.keymap.set("n", "<Leader>z", "1z=", { desc = "Fix spelling with first suggestion" })

vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, desc = "Move up (display line)" })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, desc = "Move down (display line)" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
vim.keymap.set("n", "S", "mzi<CR><ESC>`z", { desc = "Split line at cursor" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", ",s", ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>", { desc = "Search and replace word under cursor" })

vim.keymap.set("n", "Q", "@q", { desc = "Replay macro q" })

vim.keymap.set({ "n", "v" }, "/", [[/\v\c]], { desc = "Search (very magic, case insensitive)" })

-- grab the current file and line number
vim.keymap.set("n", "<leader>y", function()
	vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))
end, { desc = "Copy file path and line number" })

vim.keymap.set("n", "<leader>Y", function()
	vim.fn.setreg("+", vim.fn.expand("%:."))
end, { desc = "Copy file path" })
