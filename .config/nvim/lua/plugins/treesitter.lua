local ts_configs = require 'nvim-treesitter.configs'
ts_configs.setup {
  ensure_installed = {
    "comment", "css", "dockerfile", "eex", "elixir", "erlang", "fish", "go",
    "heex", "html", "javascript", "json", "lua", "make", "markdown", "python",
    "regex", "ruby", "rust", "scss", "vim", "vue", "yaml", "bash"
  },
  highlight = { enable = true, },
  indent = { enable = true },
  refactor = {
    smart_rename = { enable = true, keymaps = { smart_rename = 'grr' } },
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false }
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart', -- works in visual mode
    }
  },
}
