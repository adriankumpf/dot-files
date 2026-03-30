-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- Display
vim.opt.fillchars = { vert = "│", stl = " ", stlnc = " " }
vim.opt.list = true
vim.opt.listchars = { tab = "┆·", trail = "·", precedes = "", extends = "", nbsp = "‗" }
vim.opt.showbreak = "↪"
vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.scrolloff = 7
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.cmdheight = 0 -- paired with RecordingEnter/Leave autocmds
vim.opt.laststatus = 3
vim.opt.pumblend = 35 -- semi-transparent popup menu
vim.opt.emoji = true

-- Backup / undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- Behavior
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = "useopen"
vim.opt.mouse = "a"
vim.opt.whichwrap:append("<>[]hl")

-- Completion / command line
vim.opt.complete:append({ "kspell" })
vim.opt.wildmode = "longest,full"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append({ c = true })
vim.opt.spell = false

vim.diagnostic.config({ virtual_text = true })
