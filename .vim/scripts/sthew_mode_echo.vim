"" User1: Normal/Insert toggle
"" User2: Read only
"" User3: Save file!

let s:m = ''

""Cursor settings:
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

function! MyHandler(timer)
  let m = mode(1)
  if m != s:m 
    if &t_Co > 255 
        if &background == 'dark'
            hi User1 ctermfg=102 ctermbg=NONE cterm=underline
            hi User2 ctermfg=203 ctermbg=NONE cterm=NONE
            if m == 'n'
                hi User1 ctermfg=102 ctermbg=NONE cterm=underline
            elseif m == 'no'
                hi User1 ctermfg=230 ctermbg=NONE cterm=bold,underline
                echo "Operation pending!"
            elseif m == 'i'
                hi User1 ctermfg=203 ctermbg=NONE cterm=bold,underline
            elseif m == 'v' || m == 'V' || m == ''
                hi User1 ctermfg=102 ctermbg=235 cterm=underline
            elseif m == 'R' || m == 'Rv'
                hi User1 ctermfg=3 ctermbg=NONE cterm=bold,underline
            elseif m == 'c' || m == 'cv'|| m == 'ce'
                hi User1 ctermfg=3 ctermbg=NONE cterm=underline
            elseif m == 'r' || m == 'rm' || m == 'r?'
                hi User1 ctermfg=186 ctermbg=NONE cterm=bold,underline
            endif
            let s:m = m
        else
            hi User1 ctermfg=52 ctermbg=NONE cterm=underline
            hi User2 ctermfg=88 ctermbg=NONE cterm=bold
            if m == 'n'
                hi User1 ctermfg=52 ctermbg=NONE cterm=underline
            elseif m == 'no'
                hi User1 ctermfg=232 ctermbg=NONE cterm=bold,underline
                echo "Operation pending!"
            elseif m == 'i'
                hi User1 ctermfg=1 ctermbg=NONE cterm=bold,underline
            elseif m == 'v' || m == 'V' || m == ''
                hi User1 ctermfg=52 ctermbg=253 cterm=underline
            elseif m == 'R' || m == 'Rv'
                hi User1 ctermfg=88 ctermbg=NONE cterm=bold,underline
            elseif m == 'c' || m == 'cv'|| m == 'ce'
                hi User1 ctermfg=166 ctermbg=NONE cterm=underline
            elseif m == 'r' || m == 'rm' || m == 'r?'
                hi User1 ctermfg=166 ctermbg=NONE cterm=bold,underline
            endif
            let s:m = m
        endif
    else
            hi User1 ctermfg=7 ctermbg=NONE cterm=underline
            hi User2 ctermfg=7 ctermbg=NONE cterm=bold,underline
            if m == 'n'
                hi User1 ctermfg=7 ctermbg=NONE cterm=underline
            elseif m == 'no'
                hi User1 ctermfg=7 ctermbg=NONE cterm=bold,underline
                echo "Operation pending!"
            elseif m == 'i'
                hi User1 ctermfg=1 ctermbg=0 cterm=bold,underline
            elseif m == 'v' || m == 'V' || m == ''
                hi User1 ctermfg=7 ctermbg=8 cterm=underline
            elseif m == 'R' || m == 'Rv'
                hi User1 ctermfg=3 ctermbg=0 cterm=bold,underline
            elseif m == 'c' || m == 'cv'|| m == 'ce'
                hi User1 ctermfg=3 ctermbg=NONE cterm=underline
            elseif m == 'r' || m == 'rm' || m == 'r?'
                hi User1 ctermfg=4 ctermbg=0 cterm=bold,underline
            endif
            let s:m = m
    endif
  endif
endfunction
