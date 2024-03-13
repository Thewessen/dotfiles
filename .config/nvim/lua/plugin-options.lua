local set = vim.api.nvim_set_var

-- completion
-- set('coq_settings', {
--   auto_start = 'shut-up',
--   keymap = {
--     jump_to_mark = '<c-t>'
--   }
-- })

-- lsp
set('lsp_log_verbose', true)
set('lsp_log_file', '~/lsp.log')

set('bclose_no_plugin_maps', true)

set('fzf_buffers_jump', true)
set('fzf_preview_window', { 'up:70%' })

set('dispatch_no_maps', true)
set('dispatch_terminal_exec', 'zsh')

set('test#strategy', 'neovim')
set('test#php#phpunit#executable', 'dre ./vendor/bin/phpunit')
set('test#javascript#jest#options', '--watch')

set('ale_linters', {
	javascript = {'eslint'},
	typescript = {'eslint'},
	javascriptreact = {'eslint'},
	typescriptreact = {'eslint'},
  php = {'phpcs'},
  json = {'eslint'},
})
set('ale_fixers', {
  javascript = {'prettier'},
	typescript = {'prettier'},
	javascriptreact = {'prettier'},
	typescriptreact = {'prettier'},
  php = {'phpcs'},
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'}
})
set('ale_sign_error', '✘')
set('ale_sign_warning',  '⚠')
set('ale_php_cs_fixer_use_global', true)
set('ale_php_cs_standard', 'PSR2')

set('ranger_replace_netrw', 0)

set('db_ui_show_database_icon', true)
set('db_ui_save_location', '~/db_ui_queries')
set('db_ui_use_nerd_fonts', true)
set('db_ui_show_help', false)
set('db_ui_force_echo_notifications', true)

set('netrw_browse_split', 0)

-- gitsigns config
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- -- Actions
    -- map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    -- map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    -- map('n', '<leader>hS', gs.stage_buffer)
    -- map('n', '<leader>hu', gs.undo_stage_hunk)
    -- map('n', '<leader>hR', gs.reset_buffer)
    -- map('n', '<leader>hp', gs.preview_hunk)
    -- map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    -- map('n', '<leader>tb', gs.toggle_current_line_blame)
    -- map('n', '<leader>hd', gs.diffthis)
    -- map('n', '<leader>hD', function() gs.diffthis('~') end)
    -- map('n', '<leader>td', gs.toggle_deleted)

    -- -- Text object
    -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}


-- treesitter config
require'nvim-treesitter.configs'.setup{
  auto_install = false,
  sync_install = false,
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["@parameter"] = "Normal",
    },
  },
  indent = { enable = true },
  textobjects = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "vv",
      node_incremental = ".",
      scope_incremental = "gs",
      node_decremental = ",",
    },
  }
}
