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
Plugin 'tmux-plugins/vim-tmux'          " For tmux.conf file (highlights etc)
Plugin 'christoomey/vim-tmux-navigator' " Navigate seemlesly through vim and tmux
Plugin 'vim-syntastic/syntastic'        " Filecheck plugin (checks js,ts,css,html,...: starts with <leader>cs (see mappings))
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
Plugin 'kshenoy/vim-signature'          " Show marks and jumps (inc. Toggle)
Plugin 'pangloss/vim-javascript'        " Javascript indention and syntax
Plugin 'leafgarland/typescript-vim'     " Typescript syntax
Plugin 'bdauria/angular-cli.vim'        " Angular-cli inside vim (only starts when in a Angule-dir: see mappings)
Plugin 'vim-latex/vim-latex'            " Latex syntax, indention, snippits and more (install latex-suite)
Plugin 'Quramy/tsuquyomi'               " TSServer for omnicomplition typescript
Plugin 'Valloric/YouCompleteMe'         " Code completion engine (req. Python)
Plugin 'adelarsq/vim-matchit'           " Extends '%' (jump html-tag, etc.)
" Plugin 'Quramy/vim-js-pretty-template'

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
set incsearch		" search 'looped'
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
set tabstop=4
set softtabstop=4
set shiftwidth=4

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

" =================================
"       Plugin Configurations
" =================================

" Signature highlights
" let g:SignatureMarkTextHL =
" hi link SignatureMarkText User1

" let g:SignatureMarkTextHL =
" hi link SignatureMarkText User1

" Angular-cli enter on angular-cli project
autocmd VimEnter * if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() | endif
let g:angular_cli_use_dispatch = 1

" Latex-Suite configurations
let g:tex_flavor='latex'    " Enable latex-suite on empty tex-files
let g:Tex_AdvancedMath = 1  " Enable <alt>-key macro's for latex-suite
" :TTarget pdf              " Set standard output of compiler to PDF (iso DVI)

" Dispatch no keybindings
let g:dispatch_no_maps = 1

" Unimpaired-like keybindings
" nno ]g i<CR><esc>k$

" YMC (YouCompleteMe) configurations
" Start autocompletion after 3 chars
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Syntastic filechecker and maker config
" Behavior
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_balloons = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["javascript","typescript"] }
" Checkers
let g:syntastic_javascript_checkers = ["closurecompiler","standard","eslint","jslint","jsl"]
let g:syntastic_javascript_closurecompiler_path = "$HOME/.vim/compilers/closure-compiler-v20190121.jar"
let g:syntastic_typescript_checkers = ["eslint"]
let g:syntastic_python_checkers = ["flake8","pep8"]


" =================================
"           Autocommands
" =================================

au FileType netrw set foldcolumn=4

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
    autocmd BufEnter,WinEnter * if &buftype != 'terminal' | setlocal number relativenumber foldcolumn=0 | else | exec "normal! i" | endif
    autocmd BufLeave,WinLeave * setlocal nonumber norelativenumber foldcolumn=4
augroup END

" augroup terminal_numberline
"     autocmd!
"     autocmd BufWinEnter,WinEnter term://* setlocal nonumber norelativenumber
"     autocmd BufWinEnter,WinEnter term://* startinsert
" augroup END

"=================================
"		    Mappings
"=================================

" Different leader key
let mapleader=','

" Search and destroy
nno \ :Abolish -search
nno ? :Abolish! -search
nno s :%s/
vno s :s/
nno S :%S/
vno S :S/

" Help file vsplit on search
nmap <S-K> <S-K><C-W><S-L><C-W>|

" Reload this config file
nno <silent> <leader>R :source ~/.vimrc<CR> :echo "Vimrc configuration reloaded..."<CR>

" Save file
nmap <silent> <leader>, :w<CR>

" Save&Close file
nmap <silent> <leader>w :x<CR>

" Hide window
nno <silent> <leader>h :hide<CR>

" Hide other windows
nno <silent> <leader>o :only<CR>

" Quit!
nmap <silent> <leader>q :q!<CR>
nno <silent> <C-D> :q!<CR>

" New tab
nmap <silent> <leader>t :tabe %<CR>

" Open terminal
nmap <silent> <leader>z :terminal<CR>

" Switch between current and last buffer
nmap <silent> <Leader>. <C-^>

" Buffers
nmap <Leader>b :sb 
" Arguments-list
nmap <Leader>a :arg 

" Semi-colon to colon in Normal Mode
nno ; :

" Make C-U act like u
ino <C-U> <C-G>u<C-U>

" Make C-C act like esc in Insertmode (terminal also)
ino <C-C> <ESC>:echo<CR>
tno <C-c> <C-\><C-N>

" Start Vimgolf
nno <silent> <leader>G :call GolfStart()<CR>

" Run compiler for current file
nno <silent> <leader>m :Dispatch!<CR>

" Syntax checking command (syntastic)
nno <silent> <leader>cs :SyntasticCheck<CR>
nno <silent> <leader>cr :SyntasticReset<CR>
nno <silent> <leader>ci :SyntasticInfo<CR>
nno <silent> <leader>ce :Errors<CR>
nno <silent> <leader>co :lopen<CR>
nno <silent> <leader>ct :SyntasticToggleMode<CR>

" Git commands (vim-fugitive)
nno <silent> <leader>gs :Gstatus<CR>
nno <silent> <leader>gp :Gpush<CR>
nno <silent> <leader>ga :Gwrite<CR>
nno <silent> <leader>gr :Gread<CR>
nno <silent> <leader>gc :Gcommit<CR>
nno <silent> <leader>gb :Gblame!<CR>
nno <silent> <leader>gd :Gremove<CR>
nno <silent> <leader>gm :Gmove<CR>

" Window movement and tiling
nmap <C-H> <C-W>W
nmap <C-L> <C-W>w
tmap <C-H> <C-c><C-W>W
tmap <C-L> <C-c><C-W>w
nno <C-W>v <C-W><C-V><C-W>l
nno <C-W>s <C-W><C-S><C-W>j
tmap <C-W><C-V> <C-c><C-W><C-V>
tmap <C-W><C-S> <C-c><C-W><C-S>

" Increment with C-K (iso C-A tmux)
nno <C-K> <C-A>

" Scroll faster with C-E and C-Y
nno <C-E> 2<C-E>
nno <C-Y> 2<C-Y>

" Command & Insert-mode mapping
cmap <C-D> <Del>
imap <C-D> <Del>
imap <C-B> <ESC>0i

" Edit vimrc, gitconfig, tmux.conf, zshrc, bashrc and aliases
" In current window
nmap <leader>ev :e ~/.vimrc<CR>
nmap <leader>ec :e ~/.vim/colors/sthew.vim<CR>
nmap <leader>eg :e ~/.gitconfig<CR>
nmap <leader>et :e ~/.tmux.conf<CR>
nmap <leader>ez :e ~/.zshrc<CR>
nmap <leader>eb :e ~/.bashrc<CR>
nmap <leader>ea :e ~/.aliases<CR>
nmap <leader>en :new<CR>:only<CR>
" In new tab
" nmap <leader>tv :tabe ~/.vimrc<CR>
" nmap <leader>tc :tabe ~/.vim/colors/sthew.vim<CR>
" nmap <leader>tg :tabe ~/.gitconfig<CR>
" nmap <leader>tt :tabe ~/.tmux.conf<CR>
" nmap <leader>tz :tabe ~/.zshrc<CR>
" nmap <leader>tb :tabe ~/.bashrc<CR>
" nmap <leader>ta :tabe ~/.aliases<CR>
" nmap <leader>tn :tabnew<CR>

" Press Space to turn off highlighted search
" and clear any message already displayed.
nno <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Remove extra whitespace
nmap <silent> <leader><space> :%s/\s\+$<cr>
" nmap <leader><space><space> :%s/\s*\n//g<cr>

" Check syntax highlighting group under the cursor

" Map function key's
nmap <f1> :Gstatus<CR>
nmap <f2> :0Glog<CR>
" nmap <silent> <f3>
nmap <f4> :Gcommit<CR>
nmap <f5> :SyntasticCheck<CR>
nmap <f6> :SyntasticReset<CR>
nmap <silent> <f7> :py3 import vim, random; vim.current.line += str(random.randint(0, 9)) <CR>
nmap <f8> :set invpaste<CR>
" nmap <silent> <f9>
nmap <silent> <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" nmap <silent> <f11>
" nmap <silent> <f12>

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
