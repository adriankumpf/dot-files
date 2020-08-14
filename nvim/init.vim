let g:from_lock = {'do': 'yarn install --frozen-lockfile'}

call plug#begin('~/.config/nvim/plugged')
Plug 'AndrewRadev/splitjoin.vim'                               "  Transition between multi- & single-line code (gJ | gS)
Plug 'airblade/vim-gitgutter'                                  "  Git changes showed on line numbers
Plug 'ironhouzi/vim-stim'                                      "  Improve star by not jumping immediately
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }            "  Open Markdown files in Marked
Plug '/usr/local/opt/fzf'                                      "  FZF (brew install fzf)
Plug 'junegunn/fzf.vim'                                        "  FZF integration
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                "  Intelligent buffer closing
Plug 'morhetz/gruvbox'                                         "  *THE* Colorscheme
Plug 'sheerun/vim-polyglot'                                    "  All languages as one plugin
Plug 'tpope/vim-commentary'                                    "  Commenting support (gc)
Plug 'tpope/vim-sleuth'                                        "  Heuristically set indent settings
Plug 'tpope/vim-surround'                                      "  Surround with cs
Plug 'justinmk/vim-dirvish'                                    " Directory viewer
Plug 'kristijanhusak/vim-dirvish-git'                          " Git support for dirvish.vim
Plug 'vim-airline/vim-airline'                                 "  status/tabline
Plug 'neoclide/coc.nvim', {'branch': 'release' }               " Intellisense engine
Plug 'amiralies/coc-elixir',          {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'fannheyward/coc-sql',			      g:from_lock
Plug 'fannheyward/coc-rust-analyzer', g:from_lock
Plug 'neoclide/coc-css',              g:from_lock
Plug 'neoclide/coc-stylelint',        g:from_lock
Plug 'neoclide/coc-eslint',           g:from_lock
Plug 'neoclide/coc-html',             g:from_lock
Plug 'neoclide/coc-json',             g:from_lock
Plug 'neoclide/coc-lists',            g:from_lock
Plug 'neoclide/coc-tsserver',	        g:from_lock
Plug 'neoclide/coc-pairs',            g:from_lock
Plug 'neoclide/coc-snippets',         g:from_lock
Plug 'neoclide/coc-prettier',         g:from_lock
Plug 'iamcco/coc-diagnostic',         g:from_lock
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
set pumblend=35
set noemoji
set lazyredraw


syntax on
filetype plugin on


let g:mapleader="\<space>"

inoremap jj <esc>

nnoremap <silent> ,w :w<CR>
nnoremap <silent> ,q :Sayonara<CR>

nnoremap <Leader><Leader> <C-^>

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>m :MarkedOpen!<CR>

nnoremap <silent> <CR> :set nohlsearch!<CR> :set nohlsearch?<CR>

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

nnoremap / /\v
vnoremap / /\v

vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

nnoremap <silent> <Leader>co :<C-u>CocList outline<CR>
nnoremap <silent> <Leader>cs :<C-u>CocList -I symbols<CR>
nnoremap <silent> <Leader>cl :<C-u>CocList locationlist<CR>
nnoremap <silent> <Leader>cc :<C-u>CocList commands<CR>

nmap <Leader>$ <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call utils#show_documentation()<CR>

" Use tab for trigger completion
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>CheckBackSpace() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction


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

let g:marked_app = 'Markoff'

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'


match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers

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

augroup buf_write
  au!
  au BufWritePre * call utils#StripTrailingWhitespaces()
  au TextYankPost * silent! lua require'vim.highlight'.on_yank()
  au VimResized * :wincmd = " Resize splits when the window is resized
  au BufReadPost * " Return to same line when reopening a file
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     execute 'normal! g`"zvzz' |
  \ endif
augroup END
