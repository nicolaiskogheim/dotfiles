set nocompatible

call plug#begin('~/.vim/plugged')


" Developer tools
Plug 'L9'

" Collaborating
Plug 'FredKSchott/CoVim'

" Utility
Plug 'christoomey/vim-tmux-runner'
Plug 'Cofyc/vim-uncrustify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/vim-peekaboo'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-easytags'
Plug 'ceedubs/sbt-ctags'
Plug 'rizzatti/dash.vim'

" Quickfix parsers
Plug 'felixge/vim-nodejs-errorformat'

" Miscelaneous
Plug 'fmoralesc/vim-tutor-mode'
Plug 'joshhartigan/vim-reddit'
Plug 'tmux-plugins/vim-tmux' " Everything for .tmux.conf
Plug 'tmux-plugins/vim-tmux-focus-events' " Fixes issues with focus events
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'xolox/vim-misc'

" Static analysis
Plug 'scrooloose/syntastic' " Syntax checking


" Vim mappings
Plug 'jeetsukumaran/vim-indentwise'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/a.vim'
Plug 'wellle/targets.vim'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'wincent/command-T'
Plug 'mhinz/vim-startify'

" Snipmate:
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'nicolaiskogheim/vim-snippets'
" /end snipmate

" Colors and colorschemes
Plug 'sheerun/vim-polyglot' " Lanugage packs
Plug 'amdt/vim-niji' " Rainbow parenthesis for Scheme etc.
Plug 'bling/vim-airline' " Statusline
Plug 'elzr/vim-json' " Better JSON
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'justinmk/vim-syntax-extra' " Improved C-syntax
Plug 'trusktr/seti.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'nanotech/jellybeans.vim'
Plug '~/.vim/plugged/lettuce.vim'
Plug 'CheezeCake/vim-gas'
Plug 'rust-lang/rust.vim'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'chriskempson/base16-vim'

" All of your Plugs must be added before the following line
call plug#end()
filetype plugin indent on     " required


syntax on
set t_ut=
set t_Co=256
let base16colorspace=256
" colorscheme base16-seti
colorscheme lettuce
set background=dark


" For jumping between windows
" This mapping makes the shortcuts consistent between Vim and tmux.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Makes <C-p> and <C-n> behave like <Up> and <Down>
" in command line mode.
" This is done to let the chords take advantage of
" the filtering you get when using arrowkeys.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <silent> [b : :bprevious<CR>
nnoremap <silent> ]b : :bnext<CR>
nnoremap <silent> [B : :bfirst<CR>
nnoremap <silent> ]B : :blast<CR>

" Speed deleting lines
nnoremap du kdd

" I don't know if these two are a good idea.
"nnoremap dl dd
"nnoremap dd jdd


" More intuitive splitting
set splitbelow
set splitright

" command line history
set history=200

" enables matchit
runtime macros/matchit.vim

" Persist flags in substitute-command shortcur
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Fast switch to alternate buffer
noremap \\ <C-^>


" set scrolloff=3
" set visualbell
"set showmode
set autoindent
set encoding=utf-8
set expandtab
set hlsearch
set ignorecase
set laststatus=2
set matchtime=2
set number
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set softtabstop=2
set tabstop=2
set textwidth=0
set ttyfast
set wildmenu
set wildmode=list:longest
set wrapmargin=0

" Fixes strange backspace bug
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=2

nnoremap <leader><space> :noh<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack
nnoremap <leader>ft Vatzf
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <SPACE>w :w<CR>


"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup



set laststatus=2
"set fillchars+=stl:\ ,stlnc:\
let g:airline_powerline_fonts = 1

"Ingore stuff
set wildignore+=node_modules/**
set wildignore+=static/node_modules/**
set wildignore+=static/bower_components/**
set wildignore+=bower_components/**
set wildignore+=*.class
set wildignore+=*.pyc
set wildignore+=*.png

set modelines=1

" scroll page and cursor " NO THIS IS EVIL
" map <c-j> j<c-e>
" map <c-k> k<c-y>

" Folding
nnoremap <leader>f zfip

" switch tabs using left / right arrow keys
map <Right> :tabnext<CR>
map <Left> :tabprevious<CR>

" I have to do a lot of redrawing
nnoremap <leader>d :redraw!<CR>

" function to execute current buffer using it's shebang
au BufEnter *
      \ if match (getline(1) , '^\#!') == 0 |
      \ execute("let b:interpreter = getline(1)[2:]") |
      \ endif

fun! CallInterpreter()
  if exists("b:interpreter")
    exec("! ".b:interpreter." %")
  endif
endfun

map <leader>x :call CallInterpreter()<CR>

" Mappings for saving and running current file

autocmd FileType prolog noremap <buffer> <leader>s :w\|:!swipl -s %<cr>
autocmd FileType prolog inoremap <buffer> <C-l> <C-R>=":-"<C-M>

autocmd FileType scheme xnoremap <buffer> <leader>r :w !guile<cr>
autocmd FileType scheme nnoremap <buffer> <leader>s :%w !guile<cr>

autocmd FileType java nnoremap <buffer> <leader>s :w \|:!javac %<cr>

autocmd FileType python nnoremap <buffer> <leader>s :w \|:!python %<cr>

autocmd FileType c inoremap <buffer> <C-l> <C-R>="->"<C-M>

nnoremap <leader>l :source $MYVIMRC<cr>:echom "Reloaded $MYVIMRC"<cr>
vnoremap <leader>y :w !pbcopy<cr>

nnoremap <leader>R :redraw!<CR>

" Note to self: Denne ødelegger tmux-mappingene
" augroup myvimrc
"     au!
"     au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
" augroup END

" One should always be greeted by a cat when opening Vim.
" echom ">^.^<" " This should print after Vim has loaded
iabbr sop System.out.print();<esc>T(i

nmap <leader>g :TagbarToggle<CR>
let g:airline#extensions#tabline#enabled=1
let g:easytags_async=1

" autocmd FileType java let b:jcommenter_class_author='Nicolai Skogheim (nicolai.skogheim@gmail.com)'
" autocmd FileType java let b:jcommenter_file_author='Nicolai Skogheim (nicolai.skogheim@gmail.com)'
" autocmd FileType java source ~/.vim/macros/jcommenter.vim
" autocmd FileType java map <leader>j :call JCommentWriter()<CR>

" Make syntastic not complain about ionic-html
let g:syntastic_html_tidy_blocklevel_tags = [
  \'ion-checkbox',
  \'ion-content',
  \'ion-delete-button',
  \'ion-footer-bar',
  \'ion-header-bar',
  \'ion-infinite-scroll',
  \'ion-item',
  \'ion-list',
  \'ion-modal-view',
  \'ion-nav-back-button',
  \'ion-nav-bar',
  \'ion-nav-buttons',
  \'ion-nav-view',
  \'ion-option-button',
  \'ion-pane',
  \'ion-popover-view',
  \'ion-radio',
  \'ion-refresher',
  \'ion-reorder-button',
  \'ion-scroll',
  \'ion-side-menu',
  \'ion-side-menus',
  \'ion-side-menu-content',
  \'ion-slide',
  \'ion-slide-box',
  \'ion-tab',
  \'ion-tabs',
  \'ion-toggle',
  \'ion-view',
  \]

"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:startify_bookmarks = [ '~/.vimrc', '/Users/nicolai/P/inf/1010/oblig7/' ]

let g:syntastic_python_python_exec = '/usr/local/bin/python3'
set viminfo='100,n/Users/nicolai/.vim/files/info/viminfo'
 
autocmd! bufwritepost .vimrc source %

nnoremap <SPACE>w :w<CR>

" bats
au BufRead,BufNewFile *.bats        set filetype=sh
