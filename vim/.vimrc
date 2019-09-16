"==================================================================
"================ Samuel Thewessen vimrc-file =====================
"==================================================================

set nocompatible    " Unlock vim functionality (not Vi)
set encoding=utf8

"=================================
" Start Vundle vim configuration
"=================================
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

filetype off 		" required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" =================================
"             Plugins
" =================================
" New plugins here
Plugin 'w0rp/ale'                       " Async linter and completer
Plugin 'Shougo/deoplete.nvim'           " Async completion for omnicomplete
Plugin 'carlitux/deoplete-ternjs'       " Javascript source for deoplete
Plugin 'roxma/nvim-yarp'                " Deoplete dependency
Plugin 'roxma/vim-hug-neovim-rpc'       " Deoplete dependency
Plugin 'tpope/vim-obsession'            " Automatically create, restore and update Sessions
Plugin 'tpope/vim-vinegar'              " Extends Netrw filebrowsing (use '-' to enter current file browsing)
Plugin 'tpope/vim-surround'             " Change surroundings (command: {d,c,y}s{text object})
Plugin 'tpope/vim-commentary'           " Comment out (command: gcc)
Plugin 'tpope/vim-fugitive'             " Git from inside vim
Plugin 'tpope/vim-repeat'               " Extends '.' command for plugins
Plugin 'tpope/vim-dispatch'             " Async vim-compilers (tmux,gui,windows)
Plugin 'tpope/vim-abolish'              " Abbriviations, '{}' substitution, and coercion
Plugin 'tpope/vim-unimpaired'           " '[' and ']' mappings
Plugin 'tpope/vim-ragtag'               " Other cool mappings
Plugin 'tpope/vim-vividchalk'           " Colorscheme
Plugin 'kien/ctrlp.vim'                 " Search anything and everything!
Plugin 'airblade/vim-rooter'            " Auto lcd to root of project (see configs)
Plugin 'kshenoy/vim-signature'          " Show marks and jumps (inc. Toggle)
Plugin 'pangloss/vim-javascript'        " Javascript indention and syntax
Plugin 'mxw/vim-jsx'                    " JSX highlighting (React way of HTML in Javascript)
Plugin 'tmux-plugins/vim-tmux'          " For tmux.conf file (highlights etc)
Plugin 'leafgarland/typescript-vim'     " Typescript syntax
Plugin 'Quramy/tsuquyomi'               " TSServer for omnicomplition typescript
Plugin 'adelarsq/vim-matchit'           " Extends '%' (jump html-tag, etc.)
Plugin 'jwalton512/vim-blade'           " PHP blade highlighting syntax
Plugin 'mattn/emmet-vim'                " Super fast html skeletons
Plugin 'joukevandermaas/vim-ember-hbs'  " Emberjs template highlighting

" all of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Put your non-Plugin stuff after this line

"=================================
"         Vim Configurations
"=================================

" Use dark background
set background=dark

" Basic
set autoread            " If file changed outside vim, while inside vim
set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set nrformats+=alpha    " Increment and decrement also works on aplhabeth
set formatoptions+=j    " Delete comment character when joining commented lines
set tabpagemax=50

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

" Indention and formatting
set textwidth=79
set fileformat=unix
set expandtab
set autoindent
set smarttab
set tabstop=8
set softtabstop=4
set shiftwidth=4

" Folds
set foldmethod=manual     " Automatic folding depending on syntax
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

" =================================
"       Plugin Configurations
" =================================

" Signature highlights
" let g:SignatureMarkTextHL =
" hi link SignatureMarkText User1

" let g:SignatureMarkTextHL =
" hi link SignatureMarkText User1

" HTML skeletons and more...
let g:user_emmet_leader_key=','

" Blade php highlighting
let g:blade_custom_directives = ['yield', 'method', 'csrf']
let g:blade_custom_directives_pairs = {
      \ 'section': 'endsection',
      \ 'foreach': 'endforeach',
      \}

" CtrlP options
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20,results:20'
let g:ctrlp_show_hidden = 1

" Angular-cli enter on angular-cli project
autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif
let g:angular_cli_use_dispatch = 1

" Latex-Suite configurations
let g:tex_flavor='latex'    " Enable latex-suite on empty tex-files
let g:Tex_AdvancedMath = 1  " Enable <alt>-key macro's for latex-suite
" :TTarget pdf              " Set standard output of compiler to PDF (iso DVI)

" Dispatch no keybindings
let g:dispatch_no_maps = 1
let g:dispatch_terminal_exec = 'terminator'

" Unimpaired-like keybindings
" nno ]g i<CR><esc>k$

" Use Deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'auto_complete_delay': 200,
\ 'smart_case': v:true,
\ })

" Setup javascript ternjs (other then default)
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/lib/node_modules/ternjs/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#filetypes = [
\ 'jsx',
\ 'javascript.jsx',
\ 'vue'
\ ]

" Ale
set omnifunc=ale#completion#OmniFunc

" vim-rooter (lcd)
let g:rooter_patterns = ['package.json', 'venv/', '.git/', '.exercism/']
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1

" ale linters config
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}


" =================================
"           Autocommands
" =================================

au FileType netrw set nonumber norelativenumber foldcolumn=1

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
    autocmd BufEnter,WinEnter * if &filetype != 'netrw' | setlocal number relativenumber foldcolumn=0
    autocmd BufLeave,WinLeave * if &filetype != 'netrw' | setlocal nonumber norelativenumber foldcolumn=4
augroup END

augroup no_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &buftype == 'terminal' | setlocal nonumber norelativenumber foldcolumn=1 | exec 'normal i' | endif
    " autocmd BufLeave,WinLeave * if &buftype == 'terminal' | exec 'normal ' | endif
augroup END

"=================================
"		    Mappings
"=================================

" Scroll faster with C-E and C-Y
nno <C-E> 2<C-E>
nno <C-Y> 2<C-Y>

" Help file vsplit on search
nmap <S-K> <S-K><C-W><S-L><C-W>|

" Search and destroy
nno \ :Abolish -search 
nno ? :Abolish! -search 
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

" Make C-C act like esc in Insertmode
ino <C-C> <ESC>:echo<CR>
tno <C-[> <C-\><C-N>

" Window movement and tiling
nmap <C-H> <C-W>W
nmap <C-L> <C-W>w
tmap <C-H> <C-[><C-W>W
tmap <C-L> <C-[><C-W>w
nno <C-W>v <C-W><C-V><C-W>l
nno <C-W>s <C-W><C-S><C-W>j
tmap <C-W><C-V> <C-[><C-W><C-V>
tmap <C-W><C-S> <C-[><C-W><C-S>

" Increment with C-K (iso C-A tmux)
nno <C-K> <C-A>

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
nmap <leader>, :w<CR>

" Save&Close file
nmap <leader>w :x<CR>

" Quit!
nmap <silent> <leader>q :q!<CR>

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

" Buffers
nmap <leader>b :buffer 

" Arguments-list (currently held by artisan commands)
" nmap <leader>a :args 

" Split line on match
ino <C-G><C-M> <CR><ESC>O
" Run
nno <silent> <leader>G :call GolfStart()<CR>
nno <leader>E :!exercism submit %<CR>

" Run compiler for current file
nno <silent> <leader>m :Dispatch!<CR>

" Syntax checking command (ale)
nno <leader>ss :ALEReset<CR>
nno <leader>sd :ALEGoToTypeDefinition<CR>
nno <leader>sr :ALEFindReferences<CR>
nno <leader>sn :ALEDetail<CR>
nno <leader>si :ALEInfo<CR>
nno <leader>sl :ALELint<CR>
nno <leader>st :ALEToggle<CR>

" Git commands (vim-fugitive)
" CD too repository root
nno <leader>cd :Gcd<CR>
" Rest of great git commands
nno <leader>gs :Gstatus<CR>
" nno <leader>gg :Gpush<CR>
nno <leader>gg :Git 
nno <silent> <leader>gp :Gcd<CR>:bo 10split term://git push<CR><C-\><C-N><C-W>w
nno <silent> <leader>gL :0Glog<CR>
nno <silent> <leader>gl :bo 10split term://git pull<CR><C-\><C-N><C-W>w
nno <leader>gm :Gmerge 
nno <silent> <leader>gf :Gfetch<CR>
nno <silent> <leader>gc :Gcommit -v<CR>
nno <silent> <leader>gb :Gblame!<CR>
nno <leader>gd :Gremove 
nno <leader>gn :Gmove 

" NPM and nodejs dispatch commands
nno <silent> <leader>nn :let @f=expand('%')<CR>:tabedit term://nodejs<CR>const m = require('./<C-\><C-N>"fpi')<CR>
nno <silent> <leader>nh :bo 10split term://nodejs"<CR>
nno <silent> <leader>ni :bo 10split term://npm install<CR><C-\><C-N><C-W>w
nno <silent> <leader>ne :bo 10split term://eslint --init<CR>
nno <silent> <leader>nf :bo 10split term://npm audit fix --force<CR><C-\><C-N><C-W>w
nno <silent> <leader>ns :Start -title=server npm start<CR>
nno <silent> <leader>nb :tabe term://npm run build<CR><C-\><C-N>:tabprevious<CR>
nno <silent> <leader>nw :tabe term://npm run watch<CR><C-\><C-N>:tabprevious<CR>
nno <silent> <leader>nt :tabe term://npm run test<CR>
nno <silent> <leader>nl :tabe term://npm run lint<CR>

" Python dispatch commands
nno <silent> <leader>pp :!python3 %:p<CR>
nno <silent> <leader>ph :bo 10split term://python3<CR>
nno <silent> <leader>pt :exec ':tabe term://pytest -v -x --ff '.expand('%:p:h')<CR>

" PHP artisan commands
nno <silent> <leader>aa :tabe term://php artisan tinker<CR>
nno <silent> <leader>at :tabe term://vendor/bin/phpunit<CR>
nno <leader>arl :!php artisan route:list \| grep 
nno <leader>amc :!php artisan make:controller 
nno <leader>amm :!php artisan make:model 
nno <leader>amr :!php artisan make:migration 
nno <leader>amp :!php artisan make:policy  
nno <leader>ame :!php artisan make:event 
nno <leader>aml :!php artisan make:listener 
nno <silent> <leader>aMM :!php artisan migrate<CR>
nno <silent> <leader>aMf :!php artisan migrate:fresh<CR>
nno <silent> <leader>aMr :!php artisan migrate:rollback<CR>
nno <silent> <leader>aMs :!php artisan migrate:status<CR>

" Edit vimrc, gitconfig, tmux.conf, zshrc, bashrc and aliases
" In current window
nmap <leader>ev :vsplit ~/.vimrc<CR>
nmap <leader>ec :vsplit ~/.vim/colors/sthew.vim<CR>
nmap <leader>eg :vsplit ~/.gitconfig<CR>
nmap <leader>et :vsplit ~/.tmux.conf<CR>
nmap <leader>ez :vsplit ~/.zshrc<CR>
nmap <leader>eb :vsplit ~/.bashrc<CR>
nmap <leader>ea :vsplit ~/.aliases<CR>
nmap <leader>en :new<CR>:only<CR>
" Press Space to turn off highlighted search
" and clear any message already displayed.
nno <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\s*\n//g<cr>

" Snippits (read from .vim/skeletons) like html tags etc.
nno <silent> <leader>hh :-1read $HOME/.vim/skeletons/header_comment.txt<CR>:+0,+2Commentary<CR>jA<BS>
nno <silent> <leader>ht :-1read $HOME/.vim/skeletons/title_comment.txt<CR>:+0,+2Commentary<CR>jfSc2w
nno <silent> <leader>html :-1read $HOME/.vim/skeletons/skeleton.html<CR>4jwf<i

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
