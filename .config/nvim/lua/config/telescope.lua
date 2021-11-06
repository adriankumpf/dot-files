local telescope = require 'telescope'
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    layout_strategy = 'flex',
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

telescope.load_extension('fzf')
