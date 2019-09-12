call plug#begin('~/.config/nvim/plugged')
Plug 'AndrewRadev/splitjoin.vim'                               "  Transition between multi- & single-line code (gJ | gS)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }  "  Autocomplete
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }        "  Deoplete support for Rust
Plug 'airblade/vim-gitgutter'                                  "  Git changes showed on line numbers
Plug 'ironhouzi/vim-stim'                                      "  Improve star by not jumping immediately
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }            "  Open Markdown files in Marked
Plug 'jiangmiao/auto-pairs'                                    "  Automatically closing pair stuff
Plug '/usr/local/opt/fzf'                                      "  FZF (brew install fzf)
Plug 'junegunn/fzf.vim'                                        "  FZF integration
Plug 'machakann/vim-highlightedyank'                           "  Make the yanked region apparant
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                "  Intelligent buffer closing
Plug 'morhetz/gruvbox'                                         "  *THE* Colorscheme
Plug 'rakr/vim-one'                                            "  Great light colorscheme
Plug 'sheerun/vim-polyglot'                                    "  All languages as one plugin
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }            "  Elixir Integration Into Vim
Plug 'tpope/vim-commentary'                                    "  Commenting support (gc)
Plug 'tpope/vim-endwise'                                       "  Wisely add 'end' in some PLs
Plug 'tpope/vim-fugitive'                                      "  An awesome Git wrapper
Plug 'tpope/vim-rhubarb'                                       "  GitHub Extension for fugitive
Plug 'tpope/vim-sleuth'                                        "  Heuristically set indent settings
Plug 'tpope/vim-surround'                                      "  Surround with cs
Plug 'tpope/vim-vinegar'                                       "  Improve netrw
Plug 'vim-airline/vim-airline'                                 "  status/tabline
Plug 'w0rp/ale'                                                "  Linting & Fixing / Formatting
call plug#end()


set clipboard+=unnamed
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set fillchars=vert:│,stl:\ ,stlnc:\ ,
set list listchars=tab:▸\ ,trail:·,nbsp:‗ showbreak=↪
set nojoinspaces
set nonumber
set norelativenumber
set noswapfile nobackup nowritebackup
set undofile
set scrolloff=7
set ignorecase
set smartcase
set smartindent
set splitbelow splitright
set hidden
set termguicolors
set mouse=a
set signcolumn=yes
set noshowmode
set complete+=kspell
set inccommand=nosplit
set wildmode=list:longest,list:full


syntax on
filetype plugin on


let g:mapleader="\<space>"

inoremap jj <esc>

nnoremap <silent> ,w :w<CR>
nnoremap <silent> ,q :Sayonara<CR>

nnoremap <Leader><Leader> <C-^>

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <Tab> <C-r>=utils#InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>m :MarkedOpen!<CR>

nnoremap <silent> <C-p> :ALEPrevious<Return>
nnoremap <silent> <C-n> :ALENext<Return>

nnoremap <silent> <CR> :set nohlsearch!<CR> :set nohlsearch?<CR>

nnoremap <Leader>z z=1<CR><CR>

nnoremap J mzJ`z
nnoremap S mzi<CR><ESC>`z

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap ,s :%s///gc<Left><Left><Left>
nnoremap ,S :Rg 

nnoremap c "xc
xnoremap c "xc

nnoremap n nzz
nnoremap N Nzz
vnoremap n nzz
vnoremap N Nzz

nnoremap Q @q

nnoremap / /\v
vnoremap / /\v

vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

let g:netrw_liststyle = 3

let g:deoplete#enable_at_startup = 1

let g:marked_app = 'Markoff'

let g:ale_lint_on_text_changed = 0 " ALE
let g:ale_fix_on_save = 1

let g:ale_fixers = {
      \   'c': ['clang-format'],
      \   'cpp': ['clang-format'],
      \   'elixir': ['mix_format'],
      \   'html': ['prettier'],
      \   'javascript': ['prettier'],
      \   'latex': ['latexindent'],
      \   'markdown': ['prettier'],
      \   'python': ['black'],
      \   'rust': ['rustfmt'],
      \   'sql': ['pgformatter'],
      \   'vue': [],
      \}

let g:ale_linters = {
      \   'elixir': [],
      \   'javascript': [],
      \   'latex': ['lacheck'],
      \   'python': ['pylint'],
      \   'rust': ['rls'],
      \   'vue': [],
      \}

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'


match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

if $ITERM_PROFILE ==# 'light'
  colorscheme one
  set background=light
else
  let g:gruvbox_italic=1
  colorscheme gruvbox
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
endif

augroup buf_write
  au!
  autocmd BufWritePre * call utils#StripTrailingWhitespaces()
augroup END

augroup win_resize " Resize splits when the window is resized
  au!
  autocmd VimResized * :wincmd =
augroup END

augroup line_return " Return to same line when reopening a file
  au!
  au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     execute 'normal! g`"zvzz' |
  \ endif
augroup END
