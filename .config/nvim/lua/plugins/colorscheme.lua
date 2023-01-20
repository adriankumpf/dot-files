return {
  { 'ellisonleao/gruvbox.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = false,
    priority = 1000,
    config = function()
      local palette = require("gruvbox.palette")

      require("gruvbox").setup({
        overrides = {
          GitSignsAdd = { fg = palette.bright_green, bg = palette.dark0 },
          GitSignsChange = { fg = palette.bright_aqua, bg = palette.dark0 },
          GitSignsDelete = { fg = palette.bright_red, bg = palette.dark0 },
          DiagnosticSignError = { fg = palette.bright_red, bg = palette.dark0 },
          DiagnosticSignWarn = { fg = palette.bright_yellow, bg = palette.dark0 },
          DiagnosticSignInfo = { fg = palette.bright_blue, bg = palette.dark0 },
          DiagnosticSignHint = { fg = palette.bright_aqua, bg = palette.dark0 },
        }
      })

      vim.cmd("colorscheme gruvbox")
    end
  },
}
