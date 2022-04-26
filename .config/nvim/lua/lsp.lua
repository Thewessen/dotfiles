local lspconfig = require('lspconfig')
local root_pattern = lspconfig.util.root_pattern
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_attach = function (client)
  local opt = {buffer = true, noremap = true, silent = true}
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opt)
  vim.keymap.set('n', 'K', vim.lsp.diagnostic.show_line_diagnostics, opt)
  vim.keymap.set('v', 'F', vim.lsp.buf.range_formatting, opt)
  vim.keymap.set('n', '<c-k>', require'functions'.lsp_info, opt)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
  print('lsp attached: ' .. client.name)
end

-- vim
lspconfig.vimls.setup{
  cmd = {'vim-language-server', '--stdio'},
  on_attach = lsp_attach,
  filetypes = {'vim'},
  -- capabilities = capabilities,
}

-- js/ts
lspconfig.tsserver.setup{
  cmd = { 'typescript-language-server', '--stdio' },
  on_attach = lsp_attach,
  filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
  root_dir = root_pattern('package.json', 'tsconfig.json', '.git'),
  -- capabilities = capabilities,
}

-- php
lspconfig.phpactor.setup{
  cmd = {'phpactor', 'language-server'},
  on_attach = lsp_attach,
  root_dir = root_pattern('composer.json', '.git'),
  -- capabilities = capabilities,
}

-- python
lspconfig.pylsp.setup{
  cmd = { "pylsp" },
  on_attach = lsp_attach,
  filetypes = { "python" },
  root_dir = root_pattern('requirements.txt', '.git'),
  single_file_support = true,
}

-- lua
local sumneko_path = vim.env.HOME .. '/.local/lua-language-server'
lspconfig.sumneko_lua.setup{
  cmd = {sumneko_path .. '/bin/macOs/lua-language-server', '-E', sumneko_path .. '/main.lua'},
  on_attach = lsp_attach,
  -- capabilities = capabilities,
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

-- json
lspconfig.jsonls.setup{
    cmd = { "vscode-json-language-server", "--stdio" },
    on_attach = lsp_attach,
    filetypes = { "json" },
    init_options = {
      provideFormatter = true
    },
    root_dir = root_pattern('package.json', 'tsconfig.json', '.git'),
    single_file_support = true,
}

-- css
lspconfig.cssls.setup{
  cmd = { 'vscode-css-language-server', '--stdio' },
  on_attach = lsp_attach,
  filetypes = { 'css', 'scss', 'less' },
  root_dir = root_pattern('package.json', 'tsconfig.json', '.git'),
  single_file_support = true,
}
