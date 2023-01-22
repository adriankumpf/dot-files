return {
  -- Statusline
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
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
          globalstatus = true,
          theme = 'powerline',
        },
        sections = {
          lualine_b = {
            'branch', { 'diff', source = diff_source },
            { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } }
          },
        }
      })
    end
  },

  -- Tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { "tiagovla/scope.nvim", config = true }
    },
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = true,
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        sort_by = 'relative_directory',
      },
      highlights = function(config)
        local hl = {}

        for name, tbl in pairs(config.highlights) do
          local tbl_copy = {}
          for k, v in pairs(tbl) do
            if k == 'bg' then
              tbl_copy[k] = "NONE"
            else
              tbl_copy[k] = v
            end
          end
          hl[name] = tbl_copy
        end

        return hl
      end
    },
    config = function(_, opts)
      -- Move to previous/next
      vim.keymap.set('n', '<M-,>', ':BufferLineCyclePrev<CR>', { silent = true })
      vim.keymap.set('n', '<M-.>', ':BufferLineCycleNext<CR>', { silent = true })

      -- Re-order to previous/next
      vim.keymap.set('n', '<M-<>', ':BufferLineMovePrev<CR>', { silent = true })
      vim.keymap.set('n', '<M->>', ' :BufferLineMoveNext<CR>', { silent = true })

      local closeAllButCurrent = function()
        vim.cmd("BufferLineCloseRight")
        vim.cmd("BufferLineCloseLeft")
      end

      vim.keymap.set('n', '<M-c>', closeAllButCurrent, { silent = true })

      require("bufferline").setup(opts)
    end,
  },

  --  Directory viewer
  { 'justinmk/vim-dirvish',
    dependencies = { 'kristijanhusak/vim-dirvish-git' },
    config = function()
      vim.g.dirvish_mode = [[:sort ,^.*[\/],]]
    end,
  },
}
