local map = vim.api.nvim_set_keymap

-- shortkeys
map('n', '<space>', '<cmd>nohlsearch<cr><cmd>echo<cr>', { noremap = true, silent = true })
map('n', 's', ':%s/', { noremap = true })
map('v', 's', ':s/', { noremap = true })
map('n', 'Y', 'y$', { noremap = true })
map('n', '<c-e>', '31<c-e>', { noremap = true })
map('n', '<c-u>', '31<c-u>', { noremap = true })
map('n', '<c-l>', '<c-w>w', { noremap = true })
map('t', '<c-l>', '<c-\\><c-n><c-w>w', { noremap = true })
map('n', '<c-h>', '<c-w>W', { noremap = true })
map('t', '<c-h>', '<c-\\><c-n><c-w>W', { noremap = true })
map('n', '<c-d>', '<cmd>q<cr>', { noremap = true })
map('t', '<c-[>', '<c-\\><c-n>', { noremap = true })
map('n', '<F10>', '<cmd>TSHighlightCapturesUnderCursor<cr>', { noremap = true, silent = true })

-- plugins
map('n', '<c-p>', '<cmd>Files<cr>', { noremap = true, silent = true })
map('n', '-', '<cmd>RangerOpenCurrentFile<cr>', { noremap = true, silent = true })
map('n', '\\', ':Abolish -search<space>', { noremap = true })
map('n', '?', ':Abolish! -search<space>', { noremap = true })
map('n', 'S', ':%S/', { noremap = true})
map('v', 'S', ':S/', { noremap = true})
map('i', '<c-t>', '<plug>(neosnippet_expand_or_jump)', {})
map('s', '<c-t>', '<plug>(neosnippet_expand_or_jump)', {})
map('x', '<c-t>', '<plug>(neosnippet_expand_target)', {})
