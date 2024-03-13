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
