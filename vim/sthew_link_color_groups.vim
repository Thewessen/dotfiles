" ==================================================================
" =============== S. Thewessen vim-color links =====================
" ==================================================================

" Vim
hi link helpCommand Keyword
hi link vimEnvVar String
hi link vimCommand Keyword
hi link vimNotFunc Conditional

" netrew
hi link netrwClassify Noise

" Tmux
hi link tmuxOptions Identifier
hi link tmuxFlags Type
hi link tmuxVariable Normal
hi link tmuxOptions PreProc
hi link tmuxFormatString Normal

" Shell
hi link shVariable Normal
hi link shCommandSub Statement
hi link shOption Type
hi link shRange Noise
hi link shQuote String
hi link shDerefSimple String

" zsh
hi link zshDeref Directory 
hi link zshPreproc Comment 
hi link zshSubstDelim Noise 
hi link zshPrecommand zshCommands 

" Python
hi link pythonDecorator Special
hi link pythonDecoratorName Special

" Latex
hi link Delimiter Noise
hi link texBeginEndName Type

" HTML
hi link htmlTagN Tag
hi link htmlTagName Tag
hi link htmlArg Normal
hi link htmlSpecialChar Special
hi link htmlTag Comment
hi link htmlEndTag Comment

" Javascript
hi link jsObjectKey Normal
hi link jsFunction Statement
hi link jsFunctionKey Normal
hi link jsArrowFunction Operator
hi link jsObjectFuncName Normal
hi link javaScriptFunction Type
hi link javaScriptRailsFunction Type
hi link javaScriptBraces Noise
hi link jsLabel Conditional

" Typescript
hi link typescriptBraces Noise
hi link typescriptParens Noise

" PHP
hi link phpVarSelector Noise
hi link phpDocTags Special
hi link phpIdentifier Variable

" Blade PHP
hi link bladeDelimiter Normal
hi link bladeKeyword Special

" JSX
hi link jsxComponentName Define
hi link jsxTagName Tag
hi link jsxBraces Noise

" Emberjs
hi link hbsHandles Normal

" GraphQL
hi link graphqlName Normal
hi link graphqlFold Noise

" CSS (Damn those groups!!)
hi link cssClassName Type
hi link cssFunctionName Function
hi link cssValueLength Number
hi link cssPropRegion Normal
hi link cssDimensionProp Normal
hi link cssFontProp Normal
hi link cssBackgroundProp Normal
hi link cssTextProp Normal
hi link cssBoxProp Normal
hi link cssTableProp Normal
hi link cssBorderProp Normal
hi link cssPositioningProp Normal
hi link cssTransformProp Normal
hi link cssUIProp Normal
hi link cssIEUIProp Normal
hi link cssFlexibleBoxProp Normal
hi link cssMultiColumnProp Normal
hi link cssListProp Normal
hi link cssFontDiscriptorProp Normal
hi link cssTableAttr String
hi link cssBackgroundAttr String
hi link cssPositioningAttr String
hi link cssTextAttr String
hi link cssFontAttr String
hi link cssBoxAttr String
hi link cssBorderAttr String
hi link cssUIAttr String
hi link cssIEUIAttr String
hi link cssMultiColumnAttr String
hi link cssListAttr String
hi link cssFlexibleBoxAttr String
hi link cssColor Special
hi link cssCommonAttr Special
hi link cssUnitDecorators Special
hi link cssAttrRegion Special
hi link cssTagName Tag
hi link cssIdentifier Identifier
hi link cssBraces Noise
hi link cssPageProp Normal
hi link cssMediaProp Normal
hi link cssCommonAttr String
hi link cssSelectorOp Operator
hi link cssGridProp Normal
hi link cssCustomPositioningPrefix Normal
hi link cssPseudoClassId Normal
hi link styledAmpersand Identifier

" Ruby 
hi link rubyException Conditional
hi link rubyFunction Function
hi link rubyInterpolationDelimiter Normal
hi link rubyOperator Operator
hi link rubyInclude Statement
hi link rubyControl Statement
hi link rubyClass Tag
hi link rubySymbol Character
hi link rubyRailsUserClass Type
hi link rubyRailsARAssociationMethod Type
hi link rubyRailsARMethod Type
hi link rubyRailsRenderMethod Type
hi link rubyRailsMethod Type
hi link erubyRailsMethod Type
hi link rubyConstant Constant
hi link rubyStringDelimiter String
hi link rubyBlockParameter Noise
hi link rubyInstanceVariable Normal
hi link rubyGlobalVariable Normal
hi link rubyRegexp String
hi link rubyRegexpDelimiter String
hi link rubyEscape Special
hi link rubyClassVariable Normal
hi link rubyPseudoVariable Normal
hi link erubyDelimiter Normal
hi link erubyComment Comment

" YAML
hi link yamlKey Keyword
hi link yamlAnchor Normal
hi link yamlAlias Normal
hi link yamlDocumentHeader Label

" ALE
hi link ALEErrorSign Error
hi link ALEWarningSign Warning

" Git fugitive
hi link diffRemoved Operator
hi link diffAdded Function
hi link diffLine Special
hi link diffSubname Type
hi link diffFile Folded
hi link diffIndexLine Comment
hi link gitDiff Normal
hi link gitcommitSummary Normal

" Twig
hi link twigString String
hi link twigTagDelim Noise
hi link twigVariable Italic
hi link twigOperator Operator
hi link twigVarDelim Noise

" Yaml
hi link yamlKeyValueDelimiter Noise
hi link yamlBlockMappingKey Normal
