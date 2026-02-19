vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.fillchars = { vert = "│", stl = " ", stlnc = " " }
vim.opt.list = true
vim.opt.listchars = { tab = "┆·", trail = "·", precedes = "", extends = "", nbsp = "‗" }
vim.opt.showbreak = "↪"
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.scrolloff = 7
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = "useopen"
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.complete:append({ "kspell" })
vim.opt.wildmode = "longest,full"
vim.opt.pumblend = 35
vim.opt.emoji = false
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append({ c = true })
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.spell = false

vim.diagnostic.config({ virtual_text = true })

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

vim.g.mapleader = " "
