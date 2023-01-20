return {
  -- Statusline
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
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
          lualine_b = { 'branch', { 'diff', source = diff_source },
            { 'diagnostics', sources = { 'nvim_diagnostic', 'coc' } } },
        }
      })
    end
  },

  -- Tabs
  { 'romgrk/barbar.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = "VeryLazy",
    config = function()
      require 'bufferline'.setup {
        icons = true,
      }

      vim.g.bufferline = {
        auto_hide = true,
        tabpages = true,
        closable = false,
      }

      -- Move to previous/next
      vim.keymap.set('n', '<M-,>', ':BufferPrevious<CR>', { silent = true })
      vim.keymap.set('n', '<M-.>', ':BufferNext<CR>', { silent = true })

      -- Re-order to previous/next
      vim.keymap.set('n', '<M-<>', ':BufferMovePrevious<CR>', { silent = true })
      vim.keymap.set('n', '<M->>', ' :BufferMoveNext<CR>', { silent = true })

      -- Goto buffer in position...
      vim.keymap.set('n', '<M-1>', ':BufferGoto 1<CR>', { silent = true })
      vim.keymap.set('n', '<M-2>', ':BufferGoto 2<CR>', { silent = true })
      vim.keymap.set('n', '<M-3>', ':BufferGoto 3<CR>', { silent = true })
      vim.keymap.set('n', '<M-4>', ':BufferGoto 4<CR>', { silent = true })
      vim.keymap.set('n', '<M-5>', ':BufferGoto 5<CR>', { silent = true })
      vim.keymap.set('n', '<M-6>', ':BufferGoto 6<CR>', { silent = true })
      vim.keymap.set('n', '<M-7>', ':BufferGoto 7<CR>', { silent = true })
      vim.keymap.set('n', '<M-8>', ':BufferGoto 8<CR>', { silent = true })
      vim.keymap.set('n', '<M-9>', ':BufferGoto 9<CR>', { silent = true })

      -- Close commands
      vim.keymap.set('n', '<M-c>', ':BufferCloseAllButCurrent<CR>', { silent = true })

      -- Magic buffer-picking mode
      vim.keymap.set('n', '<C-p>', ':BufferPick<CR>', { silent = true })

      -- Sort automatically by...
      vim.keymap.set('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', { silent = true })
      vim.keymap.set('n', '<Space>bd', ':BufferOrderByDirectory<CR>', { silent = true })
      vim.keymap.set('n', '<Space>bl', ':BufferOrderByLanguage<CR>', { silent = true })
    end
  },

  --  Directory viewer
  { 'justinmk/vim-dirvish',
    dependencies = { 'kristijanhusak/vim-dirvish-git' },
    config = function()
      vim.g.dirvish_mode = [[:sort ,^.*[\/],]]
    end,
  },
}
