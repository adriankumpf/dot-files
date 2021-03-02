call plug#begin(stdpath('data') . '/vim-plug')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'AndrewRadev/splitjoin.vim'                    "  Transition between multi- & single-line code (gJ | gS)
Plug 'airblade/vim-gitgutter'                       "  Git changes showed on line numbers
Plug 'ironhouzi/vim-stim'                           "  Improve star by not jumping immediately
Plug 'PeterRincker/vim-searchlight'                 "  Highlight the current search match
Plug 'romainl/vim-cool'                             "  Make hlsearch more useful
Plug '/usr/local/opt/fzf'                           "  FZF (brew install fzf)
Plug 'junegunn/fzf.vim'                             "  FZF integration
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }     "  Intelligent buffer closing
Plug 'lifepillar/gruvbox8'                          "  *THE* Colorscheme
Plug 'sheerun/vim-polyglot'                         "  All languages as one plugin
Plug 'tpope/vim-commentary'                         "  Commenting support (gc)
Plug 'tpope/vim-sleuth'                             "  Heuristically set indent settings
Plug 'tpope/vim-surround'                           "  Surround with cs
Plug 'justinmk/vim-dirvish'                         "  Directory viewer
Plug 'kristijanhusak/vim-dirvish-git'               "  Git support for dirvish.vim
Plug 'vim-airline/vim-airline'                      "  status/tabline
Plug 'sbdchd/neoformat'
Plug 'axelf4/vim-strip-trailing-whitespace'         " Remove trailing whitespace from *modified* lines on save
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()


set clipboard+=unnamed
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set fillchars=vert:│,stl:\ ,stlnc:\ ,
set list listchars=tab:┆·,trail:·,precedes:,extends:,nbsp:‗ showbreak=↪
set nojoinspaces
set nonumber
set norelativenumber
set noswapfile nobackup nowritebackup
set undofile
set scrolloff=7
set smartindent
set splitbelow splitright
set hidden switchbuf=useopen
set termguicolors
set mouse=a
set signcolumn=yes
set noshowmode
set complete+=kspell
set inccommand=nosplit
set wildmode=list:longest,list:full
set pumblend=35
set noemoji
set lazyredraw
set completeopt=menuone,noinsert,noselect shortmess+=c

syntax on
filetype plugin on


let g:mapleader="\<space>"

inoremap jj <esc>

nnoremap <silent> ,w :w<CR>
nnoremap <silent> ,q :Sayonara<CR>

nnoremap <Leader><Leader> <C-^>

nnoremap <silent> <leader>f :Files<CR>

nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

nnoremap <Leader>z z=1<CR><CR>

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap J mzJ`z
nnoremap S mzi<CR><ESC>`z

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap ,s :%s///gc<Left><Left><Left>
nnoremap ,S :Rg 

nnoremap s "_d

nnoremap n nzz
nnoremap N Nzz
vnoremap n nzz
vnoremap N Nzz

nnoremap Q @q

nnoremap / /\v\c
vnoremap / /\v\c

vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


if executable('bat')
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
endif

if executable('rg')
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

  command! -nargs=* -bang RG call utils#RipgrepFzf(<q-args>, <bang>0)
endif

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

let g:dirvish_mode = ':sort ,^.*[\/],'

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

let g:airline_powerline_fonts = 1

let g:neoformat_basic_format_trim = 1
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_scss = ['prettier']


match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = {
    'bashls', 'cssls', 'dockerls', 'elixirls', 'html', 'jsonls',
    'rust_analyzer', 'sqlls', 'tsserver', 'vimls', 'vuels', 'yamlls'
  }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach, }
  end

  nvim_lsp.diagnosticls.setup {
    on_attach= on_attach,
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
EOF

command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = { enable = true, },
    indent = { enable = true },
  }
EOF


let g:gruvbox_italicize_strings = 1
colorscheme gruvbox8
set background=dark


hi clear SignColumn

hi GitGutterAdd ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=bg
hi GitGutterChange ctermfg=108 ctermbg=237 guifg=#8ec07c guibg=bg
hi GitGutterChangeDelete ctermfg=108 ctermbg=237 guifg=#8ec07c guibg=bg
hi GitGutterDelete ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=bg

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
