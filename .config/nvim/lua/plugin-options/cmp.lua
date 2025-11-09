local cmp = require'cmp'
local lspkind = require('lspkind')

require("onedrive").register_cmp_source()
require("zshbookmarks").register_cmp_source()

-- Global setup.
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- mapping conflicts with other autocompletion plugins
    -- ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth
    })
  },
  sources = {
    { name = 'onedrive' }, -- Custom source for OneDrive
    { name = 'obsidian' },
    { name = 'obsidian_tags' },
    { name = 'obsidian_new' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'vsnip' },
  },
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'zshbookmarks', group_index = 1 }, -- Custom source for Zsh bookmarks
    { name = 'path', group_index = 1 },
    { name = 'cmdline', group_index = 2, option = { ignore_cmds = require('zshbookmarks').ignore_cmds } },
  },
  matching = { disallow_symbol_nonprefix_matching = false }
})
