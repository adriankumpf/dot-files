local telescope = require("telescope")
local builtin = require('telescope.builtin')

project_files = function()
  local in_git_repo = vim.fn.systemlist"git rev-parse --is-inside-work-tree"[1] == 'true'
  if in_git_repo then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

vim.keymap.set('n', '<leader>f', project_files, {})
vim.keymap.set('n', '<leader>r', builtin.live_grep, {})
vim.keymap.set('n', '<leader>a', function() builtin.find_files({follow=true, no_ignore=true, hidden=true}) end, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>o', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>tk', builtin.keymaps, {})
vim.keymap.set('n', ',S', builtin.grep_string, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    path_display = { "truncate" },
    set_env = { ["COLORTERM"] = "truecolor" },
    mappings = {
      i = { ["<esc>"] = require("telescope.actions").close },
    },
  },
}

telescope.setup(options)
telescope.load_extension('fzf')
