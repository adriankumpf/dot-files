local null_ls = require("null-ls")

local sources = {
  -- Formatting
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.prettier,

  -- Diagnostics
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.credo.with {
    condition = function(utils)
        return utils.root_has_file('.credo.exs')
    end,
  },

  -- Code Actions
  null_ls.builtins.code_actions.gitsigns,
}

null_ls.config({ sources = sources })

require("lspconfig")["null-ls"].setup({})
