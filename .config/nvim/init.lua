local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require 'options'
require 'mappings'
require 'autocmds'

require "lazy".setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    colorscheme = { "gruvbox" }
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 10800
  }
})
