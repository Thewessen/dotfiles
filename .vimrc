"==================================================================
"================ Samuel Thewessen vimrc-file =====================
"==================================================================
" Unlock vim functionality (not Vi)
set nocompatible
set encoding=utf8

"  Index
" =================================
" - Vundle configuration
" - Vim configuration
" - Neovim configuration
" - Mappings
" - Source

" Install Vim-Plug using:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" =================================
"             Plugins
" =================================
call plug#begin('~/.vim/plugged')

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
Plug 'w0rp/ale'                       " Async linter and completer
Plug 'justinmk/vim-dirvish'           " File browser like netrw
Plug 'tpope/vim-obsession'            " Automatically create, restore and update Sessions
Plug 'tpope/vim-surround'             " Change surroundings (command: {d,c,y}s{text object})
Plug 'tpope/vim-commentary'           " Comment out (command: gcc)
Plug 'tpope/vim-fugitive'             " Git from inside vim
Plug 'tpope/vim-repeat'               " Extends '.' command for plugins
Plug 'tpope/vim-abolish'              " Abbriviations, '{}' substitution, and coercion
Plug 'tpope/vim-unimpaired'           " '[' and ']' mappings
Plug 'tpope/vim-ragtag'               " Other cool mappings
Plug 'tpope/vim-dispatch'             " Async vim-compilers (tmux,gui,windows)
Plug 'tpope/vim-vividchalk'           " Colorscheme
Plug 'junegunn/fzf.vim'               " FZF fuzzy filesearch in vim, like ctrlp
Plug 'junegunn/fzf', {
      \ 'dir': '~/.fzf',
      \ 'do': './install'
      \ }                             " FZF plugin for vim
Plug 'dyng/ctrlsf.vim'                " Quickly make multiple changes
Plug 'airblade/vim-rooter'            " Auto lcd to root of project (see configs)
Plug 'kshenoy/vim-signature'          " Show marks and jumps (inc. Toggle)
Plug 'tmux-plugins/vim-tmux'          " For tmux.conf file (highlights etc)
Plug 'adelarsq/vim-matchit'           " Extends '%' (jump html-tag, etc.)
Plug 'mattn/emmet-vim'                " Super fast html skeletons
Plug 'leafgarland/typescript-vim'     " Typescript syntax
Plug 'pangloss/vim-javascript'        " Javascript indention and syntax
Plug 'MaxMEllon/vim-jsx-pretty'       " JSX syntax highlighting (React way of HTML in Javascript)
Plug 'jwalton512/vim-blade'           " PHP blade highlighting syntax
Plug 'othree/html5-syntax.vim'        " Better HTML syntax
Plug 'posva/vim-vue'                  " Vue syntax highlighting
Plug 'joukevandermaas/vim-ember-hbs'  " Ember js highlighting and indention
Plug 'jparise/vim-graphql'            " GraphQL highlighting and indention
Plug 'hail2u/vim-css3-syntax'         " CSS3 syntax
Plug 'reasonml-editor/vim-reason-plus' " Reasonml support
Plug 'lumiliet/vim-twig'              " Twig highlighting
Plug 'neovimhaskell/haskell-vim'      " Haskell indention and syntax
Plug 'Shougo/neosnippet.vim'          " Snippets
Plug 'Shougo/context_filetype.vim'    " Snippets depending on context filetype
Plug 'ludovicchabant/vim-gutentags'   " ctags management
Plug 'rust-lang/rust.vim'             " rust helpfull toolchain
Plug 'cespare/vim-toml'               " toml syntax highlighting
Plug 'nicwest/vim-http'               " Curl wrapper

call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

"=================================
"         Vim Configurations
"=================================

" Use dark background
set background=dark

" Basic
set autoread            " If file changed outside vim, while inside vim
set backspace=indent,eol,start
set complete-=i
set completeopt=menu,noinsert
set nrformats-=octal
set nrformats+=alpha    " Increment and decrement also works on aplhabeth
set formatoptions+=j    " Delete comment character when joining commented lines
set tabpagemax=50
set cmdheight=1
set updatetime=300
set hidden

" backups
set nobackup
set nowritebackup

" Don't pass messages to |ins-complete-menu|
set shortmess+=c

" Continue where you left off by using viminfo-file
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set sessionoptions-=blank
set switchbuf+=useopen
set switchbuf+=usetab
set switchbuf-=split
set switchbuf+=vsplit

" Colors
syntax enable       " syntax highlighting
set hlsearch        " highlight searched words
set incsearch       " search 'looped'
colorscheme sthew   " Own colorscheme adapted from monokai-colors

" Speed thing up
set nolazyredraw    " Don't redraw when using macro's
set ttyfast         " Improves smoothness of redrawing
set path+=**        " Enable recursive/fuzzy filesearch

" Extra info
set laststatus=2    " Always show statusline
set noshowmode      " Not showing mode in message bar
set wildmenu        " Display all matching files when completing
set showcmd         " Pending commands in right corner

" Show linenumbers
set ruler
" set number relativenumber   " Relative numberline (only the current line has absolute linenumber
if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=yes
endif

" Indention and formatting
set textwidth=79
set fileformat=unix
set expandtab
set autoindent
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Folds
set foldmethod=indent     " Automatic folding depending on syntax
set foldlevelstart=99     " Start with all folds open

" Invisible chars
" set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Lines and scrolling
if !&scrolloff          " Always last three lines visible when scroling to EOF
  set scrolloff=5
endif
if !&sidescrolloff      " Always last five columns visible when scroling to EOL
  set sidescrolloff=5
endif
set nowrap          " No linebreaks when window-width is too small
set wrapmargin=0    " No linebreaks in Insert mode

set wildignore=Session.vim

"=================================
"         Neovim Configurations
"=================================
if has('nvim')
  set inccommand=split
endif

" =================================
"       Plugin Configurations
" =================================
let g:dirvish_mode = ':sort ,^.*[\/],'
" call dirvish#add_icon_fn({p -> p[-1:]=='/'?'':''})

" Gutentags (manually invoce gutentags)
let g:gutentags_enabled = 0

" OCaml interpreter
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

" NeovimSnippets settings
let g:neosnippet#snippets_directory = ['$HOME/.vim/snippets']
let g:neosnippet#disable_runtime_snippets = {
    \ '_': 1,
    \}

" HTML skeletons and more...
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
let g:emmet_html5 = 1
let g:user_emmet_mode = 'i'
autocmd! FileType js,jsx,vue,html,php,css EmmetInstall

" Blade php highlighting
let g:blade_custom_directives = ['yield', 'method', 'csrf']
let g:blade_custom_directives_pairs = {
      \ 'section': 'endsection',
      \ 'foreach': 'endforeach',
      \ 'for'    : 'endfor',
      \}

" FZF options
let g:fzf_layout = { 'down': '~67%' }
let g:fzf_buffers_jump = 1

" Dispatch no keybindings
let g:dispatch_no_maps = 1
let g:dispatch_terminal_exec = 'terminator'

" vim-rooter (lcd)
let g:rooter_patterns = ['Cargo.toml', 'package.json', 'venv/', '.git/', '.exercism/', 'package.yaml']
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 0

" ale linters config
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\   'typescript': ['tsserver'],
\   'reason': ['reason-language-server'],
\   'ocaml' : ['merlin'],
\   'haskell' : ['hlint'],
\   'rust' : ['rls'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['tslint'],
\   'vue': ['prettier'],
\   'ocaml' : ['ocamlformat'],
\   'rust' : ['rustfmt'],
\   '*' : ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_rust_cargo_use_clippy = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_reason_ls_executable = 'reason-language-server'
let g:ale_close_preview_on_insert = 1

" Signature config
let g:SignatureIncludeMarks = 'HTNSGCRDLFOEUIYPA'

" =================================
"           Autocommands
" =================================

au FileType netrw set nonumber norelativenumber foldcolumn=1
au FileType php,sh set shiftwidth=4 tabstop=4 softtabstop=4
au FileType blade,vue,js set shiftwidth=2 tabstop=2 softtabstop=2

" Vertical split help files
autocmd FileType help call Wincmd_help()
function! Wincmd_help()
    wincmd L
    " wincmd |
endfunction

" Save folds of some files
" When mkview is saving manual folds, set foldmethod,foldlevelstart auto(?!?)
" augroup load_save_folds
"     autocmd!
"     autocmd BufLeave vimrc,.vimrc,*.conf mkview
"     autocmd BufRead vimrc,.vimrc,*.conf
"         \ silent loadview
"         \ setlocal foldmethod=manual
"         \ setlocal foldlevel=0
" augroup END

" Auto reload this configfile on change
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost vimrc,.vimrc,*.vim normal ,R
augroup END

" Add shebang to shell scripts
augroup skeletons
    autocmd!
    autocmd BufNewFile *.sh,*.bash,*.zsh if !empty(&filetype) | execute 'silent! 1s/.*/#!\/usr\/bin\/env ' . &filetype . '\r\r'| :startinsert | endif
augroup END

" Active Window more visible by changing ruler
augroup toggle_active_win
    autocmd!
    autocmd BufEnter,WinEnter * call SetWindowActive()
    autocmd BufLeave,WinLeave * call SetWindowInactive()
augroup END

augroup no_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &buftype == 'terminal' | setlocal nonumber norelativenumber foldcolumn=1 | endif
    " autocmd BufLeave,WinLeave * if &buftype == 'terminal' | exec 'normal ' | endif
augroup END

augroup mappings
    autocmd!
    autocmd filetype netrw call NetrwMapping()
    autocmd filetype sh call ShellMapping()
    autocmd filetype python call PythonMapping()
    autocmd filetype php call PHPMapping()
    autocmd filetype haskell call HaskellMapping()
    autocmd filetype ocaml,reason call OCAMLMapping()
    autocmd filetype js,javascript,ts,typescript,mjs,vue,jsx,reason call NPMMapping()
    autocmd filetype rust,cfg call RustMapping()
augroup END

"=================================
"		    Mappings
"=================================
" Rebinding <C-L> (unbinding NetrwNetwork(?))
function! NetrwMapping()
    nunmap <buffer> <C-L>
    nno <buffer> <C-L> <C-W>w
    nno <buffer> <C-R> <Plug>(NetrwRefresh)
endfunction

" Scroll faster with C-E and C-U
nno <C-E> 31<C-E>
nno <C-U> 31<C-Y>

" Help file vsplit on search
nmap <S-K> <S-K><C-W><S-L><C-W>|

" Search and destroy
nno \ :Abolish -search<space>
nno ? :Abolish! -search<space>
nno s :%s/
vno s :s/
nno S :%S/
vno S :S/

" Yank till end of line
nno Y y$

" Quit
nno <silent> <C-D> :q<CR>
nno <silent> <C-X> :bdelete!<CR>

" Make C-U act like u
ino <C-U> <C-G>u<C-U>

" Make C-C act like esc in Insertmode
ino <C-C> <ESC>:echo<CR>
tno <C-[> <C-\><C-N>

" Make C-L go right in insertmode
ino <C-L> <ESC>la

" Window movement and tiling
nno <C-H> <C-W>W
nno <C-L> <C-W>w
ino <C-H> <C-[><C-W>W
ino <C-L> <C-[><C-W>w
tno <C-H> <C-[><C-W>W
tno <C-L> <C-[><C-W>w

" Jump word in Insertmode
cno <C-D> <Del>
ino <C-D> <Del>
ino <C-B> <ESC>bi
ino <C-L> <ESC>li
ino <C-E> <ESC>ea

" Map function key's
" nmap <f1> :Gstatus<CR>
" nmap <f2> :Gcommit -v<CR>
" nmap <f3> :Gpush<CR>
" nmap <f4> :Gpull<CR>
" nmap <f5> :0Glog<CR>
" nmap <f7> :SyntasticCheck<CR>
" nmap <f8> :SyntasticReset<CR>
" nmap <f9> :py3 import vim, random; vim.current.line += str(random.randint(0, 9)) <CR>
nmap <f9> :set invpaste<CR>
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" nmap <silent> <f11>
" nmap <silent> <f12>

" Press Space to turn off highlighted search
" and clear any message already displayed.
nno <silent> <space> :nohlsearch<cr>:echo<cr>

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\s*\n//g<cr>
" =================================
"       Leaders
" =================================
" Different leader key
let mapleader=','

" Reload this config file
nno <silent> <leader>R :source ~/.vimrc<CR> :echo "Vimrc configuration reloaded..."<CR>

" Hide window
nno <silent> <leader>h :hide<CR>

" Hide other windows
nno <silent> <leader>o :only<CR>

" Save file
nno <leader>, :w<CR>

" Save&Close file
nno <leader>w :x<CR>

" Quit!
nmap <silent> <leader>q :qall!<CR>

" New tab
nmap <silent> <leader>t <C-W>T

" " Copy to clipboard
vno <leader>y  "+y
nno <leader>Y  "+yg_
nno <leader>y  "+y
nno <leader>yy  "+yy

" " Paste from clipboard
nno <leader>p "+p
nno <leader>P "+P
vno <leader>p "+p
vno <leader>P "+P

" Open terminal
nmap <silent> <leader>z :exec "bo 10split term://zsh"<CR>

" Switch between current and last buffer
nmap <silent> <leader>. <C-^>
" nmap <silent> <leader>'

" Buffers
" nmap <leader>b :buffer<space>
" Location list
nmap <silent> <leader>l :lopen<CR>
nmap <silent> <leader>c :copen<CR>

" Arguments-list (currently held by artisan commands)
" nmap <leader>a :args<space>

" Split line on match
ino <C-G><C-M> <CR><ESC>O

" Run
nno <leader>G :GutentagsUpdate!<CR>
nno <leader>E :!exercism submit %<CR>
nno <silent> <leader>C :Rooter<CR>

" Run compiler for current file
nno <silent> <leader>m :Dispatch!<CR>

" Syntax checking command (ale)
nno <leader>ss :ALEReset<CR>
nno <leader>sf :ALEFix<CR>
nno <leader>sd :ALEGoToTypeDefinition<CR>
nno <leader>sr :ALEFindReferences<CR>
nno <leader>sn :ALEDetail<CR>
nno <leader>si :ALEInfo<CR>
nno <leader>sl :ALELint<CR>
nno <leader>st :ALEToggle<CR>

" Git commands (vim-fugitive)
" CD to repository root
" nno <leader>cd :Gcd<CR>
" Rest of great git commands
nno <leader>gs :Gstatus<CR>
" nno <leader>gg :Gpush<CR>
nno <leader>gg :Git<space>
nno <silent> <leader>gp :Gpush<CR>
nno <silent> <leader>gL :0Glog<CR>
nno <silent> <leader>gl :Gpull<CR>
nno <leader>gm :Gmerge<space>
nno <silent> <leader>gf :Gfetch<CR>
nno <silent> <leader>gc :Gcommit -v<CR>
nno <silent> <leader>gb :Gblame!<CR>
nno <leader>gd :Gvdiffsplit!<CR>
nno <leader>gi :Gvdiffsplit<space>
nno <leader>gD :Gremove<space>
nno <leader>gn :Gmove<space>
nno <leader>g, :Gwrite!<CR>
" Gdiff (3 way diff) solving merge conflicts
" Used inside working file (mid file)
nno <leader>g[ :diffget //2<CR>:diffupdate<CR>
nno <leader>g] :diffget //3<CR>:diffupdate<CR>

" Ctrlfs command
nno <silent> <leader>* :Ctrlfs<CR>

" FZF commands
nno <silent> <C-P> :Files!<CR>
nno <silent> <leader>ff :GFiles!<CR>
nno <silent> <leader>fa :Ag!<CR>
nno <silent> <leader>f* :Ag <C-R><C-W><CR>
nno <leader>f<space> :Ag<space>
nno <silent> <leader>/ :Lines!<CR>
nno <silent> <leader>fL :BLines<CR>
nno <silent> <leader>fg :GFiles?<CR>
nno <silent> <leader>fc :Commits<CR>
nno <silent> <leader>fd :BCommits<CR>
nno <silent> <leader>b :Buffer<CR>
nno <silent> <leader>fw :Windows<CR>
nno <silent> <leader>fm :Marks<CR>
nno <silent> <leader>ft :Tags<CR>
nno <silent> <leader>fT :Filetypes<CR>
nno <silent> <leader>fM :Maps<CR>
nno <silent> <leader>fh :History<CR>
nno <silent> <leader>f? :Helptags<CR>
nno <silent> <leader>fH :History:<CR>
nno <silent> <leader>f/ :History/<CR>

function! NPMMapping()
    nno <buffer> <leader>nn :let @f=expand('%')<CR>:tabedit term://nodejs<CR>const m = require('./<C-\><C-N>"fpi')<CR>
    nno <buffer> <leader>nm :bo 10split term://node --experimental-modules %<CR>
    nno <buffer> <leader>nh :bo 10split term://nodejs"<CR>
    nno <buffer> <leader>ni :bo 10split term://npm install<CR><C-\><C-N><C-W>w
    nno <buffer> <leader>ne :bo 10split term://eslint --init<CR>
    nno <buffer> <leader>nf :bo 10split term://npm audit fix --force<CR><C-\><C-N><C-W>w
    nno <buffer> <leader>ns :tabe term://npm run start<CR><C-\><C-N>:tabprevious<CR>
    nno <buffer> <leader>nb :tabe term://npm run build<CR><C-\><C-N>:tabprevious<CR>
    nno <buffer> <leader>nw :tabe term://npm run watch<CR><C-\><C-N>:tabprevious<CR>
    nno <buffer> <leader>nt :tabe term://npm run test<CR>
    nno <buffer> <leader>nT :tabe term://npm run test:watch<CR>
    nno <buffer> <leader>nl :tabe term://npm run lint<CR>
    nno <buffer> <leader>nd :tabe term://npm run deploy<CR>
endfunction

function! PythonMapping()
    nno <buffer> <leader>nn :!python3 %:p<CR>
    nno <buffer> <leader>ni :bo 10split term://ipython --no-confirm-exit --no-banner<CR>
    nno <buffer> <leader>nt :exec ':tabe term://pytest -v -x --ff '.expand('%:p:h')<CR>
endfunction

function! ShellMapping()
    nno <buffer> <leader>nn :!sh %:p<CR>
    nno <buffer> <leader>ni :exec "bo 10split term://sh"<CR>
    nno <buffer> <leader>nt :lcd %:p:h<CR>:exec ':tabe term://BATS_RUN_SKIPPED=true bats '.expand('%:p:r').'_test.sh'<CR>
endfunction

" PHP artisan commands
function! PHPMapping()
    nno <buffer> <leader>nn :tabe term://php artisan tinker<CR>
    nno <buffer> <leader>nt :bo 10split term://vendor/bin/phpunit<CR>
    nno <buffer> <leader>nr :!php artisan route:list \| grep<space>
    nno <buffer> <leader>nm :!php artisan make:
    nno <buffer> <leader>ni :!php artisan migrate:
    nno <buffer> <leader>ns :!php artisan db:seed<CR>
endfunction

function! RustMapping()
    nno <buffer> <leader>n<space> :Cargo<space>
    nno <buffer> <leader>n, :Cbuild<CR>
    nno <buffer> <leader>n. :Cargo build --release<CR>
    nno <buffer> <leader>nn :Crun<CR>
    nno <buffer> <leader>nd :Cdoc<CR>
    nno <buffer> <leader>nD :Cargo doc --open<CR>
    nno <buffer> <leader>nN :Cnew<space>
    nno <buffer> <leader>nt :Cargo test<CR>
    nno <buffer> <leader>nT :Ccheck<CR>
    nno <buffer> <leader>nc :Cclean<CR>
    nno <buffer> <leader>nb :Cbench<CR>
    nno <buffer> <leader>nB :Cpublish<CR>
endfunction

" Edit vimrc, gitconfig, tmux.conf, zshrc, bashrc and aliases
" In current window
nmap <leader>e, :vsplit ~/.dotfiles/alacritty.yml<CR>
nmap <leader>ev :vsplit ~/.vimrc<CR>
nmap <leader>ec :vsplit ~/.vim/colors/sthew.vim<CR>
nmap <leader>el :vsplit ~/.vim/scripts/sthew_link_color_groups.vim<CR>
nmap <leader>eg :vsplit ~/.gitconfig<CR>
nmap <leader>et :vsplit ~/.tmux.conf<CR>
nmap <leader>ez :vsplit ~/.zshrc<CR>
nmap <leader>eb :vsplit ~/.bashrc<CR>
nmap <leader>ea :vsplit ~/.aliases<CR>
nmap <leader>es :NeoSnippetEdit-vertical<CR>
nmap <leader>en :new<CR>:only<CR>

" neovim-snippets key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" Todo: Make different keybining (tmux)
imap <C-t> <Plug>(neosnippet_expand_or_jump)
smap <C-t> <Plug>(neosnippet_expand_or_jump)
xmap <C-t> <Plug>(neosnippet_expand_target)

" SuperTab for for completions
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! OCAMLMapping()
    nno <buffer> <leader>nh :tabe term://utop"<CR>
endfunction

function! HaskellMapping()
    nno <buffer> <leader>nh :bo 20split term://stack ghci<CR>i
    nno <buffer> <leader>nt :bo 20split term://stack test<CR>
endfunction

" =================================
"       Source vim-scripts
" =================================

function SetWindowActive()
  if &filetype == 'netrw' || &filetype == 'dirvish' || &filetype == 'terminal'
    setlocal nonumber norelativenumber foldcolumn=2 colorcolumn=0
  else
    setlocal number norelativenumber foldcolumn=0 colorcolumn=0
  endif
endfunction

function SetWindowInactive()
  if &filetype != 'netrw' && &filetype != 'dirvish' && &filetype != 'terminal' && &filetype != 'ctrlsf'
    setlocal nonumber foldcolumn=4
  endif
endfunction

" Source statusline and tabline
source $HOME/.vim/scripts/sthew_custom_tabline.vim
source $HOME/.vim/scripts/sthew_custom_statusline.vim

" Source color links (from Plugins syntax)
source $HOME/.vim/scripts/sthew_link_color_groups.vim

" Source statusline toggle mode
source $HOME/.vim/scripts/sthew_mode_echo.vim
autocmd! VimEnter * call timer_start(10,'MyHandler',{'repeat': -1})

"==================================================================
