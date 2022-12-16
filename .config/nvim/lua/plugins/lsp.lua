local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
