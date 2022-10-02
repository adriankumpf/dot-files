require("gruvbox").setup({
  overrides = {
    GitSignsAdd = { fg = "#b8bb26", bg = "#282828" },
    GitSignsChange = { fg = "#8ec07c", bg = "#282828" },
    GitSignsDelete = { fg = "#fb4934", bg = "#282828" },
  }
})

vim.cmd("colorscheme gruvbox")
