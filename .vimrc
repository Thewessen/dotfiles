"==================================================================
"================ Samuel Thewessen vimrc-file =====================
"==================================================================
" Unlock vim functionality (not Vi)
set nocompatible
set encoding=utf8

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

" NeovimSnippets settings
let g:neosnippet#snippets_directory = ['$HOME/.vim/snippets']
let g:neosnippet#disable_runtime_snippets = {
    \ '_': 1,
    \}

" FZF options
let g:fzf_layout = { 'down': '~67%' }
let g:fzf_buffers_jump = 1

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

" Scroll faster with C-E and C-U
nno <C-E> 31<C-E>
nno <C-U> 31<C-Y>

" Search and destroy
nno s :%s/
vno s :s/

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

" Press Space to turn off highlighted search
" and clear any message already displayed.
nno <silent> <space> :nohlsearch<cr>:echo<cr>

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>

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

if has('nvim')
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
endif

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

" neovim-snippets key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" Todo: Make different keybining (tmux)
imap <C-t> <Plug>(neosnippet_expand_or_jump)
smap <C-t> <Plug>(neosnippet_expand_or_jump)
xmap <C-t> <Plug>(neosnippet_expand_target)

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
