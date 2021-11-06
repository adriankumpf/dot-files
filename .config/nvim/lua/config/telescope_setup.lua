local map = require('config.utils').map

function _G.project_files()
  local builtin = require('telescope.builtin')
  local themes = require('telescope.themes')

  local ok = pcall(builtin.git_files, themes.get_ivy())
  if not ok then builtin.find_files(themes.get_ivy()) end
end

map("n", "<leader>f", [[<cmd>lua project_files()<cr>]])
map("n", "<leader>r", [[<cmd>Telescope live_grep theme=ivy<cr>]])
map("n", "<leader>la", [[<cmd>Telescope lsp_code_actions theme=ivy<cr>]])
map("n", "<leader>lt", [[<cmd>Telescope treesitter theme=ivy<cr>]])

map("n", ",S", [[<cmd>Telescope grep_string theme=ivy<cr>]])
