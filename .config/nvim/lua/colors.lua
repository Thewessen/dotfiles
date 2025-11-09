local cmd = vim.cmd

cmd('set notermguicolors')
cmd('colorscheme sthew')

-- lsp signs
cmd('sign define LspDiagnosticsSignError text=x texthl=LspDiagnosticsSignError linehl= numhl=')
cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
cmd('sign define LspDiagnosticsSignInformation text=? texthl=LspDiagnosticsSignInformation linehl= numhl=')
cmd('sign define LspDiagnosticsSignHint text=> texthl=LspDiagnosticsSignHint linehl= numhl=')
