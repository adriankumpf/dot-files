require 'plugins'

local utils = require 'config.utils'
local map = utils.map
local autocmd = utils.autocmd

-- Settings
vim.opt.clipboard:append {"unnamed"}
vim.opt.expandtab = true; vim.opt.tabstop = 2; vim.opt.softtabstop = 2; vim.opt.shiftwidth = 2
vim.opt.fillchars = { vert = "│", stl = " ", stlnc = " " }
vim.opt.list = true; vim.opt.listchars = { tab = "┆·", trail = '·', precedes = "", extends = "", nbsp = "‗" }; vim.opt.showbreak = "↪"
vim.opt.number = false; vim.opt.relativenumber = false
vim.opt.swapfile = false; vim.opt.backup = false; vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.scrolloff = 7
vim.opt.smartindent = true
vim.opt.splitbelow = true; vim.opt.splitright = true
vim.opt.switchbuf = "useopen"
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.complete:append {"kspell"}
vim.opt.wildmode = { list = "longest", list = "full" }
vim.opt.pumblend = 35
vim.opt.emoji = false
vim.opt.lazyredraw = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append { c = true }

vim.g.mapleader = " "

-- Keybindings
map("i", "jj", "<esc>")

map("n", ",w", ":w<CR>", { silent = true })
map("n", ",q", ":Sayonara<CR>", { silent = true })

map("n", "<Leader><Leader>", "<C-^>")

map("n", "<Leader>z", "z=1<CR><CR>")

map("n", "<expr>", 'k (v:count == 0 ? "gk" : "k")')
map("n", "<expr>", 'j (v:count == 0 ? "gj" : "j")')

map("n", "J", "mzJ`z")
map("n", "S", "mzi<CR><ESC>`z")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", ",s", ":%s///gc<Left><Left><Left>")

map("n", "s", '"_d')

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("v", "n", "nzz")
map("v", "N", "Nzz")

map("n", "Q", "@q")

map("n", "/", [[/\v\c]])
map("v", "/", [[/\v\c]])

map("v", "y", "y`]")
map("v", "p", '"_dP`]')
map("n", "p", "p`]")

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end
function _G.smart_shift_tab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

map("i", '<Tab>', 'v:lua.smart_tab()', { expr = true })
map("i", '<S-Tab>', 'v:lua.smart_shift_tab()', { expr = true })

-- Commands
vim.cmd [[match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$']] -- Highlight VCS conflict markers

-- Colorscheme
vim.g.gruvbox_sign_column = 'bg0'
vim.g.gruvbox_italicize_strings = 1
vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")

-- Autocommands
autocmd('highlights', {
  [[VimEnter * highlight clear SignColumn]],
  [[VimEnter * highlight GitGutterAdd guibg=bg]],
  [[VimEnter * highlight GitGutterChange guibg=bg]],
  [[VimEnter * highlight GitGutterDelete guibg=bg]]
}, true)

autocmd('buf_write', {
  [[TextYankPost * silent! lua require'vim.highlight'.on_yank()]],
  [[VimResized * :wincmd =]],
  [[BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif]]
}, true)

autocmd('fmt', {
  [[FileType rust,elixir au! BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)]],
}, true)

autocmd('packer_user_config', {
  [[BufWritePost plugins.lua source <afile> | PackerCompile]]
}, true)
