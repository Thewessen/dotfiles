local lspconfig = require('lspconfig')
local root_pattern = lspconfig.util.root_pattern

local lsp_attach = function ()
  -- vim.api.nvim_command('autocmd CursorHold * lua vim.lsp.buf.hover()')
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '<c-k>', [[<cmd>lua require'lsp-info'.info()<cr>]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('completion').on_attach()
end

-- vim
lspconfig.vimls.setup{
  cmd = {'vim-language-server', '--stdio'},
  on_attach = lsp_attach,
  filetypes = {'vim'}
}

-- js/ts
lspconfig.tsserver.setup{
  cmd = {'typescript-language-server', '--stdio'},
  on_attach = lsp_attach,
  filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
  root_dir = root_pattern('package.json', 'tsconfig.json', '.git')
}

-- php
lspconfig.phpactor.setup{
  cmd = {'phpactor', 'language-server'},
  on_attach = lsp_attach,
  root_dir = root_pattern('composer.json', '.git')
}

-- lua
local sumneko_path = vim.env.HOME .. '/.local/lua-language-server'
lspconfig.sumneko_lua.setup{
  cmd = {sumneko_path .. '/bin/macOs/lua-language-server', '-E', sumneko_path .. '/main.lua'},
  on_attach = lsp_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim','hs','dump'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        }
      },
      telemetry = {
        enable = false,
      }
    }
  }
}
