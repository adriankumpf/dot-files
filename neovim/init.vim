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

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Nerdtree file browser
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }

Plug 'w0rp/ale'                                   " Ale Linting
Plug 'Shougo/deoplete.nvim'                       " Autocomplete
Plug 'jiangmiao/auto-pairs'                       " Automatically closing pair stuff
Plug 'SirVer/ultisnips'                           " Snippet support (C-j)
Plug 'honza/vim-snippets'                         " Snippets for everything!
Plug 'tpope/vim-commentary'                       " Commenting support (gc)
Plug 'tpope/vim-sleuth'                           " Heuristically set indent settings
Plug 'sickill/vim-pasta'                          " context-aware pasting
Plug 'sheerun/vim-polyglot'                       " All languages in one
Plug 'kewah/vim-stylefmt'                         " Format stylsheets
Plug 'slashmili/alchemist.vim'                    " Elixir
Plug 'tpope/vim-fugitive'                         " Fugitive
Plug 'gregsexton/gitv', { 'on': 'Gitv' }          " Git log viewer (Gitv! for file mode)
Plug 'airblade/vim-gitgutter'                     " Git changes showed on line numbers
Plug 'tpope/vim-surround'                         " Surround with cs
Plug 'godlygeek/tabular', { 'on':  'Tabularize' } " Easy alignment
Plug 'terryma/vim-expand-region'                  " Easily expand selected region
Plug 'ironhouzi/vim-stim'                         " Improve star by not jumping immediately
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }     " Undo Tree
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }   " Intelligent buffer closing
Plug 'itspriddle/vim-marked'                      " Open Markdown files in Marked
Plug 'DataWraith/auto_mkdir'                      " create directory if it does not exist
Plug 'morhetz/gruvbox'                            " THE Colorscheme
Plug 'jeetsukumaran/vim-buffergator'              " open a window listing all buffers
Plug 'digitaltoad/vim-pug'                        " Pug/Jade Syntax highlighting
Plug 'sbdchd/neoformat'                           " Format / prettify code

call plug#end()

" ===============================
" General Settings
" ===============================

" Don't show linenumbers (toggle via F4)
set nonumber
set norelativenumber

" Buffer settings
set hidden
set nostartofline

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

" Disable checking by default (use <F4> to toggle)
set nospell

" Search settings
set ignorecase
set smartcase
set wrapscan
set nohlsearch

" Show trailing spaces and highlight hard tabs
set list listchars=tab:▸\ ,trail:·
set showbreak=↪

" Don't fold by default
set nofoldenable

" Statusline
set statusline=%=%m\ %q\ %r\ %{ALEGetStatusLine()}\ %t\ %l:%c
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,

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

" Same when moving up and down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-f> <C-f>zz
vnoremap <C-b> <C-b>zz

noremap <C-z> <C-y>

" More logical Y (default was alias for yy)
nnoremap Y y$

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

" Terminal mode mappings
if has('nvim')
  tnoremap <ESC> <C-\><C-n>
  tnoremap ,<ESC> <ESC>
endif

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

" Paste mode toggling
nnoremap <silent> <F3> :set paste!<CR> :set paste?<CR>
" Toggle spelling on and off
nnoremap <silent> <F4> :set spell!<CR> :set spell?<CR>
" Toggle line numbers
nnoremap <silent> <F5> :call utils#numberToggle()<cr>
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
let g:ale_sign_error = '❯'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']

" Neoformat
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --single-quote\
let g:neoformat_try_formatprg = 1

" Alchemist.vim
let g:alchemist_iex_term_size = 120
let g:alchemist_iex_term_split = 'vsplit'

" FZF and extensions
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" vim-polyglot's pug syntax hightlighting is buggy
let g:polyglot_disabled = ['pug']

" ===============================
" Plugin mappings
" ===============================

nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>f :GitFiles<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>c :Commands<CR>

" ALE
nmap <silent> <C-x><C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-x><C-j> <Plug>(ale_next_wrap)

" Ultisnips
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" Alchemist.vim
nnoremap <leader>i :IEx<CR>

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
"
" JS standard --fix
nnoremap <leader>ef :silent !eval standard % --fix<cr>

" ===============================
" Color and highlighting settings
" ===============================

syntax on

set background=dark
colorscheme gruvbox

" True color support (nvim)
" set termguicolors

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Customizations
hi vertsplit ctermfg=238 ctermbg=235

hi LineNr ctermfg=237

hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237

hi clear SignColumn

hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" ===============================
" Autocommands
" ===============================

" Git commits
augroup gitcommit
  au!
  au FileType gitcommit setl spell         " Enable spellchecking.
  au FileType gitcommit setl expandtab     " Use spaces instead of tabs.
  au FileType gitcommit setl tabstop=4     " A tab counts for 4 spaces.
  au FileType gitcommit setl softtabstop=4 " Causes backspace to delete 4 spaces.
  au FileType gitcommit setl shiftwidth=4  " Shift by 4 spaces.
augroup end

" Keywordprg settings
autocmd FileType vim setlocal keywordprg=:help

" Turn spellcheck on for markdown files
autocmd BufNewFile,BufRead *.md setlocal spell

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
