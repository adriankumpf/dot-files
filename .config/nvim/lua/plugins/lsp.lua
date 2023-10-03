return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim',          cmd = "Mason",  build = ":MasonUpdate" },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },

      {
          "Exafunction/codeium.nvim",
          dependencies = {
              "nvim-lua/plenary.nvim",
              "hrsh7th/nvim-cmp",
          },
          config = function()
              require("codeium").setup({
              })
          end
      },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      local lsp_configurations = require('lspconfig.configs')

      if not lsp_configurations.lexical then
        lsp_configurations.lexical = {
          default_config = {
            name = 'Lexical',
            filetypes = { "elixir", "eelixir" },
            cmd = { vim.loop.os_homedir() .. "/Developer/third_party/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
            root_dir = function(fname)
              return require('lspconfig.util').root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
            end,
            settings = {}
          }
        }
      end

      require('lspconfig').lexical.setup({})

      require('lspconfig').yamlls.setup({
        settings = {
          yaml = {
            keyOrdering = false
          }
        }
      })


      local cmp = require('cmp')
      local cmp_format = lsp_zero.cmp_format()
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        formatting = cmp_format,
        sources = {
          { name = 'nvim_lsp' },
          { name = "codeium" },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          -- scroll up and down the documentation window
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          -- Use Enter to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- Enable 'Super Tab'
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        }),
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
