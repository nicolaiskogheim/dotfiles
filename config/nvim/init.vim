" vim:foldmethod=marker

" TODO(nicolai):
" Decide what/how to do with ranger
" https://github.com/ranger/ranger
" https://github.com/Mizuchi/vim-ranger
" https://github.com/rafaqz/ranger.vim
" https://github.com/francoiscabrol/ranger.vim/
" TODO(nicolai): Figure out if this pgsql plugin is any good
" https://github.com/lifepillar/pgsql.vim

" This machine needs to be told where pyton is
if $HOST=="ganon"
    let g:python3_host_prog='/usr/bin/python'
endif

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
nnoremap <silent> <localleader>E :Sex<CR>
nnoremap <silent> <localleader>e :Ex<CR>
nnoremap <silent> <localleader>b :bd \| bn<CR>
cmap w!! w !sudo tee % >/dev/null

nnoremap <silent> <leader>r V:retab<CR>
xnoremap <silent> <leader>r :retab<CR>


" Mappings for copying to clipboard
if executable('pbcopy')
    nnoremap <silent> <localleader>y :w !pbcopy<CR><CR>
    nnoremap <silent> <localleader>u :w !nc -c localhost 8082<CR><CR>
    " :w only writes whole lines, so we have to do some magic here.
    " And we go through `head --bytes=-1` to remove the added newline.
	xnoremap <localleader>y y:split ~/tmpclipboard_uniquenamehere18284<CR>P:w !head --bytes=-1 \| pbcopy<CR><CR>:bdelete!<CR>
	xnoremap <localleader>u y:split ~/tmpclipboard_uniquenamehere18285<CR>P:w !head --bytes=-1 \| nc -c localhost 8082<CR><CR>:bdelete!<CR>
elseif executable('xsel')
    nnoremap <silent> <localleader>y :w !xsel -i -b<CR><CR>
    " :w only writes whole lines, so we have to do some magic here.
    " And we go through `head --bytes=-1` to remove the added newline.
	xnoremap <localleader>y y:split ~/tmpclipboard_uniquenamehere18284<CR>P:w !head --bytes=-1 \| xsel -i -b<CR><CR>:bdelete!<CR>
	xnoremap <localleader>u y:split ~/tmpclipboard_uniquenamehere18284<CR>P:w !head --bytes=-1 \| nc -c localhost 8083<CR><CR>:bdelete!<CR>
	onoremap <localleader>y y:split ~/tmpclipboard_uniquenamehere18284<CR>P:w !head --bytes=-1 \| xsel -i -b<CR><CR>:bdelete!<CR>
endif

" Persist flags in substitute-commend shortcut
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Makes <C-p> and <C-n> behave like <Up> and <Down>
" in command line mode.
" This is done to let the chords take advantage of
" the filtering you get when using arrowkeys.
cmap <C-p> <Up>
cmap <C-n> <Down>

" switch tabs using left / right arrow keys
nmap <Right> :tabnext<CR>
nmap <Left> :tabprevious<CR>

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
set shiftwidth=2
set showfulltag
set showmatch
set smartcase
set softtabstop=2
set tabstop=2
set wildmode=list:longest
set wrapmargin=0
set signcolumn=yes

if exists("&wildignorecase")
    set wildignorecase
endif

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
" TODO(nicolai): This should probably use <buffer> <localleader>x instead
" because it is file specific
map <leader>x :call CallInterpreter()<CR>
" }}}

" https://vi.stackexchange.com/a/2237/2777
" If one has a particular extension that one uses for binary files (such as exe,
" bin, etc), you may find it helpful to automate the process with the following
" bit of autocmds for your <.vimrc>.  Change that "*.bin" to whatever
" comma-separated list of extension(s) you find yourself wanting to edit:
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

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
        let g:user_emmet_leader_key='<C-q>'
    " }}}
" }}}

""""" Vim "extensions" {{{
    Plug 'tpope/vim-unimpaired'
    Plug 'junegunn/vim-peekaboo'                " Show registers in sidepanel
    Plug 'majutsushi/tagbar'                    " Show tags in sidepanel
    " {{{ tagbar options
        nmap <leader>g :TagbarToggle<CR>
        let g:tagbar_show_linenumbers = 1
    " }}}
    Plug 'tpope/vim-repeat'                                  " Enhance the dot-command
    " Plug 'tpope/vim-speeddating'                             " Work with dates
    Plug 'xolox/vim-misc'                                    " Dependency for other plugins
    Plug 'yuratomo/w3m.vim',         { 'on' : 'W3m' }        " Use w3m in vim
    Plug 'https://github.com/editorconfig/editorconfig-vim', " Makes Vim respect .editorconfig
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
    " {{{
        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> <C-]> <Plug>(coc-definition)
        nmap <silent> g<C-]> <Plug>(coc-type-definition)
        " nmap <silent> gi <Plug>(coc-implementation)
        " nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction
    " }}}
    Plug 'neoclide/coc-neco'

    " Plug 'w0rp/ale'                                          " Asynchonous statis analysis
    " " Ale options {{{
    "     " I turn Ale off sometimes if neovim becomes sluggish
    "     nnoremap <localleader>at :ALEToggle<CR>
    "     nnoremap <localleader>af :ALEFix<CR>
    "     let g:ale_fix_on_save = 0
    "     let g:ale_fixers = { 'php': ['prettier'] }
    "     " let g:ale_linters = { 'sh': ['language_server'], 'golang': ['gopls'] }
    "     " Enable completion where available.
    "     let g:ale_completion_enabled = 1
    " " }}}

    Plug 'nacitar/a.vim', { 'for' : ['c', 'cpp'] } " Helpers for opening related files (ish).
                                                   "Supports more languages than I selected.
    Plug 'mhinz/vim-startify'
    " {{{ startify options
    let g:startify_change_to_dir = 0
    let g:startify_change_to_vcs_root = 1

    nnoremap <silent> <localleader>s :Startify<CR>
    nnoremap <silent> <localleader>S :tabe \| Startify<CR>

    let g:startify_list_order = [ 'files', 'sessions', 'dir', 'bookmarks' ]
    let g:startify_bookmarks = [ { 'v': '~/.vimrc' },
                                \{ 'n': '~/.config/nvim/init.vim' },
                                \{ 'b': '~/.bashrc' },
                                \{ 'z': '~/.zshrc' },
                                \{ 's': '~/dotfiles/shell_agnostic_rc.inc' },
                                \{ 't': '~/.tmux.conf' },
                                \{ '3': '~/.config/i3/config' },
                                \{ 'g': '~/.gitconfig' },
                                \{ 'c': '~/.ssh/config' },
                                \{ 'o': '~/dotfiles/local/oskjeks' },
                                \{ 'a': '~/dotfiles/local/ganon' }
                                \]

    let g:startify_custom_indices = ['r', 'u', 'm', 'da', 'df', 'dd', 'dg', 'dj', 'dl', 'dk', 'lf', 'ld', 'lg', 'lj', 'lh', 'll', 'lk', 'la', 'lb', 'lc', 'oa', 'of', 'od', 'og', 'oj', 'ol', 'ok']

    " TODO: Uncomment below line when has a proper patched font
    " let g:startify_custom_entry_display = "\" (\" . WebDevIconsGetFileTypeSymbol(entry_path) . \") \" . repeat(' ', (3 - strlen(index))) . entry_path"
    " }}}
    " Plug 'vim-airline/vim-airline'               " Statusline, but it's sooo slow :(((
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
    nnoremap <silent> <localleader>gd :Gdiff<CR>
    nnoremap <silent> <localleader>gb :Gblame<CR>
    nnoremap <silent> <localleader>gc :Gcommit<CR>
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
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

    " Integrating with pane managers is not only only! But, but.
    " If this works, you should be able to navigate seamlessly through panes
    " and buffers alike, in both tmux and i3.

    Plug 'termhn/i3-vim-nav'
    " Plug 'jwilm/i3-vim-focus'
    Plug 'tmux-plugins/vim-tmux'                            " Everything for .tmux.conf
    " Plug 'edkolev/tmuxline.vim'                             " Tmux status line generator
    Plug 'tmux-plugins/vim-tmux-focus-events'               " Fixes issues with focus events
    Plug 'christoomey/vim-tmux-navigator'
    " {{{ vim-tmux-navigator options
        let g:tmux_navigator_no_mappings = 1
    " }}}
    if !empty($TMUX)
        nnoremap <silent> <c-s> :TmuxNavigateLeft<cr>
        nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
        nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
        nnoremap <silent> <c-f> :TmuxNavigateRight<cr>
        nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
    elseif $DESKTOP_SESSION=="i3"
        set title
        nnoremap <silent> <c-s> :call Focus('left', 'h')<CR>
        nnoremap <silent> <c-j> :call Focus('down', 'j')<CR>
        nnoremap <silent> <c-k> :call Focus('up', 'k')<CR>
        nnoremap <silent> <c-f> :call Focus('right', 'l')<CR>
    endif
    Plug 'https://github.com/thiderman/vim-supervisor'        " Supervisor wrapper
    Plug 'jbyuki/instant.nvim'
    " {{{
    let g:instant_username = "nico"
    "}}}
" }}}

"""""" Language specific {{{
    " Plug 'sheerun/vim-polyglot'                             " Language packs
    " XXX disable graphql in polyglot if you enable this one
    " This is the check that polyglot does:
    " index(g:polyglot_disabled, 'graphql') == -1
    """ C
    Plug 'justinmk/vim-syntax-extra' , { 'for' : 'C' }      " Improved C-syntax
    Plug 'vim-scripts/SDL-library-syntax-for-C', { 'for' : 'C' }
    """ GAS
    Plug 'CheezeCake/vim-gas'        , { 'for' : 'gas' }    " Gas highlighting
    """ Go
    Plug 'fatih/vim-go', { 'for' : ['go'], 'do': ':GoUpdateBinaries' } " For Go development
    " {{{
        let g:go_fmt_command = "goimports"
        let g:go_def_mapping_enabled = 0
        let g:go_doc_keywordprg_enabled = 0

        let g:go_highlight_array_whitespace_error = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_chan_whitespace_error = 1
        let g:go_highlight_debug = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_format_strings = 1
        let g:go_highlight_function_calls = 1
        let g:go_highlight_function_parameters = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_generate_tags = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_space_tab_error = 1
        let g:go_highlight_string_spellcheck = 1
        let g:go_highlight_trailing_whitespace_error = 1
        let g:go_highlight_types = 1
        let g:go_highlight_variable_assignments = 1
        let g:go_highlight_variable_declarations = 1
    " }}}
    " GraphQL
    Plug 'jparise/vim-graphql'
    Plug 'jodosha/vim-godebug', { 'for' : ['go'] } " Interface to Go debugger
    """ Elm
    Plug 'elmcast/elm-vim', { 'for' : 'elm' }
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
    """ Nginx
    Plug 'chr4/nginx.vim', " Smart nginx highlighting
    """ Html template languages
    Plug 'jwalton512/vim-blade'      , { 'for' : 'blade' }  " Blade highlighting
    Plug 'plasticboy/vim-markdown' , { 'for' : 'markdown' } " Markdown highlighting
    " vim-markdown options {{{
    let g:vim_markdown_folding_disabled = 1
    " }}}
    Plug 'mustache/vim-mustache-handlebars' , { 'for' : 'mustache' } " Mustache and handlebars highlighting
    Plug 'kannokanno/previm', { 'for' : ['markdown'] }     " Preview for markdown, rst, and mermaid
    " previm options {{{
    let g:previm_open_cmd = 'open -a Google\ Chrome'
    " }}}
    """ React related
    Plug 'pangloss/vim-javascript' " JavaScript bundle. Provides syntax highlighting and improved indentation.
    Plug 'leafgarland/typescript-vim' " Typescript highlighting. Dependency of maxmellon/vim-jsx-pretty.
    Plug 'maxmellon/vim-jsx-pretty' " React syntax highlighting and indenting. Also supports typescript.
    Plug 'Quramy/tsuquyomi' " 'Make your Vim a TypeScript IDE'.
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
    " Plug 'junegunn/seoul256.vim'
    Plug 'trusktr/seti.vim'
    Plug 'nanotech/jellybeans.vim'
    " Plug '~/.vim/plugged/lettuce.vim'
    Plug 'NLKNguyen/papercolor-theme'
" }}}

" Plug 'ryanoasis/vim-devicons'                           " Integrates with other plugins
                                                        " Must be loaded after plugins
                                                        " using it


" Plug 'mdempsky/gocode', { 'for': 'go', 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }


" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Initialize plugin system
call plug#end()

"""""""""" Settings that depend on filetype
augroup filetype_sensitive
    autocmd!
    autocmd FileType yaml setl shiftwidth=2

    autocmd FileType elm inoremap <buffer> <C-l> <C-R>="-> "<C-M>
augroup END


"""""""""" Color Scheme (must be after plugins that install colors chemes)
colorscheme jellybeans
set termguicolors
" colorscheme PaperColor
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
