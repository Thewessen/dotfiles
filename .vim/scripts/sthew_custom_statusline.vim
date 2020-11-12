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

function! s:get_gutentags_status(mods) abort
    let l:msg = ''
    if index(a:mods, 'ctags') >= 0
       let l:msg .= '♨'
     endif
     if index(a:mods, 'cscope') >= 0
       let l:msg .= '♺'
     endif
     return l:msg
endfunction

set statusline+=
" Statusline attributes
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
function! Custom_Statusline()
    let s=''
    let s.='%1*%4.4(|#%n%) '                                  " Buffer number
    let s.=" %{expand('#'.buffer_number('%').':t')}\ "        " File in window (base only)
    let s.="%0* %m%r%h%w%{VarExists('b:gzflag','[GZ]')}%q\ "  " File flags (modified, readonly, preview etc.)
    if exists('g:loaded_fugitive')
      let s.="%{fugitive#statusline()}"                          " Add git repro to bottom statusline
    endif
    if exists('g:coc_enabled')
      let s.="%{coc#status()}%{get(b:,'coc_current_function','')}" " Coc completion in statusline
    endif
    let s.='%='                                               " Right Side
    let s.='%0*%<%( %Y '                                      " FileType
    let s.='%0* (%0{&ff}) '                                   " FileFormat (dos/unix..)
    let s.='%{&fenc} %)'                                      " Encoding
    let s.='%0* %<☰ %02l⋮ %02v (%3p%%) '                      " Line/col number (percentage)
    let s.='%1* %-7{toupper(g:currentmode[mode()])}|'  " The current mode
    return s
endfunction

function! Custom_Statusline_NC()
    let s=''
    let s.='%4.4(#%n%) '                                   " Buffer number
    let s.=" %{expand('#'.buffer_number('%'))} "    " File in window (base only)
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
