" ==================================================================
" =============== S. Thewessen vim-color links =====================
" ==================================================================

hi! link @parameter Normal
hi! link @property Normal
hi! link @variable Normal
hi! link @type Type
hi! link @constructor Operator
hi! link @tag.attribute Normal
hi! link @tag.delimiter Noise
hi! link @tag.builtin @tag
hi! link @punctuation.special Noise
hi! link @punctuation.bracket Noise

hi! link @lsp.type.parameter Normal
hi! link @lsp.type.property Normal
hi! link @lsp.type.variable Normal

" hi link typescriptObjectLabel Normal
" hi link typescriptObjectMethod Normal
hi link typescriptMember typescriptObjectLabel
hi link typescriptInterfaceName Normal
hi link typescriptArrayMethod Function
" hi link typescriptBOMWindowProp Normal
" hi link typescriptBOMLocationMethod Normal
" hi link typescriptDOMDocProp Normal
" hi link typescriptDOMDocMethod Normal
hi link typescriptVariable Type
hi link typescriptImport PreProc
hi link typescriptExport typescriptImport
" hi link typescriptNodeGlobal Special
hi link typescriptBraces Noise
hi link typescriptParens Noise
hi link typescriptTemplateSB Noise
hi link typescriptTypeReference Special

hi link tsxTagName Operator
hi link tsxAttrib Normal
hi link tsxTag Noise

hi link jsxAttrib Normal
hi link jsxComponentName Operator
hi link jsxBraces Noise

hi link LspDiagnosticsDefaultHint ToDo
hi link LspDiagnosticsDefaultWarning ToDo
hi link LspDiagnosticsDefaultError Error

hi link jsonBraces Noise


hi link diffAdded Function

hi link CocMenuSel CocListBgWhite

hi link RenderMarkdownH1Bg Title
hi link RenderMarkdownH2Bg Title
hi link RenderMarkdownH3Bg Title
hi link RenderMarkdownH4Bg Title
hi link RenderMarkdownH5Bg Title
hi link RenderMarkdownCode Visual

" lualine.nvim highlight links
" Link alle lualine highlight groups naar StatusLine kleuren uit sthew.vim
" Actieve statusline secties
hi! link lualine_a_normal StatusLine
hi! link lualine_b_normal StatusLine
hi! link lualine_c_normal StatusLine
hi! link lualine_x_normal StatusLine
hi! link lualine_y_normal StatusLine
hi! link lualine_z_normal StatusLine

hi! link lualine_a_insert StatusLine
hi! link lualine_b_insert StatusLine
hi! link lualine_c_insert StatusLine
hi! link lualine_x_insert StatusLine
hi! link lualine_y_insert StatusLine
hi! link lualine_z_insert StatusLine

hi! link lualine_a_visual StatusLine
hi! link lualine_b_visual StatusLine
hi! link lualine_c_visual StatusLine
hi! link lualine_x_visual StatusLine
hi! link lualine_y_visual StatusLine
hi! link lualine_z_visual StatusLine

hi! link lualine_a_replace StatusLine
hi! link lualine_b_replace StatusLine
hi! link lualine_c_replace StatusLine
hi! link lualine_x_replace StatusLine
hi! link lualine_y_replace StatusLine
hi! link lualine_z_replace StatusLine

hi! link lualine_a_command StatusLine
hi! link lualine_b_command StatusLine
hi! link lualine_c_command StatusLine
hi! link lualine_x_command StatusLine
hi! link lualine_y_command StatusLine
hi! link lualine_z_command StatusLine

" Inactieve statusline secties
hi! link lualine_a_inactive StatusLineNC
hi! link lualine_b_inactive StatusLineNC
hi! link lualine_c_inactive StatusLineNC
hi! link lualine_x_inactive StatusLineNC
hi! link lualine_y_inactive StatusLineNC
hi! link lualine_z_inactive StatusLineNC
