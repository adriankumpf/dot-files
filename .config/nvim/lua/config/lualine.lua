local gps = require("nvim-gps")

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require('lualine').setup({
  options = {
    theme = 'powerline',
  },
  sections = {
    lualine_b = {'branch', {'diff', source = diff_source}, {'diagnostics', sources = {'nvim_lsp', 'coc'} } },
    lualine_c = { 'filename', { gps.get_location, cond = gps.is_available } }
  }
})
