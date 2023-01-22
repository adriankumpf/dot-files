return {
  -- Sane buffer/window deletion.
  { 'mhinz/vim-sayonara',
    cmd = 'Sayonara'
  },

  -- Transition between multi- & single-line code (gJ | gS)
  'AndrewRadev/splitjoin.vim',

  --  Improve star by not jumping immediately
  { 'ironhouzi/starlite-nvim',
    keys = {
      { "*", function() require('starlite').star() end, silent = true, desc = "Search forward" },
      { "g*", function() require('starlite').g_star() end, silent = true, desc = "Search backward" },
      { "#", function() require('starlite').hash() end, silent = true },
      { "g#", function() require('starlite').g_hash() end, silent = true },
    }
  },

  -- Quick on-screen jumps
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    keys = {
      { 's', function() require('leap').leap { target_windows = { vim.fn.win_getid() } } end, desc = "Leap" }
    }
  },

  --  Heuristically set indent settings
  'tpope/vim-sleuth',

  -- Modifying surrounding delimiter pairs
  { "kylechui/nvim-surround", config = true },

  -- Comments
  {
    'numToStr/Comment.nvim',
    config = true
  },

  -- Strip trailing whitespace
  { "mcauley-penney/tidy.nvim",
    event = 'BufWritePre',
    config = true
  },

  --  Make hlsearch more useful
  {
    "asiryk/auto-hlsearch.nvim",
    event = "VeryLazy",
    config = true
  },

  -- Git Stuff
  { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "BufReadPre",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { virt_text_pos = 'right_align' },
      yadm = { enable = true },
    }
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- Markdown
  { 'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    cmd = "MarkdownPreview",
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      { "<leader>m", "<cmd> MarkdownPreview<cr>", silent = true }
    },
  },
}
