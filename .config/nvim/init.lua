local cmd = vim.cmd
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

vim.loader.enable()

-- Load .env file before plugins
require('dotenv').setup()
require('plugins')
require('plugin-options')
require('options')
require('commands')
require('autocommands')
require('colors')
require('leader-mappings')
require('other-mappings')
require('lsp')
require('work-related')

cmd('source ~/.config/nvim/vimscript/linkcolors.vim')

-- A vim.api for creating autocommand is on its way
-- https://github.com/neovim/neovim/pull/11613
cmd('source ~/.config/nvim/vimscript/autocommands.vim')

-- some more fancy custom commands (fzf)
cmd('source ~/.config/nvim/vimscript/docker.vim')
cmd('source ~/.config/nvim/vimscript/edit-config.vim')
cmd('source ~/.config/nvim/vimscript/start-queue.vim')
cmd('source ~/.config/nvim/vimscript/quickfix-fzf.vim')
