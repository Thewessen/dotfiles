local set = vim.api.nvim_set_var

set('bclose_no_plugin_maps', true)

set('fzf_buffers_jump', true)

set('dispatch_no_maps', true)
set('dispatch_terminal_exec', 'zsh')

set('ale_linters', {
	javascript = {'eslint'},
	typescript = {'eslint'},
	javascriptreact = {'eslint'},
	typescriptreact = {'eslint'},
  php = {'phpcs'}
})
set('ale_fixers', {
  javascript = {'prettier'},
	typescript = {'prettier'},
	javascriptreact = {'prettier'},
	typescriptreact = {'prettier'},
  php = {'phpcs'},
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'}
})
set('ale_sign_error', '✘')
set('ale_sign_warning',  '⚠')
set('ale_php_cs_fixer_use_global', true)
set('ale_php_cs_standard', 'PSR2')

set('neosnippet#snippets_directory', {'$HOME/.config/nvim/snippets'})
set('neosnippet#disable_runtime_snippets', {_ = true})

set('user_emmet_leader_key', '<c-n>')
set('user_emmet_mode', 'i')
set('user_emmet_install_global', false)
