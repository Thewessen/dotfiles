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
  Plug 'Shougo/deoplete.nvim', {
        \ 'do': ':UpdateRemotePlugins'
        \ }
  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }                                   " A LC client for nvim
  Plug 'roxma/LanguageServer-php-neovim',  {
  \ 'do': 'composer install && composer run-script parse-stubs'
  \ }                                   " php LanguageServer
else
  Plug 'Shougo/deoplete.nvim'         " Async completion for omnicomplete
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'w0rp/ale'                       " Async linter and completer
Plug 'carlitux/deoplete-ternjs', {
      \ 'do' : 'npm install -g tern'
      \}                              " Javascript source for deoplete
Plug 'padawan-php/deoplete-padawan', {
      \'do': 'composer install'
      \}                              " PHP source
Plug 'tpope/vim-obsession'            " Automatically create, restore and update Sessions
Plug 'tpope/vim-vinegar'              " Extends Netrw filebrowsing (use '-' to enter current file browsing)
Plug 'tpope/vim-surround'             " Change surroundings (command: {d,c,y}s{text object})
Plug 'tpope/vim-commentary'           " Comment out (command: gcc)
Plug 'tpope/vim-fugitive'             " Git from inside vim
Plug 'tpope/vim-repeat'               " Extends '.' command for plugins
Plug 'tpope/vim-abolish'              " Abbriviations, '{}' substitution, and coercion
Plug 'tpope/vim-unimpaired'           " '[' and ']' mappings
Plug 'tpope/vim-ragtag'               " Other cool mappings
Plug 'tpope/vim-dispatch'             " Async implementations (tmux and other)
Plug 'tpope/vim-dadbod'               " Database explorer (supports many different databases)
Plug 'junegunn/fzf', {
      \ 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'               " FZF fuzzy filesearch in vim, like ctrlp
Plug 'airblade/vim-rooter'            " Automtically change working dir to root
Plug 'adelarsq/vim-matchit'           " Extends '%' (jump html-tag, etc.)
Plug 'mattn/emmet-vim'                " Super fast html skeletons
Plug 'pangloss/vim-javascript'        " Javascript indention and syntax
Plug 'MaxMEllon/vim-jsx-pretty'       " JSX highlighting (React way of HTML in Javascript)
Plug 'jwalton512/vim-blade'           " PHP blade highlighting syntax
Plug 'othree/html5-syntax.vim'        " Better HTML syntax
Plug 'hail2u/vim-css3-syntax'         " CSS3 syntax
Plug 'lumiliet/vim-twig'              " Twig highlighting
Plug 'Shougo/neosnippet.vim'          " Snippet maneger
Plug 'Shougo/context_filetype.vim'    " Snippets depending on context filetype
Plug 'janko/vim-test'                 " Multiple test runners
Plug 'lifepillar/vim-solarized8'      " Solarized colorscheme vim
Plug 'rbgrouleff/bclose.vim'          " Ranger dependencie
Plug 'francoiscabrol/ranger.vim'      " Ranger integration with vim
Plug 'jacquesbh/vim-showmarks'        " Show marks
Plug 'rust-lang/rust.vim'             " Rust language toolchain
Plug 'ludovicchabant/vim-gutentags'   " ctags generater
Plug 'vim-vdebug/vdebug'              " Debugger cli (can be used with Xdebug)
Plug 'andrmuel/vim-curl'              " Simple curl wrapper
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
set background=dark

" Basic
set autoread            " If file changed outside vim, while inside vim
set backspace=indent,eol,start
set complete-=i
set completeopt=menu
set completeopt+=noinsert
set nrformats-=octal
set nrformats+=alpha    " Increment and decrement also works on aplhabeth
set formatoptions+=j    " Delete comment character when joining commented lines
set tabpagemax=50
set hidden

" Some plugin bug fixes
set nobackup
set nowritebackup

" ??
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
set updatetime=300

" Extra info
set laststatus=2    " Always show statusline
set noshowmode      " Not showing mode in message bar
set wildmenu        " Display all matching files when completing
set showcmd         " Pending commands in right corner

" Show linenumbers
set ruler
set signcolumn=yes
" set number relativenumber   " Relative numberline (only the current line has absolute linenumber

" Indention and formatting
set textwidth=79
set colorcolumn=120
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

" Use fzf in vim
set rtp+=/usr/local/opt/fzf

" mouse support
set mouse=a

" =================================
"       Neovim Configurations
" =================================
if has('nvim')
  set inccommand=split
endif

" =================================
"       Plugin Configurations
" =================================

" Vdebug
let g:vdebug_keymap = {
\    "run" : "<leader>dr",
\    "run_to_cursor" : "<leader>dR",
\    "step_over" : "<leader>do",
\    "step_into" : "<leader>di",
\    "step_out" : "<leader>ds",
\    "close" : "<leader>dc",
\    "detach" : "<leader>d,",
\    "set_breakpoint" : "<leader>dd",
\    "get_context" : "<leader>d!",
\    "eval_under_cursor" : "<leader>d?",
\    "eval_visual" : "<Leader>dv",
\}

" GutenTags
" Use :GutentagsToggleEnabled to enable gutentags
let g:gutentags_enabled = 1
let g:gutengas_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json']

" Ranger default mapping
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 0
let g:bclose_no_plugin_maps = 1

" NeovimSnippets settings
let g:neosnippet#snippets_directory = ['$DOTFILES/vim/snippets']
let g:neosnippet#disable_runtime_snippets = {
    \ '_': 1,
    \}

" HTML skeletons and more...
let g:user_emmet_leader_key = ','
let g:user_emmet_mode = 'i'

" Blade php highlighting
let g:blade_custom_directives = ['yield', 'method', 'csrf']
let g:blade_custom_directives_pairs = {
      \ 'section': 'endsection',
      \ 'foreach': 'endforeach',
      \ 'for'    : 'endfor',
      \}

" FZF options
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_buffers_jump = 1
" Files with preview
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)

" Dispatch no keybindings
let g:dispatch_no_maps = 1
let g:dispatch_terminal_exec = 'zsh'

" Unimpaired-like keybindings
" nno ]g i<CR><esc>k$

" Use Deoplete.
let g:deoplete#enable_at_startup = 0
if has('python3')
  let g:deoplete#enable_at_startup = 1
endif

call deoplete#custom#option({
\ 'auto_complete_delay': 400,
\ 'smart_case': v:true,
\ })

" let g:deoplete#sources = {}
" let g:deoplete#sources.php = ['omni', 'phpactor', 'ultisnips', 'buffer']
" let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
" let g:deoplete#ignore_sources.php = ['phpcd', 'omni']
" Setup javascript ternjs (other then default)
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#filetypes = [
\ 'jsx',
\ 'javascript.jsx',
\ ]

" Completion function
" set omnifunc=ale#completion#OmniFunc
set omnifunc=LanguageClient#complete

" vim-rooter (lcd)
let g:rooter_patterns = ['package.json', '.git/', 'Cargo.toml']
let g:rooter_manual_only = 1
let g:rooter_cd_cmd = 'lcd'
let g:rooter_silent_chdir = 1

" ale linters config
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'rust' : ['rls', 'cargo'],
\   'php' : ['phpcs'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'rust' : ['rustfmt'],
\   'php' : ['php_cs_fixer'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 0
let g:ale_php_cs_fixer_use_global = 1
let g:ale_php_phpcs_standard = 'PSR2'

" Language server
" let $LANGUAGECLIENT_DEBUG=1
" let g:LanguageClient_loggingLevel='DEBUG'
" let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log') 
let g:LanguageClient_serverCommands = {
\ 'rust': ['rls'],
\ 'javascript': ['javascript-typescript-stdio'],
\ 'typescript': ['typescript-language-server', '--stdio']
\ }
let g:LanguageClient_autoStart=1
let g:LanguageClient_hoverPreview="Never"
let g:LanguageClient_useVirtualText="CodeLens"

" =================================
"           Autocommands
" =================================

au FileType netrw setlocal nonumber norelativenumber foldcolumn=2 colorcolumn=0
au FileType php set shiftwidth=4 tabstop=4 softtabstop=4
au FileType blade set shiftwidth=2 tabstop=2 softtabstop=2
au FileType vue set shiftwidth=2 tabstop=2 softtabstop=2
au FileType js,javascript set shiftwidth=2 tabstop=2 softtabstop=2

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

" Use compiler for latex files
augroup latex_compiler
    autocmd!
    autocmd BufWinEnter *.tex let &makeprg="pdflatex -output-directory %:p:h -interaction nonstopmode -file-line-error %"
    autocmd BufWinEnter *.tex set textwidth=79
    autocmd BufWinLeave *.tex let &makeprg=""
augroup END

" Add shebang to shell scripts
augroup skeletons
    autocmd!
    autocmd BufNewFile *.sh,*.bash,*.zsh if !empty(&filetype) | execute 'silent! 1s/.*/#!\/usr\/bin\/env ' . &filetype . '\r\r'| :startinsert | endif
augroup END

" Active Window more visible by changing ruler
augroup activewin_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &filetype != 'netrw' | setlocal number foldcolumn=0 | endif
    autocmd BufLeave,WinLeave * if &filetype != 'netrw' | setlocal nonumber foldcolumn=4 | endif
augroup END

augroup no_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &buftype == 'terminal' | setlocal nonumber foldcolumn=2  | endif
    " autocmd BufLeave,WinLeave * if &buftype == 'terminal' | exec 'normal ' | endif
augroup END

augroup fugitive_window
    autocmd!
    autocmd filetype fugitive wincmd H
augroup END

augroup mappings
    autocmd!
    autocmd filetype netrw call NetrwMapping()
    autocmd BufWinEnter,BufEnter * if &diff | call VimDiffMapping() | endif
    autocmd filetype fzf imap <buffer> <ESC> <C-D>
    autocmd filetype sh call ShellMapping()
    autocmd filetype python call PythonMapping()
    autocmd filetype php call PHPMapping()
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

function! VimDiffMapping()
  nno <buffer> ]] ]c
  nno <buffer> [[ [c
  nno <buffer> <leader>[ :diffget //2<CR>:diffupdate<CR>
  nno <buffer> <leader>] :diffget //3<CR>:diffupdate<CR>
endfunction

" Use C-E and C-U for fast scrolling
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

" Make C-U act like u
ino <C-U> <C-G>u<C-U>

" omnifunc iso next in buffer
" ino <C-N> <C-X><C-O>

" Make C-C act like esc in Insertmode
ino <C-C> <ESC>:echo<CR>
tno <C-[> <C-\><C-N>

" Make C-A and C-E act like terminal in Command mode
cno <C-A> <HOME>
cno <C-E> <END>


" Window movement and tiling
nno <C-H> <C-W>W
nno <C-L> <C-W>w
tno <C-H> <C-[><C-W>W
tno <C-L> <C-[><C-W>w
nno <C-W>v <C-W><C-V><C-W>l
nno <C-W>s <C-W><C-S><C-W>j
tmap <C-W><C-V> <C-[><C-W><C-V>
tmap <C-W><C-S> <C-[><C-W><C-S>

" Increment with C-K (iso C-A tmux)
nno <C-K> <C-A>
nunmap <C-A>

" Command & Insert-mode mapping
cno <C-D> <Del>
ino <C-D> <Del>
ino <C-B> <ESC>bi
ino <C-L> <ESC>li
ino <C-E> <ESC>ea

" instead of Isurround
imap <C-S> <Plug>Isurround
ino <C-G><C-M> <CR><ESC>O

" Map function key's
nmap <f9> :set invpaste<CR>
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Press Space to turn off highlighted search
" and clear any message already displayed.
nno <silent> <Space> :nohlsearch<CR>:echo<CR>

" =================================
"       Leaders
" =================================
" Different leader key
let mapleader=','

" Ranger iso netrw
nno <leader>- :Ranger<CR>

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\s*\n//g<cr>
"
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
" nno <leader>Y  "+yg_
nno <leader>Y  :call YankFileLineNr()<CR>
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

" Buffers
" nmap <leader>b :buffer<space>
" Location list
nmap <silent> <leader>l :lopen<CR>
nmap <silent> <leader>c :copen<CR>

nmap <leader>0 :cbelow<CR>
nmap <leader>9 :cabove<CR>
nmap <leader>] :lbelow<CR>
nmap <leader>[ :labove<CR>

" Arguments-list (currently held by artisan commands)
" nmap <leader>a :args<space>

" Split line on match
ino <C-G><C-M> <CR><ESC>O
" Run
nno <leader>E :!exercism submit %<CR>

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

" Renaming (LanguageClient)
nno <leader>rn :call LanguageClient#textDocument_rename()<CR>
nno <leader>rc :call LanguageClient#textDocument_rename(
\ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
nno <leader>rs :call LanguageClient#textDocument_rename(
\ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
nno <leader>ru :call LanguageClient#textDocument_rename(
\ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>

" Git commands (vim-fugitive)
nno <leader>gs :Gstatus<CR>
nno <leader>gg :Git<space>
nno <leader>gp :Gpush<CR>
nno <leader>gL :0Glog<CR>
nno <leader>gl :Gpull<CR>
nno <leader>gm :Gmerge<space>
nno <leader>gf :Gfetch<CR>
nno <leader>gc :Gcommit -v<CR>
nno <leader>gb :Gblame<CR>
nno <leader>gd :Git difftool -y<space>
nno <leader>gi :Gvdiffsplit<space>
nno <leader>gD :Gremove<space>
nno <leader>gn :Gmove<space>
nno <leader>g, :Gwrite!<CR>

" Enable gutentags
nno <leader>G :GutentagsUpdate!<CR>

" FZF commands
" for some reason this is mapped to buffer delete
nno <silent> <C-P> :Files!<CR>
nno <silent> <leader>ff :GFiles!<CR>
nno <leader>fa :Ag<space>
nno <silent> <leader>/ :Lines!<CR>
nno <silent> <leader>fL :BLines!<CR>
nno <silent> <leader>fg :GCheckout!<CR>
nno <silent> <leader>fc :Commits!<CR>
nno <silent> <leader>fd :BCommits!<CR>
nno <silent> <leader>b :Buffers!<CR>
nno <silent> <leader>fw :Windows<CR>
nno <silent> <leader>fm :Marks<CR>
nno <silent> <leader>ft :Tags<CR>
nno <silent> <leader>fT :Filetypes<CR>
nno <silent> <leader>fM :Maps<CR>
nno <silent> <leader>fh :History<CR>
nno <silent> <leader>f? :Helptags<CR>
nno <silent> <leader>fH :History:<CR>
nno <silent> <leader>f/ :History/<CR>

" TODO: better setup for interpreter
function! NPMMapping()
  nno <silent> <leader>nn :let @f=expand('%')<CR>:tabedit term://node<CR>const m = require('./<C-\><C-N>"fpi')<CR>
  nno <silent> <leader>nm :bo 10split term://node --experimental-modules %<CR>
  nno <silent> <leader>nh :bo 10split term://node"<CR>
  nno <silent> <leader>ni :bo 10split term://yarn<CR><C-\><C-N><C-W>w
  nno <silent> <leader>ne :bo 10split term://eslint --init<CR>
  nno <silent> <leader>ne :bo 80vsplit term://yarn lint<CR>
  nno <silent> <leader>nf :bo 10split term://npm audit fix --force<CR><C-\><C-N><C-W>w
  nno <silent> <leader>ns :tabe term://npm run start<CR><C-\><C-N>:tabprevious<CR>
  nno <silent> <leader>nb :tabe term://npm run build<CR><C-\><C-N>:tabprevious<CR>
endfunction

function! ShellMapping()
  nno <buffer> <leader>nn :!sh %:p<CR>
  nno <buffer> <leader>ni :exec "bo 10split term://sh"<CR>
  nno <buffer> <leader>nt :lcd %:p:h<CR>:exec ':tabe term://BATS_RUN_SKIPPED=true bats '.expand('%:p:r').'_test.sh'<CR>
endfunction

" PHP artisan commands
function! PHPMapping()
  nno <buffer> <leader>nn :tabe term://psysh<CR>
  nno <buffer> <leader>nt :bo 10split term://vendor/bin/phpunit<CR>
  nno <buffer> <leader>nr :!php artisan route:list \| grep<space>
  nno <buffer> <leader>nm :!php artisan make:
  nno <buffer> <leader>ni :!php artisan migrate
  nno <buffer> <leader>ns :!php artisan db:seed<CR>
endfunction

function! RustMapping()
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
nmap <leader>el :vsplit ~/.dotfiles/vim/sthew_link_color_groups.vim<CR>
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
imap <C-T> <Plug>(neosnippet_expand_or_jump)
smap <C-T> <Plug>(neosnippet_expand_or_jump)
xmap <C-T> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" TODO: GitHub auto add ticket to commit message
au! filetype gitcommit nno <buffer> <leader>b 5GyyggPd3wi[3ea] lC

" =================================
"       Custom commands
" =================================
function! YankFileLineNr()
  let path = join([expand('%'), line('.')], ':')
  call setreg('+', path)
  echo path . " (yanked to clipboard)"
endfunction

function! s:open_branch_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckout
  \ call fzf#vim#grep(
  \   'git branch -v', 0,
  \   {
  \     'sink': function('s:open_branch_fzf')
  \   },
  \   <bang>0
  \ )

" =================================
"       Source vim-scripts
" =================================

" Source statusline and tabline
source $HOME/.dotfiles/vim/sthew_custom_tabline.vim
source $HOME/.dotfiles/vim/sthew_custom_statusline.vim

" Source color links (from Plugins syntax)
source $HOME/.dotfiles/vim/sthew_link_color_groups.vim

" Source statusline toggle mode
source $HOME/.dotfiles/vim/sthew_mode_echo.vim
autocmd VimEnter * call timer_start(10,'MyHandler',{'repeat': -1})

"==================================================================
