-- Options have to be set either global, or local
-- if options are set local, the also have to be set global
-- this is unwanted behaviour and should be fixed in:
-- https://github.com/neovim/neovim/pull/13479

-- for now we add a little helper
local scopes = {g = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'g' then scopes['g'][key] = value end
end

opt('g', 'hidden', true)
opt('g', 'updatetime', 500)
opt('g', 'showmode', false)
opt('g', 'showcmd', true)
opt('g', 'autoread', true)
opt('g', 'background', 'light')

opt('g', 'completeopt', 'menu,menuone,noselect')
opt('g', 'shortmess', vim.api.nvim_get_option('shortmess') .. 'cW')
opt('g', 'clipboard', 'unnamedplus')
opt('g', 'inccommand', 'split')

opt('w', 'signcolumn', 'yes:1')
opt('w', 'scrolloff', 3)
opt('w', 'sidescrolloff', 5)
opt('w', 'wrap', false)

opt('b', 'expandtab', true)
opt('b', 'tabstop', 2)
opt('b', 'shiftwidth', 0)
opt('b', 'textwidth', 80)
