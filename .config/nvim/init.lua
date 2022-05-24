local cmd = vim.cmd
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- TODO: create module for personal lua functions
function _G.lsp_info()
  local diag = vim.lsp.diagnostic.get_line_diagnostics()
  if next(diag) ~= nil then
    vim.cmd('3split new')
    vim.api.nvim_buf_set_lines(0, 0, 0, { diag.message }, nil)
  end
end

require('plugins')
require('plugin-options')
require('options')
require('colors')
require('commands')
require('autocommands')
require('leader-mappings')
require('other-mappings')
require('lsp')
require('work-related')

-- A vim.api for creating user command is on its way
-- https://github.com/neovim/neovim/pull/11613
-- cmd('source ~/.config/nvim/commands.vim')

-- A vim.api for creating autocommand is on its way
-- https://github.com/neovim/neovim/pull/11613
cmd('source ~/.config/nvim/autocommands.vim')

-- some more fancy custom commands (fzf)
cmd('source ~/.config/nvim/docker.vim')
cmd('source ~/.config/nvim/edit-config.vim')
cmd('source ~/.config/nvim/start-queue.vim')
