vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- package manager
	use 'wbthomason/packer.nvim'

  -- github copilot
  use 'github/copilot.vim'
  -- ChatGPT
  use {
     'dpayne/CodeGPT.nvim',
     requires = {
        'MunifTanjim/nui.nvim',
        'nvim-lua/plenary.nvim',
     },
     config = function()
        require('codegpt.config')

        vim.g["codegpt_openai_api_key"] = vim.env['AZURE_OPENAI_KEY']
        vim.g["codegpt_chat_completions_url"] = "https://devdiasopenai.openai.azure.com/openai/deployments/GPT-35-Turbo/chat/completions?api-version=2024-02-15-preview"
        vim.g["codegpt_openai_api_provider"] = "Azure"
     end
  }

  -- lua helpers
  use 'nvim-lua/plenary.nvim'

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]] }
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'

	-- file/buffer-browser
	use {'junegunn/fzf.vim', requires = {'junegunn/fzf', run = function() vim.fn['fzf#intall']() end}}

  -- lsp
  -- use 'ms-jpq/coq_nvim'
  -- use 'ms-jpq/coq.artifacts'

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
  use 'tpope/vim-dadbod'

	-- coding helpers
  use {
    'phpactor/phpactor',
    ft = {'php'},
    run = 'composer install --no-dev -o'
  }

  -- tests
  use 'vim-test/vim-test'

  -- databases
  use 'kristijanhusak/vim-dadbod-ui'
  use 'kristijanhusak/vim-dadbod-completion'

  -- git
  use 'lewis6991/gitsigns.nvim'

  -- colors
  use 'folke/tokyonight.nvim'
end)
