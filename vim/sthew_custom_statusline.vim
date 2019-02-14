" ==================================================================
" ================ Custom Statusline VimScript =====================
" ==================================================================

" Setup a dictionary for all modes text
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Nor OP',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

" Check if file has some flag by var-value
function! VarExists(var, val)
    if exists(a:var) | return a:val | else | return '' | endif
endfunction

" Statusline attributes
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
function! Custom_Statusline()
    let s=''
    let s.='%1*%4.4(#%n%) '                          " Buffer number
    let s.='%0*%<%( %Y '                                 " FileType
    let s.='%0*|'                                     " Seperator
    let s.='%0* (%0{&ff}) '                          " FileFormat (dos/unix..)
    let s.='%{&fenc} %)'                  " Encoding
    let s.="%0* %m%r%h%w%{VarExists('b:gzflag','[GZ]')}%q\ "  " File flags (modified, readonly, preview etc.)
    let s.="%{FugitiveStatusline()}"
    let s.='%='                                        " Right Side
    let s.='%0* %<☰ %02l⋮ %02v (%3p%%) '            " Line/col number (percentage)
    let s.='%1* %-7{toupper(g:currentmode[mode()])} '  " The current mode 
    return s
endfunction

function! Custom_Statusline_NC()
    let s=''
    let s.='%4.4(#%n%) '                                   " Buffer number
    let s.=" %{expand('#'.buffer_number('%').':t')} "    " File in window (base only)
    let s.=" %m%r%h%w%{VarExists('b:gzflag','[GZ]')}%q\ "  " File flags (modified, readonly, preview etc.)
    let s.='%='                                            " Right Side
    let s.=' %<☰ %02l⋮ %02v (%3p%%) '                      " Line/col number (percentage)
    return s
endfunction

set statusline=%!Custom_Statusline()

augroup toggle_statusline_windowswap
    autocmd!
    autocmd WinEnter * setlocal statusline=%!Custom_Statusline()
    autocmd WinLeave * setlocal statusline=%!Custom_Statusline_NC()
augroup END
