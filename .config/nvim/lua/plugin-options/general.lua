local set = vim.api.nvim_set_var

-- lsp
set('lsp_log_verbose', true)
set('lsp_log_file', '~/lsp.log')

-- copilot
-- set('copilot_no_tab_map', true)

set('bclose_no_plugin_maps', true)

set('fzf_buffers_jump', true)
set('fzf_preview_window', { 'up:70%' })

set('dispatch_no_maps', true)
set('dispatch_terminal_exec', 'zsh')

set('netrw_browse_split', 0)

set('vsnip_snippet_dir', vim.fn.stdpath('config') .. '/snippets')
