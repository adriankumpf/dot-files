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

Plug 'DataWraith/auto_mkdir'                                                   " Create directory if it does not exist
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }                  " Autocomplete
Plug 'SirVer/ultisnips'                                                        " Snippet support (C-j)
Plug 'airblade/vim-gitgutter'                                                  " Git changes showed on line numbers
Plug 'autozimu/LanguageClient-neovim', {'tag': 'binary-*-x86_64-apple-darwin'} " Language Server Protocol (LSP) support
Plug 'docunext/closetag.vim'                                                   " Functions and mappings to close open HTML/XML tags
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }                              " Easy alignment
Plug 'gregsexton/gitv', { 'on': 'Gitv' }                                       " Git log viewer (Gitv! for file mode)
Plug 'honza/vim-snippets'                                                      " Snippets for everything!
Plug 'int3/vim-extradite'                                                      " A git commit browser for vim
Plug 'ironhouzi/vim-stim'                                                      " Improve star by not jumping immediately
Plug 'itspriddle/vim-marked'                                                   " Open Markdown files in Marked
Plug 'jeetsukumaran/vim-buffergator'                                           " open a window listing all buffers
Plug 'jiangmiao/auto-pairs'                                                    " Automatically closing pair stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }              " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'kewah/vim-stylefmt'                                                      " Format stylsheets
Plug 'kshenoy/vim-signature'                                                   " Toggle, display and navigate marks
Plug 'machakann/vim-highlightedyank'                                           " Make the yanked region apparant
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                                " Intelligent buffer closing
Plug 'morhetz/gruvbox'                                                         " THE Colorscheme
Plug 'posva/vim-vue', {'for': 'vue'}                                           " Syntax Highlight for Vue.js components
Plug 'qpkorr/vim-bufkill'                                                      " Delete a buffer without closing the split
Plug 'racer-rust/vim-racer'                                                    " Rust code completion and navigation
Plug 'rust-lang/rust.vim'                                                      " Official Rust vim plugin
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }       " Nerdtree file browser
Plug 'sebastianmarkow/deoplete-rust'                                           " Deoplete support for Rust
Plug 'sheerun/vim-polyglot'                                                    " All languages as one plugin
Plug 'sickill/vim-pasta'                                                       " context-aware pasting
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }                                  " Undo Tree
Plug 'slashmili/alchemist.vim'                                                 " Elixir Integration Into Vim
Plug 'terryma/vim-expand-region'                                               " Easily expand selected regions with 'v'
Plug 'tpope/vim-commentary'                                                    " Commenting support (gc)
Plug 'tpope/vim-fugitive'                                                      " An awesome Git wrapper
Plug 'tpope/vim-repeat'                                                        " Repeat 'vim-surround' commands with '.'
Plug 'tpope/vim-rhubarb'                                                       " Open Github URLs
Plug 'tpope/vim-sleuth'                                                        " Heuristically set indent settings
Plug 'tpope/vim-surround'                                                      " Surround with cs
Plug 'w0rp/ale'                                                                " Ale Linting & Fixing / Formatting

call plug#end()

" ===============================
" General Settings
" ===============================

" Don't show linenumbers (toggle via F4)
set nonumber
set norelativenumber

" Buffer settings
set hidden

" Whitespace settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Enale the use of the mouse
set mouse=nicr

" Split settings
set splitbelow
set splitright

" Search settings
set ignorecase
set smartcase
" set nohlsearch

" Show trailing spaces and highlight hard tabs
set list listchars=tab:▸\ ,trail:·
set showbreak=↪

" Don't fold by default
set nofoldenable

" Statusline
set statusline=%=%m\ %q\ %r\ %f\ %{AleLinterStatus()}\ %l:%c
set fillchars=vert:│,stl:\ ,stlnc:\ ,

" Disable Backup and Swap files
set noswapfile
set nobackup
set nowritebackup

" Allow to use system clipboard
set clipboard+=unnamed

" No extra space when joining a line which ends with . ? !
set nojoinspaces
"
" Scroll when closing to top or bottom of the screen
set scrolloff=7

" allow unrestricted backspacing in insert mode
set backspace=indent,start,eol

" Limit completion window height
set pumheight=5

" Interactive substitutioon
set inccommand=nosplit

" Don't use fish shell
set shell=bash

" smart autoindenting when starting a new line.
set smartindent

" Enable undo file as non-root
if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile
  else
    set undodir=~/.config/nvim/tmp/undo/
    set undofile
  endif
endif

" Filetype settings
filetype plugin on
filetype indent on

" ===============================
" Mapping settings
" ===============================

" Setting leader
let g:mapleader="\<space>"

" Disabling arrow keys, space key, exmode enter with Q key, help with F1, etc.
nnoremap <up> <NOP>
nnoremap <down> <NOP>
nnoremap <left> <NOP>
nnoremap <right> <NOP>
nnoremap <bs> <NOP>
nnoremap <delete> <NOP>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>
nnoremap <Space> <NOP>
inoremap <F1> <NOP>
nnoremap <F1> <NOP>
nnoremap Q <NOP>

" remap esc
inoremap jj <esc>

" Smart window switching with awareness of Tmux panes. Now, I can use Ctrl+hjkl
" in both Vim and Tmux (without using the prefix). Based on
" http://www.codeography.com/2013/06/19/navigating-vim-and-tmux-splits.
" Thanks to https://github.com/s3rvac/dotfiles/tree/master/vim
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

" Make j and k move by virtual lines instead of physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 25 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 25 ? "m'" . v:count : '') . 'j'

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
nnoremap ,w :w<CR>
nnoremap <silent> ,q :Sayonara<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" [S]plit line (sister to [J]oin lines) S is covered by cc.
nnoremap S mzi<CR><ESC>`z

" Start substitute on current word under the cursor
nnoremap ,s :%s///gc<Left><Left><Left>

" Search for the word under the cursor in the current directory
nnoremap ,S :Rg 

" Toggle search highlight
nnoremap <silent> <CR> :set nohlsearch!<CR> :set nohlsearch?<CR>

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" Reformat whole or selection from file
command! Format :call utils#formatFile()
nnoremap <silent> ,f :Format<CR>

" Search in very magic mode
nnoremap / /\v
vnoremap / /\v

" Bufkill.vim: Alt-W to delete a buffer and remove it from the list but keep the window
nmap ∑ :BD<CR>

" Quickly fix spelling errors choosing the first result
nmap <Leader>z z=1<CR><CR>

" ===============================
" Plugins settings
" ===============================

" NERDTree
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=35
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeShowLineNumbers=0

" Ultisnips settings
let g:UltiSnipsUsePythonVersion=3

" Gitgutter settings
let g:gitgutter_map_keys=0
let g:gitgutter_max_signs=9999
let g:gitgutter_sign_added='+'
let g:gitgutter_sign_modified='~'
let g:gitgutter_sign_removed='-'
let g:gitgutter_sign_modified_removed='~'
let g:gitgutter_sign_removed_first_line='-'

" Deoplete
let g:deoplete#enable_at_startup = 1

" Open Markoff instead of Marked 2
let g:marked_app = 'Markoff'

" ALE
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1

let g:ale_fix_on_save = 1

let g:ale_sign_error = '❯'
let g:ale_sign_warning = '⚠'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'

let g:ale_pattern_options = {
\   '.*lib/core/.*\.js$': {'ale_enabled': 0},
\   '.*test/core/.*\.js$': {'ale_enabled': 0},
\}

let g:ale_fixers = {
\   'elixir': ['mix_format'],
\   'html': ['prettier'],
\   'javascript': ['prettier-standard'],
\   'markdown': ['prettier'],
\   'stylus': ['stylelint'],
\   'vue': ['prettier'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vue': [],
\}

let g:ale_javascript_prettier_options = '--single-quote --use-tabs'

function! AleLinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '⨉ %d ⚠ %d',
    \   all_non_errors,
    \   all_errors
    \)
  endfunction

" Alchemist.vim
let g:alchemist_iex_term_size = 120
let g:alchemist_iex_term_split = 'vsplit'

" FZF and extensions
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

"Add :Rg (ripgrep) command - '?' toggles preview:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden -g !.git/ -g !*.lock --no-heading -i --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Toggle preview with '?' when searching w/ :Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \ <q-args>,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \ <bang>0)

" rust.vim
let g:rustfmt_autosave = 1

" LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" Racer: show the complete function definition
let g:racer_cmd = "$HOME/.cargo/bin/racer"
let g:racer_experimental_completer = 1

" deopelete-rust: Automatic racer binary and rust source path detection
if executable('racer')
  let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
endif

if executable('rustc')
  "$ rustup component add rust-src
    let rustc_root = systemlist('rustc --print sysroot')[0]
    let rustc_src_dir = rustc_root . '/lib/rustlib/src/rust/src'
    if isdirectory(rustc_src_dir)
        let g:deoplete#sources#rust#rust_source_path = rustc_src_dir
    endif
  endif

" ===============================
" Plugin mappings
" ===============================

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>c :Commands<CR>

" ALE
nmap <silent> <C-x><C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-x><C-j> <Plug>(ale_next_wrap)

" Ultisnips
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" Expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Deoplete autocomplete
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" Vim-Plug
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

" NERDTree
nnoremap <silent> <leader>n :call utils#nerdWrapper()<CR>

" UndoTree
noremap <silent> <Leader>u :GundoToggle<CR>

" Marked
nnoremap <silent> <leader>m :MarkedOpen!<CR>

" Save file as root
cmap w!! w !sudo tee > /dev/null %

" LanguageClient
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" ===============================
" Color and highlighting settings
" ===============================

syntax on

" Turn off syntax for long lines to improve performance
set synmaxcol=320
2mat ErrorMsg '\%100v.'

set background=dark
colorscheme gruvbox

" True color support
set termguicolors

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Customizations

" Gruvbox: 245 -> #928374 | 237 -> #3c3836

hi LineNr ctermfg=237
hi vertsplit ctermbg=235 ctermfg=245 guibg=bg guifg=#3c3836

hi NonText ctermbg=235 ctermfg=245 guibg=bg guifg=#3c3836

hi StatusLine guibg=#928374 guifg=bg
hi StatusLineNC guibg=#928374 guifg=bg

hi clear SignColumn

hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" Make Cursor more visible
set termguicolors
set guicursor=i-ci:ver25-Cursor/lCursor
hi Cursor ctermfg=1 ctermbg=1 guifg=#FFFFFF guibg=#FFFFFF

" ===============================
" Autocommands
" ===============================

" Keywordprg settings
autocmd FileType vim setlocal keywordprg=:help

" Turn spellcheck on for markdown files & git commits
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" Set correct Filetype for Dockerfiles
autocmd BufNewFile,BufRead Dockerfile* setfiletype dockerfile

" Remove trailing whitespaces automatically before save
autocmd BufWritePre * call utils#stripTrailingWhitespaces()

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

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

" Ensure syntax highlighting doesn't break on Vue files
autocmd FileType vue syntax sync fromstart
