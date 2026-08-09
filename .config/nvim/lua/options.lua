-- Indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true

-- Display
vim.o.list = true
vim.opt.listchars = { tab = "┆·", trail = "·", precedes = "", extends = "", nbsp = "‗" }
vim.o.showbreak = "↪"
vim.o.number = false
vim.o.relativenumber = false
vim.o.scrolloff = 7
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.cmdheight = 0 -- paired with RecordingEnter/Leave autocmds
vim.o.laststatus = 3
vim.o.pumblend = 35

-- Backup / undo
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undofile = true

-- Behavior
vim.opt.clipboard:append({ "unnamedplus" })
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.switchbuf = "useopen"
vim.o.mouse = "a"
vim.opt.whichwrap:append("<>[]hl")

-- Completion / command line
vim.opt.complete:append({ "kspell" })
vim.o.wildmode = "longest,full"
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.shortmess:append({ c = true })

vim.diagnostic.config({ virtual_text = true })
