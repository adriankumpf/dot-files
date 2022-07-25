local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'


  use 'AndrewRadev/splitjoin.vim'                                    --  Transition between multi- & single-line code (gJ | gS)
  use 'romainl/vim-cool'                                             --  Make hlsearch more useful
  use { 'mhinz/vim-sayonara', { cmd = 'Sayonara' } }
  use { 'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'} }
  use 'sheerun/vim-polyglot'                                         --  All languages as one plugin
  use 'tpope/vim-sleuth'                                             --  Heuristically set indent settings
  use 'tpope/vim-surround'                                           --  Surround with cs

  use { 'McAuleyPenney/tidy.nvim', event = 'BufWritePre' }

  -- Comments
  use { 'numToStr/Comment.nvim', config = [[require('config.comment')]] }

  -- Markdown
  use {
    'iamcco/markdown-preview.nvim',
    ft = {'markdown'},
    cmd = "MarkdownPreview",
    run = function() vim.fn["mkdp#util#install"]() end,
    config = [[require('config.markdown_preview')]]
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = [[require('config.lualine')]]
  }

  -- Tabs
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
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
    event = "BufRead"
  }

  -- Search
  use { 'ibhagwan/fzf-lua',
    requires = { 'vijaymarupudi/nvim-fzf', 'kyazdani42/nvim-web-devicons' },
    config = [[require('config.fzf')]],
  }

  -- Highlights
  use {
    {
      'nvim-treesitter/nvim-treesitter',
      requires = {'nvim-treesitter/nvim-treesitter-refactor', 'RRethy/nvim-treesitter-textsubjects'},
      config = [[require('config.treesitter')]],
      run = ':TSUpdate',
    },
    { 'lewis6991/spellsitter.nvim', config = function() require('spellsitter').setup() end }
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
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    { "williamboman/mason-lspconfig.nvim", config = function() require("mason-lspconfig").setup() end },
    { 'neovim/nvim-lspconfig', config = [[require('config.lsp')]] }
  }

  -- Linting, Formatting & Code Actions
  use { "jose-elias-alvarez/null-ls.nvim",
    config = [[require('config.null_ls')]],
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
