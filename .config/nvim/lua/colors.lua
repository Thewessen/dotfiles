local cmd = vim.cmd
local hl = vim.api.nvim_set_hl

cmd('colorscheme sthew')

-- lsp signs
cmd('sign define LspDiagnosticsSignError text=x texthl=LspDiagnosticsSignError linehl= numhl=')
cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
cmd('sign define LspDiagnosticsSignInformation text=? texthl=LspDiagnosticsSignInformation linehl= numhl=')
cmd('sign define LspDiagnosticsSignHint text=> texthl=LspDiagnosticsSignHint linehl= numhl=')

-- highlight
cmd('hi Delimiter ctermfg=102')

hl(0, "@property", { link = "Normal" })
hl(0, "@parameter", { link = "Normal" })
hl(0, "@variable", { link = "Normal" })
hl(0, "@constant", { link = "Constant" })
hl(0, "@variable.declarator", { link = "Identifier" })
hl(0, "@variable.name", { link = "Normal" })
hl(0, "@tag.attribute", { link = "Normal" })
hl(0, "@tag.delimiter", { link = "Noise" })

-- lua
hl(0, "@field.lua", { link = "Normal" })
hl(0, "@function.builtin.lua", { link = "Function" })
hl(0, "@constructor.lua", { link = "Noise" })
