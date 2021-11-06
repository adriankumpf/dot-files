local utils = require 'config.utils'
local autocmd = utils.autocmd
local map = utils.map

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'AndrewRadev/splitjoin.vim'                                    --  Transition between multi- & single-line code (gJ | gS)
  use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'PeterRincker/vim-searchlight'                                 --  Highlight the current search match
  use 'ironhouzi/starlite-nvim'                                      --  Improve star by not jumping immediately
  use 'romainl/vim-cool'                                             --  Make hlsearch more useful
  use { 'mhinz/vim-sayonara', { cmd = 'Sayonara' } }
  use { 'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'} }
  use 'sheerun/vim-polyglot'                                         --  All languages as one plugin
  use 'tpope/vim-commentary'                                         --  Commenting support (gc)
  use 'tpope/vim-sleuth'                                             --  Heuristically set indent settings
  use 'tpope/vim-surround'                                           --  Surround with cs
  use 'justinmk/vim-dirvish'                                         --  Directory viewer
  use 'kristijanhusak/vim-dirvish-git'                               --  Git support for dirvish.vim
  use 'vim-airline/vim-airline'                                      --  status/tabline
  use 'sbdchd/neoformat'
  use 'axelf4/vim-strip-trailing-whitespace'                         -- Remove trailing whitespace from *modified* lines on save

  use {
    { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim', 'telescope-fzf-native.nvim', }, cmd = 'Telescope', },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
  }

  use {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
  }

  use { 'iamcco/markdown-preview.nvim', ft = {'markdown'}, cmd = 'cd app && yarn install', }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.opt.clipboard:append {"unnamed"}
vim.opt.expandtab = true; vim.opt.tabstop = 2; vim.opt.softtabstop = 2; vim.opt.shiftwidth = 2
vim.opt.fillchars = { vert = "│", stl = " ", stlnc = " " }
vim.opt.list = true; vim.opt.listchars = { tab = "┆·", trail = '·', precedes = "", extends = "", nbsp = "‗" }; vim.opt.showbreak = "↪"
vim.opt.joinspaces = false
vim.opt.number = false; vim.opt.relativenumber = false
vim.opt.swapfile = false; vim.opt.backup = false; vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.scrolloff = 7
vim.opt.smartindent = true
vim.opt.splitbelow = true; vim.opt.splitright = true
vim.opt.hidden =true; vim.opt.switchbuf = "useopen"
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.complete:append {"kspell"}
vim.opt.inccommand = "nosplit"
vim.opt.wildmode = { list = "longest", list = "full" }
vim.opt.pumblend = 35
vim.opt.emoji = false
vim.opt.lazyredraw = true
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append { c = true }

vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "jj", "<esc>")

map("n", ",w", ":w<CR>", { silent = true })
map("n", ",q", ":Sayonara<CR>", { silent = true })

map("n", "<Leader><Leader>", "<C-^>")

function _G.project_files()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

map("n", "<leader>f", [[<cmd>lua project_files()<cr>]])
map("n", "<leader>r", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map("n", "<leader>n", [[<cmd>lua require('telescope.builtin').file_browser()<cr>]])
map("n", "<leader>la", [[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]])
map("n", "<leader>lt", [[<cmd>lua require('telescope.builtin').treesitter()<cr>]])

map("n", "<Tab>", ":bnext<CR>", { silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

map("n", "<Leader>z", "z=1<CR><CR>")

map("n", "<expr>", 'k (v:count == 0 ? "gk" : "k")')
map("n", "<expr>", 'j (v:count == 0 ? "gj" : "j")')

map("n", "J", "mzJ`z")
map("n", "S", "mzi<CR><ESC>`z")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", ",s", ":%s///gc<Left><Left><Left>")
map("n", ",S", [[<cmd>lua require('telescope.builtin').grep_string()<cr>]])

map("n", "s", '"_d')

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("v", "n", "nzz")
map("v", "N", "Nzz")

map("n", "Q", "@q")

map("n", "/", [[/\v\c]])
map("v", "/", [[/\v\c]])

map("v", "y", "y`]")
map("v", "p", '"_dP`]')
map("n", "p", "p`]")

map("n", "*", [[<cmd> lua require'starlite'.star()<cr>]], { silent = true })
map("n", "g*", [[<cmd> lua require'starlite'.g_star()<cr>]], { silent = true })
map("n", "#", [[<cmd> :lua require'starlite'.hash()<cr>]], { silent = true })
map("n", "g#", [[<cmd> :lua require'starlite'.g_hash()<cr>]], { silent = true })

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end
function _G.smart_shift_tab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

map("i", '<Tab>', 'v:lua.smart_tab()', { expr = true })
map("i", '<S-Tab>', 'v:lua.smart_shift_tab()', { expr = true })

vim.g.fzf_layout = { window = { width = 1, height = 0.4, yoffset = 1, border = 'horizontal' } }

vim.g.dirvish_mode = [[:sort ,^.*[\/],]]

vim.g.diagnostic_virtual_text_prefix = ""
vim.g.diagnostic_enable_virtual_text = 1

vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
vim.g.completion_matching_smart_case = 1
vim.g.completion_trigger_on_delete = 1

vim.g.airline_powerline_fonts = 1

vim.g.neoformat_basic_format_trim = 1
vim.g.neoformat_enabled_css = { 'prettier' }
vim.g.neoformat_enabled_html = { 'prettier' }
vim.g.neoformat_enabled_json = { 'prettier' }
vim.g.neoformat_enabled_markdown = { 'prettier' }
vim.g.neoformat_enabled_scss = { 'prettier' }

vim.cmd [[match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$']] -- Highlight VCS conflict markers

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = {
  'cssls', 'html', 'jsonls', 'rust_analyzer', 'tsserver',
  'vimls', 'vuels', 'yamlls'
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp.elixirls.setup{
  on_attach= on_attach,
  capabilities = capabilities,
  cmd = { vim.fn.expand("$HOME") .. "/Developer/third_party/elixir-ls/release/language_server.sh" },
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
}

nvim_lsp.sqlls.setup{
  on_attach= on_attach,
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" };
}

nvim_lsp.diagnosticls.setup {
  on_attach= on_attach,
  capabilities = capabilities,
  filetypes = { 'sh', 'dockerfile' },
  init_options = {
    linters = {
      shellcheck = {
        command = 'shellcheck',
        debounce = 100,
        args = { '--format', 'json', '-' },
        sourceName = 'shellcheck',
        parseJson = {
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${code}]',
          security = 'level'
        },
        securities = {
          error = 'error',
          warning = 'warning',
          info = 'info',
          style = 'hint'
        }
      },

      hadolint = {
        command = 'hadolint',
        sourceName = 'hadolint',
        args = { '-f', 'json', '-' },
        parseJson = {
          line = 'line',
          column = 'column',
          security = 'level',
          message = '${message} [${code}]'
        },
        securities = {
          error = 'error',
          warning = 'warning',
          info = 'info',
          style = 'hint'
        }
      },
    },

    filetypes = {
      dockerfile = 'hadolint',
      sh = 'shellcheck',
    },
  }
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.cmd [[command! Format execute 'lua vim.lsp.buf.formatting()']]

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = true },
}

require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = { virt_text_pos = 'right_align' },
}

vim.g.gruvbox_italicize_strings = 1
vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")

vim.cmd [[
  hi vertsplit ctermbg=235 ctermfg=245 guifg=#3c3836 guibg=bg
  hi NonText ctermbg=235 ctermfg=245 guifg=#3c3836 guibg=bg

  hi TabLineFill cterm=None ctermfg=15 ctermbg=242 gui=None guibg=bg
  hi TabLineSel ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=bg

  hi cursorline cterm=none guibg=none
  hi cursorlinenr ctermfg=red guifg=red

  hi link Searchlight Incsearch

  call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
  call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
  call sign_define("LspDiagnosticsInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
  call sign_define("LspDiagnosticsHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
]]


vim.cmd [[
augroup highlights
  au!
  au VimEnter * highlight clear SignColumn
  au VimEnter * highlight GitGutterAdd guibg=bg
  au VimEnter * highlight GitGutterChange guibg=bg
  au VimEnter * highlight GitGutterDelete guibg=bg
augroup END

augroup buf_write
  au!
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au VimResized * :wincmd = " Resize splits when the window is resized
  au BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

augroup fmt
  au!
  au FileType html,css,scss,vue,javascript,markdown,json,sql,yaml au! BufWritePre * Neoformat
  au FileType rust,elixir au! BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END
]]
