" ==================================================================
" ============== S. Thewessen vim-color-scheme =====================
" ==================================================================
" Color-scheme heavely inspired by Monokai colorscheme

if v:version > 600
  hi clear
endif
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "sthew"

" Link
hi link Constant Normal
hi link EndOfBuffer Normal
hi link vimParenSep Noise

" Global
hi Search term=underline cterm=underline ctermfg=NONE ctermbg=237
hi IncSearch term=reverse cterm=reverse ctermfg=3 ctermbg=NONE
hi PmenuSel ctermfg=NONE ctermbg=NONE cterm=reverse
hi Underlined cterm=underline


if &t_Co > 255
    hi Directory ctermfg=144
    hi Label ctermfg=186
    hi Wildmenu ctermfg=232 ctermbg=214 cterm=NONE
    hi SpecialKey ctermfg=141 ctermbg=NONE cterm=NONE
    hi ErrorMsg ctermfg=230 ctermbg=88 cterm=NONE
    hi WarningMsg ctermfg=232 ctermbg=3 cterm=NONE

    if &background == 'dark'
        hi Normal ctermfg=230 ctermbg=NONE
        hi Visual ctermbg=239
        hi CursorLine ctermbg=NONE cterm=underline
        hi CursorLineNr ctermfg=230 ctermbg=NONE cterm=underline
        hi ColorColumn ctermbg=237 ctermfg=NONE
        hi LineNr ctermfg=238 ctermbg=NONE
        hi StatusLine ctermfg=102 ctermbg=NONE cterm=underline
        hi StatusLineNC ctermfg=241 ctermbg=NONE cterm=NONE
        hi VertSplit ctermfg=102 ctermbg=NONE cterm=NONE
        hi Title ctermfg=231 ctermbg=NONE cterm=bold
        hi MatchParen ctermfg=231 ctermbg=NONE cterm=bold
        hi Pmenu ctermfg=NONE ctermbg=237 cterm=NONE
        hi Keyword ctermfg=144 ctermbg=NONE cterm=NONE
        hi Type ctermfg=81 cterm=NONE
        hi Boolean ctermfg=99
        hi Number ctermfg=141
        hi Float ctermfg=213
        hi Character ctermfg=178
        hi String ctermfg=186
        hi Comment ctermfg=242
        hi Noise ctermfg=94
        hi NonText ctermfg=2
        hi Function ctermfg=148
        hi Operator ctermfg=214
        hi Conditional ctermfg=197
        hi Identifier ctermfg=197 cterm=bold
        hi PreProc ctermfg=69 cterm=italic
        hi Tag ctermfg=197
        hi Statement ctermfg=197
        hi Define ctermfg=160
        hi Underlined ctermfg=230 cterm=underline
        hi Italic ctermfg=230 cterm=italic
        hi Folded ctermfg=252 ctermbg=NONE
        hi FoldColumn ctermbg=NONE ctermfg=236
        hi SignColumn ctermbg=NONE
        hi TabLine ctermfg=242 ctermbg=NONE cterm=underline
        hi TabLineFill ctermfg=102 ctermbg=NONE cterm=underline
        hi TabLineSel ctermfg=102 ctermbg=NONE cterm=bold
        hi DiffAdd ctermbg=234 cterm=NONE
        hi DiffDelete ctermbg=NONE cterm=NONE
        hi DiffChange ctermbg=237 cterm=NONE
        hi DiffText ctermbg=22 cterm=NONE
        hi Special ctermfg=141 cterm=NONE
        hi SpecialComment ctermfg=242 ctermbg=NONE cterm=NONE
        hi StorageClass ctermfg=81 ctermbg=NONE cterm=NONE
        hi Error ctermfg=1 ctermbg=NONE cterm=bold
        hi Todo ctermfg=3 ctermbg=NONE cterm=bold
        hi SpellBad ctermbg=88
        hi SpellCap ctermbg=22
        hi SpellRare ctermbg=93
        hi SpellLocal ctermbg=3
        hi SignatureMarkText ctermfg=221 cterm=underline

    else " background == 'light'
        hi Normal ctermfg=232 ctermbg=NONE
        hi Visual ctermbg=252
        hi CursorLine ctermbg=255 cterm=underline
        hi CursorLineNr ctermfg=240 ctermbg=NONE
        hi ColorColumn ctermbg=NONE
        hi LineNr ctermfg=52 ctermbg=NONE cterm=NONE
        hi StatusLine ctermfg=52 ctermbg=NONE cterm=underline
        hi StatusLineNC ctermfg=245 ctermbg=NONE cterm=underline
        hi VertSplit ctermfg=52 ctermbg=NONE cterm=NONE
        hi Title ctermfg=232 ctermbg=NONE cterm=bold
        hi MatchParen ctermfg=88 ctermbg=NONE cterm=underline
        hi Pmenu ctermfg=NONE ctermbg=255 cterm=NONE
        hi Keyword ctermfg=88
        hi Type ctermfg=21
        hi Directory ctermfg=144
        hi Boolean ctermfg=57
        hi Character ctermfg=57
        hi String ctermfg=166
        hi Number ctermfg=57
        hi Float ctermfg=57
        hi Comment ctermfg=240
        hi Noise ctermfg=102
        hi NonText ctermfg=2
        hi Function ctermfg=22
        hi Operator ctermfg=88
        hi Conditional ctermfg=88
        hi Identifier ctermfg=88
        hi PreProc ctermfg=88 cterm=NONE
        hi Tag ctermfg=88
        hi Statement ctermfg=88
        hi Folded ctermfg=235 ctermbg=252
        hi FoldColumn ctermbg=NONE ctermfg=189
        hi SignColumn ctermbg=NONE
        hi Define ctermfg=88
        hi TabLine ctermfg=52 ctermbg=NONE cterm=underline
        hi TabLineFill ctermfg=52 ctermbg=NONE cterm=underline
        hi TabLineSel ctermfg=232 ctermbg=NONE cterm=bold
        hi DiffAdd ctermbg=76 cterm=NONE
        hi DiffDelete ctermbg=204 cterm=NONE
        hi DiffChange ctermbg=255 cterm=NONE
        hi DiffText ctermbg=46 cterm=NONE
        hi Special ctermfg=57 ctermbg=NONE cterm=NONE
        hi SpecialComment ctermfg=245 ctermbg=NONE cterm=NONE
        hi StorageClass ctermfg=21 ctermbg=NONE cterm=NONE
        hi Error ctermfg=1 ctermbg=231 cterm=bold
        hi Todo ctermfg=3 ctermbg=231 cterm=bold
        hi SignatureMarkText ctermfg=197 cterm=underline
    endif
else " For 16 color terminal
    set background=dark

    " Allow color schemes to do bright colors without forcing bold.
    if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
      set t_Co=16
    endif

    hi Directory ctermfg=6
    hi Label ctermfg=3
    hi Wildmenu ctermfg=0 ctermbg=3 cterm=NONE
    hi SpecialKey ctermfg=8 ctermbg=NONE cterm=NONE
    hi ErrorMsg ctermfg=7 ctermbg=1 cterm=NONE
    hi WarningMsg ctermfg=0 ctermbg=3 cterm=NONE

    hi Normal ctermfg=7
    hi Visual ctermbg=8
    hi CursorLine ctermbg=0 cterm=underline
    hi CursorLineNr ctermfg=3
    hi ColorColumn ctermbg=0
    hi LineNr ctermfg=8 ctermbg=NONE cterm=NONE
    hi StatusLine ctermfg=7 ctermbg=NONE cterm=underline
    hi StatusLineNC ctermfg=8 ctermbg=NONE cterm=NONE
    hi VertSplit ctermfg=7 ctermbg=0 cterm=NONE
    hi Title ctermfg=7 ctermbg=NONE cterm=bold
    hi MatchParen ctermfg=1 ctermbg=NONE cterm=underline
    hi Pmenu ctermfg=NONE ctermbg=59 cterm=NONE
    hi Keyword ctermfg=1
    hi Type ctermfg=12
    hi Directory ctermfg=3
    hi Boolean ctermfg=5
    hi Character ctermfg=5
    hi String ctermfg=15
    hi Number ctermfg=5
    hi Float ctermfg=5
    hi Comment ctermfg=8
    hi Noise ctermfg=8
    hi NonText ctermfg=2
    hi Function ctermfg=10
    hi Operator ctermfg=1
    hi Conditional ctermfg=1
    hi Identifier ctermfg=1
    hi PreProc ctermfg=1
    hi Tag ctermfg=1
    hi Statement ctermfg=1
    hi Folded ctermfg=15 ctermbg=0
    hi FoldColumn ctermbg=NONE ctermfg=0
    hi SignColumn ctermfg=NONE ctermbg=0 cterm=NONE
    hi Define ctermfg=1
    hi TabLine ctermfg=8 ctermbg=NONE cterm=underline
    hi TabLineFill ctermfg=7 ctermbg=NONE cterm=underline
    hi TabLineSel ctermfg=7 ctermbg=NONE cterm=bold
    hi DiffAdd ctermfg=7 ctermbg=3
    hi DiffDelete ctermfg=1 cterm=NONE
    hi DiffChange ctermfg=3 cterm=NONE
    hi DiffText ctermfg=2 cterm=bold
    hi Special ctermfg=5 ctermbg=NONE cterm=NONE
    hi SpecialComment ctermfg=8 ctermbg=NONE cterm=NONE
    hi StorageClass ctermfg=12 ctermbg=NONE cterm=NONE
    hi Error ctermfg=1 ctermbg=NONE cterm=bold
    hi Todo ctermfg=3 ctermbg=NONE cterm=bold
endif
