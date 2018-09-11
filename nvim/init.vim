scriptencoding utf-8

" Autoinstall
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup auto_install
    au!
    au VimEnter * PlugInstall
  augroup END
endif

" ===============================
" Plugins
" ===============================

call plug#begin('~/.config/nvim/plugged')

Plug 'DataWraith/auto_mkdir'                                              " Create directory if it does not exist
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }             " Autocomplete
Plug 'airblade/vim-gitgutter'                                             " Git changes showed on line numbers
Plug 'docunext/closetag.vim'                                              " Functions and mappings to close open HTML/XML tags
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }                         " Easy alignment
Plug 'ironhouzi/vim-stim'                                                 " Improve star by not jumping immediately
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }                       " Open Markdown files in Marked
Plug 'jeetsukumaran/vim-buffergator'                                      " open a window listing all buffers
Plug 'jiangmiao/auto-pairs'                                               " Automatically closing pair stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }         " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'                                              " Toggle, display and navigate marks
Plug 'machakann/vim-highlightedyank'                                      " Make the yanked region apparant
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                           " Intelligent buffer closing
Plug 'morhetz/gruvbox'                                                    " THE Colorscheme
Plug 'racer-rust/vim-racer', { 'for': 'rust' }                            " Rust code completion and navigation
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }  " Nerdtree file browser
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }                   " Deoplete support for Rust
Plug 'sheerun/vim-polyglot'                                               " All languages as one plugin
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }                             " Undo Tree
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }                       " Elixir Integration Into Vim
Plug 'tpope/vim-commentary'                                               " Commenting support (gc)
Plug 'tpope/vim-fugitive'                                                 " An awesome Git wrapper
Plug 'tpope/vim-repeat'                                                   " Repeat 'vim-surround' commands with '.'
Plug 'tpope/vim-rhubarb'                                                  " GitHub Extension for fugitive
Plug 'tpope/vim-sleuth'                                                   " Heuristically set indent settings
Plug 'tpope/vim-surround'                                                 " Surround with cs
Plug 'w0rp/ale'                                                           " Ale Linting & Fixing / Formatting
Plug 'rakr/vim-one'                                                       " great light colorscheme
Plug 'zchee/deoplete-clang'                                               " c++/c/obj-c completion
Plug 'christoomey/vim-tmux-navigator'                                     " navigate seamlessly between vim and tmux splits
Plug 'easymotion/vim-easymotion'                                          " Vim motions on speed!
Plug 'tpope/vim-endwise'                                                  " wisely add 'end' in some PLs
Plug 'AndrewRadev/splitjoin.vim'                                          " transition between multiline and single-line code (gJ | gS)
Plug 'vim-airline/vim-airline'                                            " status/tabline

call plug#end()

" ===============================
" General Settings
" ===============================

set backspace=indent,start,eol
set clipboard+=unnamed
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set fillchars=vert:│,stl:\ ,stlnc:\ ,
set hidden
set list listchars=tab:▸\ ,trail:·,nbsp:‗ showbreak=↪
set nojoinspaces
set nonumber
set norelativenumber
set noswapfile nobackup nowritebackup
set scrolloff=7
set ignorecase
set smartcase
set smartindent
set splitbelow splitright
set termguicolors
set mouse=a
set signcolumn=yes
set noshowmode

set complete+=kspell   " Autocomplete with dictionary words when spell check is on
set inccommand=nosplit " Interactive substitution
set synmaxcol=2000     " Turn off syntax for long lines to improve performance

" Enable undo file as non-root
if has('persistent_undo')
  set undodir=~/.config/nvim/undo/
  set undofile
endif

syntax on

filetype plugin on
filetype indent on

" ===============================
" Mappings
" ===============================

let g:mapleader="\<space>"

inoremap jj <esc>

if executable('rg')
  "Add :Rg (ripgrep) command - '?' toggles preview:
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --hidden -g !.git/ -g !*.lock -g !*-lock* --no-heading -i --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
endif

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>n :call NerdWrapper()<CR>
nnoremap <silent> <Leader>u :GundoToggle<CR> " UndoTree
nnoremap <silent> <leader>m :MarkedOpen!<CR> " Marked

" ALE
nnoremap <silent> <C-p> :ALEPrevious<Return>
nnoremap <silent> <C-n> :ALENext<Return>

" Tab completion
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let l:col = col('.') - 1
    if !l:col || getline('.')[l:col - 1] !~# '\k'
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
  endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>

" Save file as root
cmap w!! w !sudo tee > /dev/null %

" When jump to next match also center screen
nnoremap n nzz
nnoremap N Nzz
vnoremap n nzz
vnoremap N Nzz

" Quick replay 'q' macro
nnoremap Q @q

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text
" and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Quick save and close buffer
nnoremap <silent> ,w :w<CR>
nnoremap <silent> ,q :Sayonara<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line
nnoremap S mzi<CR><ESC>`z

" Start substitute on current word under the cursor
nnoremap ,s :%s///gc<Left><Left><Left>

" Search for the word under the cursor in the current directory
nnoremap ,S :Rg 

" Toggle search highlight
nnoremap <silent> <CR> :set nohlsearch!<CR> :set nohlsearch?<CR>

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>|

" Search in very magic mode
nnoremap / /\v
vnoremap / /\v

" Quickly fix spelling errors choosing the first result
nnoremap <Leader>z z=1<CR><CR>

" Given a register (* by default), opens it in the cmdline-window
" Usage: <leader>m or "q<leader>m.
nnoremap <leader>M  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1

nmap <Leader>s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Bring back the Escape key in terminal mode
tnoremap <Esc> <C-\><C-n>


" ===============================
" Plugins settings
" ===============================

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1

" Deoplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#clang#libclang_path='/usr/local/Cellar/llvm/6.0.0/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header='/usr/local/opt/llvm/lib/clang/'
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Open Markoff instead of Marked 2
let g:marked_app = 'Markoff'

" Gundo
if has('python3')
  let g:gundo_prefer_python3 = 1
endif

" ALE
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

let g:ale_fixers = {
      \   'c': ['clang-format'],
      \   'cpp': ['clang-format'],
      \   'elixir': ['mix_format'],
      \   'html': ['prettier'],
      \   'javascript': [],
      \   'markdown': ['prettier'],
      \   'rust': ['rustfmt'],
      \   'vue': [],
      \}

let g:ale_linters = {
      \   'javascript': [],
      \   'vue': [],
      \   'elixir': [],
      \}

let g:ale_javascript_prettier_options = '--single-quote --no-semi'

function! AddLinterIfFileExists(lang, linter, file, lint, fix)
  let l:current = g:ale_linters[a:lang]

  if filereadable(a:file) && index(l:current, a:linter) == -1
    if a:lint
      let g:ale_linters[a:lang] = g:ale_linters[a:lang] + [a:linter]
    endif
    if a:fix
      let g:ale_fixers[a:lang] = g:ale_fixers[a:lang] + [a:linter]
    end
  endif
endfunction

call AddLinterIfFileExists('elixir', 'credo', '.credo.exs', 1, 0)
call AddLinterIfFileExists('elixir', 'credo', 'config/.credo.exs', 1, 0)
call AddLinterIfFileExists('javascript', 'eslint', '.eslintrc.js', 1, 1)
call AddLinterIfFileExists('javascript', 'eslint', '.eslintrc.json', 1, 1)
call AddLinterIfFileExists('javascript', 'standard', 'node_modules/.bin/standard', 1, 1)
call AddLinterIfFileExists('vue', 'eslint', '.eslintrc.js', 1, 1)

" polyglot
let g:jsx_ext_required = 1

" rust.vim
let g:rustfmt_autosave = 1

" deopelete-rust: Automatic racer binary and rust source path detection
if executable('racer')
  let g:racer_cmd = '$HOME/.cargo/bin/racer'
  let g:racer_experimental_completer = 1
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]

  augroup racer
    au!
    au FileType rust nmap gd <Plug>(rust-def)
    au FileType rust nmap gs <Plug>(rust-def-split)
    au FileType rust nmap gx <Plug>(rust-def-vertical)
    au FileType rust nmap <leader>gd <Plug>(rust-doc)
  augroup END
endif

if executable('rustc')
  "$ rustup component add rust-src
  let g:rustc_root = systemlist('rustc --print sysroot')[0]
  let g:rustc_src_dir = g:rustc_root . '/lib/rustlib/src/rust/src'
  if isdirectory(g:rustc_src_dir)
    let g:deoplete#sources#rust#rust_source_path = g:rustc_src_dir
  endif
endif

" Buffergator
let g:buffergator_split_size = 50
let g:buffergator_sort_regime = 'filepath'
let g:buffergator_show_full_directory_path = 0

" AirLine
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" GitGutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

" ===============================
" Color and highlighting settings
" ===============================

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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
endif

" ===============================
" Autocommands
" ===============================

augroup file_type
  au!
  autocmd FileType vim setlocal keywordprg=:help
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType elixir hi link Define GruvboxRed
  autocmd FileType vue syntax sync fromstart " Ensure syntax highlighting doesn't break on Vue files
  autocmd BufNewFile,BufRead Dockerfile* setfiletype dockerfile " Set correct Filetype for Dockerfiles
  autocmd BufNewFile,BufRead *.js setfiletype javascript
augroup END

augroup buf_write
  au!
  autocmd BufWritePre * call StripTrailingWhitespaces()
  autocmd BufWritePost init.vim source %
augroup END

augroup win_resize " Resize splits when the window is resized
  au!
  autocmd VimResized * :wincmd =
augroup END

" Close window if last remaining window is NerdTree
autocmd bufenter *
      \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |
      \   q |
      \ endif

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \     execute 'normal! g`"zvzz' |
  \ endif
augroup END

" ===============================
" Utils
" ===============================

function! StripTrailingWhitespaces() abort
  let l:lastSearch = @/
  let l:line = line('.')
  let l:col = col('.')

  execute '%s/\s\+$//e'

  let @/ = l:lastSearch
  call cursor(l:line, l:col)
endfunction

" Run NERDTreeFind or Toggle based on current buffer
function! NerdWrapper() abort
  if &filetype ==# '' " Empty buffer
    :NERDTreeToggle
  elseif expand('%:t') =~? 'NERD_tree' " In NERD_tree buffer
    wincmd w
  else " Normal file buffer
    :NERDTreeFind
  endif
endfunction
