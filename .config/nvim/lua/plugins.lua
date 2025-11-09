local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  -- file explorer
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
   -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind-nvim', -- for vscode-like icons
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
    },
  },

  -- lsp
  {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev -o'
  },
  'EmranMR/tree-sitter-blade',

   -- github copilot
  'github/copilot.vim',

  -- Cursor like AI
  {
    'harjotgill/CodeGPT.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
        require("codegpt.config")
        vim.g["codegpt_openai_api_key"] = vim.env['AZURE_OPENAI_API_KEY']
        vim.g["codegpt_chat_completions_url"] = "https://dev-sw-ao.openai.azure.com/openai/deployments/GPT-35-Turbo/chat/completions?api-version=2024-02-15-preview"
        vim.g["codegpt_openai_api_provider"] = "Azure"
    end
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    behavior = {
      auto_apply_diff_after_generation = true,
    },
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  'nvim-treesitter/playground',
  'neovim/nvim-lspconfig',

  -- lua helpers
  'nvim-lua/plenary.nvim',

  -- file/buffer-browser
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },
  -- {
  --   'junegunn/fzf.vim',
  --   dependencies = {
  --     'junegunn/fzf',
  --     build = "./install --all"
  --   },
  -- },

  -- render markdown
  {
    -- Make sure to set this up properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },

  -- tpope is king
  'tpope/vim-dispatch',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  -- 'tpope/vim-repeat'
  'tpope/vim-abolish',
  'tpope/vim-unimpaired',
  'tpope/vim-vinegar',
  'tpope/vim-ragtag',
  'tpope/vim-dadbod',

  -- -- rest client
  -- {
  --   "rest-nvim/rest.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     opts = function (_, opts)
  --       opts.ensure_installed = opts.ensure_installed or {}
  --       table.insert(opts.ensure_installed, "http")
  --     end,
  --   }
  -- },
  -- databases
  {
    'kristijanhusak/vim-dadbod-ui',
    config = function()
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_save_location = '~/db_ui_queries'
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_show_help = false
      vim.g.db_ui_force_echo_notifications = true
    end
  },
  'kristijanhusak/vim-dadbod-completion',
  'pbogut/vim-dadbod-ssh',

  -- git
  'lewis6991/gitsigns.nvim',

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false, -- Altijd laden, statusline is essentieel
  },

  -- tests
  {
    'vim-test/vim-test',
    cmd = { 'TestFile' },
    config = function()
      vim.g['test#strategy'] = 'dispatch'
      vim.g['test#php#phpunit#executable'] = 'dre ./vendor/bin/phpunit'
      vim.g['test#javascript#jest#options'] = '--watch'
      -- vim.api.nvim_set_var('test#strategy', 'dispatch')
    end,
    optional = true
  },

  -- snippets

  'hrsh7th/vim-vsnip',

  -- macro management
  'kr40/nvim-macros',

  -- note-taking
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  },
})
