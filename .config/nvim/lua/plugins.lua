vim.cmd [[packadd packer.nvim]]

package.path = package.path .. ';./plugin-configs/'

return require('packer').startup(function(use)
	-- package manager
	use 'wbthomason/packer.nvim'

  -- autocompletion
  use {'neoclide/coc.nvim', branch = 'release'}
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
  use {
    'nvim-treesitter/nvim-treesitter',
    run = [[:TSUpdate]],
  }
  use 'nvim-treesitter/playground'
  use 'neovim/nvim-lspconfig'

	-- file/buffer-browser
	use {
    'junegunn/fzf.vim',
    requires = {
      'junegunn/fzf',
      run = function() vim.fn['fzf#intall']() end
    }
  }

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
    ft = 'php',
    run = 'composer install --no-dev -o'
  }

  -- tests
  use {
    'vim-test/vim-test',
    cmd = { 'TestFile' },
    config = function()
      vim.g['test#strategy'] = 'dispatch'
      vim.g['test#php#phpunit#executable'] = 'dre ./vendor/bin/phpunit'
      vim.g['test#javascript#jest#options'] = '--watch'
      -- vim.api.nvim_set_var('test#strategy', 'dispatch')
    end,
    opt = true
  }

  -- databases
  use {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_save_location = '~/db_ui_queries'
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_show_help = false
      vim.g.db_ui_force_echo_notifications = true
    end
  }
  use 'kristijanhusak/vim-dadbod-completion'

  -- git
  use 'lewis6991/gitsigns.nvim'
end)
