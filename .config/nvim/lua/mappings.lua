vim.keymap.set("i", "jj", "<esc>")

vim.keymap.set("n", ",w", ":w<CR>", { silent = true })
vim.keymap.set("n", ",q", ":Sayonara<CR>", { silent = true })

vim.keymap.set("n", "<Leader><Leader>", "<C-^>")

vim.keymap.set("n", "<Leader>z", "z=1<CR><CR>")

vim.keymap.set("n", "<expr>", 'k (v:count == 0 ? "gk" : "k")')
vim.keymap.set("n", "<expr>", 'j (v:count == 0 ? "gj" : "j")')

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "S", "mzi<CR><ESC>`z")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", ",s", ":%s///gc<Left><Left><Left>")

vim.keymap.set("n", "s", '"_d')

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("v", "n", "nzz")
vim.keymap.set("v", "N", "Nzz")

vim.keymap.set("n", "Q", "@q")

vim.keymap.set("n", "/", [[/\v\c]])
vim.keymap.set("v", "/", [[/\v\c]])

vim.keymap.set("v", "y", "y`]")
vim.keymap.set("v", "p", '"_dP`]')
vim.keymap.set("n", "p", "p`]")

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end
function smart_shift_tab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

vim.keymap.set("i", '<Tab>', smart_tab, { expr = true })
vim.keymap.set("i", '<S-Tab>', smart_shift_tab, { expr = true })

