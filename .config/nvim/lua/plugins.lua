vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- package manager
	use 'wbthomason/packer.nvim'

  -- lua helpers
  use 'nvim-lua/plenary.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]] }
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'


	-- file/buffer-browser
	use {'junegunn/fzf.vim', requires = {'junegunn/fzf', run = function() vim.fn['fzf#intall']() end}}
  use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/popup.nvim'}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

  -- lsp
  use {'hrsh7th/nvim-cmp', requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline'
  }}

	-- tpope is king
	use 'tpope/vim-dispatch'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-fugitive'
	-- use 'tpope/vim-repeat'
	use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
	use 'tpope/vim-ragtag'

	-- coding helpers
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'

	use {
		'w0rp/ale',
		cmd = 'ALEToggle',
		config = 'vim.cmd[[ALEEnable]]'
	}
  -- use {'mattn/emmet-vim', ft = {'javascriptreact','typescriptreact','html'}, config = 'vim.cmd[[EmmetInstall]]'}
  use {
    'phpactor/phpactor',
    ft = {'php'},
    run = 'composer install --no-dev -o'
  }

  -- tests
  use 'vim-test/vim-test'

  -- databases
  use 'tpope/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'
  use 'kristijanhusak/vim-dadbod-completion'
end)
