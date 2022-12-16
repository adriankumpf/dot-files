local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print "Cloning packer .."
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Transition between multi- & single-line code (gJ | gS)
  use 'AndrewRadev/splitjoin.vim'

  -- Strip trailing whitespace
  use { "mcauley-penney/tidy.nvim",
    event = 'BufWritePre',
    config = function() require("tidy").setup() end
  }

  --  Make hlsearch more useful
  use 'romainl/vim-cool'

  -- Sane buffer/window deletion.
  use { 'mhinz/vim-sayonara', { cmd = 'Sayonara' } }

  -- Colorscheme
  use { 'ellisonleao/gruvbox.nvim',
    requires = { 'rktjmp/lush.nvim' },
    config = function() require("plugins.gruvbox") end,
  }

  --  Heuristically set indent settings
  use 'tpope/vim-sleuth'

  -- Modifying surrounding delimiter pairs
  use { "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup() end
  }

  -- Comments
  use { 'numToStr/Comment.nvim',
    config = function() require('plugins.comment') end
  }

  -- Markdown
  use { 'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    cmd = "MarkdownPreview",
    run = function() vim.fn["mkdp#util#install"]() end,
    config = function() require('plugins.markdown_preview') end,
  }

  -- Statusline
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugins.lualine') end,
  }

  -- Tabs
  use { 'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugins.barbar') end,
  }

  --  Directory viewer
  use { 'justinmk/vim-dirvish',
    requires = { 'kristijanhusak/vim-dirvish-git' },
    config = function() require('plugins.dirvish') end,
  }

  --  Improve star by not jumping immediately
  use { 'ironhouzi/starlite-nvim',
    config = function() require('plugins.starlite') end,
  }

  -- Quick on-screen jumps
  use {
    "ggandor/leap.nvim",
    config = function() require('plugins.leap') end,
  }

  -- Git
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.gitsigns') end,
    event = "BufRead"
  }

  -- Search
  use { "nvim-telescope/telescope.nvim",
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function() require "plugins.telescope" end,
  }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter-refactor', 'RRethy/nvim-treesitter-textsubjects' },
    config = function() require('plugins.treesitter') end,
    run = ':TSUpdate',
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    config = [[require('plugins.lsp')]],
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
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
    }
  }

  -- Linting, Formatting & Code Actions
  use { "jose-elias-alvarez/null-ls.nvim",
    config = [[require('plugins.null_ls')]],
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
