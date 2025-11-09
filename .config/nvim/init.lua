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
require('linkcolors')
require('leader-mappings')
require('other-mappings')
require('lsp')
require('work-related')
require('edit-config')
require('edit-notes')
require('docker')
require('obsidian-tags')
