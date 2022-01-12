local set = vim.api.nvim_set_var

set('bclose_no_plugin_maps', true)

set('fzf_buffers_jump', true)
set('fzf_preview_window', { 'up:70%' })

set('dispatch_no_maps', true)
set('dispatch_terminal_exec', 'zsh')

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
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
