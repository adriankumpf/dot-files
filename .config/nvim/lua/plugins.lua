local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'AndrewRadev/splitjoin.vim'                                    --  Transition between multi- & single-line code (gJ | gS)
  use 'PeterRincker/vim-searchlight'                                 --  Highlight the current search match
  use 'romainl/vim-cool'                                             --  Make hlsearch more useful
  use { 'mhinz/vim-sayonara', { cmd = 'Sayonara' } }
  use { 'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'} }
  use 'sheerun/vim-polyglot'                                         --  All languages as one plugin
  use 'tpope/vim-commentary'                                         --  Commenting support (gc)
  use 'tpope/vim-sleuth'                                             --  Heuristically set indent settings
  use 'tpope/vim-surround'                                           --  Surround with cs
  use 'axelf4/vim-strip-trailing-whitespace'                         -- Remove trailing whitespace from *modified* lines on save
  use { 'vim-airline/vim-airline', config = [[require('config.airline')]] }
  use { 'sbdchd/neoformat', config = [[require('config.neoformat')]] }
  use { 'iamcco/markdown-preview.nvim', ft = {'markdown'}, cmd = 'cd app && yarn install', }

  -- Tabs
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = [[require('config.barbar')]]
  }

  --  Directory viewer
  use {
    'justinmk/vim-dirvish',
    requires = {'kristijanhusak/vim-dirvish-git'},
    config = [[require('config.dirvish')]]
  }

  --  Improve star by not jumping immediately
  use {
    'ironhouzi/starlite-nvim',
    config = [[require('config.starlite')]],
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('config.gitsigns')]],
  }

  -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'telescope-fzf-native.nvim', },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
  }

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {'nvim-treesitter/nvim-treesitter-refactor'},
    config = [[require('config.treesitter')]],
    run = ':TSUpdate',
  }

 -- Completion
  use {
    {
      'hrsh7th/nvim-cmp',
      requires = {
        'L3MON4D3/LuaSnip',
        'hrsh7th/cmp-nvim-lsp',
        { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      },
      config = [[require('config.cmp')]],
      event = 'InsertEnter *',
    },
    { 'neovim/nvim-lspconfig', config = [[require('config.lsp')]], }
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

