"==================================================================
"================ Samuel Thewessen vimrc-file =====================
"==================================================================
" Unlock vim functionality (not Vi)
set nocompatible
set encoding=utf8

"  Index
" =================================
" - Plugins
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

Plug 'tpope/vim-obsession'            " Auto updating a session file
Plug 'tpope/vim-vinegar'              " Extends Netrw filebrowsing (use '-' to enter current file browsing)
Plug 'tpope/vim-surround'             " Change surroundings (command: {d,c,y}s{text object})
Plug 'tpope/vim-commentary'           " Comment out (command: gcc)
Plug 'tpope/vim-fugitive'             " Git from inside vim
Plug 'tpope/vim-repeat'               " Extends '.' command for plugins
Plug 'tpope/vim-abolish'              " Abbriviations, '{}' substitution, and coercion
Plug 'tpope/vim-unimpaired'           " '[' and ']' mappings
Plug 'tpope/vim-ragtag'               " Other cool mappings
Plug 'junegunn/fzf.vim'               " FZF fuzzy filesearch in vim, like ctrlp
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'install --all' } " FZF plugin for vim
Plug 'tmux-plugins/vim-tmux'          " For tmux.conf file (highlights etc)
Plug 'adelarsq/vim-matchit'           " Extends '%' (jump html-tag, etc.)
Plug 'leafgarland/typescript-vim'     " Typescript syntax
Plug 'pangloss/vim-javascript'        " Javascript indention and syntax
Plug 'cakebaker/scss-syntax.vim'      " SCSS syntax highlighting
Plug 'MaxMEllon/vim-jsx-pretty'       " JSX highlighting (React way of HTML in Javascript)
Plug 'jwalton512/vim-blade'           " PHP blade highlighting syntax
Plug 'othree/html5-syntax.vim'        " Better HTML syntax
Plug 'hail2u/vim-css3-syntax'         " CSS3 syntax
Plug 'posva/vim-vue'                  " Vue syntax highlighting
Plug 'lumiliet/vim-twig'              " Twig highlighting
Plug 'joukevandermaas/vim-ember-hbs'  " Ember js highlighting and indention
Plug 'jparise/vim-graphql'            " GraphQL highlighting and indention
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
  nno <Tab> :tabnext<CR>
  nno <S-Tab> :tabprevious<CR>
endif

" =================================
"       Plugin Configurations
" =================================

" Blade php highlighting
let g:blade_custom_directives = ['yield', 'method', 'csrf']
let g:blade_custom_directives_pairs = {
      \ 'section': 'endsection',
      \ 'foreach': 'endforeach',
      \ 'for'    : 'endfor',
      \}

" FZF options
let g:fzf_layout = { 'up': '~40%' }
let g:fzf_buffers_jump = 1

" Unimpaired-like keybindings
" nno ]g i<CR><esc>k$


" =================================
"           Autocommands
" =================================

au FileType netrw set nonumber norelativenumber foldcolumn=2
au FileType php set shiftwidth=4 tabstop=4 softtabstop=4
au FileType blade set shiftwidth=2 tabstop=2 softtabstop=2
au FileType vue set shiftwidth=2 tabstop=2 softtabstop=2

" Vertical split help files
autocmd FileType help call Wincmd_help()
function! Wincmd_help()
    wincmd L
    " wincmd |
endfunction

" Auto reload this configfile on change
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost vimrc,.vimrc,*.vim normal ,R
augroup END

" Active Window more visible by changing ruler
augroup activewin_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &filetype != 'netrw' | setlocal number relativenumber foldcolumn=0 | endif
    autocmd BufLeave,WinLeave * if &filetype != 'netrw' | setlocal nonumber norelativenumber foldcolumn=4 | endif
augroup END

augroup no_numberline
    autocmd!
    autocmd BufEnter,WinEnter * if &buftype == 'terminal' | setlocal nonumber norelativenumber foldcolumn=2 | exec 'normal i' | endif
    " autocmd BufLeave,WinLeave * if &buftype == 'terminal' | exec 'normal ' | endif
augroup END

augroup fugitive_window
    autocmd!
    autocmd filetype fugitive wincmd H
augroup END

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
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

" Scroll faster with C-E and C-Y
nno <C-E> 2<C-E>
nno <C-Y> 2<C-Y>

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

" Command & Insert-mode mapping
cno <C-D> <Del>
ino <C-D> <Del>
ino <C-B> <ESC>bi
ino <C-L> <ESC>li
ino <C-E> <ESC>ea

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

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\s*\n//g<cr>

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

nmap <leader>0 :cbelow<CR>
nmap <leader>9 :cabove<CR>
nmap <leader>] :lbelow<CR>
nmap <leader>[ :labove<CR>

" Arguments-list (currently held by artisan commands)
" nmap <leader>a :args<space>

" Split line on match
ino <C-G><C-M> <CR><ESC>O
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
nno <leader>gd :Gvdiffsplit!<CR>
nno <leader>gi :Gvdiffsplit<space>
nno <leader>gD :Gremove<space>
nno <leader>gn :Gmove<space>
nno <leader>gw :Gwrite!<CR>
" Gdiff (3 way diff) solving merge conflicts
" Used inside working file (mid file)
nno <leader>g[ :diffget //2<CR>:diffupdate<CR>
nno <leader>g] :diffget //3<CR>:diffupdate<CR>

" FZF commands
nno <C-P> :Files<CR>
nno <leader>ff :GFiles<CR>
nno <leader>fa :Ag<space>
nno <leader>f* :Ag <C-R><C-W><CR>
nno <leader>/ :Lines<CR>
nno <leader>fl :BLines<CR>
nno <leader>fg :GFiles?<CR>
nno <leader>fc :Commits<CR>
nno <leader>fd :BCommits<CR>
nno <leader>b :Buffer<CR>
nno <leader>fw :Windows<CR>
nno <leader>fm :Marks<CR>
nno <leader>ft :Tags<CR>
nno <leader>fT :Filetypes<CR>
nno <leader>fM :Maps<CR>
nno <leader>fh :History<CR>
nno <leader>f? :Helptags<CR>
nno <leader>f: :History:<CR>
nno <leader>f/ :History/<CR>

" Edit vimrc, gitconfig, tmux.conf, zshrc, bashrc and aliases
" In current window
nmap <leader>ev :vsplit ~/.vimrc<CR>
nmap <leader>ec :vsplit ~/.vim/colors/sthew.vim<CR>
nmap <leader>el :vsplit ~/.dotfiles/vim/sthew_link_color_groups.vim<CR>
nmap <leader>eg :vsplit ~/.gitconfig<CR>
nmap <leader>et :vsplit ~/.tmux.conf<CR>
nmap <leader>ez :vsplit ~/.zshrc<CR>
nmap <leader>eb :vsplit ~/.bashrc<CR>
nmap <leader>ea :vsplit ~/.aliases<CR>
nmap <leader>en :tabnew<CR>

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
