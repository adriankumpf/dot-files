vim.keymap.set("i", "jj", "<esc>")

vim.keymap.set("n", ",w", ":w<CR>", { silent = true })

vim.keymap.set("n", "<Leader><Leader>", "<C-^>")

vim.keymap.set("n", "<Leader>z", "1z=")

vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "S", "mzi<CR><ESC>`z")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", ",s", ":%s///gc<Left><Left><Left>")


vim.keymap.set("n", "Q", "@q")

vim.keymap.set({ "n", "v" }, "/", [[/\v\c]])

-- grab the current file and line number
vim.keymap.set("n", "<leader>y", function()
	vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))
end)

vim.keymap.set("n", "<leader>Y", function()
	vim.fn.setreg("+", vim.fn.expand("%:."))
end)
