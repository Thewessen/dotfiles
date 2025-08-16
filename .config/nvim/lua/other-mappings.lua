local map = vim.api.nvim_set_keymap
local function t(str)
  -- replaces given str with '<Tab>' with '\42Tab\x10' (or something)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- shortkeys
map('n', '<space>', '<cmd>nohlsearch<cr><cmd>echo<cr>', { noremap = true, silent = true })
map('n', 's', ':%s/', { noremap = true })
map('v', 's', ':s/', { noremap = true })
map('n', 'Y', 'y$', { noremap = true })
map('n', '<c-e>', '31<c-e>', { noremap = true })
map('n', '<c-u>', '31<c-u>', { noremap = true })
map('n', '<c-l>', '<c-w>w', { noremap = true })
map('n', 'gx', [[:silent execute '!open '.shellescape('<cWORD>')<CR>]], { noremap = true })
map('t', '<esc>', '<c-\\><c-n>', { noremap = true })
map('n', '<c-h>', '<c-w>W', { noremap = true })
map('t', '<c-\\>', '<c-\\><c-n>', { noremap = true })
map('n', '<c-d>', '<cmd>q<cr>', { noremap = true })
map('n', '<F10>', '<cmd>TSHighlightCapturesUnderCursor<cr>', { noremap = true, silent = true })
map('n', '<F11>', '<cmd>TSPlaygroundToggle<cr>', { noremap = true, silent = true })

-- plugins
map('n', '<c-p>', '<cmd>FzfLua files<cr>', { noremap = true, silent = true })
map('n', '\\', ':Abolish -search<space>', { noremap = true })
map('n', '?', ':Abolish! -search<space>', { noremap = true })
map('n', 'S', ':%S/', { noremap = true})
map('v', 'S', ':S/', { noremap = true})
-- map('i', '<c-k>', 'copilot#Accept("<CR>")', { noremap = true, silent = true, expr = true, script = true })
map('i', '<c-j>', '<cmd>Copilot panel<CR>', { noremap = true, silent = true, expr = true, script = true })

-- coc.nvim
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- map("i", "<C-k>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
map("i", "<C-l>", [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], opts)
