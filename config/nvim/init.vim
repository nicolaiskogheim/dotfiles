" vim:foldmethod=marker

" TODO(nicolai):
" Decide what/how to do with ranger
" https://github.com/ranger/ranger
" https://github.com/Mizuchi/vim-ranger
" https://github.com/rafaqz/ranger.vim
" https://github.com/francoiscabrol/ranger.vim/
" TODO(nicolai): Figure out if this pgsql plugin is any good
" https://github.com/lifepillar/pgsql.vim

" Autoinstall vim-plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

"""""""""" Mappings {{{
let maplocalleader = "\<space>"

" Switch to alternate buffer
nnoremap <leader><leader> <C-^>

nnoremap du kdd
nnoremap Y y$
nnoremap <leader><space> :noh<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <localleader>w :w<CR>
nnoremap <leader>l :source $MYVIMRC<cr>:echom "Reloaded $MYVIMRC"<cr>
nnoremap <leader>d :redraw!<CR>
xnoremap <silent> <localleader>y :w !pbcopy<CR><CR>
nnoremap <silent> <localleader>y :w !pbcopy<CR><CR>
nnoremap <silent> <localleader>E :Sex<CR>
nnoremap <silent> <localleader>e :Ex<CR>
nnoremap <silent> <localleader>b :bd \| bn<CR>
cmap w!! w !sudo tee % >/dev/null

" Persist flags in substitute-commend shortcut
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Makes <C-p> and <C-n> behave like <Up> and <Down>
" in command line mode.
" This is done to let the chords take advantage of
" the filtering you get when using arrowkeys.
" XXX: I haven't gotten this to work in Neovim
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" switch tabs using left / right arrow keys
map <Right> :tabnext<CR>
map <Left> :tabprevious<CR>

" }}}

"""""""""" Nvim Options {{{

set history=3000
set splitbelow 		" Put windows below, not above, current window when splitting
set splitright 		" Put windows right, not left, of current window when splitting
set diffopt+=vertical
set expandtab
set foldopen=insert,mark,percent,quickfix,search,tag,undo " These commands open folds //Additional default: block,jump
set ignorecase
set modelines=2
set noequalalways  " Never resize panes when splitting
set number
set shiftwidth=4
set showfulltag
set showmatch
set smartcase
set softtabstop=4
set tabstop=4
set wildmode=list:longest
set wrapmargin=0

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

" }}}

"""""""""" Undo {{{
" Keep undo history across sessions by storing it in a file
" I already have a lot of persistent undo files from using Vim,
" therefore I'll keep using the same folder for this.
let vimDir = '$HOME/.vim'
if has('persistent_undo') " {{{
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif " }}}
" }}}

"""""""""" Utility functions {{{

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
nnoremap <silent> <leader>W :call <SID>StripTrailingWhitespace()<CR>

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
" }}}

""""""""" Plugins
call plug#begin('~/.local/share/nvim/plugged')

"""""" For working with text {{{
    Plug 'junegunn/vim-easy-align'
    " {{{
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. <leader>gaip)
        nmap <leader>ga <Plug>(EasyAlign)
    " }}}
    Plug 'jeetsukumaran/vim-indentwise'
    Plug 'tomtom/tcomment_vim'                  " Commenting
    Plug 'tpope/vim-abolish'                    " Search and substitute on crack
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'mattn/emmet-vim', { 'for' : ['html', 'elm', 'blade', 'php'] } " Speed editing html
    " {{{
        let g:user_emmet_leader_key='<C-e>'
    " }}}
" }}}

""""" Vim "extensions" {{{
    Plug 'tpope/vim-unimpaired'
    Plug 'junegunn/vim-peekaboo'                " Show registers in sidepanel
    Plug 'majutsushi/tagbar'                    " Show tags in sidepanel
    " {{{ tagbar options
        nmap <leader>g :TagbarToggle<CR>
    " }}}
    Plug 'tpope/vim-repeat'                                  " Enhance the dot-command
    Plug 'tpope/vim-speeddating'                             " Work with dates
    Plug 'xolox/vim-misc'                                    " Dependency for other plugins
    Plug 'yuratomo/w3m.vim',         { 'on' : 'W3m' }        " Use w3m in vim
    Plug 'https://github.com/editorconfig/editorconfig-vim', " Makes Vim respect .editorconfig
    Plug 'w0rp/ale'                                          " Asynchonous statis analysis
    " Ale options {{{
        " I turn Ale off sometimes if neovim becomes sluggish
        nnoremap <localleader>a :ALEToggle<CR>
    " }}}
    Plug 'nacitar/a.vim', { 'for' : ['c', 'cpp'] } " Helpers for opening related files (ish).
                                                   "Supports more languages than I selected.
    Plug 'mhinz/vim-startify'
    " {{{ startify options
    nnoremap <silent> <localleader>s :Startify<CR>
    nnoremap <silent> <localleader>S :tabe \| Startify<CR>

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

    let g:startify_custom_indices = ['r', 'u', 'm', 'aa', 'af', 'ad', 'ag', 'aj', 'al', 'ak', 'da', 'df', 'dd', 'dg', 'dj', 'dl', 'dk', 'lf', 'ld', 'lg', 'lj', 'lh', 'll', 'lk', 'la', 'oa', 'of', 'od', 'og', 'oj', 'ol', 'ok']

    " TODO: Uncomment below line when has a proper patched font
    " let g:startify_custom_entry_display = "\" (\" . WebDevIconsGetFileTypeSymbol(entry_path) . \") \" . repeat(' ', (3 - strlen(index))) . entry_path"
    " }}}
    " Plug 'vim-airline/vim-airline'                                " Statusline, but it's sooo slow :(((
    " {{{ airline options
        let g:airline_extensions = []
        let g:airline_highlighting_cache = 0
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
" }}}

""""" Integration plugins {{{
    Plug 'tpope/vim-fugitive'                " Everything git from inside neovim
    " {{{ fugitive options
    nnoremap <silent> <localleader>gs :Gstatus<CR>
    " }}}
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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

      " These isn't always behaving like I want
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
    Plug 'mattn/webapi-vim'                  " gist-vim dependency
    Plug 'mattn/gist-vim', { 'on' : 'Gist' } " Create gists from neovim
    " {{{ gist options
        let g:gist_clip_command = 'pbcopy'
        let g:gist_detect_filetype = 1
        let g:gist_post_private = 1
    " }}}
    Plug 'tmux-plugins/vim-tmux'                            " Everything for .tmux.conf
    " Plug 'edkolev/tmuxline.vim'                             " Tmux status line generator
    Plug 'tmux-plugins/vim-tmux-focus-events'               " Fixes issues with focus events
    Plug 'christoomey/vim-tmux-navigator'
    " {{{ vim-tmux-navigator options
        let g:tmux_navigator_no_mappings = 1

        nnoremap <silent> <c-s> :TmuxNavigateLeft<cr>
        nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <c-f> :TmuxNavigateRight<cr>
        nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
    " }}}
    Plug 'https://github.com/thiderman/vim-supervisor'        " Supervisor wrapper
" }}}

"""""" Language specific {{{
    " Plug 'sheerun/vim-polyglot'                             " Language packs
    " XXX disable graphql in polyglot if you enable this one
    " This is the check that polyglot does:
    " index(g:polyglot_disabled, 'graphql') == -1
    """ C
    Plug 'justinmk/vim-syntax-extra' , { 'for' : 'C' }      " Improved C-syntax
    Plug 'vim-scripts/SDL-library-syntax-for-C'
    """ GAS
    Plug 'CheezeCake/vim-gas'        , { 'for' : 'gas' }    " Gas highlighting
    """ Go
    Plug 'fatih/vim-go', { 'for' : ['go'] , 'tag' : '*' } " For Go development
    " {{{
        let g:go_fmt_command = "goimports"
    " }}}
    Plug 'jodosha/vim-godebug', { 'for' : ['go'] } " Interface to Go debugger
    """ Elm
    Plug 'elmcast/elm-vim'
    " {{{
        let g:elm_format_autosave = 1
        let g:elm_setup_keybindings = 0
        let g:elm_syntastic_show_warnings = 1

        " Below are some available options. The values is not necessarily the default

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
    """ Rust
    Plug 'rust-lang/rust.vim', { 'for' : 'rust' }   " Rust highlighting
    " {{{
        let g:rustfmt_autosave = 1
    " }}}
    """ Java
    Plug 'vim-jp/vim-java', { 'for' : 'java' }   " Java highlighting
    """ Gradle
    Plug 'tfnico/vim-gradle', { 'for' : 'gradle'}  " Gradle highlighting
    """ JSON
    Plug 'elzr/vim-json',   { 'for' : 'json' }   " Better looking JSON
    """ Html template languages
    Plug 'jwalton512/vim-blade'      , { 'for' : 'blade' }  " Blade highlighting
" }}}

"""""" Snippets {{{
" Snipmate:
    Plug 'MarcWeber/vim-addon-mw-utils'
    Plug 'tomtom/tlib_vim'
    Plug 'garbas/vim-snipmate'
    Plug 'nicolaiskogheim/vim-snippets'
" /end snipmate
" }}}

"""""" Colorschemes {{{
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/seoul256.vim'
    Plug 'trusktr/seti.vim'
    Plug 'nanotech/jellybeans.vim'
    Plug '~/.vim/plugged/lettuce.vim'
    Plug 'NLKNguyen/papercolor-theme'
" }}}

Plug 'ryanoasis/vim-devicons'                           " Integrates with other plugins
                                                        " Must be loaded after plugins
                                                        " using it


Plug 'nsf/gocode', { 'for': 'go', 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }


" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Initialize plugin system
call plug#end()

"""""""""" Color Scheme (must be after plugins that install colors chemes)
colorscheme papercolor
let g:gruvbox_contrast_dark="hard"
set background=dark

"""""""""" Status line
" set statusline=%f
	  "%-0{minwid}.{maxwid}{item}
      ":set statusline=%!MyStatusLine()

hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set statusline=%F    " Full path to the file in the buffer
set statusline+=%m%* " Modified flag, text is "[+]"; "[-]" if 'modifiable' is off.
set statusline+=%r   " Read-only flag, text is "[RO]"
set statusline+=%h   " Help buffer flag, text is "[help]"
set statusline+=%w%*\ 
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=%=%{fugitive#statusline()}\    
" set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)
" set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
