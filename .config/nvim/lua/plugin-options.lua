local set = vim.api.nvim_set_var

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

set('vsnip_snippet_dir', '$HOME/.config/nvim/snippets')
set('vsnip_filetypes', {
  javascriptreact = {'commonjs'},
  typescriptreact = {'commonjs'},
  javascript = {'commonjs'},
  typescript = {'commonjs'},
})

set('user_emmet_leader_key', '<c-n>')
set('user_emmet_mode', 'i')
set('user_emmet_install_global', false)

set('ranger_replace_netrw', 0)

set('db_ui_show_database_icon', true)
set('db_ui_use_nerd_fonts', true)
set('db_ui_show_help', false)
set('db_ui_force_echo_notifications', true)

set('netrw_browse_split', 0)

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<c-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<c-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<c-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<c-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- treesitter config
require'nvim-treesitter.configs'.setup{
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
    custom_captures = {
      ["exclude"] = "PreProc",
      ["tag"] = "Tag",
      ["function"] = "Function",
      ["variable.name"] = "Normal",
      ["object.name"] = "Normal",
      ["variable.declarator"] = "Type",
    }
  },
  indent = { enable = true },
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

