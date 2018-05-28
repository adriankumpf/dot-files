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

Plug 'DataWraith/auto_mkdir'                                                             " Create directory if it does not exist
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                            " Autocomplete
Plug 'airblade/vim-gitgutter'                                                            " Git changes showed on line numbers
Plug 'docunext/closetag.vim'                                                             " Functions and mappings to close open HTML/XML tags
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }                                        " Easy alignment
Plug 'ironhouzi/vim-stim'                                                                " Improve star by not jumping immediately
Plug 'itspriddle/vim-marked', { 'for': 'markdown' }                                      " Open Markdown files in Marked
Plug 'jeetsukumaran/vim-buffergator'                                                     " open a window listing all buffers
Plug 'jiangmiao/auto-pairs'                                                              " Automatically closing pair stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }                        " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature'                                                             " Toggle, display and navigate marks
Plug 'machakann/vim-highlightedyank'                                                     " Make the yanked region apparant
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                                          " Intelligent buffer closing
Plug 'morhetz/gruvbox'                                                                   " THE Colorscheme
Plug 'racer-rust/vim-racer', { 'for': 'rust' }                                           " Rust code completion and navigation
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }                 " Nerdtree file browser
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }                                  " Deoplete support for Rust
Plug 'sheerun/vim-polyglot'                                                              " All languages as one plugin
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }                                            " Undo Tree
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }                                      " Elixir Integration Into Vim
Plug 'tpope/vim-commentary'                                                              " Commenting support (gc)
Plug 'tpope/vim-fugitive'                                                                " An awesome Git wrapper
Plug 'tpope/vim-repeat'                                                                  " Repeat 'vim-surround' commands with '.'
Plug 'tpope/vim-rhubarb'                                                                 " GitHub Extension for fugitive
Plug 'tpope/vim-sleuth'                                                                  " Heuristically set indent settings
Plug 'tpope/vim-surround'                                                                " Surround with cs
Plug 'w0rp/ale'                                                                          " Ale Linting & Fixing / Formatting
Plug 'rakr/vim-one'
Plug 'zchee/deoplete-clang'

call plug#end()

" ===============================
" General Settings
" ===============================

set backspace=indent,start,eol
set clipboard+=unnamed
set expandtab tabstop=2 softtabstop=2 shiftwidth=2
set fillchars=vert:│,stl:\ ,stlnc:\ ,
set hidden
set list listchars=tab:▸\ ,trail:· showbreak=↪
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

set statusline=%=%m\ %q\ %r\ %f\ %{AleLinterStatus()}\ %l:%c

set complete+=kspell   " Autocomplete with dictionary words when spell check is on
set inccommand=nosplit " Interactive substitution
set synmaxcol=320      " Turn off syntax for long lines to improve performance

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

"Add :Rg (ripgrep) command - '?' toggles preview:
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden -g !.git/ -g !*.lock --no-heading -i --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>/ :Rg<CR>
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

" Smart window switching with awareness of Tmux panes. Thanks to https://github.com/s3rvac/dotfiles/tree/master/vim
if exists('$TMUX')
  function! s:TmuxOrSplitSwitch(wincmd, tmuxdir)
    let l:previous_winnr = winnr()
    silent! execute 'wincmd ' . a:wincmd
    if l:previous_winnr == winnr()
      call system('tmux select-pane -' . a:tmuxdir)
      redraw!
    endif
  endfunction

  let g:previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;" . g:previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call <SID>TmuxOrSplitSwitch('h', 'L')<CR>
  nnoremap <silent> <C-j> :call <SID>TmuxOrSplitSwitch('j', 'D')<CR>
  nnoremap <silent> <C-k> :call <SID>TmuxOrSplitSwitch('k', 'U')<CR>
  nnoremap <silent> <C-l> :call <SID>TmuxOrSplitSwitch('l', 'R')<CR>
else
  noremap <C-h> <C-w>h
  noremap <C-j> <C-w>j
  noremap <C-k> <C-w>k
  noremap <C-l> <C-w>l
endif

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

" ALE
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

let g:ale_fixers = {
      \   'c': ['clang-format'],
      \   'cpp': ['clang-format'],
      \   'elixir': ['mix_format'],
      \   'html': ['prettier'],
      \   'javascript': ['eslint', 'prettier'],
      \   'markdown': ['prettier'],
      \   'vue': ['eslint', 'prettier'],
      \}
      "   'rust': ['rustfmt']

let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'vue': ['eslint'],
      \}

let g:ale_javascript_prettier_options = '--single-quote --no-semi'

" rust.vim
let g:rustfmt_autosave = 1

" deopelete-rust: Automatic racer binary and rust source path detection
if executable('racer')
  let g:racer_cmd = '$HOME/.cargo/bin/racer'
  let g:racer_experimental_completer = 1
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
endif

if executable('rustc')
  "$ rustup component add rust-src
  let g:rustc_root = systemlist('rustc --print sysroot')[0]
  let g:rustc_src_dir = g:rustc_root . '/lib/rustlib/src/rust/src'
  if isdirectory(g:rustc_src_dir)
    let g:deoplete#sources#rust#rust_source_path = g:rustc_src_dir
  endif
endif

" ===============================
" Color and highlighting settings
" ===============================

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

hi clear SignColumn

hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi LineNr ctermfg=237
hi NonText ctermbg=235 ctermfg=245 guibg=bg guifg=#3c3836
hi vertsplit ctermbg=235 ctermfg=245 guibg=bg guifg=#3c3836

if $ITERM_PROFILE ==# 'light'
  colorscheme one
  set background=light
else
  colorscheme gruvbox
  set background=dark
  hi StatusLine guibg=#928374 guifg=bg
  hi StatusLineNC guibg=#928374 guifg=bg
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

function! AleLinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
  \   '⨉ %d ⚠ %d',
  \   l:all_non_errors,
  \   l:all_errors
  \)
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
