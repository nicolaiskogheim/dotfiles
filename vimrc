" vim:foldmethod=marker
set nocompatible
set viminfo='100,n$HOME/.vim/files/info/viminfo " yes, no trailing '
let maplocalleader = "\<space>"

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo') " {{{
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif " }}}

" This doesn't always work.
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    set clipboard^=unnamed
endif

" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.vim/plugged')

" I plan to check these out:
" unblevable/quick-scope
" zef/vim-cycle
" rstacruz/vim-closer
" vim-obsession
" vim-eunuch
" Olical/vim-enmasse
" http://www.stephendiehl.com/posts/vim_2016.html  << haskell in vim 2016
" https://github.com/begriffs/haskell-vim-now

" Developer tools (for Vim)
" Plug 'L9'

" Collaborating
" Plug 'FredKSchott/CoVim'                  " Shitty plug for collaborating

" Utility
" Plug 'christoomey/vim-tmux-runner'
" Plug 'Cofyc/vim-uncrustify', { 'for' : ['c', 'cpp'] }
" {{{
augroup load_uncrustify_mappings
    autocmd!
    autocmd FileType c noremap <buffer> <leader>u :call Uncrustify('c')<CR>
    autocmd FileType c vnoremap <buffer> <leader>u :call RangeUncrustify('c')<CR>
    autocmd FileType cpp noremap <buffer> <leader>u :call Uncrustify('cpp')<CR>
    autocmd FileType cpp vnoremap <buffer> <leader>u :call RangeUncrustify('cpp')<CR>
augroup end
" }}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" {{{ fzf options
  let g:fzf_vim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader>t :Files<CR>
  nnoremap <silent> <localleader>t :GFiles<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <localleader>; :BLines<CR>
  nnoremap <silent> <localleader>. :Lines<CR>
  nnoremap <silent> <localleader>o :BTags<CR>
  nnoremap <silent> <localleader>O :Tags<CR>
  nnoremap <silent> <localleader>: :Commands<CR>
  nnoremap <silent> <localleader>? :History<CR>
  nnoremap <silent> <localleader>/ :execute 'Ag ' . input('Ag/')<CR>
  nnoremap <silent> <localleader>k :call SearchWordWithAg()<CR>
  vnoremap <silent> <localleader>k :call SearchVisualSelectionWithAg()<CR>
  nnoremap <silent> <localleader>gl :Commits<CR>
  nnoremap <silent> <localleader>ga :BCommits<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
  endfunction
" }}}
Plug 'junegunn/vim-peekaboo'                " Show registers in sidepanel
Plug 'majutsushi/tagbar'                    " Show tags in sidepanel
" {{{ tagbar options
nmap <leader>g :TagbarToggle<CR>
" }}}

Plug 'tpope/vim-fugitive'                   " Git wrapper
" {{{
set diffopt+=vertical
" }}}
Plug 'xolox/vim-easytags'                   " ctags for vim, ala Go-to-definition
" Plug 'oepn/vim-easytags'                   " ctags for vim, ala Go-to-definition
" {{{ easytags options
let g:easytags_events = ['BufReadPost', 'BufWritePost'] " This is sofa king slow.
nnoremap <localleader>ht :HighlightTags<CR>
nnoremap <localleader>ut :UpdateTags<CR>
let g:easytags_async = 1

let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
let g:easytags_async=1
" }}}
" Plug 'ceedubs/sbt-ctags', { 'for' : 'scala' } " ctags with sbt
"Plug 'luben/sctags'                         " Tags and Etags extractor for Scala
" Plug 'rizzatti/dash.vim', { 'on' : 'Dash' }   " Interface with Dash
" {{{
let g:dash_map = {
        \ 'tex' : 'latex'
        \ }
nmap <silent> <localleader>d <Plug>DashSearch
nmap <silent> <leader>s :.Dash<cr>
" }}}
Plug 'johnsyweb/vim-makeshift'                " Set makeprg according to build system
" {{{ vim-makeshift options
let g:makeshift_chdir = 1
" }}}
" Plug 'janko-m/vim-test'                       " Run tests from Vim
Plug 'mattn/webapi-vim'                       " gist-vim dependency
Plug 'mattn/gist-vim', { 'on' : 'Gist' }      " Gist from vim
" {{{ gist options
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_post_private = 1
" }}}
" Plug 'jamessan/vim-gnupg', { 'for' : 'asc' }  " Edit encrypted files
Plug 'junegunn/vim-easy-align'                " Align text
" {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>ga <Plug>(EasyAlign)
" }}}
Plug 'justinmk/vim-dirvish'                   " # Directory viewer
" Plug 'mattn/emmet-vim', { 'for' : ['html', 'elm', 'blade', 'php'] } " Speed editing html
" {{{
let g:user_emmet_leader_key='<C-q>'
" }}}
Plug 'fatih/vim-go', { 'for' : ['go'] , 'tag' : '*' } " For Go development
" {{{
let g:go_fmt_command = "goimports"
" }}}
Plug 'jodosha/vim-godebug', { 'for' : ['go'] } " Interface to Go debugger
Plug 'elmcast/elm-vim'
" {{{
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0
let g:elm_syntastic_show_warnings = 1

" Below are some available options. The values does not necessarily represent
" the default value.

" let g:elm_jump_to_error = 0
" let g:elm_make_output_file = "elm.js"
" let g:elm_make_show_warnings = 0
" let g:elm_syntastic_show_warnings = 0
" let g:elm_browser_command = ""
" let g:elm_detailed_complete = 0
" let g:elm_format_autosave = 0
" let g:elm_format_fail_silently = 0
" let g:elm_setup_keybindings = 1
" }}}
Plug 'rust-lang/rust.vim', { 'for' : ['rust'] }
" {{{
let g:rustfmt_autosave = 1
" }}}
" Quickfix parsers
Plug 'felixge/vim-nodejs-errorformat', { 'for' : 'js' }

" Miscelaneous
" Plug 'junegunn/goyo.vim',        { 'on' : 'Goyo' }   " Zen-mode
Plug 'junegunn/limelight.vim',   { 'on' : 'Limelight' }
" {{{
let g:limelight_conceal_ctermfg = 240
" }}}
" Plug 'fmoralesc/vim-tutor-mode', { 'on' : 'Tutor' }
" Plug 'joshhartigan/vim-reddit',  { 'on' : 'Reddit' }   " Browse reddit
Plug 'tmux-plugins/vim-tmux'                             " Everything for .tmux.conf
Plug 'tmux-plugins/vim-tmux-focus-events'                " Fixes issues with focus events
Plug 'tpope/vim-repeat'                                  " Enhance the dot-command
Plug 'tpope/vim-speeddating'                             " Work with dates
Plug 'xolox/vim-misc'
Plug 'yuratomo/w3m.vim',         { 'on' : 'W3m' }        " Use w3m in vim
Plug 'https://github.com/editorconfig/editorconfig-vim', " Makes Vim respect .editorconfig
Plug 'kannokanno/previm', { 'for' : ['markdown'] }     " Preview for markdown, rst, and mermaid
" previm options {{{
let g:previm_open_cmd = 'open -a Google\ Chrome'
" }}}

" Static analysis
Plug 'w0rp/ale'
" Ale options {{{
nnoremap <localleader>a :ALEToggle<CR>
" }}}

" Plug 'scrooloose/syntastic'                 " Syntax checking
" " {{{ syntastic options
" let g:syntastic_loc_list_height=3
" let g:syntastic_c_checkers = ['make']
" let g:syntastic_c_compiler="make"
" " let g:syntastic_c_compiler_options="-Wall -Wextra -std=gnu99 -Wconversion -Wpedantic"
" " OS flags
" let g:syntastic_c_compiler_options="-DLINUX_SIM=1 -Wall -Wextra -std=gnu99 -Wconversion -Wpedantic -nostartfiles -fno-defer-pop -Wno-implicit-function-declaration -fno-stack-protector -melf_i386 -N"
" let g:syntastic_enable_signs=1              " mark syntax errors with :signs
" let g:syntastic_auto_jump=0                 " automatically jump to the error when saving the file
" let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" let g:syntastic_check_on_wq = 0
" let g:syntastic_java_javac_config_file_enabled = 1
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"
" let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"
" " I can't handle fucking crates
" " let g:syntastic_rust_checkers = ['rustc']
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
"
" " Make syntastic not complain about ionic-html {{{
" let g:syntastic_html_tidy_blocklevel_tags = [
"   \'ion-checkbox',
"   \'ion-content',
"   \'ion-delete-button',
"   \'ion-footer-bar',
"   \'ion-header-bar',
"   \'ion-infinite-scroll',
"   \'ion-item',
"   \'ion-list',
"   \'ion-modal-view',
"   \'ion-nav-back-button',
"   \'ion-nav-bar',
"   \'ion-nav-buttons',
"   \'ion-nav-view',
"   \'ion-option-button',
"   \'ion-pane',
"   \'ion-popover-view',
"   \'ion-radio',
"   \'ion-refresher',
"   \'ion-reorder-button',
"   \'ion-scroll',
"   \'ion-side-menu',
"   \'ion-side-menus',
"   \'ion-side-menu-content',
"   \'ion-slide',
"   \'ion-slide-box',
"   \'ion-tab',
"   \'ion-tabs',
"   \'ion-toggle',
"   \'ion-view',
"   \]
" " }}}
"
" }}}

" Vim mappings
Plug 'jeetsukumaran/vim-indentwise'
Plug 'tomtom/tcomment_vim'                  " Commenting
Plug 'tpope/vim-abolish'                    " Search and substitute on crack
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/a.vim'
Plug 'wellle/targets.vim'
" Plug 'AndrewRadev/splitjoin.vim'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
" {{{ vim-tmux-navigator options
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <c-s> :TmuxNavigateLeft<cr>
    nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <c-f> :TmuxNavigateRight<cr>
    nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" }}}

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mhinz/vim-startify'
" {{{ startify options

let g:startify_list_order = [ 'files', 'sessions', 'dir', 'bookmarks' ]
let g:startify_bookmarks = [ { 'v': '~/.vimrc' },
                            \{ 'n': '~/.config/nvim/init.vim' },
                            \{ 'b': '~/.bashrc' },
                            \{ 'z': '~/.zshrc' },
                            \{ 's': '~/dotfiles/shell_agnostic_rc.inc' },
                            \{ 't': '~/.tmux.conf' },
                            \{ 'g': '~/.gitconfig' },
                            \{ 'c': '~/.ssh/config' },
                            \{ 'o': '~/dotfiles/local/oskjeks' }
                            \]

let g:startify_custom_indices = ['r', 'u', 'n', 'm', 'aa', 'af', 'ad', 'ag', 'aj', 'al', 'ak', 'da', 'df', 'dd', 'dg', 'dj', 'dl', 'dk', 'lf', 'ld', 'lg', 'lj', 'lh', 'll', 'lk', 'la', 'oa', 'of', 'od', 'og', 'oj', 'ol', 'ok']

" TODO: Uncomment below line when has a proper patched font
" let g:startify_custom_entry_display = "\" (\" . WebDevIconsGetFileTypeSymbol(entry_path) . \") \" . repeat(' ', (3 - strlen(index))) . entry_path"
" }}}
" Snipmate:
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'nicolaiskogheim/vim-snippets'
" /end snipmate

" Appearance
Plug 'sheerun/vim-polyglot'                             " Language packs
Plug 'vim-jp/vim-java'           , { 'for' : 'java' }   " Java highlighting
" Plug 'amdt/vim-niji'             , { 'for' : 'scheme' } " Rainbow parenthesis for Scheme etc.
" Plug 'bling/vim-airline'                                " Statusline
" {{{ airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }
" }}}
Plug 'elzr/vim-json'             , { 'for' : 'json' }   " Better JSON
Plug 'justinmk/vim-syntax-extra' , { 'for' : 'C' }      " Improved C-syntax
" I've disabled this because I've altered my tmux line, and it's getting
" overridden by this (which is the point, I know)
Plug 'edkolev/tmuxline.vim'                             " Tmux status line generator
Plug 'tfnico/vim-gradle'         , { 'for' : 'gradle'}  " Gradle highlighting
Plug 'CheezeCake/vim-gas'        , { 'for' : 'gas' }    " Gas highlighting
Plug 'rust-lang/rust.vim'        , { 'for' : 'rust' }   " Rust highlighting
Plug 'jwalton512/vim-blade'      , { 'for' : 'blade' }  " Blade highlighting
Plug 'vim-scripts/SDL-library-syntax-for-C'
Plug 'ryanoasis/vim-devicons'                           " Integrates with other plugins
                                                        " Must be loaded after plugins
                                                        " using it
Plug 'vim-php/phpctags'
Plug 'vim-php/tagbar-phpctags.vim'

" Color schemes
Plug 'junegunn/seoul256.vim'
Plug 'trusktr/seti.vim'
Plug 'nanotech/jellybeans.vim'
Plug '~/.vim/plugged/lettuce.vim'
Plug 'NLKNguyen/papercolor-theme'
" Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'

" IDE plugins
" Plug 'jplaut/vim-arduino-ino'

" All of your Plugs must be added before the following line
call plug#end()
filetype plugin indent on     " required


syntax on
set t_ut=
set t_Co=256
let base16colorspace=256
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
set background=dark


" Makes <C-p> and <C-n> behave like <Up> and <Down>
" in command line mode.
" This is done to let the chords take advantage of
" the filtering you get when using arrowkeys.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap du kdd
nnoremap Y y$

" More intuitive splitting
set splitbelow
set splitright

" command line history
set history=3000

" enables matchit
runtime macros/matchit.vim

" Persist flags in substitute-command shortcur
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Fast switch to alternate buffer
noremap <leader><leader> <C-^>

" set scrolloff=3
" set visualbell
" set showmode
set autoindent
set diffopt+=vertical
set encoding=utf-8
set expandtab
set foldopen=insert,jump,mark,percent,quickfix,search,tag,undo " These commands open folds //Additional default: block
set ignorecase
set incsearch
set laststatus=2
set matchtime=2
set modelines=2
set number
set shiftround " Don't know if I want this. Leaving it here to not forget.
set shiftwidth=4
set showcmd
set showfulltag " When completing by tag, show the whole tag, not just the function name
set showmatch
set smartcase
set softtabstop=4
set tabstop=4
set textwidth=0
set ttyfast
set wildmenu
set wildmode=list:longest
set wrapmargin=0

if exists("&wildignorecase")
    set wildignorecase
endif

" set timeout timeoutlen=200 ttimeoutlen=200

" Fixes strange backspace bug
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

function! <SID>StripTrailingWhitespace() " {{{
    let l:_s=@/
    let l:l = line('.')
    let l:c = col('.')
	" vint: -ProhibitCommandRelyOnUser -ProhibitCommandWithUnintendedSideEffect
    %s/\s\+$//e
	" vint: +ProhibitCommandRelyOnUser +ProhibitCommandWithUnintendedSideEffect
    let @/=l:_s
    call cursor(l:l, l:c)
endfunction " }}}

nnoremap <leader><space> :noh<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap <silent> <leader>W :call <SID>StripTrailingWhitespace()<CR>
nnoremap <leader>a :Ack
" This one is conflicting somewhat with <leader>f
nnoremap <leader>ft Vatzf
nnoremap <leader>f zfip
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>v V`]
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <localleader>w :w<CR>
" Run quicklook alias
nnoremap <leader>q :!ql %<CR>
nnoremap <leader>l :source $MYVIMRC<cr>:echom "Reloaded $MYVIMRC"<cr>
nnoremap <leader>d :redraw!<CR>
vnoremap <localleader>y :w !pbcopy<cr>
nnoremap <localleader>y :w !pbcopy<cr>
nmap <C-å> <ESC>

cmap w!! w !sudo tee % >/dev/null

"set fillchars+=stl:\ ,stlnc:\

" File patterns to ignore {{{
set wildignore+=node_modules
set wildignore+=static/node_modules
set wildignore+=static/bower_components
set wildignore+=bower_components
set wildignore+=*.class
set wildignore+=*.pyc
set wildignore+=*.png,*.jpeg,*.jpg
set wildignore+=*~
set wildignore+=*.tgz
set wildignore+=*.dSYM
set wildignore+=build
" }}}

" switch tabs using left / right arrow keys
map <Right> :tabnext<CR>
map <Left> :tabprevious<CR>


" function to execute current buffer using it's shebang {{{
au BufEnter *
      \ if match (getline(1) , '^\#!') == 0 |
      \ execute("let b:interpreter = getline(1)[2:]") |
      \ endif

fun! CallInterpreter()
  if exists("b:interpreter")
    exec("! ".b:interpreter." %")
  endif
endfun
" }}}
map <leader>x :call CallInterpreter()<CR>

" Mappings for saving and running current file
augroup autocommands
    au!
    autocmd FileType prolog noremap <buffer> <leader>s :w\|:!swipl -s %<cr>
    autocmd FileType prolog inoremap <buffer> <C-l> <C-R>=":-"<C-M>

    autocmd FileType scheme xnoremap <buffer> <leader>r :w !guile<cr>
    autocmd FileType scheme nnoremap <buffer> <leader>s :%w !guile<cr>

    autocmd FileType java nnoremap <buffer> <leader>s :w \|:!javac %<cr>

    autocmd FileType python nnoremap <buffer> <leader>s :w \|:!python %<cr>

    autocmd FileType c inoremap <buffer> <C-l> <C-R>="->"<C-M>
    autocmd FileType cpp inoremap <buffer> <C-l> <C-R>="->"<C-M>

    autocmd FileType php inoremap <buffer> <C-l> <C-R>="=>"<C-M>

    autocmd FileType haskell inoremap <buffer> <C-l> <C-R>="->"<C-M>
    autocmd FileType haskell nnoremap <buffer> <leader>s :w \|:!runhaskell %<cr>

    " Regular latex
    "autocmd FileType tex nnoremap <buffer> <leader>r :!export TEXINPUTS=".:./ifi:" ; pdflatex % && open %:r.pdf<cr>
    autocmd Filetype tex nnoremap <buffer> <leader>r :!make && open %:r.pdf<cr>
    " Latex with Biber
    " autocmd FileType tex nnoremap <buffer> <leader>r :!pdflatex %
    "                                                  \ && biber %:r
    "                                                  \ && pdflatex %
    "                                                  \ && open %:r.pdf<cr>


    " diff
    autocmd FileType diff setlocal list
    autocmd FileType diff nnoremap <localleader>r :g/^+/.retab\|s/\s\+$//e<CR>

    " bats
    autocmd BufRead,BufNewFile *.bats        set filetype=sh
    " markdown
    autocmd BufNewFile,BufReadPost *.md      set filetype=markdown

    autocmd! bufwritepost .vimrc source %

augroup END

" Eclim
let g:EclimeCompletionMethod = 'omnifunc'
nmap <leader>ji :JavaImportOrganize<CR>

" Script to easily change working dir to the root of a git project
function! Git_Repo_Cdup() " Get the relative path to repo root {{{
    "Ask git for the root of the git repo (as a relative '../../' path)
    let git_top = system('git rev-parse --show-cdup')
    let git_fail = 'fatal: Not a git repository'
    if strpart(git_top, 0, strlen(git_fail)) == git_fail
        " Above line says we are not in git repo. Ugly. Better version?
        return ''
    else
        " Return the cdup path to the root. If already in root,
        " path will be empty, so add './'
        return './' . git_top
    endif
endfunction " }}}

function! CD_Git_Root() " {{{
    execute 'cd '.Git_Repo_Cdup()
    let curdir = getcwd()
    echo 'CWD now set to: '.curdir
endfunction " }}}
nnoremap <LEADER>gr :call CD_Git_Root()<cr>


" Make Wildignore reflect .gitignore
" Define the wildignore from gitignore. Primarily for CommandT {{{
function! WildignoreFromGitignore()
    silent call CD_Git_Root()
    let gitignore = '.gitignore'
    if filereadable(gitignore)
        let igstring = ''
        for oline in readfile(gitignore)
            let line = substitute(oline, '\s|\n|\r', '', "g")
            if line =~ '^#' | con | endif
            if line == '' | con  | endif
            if line =~ '^!' | con  | endif
            if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
            let igstring .= "," . line
        endfor
        let execstring = "set wildignore=".substitute(igstring,'^,','',"g")
        execute execstring
        echo 'Wildignore defined from gitignore in: '.getcwd()
    else
        echo 'Unable to find gitignore'
    endif
endfunction " }}}
nnoremap <LEADER>cti :call WildignoreFromGitignore()<cr>
nnoremap <LEADER>cwi :set wildignore=''<cr>:echo 'Wildignore cleared'<cr>

nnoremap <localleader>m :set foldmethod=marker<CR>

nnoremap <silent> <localleader>r V:retab<CR>
xnoremap <silent> <localleader>r :retab<CR>

if executable('keyboard-leds') " {{{
	augroup keyboard_leds
		autocmd!
		au InsertEnter * let _caps=system('keyboard-leds -c1')
		au InsertLeave * let _caps=system('keyboard-leds -c0')
	augroup END
endif " }}}
