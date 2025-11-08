-- Use nvim-cmp capabilities for better completion integration
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_attach = function (client)
  local opt = {buffer = true, noremap = true, silent = false}
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, opt)
  vim.keymap.set('n', 'K', vim.diagnostic.open_float, opt)
  vim.keymap.set('v', 'F', vim.lsp.buf.format, opt)
  vim.keymap.set('n', '<c-k>', require'functions'.lsp_info, opt)
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

-- vim
vim.lsp.config('vimls', {
  cmd = {'vim-language-server', '--stdio'},
  on_attach = lsp_attach,
  filetypes = {'vim'},
  capabilities = capabilities,
})

-- js/ts
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  on_attach = lsp_attach,
  filetypes = {'javascript', 'javascript.jsx', 'typescript', 'javascriptreact', 'typescriptreact', 'typescript.tsx'},
  root_markers = {'package.json', 'tsconfig.json', '.git'},
  init_options = {
    hostInfo = 'neovim',
  },
  capabilities = capabilities,
})

-- php
vim.lsp.config('phpactor', {
  cmd = {'phpactor', 'language-server'},
  filetypes = {'php'},
  on_attach = lsp_attach,
  root_dir = function(fname)
    -- fname can be a buffer number or a file path
    local actual_fname = fname
    if type(fname) == 'number' then
      actual_fname = vim.api.nvim_buf_get_name(fname)
    end
    -- Return nil if no valid file name
    if not actual_fname or actual_fname == '' then
      return nil
    end
    local util = require('lspconfig.util')
    return util.root_pattern('.phpactor.json', 'composer.json', '.git')(actual_fname)
  end,
  capabilities = capabilities,
})

-- python
vim.lsp.config('pylsp', {
  cmd = { "pylsp" },
  on_attach = lsp_attach,
  filetypes = { "python" },
  root_dir = {'requirements.txt', '.git'},
  single_file_support = true,
  capabilities = capabilities,
})

-- lua
vim.lsp.config('lua_ls', {
  cmd = {"lua-language-server"},
  on_attach = lsp_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim', 'hs', 'dump'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  }
})

-- json
vim.lsp.config('jsonls', {
  cmd = { "vscode-json-languageserver", "--stdio" },
  on_attach = lsp_attach,
  filetypes = { "json" },
  init_options = {
    provideFormatter = true
  },
  root_dir = {'package.json', 'tsconfig.json', '.git'},
  single_file_support = true,
  capabilities = capabilities,
})

-- css
vim.lsp.config('cssls', {
  cmd = { 'vscode-css-language-server', '--stdio' },
  on_attach = lsp_attach,
  filetypes = { 'css', 'scss', 'less' },
  root_dir = {'package.json', 'tsconfig.json', '.git'},
  single_file_support = true,
  capabilities = capabilities,
})

-- markdown (for Obsidian back references)
vim.lsp.config('marksman', {
  cmd = { 'marksman', 'server' },
  on_attach = lsp_attach,
  filetypes = { 'markdown', 'md' },
  root_dir = {'.git', '.marksman.toml'},
  single_file_support = true,
  capabilities = capabilities,
})
