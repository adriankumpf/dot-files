" Forked from https://github.com/martin-svk/dot-files

" Autoinstall
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" ======================================================================================================================
" Plugins
" ======================================================================================================================

call plug#begin('~/.config/nvim/plugged')

" Asynchronous maker and linter (needs linters to work)
Plug 'benekastah/neomake', { 'on': ['Neomake'] }
" Autocomplete
Plug 'Shougo/deoplete.nvim'
" Automatically closing pair stuff
Plug 'cohama/lexima.vim'
" Snippet support (C-j)
Plug 'SirVer/ultisnips'
" Snippets for everything!
Plug 'honza/vim-snippets'
" Commenting support (gc)
Plug 'tpope/vim-commentary'
" Heuristically set indent settings
Plug 'tpope/vim-sleuth'
" context-aware pasting
Plug 'sickill/vim-pasta'

" All languages in one
Plug 'sheerun/vim-polyglot'
" JS libs syntax (React, Angular)
Plug 'othree/javascript-libraries-syntax.vim'
" Format stylsheets
Plug 'kewah/vim-stylefmt'
" Color highlighter
Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'stylus', 'scss', 'less', 'html', 'xhtml', 'javascript', 'javascript.jsx'] }
" Elixir
Plug 'slashmili/alchemist.vim'
" Markdown/Latex
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Wrapper function
Plug 'junegunn/fzf.vim'

" Nerdtree file browser
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
" File Icons
Plug 'ryanoasis/vim-devicons'
" Lightline (simple status line)
Plug 'itchyny/lightline.vim'
" Buffers tabline
Plug 'ap/vim-buftabline'
" Fugitive
Plug 'tpope/vim-fugitive'
" Git log viewer (Gitv! for file mode)
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
" Git changes showed on line numbers
Plug 'airblade/vim-gitgutter'
" Git commit browser
Plug 'int3/vim-extradite'

" Jump to any location specified by two characters
Plug 'justinmk/vim-sneak'
" Surround (cs"')
Plug 'tpope/vim-surround'
" Easy alignment
Plug 'godlygeek/tabular', { 'on':  'Tabularize' }
" Argument text object (via, >a)
Plug 'PeterRincker/vim-argumentative'
" Indent text object (vii)
Plug 'kana/vim-textobj-indent'
" Comment text object (vac)
Plug 'glts/vim-textobj-comment'
" Custom text objects creation (dependency for others)
Plug 'kana/vim-textobj-user'

" Easily expand selected region
Plug 'terryma/vim-expand-region'
" Improve star by not jumping immediately
Plug 'ironhouzi/vim-stim'
" Iabbrev auto-correction library
Plug 'chip/vim-fat-finger'
" Intelligently toogle relatv line numbers
Plug 'myusuf3/numbers.vim'
" Undo Tree
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" Intelligent buffer closing
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
" Open Markdown files in Marked
Plug 'itspriddle/vim-marked'
" create directory if it does not exist
Plug 'DataWraith/auto_mkdir'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'

call plug#end()

" ======================================================================================================================
" General Settings
" ======================================================================================================================

" Basic settings (Neovim defaults: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults)
"
set shell=/bin/bash                         " Setting shell to zsh
set number                                  " Line numbers on
set showmode                                " Always show mode
set showcmd                                 " Show commands as you type them
set textwidth=120                           " Text width is 120 characters
set cmdheight=1                             " Command line height
set pumheight=10                            " Completion window max size
set noswapfile                              " New buffers will be loaded without creating a swapfile
set hidden                                  " Enables to switch between unsaved buffers and keep undo history
set clipboard+=unnamed                      " Allow to use system clipboard
set showmatch                               " Show matching brackets when text indicator is over them
set matchtime=2                             " How many tenths of a second to blink when matching brackets
set nostartofline                           " Prevent cursor from moving to beginning of line when switching buffers
set virtualedit=block                       " To be able to select past EOL in visual block mode
set nojoinspaces                            " No extra space when joining a line which ends with . ? !
set scrolloff=7                             " Scroll when closing to top or bottom of the screen
set updatetime=1000                         " Update time used to create swap file or other things

" Split settings (more natural)
set splitbelow                              " Splitting a window will put the new window below the current
set splitright                              " Splitting a window will put the new window right of the current

" Timeout settings
" Time out on key codes but not mappings. Basically this makes terminal Vim work sanely. (by Steve Losh)
set notimeout
set ttimeout
set ttimeoutlen=10

" Spelling settings
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
set spelllang=en_us                         " Set language to US English
set nospell                                 " Disable checking by default (use <F4> to toggle)

" Search settings
set ignorecase                              " Ignore case by default
set smartcase                               " Make search case sensitive only if it contains uppercase letters
set wrapscan                                " Search again from top when reached the bottom
set nohlsearch                              " Don't highlight after search

" Persistent undo settings
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo/
endif

" White characters settings
set list                                    " Show listchars by default
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·,nbsp:·
set showbreak=↪

" Filetype settings
filetype plugin on
filetype indent on

" Folding settings
set foldmethod=marker                       " Markers are used to specify folds.
set foldlevel=1                             " Start folding automatically from level 2
set fillchars="fold: "                      " Characters to fill the statuslines and vertical separators
set nofoldenable                            " don't fold by default

" Omni completion settings
set completeopt-=preview                    " Don't show preview scratch buffers
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" Neovim specific settings
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1       	" Set an environment variable to use the t_SI/t_EI hack
let $NVIM_TUI_ENABLE_TRUE_COLOR=1       	" Turn on true colors support (does not work inside tmux yet)

" ======================================================================================================================
" Mapping settings
" ======================================================================================================================

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

" Vim defaults overriding

" remap esc
inoremap jj <esc>

" Easier window switching
nmap <silent> <C-w><C-w> :call utils#intelligentCycling()<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Visual linewise up and down by default (and use gj gk to go quicker)
nnoremap j gj
nnoremap k gk
nnoremap gj 5j
nnoremap gk 5k
vnoremap j gj
vnoremap k gk
vnoremap gj 5j
vnoremap gk 5k

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-z> 3<C-y>

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

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" More logical Y (default was alias for yy)
nnoremap Y y$

" Quick replay 'q' macro
nnoremap Q @q

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Fix the cw at the end of line bug default vim has special treatment (:help cw)
nmap cw ce
nmap dw de

" Uppercase word in insert mode
inoremap <C-u> <ESC>mzgUiw`za

" Matching brackets with TAB (using matchit) (Breaks the <C-i> jump)
map <TAB> %
silent! unmap [%
silent! unmap ]%

" Don't cancel visual select when shifting
xnoremap <  <gv
xnoremap >  >gv

" Terminal mode mappings
if has('nvim')
tnoremap <ESC> <C-\><C-n>
tnoremap ,<ESC> <ESC>
endif

" Stay down after creating fold
vnoremap zf mzzf`zzz

" Quick save and close buffer
nnoremap ,w :w<CR>
nnoremap <silent> ,c :Sayonara!<CR>
nnoremap <silent> ,q :Sayonara<CR>

" Yank and paste from clipboard
nnoremap ,y "+y
vnoremap ,y "+y
nnoremap ,yy "+yy
nnoremap ,p "+p

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Reselect last-pasted text
nnoremap gp `[v`]

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" [S]plit line (sister to [J]oin lines) S is covered by cc.
nnoremap S mzi<CR><ESC>`z

" Easier fold toggling
nnoremap ,z za

" Start substitute on current word under the cursor
nnoremap ,s :%s///gc<Left><Left><Left>

" Start search on current word under the cursor
nnoremap ,/ /<CR>

" Start reverse search on current word under the cursor
nnoremap ,? ?<CR>

" F-key actions

" Paste mode toggling
nnoremap <silent> <F3> :set paste!<CR> :set paste?<CR>
" Toggle spelling on and off
nnoremap <silent> <F4> :set spell!<CR> :set spell?<CR>
" Source (reload configuration)
nnoremap <silent> <F5> :source $MYNVIMRC<CR>
" Toggle search highlight
nnoremap <silent> <F6> :set nohlsearch!<CR> :set nohlsearch?<CR>
" Toggle white characters visibility
nnoremap <silent> <F7> :set list!<CR> :set list?<CR>
" New horizontal term buffer
nnoremap <silent> <F8> :T ls<CR>

" Window / Buffer management

" Intelligent windows resizing using ctrl + arrow keys
nnoremap <silent> <C-Right> :call utils#intelligentVerticalResize('right')<CR>
nnoremap <silent> <C-Left> :call utils#intelligentVerticalResize('left')<CR>
nnoremap <silent> <C-Up> :resize +1<CR>
nnoremap <silent> <C-Down> :resize -1<CR>

" Buffers navigation and management
nnoremap <silent> + :bn<CR>
nnoremap <silent> _ :bp<CR>

" Custom commands and functions

" Run current file
command! Run :call utils#runCurrentFile()
nnoremap <silent> ,r :Run<CR>

" Reformat whole or selection from file
command! Format :call utils#formatFile()
nnoremap <silent> ,f :Format<CR>

" Toogle wrap lines
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* Unwrap set nowrap nolinebreak list

" ======================================================================================================================
" Plugins settings
" ======================================================================================================================

" NERDTree
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=0
let g:NERDTreeWinSize=30
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1

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

" Lightline settings
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'tab': {
    \   'active': [ 'filename' ],
    \   'inactive': [ 'filename' ]
    \ },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype', 'fileencoding', 'fileformat' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"HELP":&readonly?"RO":""}'
    \ },
    \ 'component_function': {
    \   'mode': 'utils#lightLineMode',
    \   'filename': 'utils#lightLineFilename',
    \   'filetype': 'utils#lightLineFiletype',
    \   'fileformat': 'utils#lightLineFileformat',
    \   'fileencoding': 'utils#lightLineFileencoding'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&readonly)'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

" Neomake settings
let g:neomake_verbose=0
let g:neomake_warning_sign = {
    \ 'text': '❯',
    \ 'texthl': 'WarningMsg',
    \ }
let g:neomake_error_sign = {
    \ 'text': '❯',
    \ 'texthl': 'ErrorMsg',
    \ }

" Quick scope settings
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

" Deoplete autocomplete settings
let g:deoplete#enable_at_startup=1
let g:deoplete#file#enable_buffer_path=1

let g:deoplete#sources={}
let g:deoplete#sources._    = ['buffer', 'file', 'ultisnips']
let g:deoplete#sources.elixir = ['buffer', 'member', 'file', 'omni', 'ultisnips', 'alchemist']
let g:deoplete#sources.ruby = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources.vim  = ['buffer', 'member', 'file', 'ultisnips']
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ultisnips', 'ternjs']
let g:deoplete#sources.css  = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.scss = ['buffer', 'member', 'file', 'omni', 'ultisnips']
let g:deoplete#sources.html = ['buffer', 'member', 'file', 'omni', 'ultisnips']

" Javascript libraries syntax settings
let g:used_javascript_libs = 'chai,flux,react,underscore'

" Plug settings
let g:plug_timeout=20

" Colorizer settings
let g:colorizer_nomap=1

" Numbers.Vim settings
let g:numbers_exclude = ['tagbar', 'startify', 'gundo', 'vimshell', 'w3m']

" WebDevIcons
let g:webdevicons_enable_nerdtree = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 0
let g:webdevicons_conceal_nerdtree_brackets = 1

" Open Markoff instead of Marked 2
let g:marked_app = "Markoff"

" ======================================================================================================================
" Plugin mappings
" ======================================================================================================================
"
" FZF and extensions
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <silent> <leader>o :GitFiles<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
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

" Ultisnips
" Disable built-in cx-ck to be able to go backward
" inoremap <C-x><C-k> <NOP>
 let g:UltiSnipsExpandTrigger='<C-j>'
 let g:UltiSnipsListSnippets='<C-l>'
 let g:UltiSnipsJumpForwardTrigger='<C-j>'
 let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" Pandoc
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level = 4
let g:pandoc#folding#mode = "relative"

" Alchemist.vim

let g:alchemist_iex_term_size = 120
let g:alchemist_iex_term_split = 'vsplit'

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
xmap aa <Plug>Argumentative_OuterTextObject
omap ia <Plug>Argumentative_OpPendingInnerTextObject
omap aa <Plug>Argumentative_OpPendingOuterTextObject
nmap [a <Plug>Argumentative_Prev
nmap ]a <Plug>Argumentative_Next
xmap [a <Plug>Argumentative_XPrev
xmap ]a <Plug>Argumentative_XNext
nmap <a <Plug>Argumentative_MoveLeft
nmap >a <Plug>Argumentative_MoveRight

" Deoplete autocomplete
" Insert <TAB> or select next match
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

" BufOnly
nnoremap ,C :Bonly<CR>

" Gitv
nnoremap <leader>gh :Gitv!<CR>

" Extradite
nnoremap <leader>gl :Extradite!<CR>

" NERDTree
nnoremap <leader>n :call utils#nerdWrapper()<CR>

" cosco.vim
nnoremap <silent> <Leader>, :call cosco#commaOrSemiColon()<CR>
inoremap <silent> <Leader>, <c-o>:call cosco#commaOrSemiColon()<CR>

" UndoTree
noremap <Leader>u :GundoToggle<CR>

" Marked
nnoremap <leader>m :MarkedOpen!<CR>

" ======================================================================================================================
" Color and highlighting settings
" ======================================================================================================================

syntax on

set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='medium'

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Highlight term cursor differently
highlight TermCursor ctermfg=green guifg=green

" Listchars highlighting
highlight NonText ctermfg=235 guifg=gray
highlight SpecialKey ctermfg=235 guifg=gray

" Remove underline in folded lines
hi! Folded term=NONE cterm=NONE gui=NONE ctermbg=NONE

" Link highlight groups to improve buftabline colors
hi! link BufTabLineCurrent Identifier
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment

" ======================================================================================================================
" Autocommands
" ======================================================================================================================

" Keywordprg settings
autocmd FileType vim setlocal keywordprg=:help

" Apply changes after save
autocmd BufWritePost init.vim source %

" Turn spellcheck on for markdown files
autocmd BufNewFile,BufRead *.md setlocal spell

" Remove trailing whitespaces automatically before save
autocmd BufWritePre * call utils#stripTrailingWhitespaces()

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Make sure Vim returns to the same line when you reopen a file. Thanks, Amit and Steve Losh.
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Run linters after save

autocmd BufWritePost *.js Neomake eslint
" npm install -g jsonlint
autocmd BufWritePost *.json Neomake jsonlint
" gem install rubocop
autocmd BufWritePost *.rb Neomake rubocop
" sudo apt-get install elixir
autocmd BufWritePost *.ex Neomake elixir
" apt-get install tidy
autocmd BufWritePost *.html Neomake tidy
" gem install haml_lint
autocmd BufWritePost *.haml Neomake hamllint
" gem install scsslint
autocmd BufWritePost *.scss Neomake scsslint
" gem install mdl
autocmd BufWritePost *.md Neomake mdl
" apt-get install shellcheck
autocmd BufWritePost *.sh Neomake shellcheck
" pip3 install vim-vint
autocmd BufWritePost *.vim Neomake vint
