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

Plug 'w0rp/ale'                                                          " Ale Linting
Plug 'editorconfig/editorconfig-vim'                                     " Editorconfig support
Plug 'Shougo/deoplete.nvim'                                              " Autocomplete
Plug 'jiangmiao/auto-pairs'                                              " Automatically closing pair stuff
Plug 'SirVer/ultisnips'                                                  " Snippet support (C-j)
Plug 'honza/vim-snippets'                                                " Snippets for everything!
Plug 'tpope/vim-commentary'                                              " Commenting support (gc)
Plug 'tpope/vim-sleuth'                                                  " Heuristically set indent settings
Plug 'sickill/vim-pasta'                                                 " context-aware pasting
Plug 'sheerun/vim-polyglot'                                              " All languages in one
Plug 'kewah/vim-stylefmt'                                                " Format stylsheets
Plug 'slashmili/alchemist.vim'                                           " Elixir
Plug 'powerman/vim-plugin-AnsiEsc'                                       " Support ansi escape codes  in elxiir docs
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }        " Fuzzy finder
Plug 'junegunn/fzf.vim'                                                  " Wrapper function
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " Nerdtree file browser
Plug 'tpope/vim-fugitive'                                                " Fugitive
Plug 'gregsexton/gitv', { 'on': 'Gitv' }                                 " Git log viewer (Gitv! for file mode)
Plug 'airblade/vim-gitgutter'                                            " Git changes showed on line numbers
Plug 'int3/vim-extradite'                                                " Git commit browser
Plug 'justinmk/vim-sneak'                                                " Jump to any location specified by two characters
Plug 'tpope/vim-surround'                                                " Surround with cs
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }                        " Easy alignment
Plug 'PeterRincker/vim-argumentative'                                    " Argument text object (via, >a)
Plug 'kana/vim-textobj-indent'                                           " Indent text object (vii)
Plug 'glts/vim-textobj-comment'                                          " Comment text object (vac)
Plug 'kana/vim-textobj-user'                                             " Custom text objects creation (dependency for others)
Plug 'terryma/vim-expand-region'                                         " Easily expand selected region
Plug 'ironhouzi/vim-stim'                                                " Improve star by not jumping immediately
Plug 'chip/vim-fat-finger'                                               " Iabbrev auto-correction library
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }                            " Undo Tree
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }                          " Intelligent buffer closing
Plug 'itspriddle/vim-marked'                                             " Open Markdown files in Marked
Plug 'DataWraith/auto_mkdir'                                             " create directory if it does not exist
Plug 'morhetz/gruvbox'                                                   " THE Colorscheme
Plug 'jeetsukumaran/vim-buffergator'

call plug#end()

" ===============================
" General Settings
" ===============================

set nonumber
set norelativenumber
set noshowmode
set noshowcmd                                                     " Don't show last cmd
set laststatus=2
set textwidth=120                                                 " Text width is 80 characters
set cmdheight=1
set pumheight=10                                                  " Completion window max size
set hidden                                                        " Enables to switch between unsaved buffers and keep undo history
set clipboard+=unnamed                                            " Allow to use system clipboard
set showmatch                                                     " Show matching brackets when text indicator is over them
set matchtime=2                                                   " How many tenths of a second to blink when matching brackets
set nostartofline                                                 " Prevent cursor from moving to beginning of line when switching buffers
set virtualedit=block                                             " To be able to select past EOL in visual block mode
set nojoinspaces                                                  " No extra space when joining a line which ends with . ? !
set scrolloff=7                                                   " Scroll when closing to top or bottom of the screen
set updatetime=1000                                               " Update time used to create swap file or other things
set tabstop=2
set mouse=nicr                                                    " Enale the use of the mouse
set splitbelow                                                    " Split settings (more natural)
set splitright
set notimeout                                                     " Time out on key codes but not mappings.
set ttimeout
set ttimeoutlen=10
set nospell                                                       " Disable checking by default (use <F4> to toggle)
set ignorecase                                                    " Search settings
set smartcase
set wrapscan
set nohlsearch
set list                                                          " White characters settings
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪
set nofoldenable                                                  " don't fold by default

set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set statusline=%=%m\ %q\ %r\ %{ALEGetStatusLine()}\ %t\ %l:%c
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,

set backspace=indent,start,eol                                    " allow unrestricted backspacing in insert mode

if has('linebreak')
  set breakindent                                                 " indent wrapped lines to match start
  if exists('&breakindentopt')
    set breakindentopt=shift:2                                    " emphasize broken lines by indenting them
  endif
endif

if exists('$SUDO_USER')
  set nobackup                                                    " don't create root-owned files
  set nowritebackup                                               " don't create root-owned files
else
  set backupdir=~/.config/nvim/tmp/backup                         " keep backup files out of the way
  set backupdir+=.
endif

if exists('$SUDO_USER')
  set noswapfile                                                  " don't create root-owned files
else
  set directory=~/.config/nvim/tmp/swap//                         " keep swap files out of the way
  set directory+=.
endif

set shortmess+=A                                                  " ignore annoying swapfile messages
set shortmess+=I                                                  " no splash screen
set shortmess+=O                                                  " file-read message overwrites previous
set shortmess+=T                                                  " truncate non-file messages in middle
set shortmess+=W                                                  " don't echo [w] [written]
set shortmess+=a                                                  " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                                                  " overwrite file-written messages
set shortmess+=t                                                  " truncate file messages at start

if has('persistent_undo')
  if exists('$SUDO_USER')
    set noundofile                                    " don't create root-owned files
  else
    set undodir=~/.config/nvim/tmp/undo/              " keep undo files out of the way
    set undofile                                      " actually use undo files
  endif
endif
" Filetype settings
filetype plugin on
filetype indent on

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1                               " Set an environment variable to use the t_SI/t_EI hack
let $NVIM_TUI_ENABLE_TRUE_COLOR=1                                 " Turn on true colors support (does not work inside tmux yet)

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
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

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
nnoremap <silent> ,c :Sayonara!<CR>
nnoremap <silent> ,q :Sayonara<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Reselect last-pasted text
nnoremap gp `[v`]

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
nnoremap <silent> <F6> :set nohlsearch!<CR> :set nohlsearch?<CR>
" Toggle white characters visibility
nnoremap <silent> <F7> :set list!<CR> :set list?<CR>

" Intelligent windows resizing using ctrl + arrow keys
nnoremap <silent> <C-Right> :call utils#intelligentVerticalResize('right')<CR>
nnoremap <silent> <C-Left> :call utils#intelligentVerticalResize('left')<CR>
nnoremap <silent> <C-Up> :resize +1<CR>
nnoremap <silent> <C-Down> :resize -1<CR>

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" Reformat whole or selection from file
command! Format :call utils#formatFile()
nnoremap <silent> ,f :Format<CR>

" Toogle wrap lines
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Unwrap set nowrap nolinebreak list

" Close the opened HTML tag with Ctrl+_ (I do not use vim-closetag because it
" often fails with an error).
inoremap <silent> <C--> </<C-x><C-o><C-x>

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

" Vim JSX highlighting settings
let g:jsx_ext_required=0

" Deoplete autocomplete settings
let g:deoplete#enable_at_startup=1
let g:deoplete#file#enable_buffer_path=1
let g:deoplete#enable_smart_case = 1

let g:deoplete#sources={}
let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
let g:deoplete#sources.elixir = [
      \   'buffer', 'member', 'file', 'omni', 'ultisnips', 'alchemist'
      \ ]
let g:deoplete#sources.ruby = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.vim  = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources['javascript.jsx'] = [
      \   'buffer', 'file', 'omni', 'ultisnips'
      \ ]
let g:deoplete#sources.css  = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.html = ['buffer', 'member', 'file', 'omni', 'ultisnips']

" Plug settings
let g:plug_timeout=20

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

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_core_mode = 'external_command'

" Vim-Fat_finger overwrite
iabbrev ok ok

" Smart Toggle between numbers
let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree', 'vimshell']

" Alchemist.vim
let g:alchemist_iex_term_size = 120
let g:alchemist_iex_term_split = 'vsplit'

" FZF and extensions
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" ===============================
" Plugin mappings
" ===============================

nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>f :GitFiles<CR>
nnoremap <silent> <leader>B :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>L :Lines<CR>
nnoremap <silent> <leader>t :BTags<CR>
nnoremap <silent> <leader>s :Snippets<CR>

nnoremap <silent> <leader>T :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>hc :Commands<CR>
nnoremap <silent> <leader>hm :Maps<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)
nmap <silent> <C-x><C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-x><C-j> <Plug>(ale_next_wrap)

" Ultisnips
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsListSnippets='<C-l>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" Alchemist.vim
nnoremap <leader>i :IEx<CR>

" Gitgutter
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap ,hs :GitGutterStageHunk<CR>
nnoremap ,hr :GitGutterRevertHunk<CR>

" Expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Argumentative (use a instead of ,)
xmap ia <Plug>Argumentative_InnerTextObject
omap ia <Plug>Argumentative_OpPendingInnerTextObject
xmap aa <Plug>Argumentative_OuterTextObject
omap aa <Plug>Argumentative_OpPendingOuterTextObject
nmap <a <Plug>Argumentative_MoveLeft
nmap >a <Plug>Argumentative_MoveRight

" Deoplete autocomplete
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

" Vim-Plug
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gd :Gvdiff<CR>

" Gitv
nnoremap <leader>gh :Gitv!<CR>

" Extradite
nnoremap <leader>gl :Extradite!<CR>

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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Highlight term cursor differently
highlight TermCursor ctermfg=green guifg=green

" Listchars highlighting
highlight NonText ctermfg=235 guifg=gray
highlight SpecialKey ctermfg=235 guifg=gray

" Customizations
hi! Folded term=NONE cterm=NONE gui=NONE ctermbg=NONE
hi vertsplit ctermfg=238 ctermbg=235
hi LineNr ctermfg=237
hi StatusLine ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi Search ctermbg=58 ctermfg=15
hi Default ctermfg=1
hi clear SignColumn
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=237 ctermbg=235

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
