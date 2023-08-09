return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim',          cmd = "Mason", build = ":MasonUpdate" },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp = require('lsp-zero')
      local cmp = require('cmp')

      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      local lexical_config = {
        filetypes = { "elixir", "eelixir", },
        cmd = { vim.loop.os_homedir() .. "/Developer/third_party/lexical/_build/dev/rel/lexical/start_lexical.sh" },
        settings = {},
      }

      if not configs.lexical then
        configs.lexical = {
          default_config = {
            filetypes = lexical_config.filetypes,
            cmd = lexical_config.cmd,
            root_dir = function(fname)
              return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
            end,
            -- optional settings
            settings = lexical_config.settings,
          },
        }
      end

      lspconfig.lexical.setup({})

      lsp.configure("yamlls", {
        settings = {
          yaml = {
            keyOrdering = false
          }
        }
      })

      lsp.preset('recommended')
      lsp.nvim_workspace()
      lsp.setup()

      cmp.setup({
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }
      })

      vim.diagnostic.config({
        virtual_text = true,
      })
    end
  },

  -- Linting, Formatting & Code Actions
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig"
    },
    event = "BufReadPre",
    opts = function()
      local null_ls = require("null-ls")

      return {
        sources = {
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
        },
      }
    end
  },
}
