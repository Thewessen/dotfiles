vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- File browser like netrw
  use 'justinmk/vim-dirvish'

  -- LSP code completer
  use 'neoclide/coc.nvim'

  -- Change surroundings (command: {d,c,y}s{text object})
  use 'tpope/vim-surround'

  -- Comment out (command: gcc)
  use 'tpope/vim-commentary'

  -- FZF fuzzy filesearch in vim, like ctrlp
  use 'junegunn/fzf.vim'

  -- FZF plugin for vim
  use 'junegunn/fzf'

  -- Git from inside vim
  use 'tpope/vim-fugitive'

  -- Extends '.' command for plugins
  use 'tpope/vim-repeat'

  -- Abbriviations, '{}' substitution, and coercion
  use 'tpope/vim-abolish'

  -- ctags management
  use {
    'ludovicchabant/vim-gutentags',
    cmd='GutentagsUpdate!'
  }

  -- Async linter and completer
  use {
    'w0rp/ale',
    ft = {
      'sh',
      'zsh',
      'bash',
      'javascript',
      'jsx',
      'typescript',
      'php',
      'css',
      'html',
      'reason',
      'python',
      'rust',
      'vue'
    },
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- LSP for php
  use {
    'phpactor/phpactor',
    ft = 'php',
    run = 'composer install --no-dev -o'
  }

  -- Snippets
  use 'Shougo/neosnippet.vim'

  -- Snippets depending on context filetype
  use {
    'Shougo/context_filetype.vim',
    ft = 'vue'
  }

  -- Curl wrapper
  -- TODO: only needed in specific buffer... need to create a plugin
  use 'nicwest/vim-http'

  -- Automatically create, restore and update Sessions
  use 'tpope/vim-obsession'

  -- '[' and ']' mappings
  use 'tpope/vim-unimpaired'

  -- Other cool mappings
  use 'tpope/vim-ragtag'

  -- Async vim-compilers (tmux,gui,windows)
  use {
    'tpope/vim-dispatch',
    ft = { 'javascript', 'jsx', 'typescript', 'vue', 'reason', 'rust', 'php', 'python' },
    cmd = 'Dispatch'
  }

  -- Quickly make multiple changes
  use 'dyng/ctrlsf.vim'                

  -- Auto lcd to root of project (see configs)
  use 'airblade/vim-rooter'

  -- Extends '%' (jump html-tag, etc.)
  use 'adelarsq/vim-matchit'

  -- Super fast html skeletons
  use {
    'mattn/emmet-vim',
    ft = { 'javascript', 'html', 'jsx', 'typescript', 'vue' }
  }

  -- Typescript syntax
  use 'leafgarland/typescript-vim'

  -- Javascript indention and syntax
  use 'pangloss/vim-javascript'

  -- JSX syntax highlighting (React way of HTML in Javascript)
  use 'MaxMEllon/vim-jsx-pretty'

  -- PHP blade highlighting syntax
  use 'jwalton512/vim-blade'

  -- Better HTML syntax
  use 'othree/html5-syntax.vim'

  -- Vue syntax highlighting
  use 'posva/vim-vue'

  -- CSS3 syntax
  use 'hail2u/vim-css3-syntax'

  -- Reasonml support
  use 'reasonml-editor/vim-reason-plus'

  -- Twig highlighting
  use 'lumiliet/vim-twig'

  -- Haskell indention and syntax
  use 'neovimhaskell/haskell-vim'

  -- rust helpfull toolchain
  use 'rust-lang/rust.vim'

  -- toml syntax highlighting
  use 'cespare/vim-toml'
end)

