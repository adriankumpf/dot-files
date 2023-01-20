local project_files = function()
  local in_git_repo = vim.fn.systemlist "git rev-parse --is-inside-work-tree"[1] == 'true'
  if in_git_repo then
    require("telescope.builtin").git_files({ show_untracked = true })
  else
    require("telescope.builtin").find_files()
  end
end

return { "nvim-telescope/telescope.nvim",
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  cmd = "Telescope",
  keys = {
    { '<leader>f', project_files, desc = "Find Files (Project)" },
    { '<leader>r', function() require('telescope.builtin').live_grep() end, desc = "Find in Files (Grep)" },
    { '<leader>a',
      function() require('telescope.builtin').find_files({ follow = true, no_ignore = true, hidden = true }) end,
      desc = "Find Files (All)" },
    { '<leader>b', function() require('telescope.builtin').buffers() end, desc = "Buffers" },
    { '<leader>h', function() require('telescope.builtin').help_tags() end, desc = "Help Pages" },
    { '<leader>o', function() require('telescope.builtin').oldfiles() end, desc = "Recent" },
    { '<leader>tk', function() require('telescope.builtin').keymaps() end, desc = "Keymaps" },
    { ',S', function() require('telescope.builtin').grep_string({ use_regex = true }) end, desc = "Find Word" },
    { '<leader>gc', function() require('telescope.builtin').git_commits() end, "Git commits" },
    { '<leader>gs', function() require('telescope.builtin').git_status() end, "Git Status" },
  },
  config = function()
    local telescope = require("telescope")

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
  end
}
